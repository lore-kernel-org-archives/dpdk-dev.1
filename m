Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE106C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 811C340655;
	Wed, 16 Jul 2025 22:54:10 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id D7A064042E
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:54:07 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4ab93f24dc3so5429251cf.0
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752699247; x=1753304047; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JR0hBy6+/OnHwq8C6kGKiCOblFqqGM5yahfuHBQIJEg=;
 b=VvIfXd1riFtvty/0L9F0nPrXF+MWZ6PBFsqePIGcopSEvTzUQ91CP2lu7V7AW9R+fx
 uiAzEP0jzrOyrimgM4wDZ6HTM7Qxl1JMW7Q2H87Zw0F+B8OG2JT6evp1AUkC8qu/Zb84
 Hq4PkcvVbxrYLRlP1jco8p1zcygSQCMlifWvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752699247; x=1753304047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JR0hBy6+/OnHwq8C6kGKiCOblFqqGM5yahfuHBQIJEg=;
 b=U1QTZTXn9CSzJQDqfEMURmCv3/+3AcJeFM72p4wwF9I8svv8wUCsOqMshPosRsuQB3
 OHMgjWnLB411++frnyHA3fDR+3i/NRsGQRgYDNpt/WGwaEK/woLZMvJ8x3hXPdBr+LlJ
 MQ+CAHRokJ39lzSt6aRsDzZ2hxvQryvArUNfo2ndRwFTBSCvBMaBV86nK/X5Xw8Eo/2S
 8LeAOdG32iJAhafd4X2eDnLncOVoSoDApUGRme56dHPQOVHEUV6ziCU2x5euwgzcuUEI
 y9Tvje/2vZAsfvkYmoNZ+4i8EyetLpfDdczCiiV2A4lDBiTk2/wBEHFfwpBfW/t6GSrO
 fzTQ==
X-Gm-Message-State: AOJu0YwnT3wqUOxSDuAP9fsOOM0zoShFbzDpeyZp5e/p7dnoHJB3KaoZ
 MlZ+FD1oCo3g/WtqCML1wfpCW+UZwi9n/r4pj38zmTfgCVR6R3S8sPxLyns6VRAERAY=
X-Gm-Gg: ASbGncvAyIvYoleJ+H28ZNqZLiQE+Yvx8uOlFTx7dbMw6JKj4iLbDQGfjih34w6Z1Ei
 G/CBeBG+/YDthL8paRf5cffqKT4d5b6eeQRyXP7zZS/F2icRjY05vucWV66PYcGXdmd5w1H5fRj
 KQMfIb/pJJncDhKjhcF+O7aijN2yhU19MmF5aNeg7npn/O98wU0csiX8BVbwPhcU+cVz98nAa4D
 hXeS0WB4pxw8DL51JDyfXE+mSHKhq5WAz+RzMtPxXW3KjYtpwKeD/fdp/Rxx7TOtPfl/is+5MXM
 HD9jVY5oGhQ6EEV/4HyPF/FZ9qLTFbbeYyf1BBJ1MZIoKPHVxmVK+OPbSPJEsN142VnAge1GmYF
 DJnqk4CQS+KHCz3L567aILEQnc8JWElz3ovCZXZorcVtLAlOd+AoL
X-Google-Smtp-Source: AGHT+IHNoSyt9CYv6FcYmwPQnvIDZlpuqSW5nD+1g785CFQCgRW1h94Ykll11+XImZF3WgivL+Q8DA==
X-Received: by 2002:ac8:5d07:0:b0:4a9:8ddf:83ee with SMTP id
 d75a77b69052e-4ab90cde61fmr66538791cf.46.1752699246805; 
 Wed, 16 Jul 2025 13:54:06 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.209])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab85620d80sm21406531cf.61.2025.07.16.13.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:54:06 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v7 3/3] doc: revise coding guidelines section
Date: Wed, 16 Jul 2025 16:54:00 -0400
Message-ID: <20250716205402.64997-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716205402.64997-1-dmarx@iol.unh.edu>
References: <20250716182546.58567-1-dmarx@iol.unh.edu>
 <20250716205402.64997-1-dmarx@iol.unh.edu>
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
 doc/guides/tools/dts.rst | 203 +++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 104 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 8ba855c6fc..cc1f1a9270 100644
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
 
@@ -348,122 +348,120 @@ Adding test cases may require adding code to the framework as well.
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
+* When referring to a parameter in a docstring, omit articles and enclose the parameter in single backticks,
+   consistent with the `Python documentation style <https://docs.python.org/3/index.html>`_.
+* Use double backticks for literal values.
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
+Example::
+
+   @func_test
+   def test_basic_link(self):
+      """your testcase docstring here"""
+      # your testcase code here
 
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
@@ -493,13 +491,10 @@ Building DTS API docs
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

