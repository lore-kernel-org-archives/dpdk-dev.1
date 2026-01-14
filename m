Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C56D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4904C427D8;
	Wed, 14 Jan 2026 23:56:18 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id A7F63427BF
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:16 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so1820935e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431376;
 x=1769036176; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lmu54IIfq8AY3E6svad+SrT5aRbuAHoGFcRi8Zg1cw=;
 b=l/WTFUxDChqG2GMgkuNbiTWHRiGp7urAEf1eT9qAgNR7jG7i/HdUR1VpwT1CVZg8al
 jeaME13Qbz2u26Kgspeh/Swx5lNyMt2O74bnOn30mf780F8T3bxgr2ppsIvQosSydusI
 WLHJSxJP78Y3o7aGB51Ee3CRFash4HyrQGFmgqpeHSe6fCsF3rW8TNaWLc3/QF1hmMYd
 S50HoXurAyHa663Y6yN+b4RIvIgOEFjutGUUutlMihZJTaBxYQifKLmPAsuBu0blZGYX
 l795uOU+v7DIXSM1rkqtVTbhZatPf2Rg18LlR8/NyeASN+B9/Y99LLmd8r8NVwRW292W
 AmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431376; x=1769036176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2lmu54IIfq8AY3E6svad+SrT5aRbuAHoGFcRi8Zg1cw=;
 b=UfkMDf/hTyGxJNogQmhmuC3s4zhLtIVNjrAbXubT2zRaabn7HhkX3FeGjWlg8KtIFg
 EYxSjsj/7nesBZXA/51KTi2v2RDQi1FP9OicQt2KCjbIeqFnYVBmMFPe44AZkarYDKdi
 e9jcEgK39s0j+ottYnF0pQRSMBxlRJb5N0BZDJa11/3hiyUzUbuWSYk/OfQTx4pBjS7y
 MGcamgiI+47P9kBSeg0/vJ1D1+Eaa2lt4zNLJU0VCUk8zjVolqYIoFlHweHd1vmhcHRi
 rsTOD4jOKhiFXp9EJRuFtW8Mn8pOfStK/JMiN2t5JInNsXuSaZnRFiggK0QRlZ19RPIw
 WWfg==
X-Gm-Message-State: AOJu0Yx4I6Ftra/aQ68xeKKP4KdhRBIaK0RM75VchTaUbzZe1h+MK6cu
 Tj3HqK4BJlVZ3Suywhi868AfPPOMQZM+bTvYhEPlyoDMCH7p1zl322cJ3fChuxky8X7hY0FQOyO
 esFrB
X-Gm-Gg: AY/fxX6Vk6xyfbMMlC4I2Ok+0r1CpgMt4J6wwZFKYIUUbigSMnrwSiY0vDobthBHhMU
 VlBDPEdG01Lgo+CQMPGIXTRkOlTi5hQCcnMXDg36dFn5eXk+fcxJpSveqlCytXEHZHRryV3gXvQ
 Cu973M8e5bP+t/55VUK4CH9QgOt+2ZF5MyCpxb55MPcfl4sxoNnmtMt+6yJMo+hmK2Z79Hl2ujV
 wfV7I6zPQkoShHanC4jh5h6//0nmSsvQZ0mN39cUeZZ6Cg0SAl13GVOEM4fGoljhlpT1fsTPuiV
 l7QFxSCJWqiIlhJ5pP3xU72Tla7vU/iCa0NaRxU3xrbjPeAmMpscK9PjdbHv8V7SAqqbGsq3w5F
 cNN9ATlyvS5GjnxlRz+OyN+AXfRk7Leov7eFpBti1r8WurQuKTgweeOvdVvFbmDGOoA47/BDoIz
 gGJedgYqOBD/FB80GtAIDUG4+xegUxaOlAJqC0xVsDA7d66r7g1Q==
X-Received: by 2002:a05:600c:8217:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-47ee32e07d0mr44417945e9.4.1768431376192; 
 Wed, 14 Jan 2026 14:56:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:56:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 10/11] doc: improve unit test guide readability
Date: Wed, 14 Jan 2026 14:54:14 -0800
Message-ID: <20260114225555.127448-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
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

Improve the unit test documentation
- Converting passive voice to active voice
- Using imperative mood for instructions
- Simplifying wordy constructions
- Removing unnecessary include statements from code example
- Fixing minor grammar and punctuation issues

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/unit_test.rst | 113 ++++++++++++--------------
 1 file changed, 52 insertions(+), 61 deletions(-)

diff --git a/doc/guides/contributing/unit_test.rst b/doc/guides/contributing/unit_test.rst
index c0f0d2988f..5b22393e6f 100644
--- a/doc/guides/contributing/unit_test.rst
+++ b/doc/guides/contributing/unit_test.rst
@@ -9,7 +9,7 @@ tests to the in-tree DPDK test suites.
 
 The DPDK test suite model is loosely based on the xUnit model,
 where tests are grouped into test suites, and suites are run by runners.
-For a basic overview, see the basic Wikipedia article on `xUnit
+For a basic overview, see the Wikipedia article on `xUnit
 <https://en.wikipedia.org/wiki/XUnit>`_.
 
 
@@ -18,13 +18,13 @@ Background
 
 The in-tree testing infrastructure for DPDK consists of
 multiple applications and support tools.
-The primary tools are the `dpdk-test` application,
+The primary tools are the `dpdk-test` application
 and the ``meson test`` infrastructure.
-These two are the primary ways through which
-a user will interact with the DPDK testing infrastructure.
+These two are the primary ways
+users interact with the DPDK testing infrastructure.
 
-There exists a bit of confusion with the test suite and test case separation
-with respect to `dpdk-test` and ``meson test``.
+Some confusion exists regarding test suite and test case separation
+between `dpdk-test` and ``meson test``.
 Both have a concept of test suite and test case.
 In both, the concept is similar.
 A test suite is a group of test cases,
@@ -36,14 +36,14 @@ to denote a Meson test suite / case.
 Running a test
 --------------
 
-DPDK tests are run via the main test runner, the `dpdk-test` app.
+DPDK tests run via the main test runner, the `dpdk-test` app.
 The `dpdk-test` app is a command-line interface that facilitates
 running various tests or test suites.
 
 There are three modes of operation.
-The first mode is as an interactive command shell
+The first mode is an interactive command shell
 that allows launching specific test suites.
-This is the default operating mode of `dpdk-test` and can be done by::
+This is the default operating mode of `dpdk-test` and can be invoked by::
 
    $ ./build/app/test/dpdk-test --dpdk-options-here
    EAL: Detected 4 lcore(s)
@@ -58,12 +58,12 @@ This is the default operating mode of `dpdk-test` and can be done by::
    APP: HPET is not enabled, using TSC as default timer
    RTE>>
 
-At the prompt, simply type the name of the test suite you wish to run
+At the prompt, type the name of the test suite you wish to run
 and it will execute.
 
-The second form is useful for a scripting environment,
+The second form is useful for a scripting environment
 and is used by the DPDK Meson build system.
-This mode is invoked by
+Invoke this mode by
 assigning a specific test suite name to the environment variable ``DPDK_TEST``
 before invoking the `dpdk-test` command, such as::
 
@@ -84,7 +84,7 @@ before invoking the `dpdk-test` command, such as::
    RTE>>$
 
 The above shows running a specific test case.
-On success, the return code will be '0',
+On success, the return code will be '0';
 otherwise it will be set to some error value (such as '255', or a negative value).
 
 The third form is an alternative
@@ -110,20 +110,20 @@ The unit test app can accept test suite names via command line arguments::
 The primary benefit here is specifying multiple test names,
 which is not possible with the ``DPDK_TEST`` environment variable.
 
-Additionally, it is possible to specify additional test parameters
+Additionally, specify additional test parameters
 via the ``DPDK_TEST_PARAMS`` argument,
 in case some tests need additional configuration.
-This isn't currently used in the Meson test suites.
+This is not currently used in the Meson test suites.
 
 
 Running test cases via Meson
 ----------------------------
 
-In order to allow developers to quickly execute all the standard internal tests
+To allow developers to quickly execute all the standard internal tests
 without needing to remember or look up each test suite name,
 the build system includes a standard way of executing the Meson test suites.
 After building via ``ninja``, the ``meson test`` command
-with no arguments will execute the Meson test suites.
+with no arguments executes the Meson test suites.
 
 There are a number of pre-configured Meson test suites.
 The first is the **fast** test suite, which is the largest group of test cases.
@@ -133,9 +133,9 @@ These test suites can take longer to run and do performance evaluations.
 The third is the **driver** test suite,
 which is mostly for special hardware related testing (such as `cryptodev`).
 The fourth, and currently the last, suite is the **debug** suite.
-These tests mostly are used to dump system information.
+These tests mostly dump system information.
 
-The Meson test suites can be selected by adding the ``--suite`` option
+Select the Meson test suites by adding the ``--suite`` option
 to the ``meson test`` command.
 Ex: ``meson test --suite fast-tests``::
 
@@ -159,19 +159,19 @@ via the command line by adding the test names as an argument::
    1/1 DPDK:fast-tests / version_autotest OK             0.17s
    ...
 
-Note that these test cases must be known to Meson
+Note that Meson must know these test cases
 for the ``meson test`` command to run them.
-Simply adding a new test to the `dpdk-test` application isn't enough.
+Simply adding a new test to the `dpdk-test` application is not enough.
 See the section `Adding a suite or test case to Meson`_ for more details.
 
 
 Adding tests to dpdk-test application
 -------------------------------------
 
-Unit tests should be added to the system
-whenever we introduce new functionality to DPDK,
-as well as whenever a bug is resolved.
-This helps the DPDK project to catch regressions as they are introduced.
+Add unit tests to the system
+whenever introducing new functionality to DPDK
+or resolving a bug.
+This helps the DPDK project catch regressions as they occur.
 
 The DPDK test application supports two layers of tests:
    #. *test cases* which are individual tests
@@ -185,12 +185,12 @@ There are two important functions for interacting with the test harness:
    ``REGISTER_<MESON_SUITE>_TEST(command_name, function_to_execute)``
       Registers a test command with the name `command_name`
       and which runs the function `function_to_execute` when `command_name` is invoked.
-      The test is automatically added to the Meson test suite `<MESON_SUITE>` by this macro.
-      Examples would be ``REGISTER_DRIVER_TEST``, or ``REGISTER_PERF_TEST``.
+      This macro automatically adds the test to the Meson test suite `<MESON_SUITE>`.
+      Examples: ``REGISTER_DRIVER_TEST``, or ``REGISTER_PERF_TEST``.
       **NOTE:** The ``REGISTER_FAST_TEST`` macro is slightly different,
       in that it takes two additional parameters,
-      specifying whether the test can be run using ``--no-huge``,
-      and whether the test can be run using Address Sanitization (ASAN)
+      specifying whether the test can run using ``--no-huge``,
+      and whether the test can run using Address Sanitization (ASAN).
 
    ``unit_test_suite_runner(struct unit_test_suite *)``
       Returns a runner for a full test suite object,
@@ -203,28 +203,19 @@ that runs at the beginning and end of the test suite execution.
 Each unit test has a similar function for test case setup and tear down.
 
 Each test suite may use a nested list of sub-testsuites,
-which are iterated by the ``unit_test_suite_runner``.
+which the ``unit_test_suite_runner`` iterates.
 This support allows for better granularity when designing test suites.
-The sub-testsuites list can also be used in parallel with the vector of test cases,
-in this case the test cases will be run,
-and then each sub-testsuite is executed.
+The sub-testsuites list can also be used in parallel with the vector of test cases;
+in this case, the test cases run first,
+then each sub-testsuite executes.
 To see an example of a test suite using sub-testsuites,
 see *app/test/test_cryptodev.c*.
 
-Test cases are added to the ``.unit_test_cases`` element
-of the appropriate unit test suite structure.
-An example of both a test suite and a case:
+Example of a test suite with a single test case:
 
 .. code-block:: c
    :linenos:
 
-   #include <time.h>
-
-   #include <rte_common.h>
-   #include <rte_cycles.h>
-   #include <rte_hexdump.h>
-   #include <rte_random.h>
-
    #include "test.h"
 
    static int testsuite_setup(void) { return TEST_SUCCESS; }
@@ -256,7 +247,7 @@ An example of both a test suite and a case:
 The above code block is a small example
 that can be used to create a complete test suite with test case.
 
-Sub-testsuites can be added to the ``.unit_test_suites`` element
+Add sub-testsuites to the ``.unit_test_suites`` element
 of the unit test suite structure, for example:
 
 .. code-block:: c
@@ -335,13 +326,13 @@ The first way to indicate a generic error is
 by returning a test result failure, using the ``TEST_FAILED`` error code.
 This is the most basic way of indicating that an error
 has occurred in a test routine.
-It isn't very informative to the user, so it should really be used in cases
+It is not very informative to the user, so use it in cases
 where the test has catastrophically failed.
 
 The preferred method of indicating an error is
 via the ``RTE_TEST_ASSERT`` family of macros,
-which will immediately return ``TEST_FAILED`` error condition,
-but will also log details about the failure.
+which immediately return ``TEST_FAILED`` error condition,
+but also log details about the failure.
 The basic form is:
 
 .. code-block:: c
@@ -350,16 +341,16 @@ The basic form is:
 
 In the above macro, *cond* is the condition to evaluate to **true**.
 Any generic condition can go here.
-The *msg* parameter will be a message to display if *cond* evaluates to **false**.
+The *msg* parameter is a message to display if *cond* evaluates to **false**.
 Some specialized macros already exist.
 See `lib/librte_eal/include/rte_test.h` for a list of defined test assertions.
 
 Sometimes it is important to indicate that a test needs to be skipped,
-either because the environment isn't able to support running the test,
-or because some requisite functionality isn't available.
+either because the environment cannot support running the test,
+or because some requisite functionality is unavailable.
 The test suite supports returning a result of ``TEST_SKIPPED``
 during test case setup, or during test case execution
-to indicate that the preconditions of the test aren't available.
+to indicate that the preconditions of the test are not available.
 Example::
 
    $ meson test -C build --suite fast-tests
@@ -386,10 +377,10 @@ Example::
    $ meson test -C build --suite fast-tests
    $ ninja coverage-html -C build
 
-The above will generate an HTML report
+The above generates an HTML report
 in the `build/meson-logs/coveragereport/` directory
 that can be explored for detailed code covered information.
-This can be used to assist in test development.
+Use this to assist in test development.
 
 
 Adding a suite or test case to Meson
@@ -400,10 +391,10 @@ to register the test in dpdk-test, as described above.
 For example,
 defining the test command using ``REGISTER_PERF_TEST`` automatically
 adds the test to the perf-test meson suite.
-Once added, the new test will be run
+Once added, the new test runs
 as part of the appropriate class (fast, perf, driver, etc.).
 
-A user or developer can confirm that a test is known to Meson
+Confirm that a test is known to Meson
 by using the ``--list`` option::
 
    $ meson test -C build --list
@@ -411,12 +402,12 @@ by using the ``--list`` option::
    DPDK:fast-tests / bitops_autotest
    ...
 
-Some of these test suites are run during continuous integration tests,
+Some of these test suites run during continuous integration tests,
 making regression checking automatic for new patches submitted to the project.
 
 .. note::
 
-   The use of the old ``REGISTER_TEST_COMMAND`` macro
+   The old ``REGISTER_TEST_COMMAND`` macro
    to add a command without adding it to a meson test suite is deprecated.
    All new tests must be added to a test suite
    using the appropriate ``REGISTER_<SUITE>_TEST`` macro.
@@ -424,8 +415,8 @@ making regression checking automatic for new patches submitted to the project.
 Running cryptodev tests
 -----------------------
 
-When running cryptodev tests, the user must create any required virtual device
-via EAL arguments, as this is not automatically done by the test::
+When running cryptodev tests, create any required virtual device
+via EAL arguments, as this is not done automatically by the test::
 
    $ ./build/app/test/dpdk-test --vdev crypto_aesni_mb
    $ meson test -C build --suite driver-tests \
@@ -433,6 +424,6 @@ via EAL arguments, as this is not automatically done by the test::
 
 .. note::
 
-   The ``cryptodev_scheduler_autotest`` is the only exception to this.
-   This vdev will be created automatically by the test app,
+   The ``cryptodev_scheduler_autotest`` is the only exception.
+   This vdev is created automatically by the test app,
    as it requires a more complex setup than other vdevs.
-- 
2.51.0

