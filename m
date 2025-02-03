Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B2C02195
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 15:18:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 110DB40DFB;
	Mon,  3 Feb 2025 16:18:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B1D5F40670
 for <dev@dpdk.org>; Mon,  3 Feb 2025 16:17:50 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EA0E11FB;
 Mon,  3 Feb 2025 07:18:14 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 916623F63F;
 Mon,  3 Feb 2025 07:17:49 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [RFC PATCH 7/7] dts: revamp runtime internals
Date: Mon,  3 Feb 2025 15:16:12 +0000
Message-ID: <20250203151613.2436570-8-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203151613.2436570-1-luca.vizzarro@arm.com>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
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

Enforce separation of concerns by letting test runs being isolated
through a new TestRun class and respective module. This also means that
any actions taken on the nodes must be handled exclusively by the test
run. An example being the creation and destruction of the traffic
generator. TestSuiteWithCases is now redundant as the configuration is
able to provide all the details about the test run's own test suites.
Any other runtime state which concerns the test runs, now belongs to
their class.

Finally, as the test run execution is isolated, all the runtime
internals are held in the new class. Internals which have been
completely reworked into a finite state machine (FSM), to simplify the
use and understanding of the different execution states, while
rendering the process of handling errors less repetitive and easier.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 doc/api/dts/framework.test_run.rst        |   8 +
 doc/api/dts/index.rst                     |   1 +
 doc/guides/conf.py                        |   3 +-
 dts/framework/exception.py                |  33 +-
 dts/framework/runner.py                   | 492 +---------------------
 dts/framework/test_result.py              | 143 +------
 dts/framework/test_run.py                 | 443 +++++++++++++++++++
 dts/framework/testbed_model/capability.py |  24 +-
 dts/framework/testbed_model/tg_node.py    |   6 +-
 9 files changed, 524 insertions(+), 629 deletions(-)
 create mode 100644 doc/api/dts/framework.test_run.rst
 create mode 100644 dts/framework/test_run.py

diff --git a/doc/api/dts/framework.test_run.rst b/doc/api/dts/framework.test_run.rst
new file mode 100644
index 0000000000..8147320ed9
--- /dev/null
+++ b/doc/api/dts/framework.test_run.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+test_run - Test Run Execution
+===========================================================
+
+.. automodule:: framework.test_run
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index b211571430..c76725eb75 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -26,6 +26,7 @@ Modules
    :maxdepth: 1
 
    framework.runner
+   framework.test_run
    framework.test_suite
    framework.test_result
    framework.settings
diff --git a/doc/guides/conf.py b/doc/guides/conf.py
index e7508ea1d5..9ccd7d0c84 100644
--- a/doc/guides/conf.py
+++ b/doc/guides/conf.py
@@ -59,7 +59,8 @@
 
 # DTS API docs additional configuration
 if environ.get('DTS_DOC_BUILD'):
-    extensions = ['sphinx.ext.napoleon', 'sphinx.ext.autodoc']
+    extensions = ['sphinx.ext.napoleon', 'sphinx.ext.autodoc', 'sphinx.ext.graphviz']
+    graphviz_output_format = "svg"
 
     # Pydantic models require autodoc_pydantic for the right formatting
     try:
diff --git a/dts/framework/exception.py b/dts/framework/exception.py
index d967ede09b..47e3fac05c 100644
--- a/dts/framework/exception.py
+++ b/dts/framework/exception.py
@@ -205,28 +205,27 @@ class TestCaseVerifyError(DTSError):
     severity: ClassVar[ErrorSeverity] = ErrorSeverity.TESTCASE_VERIFY_ERR
 
 
-class BlockingTestSuiteError(DTSError):
-    """A failure in a blocking test suite."""
+class InternalError(DTSError):
+    """An internal error or bug has occurred in DTS."""
 
     #:
-    severity: ClassVar[ErrorSeverity] = ErrorSeverity.BLOCKING_TESTSUITE_ERR
-    _suite_name: str
+    severity: ClassVar[ErrorSeverity] = ErrorSeverity.INTERNAL_ERR
 
-    def __init__(self, suite_name: str) -> None:
-        """Define the meaning of the first argument.
 
-        Args:
-            suite_name: The blocking test suite.
-        """
-        self._suite_name = suite_name
+class SkippedTestException(DTSError):
+    """An exception raised when a test suite or case has been skipped."""
 
-    def __str__(self) -> str:
-        """Add some context to the string representation."""
-        return f"Blocking suite {self._suite_name} failed."
+    #:
+    severity: ClassVar[ErrorSeverity] = ErrorSeverity.NO_ERR
 
+    def __init__(self, reason: str) -> None:
+        """Constructor.
 
-class InternalError(DTSError):
-    """An internal error or bug has occurred in DTS."""
+        Args:
+            reason: The reason for the test being skipped.
+        """
+        self._reason = reason
 
-    #:
-    severity: ClassVar[ErrorSeverity] = ErrorSeverity.INTERNAL_ERR
+    def __str__(self) -> str:
+        """Stringify the exception."""
+        return self._reason
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index 60a885d8e6..8f5bf716a3 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -19,14 +19,12 @@
 """
 
 import os
-import random
 import sys
-from pathlib import Path
-from types import MethodType
-from typing import Iterable
 
 from framework.config.common import ValidationContext
-from framework.testbed_model.capability import Capability, get_supported_capabilities
+from framework.status import POST_RUN
+from framework.test_run import TestRun
+from framework.testbed_model.node import Node
 from framework.testbed_model.sut_node import SutNode
 from framework.testbed_model.tg_node import TGNode
 
@@ -38,23 +36,12 @@
     SutNodeConfiguration,
     TGNodeConfiguration,
 )
-from .config.test_run import (
-    TestRunConfiguration,
-    TestSuiteConfig,
-)
-from .exception import BlockingTestSuiteError, SSHTimeoutError, TestCaseVerifyError
-from .logger import DTSLogger, DtsStage, get_dts_logger
+from .logger import DTSLogger, get_dts_logger
 from .settings import SETTINGS
 from .test_result import (
     DTSResult,
     Result,
-    TestCaseResult,
-    TestRunResult,
-    TestSuiteResult,
-    TestSuiteWithCases,
 )
-from .test_suite import TestCase, TestSuite
-from .testbed_model.topology import PortLink, Topology
 
 
 class DTSRunner:
@@ -79,10 +66,6 @@ class DTSRunner:
     _configuration: Configuration
     _logger: DTSLogger
     _result: DTSResult
-    _test_suite_class_prefix: str
-    _test_suite_module_prefix: str
-    _func_test_case_regex: str
-    _perf_test_case_regex: str
 
     def __init__(self):
         """Initialize the instance with configuration, logger, result and string constants."""
@@ -92,10 +75,6 @@ def __init__(self):
             os.makedirs(SETTINGS.output_dir)
         self._logger.add_dts_root_logger_handlers(SETTINGS.verbose, SETTINGS.output_dir)
         self._result = DTSResult(SETTINGS.output_dir, self._logger)
-        self._test_suite_class_prefix = "Test"
-        self._test_suite_module_prefix = "tests.TestSuite_"
-        self._func_test_case_regex = r"test_(?!perf_)"
-        self._perf_test_case_regex = r"test_perf_"
 
     def run(self) -> None:
         """Run all test runs from the test run configuration.
@@ -131,45 +110,28 @@ def run(self) -> None:
         the :option:`--test-suite` command line argument or
         the :envvar:`DTS_TESTCASES` environment variable.
         """
-        sut_nodes: dict[str, SutNode] = {}
-        tg_nodes: dict[str, TGNode] = {}
+        nodes: list[Node] = []
         try:
             # check the python version of the server that runs dts
             self._check_dts_python_version()
             self._result.update_setup(Result.PASS)
 
+            for node_config in self._configuration.nodes:
+                node: Node
+
+                match node_config:
+                    case SutNodeConfiguration():
+                        node = SutNode(node_config)
+                    case TGNodeConfiguration():
+                        node = TGNode(node_config)
+
+                nodes.append(node)
+
             # for all test run sections
-            for test_run_with_nodes_config in self._configuration.test_runs_with_nodes:
-                test_run_config, sut_node_config, tg_node_config = test_run_with_nodes_config
-                self._logger.set_stage(DtsStage.test_run_setup)
-                self._logger.info(f"Running test run with SUT '{sut_node_config.name}'.")
-                self._init_random_seed(test_run_config)
+            for test_run_config in self._configuration.test_runs:
                 test_run_result = self._result.add_test_run(test_run_config)
-                # we don't want to modify the original config, so create a copy
-                test_run_test_suites = test_run_config.test_suites
-                if not test_run_config.skip_smoke_tests:
-                    test_run_test_suites[:0] = [TestSuiteConfig(test_suite="smoke_tests")]
-                try:
-                    test_suites_with_cases = self._get_test_suites_with_cases(
-                        test_run_test_suites, test_run_config.func, test_run_config.perf
-                    )
-                    test_run_result.test_suites_with_cases = test_suites_with_cases
-                except Exception as e:
-                    self._logger.exception(
-                        f"Invalid test suite configuration found: " f"{test_run_test_suites}."
-                    )
-                    test_run_result.update_setup(Result.FAIL, e)
-
-                else:
-                    self._connect_nodes_and_run_test_run(
-                        sut_nodes,
-                        tg_nodes,
-                        sut_node_config,
-                        tg_node_config,
-                        test_run_config,
-                        test_run_result,
-                        test_suites_with_cases,
-                    )
+                test_run = TestRun(test_run_config, nodes, test_run_result)
+                test_run.spin()
 
         except Exception as e:
             self._logger.exception("An unexpected error has occurred.")
@@ -178,8 +140,8 @@ def run(self) -> None:
 
         finally:
             try:
-                self._logger.set_stage(DtsStage.post_run)
-                for node in (sut_nodes | tg_nodes).values():
+                self._logger.set_stage(POST_RUN)
+                for node in nodes:
                     node.close()
                 self._result.update_teardown(Result.PASS)
             except Exception as e:
@@ -205,412 +167,6 @@ def _check_dts_python_version(self) -> None:
             )
             self._logger.warning("Please use Python >= 3.10 instead.")
 
-    def _get_test_suites_with_cases(
-        self,
-        test_suite_configs: list[TestSuiteConfig],
-        func: bool,
-        perf: bool,
-    ) -> list[TestSuiteWithCases]:
-        """Get test suites with selected cases.
-
-        The test suites with test cases defined in the user configuration are selected
-        and the corresponding functions and classes are gathered.
-
-        Args:
-            test_suite_configs: Test suite configurations.
-            func: Whether to include functional test cases in the final list.
-            perf: Whether to include performance test cases in the final list.
-
-        Returns:
-            The test suites, each with test cases.
-        """
-        test_suites_with_cases = []
-
-        for test_suite_config in test_suite_configs:
-            test_suite_class = test_suite_config.test_suite_spec.class_obj
-            test_cases: list[type[TestCase]] = []
-            func_test_cases, perf_test_cases = test_suite_class.filter_test_cases(
-                test_suite_config.test_cases_names
-            )
-            if func:
-                test_cases.extend(func_test_cases)
-            if perf:
-                test_cases.extend(perf_test_cases)
-
-            test_suites_with_cases.append(
-                TestSuiteWithCases(test_suite_class=test_suite_class, test_cases=test_cases)
-            )
-        return test_suites_with_cases
-
-    def _connect_nodes_and_run_test_run(
-        self,
-        sut_nodes: dict[str, SutNode],
-        tg_nodes: dict[str, TGNode],
-        sut_node_config: SutNodeConfiguration,
-        tg_node_config: TGNodeConfiguration,
-        test_run_config: TestRunConfiguration,
-        test_run_result: TestRunResult,
-        test_suites_with_cases: Iterable[TestSuiteWithCases],
-    ) -> None:
-        """Connect nodes, then continue to run the given test run.
-
-        Connect the :class:`SutNode` and the :class:`TGNode` of this `test_run_config`.
-        If either has already been connected, it's going to be in either `sut_nodes` or `tg_nodes`,
-        respectively.
-        If not, connect and add the node to the respective `sut_nodes` or `tg_nodes` :class:`dict`.
-
-        Args:
-            sut_nodes: A dictionary storing connected/to be connected SUT nodes.
-            tg_nodes: A dictionary storing connected/to be connected TG nodes.
-            sut_node_config: The test run's SUT node configuration.
-            tg_node_config: The test run's TG node configuration.
-            test_run_config: A test run configuration.
-            test_run_result: The test run's result.
-            test_suites_with_cases: The test suites with test cases to run.
-        """
-        sut_node = sut_nodes.get(sut_node_config.name)
-        tg_node = tg_nodes.get(tg_node_config.name)
-
-        try:
-            if not sut_node:
-                sut_node = SutNode(sut_node_config)
-                sut_nodes[sut_node.name] = sut_node
-            if not tg_node:
-                tg_node = TGNode(tg_node_config)
-                tg_nodes[tg_node.name] = tg_node
-        except Exception as e:
-            failed_node = test_run_config.system_under_test_node
-            if sut_node:
-                failed_node = test_run_config.traffic_generator_node
-            self._logger.exception(f"The Creation of node {failed_node} failed.")
-            test_run_result.update_setup(Result.FAIL, e)
-
-        else:
-            self._run_test_run(
-                sut_node,
-                tg_node,
-                test_run_config,
-                test_run_result,
-                test_suites_with_cases,
-            )
-
-    def _run_test_run(
-        self,
-        sut_node: SutNode,
-        tg_node: TGNode,
-        test_run_config: TestRunConfiguration,
-        test_run_result: TestRunResult,
-        test_suites_with_cases: Iterable[TestSuiteWithCases],
-    ) -> None:
-        """Run the given test run.
-
-        This involves running the test run setup as well as running all test suites
-        in the given test run. After that, the test run teardown is run.
-
-        Args:
-            sut_node: The test run's SUT node.
-            tg_node: The test run's TG node.
-            test_run_config: A test run configuration.
-            test_run_result: The test run's result.
-            test_suites_with_cases: The test suites with test cases to run.
-
-        Raises:
-            ConfigurationError: If the DPDK sources or build is not set up from config or settings.
-        """
-        self._logger.info(f"Running test run with SUT '{test_run_config.system_under_test_node}'.")
-        test_run_result.ports = sut_node.ports
-        test_run_result.sut_info = sut_node.node_info
-        try:
-            dpdk_build_config = test_run_config.dpdk_config
-            sut_node.set_up_test_run(test_run_config, dpdk_build_config)
-            test_run_result.dpdk_build_info = sut_node.get_dpdk_build_info()
-            tg_node.set_up_test_run(test_run_config, dpdk_build_config)
-            test_run_result.update_setup(Result.PASS)
-        except Exception as e:
-            self._logger.exception("Test run setup failed.")
-            test_run_result.update_setup(Result.FAIL, e)
-
-        else:
-            topology = Topology(
-                PortLink(sut_node.ports_by_name[link.sut_port], tg_node.ports_by_name[link.tg_port])
-                for link in test_run_config.port_topology
-            )
-            self._run_test_suites(
-                sut_node, tg_node, topology, test_run_result, test_suites_with_cases
-            )
-
-        finally:
-            try:
-                self._logger.set_stage(DtsStage.test_run_teardown)
-                sut_node.tear_down_test_run()
-                tg_node.tear_down_test_run()
-                test_run_result.update_teardown(Result.PASS)
-            except Exception as e:
-                self._logger.exception("Test run teardown failed.")
-                test_run_result.update_teardown(Result.FAIL, e)
-
-    def _get_supported_capabilities(
-        self,
-        sut_node: SutNode,
-        topology_config: Topology,
-        test_suites_with_cases: Iterable[TestSuiteWithCases],
-    ) -> set[Capability]:
-        capabilities_to_check = set()
-        for test_suite_with_cases in test_suites_with_cases:
-            capabilities_to_check.update(test_suite_with_cases.required_capabilities)
-
-        self._logger.debug(f"Found capabilities to check: {capabilities_to_check}")
-
-        return get_supported_capabilities(sut_node, topology_config, capabilities_to_check)
-
-    def _run_test_suites(
-        self,
-        sut_node: SutNode,
-        tg_node: TGNode,
-        topology: Topology,
-        test_run_result: TestRunResult,
-        test_suites_with_cases: Iterable[TestSuiteWithCases],
-    ) -> None:
-        """Run `test_suites_with_cases` with the current test run.
-
-        The method assumes the DPDK we're testing has already been built on the SUT node.
-
-        Before running any suites, the method determines whether they should be skipped
-        by inspecting any required capabilities the test suite needs and comparing those
-        to capabilities supported by the tested environment. If all capabilities are supported,
-        the suite is run. If all test cases in a test suite would be skipped, the whole test suite
-        is skipped (the setup and teardown is not run).
-
-        If a blocking test suite (such as the smoke test suite) fails, the rest of the test suites
-        in the current test run won't be executed.
-
-        Args:
-            sut_node: The test run's SUT node.
-            tg_node: The test run's TG node.
-            topology: The test run's port topology.
-            test_run_result: The test run's result.
-            test_suites_with_cases: The test suites with test cases to run.
-        """
-        end_dpdk_build = False
-        supported_capabilities = self._get_supported_capabilities(
-            sut_node, topology, test_suites_with_cases
-        )
-        for test_suite_with_cases in test_suites_with_cases:
-            test_suite_with_cases.mark_skip_unsupported(supported_capabilities)
-            test_suite_result = test_run_result.add_test_suite(test_suite_with_cases)
-            try:
-                if not test_suite_with_cases.skip:
-                    self._run_test_suite(
-                        sut_node,
-                        tg_node,
-                        topology,
-                        test_suite_result,
-                        test_suite_with_cases,
-                    )
-                else:
-                    self._logger.info(
-                        f"Test suite execution SKIPPED: "
-                        f"'{test_suite_with_cases.test_suite_class.__name__}'. Reason: "
-                        f"{test_suite_with_cases.test_suite_class.skip_reason}"
-                    )
-                    test_suite_result.update_setup(Result.SKIP)
-            except BlockingTestSuiteError as e:
-                self._logger.exception(
-                    f"An error occurred within {test_suite_with_cases.test_suite_class.__name__}. "
-                    "Skipping the rest of the test suites in this test run."
-                )
-                self._result.add_error(e)
-                end_dpdk_build = True
-            # if a blocking test failed and we need to bail out of suite executions
-            if end_dpdk_build:
-                break
-
-    def _run_test_suite(
-        self,
-        sut_node: SutNode,
-        tg_node: TGNode,
-        topology: Topology,
-        test_suite_result: TestSuiteResult,
-        test_suite_with_cases: TestSuiteWithCases,
-    ) -> None:
-        """Set up, execute and tear down `test_suite_with_cases`.
-
-        The method assumes the DPDK we're testing has already been built on the SUT node.
-
-        Test suite execution consists of running the discovered test cases.
-        A test case run consists of setup, execution and teardown of said test case.
-
-        Record the setup and the teardown and handle failures.
-
-        Args:
-            sut_node: The test run's SUT node.
-            tg_node: The test run's TG node.
-            topology: The port topology of the nodes.
-            test_suite_result: The test suite level result object associated
-                with the current test suite.
-            test_suite_with_cases: The test suite with test cases to run.
-
-        Raises:
-            BlockingTestSuiteError: If a blocking test suite fails.
-        """
-        test_suite_name = test_suite_with_cases.test_suite_class.__name__
-        self._logger.set_stage(
-            DtsStage.test_suite_setup, Path(SETTINGS.output_dir, test_suite_name)
-        )
-        test_suite = test_suite_with_cases.test_suite_class(sut_node, tg_node, topology)
-        try:
-            self._logger.info(f"Starting test suite setup: {test_suite_name}")
-            test_suite.set_up_suite()
-            test_suite_result.update_setup(Result.PASS)
-            self._logger.info(f"Test suite setup successful: {test_suite_name}")
-        except Exception as e:
-            self._logger.exception(f"Test suite setup ERROR: {test_suite_name}")
-            test_suite_result.update_setup(Result.ERROR, e)
-
-        else:
-            self._execute_test_suite(
-                test_suite,
-                test_suite_with_cases.test_cases,
-                test_suite_result,
-            )
-        finally:
-            try:
-                self._logger.set_stage(DtsStage.test_suite_teardown)
-                test_suite.tear_down_suite()
-                sut_node.kill_cleanup_dpdk_apps()
-                test_suite_result.update_teardown(Result.PASS)
-            except Exception as e:
-                self._logger.exception(f"Test suite teardown ERROR: {test_suite_name}")
-                self._logger.warning(
-                    f"Test suite '{test_suite_name}' teardown failed, "
-                    "the next test suite may be affected."
-                )
-                test_suite_result.update_setup(Result.ERROR, e)
-            if len(test_suite_result.get_errors()) > 0 and test_suite.is_blocking:
-                raise BlockingTestSuiteError(test_suite_name)
-
-    def _execute_test_suite(
-        self,
-        test_suite: TestSuite,
-        test_cases: Iterable[type[TestCase]],
-        test_suite_result: TestSuiteResult,
-    ) -> None:
-        """Execute all `test_cases` in `test_suite`.
-
-        If the :option:`--re-run` command line argument or the :envvar:`DTS_RERUN` environment
-        variable is set, in case of a test case failure, the test case will be executed again
-        until it passes or it fails that many times in addition of the first failure.
-
-        Args:
-            test_suite: The test suite object.
-            test_cases: The list of test case functions.
-            test_suite_result: The test suite level result object associated
-                with the current test suite.
-        """
-        self._logger.set_stage(DtsStage.test_suite)
-        for test_case in test_cases:
-            test_case_name = test_case.__name__
-            test_case_result = test_suite_result.add_test_case(test_case_name)
-            all_attempts = SETTINGS.re_run + 1
-            attempt_nr = 1
-            if not test_case.skip:
-                self._run_test_case(test_suite, test_case, test_case_result)
-                while not test_case_result and attempt_nr < all_attempts:
-                    attempt_nr += 1
-                    self._logger.info(
-                        f"Re-running FAILED test case '{test_case_name}'. "
-                        f"Attempt number {attempt_nr} out of {all_attempts}."
-                    )
-                    self._run_test_case(test_suite, test_case, test_case_result)
-            else:
-                self._logger.info(
-                    f"Test case execution SKIPPED: {test_case_name}. Reason: "
-                    f"{test_case.skip_reason}"
-                )
-                test_case_result.update_setup(Result.SKIP)
-
-    def _run_test_case(
-        self,
-        test_suite: TestSuite,
-        test_case: type[TestCase],
-        test_case_result: TestCaseResult,
-    ) -> None:
-        """Setup, execute and teardown `test_case_method` from `test_suite`.
-
-        Record the result of the setup and the teardown and handle failures.
-
-        Args:
-            test_suite: The test suite object.
-            test_case: The test case function.
-            test_case_result: The test case level result object associated
-                with the current test case.
-        """
-        test_case_name = test_case.__name__
-
-        try:
-            # run set_up function for each case
-            test_suite.set_up_test_case()
-            test_case_result.update_setup(Result.PASS)
-        except SSHTimeoutError as e:
-            self._logger.exception(f"Test case setup FAILED: {test_case_name}")
-            test_case_result.update_setup(Result.FAIL, e)
-        except Exception as e:
-            self._logger.exception(f"Test case setup ERROR: {test_case_name}")
-            test_case_result.update_setup(Result.ERROR, e)
-
-        else:
-            # run test case if setup was successful
-            self._execute_test_case(test_suite, test_case, test_case_result)
-
-        finally:
-            try:
-                test_suite.tear_down_test_case()
-                test_case_result.update_teardown(Result.PASS)
-            except Exception as e:
-                self._logger.exception(f"Test case teardown ERROR: {test_case_name}")
-                self._logger.warning(
-                    f"Test case '{test_case_name}' teardown failed, "
-                    f"the next test case may be affected."
-                )
-                test_case_result.update_teardown(Result.ERROR, e)
-                test_case_result.update(Result.ERROR)
-
-    def _execute_test_case(
-        self,
-        test_suite: TestSuite,
-        test_case: type[TestCase],
-        test_case_result: TestCaseResult,
-    ) -> None:
-        """Execute `test_case_method` from `test_suite`, record the result and handle failures.
-
-        Args:
-            test_suite: The test suite object.
-            test_case: The test case function.
-            test_case_result: The test case level result object associated
-                with the current test case.
-
-        Raises:
-            KeyboardInterrupt: If DTS has been interrupted by the user.
-        """
-        test_case_name = test_case.__name__
-        try:
-            self._logger.info(f"Starting test case execution: {test_case_name}")
-            # Explicit method binding is required, otherwise mypy complains
-            MethodType(test_case, test_suite)()
-            test_case_result.update(Result.PASS)
-            self._logger.info(f"Test case execution PASSED: {test_case_name}")
-
-        except TestCaseVerifyError as e:
-            self._logger.exception(f"Test case execution FAILED: {test_case_name}")
-            test_case_result.update(Result.FAIL, e)
-        except Exception as e:
-            self._logger.exception(f"Test case execution ERROR: {test_case_name}")
-            test_case_result.update(Result.ERROR, e)
-        except KeyboardInterrupt:
-            self._logger.error(f"Test case execution INTERRUPTED by user: {test_case_name}")
-            test_case_result.update(Result.SKIP)
-            raise KeyboardInterrupt("Stop DTS")
-
     def _exit_dts(self) -> None:
         """Process all errors and exit with the proper exit code."""
         self._result.process()
@@ -619,9 +175,3 @@ def _exit_dts(self) -> None:
             self._logger.info("DTS execution has ended.")
 
         sys.exit(self._result.get_return_code())
-
-    def _init_random_seed(self, conf: TestRunConfiguration) -> None:
-        """Initialize the random seed to use for the test run."""
-        seed = conf.random_seed or random.randrange(0xFFFF_FFFF)
-        self._logger.info(f"Initializing test run with random seed {seed}.")
-        random.seed(seed)
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index 1acb526b64..a59bac71bb 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -25,98 +25,18 @@
 
 import json
 from collections.abc import MutableSequence
-from dataclasses import asdict, dataclass, field
 from enum import Enum, auto
 from pathlib import Path
-from typing import Any, Callable, TypedDict, cast
+from typing import Any, Callable, TypedDict
 
-from framework.config.node import PortConfig
-from framework.testbed_model.capability import Capability
-
-from .config.test_run import TestRunConfiguration, TestSuiteConfig
+from .config.test_run import TestRunConfiguration
 from .exception import DTSError, ErrorSeverity
 from .logger import DTSLogger
-from .test_suite import TestCase, TestSuite
 from .testbed_model.os_session import OSSessionInfo
 from .testbed_model.port import Port
 from .testbed_model.sut_node import DPDKBuildInfo
 
 
-@dataclass(slots=True, frozen=True)
-class TestSuiteWithCases:
-    """A test suite class with test case methods.
-
-    An auxiliary class holding a test case class with test case methods. The intended use of this
-    class is to hold a subset of test cases (which could be all test cases) because we don't have
-    all the data to instantiate the class at the point of inspection. The knowledge of this subset
-    is needed in case an error occurs before the class is instantiated and we need to record
-    which test cases were blocked by the error.
-
-    Attributes:
-        test_suite_class: The test suite class.
-        test_cases: The test case methods.
-        required_capabilities: The combined required capabilities of both the test suite
-            and the subset of test cases.
-    """
-
-    test_suite_class: type[TestSuite]
-    test_cases: list[type[TestCase]]
-    required_capabilities: set[Capability] = field(default_factory=set, init=False)
-
-    def __post_init__(self):
-        """Gather the required capabilities of the test suite and all test cases."""
-        for test_object in [self.test_suite_class] + self.test_cases:
-            self.required_capabilities.update(test_object.required_capabilities)
-
-    def create_config(self) -> TestSuiteConfig:
-        """Generate a :class:`TestSuiteConfig` from the stored test suite with test cases.
-
-        Returns:
-            The :class:`TestSuiteConfig` representation.
-        """
-        return TestSuiteConfig(
-            test_suite=self.test_suite_class.__name__,
-            test_cases=[test_case.__name__ for test_case in self.test_cases],
-        )
-
-    def mark_skip_unsupported(self, supported_capabilities: set[Capability]) -> None:
-        """Mark the test suite and test cases to be skipped.
-
-        The mark is applied if object to be skipped requires any capabilities and at least one of
-        them is not among `supported_capabilities`.
-
-        Args:
-            supported_capabilities: The supported capabilities.
-        """
-        for test_object in [self.test_suite_class, *self.test_cases]:
-            capabilities_not_supported = test_object.required_capabilities - supported_capabilities
-            if capabilities_not_supported:
-                test_object.skip = True
-                capability_str = (
-                    "capability" if len(capabilities_not_supported) == 1 else "capabilities"
-                )
-                test_object.skip_reason = (
-                    f"Required {capability_str} '{capabilities_not_supported}' not found."
-                )
-        if not self.test_suite_class.skip:
-            if all(test_case.skip for test_case in self.test_cases):
-                self.test_suite_class.skip = True
-
-                self.test_suite_class.skip_reason = (
-                    "All test cases are marked to be skipped with reasons: "
-                    f"{' '.join(test_case.skip_reason for test_case in self.test_cases)}"
-                )
-
-    @property
-    def skip(self) -> bool:
-        """Skip the test suite if all test cases or the suite itself are to be skipped.
-
-        Returns:
-            :data:`True` if the test suite should be skipped, :data:`False` otherwise.
-        """
-        return all(test_case.skip for test_case in self.test_cases) or self.test_suite_class.skip
-
-
 class Result(Enum):
     """The possible states that a setup, a teardown or a test case may end up in."""
 
@@ -463,7 +383,6 @@ class TestRunResult(BaseResult):
     """
 
     _config: TestRunConfiguration
-    _test_suites_with_cases: list[TestSuiteWithCases]
     _ports: list[Port]
     _sut_info: OSSessionInfo | None
     _dpdk_build_info: DPDKBuildInfo | None
@@ -476,49 +395,23 @@ def __init__(self, test_run_config: TestRunConfiguration):
         """
         super().__init__()
         self._config = test_run_config
-        self._test_suites_with_cases = []
         self._ports = []
         self._sut_info = None
         self._dpdk_build_info = None
 
-    def add_test_suite(
-        self,
-        test_suite_with_cases: TestSuiteWithCases,
-    ) -> "TestSuiteResult":
+    def add_test_suite(self, test_suite_name: str) -> "TestSuiteResult":
         """Add and return the child result (test suite).
 
         Args:
-            test_suite_with_cases: The test suite with test cases.
+            test_suite_name: The test suite name.
 
         Returns:
             The test suite's result.
         """
-        result = TestSuiteResult(test_suite_with_cases)
+        result = TestSuiteResult(test_suite_name)
         self.child_results.append(result)
         return result
 
-    @property
-    def test_suites_with_cases(self) -> list[TestSuiteWithCases]:
-        """The test suites with test cases to be executed in this test run.
-
-        The test suites can only be assigned once.
-
-        Returns:
-            The list of test suites with test cases. If an error occurs between
-            the initialization of :class:`TestRunResult` and assigning test cases to the instance,
-            return an empty list, representing that we don't know what to execute.
-        """
-        return self._test_suites_with_cases
-
-    @test_suites_with_cases.setter
-    def test_suites_with_cases(self, test_suites_with_cases: list[TestSuiteWithCases]) -> None:
-        if self._test_suites_with_cases:
-            raise ValueError(
-                "Attempted to assign test suites to a test run result "
-                "which already has test suites."
-            )
-        self._test_suites_with_cases = test_suites_with_cases
-
     @property
     def ports(self) -> list[Port]:
         """Get the list of ports associated with this test run."""
@@ -602,24 +495,14 @@ def to_dict(self) -> TestRunResultDict:
             compiler_version = self.dpdk_build_info.compiler_version
             dpdk_version = self.dpdk_build_info.dpdk_version
 
-        ports = [asdict(port) for port in self.ports]
-        for port in ports:
-            port["config"] = cast(PortConfig, port["config"]).model_dump()
-
         return {
             "compiler_version": compiler_version,
             "dpdk_version": dpdk_version,
-            "ports": ports,
+            "ports": [port.to_dict() for port in self.ports],
             "test_suites": [child.to_dict() for child in self.child_results],
             "summary": results | self.generate_pass_rate_dict(results),
         }
 
-    def _mark_results(self, result) -> None:
-        """Mark the test suite results as `result`."""
-        for test_suite_with_cases in self._test_suites_with_cases:
-            child_result = self.add_test_suite(test_suite_with_cases)
-            child_result.update_setup(result)
-
 
 class TestSuiteResult(BaseResult):
     """The test suite specific result.
@@ -631,18 +514,16 @@ class TestSuiteResult(BaseResult):
     """
 
     test_suite_name: str
-    _test_suite_with_cases: TestSuiteWithCases
     _child_configs: list[str]
 
-    def __init__(self, test_suite_with_cases: TestSuiteWithCases):
+    def __init__(self, test_suite_name: str):
         """Extend the constructor with test suite's config.
 
         Args:
-            test_suite_with_cases: The test suite with test cases.
+            test_suite_name: The test suite name.
         """
         super().__init__()
-        self.test_suite_name = test_suite_with_cases.test_suite_class.__name__
-        self._test_suite_with_cases = test_suite_with_cases
+        self.test_suite_name = test_suite_name
 
     def add_test_case(self, test_case_name: str) -> "TestCaseResult":
         """Add and return the child result (test case).
@@ -667,12 +548,6 @@ def to_dict(self) -> TestSuiteResultDict:
             "test_cases": [child.to_dict() for child in self.child_results],
         }
 
-    def _mark_results(self, result) -> None:
-        """Mark the test case results as `result`."""
-        for test_case_method in self._test_suite_with_cases.test_cases:
-            child_result = self.add_test_case(test_case_method.__name__)
-            child_result.update_setup(result)
-
 
 class TestCaseResult(BaseResult, FixtureResult):
     r"""The test case specific result.
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
new file mode 100644
index 0000000000..add0a62eb9
--- /dev/null
+++ b/dts/framework/test_run.py
@@ -0,0 +1,443 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+r"""Test run module.
+
+The test run is implemented as a finite state machine which maintains a globally accessible
+:class:`~.context.Context` and holds all the execution stages and state as defined in
+:class:`~.status.State`.
+
+The state machine is implemented in :meth:`~TestRun._runner` which can be run by calling
+:meth:`~TestRun.spin`.
+
+The following graph represents all the states and steps of the state machine. Each node represents a
+state labelled with the initials, e.g. ``TR.B`` is represented by :attr:`~.status.Stage.TEST_RUN`
+and :attr:`~.status.InternalState.BEGIN`. States represented by a double green circle are looping
+states. These states are only exited through:
+
+    * **next** which progresses to the next test suite/case.
+    * **end** which indicates that no more test suites/cases are available and
+      the loop is terminated.
+
+Red dashed links represent the path taken when an exception is
+raised in the origin state. If a state does not have one, then the execution progresses as usual.
+When :class:`~.exception.InternalError` is raised in any state, the state machine execution is
+immediately terminated.
+Orange dashed links represent exceptional conditions. Test suites and cases can be ``blocked`` or
+``skipped`` in the following conditions:
+
+    * If a *blocking* test suite fails, the ``blocked`` flag is raised.
+    * If the user sends a ``SIGINT`` signal, the ``blocked`` flag is raised.
+    * If a test suite and/or test case requires a capability unsupported by the test run, then this
+      is ``skipped`` and the state restarts from the beginning.
+
+Finally, test cases **retry** when they fail and DTS is configured to re-run.
+
+.. digraph:: test_run_fsm
+
+    bgcolor=transparent
+    nodesep=0.5
+    ranksep=0.3
+
+    node [fontname="sans-serif" fixedsize="true" width="0.7"]
+    edge [fontname="monospace" color="gray30" fontsize=12]
+    node [shape="circle"] "TR.S" "TR.T" "TS.S" "TS.T" "TC.S" "TC.T"
+
+    node [shape="doublecircle" style="bold" color="darkgreen"] "TR.R" "TS.R" "TC.R"
+
+    node [shape="box" style="filled" color="gray90"] "TR.B" "TR.E"
+    node [style="solid"] "TS.E" "TC.E"
+
+    node [shape="plaintext" fontname="monospace" fontsize=12 fixedsize="false"] "exit"
+
+    "TR.B" -> "TR.S" -> "TR.R"
+    "TR.R":e -> "TR.T":w [taillabel="end" labeldistance=1.5 labelangle=45]
+    "TR.T" -> "TR.E"
+    "TR.E" -> "exit" [style="solid" color="gray30"]
+
+    "TR.R" -> "TS.S" [headlabel="next" labeldistance=3 labelangle=320]
+    "TS.S" -> "TS.R"
+    "TS.R" -> "TS.T" [label="end"]
+    "TS.T" -> "TS.E" -> "TR.R"
+
+    "TS.R" -> "TC.S" [headlabel="next" labeldistance=3 labelangle=320]
+    "TC.S" -> "TC.R" -> "TC.T" -> "TC.E" -> "TS.R":se
+
+
+    edge [fontcolor="orange", color="orange" style="dashed"]
+    "TR.R":sw -> "TS.R":nw [taillabel="next\n(blocked)" labeldistance=13]
+    "TS.R":ne -> "TR.R" [taillabel="end\n(blocked)" labeldistance=7.5 labelangle=345]
+    "TR.R":w -> "TR.R":nw [headlabel="next\n(skipped)" labeldistance=4]
+    "TS.R":e -> "TS.R":e [taillabel="next\n(blocked)\n(skipped)" labelangle=325 labeldistance=7.5]
+    "TC.R":e -> "TC.R":e [taillabel="retry" labelangle=5 labeldistance=2.5]
+
+    edge [fontcolor="crimson" color="crimson"]
+    "TR.S" -> "TR.T"
+    "TS.S":w -> "TS.T":n
+    "TC.S" -> "TC.T"
+
+    node [fontcolor="crimson" color="crimson"]
+    "InternalError" -> "exit":ew
+"""
+
+import random
+from collections import deque
+from collections.abc import Generator, Iterable
+from functools import cached_property
+from pathlib import Path
+from types import MethodType
+from typing import cast
+
+from framework.config.test_run import TestRunConfiguration
+from framework.context import Context, init_ctx
+from framework.exception import (
+    InternalError,
+    SkippedTestException,
+    TestCaseVerifyError,
+)
+from framework.logger import DTSLogger, get_dts_logger
+from framework.settings import SETTINGS
+from framework.status import InternalState, Stage, State
+from framework.test_result import BaseResult, Result, TestCaseResult, TestRunResult, TestSuiteResult
+from framework.test_suite import TestCase, TestSuite
+from framework.testbed_model.capability import (
+    Capability,
+    get_supported_capabilities,
+    test_if_supported,
+)
+from framework.testbed_model.node import Node
+from framework.testbed_model.sut_node import SutNode
+from framework.testbed_model.tg_node import TGNode
+from framework.testbed_model.topology import PortLink, Topology
+
+TestScenario = tuple[type[TestSuite], deque[type[TestCase]]]
+
+
+class TestRun:
+    """Spins a test run."""
+
+    config: TestRunConfiguration
+    logger: DTSLogger
+
+    ctx: Context
+    result: TestRunResult
+    selected_tests: list[TestScenario]
+
+    _state: State
+    _remaining_tests: deque[TestScenario]
+    _max_retries: int
+
+    def __init__(self, config: TestRunConfiguration, nodes: Iterable[Node], result: TestRunResult):
+        """Test run constructor."""
+        self.config = config
+        self.logger = get_dts_logger()
+
+        sut_node = next(n for n in nodes if n.name == config.system_under_test_node)
+        sut_node = cast(SutNode, sut_node)  # Config validation must render this valid.
+
+        tg_node = next(n for n in nodes if n.name == config.traffic_generator_node)
+        tg_node = cast(TGNode, tg_node)  # Config validation must render this valid.
+
+        topology = Topology.from_port_links(
+            PortLink(sut_node.ports_by_name[link.sut_port], tg_node.ports_by_name[link.tg_port])
+            for link in self.config.port_topology
+        )
+
+        self.ctx = Context(sut_node, tg_node, topology)
+        init_ctx(self.ctx)
+
+        self.result = result
+        self.selected_tests = list(self.config.filter_tests())
+
+        self._state = State(Stage.TEST_RUN, InternalState.BEGIN)
+        self._max_retries = SETTINGS.re_run
+
+    @cached_property
+    def required_capabilities(self) -> set[Capability]:
+        """The capabilities required to run this test run in its totality."""
+        caps = set()
+
+        for test_suite, test_cases in self.selected_tests:
+            caps.update(test_suite.required_capabilities)
+            for test_case in test_cases:
+                caps.update(test_case.required_capabilities)
+
+        return caps
+
+    def spin(self):
+        """Spin the internal state machine that executes the test run."""
+        self.logger.info(f"Running test run with SUT '{self.ctx.sut_node.name}'.")
+
+        runner = self._runner()
+        while next_state := next(runner, False):
+            previous_state = self._state
+            stage, internal_state = next_state
+            self._state = State(stage, internal_state)
+            self.logger.debug(f"FSM - moving from '{previous_state}' to '{self._state}'")
+
+    def _runner(self) -> Generator[tuple[Stage, InternalState], None, None]:  # noqa: C901
+        """Process the current state.
+
+        Yields:
+            The next state.
+
+        Raises:
+            InternalError: If the test run has entered an illegal state or a critical error has
+                occurred.
+        """
+        running = True
+        blocked = False
+
+        remaining_attempts: int
+        remaining_test_cases: deque[type[TestCase]]
+        test_suite: TestSuite
+        test_suite_result: TestSuiteResult
+        test_case: type[TestCase]
+        test_case_result: TestCaseResult
+
+        while running:
+            state = self._state
+            try:
+                match state:
+                    case Stage.TEST_RUN, InternalState.BEGIN:
+                        yield state[0], InternalState.SETUP
+
+                    case Stage.TEST_RUN, InternalState.SETUP:
+                        self.update_logger_stage()
+                        self.setup()
+                        yield state[0], InternalState.RUN
+
+                    case Stage.TEST_RUN, InternalState.RUN:
+                        self.update_logger_stage()
+                        try:
+                            test_suite_class, remaining_test_cases = self._remaining_tests.popleft()
+                            test_suite = test_suite_class()
+                            test_suite_result = self.result.add_test_suite(test_suite.name)
+
+                            if blocked:
+                                test_suite_result.update_setup(Result.BLOCK)
+                                self.logger.error(f"Test suite '{test_suite.name}' was BLOCKED.")
+                                # Continue to allow the rest to mark as blocked, no need to setup.
+                                yield Stage.TEST_SUITE, InternalState.RUN
+                                continue
+
+                            test_if_supported(test_suite_class, self.supported_capabilities)
+                            self.ctx.local.reset()
+                            yield Stage.TEST_SUITE, InternalState.SETUP
+                        except IndexError:
+                            # No more test suites. We are done here.
+                            yield state[0], InternalState.TEARDOWN
+
+                    case Stage.TEST_SUITE, InternalState.SETUP:
+                        self.update_logger_stage(test_suite.name)
+                        test_suite.set_up_suite()
+
+                        test_suite_result.update_setup(Result.PASS)
+                        yield state[0], InternalState.RUN
+
+                    case Stage.TEST_SUITE, InternalState.RUN:
+                        if not blocked:
+                            self.update_logger_stage(test_suite.name)
+                        try:
+                            test_case = remaining_test_cases.popleft()
+                            test_case_result = test_suite_result.add_test_case(test_case.name)
+
+                            if blocked:
+                                test_case_result.update_setup(Result.BLOCK)
+                                continue
+
+                            test_if_supported(test_case, self.supported_capabilities)
+                            yield Stage.TEST_CASE, InternalState.SETUP
+                        except IndexError:
+                            if blocked and test_suite_result.setup_result.result is Result.BLOCK:
+                                # Skip teardown if the test case AND suite were blocked.
+                                yield state[0], InternalState.END
+                            else:
+                                # No more test cases. We are done here.
+                                yield state[0], InternalState.TEARDOWN
+
+                    case Stage.TEST_CASE, InternalState.SETUP:
+                        test_suite.set_up_test_case()
+                        remaining_attempts = self._max_retries
+
+                        test_case_result.update_setup(Result.PASS)
+                        yield state[0], InternalState.RUN
+
+                    case Stage.TEST_CASE, InternalState.RUN:
+                        self.logger.info(f"Running test case '{test_case.name}'.")
+                        run_test_case = MethodType(test_case, test_suite)
+                        run_test_case()
+
+                        test_case_result.update(Result.PASS)
+                        self.logger.info(f"Test case '{test_case.name}' execution PASSED.")
+                        yield state[0], InternalState.TEARDOWN
+
+                    case Stage.TEST_CASE, InternalState.TEARDOWN:
+                        test_suite.tear_down_test_case()
+
+                        test_case_result.update_teardown(Result.PASS)
+                        yield state[0], InternalState.END
+
+                    case Stage.TEST_CASE, InternalState.END:
+                        yield Stage.TEST_SUITE, InternalState.RUN
+
+                    case Stage.TEST_SUITE, InternalState.TEARDOWN:
+                        self.update_logger_stage(test_suite.name)
+                        test_suite.tear_down_suite()
+                        self.ctx.sut_node.kill_cleanup_dpdk_apps()
+
+                        test_suite_result.update_teardown(Result.PASS)
+                        yield state[0], InternalState.END
+
+                    case Stage.TEST_SUITE, InternalState.END:
+                        if test_suite_result.get_errors() and test_suite.is_blocking:
+                            self.logger.error(
+                                f"An error occurred within blocking {test_suite.name}. "
+                                "The remaining test suites will be skipped."
+                            )
+                            blocked = True
+                        yield Stage.TEST_RUN, InternalState.RUN
+
+                    case Stage.TEST_RUN, InternalState.TEARDOWN:
+                        self.update_logger_stage()
+                        self.teardown()
+                        yield Stage.TEST_RUN, InternalState.END
+
+                    case Stage.TEST_RUN, InternalState.END:
+                        running = False
+
+                    case _:
+                        raise InternalError("Illegal state entered. How did I get here?")
+
+            except TestCaseVerifyError as e:
+                self.logger.error(f"Test case '{test_case.name}' execution FAILED: {e}")
+
+                remaining_attempts -= 1
+                if remaining_attempts > 0:
+                    self.logger.info(f"Re-attempting. {remaining_attempts} attempts left.")
+                else:
+                    test_case_result.update(Result.FAIL, e)
+                    yield state[0], InternalState.TEARDOWN
+
+            except SkippedTestException as e:
+                if state[0] is Stage.TEST_RUN:
+                    who = "suite"
+                    name = test_suite.name
+                    result_handler: BaseResult = test_suite_result
+                else:
+                    who = "case"
+                    name = test_case.name
+                    result_handler = test_case_result
+                self.logger.info(f"Test {who} '{name}' execution SKIPPED with reason: {e}")
+                result_handler.update_setup(Result.SKIP)
+
+            except InternalError as e:
+                self.logger.error(
+                    "A critical error has occurred. Unrecoverable state reached, shutting down."
+                )
+                # TODO: Handle final test suite result!
+                raise e
+
+            except (KeyboardInterrupt, Exception) as e:
+                match state[0]:
+                    case Stage.TEST_RUN:
+                        stage_str = "run"
+                    case Stage.TEST_SUITE:
+                        stage_str = f"suite '{test_suite.name}'"
+                    case Stage.TEST_CASE:
+                        stage_str = f"case '{test_case.name}'"
+
+                match state[1]:
+                    case InternalState.SETUP:
+                        state_str = "setup"
+                        next_state = InternalState.TEARDOWN
+                    case InternalState.RUN:
+                        state_str = "execution"
+                        next_state = InternalState.TEARDOWN
+                    case InternalState.TEARDOWN:
+                        state_str = "teardown"
+                        next_state = InternalState.END
+
+                if isinstance(e, KeyboardInterrupt):
+                    msg = (
+                        f"Test {stage_str} {state_str} INTERRUPTED by user! "
+                        "Shutting down gracefully."
+                    )
+                    result = Result.BLOCK
+                    ex: Exception | None = None
+                    blocked = True
+                else:
+                    msg = (
+                        "An unexpected error has occurred "
+                        f"while running test {stage_str} {state_str}."
+                    )
+                    result = Result.ERROR
+                    ex = e
+
+                match state:
+                    case Stage.TEST_RUN, InternalState.SETUP:
+                        self.result.update_setup(result, ex)
+                    case Stage.TEST_RUN, InternalState.TEARDOWN:
+                        self.result.update_teardown(result, ex)
+                    case Stage.TEST_SUITE, InternalState.SETUP:
+                        test_suite_result.update_setup(result, ex)
+                    case Stage.TEST_SUITE, InternalState.TEARDOWN:
+                        test_suite_result.update_teardown(result, ex)
+                    case Stage.TEST_CASE, InternalState.SETUP:
+                        test_case_result.update_setup(result, ex)
+                    case Stage.TEST_CASE, InternalState.RUN:
+                        test_case_result.update(result, ex)
+                    case Stage.TEST_CASE, InternalState.TEARDOWN:
+                        test_case_result.update_teardown(result, ex)
+                    case _:
+                        if ex:
+                            raise InternalError(
+                                "An error was raised in un uncontrolled state."
+                            ) from ex
+
+                self.logger.error(msg)
+
+                if ex:
+                    self.logger.exception(ex)
+
+                if state[1] is InternalState.TEARDOWN:
+                    self.logger.warning(
+                        "The environment may have not been cleaned up correctly. "
+                        "The subsequent tests could be affected!"
+                    )
+
+                yield state[0], next_state
+
+    def setup(self) -> None:
+        """Setup the test run."""
+        self.logger.info(f"Running on SUT node '{self.ctx.sut_node.name}'.")
+        self.init_random_seed()
+        self._remaining_tests = deque(self.selected_tests)
+
+        self.ctx.sut_node.set_up_test_run(self.config, self.ctx.topology.sut_ports)
+        self.ctx.tg_node.set_up_test_run(self.config, self.ctx.topology.tg_ports)
+
+        self.result.ports = self.ctx.topology.sut_ports + self.ctx.topology.tg_ports
+        self.result.sut_info = self.ctx.sut_node.node_info
+        self.result.dpdk_build_info = self.ctx.sut_node.get_dpdk_build_info()
+
+        self.logger.debug(f"Found capabilities to check: {self.required_capabilities}")
+        self.supported_capabilities = get_supported_capabilities(
+            self.ctx.sut_node, self.ctx.topology, self.required_capabilities
+        )
+
+    def teardown(self) -> None:
+        """Teardown the test run."""
+        self.ctx.sut_node.tear_down_test_run(self.ctx.topology.sut_ports)
+        self.ctx.tg_node.tear_down_test_run(self.ctx.topology.tg_ports)
+
+    def update_logger_stage(self, file_name: str | None = None) -> None:
+        """Update the current stage of the logger."""
+        log_file_path = Path(SETTINGS.output_dir, file_name) if file_name is not None else None
+        self.logger.set_stage(self._state, log_file_path)
+
+    def init_random_seed(self) -> None:
+        """Initialize the random seed to use for the test run."""
+        seed = self.config.random_seed or random.randrange(0xFFFF_FFFF)
+        self.logger.info(f"Initializing with random seed {seed}.")
+        random.seed(seed)
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index 7b06ecd715..463fd69cd9 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 PANTHEON.tech s.r.o.
+# Copyright(c) 2025 Arm Limited
 
 """Testbed capabilities.
 
@@ -53,7 +54,7 @@ def test_scatter_mbuf_2048(self):
 
 from typing_extensions import Self
 
-from framework.exception import ConfigurationError
+from framework.exception import ConfigurationError, SkippedTestException
 from framework.logger import get_dts_logger
 from framework.remote_session.testpmd_shell import (
     NicCapability,
@@ -221,9 +222,7 @@ def get_supported_capabilities(
         )
         if cls.capabilities_to_check:
             capabilities_to_check_map = cls._get_decorated_capabilities_map()
-            with TestPmdShell(
-                sut_node, privileged=True, disable_device_start=True
-            ) as testpmd_shell:
+            with TestPmdShell() as testpmd_shell:
                 for (
                     conditional_capability_fn,
                     capabilities,
@@ -510,3 +509,20 @@ def get_supported_capabilities(
         supported_capabilities.update(callback(sut_node, topology_config))
 
     return supported_capabilities
+
+
+def test_if_supported(test: type[TestProtocol], supported_caps: set[Capability]) -> None:
+    """Test if the given test suite or test case is supported.
+
+    Args:
+        test: The test suite or case.
+        supported_caps: The capabilities that need to be checked against the test.
+
+    Raises:
+        SkippedTestException: If the test hasn't met the requirements.
+    """
+    unsupported_caps = test.required_capabilities - supported_caps
+    if unsupported_caps:
+        capability_str = "capabilities" if len(unsupported_caps) > 1 else "capability"
+        msg = f"Required {capability_str} '{unsupported_caps}' not found."
+        raise SkippedTestException(msg)
diff --git a/dts/framework/testbed_model/tg_node.py b/dts/framework/testbed_model/tg_node.py
index 595836a664..290a3fbd74 100644
--- a/dts/framework/testbed_model/tg_node.py
+++ b/dts/framework/testbed_model/tg_node.py
@@ -37,9 +37,11 @@ class TGNode(Node):
     must be a way to send traffic without that.
 
     Attributes:
+        config: The traffic generator node configuration.
         traffic_generator: The traffic generator running on the node.
     """
 
+    config: TGNodeConfiguration
     traffic_generator: CapturingTrafficGenerator
 
     def __init__(self, node_config: TGNodeConfiguration):
@@ -51,7 +53,6 @@ def __init__(self, node_config: TGNodeConfiguration):
             node_config: The TG node's test run configuration.
         """
         super().__init__(node_config)
-        self.traffic_generator = create_traffic_generator(self, node_config.traffic_generator)
         self._logger.info(f"Created node: {self.name}")
 
     def set_up_test_run(self, test_run_config: TestRunConfiguration, ports: Iterable[Port]) -> None:
@@ -64,6 +65,7 @@ def set_up_test_run(self, test_run_config: TestRunConfiguration, ports: Iterable
         """
         super().set_up_test_run(test_run_config, ports)
         self.main_session.bring_up_link(ports)
+        self.traffic_generator = create_traffic_generator(self, self.config.traffic_generator)
 
     def tear_down_test_run(self, ports: Iterable[Port]) -> None:
         """Extend the test run teardown with the teardown of the traffic generator.
@@ -72,6 +74,7 @@ def tear_down_test_run(self, ports: Iterable[Port]) -> None:
             ports: The ports to tear down for the test run.
         """
         super().tear_down_test_run(ports)
+        self.traffic_generator.close()
 
     def send_packets_and_capture(
         self,
@@ -119,5 +122,4 @@ def close(self) -> None:
 
         This extends the superclass method with TG cleanup.
         """
-        self.traffic_generator.close()
         super().close()
-- 
2.43.0

