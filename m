Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EAC982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C156442ED7;
	Fri, 16 Jan 2026 21:18:03 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id B3A2642ED1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:18:02 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64d0d41404cso4208225a12.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594682;
 x=1769199482; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34a0NjS1nWDSrOi9uQkxkjqazGHDVJswLHmZ5JXRPTU=;
 b=Jtx9v2F2D9sJfD5YWtMlspdmWzrs8SqD4sDX6nzdvPksQ0LzKRxQevtbeoWran64e7
 8JxqdTyByXu1PfADsV4N3po26GKGyOv1bLTr+iSSihvye0o6IcFHL/EMuMHOzMYap/4F
 JUKZDWy+eCpRcR3a8zCvJFcWWRzsBY0s141hCSD+oWlxGdIZ4E3CYQHuSe1ET5nOr2+q
 p6IAO5vV6zDOVCpLNPGtMjakm+cKJhtvAeckDWlc27G8Abs9uVyhoM1VJNhsMEXUEcj6
 PwYH3qXJrjUqSCKMYyZEgsJ+fvIPulFRi4FvWGLOyOAmgzzW/kSfQYZm+Eb1KxABfDRa
 wvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594682; x=1769199482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=34a0NjS1nWDSrOi9uQkxkjqazGHDVJswLHmZ5JXRPTU=;
 b=SWdvalNh44FBgtGpJC01TP30DqQhrUuc4a955IlEXNVOSq5Ab9zNWUxG1jKhcHu7rX
 AEXjkti3DfpvtjP0RlPtv/XOhJw26y3vSVK7rufSUWrcp1HlEQUuYui9dkFb0FUlgLo6
 84sKAzw92p5vtSdMoBuwI7d+L+vKbk/4xVr16dgR/PsT/Y3yTOiRw4AFxh6CV1MatuH3
 NcMpvlqSvqdcL3uXDkzharrrPYyHnxkkjTdRfSZt9g/ihPG5+WeaF1WTcBIOq+/BTy/M
 JHhczeZ4XVP4dnx46Ru2QxPNqNZoSmYxK8exq+BlOcjjuiP+EfIWJh+uN9DI57wc+8aH
 7AXQ==
X-Gm-Message-State: AOJu0YzqVpHpxFIhk3wAfu0kXWccOIOWPVWGZZ/KF6FqFdCi+96V4npi
 m2rDgGN+9ZCM2gk3GbXCgFW23Ovi4szx9pEFGT7c6GK9iu8JKkoJa5pntaB6UZTuDvjHjOtdA6O
 FPIiW
X-Gm-Gg: AY/fxX4a5BZb5usCgVY8q+7iZO3kQ3gLQUoH2n4l3VPh7IJWlKuFf5L18qbWMNWTyjT
 +Z0SOcy1ux2IJPXl6bCR2bXb6dS1s0nhVhaQZhsYSYu1LGT92meS++p0yF0o/VSnniZdMh3oWNO
 61DKl6xSwgXCw5JqFSxUkKMZMCe+UWeZAw5McJaIIheUpxQBSr9m+HU2SHTxVUeMzinfq2XYDYN
 zq/XugNyILqRB3PVA3HD+MTS/BXzRTLKAi+QRk7KXU86JteA7vGI+OO6X/IGalKtX3o7eKMzqDW
 Nf9jHsjUkNvuPWZhMTY0STzsx9BLZnL9DW5thsgz94dQSp7qCmL8viKad+UnQ5JE0TwlXI5vhPh
 C9TRbxGTDZ+eN/OSpjKamzPl3WEKc8Pacu7b+R/eCzw1r3OMuKetMqCvuPgTx2aOoKVFAOJk90N
 0cLg3vkQhk2XzerLVBFM6reVckbhz2IqUgKKILEFzUPdegpkpqUQ==
X-Received: by 2002:a17:907:a05:b0:b86:fed0:2b with SMTP id
 a640c23a62f3a-b8792f79c4dmr375682166b.32.1768594682036; 
 Fri, 16 Jan 2026 12:18:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:18:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 11/12] doc: improve unit test guide readability
Date: Fri, 16 Jan 2026 12:14:29 -0800
Message-ID: <20260116201738.74578-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
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
- Add missing subject in sentence about DPDK_TEST_PARAMS
- Add missing article "a" before "test case"
- Fix missing closing backtick in meson test example
- Use consistent double backticks for dpdk-test command references
- Use double backticks for file path reference
- Correct "test case" to "test suite" in DPDK_TEST example description
- Clarify "cryptodev" reference to "crypto devices"
- Remove unnecessary quotes around return code values

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/unit_test.rst | 129 ++++++++++++--------------
 1 file changed, 60 insertions(+), 69 deletions(-)

diff --git a/doc/guides/contributing/unit_test.rst b/doc/guides/contributing/unit_test.rst
index 0c76921299..a92953eab1 100644
--- a/doc/guides/contributing/unit_test.rst
+++ b/doc/guides/contributing/unit_test.rst
@@ -9,7 +9,7 @@ tests to the in-tree DPDK test suites.
 
 The DPDK test suite model is loosely based on the xUnit model,
 where tests are grouped into test suites, and suites are run by runners.
-For a basic overview, see the basic Wikipedia article on `xUnit
+For a basic overview, see the Wikipedia article on `xUnit
 <https://en.wikipedia.org/wiki/XUnit>`_.
 
 
@@ -18,32 +18,32 @@ Background
 
 The in-tree testing infrastructure for DPDK consists of
 multiple applications and support tools.
-The primary tools are the `dpdk-test` application,
+The primary tools are the ``dpdk-test`` application
 and the ``meson test`` infrastructure.
-These two are the primary ways through which
-a user will interact with the DPDK testing infrastructure.
+These two are the primary ways
+users interact with the DPDK testing infrastructure.
 
-There exists a bit of confusion with the test suite and test case separation
-with respect to `dpdk-test` and ``meson test``.
+Some confusion exists regarding test suite and test case separation
+between ``dpdk-test`` and ``meson test``.
 Both have a concept of test suite and test case.
 In both, the concept is similar.
 A test suite is a group of test cases,
 and a test case represents the steps needed to test a particular set of code.
-Where needed, they will be disambiguated by the word `Meson`
+Where needed, they will be disambiguated by the word Meson
 to denote a Meson test suite / case.
 
 
 Running a test
 --------------
 
-DPDK tests are run via the main test runner, the `dpdk-test` app.
-The `dpdk-test` app is a command-line interface that facilitates
+DPDK tests run via the main test runner, the ``dpdk-test`` app.
+The ``dpdk-test`` app is a command-line interface that facilitates
 running various tests or test suites.
 
 There are three modes of operation.
-The first mode is as an interactive command shell
+The first mode is an interactive command shell
 that allows launching specific test suites.
-This is the default operating mode of `dpdk-test` and can be done by::
+This is the default operating mode of ``dpdk-test`` and can be invoked by::
 
    $ ./build/app/test/dpdk-test --dpdk-options-here
    EAL: Detected 4 lcore(s)
@@ -58,14 +58,14 @@ This is the default operating mode of `dpdk-test` and can be done by::
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
-before invoking the `dpdk-test` command, such as::
+before invoking the ``dpdk-test`` command, such as::
 
    $ DPDK_TEST=version_autotest ./build/app/test/dpdk-test --dpdk-options-here
    EAL: Detected 4 lcore(s)
@@ -83,9 +83,9 @@ before invoking the `dpdk-test` command, such as::
    Test OK
    RTE>>$
 
-The above shows running a specific test case.
-On success, the return code will be '0',
-otherwise it will be set to some error value (such as '255', or a negative value).
+The above shows running a specific test suite.
+On success, the return code will be 0;
+otherwise it will be set to some error value (such as 255).
 
 The third form is an alternative
 to providing the test suite name in an environment variable.
@@ -110,20 +110,20 @@ The unit test app can accept test suite names via command line arguments::
 The primary benefit here is specifying multiple test names,
 which is not possible with the ``DPDK_TEST`` environment variable.
 
-Additionally, it is possible to specify additional test parameters
+Additionally, you can specify additional test parameters
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
@@ -131,11 +131,11 @@ These are the bulk of the unit tests to validate functional blocks.
 The second is the **perf** tests.
 These test suites can take longer to run and do performance evaluations.
 The third is the **driver** test suite,
-which is mostly for special hardware related testing (such as `cryptodev`).
+which is mostly for special hardware related testing (such as crypto devices).
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
+Simply adding a new test to the ``dpdk-test`` application is not enough.
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
@@ -185,8 +185,8 @@ There are two important functions for interacting with the test harness:
    ``REGISTER_<MESON_SUITE>_TEST(command_name, function_to_execute)``
       Registers a test command with the name `command_name`
       and which runs the function `function_to_execute` when `command_name` is invoked.
-      The test is automatically added to the Meson test suite `<MESON_SUITE>` by this macro.
-      Examples would be ``REGISTER_DRIVER_TEST``, or ``REGISTER_PERF_TEST``.
+      This macro automatically adds the test to the Meson test suite `<MESON_SUITE>`.
+      Examples: ``REGISTER_DRIVER_TEST``, or ``REGISTER_PERF_TEST``.
       **NOTE:** The ``REGISTER_FAST_TEST`` macro is slightly different,
       in that it takes two additional parameters before the function name:
       the hugepage requirement (``NOHUGE_OK`` if the test can run without hugepages,
@@ -205,28 +205,19 @@ that runs at the beginning and end of the test suite execution.
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
@@ -256,9 +247,9 @@ An example of both a test suite and a case:
    REGISTER_PERF_TEST(example_autotest, example_tests);
 
 The above code block is a small example
-that can be used to create a complete test suite with test case.
+that can be used to create a complete test suite with a test case.
 
-Sub-testsuites can be added to the ``.unit_test_suites`` element
+Add sub-testsuites to the ``.unit_test_suites`` element
 of the unit test suite structure, for example:
 
 .. code-block:: c
@@ -337,13 +328,13 @@ The first way to indicate a generic error is
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
@@ -352,20 +343,20 @@ The basic form is:
 
 In the above macro, *cond* is the condition to evaluate to **true**.
 Any generic condition can go here.
-The *msg* parameter will be a message to display if *cond* evaluates to **false**.
+The *msg* parameter is a message to display if *cond* evaluates to **false**.
 Some specialized macros already exist.
-See `lib/librte_eal/include/rte_test.h` for a list of defined test assertions.
+See ``lib/librte_eal/include/rte_test.h`` for a list of defined test assertions.
 
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
-   ninja: Entering directory `/home/aconole/git/dpdk/build
+   ninja: Entering directory `/home/aconole/git/dpdk/build'
    [2543/2543] Linking target app/test/dpdk-test.
    1/60 DPDK:fast-tests / acl_autotest          OK       3.17 s
    2/60 DPDK:fast-tests / bitops_autotest       OK       0.22 s
@@ -388,10 +379,10 @@ Example::
    $ meson test -C build --suite fast-tests
    $ ninja coverage-html -C build
 
-The above will generate an HTML report
-in the `build/meson-logs/coveragereport/` directory
+The above generates an HTML report
+in the ``build/meson-logs/coveragereport/`` directory
 that can be explored for detailed code covered information.
-This can be used to assist in test development.
+Use this to assist in test development.
 
 
 Adding a suite or test case to Meson
@@ -402,10 +393,10 @@ to register the test in dpdk-test, as described above.
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
@@ -413,12 +404,12 @@ by using the ``--list`` option::
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
@@ -426,8 +417,8 @@ making regression checking automatic for new patches submitted to the project.
 Running cryptodev tests
 -----------------------
 
-When running cryptodev tests, the user must create any required virtual device
-via EAL arguments, as this is not automatically done by the test::
+When running cryptodev tests, create any required virtual device
+via EAL arguments, as this is not done automatically by the test::
 
    $ ./build/app/test/dpdk-test --vdev crypto_aesni_mb
    $ meson test -C build --suite driver-tests \
@@ -435,6 +426,6 @@ via EAL arguments, as this is not automatically done by the test::
 
 .. note::
 
-   The ``cryptodev_scheduler_autotest`` is the only exception to this.
-   This vdev will be created automatically by the test app,
+   The ``cryptodev_scheduler_autotest`` is the only exception.
+   This vdev is created automatically by the test app,
    as it requires a more complex setup than other vdevs.
-- 
2.51.0

