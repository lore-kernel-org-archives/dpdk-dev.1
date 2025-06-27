Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88568C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:13:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 099014067A;
	Fri, 27 Jun 2025 17:12:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 19F9C40667
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:12:55 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1250228FA;
 Fri, 27 Jun 2025 08:12:37 -0700 (PDT)
Received: from e132991.arm.com (unknown [10.57.84.101])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E77143F66E;
 Fri, 27 Jun 2025 08:12:52 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, Thomas Wilks <thomas.wilks@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH 2/2] dts: rework test results
Date: Fri, 27 Jun 2025 16:12:41 +0100
Message-ID: <20250627151241.335114-3-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627151241.335114-1-thomas.wilks@arm.com>
References: <20250627151241.335114-1-thomas.wilks@arm.com>
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

Refactor the DTS result recording system to use a hierarchical tree
structure based on `ResultNode` and `ResultLeaf`, replacing the prior flat
model of DTSResult, TestRunResult, and TestSuiteResult. This improves
clarity, composability, and enables consistent traversal and aggregation
of test outcomes.

Update all FSM states and the runner to build results directly into the
tree, capturing setup, teardown, and test outcomes uniformly. Errors are
now stored directly as exceptions and reduced into an exit code, and
summaries are generated using Pydantic-based serializers for JSON and text
output. Finally, a new textual result summary is generated showing the
result of all the steps.

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/framework/runner.py                      |  33 +-
 dts/framework/test_result.py                 | 882 +++++--------------
 dts/framework/test_run.py                    | 137 +--
 dts/framework/testbed_model/posix_session.py |   4 +-
 4 files changed, 337 insertions(+), 719 deletions(-)

diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index f20aa3576a..0a3d92b0c8 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -18,16 +18,10 @@
 from framework.test_run import TestRun
 from framework.testbed_model.node import Node
 
-from .config import (
-    Configuration,
-    load_config,
-)
+from .config import Configuration, load_config
 from .logger import DTSLogger, get_dts_logger
 from .settings import SETTINGS
-from .test_result import (
-    DTSResult,
-    Result,
-)
+from .test_result import ResultNode, TestRunResult
 
 
 class DTSRunner:
@@ -35,7 +29,7 @@ class DTSRunner:
 
     _configuration: Configuration
     _logger: DTSLogger
-    _result: DTSResult
+    _result: TestRunResult
 
     def __init__(self):
         """Initialize the instance with configuration, logger, result and string constants."""
@@ -54,7 +48,9 @@ def __init__(self):
         if not os.path.exists(SETTINGS.output_dir):
             os.makedirs(SETTINGS.output_dir)
         self._logger.add_dts_root_logger_handlers(SETTINGS.verbose, SETTINGS.output_dir)
-        self._result = DTSResult(SETTINGS.output_dir, self._logger)
+
+        test_suites_result = ResultNode(label="test_suites")
+        self._result = TestRunResult(test_suites=test_suites_result)
 
     def run(self) -> None:
         """Run DTS.
@@ -66,34 +62,30 @@ def run(self) -> None:
         try:
             # check the python version of the server that runs dts
             self._check_dts_python_version()
-            self._result.update_setup(Result.PASS)
 
             for node_config in self._configuration.nodes:
                 nodes.append(Node(node_config))
 
-            test_run_result = self._result.add_test_run(self._configuration.test_run)
             test_run = TestRun(
                 self._configuration.test_run,
                 self._configuration.tests_config,
                 nodes,
-                test_run_result,
+                self._result,
             )
             test_run.spin()
 
         except Exception as e:
-            self._logger.exception("An unexpected error has occurred.")
+            self._logger.exception("An unexpected error has occurred.", e)
             self._result.add_error(e)
-            # raise
 
         finally:
             try:
                 self._logger.set_stage("post_run")
                 for node in nodes:
                     node.close()
-                self._result.update_teardown(Result.PASS)
             except Exception as e:
-                self._logger.exception("The final cleanup of nodes failed.")
-                self._result.update_teardown(Result.ERROR, e)
+                self._logger.exception("The final cleanup of nodes failed.", e)
+                self._result.add_error(e)
 
         # we need to put the sys.exit call outside the finally clause to make sure
         # that unexpected exceptions will propagate
@@ -116,9 +108,6 @@ def _check_dts_python_version(self) -> None:
 
     def _exit_dts(self) -> None:
         """Process all errors and exit with the proper exit code."""
-        self._result.process()
-
         if self._logger:
             self._logger.info("DTS execution has ended.")
-
-        sys.exit(self._result.get_return_code())
+        sys.exit(self._result.process())
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index 7f576022c7..8ce6cc8fbf 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -7,723 +7,323 @@
 
 The results are recorded in a hierarchical manner:
 
-    * :class:`DTSResult` contains
     * :class:`TestRunResult` contains
-    * :class:`TestSuiteResult` contains
-    * :class:`TestCaseResult`
+    * :class:`ResultNode` may contain itself or
+    * :class:`ResultLeaf`
 
-Each result may contain multiple lower level results, e.g. there are multiple
-:class:`TestSuiteResult`\s in a :class:`TestRunResult`.
-The results have common parts, such as setup and teardown results, captured in :class:`BaseResult`,
-which also defines some common behaviors in its methods.
-
-Each result class has its own idiosyncrasies which they implement in overridden methods.
+Each result may contain many intermediate steps, e.g. there are multiple
+:class:`ResultNode`\s in a :class:`ResultNode`.
 
 The :option:`--output` command line argument and the :envvar:`DTS_OUTPUT_DIR` environment
 variable modify the directory where the files with results will be stored.
 """
 
-import json
-from collections.abc import MutableSequence
-from enum import Enum, auto
+import sys
+from collections import Counter
+from enum import IntEnum, auto
+from io import StringIO
 from pathlib import Path
-from typing import Any, Callable, TypedDict
+from typing import Any, ClassVar, Literal, TextIO, Union
+
+from pydantic import (
+    BaseModel,
+    ConfigDict,
+    Field,
+    computed_field,
+    field_serializer,
+    model_serializer,
+)
+from typing_extensions import OrderedDict
 
-from .config.test_run import TestRunConfiguration
-from .exception import DTSError, ErrorSeverity
-from .logger import DTSLogger
-from .remote_session.dpdk import DPDKBuildInfo
-from .testbed_model.os_session import OSSessionInfo
-from .testbed_model.port import Port
+from framework.remote_session.dpdk import DPDKBuildInfo
+from framework.settings import SETTINGS
+from framework.testbed_model.os_session import OSSessionInfo
 
+from .exception import DTSError, ErrorSeverity, InternalError
 
-class Result(Enum):
+
+class Result(IntEnum):
     """The possible states that a setup, a teardown or a test case may end up in."""
 
     #:
     PASS = auto()
     #:
-    FAIL = auto()
-    #:
-    ERROR = auto()
+    SKIP = auto()
     #:
     BLOCK = auto()
     #:
-    SKIP = auto()
+    FAIL = auto()
+    #:
+    ERROR = auto()
 
     def __bool__(self) -> bool:
         """Only :attr:`PASS` is True."""
         return self is self.PASS
 
 
-class TestCaseResultDict(TypedDict):
-    """Represents the `TestCaseResult` results.
-
-    Attributes:
-        test_case_name: The name of the test case.
-        result: The result name of the test case.
-    """
-
-    test_case_name: str
-    result: str
-
-
-class TestSuiteResultDict(TypedDict):
-    """Represents the `TestSuiteResult` results.
-
-    Attributes:
-        test_suite_name: The name of the test suite.
-        test_cases: A list of test case results contained in this test suite.
-    """
-
-    test_suite_name: str
-    test_cases: list[TestCaseResultDict]
-
-
-class TestRunResultDict(TypedDict, total=False):
-    """Represents the `TestRunResult` results.
-
-    Attributes:
-        compiler_version: The version of the compiler used for the DPDK build.
-        dpdk_version: The version of DPDK being tested.
-        ports: A list of ports associated with the test run.
-        test_suites: A list of test suite results included in this test run.
-        summary: A dictionary containing overall results, such as pass/fail counts.
-    """
-
-    compiler_version: str | None
-    dpdk_version: str | None
-    ports: list[dict[str, Any]]
-    test_suites: list[TestSuiteResultDict]
-    summary: dict[str, int | float]
-
+class ResultLeaf(BaseModel):
+    """Class representing a result in the results tree.
 
-class DtsRunResultDict(TypedDict):
-    """Represents the `DtsRunResult` results.
+    A leaf node that can contain the results for a :class:`~.test_suite.TestSuite`,
+    :class:`.test_suite.TestCase` or a DTS execution step.
 
     Attributes:
-        test_runs: A list of test run results.
-        summary: A summary dictionary containing overall statistics for the test runs.
+        result: The actual result.
+        reason: The reason of the result.
     """
 
-    test_runs: list[TestRunResultDict]
-    summary: dict[str, int | float]
-
-
-class FixtureResult:
-    """A record that stores the result of a setup or a teardown.
-
-    :attr:`~Result.FAIL` is a sensible default since it prevents false positives (which could happen
-    if the default was :attr:`~Result.PASS`).
-
-    Preventing false positives or other false results is preferable since a failure
-    is mostly likely to be investigated (the other false results may not be investigated at all).
-
-    Attributes:
-        result: The associated result.
-        error: The error in case of a failure.
-    """
+    model_config = ConfigDict(arbitrary_types_allowed=True)
 
     result: Result
-    error: Exception | None = None
-
-    def __init__(
-        self,
-        result: Result = Result.FAIL,
-        error: Exception | None = None,
-    ):
-        """Initialize the constructor with the fixture result and store a possible error.
-
-        Args:
-            result: The result to store.
-            error: The error which happened when a failure occurred.
-        """
-        self.result = result
-        self.error = error
-
-    def __bool__(self) -> bool:
-        """A wrapper around the stored :class:`Result`."""
-        return bool(self.result)
+    reason: DTSError | None = None
 
+    def __lt__(self, other):
+        """Compare another instance of the same class by :attr:`~ResultLeaf.result`."""
+        if isinstance(other, ResultLeaf):
+            return self.result < other.result
+        return True
 
-class BaseResult:
-    """Common data and behavior of DTS results.
+    def __eq__(self, other):
+        """Compare equality with compatible classes by :attr:`~ResultLeaf.result`."""
+        match other:
+            case ResultLeaf(result=result):
+                return self.result == result
+            case Result():
+                return self.result == other
+            case _:
+                return False
 
-    Stores the results of the setup and teardown portions of the corresponding stage.
-    The hierarchical nature of DTS results is captured recursively in an internal list.
-    A stage is each level in this particular hierarchy (pre-run or the top-most level,
-    test run, test suite and test case).
 
-    Attributes:
-        setup_result: The result of the setup of the particular stage.
-        teardown_result: The results of the teardown of the particular stage.
-        child_results: The results of the descendants in the results hierarchy.
-    """
-
-    setup_result: FixtureResult
-    teardown_result: FixtureResult
-    child_results: MutableSequence["BaseResult"]
-
-    def __init__(self):
-        """Initialize the constructor."""
-        self.setup_result = FixtureResult()
-        self.teardown_result = FixtureResult()
-        self.child_results = []
-
-    def update_setup(self, result: Result, error: Exception | None = None) -> None:
-        """Store the setup result.
-
-        If the result is :attr:`~Result.BLOCK`, :attr:`~Result.ERROR` or :attr:`~Result.FAIL`,
-        then the corresponding child results in result hierarchy
-        are also marked with :attr:`~Result.BLOCK`.
-
-        Args:
-            result: The result of the setup.
-            error: The error that occurred in case of a failure.
-        """
-        self.setup_result.result = result
-        self.setup_result.error = error
-
-        if result != Result.PASS:
-            result_to_mark = Result.BLOCK if result != Result.SKIP else Result.SKIP
-            self.update_teardown(result_to_mark)
-            self._mark_results(result_to_mark)
-
-    def _mark_results(self, result) -> None:
-        """Mark the child results or the result of the level itself as `result`.
-
-        The marking of results should be done in overloaded methods.
-        """
+ExecutionStep = Literal["setup", "teardown"]
+"""Predefined execution steps."""
 
-    def update_teardown(self, result: Result, error: Exception | None = None) -> None:
-        """Store the teardown result.
-
-        Args:
-            result: The result of the teardown.
-            error: The error that occurred in case of a failure.
-        """
-        self.teardown_result.result = result
-        self.teardown_result.error = error
-
-    def _get_setup_teardown_errors(self) -> list[Exception]:
-        errors = []
-        if self.setup_result.error:
-            errors.append(self.setup_result.error)
-        if self.teardown_result.error:
-            errors.append(self.teardown_result.error)
-        return errors
-
-    def _get_child_errors(self) -> list[Exception]:
-        return [error for child_result in self.child_results for error in child_result.get_errors()]
-
-    def get_errors(self) -> list[Exception]:
-        """Compile errors from the whole result hierarchy.
-
-        Returns:
-            The errors from setup, teardown and all errors found in the whole result hierarchy.
-        """
-        return self._get_setup_teardown_errors() + self._get_child_errors()
-
-    def to_dict(self):
-        """Convert the results hierarchy into a dictionary representation."""
-
-    def add_result(self, results: dict[str, int]):
-        """Collate the test case result to the given result hierarchy.
-
-        Args:
-            results: The dictionary in which results will be collated.
-        """
-        for child_result in self.child_results:
-            child_result.add_result(results)
-
-    def generate_pass_rate_dict(self, test_run_summary) -> dict[str, float]:
-        """Generate a dictionary with the PASS/FAIL ratio of all test cases.
-
-        Args:
-            test_run_summary: The summary dictionary containing test result counts.
-
-        Returns:
-            A dictionary with the PASS/FAIL ratio of all test cases.
-        """
-        cases_not_skipped = sum(
-            test_run_summary[result.name] for result in Result if result != Result.SKIP
-        )
-        return {"PASS_RATE": test_run_summary[Result.PASS.name] * 100.0 / max(cases_not_skipped, 1)}
-
-
-class DTSResult(BaseResult):
-    """Stores environment information and test results from a DTS run.
-
-        * Test run level information, such as testbed, the test suite list and
-          DPDK build compiler configuration,
-        * Test suite and test case results,
-        * All errors that are caught and recorded during DTS execution.
-
-    The information is stored hierarchically. This is the first level of the hierarchy
-    and as such is where the data form the whole hierarchy is collated or processed.
-
-    The internal list stores the results of all test runs.
-    """
-
-    _output_dir: str
-    _logger: DTSLogger
-    _errors: list[Exception]
-    _return_code: ErrorSeverity
-
-    def __init__(self, output_dir: str, logger: DTSLogger):
-        """Extend the constructor with top-level specifics.
-
-        Args:
-            output_dir: The directory where DTS logs and results are saved.
-            logger: The logger instance the whole result will use.
-        """
-        super().__init__()
-        self._output_dir = output_dir
-        self._logger = logger
-        self._errors = []
-        self._return_code = ErrorSeverity.NO_ERR
-
-    def add_test_run(self, test_run_config: TestRunConfiguration) -> "TestRunResult":
-        """Add and return the child result (test run).
-
-        Args:
-            test_run_config: A test run configuration.
-
-        Returns:
-            The test run's result.
-        """
-        result = TestRunResult(test_run_config)
-        self.child_results.append(result)
-        return result
-
-    def add_error(self, error: Exception) -> None:
-        """Record an error that occurred outside any test run.
-
-        Args:
-            error: The exception to record.
-        """
-        self._errors.append(error)
-
-    def process(self) -> None:
-        """Process the data after a whole DTS run.
-
-        The data is added to child objects during runtime and this object is not updated
-        at that time. This requires us to process the child data after it's all been gathered.
-
-        The processing gathers all errors and the statistics of test case results.
-        """
-        self._errors += self.get_errors()
-        if self._errors and self._logger:
-            self._logger.debug("Summary of errors:")
-            for error in self._errors:
-                self._logger.debug(repr(error))
-
-        TextSummary(self).save(Path(self._output_dir, "results_summary.txt"))
-        JsonResults(self).save(Path(self._output_dir, "results.json"))
-
-    def get_return_code(self) -> int:
-        """Go through all stored Exceptions and return the final DTS error code.
-
-        Returns:
-            The highest error code found.
-        """
-        for error in self._errors:
-            error_return_code = ErrorSeverity.GENERIC_ERR
-            if isinstance(error, DTSError):
-                error_return_code = error.severity
-
-            if error_return_code > self._return_code:
-                self._return_code = error_return_code
-
-        return int(self._return_code)
-
-    def to_dict(self) -> DtsRunResultDict:
-        """Convert DTS result into a dictionary format.
-
-        The dictionary contains test runs and summary of test runs.
-
-        Returns:
-            A dictionary representation of the DTS result
-        """
 
-        def merge_test_run_summaries(test_run_summaries: list[dict[str, int]]) -> dict[str, int]:
-            """Merge multiple test run summaries into one dictionary.
+class ResultNode(BaseModel):
+    """Class representing a node in the tree of results.
 
-            Args:
-                test_run_summaries: List of test run summary dictionaries.
-
-            Returns:
-                A merged dictionary containing the aggregated summary.
-            """
-            return {
-                key.name: sum(test_run_summary[key.name] for test_run_summary in test_run_summaries)
-                for key in Result
-            }
-
-        test_runs = [child.to_dict() for child in self.child_results]
-        test_run_summary = merge_test_run_summaries([test_run["summary"] for test_run in test_runs])
-
-        return {
-            "test_runs": test_runs,
-            "summary": test_run_summary | self.generate_pass_rate_dict(test_run_summary),
-        }
-
-
-class TestRunResult(BaseResult):
-    """The test run specific result.
-
-    The internal list stores the results of all test suites in a given test run.
+    Each node contains a label and a list of children, which can be either :class:`~.ResultNode`, or
+    :class:`~.ResultLeaf`. This node is serialized as a dictionary of the children. The key of each
+    child is either ``result`` in the case of a :class:`~.ResultLeaf`, or it is the value of
+    :attr:`~.ResultNode.label`.
 
     Attributes:
-        compiler_version: The DPDK build compiler version.
-        dpdk_version: The built DPDK version.
-        sut_os_name: The operating system of the SUT node.
-        sut_os_version: The operating system version of the SUT node.
-        sut_kernel_version: The operating system kernel version of the SUT node.
+        label: The name of the node.
+        children: A list of either :class:`~.ResultNode` or :class:`~.ResultLeaf`.
+        parent: The parent node, if any.
     """
 
-    _config: TestRunConfiguration
-    _ports: list[Port]
-    _sut_info: OSSessionInfo | None
-    _dpdk_build_info: DPDKBuildInfo | None
-
-    def __init__(self, test_run_config: TestRunConfiguration):
-        """Extend the constructor with the test run's config.
+    __ignore_steps: ClassVar[list[ExecutionStep]] = ["setup", "teardown"]
 
-        Args:
-            test_run_config: A test run configuration.
-        """
-        super().__init__()
-        self._config = test_run_config
-        self._ports = []
-        self._sut_info = None
-        self._dpdk_build_info = None
+    label: str
+    children: list[Union["ResultNode", ResultLeaf]] = Field(default_factory=list)
+    parent: Union["ResultNode", None] = None
 
-    def add_test_suite(self, test_suite_name: str) -> "TestSuiteResult":
-        """Add and return the child result (test suite).
+    def add_child(self, label: str) -> "ResultNode":
+        """Creates and append a child node to the model.
 
         Args:
-            test_suite_name: The test suite name.
-
-        Returns:
-            The test suite's result.
+            label: The name of the node.
         """
-        result = TestSuiteResult(test_suite_name)
-        self.child_results.append(result)
-        return result
+        child = ResultNode(label=label, parent=self)
+        self.children.append(child)
+        return child
 
-    @property
-    def ports(self) -> list[Port]:
-        """Get the list of ports associated with this test run."""
-        return self._ports
-
-    @ports.setter
-    def ports(self, ports: list[Port]) -> None:
-        """Set the list of ports associated with this test run.
+    def mark_result_as(self, result: Result, ex: Exception | None = None) -> None:
+        """Mark result for the current step.
 
         Args:
-            ports: The list of ports to associate with this test run.
-
-        Raises:
-            ValueError: If the ports have already been assigned to this test run.
+            result: The result of the current step.
+            ex: The exception if any occurred. If this is not an instance of DTSError, it is wrapped
+                with an InternalError.
         """
-        if self._ports:
-            raise ValueError(
-                "Attempted to assign `ports` to a test run result which already has `ports`."
-            )
-        self._ports = ports
-
-    @property
-    def sut_info(self) -> OSSessionInfo | None:
-        """Get the SUT OS session information associated with this test run."""
-        return self._sut_info
-
-    @sut_info.setter
-    def sut_info(self, sut_info: OSSessionInfo) -> None:
-        """Set the SUT node information associated with this test run.
-
-        Args:
-            sut_info: The SUT node information to associate with this test run.
-
-        Raises:
-            ValueError: If the SUT information has already been assigned to this test run.
-        """
-        if self._sut_info:
-            raise ValueError(
-                "Attempted to assign `sut_info` to a test run result which already has `sut_info`."
-            )
-        self._sut_info = sut_info
+        if ex is None or isinstance(ex, DTSError):
+            reason = ex
+        else:
+            reason = InternalError(f"Unhandled exception raised: {ex}")
 
-    @property
-    def dpdk_build_info(self) -> DPDKBuildInfo | None:
-        """Get the DPDK build information associated with this test run."""
-        return self._dpdk_build_info
+        result_leaf = next((child for child in self.children if type(child) is ResultLeaf), None)
+        if result_leaf:
+            result_leaf.result = result
+            result_leaf.reason = reason
+        else:
+            self.children.append(ResultLeaf(result=result, reason=reason))
 
-    @dpdk_build_info.setter
-    def dpdk_build_info(self, dpdk_build_info: DPDKBuildInfo) -> None:
-        """Set the DPDK build information associated with this test run.
+    def mark_step_as(
+        self, step: ExecutionStep, result: Result, ex: Exception | None = None
+    ) -> None:
+        """Mark an execution step with the given result.
 
         Args:
-            dpdk_build_info: The DPDK build information to associate with this test run.
-
-        Raises:
-            ValueError: If the DPDK build information has already been assigned to this test run.
-        """
-        if self._dpdk_build_info:
-            raise ValueError(
-                "Attempted to assign `dpdk_build_info` to a test run result which already "
-                "has `dpdk_build_info`."
+            step: Step to mark, e.g.: setup, teardown.
+            result: The result of the execution step.
+            ex: The exception if any occurred. If this is not an instance of DTSError, it is wrapped
+                with an InternalError.
+        """
+        try:
+            step_node = next(
+                child
+                for child in self.children
+                if type(child) is ResultNode and child.label == step
             )
-        self._dpdk_build_info = dpdk_build_info
-
-    def to_dict(self) -> TestRunResultDict:
-        """Convert the test run result into a dictionary.
-
-        The dictionary contains test suites in this test run, and a summary of the test run and
-        information about the DPDK version, compiler version and associated ports.
-
-        Returns:
-            TestRunResultDict: A dictionary representation of the test run result.
-        """
-        results = {result.name: 0 for result in Result}
-        self.add_result(results)
-
-        compiler_version = None
-        dpdk_version = None
-
-        if self.dpdk_build_info:
-            compiler_version = self.dpdk_build_info.compiler_version
-            dpdk_version = self.dpdk_build_info.dpdk_version
-
-        return {
-            "compiler_version": compiler_version,
-            "dpdk_version": dpdk_version,
-            "ports": [port.to_dict() for port in self.ports],
-            "test_suites": [child.to_dict() for child in self.child_results],
-            "summary": results | self.generate_pass_rate_dict(results),
-        }
-
-
-class TestSuiteResult(BaseResult):
-    """The test suite specific result.
-
-    The internal list stores the results of all test cases in a given test suite.
-
-    Attributes:
-        test_suite_name: The test suite name.
-    """
+        except StopIteration:
+            step_node = self.add_child(step)
+        step_node.mark_result_as(result, ex)
+
+    @model_serializer
+    def serialize_model(self) -> dict[str, Any]:
+        """Serializes model output."""
+        obj: dict[str, Any] = OrderedDict()
+
+        for child in self.children:
+            match child:
+                case ResultNode(label=label):
+                    obj[label] = child
+                case ResultLeaf(result=result, reason=reason):
+                    obj["result"] = result.name
+                    if reason is not None:
+                        obj["reason"] = str(reason)
+
+        return obj
+
+    def get_overall_result(self) -> ResultLeaf:
+        """The overall result of the underlying results."""
+
+        def extract_result(value: ResultNode | ResultLeaf) -> ResultLeaf:
+            match value:
+                case ResultNode():
+                    return value.get_overall_result()
+                case ResultLeaf():
+                    return value
+
+        return max(
+            (extract_result(child) for child in self.children),
+            default=ResultLeaf(result=Result.PASS),
+        )
 
-    test_suite_name: str
-    _child_configs: list[str]
+    def make_summary(self) -> Counter[Result]:
+        """Make the summary of the underlying results while ignoring special nodes."""
+        counter: Counter[Result] = Counter()
+        for child in self.children:
+            match child:
+                case ResultNode(label=label) if label not in self.__ignore_steps:
+                    counter += child.make_summary()
+                case ResultLeaf(result=result):
+                    counter[result] += 1
+        return counter
 
-    def __init__(self, test_suite_name: str):
-        """Extend the constructor with test suite's config.
+    def print_results(
+        self, file: TextIO = sys.stdout, indent_level: int = 0, indent_width: int = 2
+    ) -> None:
+        """Print the results in a textual tree format."""
 
-        Args:
-            test_suite_name: The test suite name.
-        """
-        super().__init__()
-        self.test_suite_name = test_suite_name
+        def indent(extra_level: int = 0) -> str:
+            return (indent_level + extra_level) * indent_width * " "
 
-    def add_test_case(self, test_case_name: str) -> "TestCaseResult":
-        """Add and return the child result (test case).
+        overall_result = self.get_overall_result()
+        if self.label in self.__ignore_steps and overall_result == Result.PASS:
+            return
 
-        Args:
-            test_case_name: The name of the test case.
+        print(f"{indent()}{self.label}: {overall_result.result.name}", file=file)
 
-        Returns:
-            The test case's result.
-        """
-        result = TestCaseResult(test_case_name)
-        self.child_results.append(result)
-        return result
-
-    def to_dict(self) -> TestSuiteResultDict:
-        """Convert the test suite result into a dictionary.
+        for child in self.children:
+            match child:
+                case ResultNode():
+                    child.print_results(file, indent_level + 1, indent_width)
+                case ResultLeaf(reason=reason) if reason is not None:
+                    # The result is already printed as part of `overall_result` above.
+                    print(f"{indent(1)}reason: {reason}", file=file)
 
-        The dictionary contains a test suite name and test cases given in this test suite.
-        """
-        return {
-            "test_suite_name": self.test_suite_name,
-            "test_cases": [child.to_dict() for child in self.child_results],
-        }
 
+class TestRunResult(BaseModel):
+    """Class representing the root node of the results tree.
 
-class TestCaseResult(BaseResult, FixtureResult):
-    r"""The test case specific result.
-
-    Stores the result of the actual test case. This is done by adding an extra superclass
-    in :class:`FixtureResult`. The setup and teardown results are :class:`FixtureResult`\s and
-    the class is itself a record of the test case.
+    Root node of the model containing metadata about the DPDK version, ports, compiler and
+    DTS execution results.
 
     Attributes:
-        test_case_name: The test case name.
-    """
-
-    test_case_name: str
-
-    def __init__(self, test_case_name: str):
-        """Extend the constructor with test case's name.
-
-        Args:
-            test_case_name: The test case's name.
-        """
-        super().__init__()
-        self.test_case_name = test_case_name
-
-    def update(self, result: Result, error: Exception | None = None) -> None:
-        """Update the test case result.
-
-        This updates the result of the test case itself and doesn't affect
-        the results of the setup and teardown steps in any way.
-
-        Args:
-            result: The result of the test case.
-            error: The error that occurred in case of a failure.
-        """
-        self.result = result
-        self.error = error
-
-    def _get_child_errors(self) -> list[Exception]:
-        if self.error:
-            return [self.error]
-        return []
-
-    def to_dict(self) -> TestCaseResultDict:
-        """Convert the test case result into a dictionary.
-
-        The dictionary contains a test case name and the result name.
-        """
-        return {"test_case_name": self.test_case_name, "result": self.result.name}
-
-    def add_result(self, results: dict[str, int]):
-        r"""Add the test case result to the results.
-
-        The base method goes through the hierarchy recursively and this method is here to stop
-        the recursion, as the :class:`TestCaseResult` are the leaves of the hierarchy tree.
-
-        Args:
-            results: The dictionary to which results will be collated.
-        """
-        results[self.result.name] += 1
-
-    def _mark_results(self, result) -> None:
-        r"""Mark the result as `result`."""
-        self.update(result)
-
-    def __bool__(self) -> bool:
-        """The test case passed only if setup, teardown and the test case itself passed."""
-        return bool(self.setup_result) and bool(self.teardown_result) and bool(self.result)
-
-
-class TextSummary:
-    """Generates and saves textual summaries of DTS run results.
-
-    The summary includes:
-    * Results of test cases,
-    * Compiler version of the DPDK build,
-    * DPDK version of the DPDK source tree,
-    * Overall summary of results when multiple test runs are present.
+        sut_session_info: The SUT node OS session information.
+        dpdk_build_info: The DPDK build information.
+        ports: The ports that were used in the test run.
+        test_suites: The test suites containing the results of DTS execution.
+        execution_errors: A list of errors that occur during DTS execution.
     """
 
-    _dict_result: DtsRunResultDict
-    _summary: dict[str, int | float]
-    _text: str
+    model_config = ConfigDict(arbitrary_types_allowed=True)
 
-    def __init__(self, dts_run_result: DTSResult):
-        """Initializes with a DTSResult object and converts it to a dictionary format.
+    json_filepath: ClassVar[Path] = Path(SETTINGS.output_dir, "results.json")
+    summary_filepath: ClassVar[Path] = Path(SETTINGS.output_dir, "results_summary.txt")
 
-        Args:
-            dts_run_result: The DTS result.
-        """
-        self._dict_result = dts_run_result.to_dict()
-        self._summary = self._dict_result["summary"]
-        self._text = ""
-
-    @property
-    def _outdent(self) -> str:
-        """Appropriate indentation based on multiple test run results."""
-        return "\t" if len(self._dict_result["test_runs"]) > 1 else ""
+    sut_session_info: OSSessionInfo | None = None
+    dpdk_build_info: DPDKBuildInfo | None = None
+    ports: list[dict[str, str]] | None = None
+    test_suites: ResultNode
+    execution_errors: list[DTSError] = Field(default_factory=list)
 
-    def save(self, output_path: Path):
-        """Generate and save text statistics to a file.
+    @field_serializer("execution_errors", when_used="json")
+    def serialize_errors(self, execution_errors: list[DTSError]) -> list[str]:
+        """Serialize errors as plain text."""
+        return [str(err) for err in execution_errors]
 
-        Args:
-            output_path: The path where the text file will be saved.
-        """
-        if self._dict_result["test_runs"]:
-            with open(f"{output_path}", "w") as fp:
-                self._add_test_runs_dict_decorator(self._add_test_run_dict)
-                fp.write(self._text)
-
-    def _add_test_runs_dict_decorator(self, func: Callable):
-        """Handles multiple test runs and appends results to the summary.
-
-        Adds headers for each test run and overall result when multiple
-        test runs are provided.
-
-        Args:
-            func: Function to process and add results from each test run.
-        """
-        if len(self._dict_result["test_runs"]) > 1:
-            for idx, test_run_result in enumerate(self._dict_result["test_runs"]):
-                self._text += f"TEST_RUN_{idx}\n"
-                func(test_run_result)
-
-            self._add_overall_results()
+    def add_error(self, ex: Exception) -> None:
+        """Add an execution error to the test run result."""
+        if isinstance(ex, DTSError):
+            self.execution_errors.append(ex)
         else:
-            func(self._dict_result["test_runs"][0])
-
-    def _add_test_run_dict(self, test_run_dict: TestRunResultDict):
-        """Adds the results and the test run attributes of a single test run to the summary.
+            self.execution_errors.append(InternalError(f"Unhandled exception raised: {ex}"))
 
-        Args:
-            test_run_dict: Dictionary containing the test run results.
-        """
-        self._add_column(
-            DPDK_VERSION=test_run_dict["dpdk_version"],
-            COMPILER_VERSION=test_run_dict["compiler_version"],
-            **test_run_dict["summary"],
+    @computed_field  # type: ignore[prop-decorator]
+    @property
+    def summary(self) -> dict[str, int]:
+        """The test cases result summary."""
+        summary = self.test_suites.make_summary()
+        total_without_skip = (
+            sum(total for result, total in summary.items() if result != Result.SKIP) or 1
         )
-        self._text += "\n"
-
-    def _add_column(self, **rows):
-        """Formats and adds key-value pairs to the summary text.
-
-        Handles cases where values might be None by replacing them with "N/A".
-
-        Args:
-            **rows: Arbitrary key-value pairs representing the result data.
-        """
-        rows = {k: "N/A" if v is None else v for k, v in rows.items()}
-        max_length = len(max(rows, key=len))
-        for key, value in rows.items():
-            self._text += f"{self._outdent}{key:<{max_length}} = {value}\n"
-
-    def _add_overall_results(self):
-        """Add overall summary of test runs."""
-        self._text += "OVERALL\n"
-        self._add_column(**self._summary)
-
 
-class JsonResults:
-    """Save DTS run result in JSON format."""
+        final_summary = OrderedDict((result.name, summary[result]) for result in Result)
+        final_summary["PASS_RATE"] = int(final_summary["PASS"] / total_without_skip * 100)
+        return final_summary
 
-    _dict_result: DtsRunResultDict
-
-    def __init__(self, dts_run_result: DTSResult):
-        """Initializes with a DTSResult object and converts it to a dictionary format.
-
-        Args:
-            dts_run_result: The DTS result.
-        """
-        self._dict_result = dts_run_result.to_dict()
-
-    def save(self, output_path: Path):
-        """Save the result to a file as JSON.
-
-        Args:
-            output_path: The path where the JSON file will be saved.
-        """
-        with open(f"{output_path}", "w") as fp:
-            json.dump(self._dict_result, fp, indent=4)
+    @property
+    def return_code(self) -> int:
+        """Gather all the errors and return a code by highest severity."""
+        codes = [err.severity for err in self.execution_errors]
+        if err := self.test_suites.get_overall_result().reason:
+            codes.append(err.severity)
+        return max(codes, default=ErrorSeverity.NO_ERR).value
+
+    def print_summary(self, file: TextIO = sys.stdout) -> None:
+        """Print out the textual summary."""
+        print("Results", file=file)
+        print("=======", file=file)
+        self.test_suites.print_results(file)
+        print(file=file)
+
+        print("Test Cases Summary", file=file)
+        print("==================", file=file)
+        summary = self.summary
+        padding = max(len(result_label) for result_label in self.summary.keys())
+        for result_label, total in summary.items():
+            if result_label == "PASS_RATE":
+                print(f"{'PASS RATE': <{padding}} = {total}%", file=file)
+            else:
+                print(f"{result_label: <{padding}} = {total}", file=file)
+
+    def dump_json(self, file: TextIO = sys.stdout, /, indent: int = 4) -> None:
+        """Dump the results as JSON."""
+        file.write(self.model_dump_json(indent=indent))
+
+    def process(self) -> int:
+        """Process and store all the results, and return the resulting exit code."""
+        with open(self.json_filepath, "w") as json_file:
+            self.dump_json(json_file)
+
+        summary = StringIO()
+        self.print_summary(summary)
+        with open(self.summary_filepath, "w") as summary_file:
+            summary_file.write(summary.getvalue())
+
+        print()
+        print(summary.getvalue())
+
+        return self.return_code
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index fd49a7dc74..d8a224117f 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -109,15 +109,11 @@
 
 from framework.config.test_run import TestRunConfiguration
 from framework.context import Context, init_ctx
-from framework.exception import (
-    InternalError,
-    SkippedTestException,
-    TestCaseVerifyError,
-)
+from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
-from framework.test_result import BaseResult, Result, TestCaseResult, TestRunResult, TestSuiteResult
+from framework.test_result import Result, ResultNode, TestRunResult
 from framework.test_suite import BaseConfig, TestCase, TestSuite
 from framework.testbed_model.capability import (
     Capability,
@@ -216,7 +212,7 @@ def __init__(
         self.remaining_test_cases = deque()
         self.supported_capabilities = set()
 
-        self.state = TestRunSetup(self, self.result)
+        self.state = TestRunSetup(self, result)
 
     @cached_property
     def required_capabilities(self) -> set[Capability]:
@@ -260,7 +256,7 @@ class State(Protocol):
 
     logger_name: ClassVar[str]
     test_run: TestRun
-    result: BaseResult
+    result: TestRunResult | ResultNode
 
     def before(self):
         """Hook before the state is processed."""
@@ -349,21 +345,22 @@ def next(self) -> State | None:
         test_run.ctx.topology.configure_ports("sut", "dpdk")
         test_run.ctx.tg.setup(test_run.ctx.topology)
 
-        self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
-        self.result.sut_info = test_run.ctx.sut_node.node_info
+        self.result.ports = [
+            port.to_dict()
+            for port in test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
+        ]
+        self.result.sut_session_info = test_run.ctx.sut_node.node_info
         self.result.dpdk_build_info = test_run.ctx.dpdk_build.get_dpdk_build_info()
 
         self.logger.debug(f"Found capabilities to check: {test_run.required_capabilities}")
         test_run.supported_capabilities = get_supported_capabilities(
             test_run.ctx.sut_node, test_run.ctx.topology, test_run.required_capabilities
         )
-
-        self.result.update_setup(Result.PASS)
         return TestRunExecution(test_run, self.result)
 
     def on_error(self, ex: Exception) -> State | None:
         """Next state on error."""
-        self.result.update_setup(Result.ERROR, ex)
+        self.test_run.result.add_error(ex)
         return TestRunTeardown(self.test_run, self.result)
 
 
@@ -387,11 +384,11 @@ def next(self) -> State | None:
             test_suite_class, test_config, test_run.remaining_test_cases = (
                 test_run.remaining_tests.popleft()
             )
-            test_suite = test_suite_class(test_config)
-            test_suite_result = test_run.result.add_test_suite(test_suite.name)
 
+            test_suite = test_suite_class(test_config)
+            test_suite_result = self.result.test_suites.add_child(test_suite.name)
             if test_run.blocked:
-                test_suite_result.update_setup(Result.BLOCK)
+                test_suite_result.mark_result_as(Result.BLOCK)
                 self.logger.warning(f"Test suite '{test_suite.name}' was BLOCKED.")
                 # Continue to allow the rest to mark as blocked, no need to setup.
                 return TestSuiteExecution(test_run, test_suite, test_suite_result)
@@ -399,10 +396,9 @@ def next(self) -> State | None:
             try:
                 test_if_supported(test_suite_class, test_run.supported_capabilities)
             except SkippedTestException as e:
-                self.logger.info(
-                    f"Test suite '{test_suite.name}' execution SKIPPED with reason: {e}"
-                )
-                test_suite_result.update_setup(Result.SKIP)
+                self.logger.info(f"Test suite '{test_suite.name}' execution SKIPPED: {e}")
+                test_suite_result.mark_result_as(Result.SKIP, e)
+
                 return self
 
             test_run.ctx.local.reset()
@@ -413,7 +409,7 @@ def next(self) -> State | None:
 
     def on_error(self, ex: Exception) -> State | None:
         """Next state on error."""
-        self.result.update_setup(Result.ERROR, ex)
+        self.test_run.result.add_error(ex)
         return TestRunTeardown(self.test_run, self.result)
 
 
@@ -438,12 +434,11 @@ def next(self) -> State | None:
         self.test_run.ctx.dpdk.teardown()
         self.test_run.ctx.tg_node.teardown()
         self.test_run.ctx.sut_node.teardown()
-        self.result.update_teardown(Result.PASS)
         return None
 
     def on_error(self, ex: Exception) -> State | None:
         """Next state on error."""
-        self.result.update_teardown(Result.ERROR, ex)
+        self.test_run.result.add_error(ex)
         self.logger.warning(
             "The environment may have not been cleaned up correctly. "
             "The subsequent tests could be affected!"
@@ -457,7 +452,7 @@ class TestSuiteState(State):
 
     test_run: TestRun
     test_suite: TestSuite
-    result: TestSuiteResult
+    result: ResultNode
 
     def get_log_file_name(self) -> str | None:
         """Get the log file name."""
@@ -482,12 +477,16 @@ def next(self) -> State | None:
         self.test_run.ctx.topology.configure_ports("sut", sut_ports_drivers)
 
         self.test_suite.set_up_suite()
-        self.result.update_setup(Result.PASS)
-        return TestSuiteExecution(self.test_run, self.test_suite, self.result)
+        self.result.mark_step_as("setup", Result.PASS)
+        return TestSuiteExecution(
+            test_run=self.test_run,
+            test_suite=self.test_suite,
+            result=self.result,
+        )
 
     def on_error(self, ex: Exception) -> State | None:
         """Next state on error."""
-        self.result.update_setup(Result.ERROR, ex)
+        self.result.mark_step_as("setup", Result.ERROR, ex)
         return TestSuiteTeardown(self.test_run, self.test_suite, self.result)
 
 
@@ -506,25 +505,31 @@ def next(self) -> State | None:
         """Next state."""
         try:
             test_case = self.test_run.remaining_test_cases.popleft()
-            test_case_result = self.result.add_test_case(test_case.name)
-
+            test_case_result = self.result.add_child(test_case.name)
             if self.test_run.blocked:
-                test_case_result.update_setup(Result.BLOCK)
+                test_case_result.mark_result_as(Result.BLOCK)
                 self.logger.warning(f"Test case '{test_case.name}' execution was BLOCKED.")
-                return TestSuiteExecution(self.test_run, self.test_suite, self.result)
+                return TestSuiteExecution(
+                    test_run=self.test_run,
+                    test_suite=self.test_suite,
+                    result=self.result,
+                )
 
             try:
                 test_if_supported(test_case, self.test_run.supported_capabilities)
             except SkippedTestException as e:
-                self.logger.info(f"Test case '{test_case.name}' execution SKIPPED with reason: {e}")
-                test_case_result.update_setup(Result.SKIP)
+                self.logger.info(f"Test case '{test_case.name}' execution SKIPPED: {e}")
+                test_case_result.mark_result_as(Result.SKIP, e)
                 return self
 
             return TestCaseSetup(
-                self.test_run, self.test_suite, self.result, test_case, test_case_result
+                self.test_run,
+                self.test_suite,
+                test_case,
+                test_case_result,
             )
         except IndexError:
-            if self.test_run.blocked and self.result.setup_result.result is Result.BLOCK:
+            if self.test_run.blocked and self.result.get_overall_result() == Result.BLOCK:
                 # Skip teardown if the test case AND suite were blocked.
                 return TestRunExecution(self.test_run, self.test_run.result)
             else:
@@ -533,7 +538,7 @@ def next(self) -> State | None:
 
     def on_error(self, ex: Exception) -> State | None:
         """Next state on error."""
-        self.result.update_setup(Result.ERROR, ex)
+        self.test_run.result.add_error(ex)
         return TestSuiteTeardown(self.test_run, self.test_suite, self.result)
 
 
@@ -553,7 +558,7 @@ def next(self) -> State | None:
         self.test_suite.tear_down_suite()
         self.test_run.ctx.dpdk.kill_cleanup_dpdk_apps()
         self.test_run.ctx.shell_pool.terminate_current_pool()
-        self.result.update_teardown(Result.PASS)
+        self.result.mark_step_as("teardown", Result.PASS)
         return TestRunExecution(self.test_run, self.test_run.result)
 
     def on_error(self, ex: Exception) -> State | None:
@@ -562,12 +567,15 @@ def on_error(self, ex: Exception) -> State | None:
             "The environment may have not been cleaned up correctly. "
             "The subsequent tests could be affected!"
         )
-        self.result.update_teardown(Result.ERROR, ex)
+        self.result.mark_step_as("teardown", Result.ERROR, ex)
         return TestRunExecution(self.test_run, self.test_run.result)
 
     def after(self):
         """Hook after state is processed."""
-        if self.result.get_errors() and self.test_suite.is_blocking:
+        if (
+            self.result.get_overall_result() in [Result.FAIL, Result.ERROR]
+            and self.test_suite.is_blocking
+        ):
             self.logger.warning(
                 f"An error occurred within blocking {self.test_suite.name}. "
                 "The remaining test suites will be skipped."
@@ -581,9 +589,8 @@ class TestCaseState(State):
 
     test_run: TestRun
     test_suite: TestSuite
-    test_suite_result: TestSuiteResult
     test_case: type[TestCase]
-    result: TestCaseResult
+    result: ResultNode
 
     def get_log_file_name(self) -> str | None:
         """Get the log file name."""
@@ -610,11 +617,10 @@ def next(self) -> State | None:
         self.test_run.ctx.topology.configure_ports("sut", sut_ports_drivers)
 
         self.test_suite.set_up_test_case()
-        self.result.update_setup(Result.PASS)
+        self.result.mark_step_as("setup", Result.PASS)
         return TestCaseExecution(
             self.test_run,
             self.test_suite,
-            self.test_suite_result,
             self.test_case,
             self.result,
             SETTINGS.re_run,
@@ -622,9 +628,13 @@ def next(self) -> State | None:
 
     def on_error(self, ex: Exception) -> State | None:
         """Next state on error."""
-        self.result.update_setup(Result.ERROR, ex)
+        self.result.mark_step_as("setup", Result.ERROR, ex)
+        self.result.mark_result_as(Result.BLOCK)
         return TestCaseTeardown(
-            self.test_run, self.test_suite, self.test_suite_result, self.test_case, self.result
+            self.test_run,
+            self.test_suite,
+            self.test_case,
+            self.result,
         )
 
 
@@ -654,23 +664,29 @@ def next(self) -> State | None:
                 self.logger.info(f"Re-attempting. {self.reattempts_left} attempts left.")
                 return self
 
-            self.result.update(Result.FAIL, e)
+            self.result.mark_result_as(Result.FAIL, e)
         except SkippedTestException as e:
             self.logger.info(f"{self.description.capitalize()} SKIPPED: {e}")
-            self.result.update(Result.SKIP, e)
+            self.result.mark_result_as(Result.SKIP, e)
         else:
-            self.result.update(Result.PASS)
+            self.result.mark_result_as(Result.PASS)
             self.logger.info(f"{self.description.capitalize()} PASSED.")
 
         return TestCaseTeardown(
-            self.test_run, self.test_suite, self.test_suite_result, self.test_case, self.result
+            self.test_run,
+            self.test_suite,
+            self.test_case,
+            self.result,
         )
 
     def on_error(self, ex: Exception) -> State | None:
         """Next state on error."""
-        self.result.update(Result.ERROR, ex)
+        self.result.mark_result_as(Result.ERROR, ex)
         return TestCaseTeardown(
-            self.test_run, self.test_suite, self.test_suite_result, self.test_case, self.result
+            self.test_run,
+            self.test_suite,
+            self.test_case,
+            self.result,
         )
 
 
@@ -689,8 +705,13 @@ def next(self) -> State | None:
         """Next state."""
         self.test_suite.tear_down_test_case()
         self.test_run.ctx.shell_pool.terminate_current_pool()
-        self.result.update_teardown(Result.PASS)
-        return TestSuiteExecution(self.test_run, self.test_suite, self.test_suite_result)
+        self.result.mark_step_as("teardown", Result.PASS)
+        assert self.result.parent is not None
+        return TestSuiteExecution(
+            test_run=self.test_run,
+            test_suite=self.test_suite,
+            result=self.result.parent,
+        )
 
     def on_error(self, ex: Exception) -> State | None:
         """Next state on error."""
@@ -698,5 +719,11 @@ def on_error(self, ex: Exception) -> State | None:
             "The environment may have not been cleaned up correctly. "
             "The subsequent tests could be affected!"
         )
-        self.result.update_teardown(Result.ERROR, ex)
-        return TestSuiteExecution(self.test_run, self.test_suite, self.test_suite_result)
+        self.result.mark_step_as("teardown", Result.ERROR, ex)
+
+        assert self.result.parent is not None
+        return TestSuiteExecution(
+            test_run=self.test_run,
+            test_suite=self.test_suite,
+            result=self.result.parent,
+        )
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index e35ae6179b..c71bc93f0b 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -425,7 +425,9 @@ def get_node_info(self) -> OSSessionInfo:
             SETTINGS.timeout,
         ).stdout.split("\n")
         kernel_version = self.send_command("uname -r", SETTINGS.timeout).stdout
-        return OSSessionInfo(os_release_info[0].strip(), os_release_info[1].strip(), kernel_version)
+        return OSSessionInfo(
+            os_release_info[0].strip('"'), os_release_info[1].strip('"'), kernel_version
+        )
 
     def get_arch_info(self) -> str:
         """Overrides :meth'~.os_session.OSSession.get_arch_info'."""
-- 
2.43.0

