Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD65C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:57:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33EEB4066D;
	Wed, 16 Jul 2025 15:57:16 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id AA20B4065F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:57:14 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4ab6b3e8386so31520141cf.3
 for <dev@dpdk.org>; Wed, 16 Jul 2025 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752674234; x=1753279034; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57vFGlhLnhYjXpFpvkgGfvXU2rCxwQaZGzx6L4w1uNI=;
 b=HjeGBPV0NQBDd2536c/5gLwGaf2l+dBwTCXPPZou7LeLmdi8NlOPjCtHtIMrYor/HJ
 /9corJZRxcyHQbpni9lrPEc3Qq3UwpI0VEb8Bh4KrVXkEs2VRErmrcQroCn2bxKI2wgu
 TJGZ+AYF/SGtpRU7DwAlbFcmta+fFC7hcGjAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752674234; x=1753279034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57vFGlhLnhYjXpFpvkgGfvXU2rCxwQaZGzx6L4w1uNI=;
 b=M1PT86fbdB7kEjnmGHira+VxS7E9pmgO534ZOY+cFe9kOe8N2Cs1TFfTLcFS0Vdlim
 7eibKTGj5gsNmoGAUht5S9n6J09pPLbyU3qBGHKs3lqf748qosyzpNhA26IGU0ucFiwT
 C8o35grLKfTz8edCmsBhGNGZ5ioicXINrPgFVqR0wVEXkmdDBq8oO337PbAzvHgGmiHk
 DIDgq0iLsd3kfa5Pk3swaMp8jpC+lLElqLRfdPikjXnAaPmH3TwrxZey2+AWv9KaVMwW
 M+bbGOQ554R5XFOvqXAckhx2Zapc3lRwKEkcQEsQVTGgb670YV+Svppo1VROzxKL3QA7
 PdJw==
X-Gm-Message-State: AOJu0Yyz6UaxLkJRGT3aIFBGPj5Z4i9jnPCldL3ur1ln8tsSz3dh9zWh
 ql75argLzgXOgEV3qHNj9/6CDrBD4TF7sXYcyqP0MkTbEwM6ACc3JleyYybRvx7uElU=
X-Gm-Gg: ASbGnctEha9bp3M0r/4RH1SRx0VX24PfakiS92sWMQd0kQwThZyLrchu8VBOwzYl8Xw
 WnHaxAP1HB9egYw9382uXeUqKxh1pktGg+qU/kW9JBciV6QQNTNwUQbMMMRQv3GcTQ2b+PIh39h
 jtcz059bvUMY3c6uadaaWoGblizipZiGQbkt3pCGpRk+45hkZC+EqL36v0YEjRd9axgI7pIXtb3
 jPX5V+tdgDjB5Vr6vKWISupWC3CvjRb8k80GP+6UoA/wH4zMtuxhCvXa+1L+OOAe9RxuCl/GDwq
 QqLi0zB0tp5orEs2WGMZl9csH7zi6/Lt7coZGjAzPHiqjNOlG/ARbZmv7qSZtV3AScZHwC7onST
 M5T4R1QGNJLmUd5nZp+zmtGblRW6oAnBLm89mA1D2U7NvUQYRIQnS
X-Google-Smtp-Source: AGHT+IHh1Yk0mAeCRL14r9jhpk2dTtf2fp4wuAkvoE+SCW/o0eqv6DYnXKU4mf4drmzTLNLfL7IXBg==
X-Received: by 2002:ac8:5a16:0:b0:4ab:5f47:da6c with SMTP id
 d75a77b69052e-4ab90c8c439mr49404321cf.40.1752674233604; 
 Wed, 16 Jul 2025 06:57:13 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.221])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab5427925bsm46608061cf.7.2025.07.16.06.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 06:57:12 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 3/3] doc: revise coding guidelines section
Date: Wed, 16 Jul 2025 09:57:06 -0400
Message-ID: <20250716135708.49233-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716135708.49233-1-dmarx@iol.unh.edu>
References: <20250714171346.564267-1-dmarx@iol.unh.edu>
 <20250716135708.49233-1-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The Framework Coding Guidelines section includes outdated information
about DTS and how to write a test suite. Updated these points to include
the new test case decorators and setup/teardown hooks.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 201 +++++++++++++++++++--------------------
 1 file changed, 97 insertions(+), 104 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 8ba855c6fc..735c0a2f12 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -78,15 +78,15 @@ Setting up DTS environment
    To install Poetry, visit their `doc pages <https://python-poetry.org/docs/>`_.
    The recommended Poetry version is at least 1.8.2.
 
-#. **Getting a Poetry shell**
+#. **Running DTS with Poetry**
 
    Once you have Poetry along with the proper Python version all set up, it's just a matter
-   of installing dependencies via Poetry and using the virtual environment Poetry provides:
+   of installing dependencies via Poetry and running main.py:
 
    .. code-block:: console
 
       poetry install
-      poetry shell
+      poetry run ./main.py
 
 #. **SSH Connection**
 
@@ -263,7 +263,7 @@ which don't require password authentication.
 DTS Execution
 ~~~~~~~~~~~~~
 
-DTS is run with ``main.py`` located in the ``dts`` directory after entering Poetry shell:
+DTS is run with ``main.py`` located in the ``dts`` directory using the ``poetry run`` command:
 
 .. code-block:: console
 
@@ -348,122 +348,118 @@ Adding test cases may require adding code to the framework as well.
 Framework Coding Guidelines
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-When adding code to the DTS framework, pay attention to the rest of the code
-and try not to divert much from it.
-The :ref:`DTS developer tools <dts_dev_tools>` will issue warnings
-when some of the basics are not met.
-You should also build the :ref:`API documentation <building_api_docs>`
-to address any issues found during the build.
-
-The API documentation, which is a helpful reference when developing, may be accessed
-in the code directly or generated with the :ref:`API docs build steps <building_api_docs>`.
-When adding new files or modifying the directory structure,
-the corresponding changes must be made to DTS API doc sources in ``doc/api/dts``.
-
-Speaking of which, the code must be properly documented with docstrings.
-The style must conform to the `Google style
-<https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings>`_.
-See an example of the style `here
-<https://www.sphinx-doc.org/en/master/usage/extensions/example_google.html>`_.
-For cases which are not covered by the Google style, refer to `PEP 257
-<https://peps.python.org/pep-0257/>`_.
-There are some cases which are not covered by the two style guides,
-where we deviate or where some additional clarification is helpful:
-
-   * The ``__init__()`` methods of classes are documented separately
-     from the docstring of the class itself.
-   * The docstrings of implemented abstract methods should refer to the superclass's definition
-     if there's no deviation.
-   * Instance variables/attributes should be documented in the docstring of the class
-     in the ``Attributes:`` section.
-   * The ``dataclass.dataclass`` decorator changes how the attributes are processed.
-     The dataclass attributes which result in instance variables/attributes
-     should also be recorded in the ``Attributes:`` section.
-   * Class variables/attributes and Pydantic model fields, on the other hand,
-     should be documented with ``#:`` above the type annotated line.
-     The description may be omitted if the meaning is obvious.
-   * The ``Enum`` and ``TypedDict`` also process the attributes in particular ways
-     and should be documented with ``#:`` as well.
-     This is mainly so that the autogenerated documentation contains the assigned value.
-   * When referencing a parameter of a function or a method in their docstring,
-     don't use any articles and put the parameter into single backticks.
-     This mimics the style of `Python's documentation <https://docs.python.org/3/index.html>`_.
-   * When specifying a value, use double backticks::
-
-        def foo(greet: bool) -> None:
-            """Demonstration of single and double backticks.
-
-            `greet` controls whether ``Hello World`` is printed.
-
-            Args:
-               greet: Whether to print the ``Hello World`` message.
-            """
-            if greet:
-               print(f"Hello World")
-
-   * The docstring maximum line length is the same as the code maximum line length.
+When contributing code to the DTS framework, follow existing conventions to ensure consistency.
+The :ref:`DTS developer tools <dts_dev_tools>` will flag basic issues.
+Also, be sure to :ref:`build the API documentation <building_api_docs>` to catch any problems during the build.
+
+The API documentation is a helpful reference during development.
+It can be viewed in the code directly or generated using the :ref:`API docs build steps <building_api_docs>`.
+If you add new files or change the directory structure, update the corresponding sources in ``doc/api/dts``.
+
+Code must be documented with docstrings that follow the
+`Google style <https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings>`_.
+Additional references:
+
+* `Sphinx Google style example <https://www.sphinx-doc.org/en/master/usage/extensions/example_google.html>`_
+* `PEP 257 <https://peps.python.org/pep-0257/>`_
+
+Docstring and Attribute Guidelines
+
+* Document ``__init__()`` separately from the class docstring.
+* If an abstract method simply implements a superclass definition without changes, refer to that superclass in the docstring.
+* Document instance variables in the class docstring under an ``Attributes:`` section.
+* For ``@dataclass`` classes, document instance-level attributes in ``Attributes:``, as they are generated from the class fields.
+* Document class variables and Pydantic fields using ``#:``,
+   placed above the type-annotated line. Descriptions may be omitted if the meaning is clear.
+* Apply ``#:`` to ``Enum`` and ``TypedDict`` fields as well, so that autogenerated documentation includes their values.
+* When referring to a parameter in a docstring, omit articles and enclose the parameter in single backticks (e.g., `` `param` ``),
+   consistent with the `Python documentation style <https://docs.python.org/3/index.html>`_.
+* Use double backticks (````value````) for literal values.
+
+Example::
+
+   def foo(greet: bool) -> None:
+       """Demonstrates single and double backticks.
+
+       `greet` controls whether ``Hello World`` is printed.
+
+       Args:
+           greet: Whether to print the ``Hello World`` message.
+       """
+       if greet:
+           print("Hello World")
+
+The maximum line length for docstrings must match that of the code.
 
 
 How To Write a Test Suite
 -------------------------
 
-All test suites inherit from ``TestSuite`` defined in ``dts/framework/test_suite.py``.
-There are four types of methods that comprise a test suite:
+All test suites are classes that inherit from TestSuite, defined in dts/framework/test_suite.py. A typical suite contains:
+
+Test Cases
+
+   Test cases are defined as methods and must be decorated appropriately.
+   Use the @func_test and/or @perf_test decorators from TestSuite above each test case method.
+   For example:
+
+   @func_test
+   def test_basic_link(self):
+      """your testcase docstring here"""
+      #your testcase code here
 
-#. **Test cases**
+   Functional test cases should use the @func_test decorator, and performance test cases should use @perf_test.
+   A test suite may include any number of functional and/or performance test cases.
+   Each suite should focus on testing a single feature (one feature = one test suite).
 
-   | Test cases are methods that start with a particular prefix.
-   | Functional test cases start with ``test_``, e.g. ``test_hello_world_single_core``.
-   | Performance test cases start with ``test_perf_``, e.g. ``test_perf_nic_single_core``.
-   | A test suite may have any number of functional and/or performance test cases.
-     However, these test cases must test the same feature,
-     following the rule of one feature = one test suite.
-     Test cases for one feature don't need to be grouped in just one test suite, though.
-     If the feature requires many testing scenarios to cover,
-     the test cases would be better off spread over multiple test suites
-     so that each test suite doesn't take too long to execute.
+Setup and Teardown Hooks
 
-#. **Setup and Teardown methods**
+   Setup and teardown methods can be defined at both the suite and test case levels.
 
-   | There are setup and teardown methods for the whole test suite and each individual test case.
-   | Methods ``set_up_suite`` and ``tear_down_suite`` will be executed
-     before any and after all test cases have been executed, respectively.
-   | Methods ``set_up_test_case`` and ``tear_down_test_case`` will be executed
-     before and after each test case, respectively.
-   | These methods don't need to be implemented if there's no need for them in a test suite.
-     In that case, nothing will happen when they are executed.
+   Suite-level:
 
-#. **Configuration, traffic and other logic**
+   * set_up_suite() — runs once before any test cases in the suite
 
-   The ``TestSuite`` class contains a variety of methods for anything that
-   a test suite setup, a teardown, or a test case may need to do.
+   * tear_down_suite() — runs once after all test cases have completed
 
-   The test suites also frequently use a DPDK app, such as testpmd, in interactive mode
-   and use the interactive shell instances directly.
+   Case-level:
 
-   These are the two main ways to call the framework logic in test suites.
-   If there's any functionality or logic missing from the framework,
-   it should be implemented so that the test suites can use one of these two ways.
+   * set_up_test_case() — runs before each individual test case
 
-   Test suites may also be configured individually using a file provided at the command line.
-   The file is a simple mapping of test suite names to their corresponding configurations.
+   * tear_down_test_case() — runs after each individual test case
 
-   Any test suite can be designed to require custom configuration attributes or optional ones.
-   Any optional attributes should supply a default value for the test suite to use.
+   These methods are optional. If not implemented, the framework will simply skip them.
 
-#. **Test case verification**
+   The TestSuite class provides a variety of methods for setup, teardown, and test logic.
+   Test suites often use DPDK applications (e.g., testpmd) in interactive mode and interact with them via shell instances.
 
-   Test case verification should be done with the ``verify`` method, which records the result.
-   The method should be called at the end of each test case.
+Leveraging the DTS framework in writing testsuites:
 
-#. **Other methods**
+   One should avoid directly importing DTS framework code to their
+   testsuites where possible. Instead, for performing common processes
+   required in testsuites, one should use (or add to) the list of methods
+   provided in the Testsuite class (the base class of all testsuites). For
+   instance, for sending a list of packets, one should work through the packet
+   transmitting function already made available in the TestSuite class,
+   instead of directly importing the DTS traffic generator class and using
+   that class in one's testsuite implementation. It is also acceptable to
+   import and instantiate classes for various DPDK applications. For instance,
+   writing a testsuite for a simple packet forwarding operation would involve
+   importing the DTS TestPmdShell class, instantiating TestPmdShell, calling
+   TestPmdShell's start() method, and then sending traffic via one of the
+   traffic transmitting functions exposed in the Testsuite class.
 
-   Of course, all test suite code should adhere to coding standards.
-   Only the above methods will be treated specially and any other methods may be defined
-   (which should be mostly private methods needed by each particular test suite).
-   Any specific features (such as NIC configuration) required by a test suite
-   should be implemented in the ``SutNode`` class (and the underlying classes that ``SutNode`` uses)
-   and used by the test suite via the ``sut_node`` field.
+Test Case Verification
+
+   Use the verify method to assert conditions and record test results.
+   This should typically be called at the end of each test case.
+   Example: self.verify(link_up, "Link should be up after configuration.")
+
+Other Methods
+
+   All test suite code should follow the project's coding standards.
+   Only test cases, setup/teardown hooks, and verification methods are treated specially by the framework.
+   Additional private methods may be added as needed in your testsuite implementation.
 
 
 .. _dts_dev_tools:
@@ -493,13 +489,10 @@ Building DTS API docs
 The documentation is built using the standard DPDK build system.
 See :doc:`../linux_gsg/build_dpdk` for more details on compiling DPDK with meson.
 
-The :ref:`doc build dependencies <doc_dependencies>` may be installed with Poetry:
-
 .. code-block:: console
 
    poetry install --only docs
    poetry install --with docs  # an alternative that will also install DTS dependencies
-   poetry shell
 
 After executing the meson command, build the documentation with:
 
-- 
2.50.1

