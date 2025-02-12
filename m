Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B0AC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:46:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD47442E56;
	Wed, 12 Feb 2025 17:46:12 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1E6CD42707
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:46:08 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9672212FC;
 Wed, 12 Feb 2025 08:46:28 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.11.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C6CAD3F5A1;
 Wed, 12 Feb 2025 08:46:06 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Nicholas Pratte <npratte@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 2/7] dts: isolate test specification to config
Date: Wed, 12 Feb 2025 16:45:55 +0000
Message-ID: <20250212164600.23759-3-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212164600.23759-1-luca.vizzarro@arm.com>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250212164600.23759-1-luca.vizzarro@arm.com>
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

In an effort to improve separation of concerns, make the TestRunConfig
class responsible for processing the configured test suites. Moreover,
give TestSuiteConfig a facility to yield references to the selected test
cases.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/config/__init__.py | 84 +++++++++++---------------------
 dts/framework/config/test_run.py | 59 +++++++++++++++++-----
 2 files changed, 76 insertions(+), 67 deletions(-)

diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index 79f8141ef6..273a5cc3a7 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -27,9 +27,8 @@
       and makes it thread safe should we ever want to move in that direction.
 """
 
-from functools import cached_property
 from pathlib import Path
-from typing import Annotated, Any, Literal, NamedTuple, TypeVar, cast
+from typing import Annotated, Any, Literal, TypeVar, cast
 
 import yaml
 from pydantic import Field, TypeAdapter, ValidationError, model_validator
@@ -45,18 +44,6 @@
 )
 from .test_run import TestRunConfiguration
 
-
-class TestRunWithNodesConfiguration(NamedTuple):
-    """Tuple containing the configuration of the test run and its associated nodes."""
-
-    #:
-    test_run_config: TestRunConfiguration
-    #:
-    sut_node_config: SutNodeConfiguration
-    #:
-    tg_node_config: TGNodeConfiguration
-
-
 TestRunsConfig = Annotated[list[TestRunConfiguration], Field(min_length=1)]
 
 NodesConfig = Annotated[list[NodeConfigurationTypes], Field(min_length=1)]
@@ -70,40 +57,6 @@ class Configuration(FrozenModel):
     #: Node configurations.
     nodes: NodesConfig
 
-    @cached_property
-    def test_runs_with_nodes(self) -> list[TestRunWithNodesConfiguration]:
-        """List of test runs with the associated nodes."""
-        test_runs_with_nodes = []
-
-        for test_run_no, test_run in enumerate(self.test_runs):
-            sut_node_name = test_run.system_under_test_node
-            sut_node = next(filter(lambda n: n.name == sut_node_name, self.nodes), None)
-
-            assert sut_node is not None, (
-                f"test_runs.{test_run_no}.sut_node_config.node_name "
-                f"({test_run.system_under_test_node}) is not a valid node name"
-            )
-            assert isinstance(sut_node, SutNodeConfiguration), (
-                f"test_runs.{test_run_no}.sut_node_config.node_name is a valid node name, "
-                "but it is not a valid SUT node"
-            )
-
-            tg_node_name = test_run.traffic_generator_node
-            tg_node = next(filter(lambda n: n.name == tg_node_name, self.nodes), None)
-
-            assert tg_node is not None, (
-                f"test_runs.{test_run_no}.tg_node_name "
-                f"({test_run.traffic_generator_node}) is not a valid node name"
-            )
-            assert isinstance(tg_node, TGNodeConfiguration), (
-                f"test_runs.{test_run_no}.tg_node_name is a valid node name, "
-                "but it is not a valid TG node"
-            )
-
-            test_runs_with_nodes.append(TestRunWithNodesConfiguration(test_run, sut_node, tg_node))
-
-        return test_runs_with_nodes
-
     @model_validator(mode="after")
     def validate_node_names(self) -> Self:
         """Validate that the node names are unique."""
@@ -162,14 +115,33 @@ def validate_port_links(self) -> Self:
         return self
 
     @model_validator(mode="after")
-    def validate_test_runs_with_nodes(self) -> Self:
-        """Validate the test runs to nodes associations.
-
-        This validator relies on the cached property `test_runs_with_nodes` to run for the first
-        time in this call, therefore triggering the assertions if needed.
-        """
-        if self.test_runs_with_nodes:
-            pass
+    def validate_test_runs_against_nodes(self) -> Self:
+        """Validate the test runs to nodes associations."""
+        for test_run_no, test_run in enumerate(self.test_runs):
+            sut_node_name = test_run.system_under_test_node
+            sut_node = next((n for n in self.nodes if n.name == sut_node_name), None)
+
+            assert sut_node is not None, (
+                f"Test run {test_run_no}.system_under_test_node "
+                f"({sut_node_name}) is not a valid node name."
+            )
+            assert isinstance(sut_node, SutNodeConfiguration), (
+                f"Test run {test_run_no}.system_under_test_node is a valid node name, "
+                "but it is not a valid SUT node."
+            )
+
+            tg_node_name = test_run.traffic_generator_node
+            tg_node = next((n for n in self.nodes if n.name == tg_node_name), None)
+
+            assert tg_node is not None, (
+                f"Test run {test_run_no}.traffic_generator_name "
+                f"({tg_node_name}) is not a valid node name."
+            )
+            assert isinstance(tg_node, TGNodeConfiguration), (
+                f"Test run {test_run_no}.traffic_generator_name is a valid node name, "
+                "but it is not a valid TG node."
+            )
+
         return self
 
 
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 3d73fb31bb..eef01d0340 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -11,6 +11,8 @@
 
 import re
 import tarfile
+from collections import deque
+from collections.abc import Iterable
 from enum import auto, unique
 from functools import cached_property
 from pathlib import Path, PurePath
@@ -25,7 +27,7 @@
 from .common import FrozenModel, load_fields_from_settings
 
 if TYPE_CHECKING:
-    from framework.test_suite import TestSuiteSpec
+    from framework.test_suite import TestCase, TestSuite, TestSuiteSpec
 
 
 @unique
@@ -231,6 +233,21 @@ def test_suite_spec(self) -> "TestSuiteSpec":
         ), f"{self.test_suite_name} is not a valid test suite module name."
         return test_suite_spec
 
+    @cached_property
+    def test_cases(self) -> list[type["TestCase"]]:
+        """The objects of the selected test cases."""
+        available_test_cases = {t.name: t for t in self.test_suite_spec.class_obj.get_test_cases()}
+        selected_test_cases = []
+
+        for requested_test_case in self.test_cases_names:
+            assert requested_test_case in available_test_cases, (
+                f"{requested_test_case} is not a valid test case "
+                f"of test suite {self.test_suite_name}."
+            )
+            selected_test_cases.append(available_test_cases[requested_test_case])
+
+        return selected_test_cases or list(available_test_cases.values())
+
     @model_validator(mode="before")
     @classmethod
     def convert_from_string(cls, data: Any) -> Any:
@@ -244,17 +261,11 @@ def convert_from_string(cls, data: Any) -> Any:
     def validate_names(self) -> Self:
         """Validate the supplied test suite and test cases names.
 
-        This validator relies on the cached property `test_suite_spec` to run for the first
-        time in this call, therefore triggering the assertions if needed.
+        This validator relies on the cached properties `test_suite_spec` and `test_cases` to run for
+        the first time in this call, therefore triggering the assertions if needed.
         """
-        available_test_cases = map(
-            lambda t: t.name, self.test_suite_spec.class_obj.get_test_cases()
-        )
-        for requested_test_case in self.test_cases_names:
-            assert requested_test_case in available_test_cases, (
-                f"{requested_test_case} is not a valid test case "
-                f"of test suite {self.test_suite_name}."
-            )
+        if self.test_cases:
+            pass
 
         return self
 
@@ -381,3 +392,29 @@ class TestRunConfiguration(FrozenModel):
     fields_from_settings = model_validator(mode="before")(
         load_fields_from_settings("test_suites", "random_seed")
     )
+
+    def filter_tests(
+        self,
+    ) -> Iterable[tuple[type["TestSuite"], deque[type["TestCase"]]]]:
+        """Filter test suites and cases selected for execution."""
+        from framework.test_suite import TestCaseType
+
+        test_suites = [TestSuiteConfig(test_suite="smoke_tests")]
+
+        if self.skip_smoke_tests:
+            test_suites = self.test_suites
+        else:
+            test_suites += self.test_suites
+
+        return (
+            (
+                t.test_suite_spec.class_obj,
+                deque(
+                    tt
+                    for tt in t.test_cases
+                    if (tt.test_type is TestCaseType.FUNCTIONAL and self.func)
+                    or (tt.test_type is TestCaseType.PERFORMANCE and self.perf)
+                ),
+            )
+            for t in test_suites
+        )
-- 
2.43.0

