from distutils.core import setup

if __name__== '__main__':
    setup(include_package_data=True,
          description='string kernel SVM training and importance scoring',
          url='NA',
          download_url='NA',
          version='0.1',
          packages=['ssvmimp', 'ssvmimp.backend', 'ssvmimp.stats'],
          package_data={'ssvmimp.stats': ['logFactorial_30000.txt']},
          setup_requires=[],
          install_requires=['numpy>=1.9', 'theano>=0.9', 'scikit-learn>=0.19', 'scipy>=0.19'],
          scripts=[],
          name='ssvmimp')
