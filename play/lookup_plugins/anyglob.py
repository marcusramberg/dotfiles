import os
from ansible import utils
import glob

class LookupModule(object):

    def __init__(self, basedir=None, **kwargs):
        self.basedir = basedir

    def run(self, terms, inject=None, **kwargs):

        terms = utils.listify_lookup_plugin_terms(terms, self.basedir, inject)

        ret = []

        for term in terms:

            dwimmed = utils.path_dwim(self.basedir, term)
            globbed = glob.glob(dwimmed)
            ret.extend(g for g in globbed)

        return ret
