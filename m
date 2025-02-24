Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFAEC021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 13:30:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59C9441132;
	Mon, 24 Feb 2025 14:30:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E072D41060
 for <dev@dpdk.org>; Mon, 24 Feb 2025 14:30:10 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1612D1477;
 Mon, 24 Feb 2025 05:30:27 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB2DD3F5A1;
 Mon, 24 Feb 2025 05:30:09 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 4/6] dts: decouple DPDK runtime from build
Date: Mon, 24 Feb 2025 13:28:21 +0000
Message-ID: <20250224132823.196509-5-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224132823.196509-1-luca.vizzarro@arm.com>
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
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

Allow the DPDKRuntimeEnvironment to work without an associated DPDK
build. This is useful when executing any program that is based on DPDK,
so that the common runtime functionality can be shared.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/context.py                   |  3 ++-
 dts/framework/remote_session/dpdk.py       | 29 +++++++++++++++-------
 dts/framework/remote_session/dpdk_shell.py |  2 +-
 dts/framework/test_run.py                  |  6 +++--
 dts/tests/TestSuite_smoke_tests.py         |  2 +-
 dts/tests/TestSuite_softnic.py             |  2 +-
 6 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/dts/framework/context.py b/dts/framework/context.py
index 8adffff57f..ddd7ed4d36 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -14,7 +14,7 @@
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
-    from framework.remote_session.dpdk import DPDKRuntimeEnvironment
+    from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
     from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
 P = ParamSpec("P")
@@ -66,6 +66,7 @@ class Context:
     sut_node: Node
     tg_node: Node
     topology: Topology
+    dpdk_build: "DPDKBuildEnvironment"
     dpdk: "DPDKRuntimeEnvironment"
     tg: "TrafficGenerator"
     local: LocalContext = field(default_factory=LocalContext)
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index f75ec353ed..50c22769c1 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -24,7 +24,7 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
-from framework.exception import ConfigurationError, RemoteFileNotFoundError
+from framework.exception import ConfigurationError, InternalError, RemoteFileNotFoundError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
@@ -367,7 +367,7 @@ class DPDKRuntimeEnvironment:
     """Class handling a DPDK runtime environment."""
 
     config: Final[DPDKRuntimeConfiguration]
-    build: Final[DPDKBuildEnvironment]
+    build: Final[DPDKBuildEnvironment | None]
     _node: Final[Node]
     _logger: Final[DTSLogger]
 
@@ -383,14 +383,14 @@ def __init__(
         self,
         config: DPDKRuntimeConfiguration,
         node: Node,
-        build_env: DPDKBuildEnvironment,
+        build_env: DPDKBuildEnvironment | None = None,
     ):
         """DPDK environment constructor.
 
         Args:
             config: The configuration of DPDK.
             node: The target node to manage a DPDK environment.
-            build_env: The DPDK build environment.
+            build_env: The DPDK build environment, if any.
         """
         self.config = config
         self.build = build_env
@@ -417,13 +417,15 @@ def __init__(
 
     def setup(self, ports: Iterable[Port]):
         """Set up the DPDK runtime on the target node."""
-        self.build.setup()
+        if self.build:
+            self.build.setup()
         self.bind_ports_to_driver(ports)
 
     def teardown(self, ports: Iterable[Port]) -> None:
         """Reset DPDK variables and bind port driver to the OS driver."""
         self.bind_ports_to_driver(ports, for_dpdk=False)
-        self.build.teardown()
+        if self.build:
+            self.build.teardown()
 
     def run_dpdk_app(
         self, app_path: PurePath, eal_params: EalParams, timeout: float = 30
@@ -467,9 +469,18 @@ def bind_ports_to_driver(self, ports: Iterable[Port], for_dpdk: bool = True) ->
 
     @cached_property
     def devbind_script_path(self) -> PurePath:
-        """The path to the dpdk-devbind.py script on the node."""
-        return self._node.main_session.join_remote_path(
-            self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
+        """The path to the dpdk-devbind.py script on the node.
+
+        Raises:
+            InternalError: If attempting to retrieve the devbind script in a build-less runtime.
+        """
+        if self.build:
+            return self._node.main_session.join_remote_path(
+                self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
+            )
+
+        raise InternalError(
+            "DPDK runtime is not associated with any DPDK build. Can't retrieve dpdk-devbind.py."
         )
 
     def filter_lcores(
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index fc43448e06..0962414876 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -79,5 +79,5 @@ def _update_real_path(self, path: PurePath) -> None:
         Adds the remote DPDK build directory to the path.
         """
         super()._update_real_path(
-            PurePath(get_ctx().dpdk.build.remote_dpdk_build_dir).joinpath(path)
+            PurePath(get_ctx().dpdk_build.remote_dpdk_build_dir).joinpath(path)
         )
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 69cc76bc25..84d8fb26ac 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -199,7 +199,9 @@ def __init__(self, config: TestRunConfiguration, nodes: Iterable[Node], result:
         dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
         traffic_generator = create_traffic_generator(config.traffic_generator, tg_node)
 
-        self.ctx = Context(sut_node, tg_node, topology, dpdk_runtime_env, traffic_generator)
+        self.ctx = Context(
+            sut_node, tg_node, topology, dpdk_build_env, dpdk_runtime_env, traffic_generator
+        )
         self.result = result
         self.selected_tests = list(self.config.filter_tests())
         self.blocked = False
@@ -339,7 +341,7 @@ def next(self) -> State | None:
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
         self.result.sut_info = test_run.ctx.sut_node.node_info
-        self.result.dpdk_build_info = test_run.ctx.dpdk.build.get_dpdk_build_info()
+        self.result.dpdk_build_info = test_run.ctx.dpdk_build.get_dpdk_build_info()
 
         self.logger.debug(f"Found capabilities to check: {test_run.required_capabilities}")
         test_run.supported_capabilities = get_supported_capabilities(
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index cc24dd01f4..274ada0202 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -47,7 +47,7 @@ def set_up_suite(self) -> None:
             Set the build directory path and a list of NICs in the SUT node.
         """
         self.sut_node = self._ctx.sut_node  # FIXME: accessing the context should be forbidden
-        self.dpdk_build_dir_path = self._ctx.dpdk.build.remote_dpdk_build_dir
+        self.dpdk_build_dir_path = self._ctx.dpdk_build.remote_dpdk_build_dir
         self.nics_in_node = [p.config for p in self.topology.sut_ports]
 
     @func_test
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index eefd6d3273..9cd4e37746 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -46,7 +46,7 @@ def prepare_softnic_files(self) -> PurePath:
         spec_file = Path("rx_tx.spec")
         rx_tx_1_file = Path("rx_tx_1.io")
         rx_tx_2_file = Path("rx_tx_2.io")
-        path_sut = self._ctx.dpdk.build.remote_dpdk_build_dir
+        path_sut = self._ctx.dpdk_build.remote_dpdk_build_dir
         cli_file_sut = self.sut_node.main_session.join_remote_path(path_sut, cli_file)
         spec_file_sut = self.sut_node.main_session.join_remote_path(path_sut, spec_file)
         rx_tx_1_file_sut = self.sut_node.main_session.join_remote_path(path_sut, rx_tx_1_file)
-- 
2.43.0

