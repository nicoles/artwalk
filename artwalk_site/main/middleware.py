import sys
import traceback

class LogExceptionMiddleware(object):
	def process_exception(self, request, exception):
		"""Send tracebacks to error log."""
		print >> sys.stderr,"here"
		traceback.print_exc(file=sys.stderr)
		return None