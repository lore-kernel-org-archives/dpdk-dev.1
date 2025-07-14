Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC937C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 17:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 763A1402F1;
	Mon, 14 Jul 2025 19:13:56 +0200 (CEST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
 [209.85.166.42]) by mails.dpdk.org (Postfix) with ESMTP id B34A540608
 for <dev@dpdk.org>; Mon, 14 Jul 2025 19:13:53 +0200 (CEST)
Received: by mail-io1-f42.google.com with SMTP id
 ca18e2360f4ac-875f57e0cb9so366465439f.3
 for <dev@dpdk.org>; Mon, 14 Jul 2025 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752513233; x=1753118033; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6laGxwPoqc7WLxUjxDMti2lsDbzC9h4ohLLF48puDQ=;
 b=LEWSwn69vpX6u4fxQVv7keEgiUb7bO3c9qDyyQFeTWy3ByhwnRNnH+vBNIHXg4nQ2g
 FQp4yl4F1px5no4XzRe9/iRc8K/AIMsJE9yuhhCUE/7BKxwBHxemK/9EySmMLlPNxint
 jS62o3/0od08cJwkDjMMy7/0X5gGrZuTn84ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752513233; x=1753118033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6laGxwPoqc7WLxUjxDMti2lsDbzC9h4ohLLF48puDQ=;
 b=vM5zHqiMXfle1vsCqS2uU+jNThIPZdYNF50kLkodDgMKOGV/daOQs/mb1gBM6C160K
 fammf/qxldLfXeiiX8gLPJ+WvJ2XTWrkn3CDRizWvmzrH3ml7SHTi2xQklWVn9nwwe6e
 tEPi/gOQ7JTM39GuygIMNjxQeewqt9Gm0ppsPUw5ALoff29CFrKnnbqF3tn3w+oKDg8c
 mIOKYV65rF7y90yoedkveFjdKHGa9ER1AxvQokUI8dq8Ltoj/3Zut2McajAW+F+l6AZj
 XHA4LTure0uSO58JHN77UIozyOuOii/Hdj3Tjem2Ft0rPLRKvz7GZgAMy31ipX2hR//E
 4yZA==
X-Gm-Message-State: AOJu0YxNEXc7ygYirxUHolk665xVHnbXxD88hI5boYeGl5uzyoWtw/ug
 TxbDEBzaoDydm6t/KXYzSLnq+Q0t3ypuQxn+8CAsk2rAEDkJWCLZFHT8HvMtzBOn1YQ=
X-Gm-Gg: ASbGncsxG4CwRZOVQha2K9KVhK5wT4sOUoIqupykal2gOwM+2mjrKOYw9iDPFD+1wSh
 nkIrxTH9MLI2VbQz2b7i7iv9oYWpLjywHtRyZ2qf+JDZ2N5BIX9LwM36R1/uQT+sJE0FotnGS6h
 cCHEU9WghzsrlnRmmtplM8F5vTPElE7J5cDzz1qH2pmUhs+AhR2Md8yOWa5HkwfYdCdc+gq3slC
 QdNsab23JgxCOoLqIfPJP4tEXWCO0VgpWVpHic/ENnA404eEbD3jFJFSyKq+S/65aZgdjCC/u+B
 ruIkxu0+IoNapV+kaUQo+Vsrxe6h4RWhdjagbmbbMFJBuJCXhdEckTRKFafZeBj2UCkCq/9BHln
 wvNOksBjL
X-Google-Smtp-Source: AGHT+IGmRmJ/EN3uPPv8I5FZJDV0BzquuROCfcS6c1U/VyzpVfxtqzTbnA5XxjzGB/BXEXPaoLr9vQ==
X-Received: by 2002:a05:6e02:3420:b0:3df:3b77:1ed8 with SMTP id
 e9e14a558f8ab-3e25329bb7dmr128124395ab.7.1752513232746; 
 Mon, 14 Jul 2025 10:13:52 -0700 (PDT)
Received: from fedora.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50556b14167sm2111784173.131.2025.07.14.10.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 10:13:52 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 3/3] doc: revise coding guidelines section
Date: Mon, 14 Jul 2025 13:13:44 -0400
Message-ID: <20250714171346.564267-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714171346.564267-1-dmarx@iol.unh.edu>
References: <20250711172534.540416-1-dmarx@iol.unh.edu>
 <20250714171346.564267-1-dmarx@iol.unh.edu>
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
 doc/guides/tools/dts.rst | 194 ++++++++++++++++++---------------------
 1 file changed, 90 insertions(+), 104 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 8ba855c6fc..4da55e00ef 100644
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
 
@@ -348,122 +348,111 @@ Adding test cases may require adding code to the framework as well.
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
 
-#. **Test cases**
+Test Cases
 
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
+   Test cases are defined as methods and must be decorated appropriately.
+   Use the @func_test and/or @perf_test decorators from TestSuite above each test case method.
+   For example:
 
-#. **Setup and Teardown methods**
+   @func_test
+   def test_basic_link(self):
+      """your testcase docstring here"""
+      #your testcase code here
 
-   | There are setup and teardown methods for the whole test suite and each individual test case.
-   | Methods ``set_up_suite`` and ``tear_down_suite`` will be executed
-     before any and after all test cases have been executed, respectively.
-   | Methods ``set_up_test_case`` and ``tear_down_test_case`` will be executed
-     before and after each test case, respectively.
-   | These methods don't need to be implemented if there's no need for them in a test suite.
-     In that case, nothing will happen when they are executed.
+   Functional test cases should use the @func_test decorator, and performance test cases should use @perf_test.
+   A test suite may include any number of functional and/or performance test cases.
+   Each suite should focus on testing a single feature (one feature = one test suite).
 
-#. **Configuration, traffic and other logic**
+Setup and Teardown Hooks
 
-   The ``TestSuite`` class contains a variety of methods for anything that
-   a test suite setup, a teardown, or a test case may need to do.
+   Setup and teardown methods can be defined at both the suite and test case levels.
 
-   The test suites also frequently use a DPDK app, such as testpmd, in interactive mode
-   and use the interactive shell instances directly.
+   Suite-level:
 
-   These are the two main ways to call the framework logic in test suites.
-   If there's any functionality or logic missing from the framework,
-   it should be implemented so that the test suites can use one of these two ways.
+   * set_up_suite() — runs once before any test cases in the suite
 
-   Test suites may also be configured individually using a file provided at the command line.
-   The file is a simple mapping of test suite names to their corresponding configurations.
+   * tear_down_suite() — runs once after all test cases have completed
 
-   Any test suite can be designed to require custom configuration attributes or optional ones.
-   Any optional attributes should supply a default value for the test suite to use.
+   Case-level:
 
-#. **Test case verification**
+   * set_up_test_case() — runs before each individual test case
 
-   Test case verification should be done with the ``verify`` method, which records the result.
-   The method should be called at the end of each test case.
+   * tear_down_test_case() — runs after each individual test case
 
-#. **Other methods**
+   These methods are optional. If not implemented, the framework will simply skip them.
 
-   Of course, all test suite code should adhere to coding standards.
-   Only the above methods will be treated specially and any other methods may be defined
-   (which should be mostly private methods needed by each particular test suite).
-   Any specific features (such as NIC configuration) required by a test suite
-   should be implemented in the ``SutNode`` class (and the underlying classes that ``SutNode`` uses)
-   and used by the test suite via the ``sut_node`` field.
+   The TestSuite class provides a variety of methods for setup, teardown, and test logic.
+   Test suites often use DPDK applications (e.g., testpmd) in interactive mode and interact with them via shell instances.
+
+Using the DTS Framework Within TestSuites:
+
+   There are two ways to call the framework logic in test suites:
+
+   - Using built-in methods provided by TestSuite or its base classes
+   - Interacting directly with tools or shell interfaces
+
+   If any required functionality is missing, it should be implemented in a way that supports one of these two approaches.
+
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
+   Additional methods may be defined as needed (ideally private).
 
 
 .. _dts_dev_tools:
@@ -493,13 +482,10 @@ Building DTS API docs
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
2.49.0

