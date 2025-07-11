Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E773FC83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 17:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9F47402D8;
	Fri, 11 Jul 2025 19:25:44 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id CB48D402CB
 for <dev@dpdk.org>; Fri, 11 Jul 2025 19:25:42 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4a44b3526e6so30778191cf.0
 for <dev@dpdk.org>; Fri, 11 Jul 2025 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752254742; x=1752859542; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xxh97Dqvlnfs0bUVcXGtJI3b1o9t9XufBXew3wJ3Ln0=;
 b=Mmg2+hLuWhHQKIB9+LeO2YU9rDBQb+oVP9xBfjdlKPmrjqwTa98y4Dkl+gun6kstXY
 VeCkl3fXrxlHmCqfAxyItnE9oGhv3ugTTrSIFEiyepDygwumnrIwoa1EUPbKLQW/qUH9
 SC2M1Ps0F01g2bNFKPXvlQy9KHIk0KEiNTtaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254742; x=1752859542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xxh97Dqvlnfs0bUVcXGtJI3b1o9t9XufBXew3wJ3Ln0=;
 b=ndvonAh16rLaQlva1o920gYGbNmDfc3KrR9MopnoHbzchJRwYevW8q3gWyfeKUTVuk
 BKwseQxLjYCsILT0fpUfFknL19kpgku3TTUC3Kb5svpCfreoJygNc2vzAq3Ugq1Hzo+v
 +UyWwhgDPi98bFCmoGDQi9YJ7grKfSHfc7vTdb8SU4C+dULvf1dXXYQgBPpoovPnRsof
 CgvqaAjNe0YBQWRsjxLVetGrIL6PY5zaYWTgVyz8XiokHz8iGR6A0jb6kJ9HrGxwKphf
 rO1dyte8qwdK/BC7+L5zcfNhGqYU8D/4uddaYUve7l26wqOXbfhxFsKV3lYXD6uHKUN/
 taow==
X-Gm-Message-State: AOJu0YzkU2uPDX0rkwpMoCOO5+guLEFIkb01gU423tqmNhAtN8r10MbJ
 X/1TpscZEHR4u4KEc4/K5xt7VcDswqd9gMqDJeegC6PWz6lftxg3wncDS157Vlj7/Dw=
X-Gm-Gg: ASbGncveIfTFgf6i6xz4h3EuNfZCV/NtFgn7aQNk3lZ89YcplrL32YQpAGgyuAjNagy
 BJIkanjCNEk8CiL+btCNgEEa/nbMRG7eEOVd06kqKejdTmcjkeAUwv4OnJzqnRJd97YPtwSRBQs
 6JkIy+42X0tJbBiUoCvhTqYUXtxlUb6WEdjqceISaaWEsj6IJNPUjFJtoa9MF4vUfpt+8fDW7fU
 vYI2jD3QU8sPJ48dJBwvOVx/WrrVsfhVboSvxgXcJTaMqIn7RVD1vMsWxV6ThdInFqwlnDDedUU
 LPGZTN97lGWvRhISMEM+fpLy2hse4ah6Ai2Ht+3B3AP1D1wgPV3iATPKpMdDHurYCfXK8XXL3lQ
 pNfsOUMiXO0DPRg==
X-Google-Smtp-Source: AGHT+IHu6Ntsh4NQWizFHQmEpUDM00sStftTRfAwY1c7zi6QeS9/z/OnuUaUPr75M3oL/WxlQPRksA==
X-Received: by 2002:ac8:6f19:0:b0:4a6:ef86:19a1 with SMTP id
 d75a77b69052e-4a9fb8872e8mr78610791cf.16.1752254741973; 
 Fri, 11 Jul 2025 10:25:41 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9edc65720sm23329341cf.30.2025.07.11.10.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:25:41 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 3/3] doc: revise coding guidelines section
Date: Fri, 11 Jul 2025 13:24:55 -0400
Message-ID: <20250711172534.540416-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711172534.540416-1-dmarx@iol.unh.edu>
References: <20250603172827.458725-1-dmarx@iol.unh.edu>
 <20250711172534.540416-1-dmarx@iol.unh.edu>
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
---
 doc/guides/tools/dts.rst | 181 ++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 97 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 7f6f7c1db5..6af9f8b75c 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -348,122 +348,109 @@ Adding test cases may require adding code to the framework as well.
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
+       """Demonstrates single vs. double backticks.
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
+   For example: @func_test followed by def test_basic_link(self):
+
+   Functional test cases should use the @func_test decorator, and performance test cases should use @perf_test.
+   A test suite may include any number of functional and/or performance test cases.
+   Each suite should focus on testing a single feature (one feature = one test suite).
+   If a feature requires extensive testing scenarios, it's better to split the test cases across multiple test suites to reduce execution time.
+
+Setup and Teardown Hooks
+
+   Setup and teardown methods can be defined at both the suite and test case levels.
+
+   Suite-level:
+
+   * set_up_suite() — runs once before any test cases in the suite
+
+   * tear_down_suite() — runs once after all test cases have completed
 
-#. **Test cases**
+   Case-level:
 
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
+   * set_up_test_case() — runs before each individual test case
 
-#. **Setup and Teardown methods**
+   * tear_down_test_case() — runs after each individual test case
 
-   | There are setup and teardown methods for the whole test suite and each individual test case.
-   | Methods ``set_up_suite`` and ``tear_down_suite`` will be executed
-     before any and after all test cases have been executed, respectively.
-   | Methods ``set_up_test_case`` and ``tear_down_test_case`` will be executed
-     before and after each test case, respectively.
-   | These methods don't need to be implemented if there's no need for them in a test suite.
-     In that case, nothing will happen when they are executed.
+   These methods are optional. If not implemented, the framework will simply skip them.
 
-#. **Configuration, traffic and other logic**
+Configuration, Traffic, and Other Logic
 
-   The ``TestSuite`` class contains a variety of methods for anything that
-   a test suite setup, a teardown, or a test case may need to do.
+   The TestSuite class provides a variety of methods for setup, teardown, and test logic.
+   Test suites often use DPDK applications (e.g., testpmd) in interactive mode and interact with them via shell instances.
 
-   The test suites also frequently use a DPDK app, such as testpmd, in interactive mode
-   and use the interactive shell instances directly.
+Framework logic should be used in one of two ways:
 
-   These are the two main ways to call the framework logic in test suites.
-   If there's any functionality or logic missing from the framework,
-   it should be implemented so that the test suites can use one of these two ways.
+* Using built-in methods provided by TestSuite or its base classes
 
-   Test suites may also be configured individually using a file provided at the command line.
-   The file is a simple mapping of test suite names to their corresponding configurations.
+* Interacting directly with tools or shell interfaces
 
-   Any test suite can be designed to require custom configuration attributes or optional ones.
-   Any optional attributes should supply a default value for the test suite to use.
+If any required functionality is missing, it should be implemented in a way that supports one of these two approaches.
 
-#. **Test case verification**
+Test Case Verification
 
-   Test case verification should be done with the ``verify`` method, which records the result.
-   The method should be called at the end of each test case.
+   Use the verify method to assert conditions and record test results.
+   This should typically be called at the end of each test case.
+   Example: self.verify(link_up, "Link should be up after configuration.")
 
-#. **Other methods**
+Other Methods
 
-   Of course, all test suite code should adhere to coding standards.
-   Only the above methods will be treated specially and any other methods may be defined
-   (which should be mostly private methods needed by each particular test suite).
-   Any specific features (such as NIC configuration) required by a test suite
-   should be implemented in the ``SutNode`` class (and the underlying classes that ``SutNode`` uses)
-   and used by the test suite via the ``sut_node`` field.
+   All test suite code should follow the project's coding standards.
+   Only test cases, setup/teardown hooks, and verification methods are treated specially by the framework.
+   Additional methods may be defined as needed (ideally private).
+   Any specific features (such as NIC configuration) should be implemented in the SutNode class or its supporting classes, and accessed using the sut_node field.
 
 
 .. _dts_dev_tools:
-- 
2.49.0

