Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA4C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:37:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 178A34066A;
	Tue, 27 May 2025 17:37:41 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id B496640669
 for <dev@dpdk.org>; Tue, 27 May 2025 17:37:39 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7c53b9d66fdso460414585a.3
 for <dev@dpdk.org>; Tue, 27 May 2025 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748360259; x=1748965059; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIqWcj2oRu50EJeDAwImQ8euFh1xBm94dXqyWqHAMKw=;
 b=dh3iQJ/aUCBpHglHaN85brRdNGdF0z1e0yqb7TQUxRKYffb2r6DhTcZZpLqd0vmZxw
 WoWlRW/jBevxwoIPiZI4l5PlonlE5/RMwW/Wjj0HjNBSKguIPJ2y+ojgFfyRoRAA4feO
 pywo14k/K6Xr7mxNPxpY3ZM6dIuxEC9hgj2cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748360259; x=1748965059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIqWcj2oRu50EJeDAwImQ8euFh1xBm94dXqyWqHAMKw=;
 b=OOb7t+WDFa5TMiAaaHGQHolPFMLPYNy3yYOK7er9Q1u7jFSd3eirwAowQaCRCMpQZs
 XwEcfcL9CCcMnIzedYjwWirUJ2acHsj+ScSjGMRNKFaYi9OZ1vdCDqOIoLMNacpjihdf
 Ti4CoC0OyXSJyo42NLkdWSt9hNd5km1SQWPaE1L86FhRPf6lUvOmmhlM4h4Iw2hNnuGS
 lBnHMJM0N+BlN8Tj5XLhlMNkmVZd+JGrHRAiWdG5NFqhtMZlS4oF4fDrSUBYqP8mfA3x
 GL2BLThq5mjyulMN1FtGUWL34pslFWhGdDYJCqPs5UHkBmqI3nLgm/v+K+DXMSrHb1bF
 jVnQ==
X-Gm-Message-State: AOJu0YyI/Nl5I/jKk3UYvGLw03DkvXCdx1KvIlFESOQaLM1XCdKNuBD/
 4cH3qZAQr7nMpiIH2vcps3/pXfaeY49xsnrK6hnAQD65rK9SmfpgiJvY5UGogXACX71VeLWm54z
 fzZCQ
X-Gm-Gg: ASbGncu55lLEENhRrDbJQggo5d1PgJqT6D9x3Mc9qqfuE5/Jp3Maf6QkNlvTJAnJgnO
 Yvqw19beB43jlVdRcf1P3O2Ho3v8pIcWmeIi4dvfPysyzVks+v5KvVn/HlYP3Zw9kr2VPt4DRX9
 4IqPRrlxK1+NA5oVSZsi1ZZGntR+WbderZtP9tLIz0jL2XNw+O4Zq1Jmx/La39f1jrDU+y2fUpX
 QAHGh7UHi0PHCQP5S5WpyGBrTqRniKvhVGdAipkSRMo0GjYPt7FZMr6gqfLUoROrq4MiDbW3rkI
 L7GEWuq3MChqf2C8qVOec5IFayIHwf3g/f4Dwy5pa+6ggO/3BQPnrQ==
X-Google-Smtp-Source: AGHT+IGuyFxU+x6YzWfdggkHY3aWKrDNTuSH90z0ori6eLjKYqp0jZuTe6/4XAKggZDXpit+mkHJWw==
X-Received: by 2002:a05:620a:2916:b0:7ca:f3ef:804d with SMTP id
 af79cd13be357-7ceecbbfe60mr2023512485a.9.1748360258846; 
 Tue, 27 May 2025 08:37:38 -0700 (PDT)
Received: from fedora.hsd1.nh.comcast.net ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bd91asm1753910685a.7.2025.05.27.08.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:37:38 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 2/3] dts: rewrite dts rst
Date: Tue, 27 May 2025 11:37:33 -0400
Message-ID: <20250527153734.368235-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527153734.368235-1-dmarx@iol.unh.edu>
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
MIME-Version: 1.0
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

Modify dts.rst to exclude redundant/outdated information about the project,
and add new information regarding setup and framework design.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 310 +++++++++++++--------------------------
 1 file changed, 99 insertions(+), 211 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index fcc6d22036..0aa6663b9f 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -1,6 +1,7 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2022-2023 PANTHEON.tech s.r.o.
     Copyright(c) 2024 Arm Limited
+    Copyright(c) 2025 University of New Hampshire
 
 DPDK Test Suite
 ===============
@@ -20,31 +21,18 @@ DTS runtime environment
 
 DTS runtime environment node
   A node where at least one DTS runtime environment is present.
-  This is the node where we run DTS and from which DTS connects to other nodes.
 
 System under test
-  An SUT is the combination of DPDK and the hardware we're testing
-  in conjunction with DPDK (NICs, crypto and other devices).
+  Node with DPDK and relevant hardware (NICs, crypto, etc.).
 
 System under test node
   A node where at least one SUT is present.
 
 Traffic generator
-  A TG is either software or hardware capable of sending packets.
+  Node that sends traffic; can be hardware or software-based.
 
 Traffic generator node
   A node where at least one TG is present.
-  In case of hardware traffic generators, the TG and the node are literally the same.
-
-
-In most cases, interchangeably referring to a runtime environment, SUT, TG or the node
-they're running on (e.g. using SUT and SUT node interchangeably) doesn't cause confusion.
-There could theoretically be more than of these running on the same node and in that case
-it's useful to have stricter definitions.
-An example would be two different traffic generators (such as Trex and Scapy)
-running on the same node.
-A different example would be a node containing both a DTS runtime environment
-and a traffic generator, in which case it's both a DTS runtime environment node and a TG node.
 
 
 DTS Environment
@@ -195,12 +183,28 @@ These need to be set up on a Traffic Generator Node:
 Running DTS
 -----------
 
-DTS needs to know which nodes to connect to and what hardware to use on those nodes.
-Once that's configured, either a DPDK source code tarball or tree folder
-need to be supplied whether these are on your DTS host machine or the SUT node.
-DTS can accept a pre-compiled build placed in a subdirectory,
-or it will compile DPDK on the SUT node,
-and then run the tests with the newly built binaries.
+To run DTS, use ``main.py`` with Poetry:
+
+.. code-block:: console
+
+   ```shell
+   docker build --target dev -t dpdk-dts .
+   docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it dpdk-dts bash
+   $ poetry install
+   $ poetry run ./main.py
+   ```
+
+Common options include:
+
+- ``--output-dir``: Custom output location.
+- ``--remote-source``: Use sources stored on the SUT.
+- ``--tarball``: Specify the tarball to be tested.
+
+For a full list:
+
+.. code-block:: console
+
+   poetry run ./main.py --help
 
 
 Configuring DTS
@@ -220,71 +224,6 @@ The user must have :ref:`administrator privileges <sut_admin_user>`
 which don't require password authentication.
 
 
-DTS Execution
-~~~~~~~~~~~~~
-
-DTS is run with ``main.py`` located in the ``dts`` directory after entering Poetry shell:
-
-.. code-block:: console
-
-   (dts-py3.10) $ ./main.py --help
-   usage: main.py [-h] [--test-run-config-file FILE_PATH] [--nodes-config-file FILE_PATH] [--tests-config-file FILE_PATH]
-                  [--output-dir DIR_PATH] [-t SECONDS] [-v] [--dpdk-tree DIR_PATH | --tarball FILE_PATH] [--remote-source]
-                  [--precompiled-build-dir DIR_NAME] [--compile-timeout SECONDS] [--test-suite TEST_SUITE [TEST_CASES ...]]
-                  [--re-run N_TIMES] [--random-seed NUMBER]
-
-   Run DPDK test suites. All options may be specified with the environment variables provided in brackets. Command line arguments have higher
-   priority.
-
-   options:
-     -h, --help            show this help message and exit
-     --test-run-config-file FILE_PATH
-                           [DTS_TEST_RUN_CFG_FILE] The configuration file that describes the test cases and DPDK build options. (default: test-run.conf.yaml)
-     --nodes-config-file FILE_PATH
-                           [DTS_NODES_CFG_FILE] The configuration file that describes the SUT and TG nodes. (default: nodes.conf.yaml)
-     --tests-config-file FILE_PATH
-                           [DTS_TESTS_CFG_FILE] Configuration file used to override variable values inside specific test suites. (default: None)
-     --output-dir DIR_PATH, --output DIR_PATH
-                           [DTS_OUTPUT_DIR] Output directory where DTS logs and results are saved. (default: output)
-     -t SECONDS, --timeout SECONDS
-                           [DTS_TIMEOUT] The default timeout for all DTS operations except for compiling DPDK. (default: 15)
-     -v, --verbose         [DTS_VERBOSE] Specify to enable verbose output, logging all messages to the console. (default: False)
-     --compile-timeout SECONDS
-                           [DTS_COMPILE_TIMEOUT] The timeout for compiling DPDK. (default: 1200)
-     --test-suite TEST_SUITE [TEST_CASES ...]
-                           [DTS_TEST_SUITES] A list containing a test suite with test cases. The first parameter is the test suite name, and
-                           the rest are test case names, which are optional. May be specified multiple times. To specify multiple test suites
-                           in the environment variable, join the lists with a comma. Examples: --test-suite suite case case --test-suite
-                           suite case ... | DTS_TEST_SUITES='suite case case, suite case, ...' | --test-suite suite --test-suite suite case
-                           ... | DTS_TEST_SUITES='suite, suite case, ...' (default: [])
-     --re-run N_TIMES, --re_run N_TIMES
-                           [DTS_RERUN] Re-run each test case the specified number of times if a test failure occurs. (default: 0)
-     --random-seed NUMBER  [DTS_RANDOM_SEED] The seed to use with the pseudo-random generator. If not specified, the configuration value is
-                           used instead. If that's also not specified, a random seed is generated. (default: None)
-
-   DPDK Build Options:
-     Arguments in this group (and subgroup) will be applied to a DPDKLocation when the DPDK tree, tarball or revision will be provided,
-     other arguments like remote source and build dir are optional. A DPDKLocation from settings are used instead of from config if
-     construct successful.
-
-     --dpdk-tree DIR_PATH  [DTS_DPDK_TREE] The path to the DPDK source tree directory to test. Cannot be used in conjunction with --tarball.
-                           (default: None)
-     --tarball FILE_PATH, --snapshot FILE_PATH
-                           [DTS_DPDK_TARBALL] The path to the DPDK source tarball to test. DPDK must be contained in a folder with the same
-                           name as the tarball file. Cannot be used in conjunction with --dpdk-tree. (default: None)
-     --remote-source       [DTS_REMOTE_SOURCE] Set this option if either the DPDK source tree or tarball to be used are located on the SUT
-                           node. Can only be used with --dpdk-tree or --tarball. (default: False)
-     --precompiled-build-dir DIR_NAME
-                           [DTS_PRECOMPILED_BUILD_DIR] Define the subdirectory under the DPDK tree root directory or tarball where the pre-
-                           compiled binaries are located. (default: None)
-
-
-The brackets contain the names of environment variables that set the same thing.
-The minimum DTS needs is a config file and a pre-built DPDK
-or DPDK sources location which can be specified in said config file
-or on the command line or environment variables.
-
-
 DTS Results
 ~~~~~~~~~~~
 
@@ -308,140 +247,89 @@ Adding test cases may require adding code to the framework as well.
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
-
-
-How To Write a Test Suite
--------------------------
-
-All test suites inherit from ``TestSuite`` defined in ``dts/framework/test_suite.py``.
-There are four types of methods that comprise a test suite:
-
-#. **Test cases**
-
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
-
-#. **Setup and Teardown methods**
-
-   | There are setup and teardown methods for the whole test suite and each individual test case.
-   | Methods ``set_up_suite`` and ``tear_down_suite`` will be executed
-     before any and after all test cases have been executed, respectively.
-   | Methods ``set_up_test_case`` and ``tear_down_test_case`` will be executed
-     before and after each test case, respectively.
-   | These methods don't need to be implemented if there's no need for them in a test suite.
-     In that case, nothing will happen when they are executed.
-
-#. **Configuration, traffic and other logic**
-
-   The ``TestSuite`` class contains a variety of methods for anything that
-   a test suite setup, a teardown, or a test case may need to do.
-
-   The test suites also frequently use a DPDK app, such as testpmd, in interactive mode
-   and use the interactive shell instances directly.
-
-   These are the two main ways to call the framework logic in test suites.
-   If there's any functionality or logic missing from the framework,
-   it should be implemented so that the test suites can use one of these two ways.
-
-#. **Test case verification**
-
-   Test case verification should be done with the ``verify`` method, which records the result.
-   The method should be called at the end of each test case.
-
-#. **Other methods**
-
-   Of course, all test suite code should adhere to coding standards.
-   Only the above methods will be treated specially and any other methods may be defined
-   (which should be mostly private methods needed by each particular test suite).
-   Any specific features (such as NIC configuration) required by a test suite
-   should be implemented in the ``SutNode`` class (and the underlying classes that ``SutNode`` uses)
-   and used by the test suite via the ``sut_node`` field.
+When contributing code to the DTS framework, follow existing conventions to ensure consistency.
+The :ref:`DTS developer tools <dts_dev_tools>` will flag basic issues.
+Also, be sure to :ref:`build the API documentation <building_api_docs>` to catch any problems during the build.
 
+The API documentation is a helpful reference during development.
+It can be viewed in the code directly or generated using the :ref:`API docs build steps <building_api_docs>`.
+If you add new files or change the directory structure, update the corresponding sources in ``doc/api/dts``.
 
-.. _dts_dev_tools:
+Code must be documented with docstrings that follow the
+`Google style <https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings>`_.
+Additional references:
 
-DTS Developer Tools
--------------------
+* `Sphinx Google style example <https://www.sphinx-doc.org/en/master/usage/extensions/example_google.html>`_
+* `PEP 257 <https://peps.python.org/pep-0257/>`_
+
+Docstring and Attribute Guidelines
 
-There are two tools used in DTS to help with code checking, style and formatting:
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
 
-* `ruff <https://astral.sh/ruff/>`_
+Example::
 
-  An extremely fast all-in-one linting and formatting solution,
-  which covers most if not all the major rules such as:
-  pylama, flake8, pylint etc.
-  Its built-in formatter is also Black-compatible
-  and is able to sort imports automatically like isort would.
+   def foo(greet: bool) -> None:
+       """Demonstrates single vs. double backticks.
 
-* `mypy <https://github.com/python/mypy>`_
+       `greet` controls whether ``Hello World`` is printed.
 
-  Enables static typing for Python, exploiting the type hints in the source code.
+       Args:
+           greet: Whether to print the ``Hello World`` message.
+       """
+       if greet:
+           print("Hello World")
+
+The maximum line length for docstrings must match that of the code.
+
+
+Creating a Test Suite
+---------------------
+
+All test suites inherit from ``TestSuite`` in ``dts/framework/test_suite.py``. A typical suite contains:
+
+- Test Cases  
+  - Functional: start with ``test_``, e.g., ``test_basic_link``  
+  - Performance: start with ``test_perf_``, e.g., ``test_perf_throughput``
+  - Import the ``func_test`` and/or ``perf_test`` decorators from ``TestSuite`` and add them above each test case method,
+   e.g., ``@func_test`` followed by ``test_basic_link``
+
+- Setup/Teardown Hooks
+  - Suite-level: ``set_up_suite()``, ``tear_down_suite()``
+  - Case-level: ``set_up_test_case()``, ``tear_down_test_case()``
+
+- Verification  
+  Use ``self.verify(condition, message)`` to record test results.
+
+- Support Methods
+  Helper logic (e.g., traffic handling, config) should be in private methods or delegated to ``sut_node``.
+
+
+.. _dts_dev_tools:
+
+Developer Tools
+---------------
+
+- ruff  
+  - Linter and formatter (replaces flake8, pylint, isort, etc.)
+  - Compatible with Black
+
+- mypy  
+  - Performs static type checking
+
+Run checks using:
+
+.. code-block:: console
 
-These two tools are all used in ``devtools/dts-check-format.sh``,
-the DTS code check and format script.
-Refer to the script for usage: ``devtools/dts-check-format.sh -h``.
+   devtools/dts-check-format.sh
 
 
 .. _building_api_docs:
-- 
2.49.0

