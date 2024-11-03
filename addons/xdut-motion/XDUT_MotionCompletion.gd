#-------------------------------------------------------------------------------
#
#
#	Copyright 2022-2024 Ydi (@ydipeepo.bsky.social)
#
#
#	Permission is hereby granted, free of charge, to any person obtaining
#	a copy of this software and associated documentation files (the "Software"),
#	to deal in the Software without restriction, including without limitation
#	the rights to use, copy, modify, merge, publish, distribute, sublicense,
#	and/or sell copies of the Software, and to permit persons to whom
#	the Software is furnished to do so, subject to the following conditions:
#
#	The above copyright notice and this permission notice shall be included in
#	all copies or substantial portions of the Software.
#
#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#	THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#	ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#	OTHER DEALINGS IN THE SOFTWARE.
#
#
#-------------------------------------------------------------------------------

class_name XDUT_MotionCompletion

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var is_completed: bool:
	get:
		return get_state() == Awaitable.STATE_COMPLETED

var is_canceled: bool:
	get:
		return get_state() == Awaitable.STATE_CANCELED

var is_pending: bool:
	get:
		var state := get_state()
		return \
			state == Awaitable.STATE_PENDING or \
			state == Awaitable.STATE_PENDING_WITH_WAITERS

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_state() -> int:
	return _state

func wait(cancel: Cancel = null) -> void:
	if _state == Awaitable.STATE_PENDING:
		_state = Awaitable.STATE_PENDING_WITH_WAITERS
	if _state == Awaitable.STATE_PENDING_WITH_WAITERS:
		if cancel != null:
			await _wait_with_exotic_cancel(cancel)
		else:
			await _wait()

func release_complete() -> void:
	match _state:
		Awaitable.STATE_PENDING:
			if _cancel != null:
				_cancel.requested.disconnect(release_cancel)
				_cancel = null
			_state = Awaitable.STATE_COMPLETED
		Awaitable.STATE_PENDING_WITH_WAITERS:
			if _cancel != null:
				_cancel.requested.disconnect(release_cancel)
				_cancel = null
			_state = Awaitable.STATE_COMPLETED
			_release.emit()

func release_cancel() -> void:
	match _state:
		Awaitable.STATE_PENDING:
			if _cancel != null:
				_cancel.requested.disconnect(release_cancel)
				_cancel = null
			_state = Awaitable.STATE_CANCELED
		Awaitable.STATE_PENDING_WITH_WAITERS:
			if _cancel != null:
				_cancel.requested.disconnect(release_cancel)
				_cancel = null
			_state = Awaitable.STATE_CANCELED
			_release.emit()

#-------------------------------------------------------------------------------

signal _release

var _state: int = Awaitable.STATE_PENDING
var _cancel: Cancel

func _wait() -> void:
	assert(_state == Awaitable.STATE_PENDING_WITH_WAITERS)
	await _release

func _wait_with_exotic_cancel(cancel: Cancel) -> void:
	assert(_state == Awaitable.STATE_PENDING_WITH_WAITERS)
	if cancel.is_requested:
		release_cancel()
	else:
		cancel.requested.connect(release_cancel)
		await _release
		cancel.requested.disconnect(release_cancel)

func _init(cancel: Cancel) -> void:
	if cancel != null:
		if cancel.is_requested:
			_state = Awaitable.STATE_CANCELED
		else:
			_cancel = cancel
			_cancel.requested.connect(release_cancel)
