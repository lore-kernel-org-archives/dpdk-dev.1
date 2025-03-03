Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8CAC282D1
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 14:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDB3540647;
	Mon,  3 Mar 2025 15:57:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2057640395
 for <dev@dpdk.org>; Mon,  3 Mar 2025 15:57:24 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5027106F;
 Mon,  3 Mar 2025 06:57:37 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.64.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D21623F66E;
 Mon,  3 Mar 2025 06:57:22 -0800 (PST)
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 5/7] dts: run only one test run per execution
Date: Mon,  3 Mar 2025 16:57:07 +0200
Message-ID: <20250303145709.126126-6-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303145709.126126-1-Luca.Vizzarro@arm.com>
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
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

From: Luca Vizzarro <luca.vizzarro@arm.com>

To aid configurability and flexibility both for the user and the
developer, make DTS run only one test run per execution.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 doc/guides/tools/dts.rst         | 18 ++++----
 dts/.gitignore                   |  2 +-
 dts/framework/config/__init__.py | 73 +++++++++++++++-----------------
 dts/framework/config/test_run.py | 15 +++----
 dts/framework/runner.py          | 14 +++---
 dts/framework/settings.py        | 16 +++----
 dts/test_run.example.yaml        | 43 +++++++++++++++++++
 dts/test_runs.example.yaml       | 43 -------------------
 dts/tests_config.example.yaml    |  0
 9 files changed, 107 insertions(+), 117 deletions(-)
 create mode 100644 dts/test_run.example.yaml
 delete mode 100644 dts/test_runs.example.yaml
 create mode 100644 dts/tests_config.example.yaml

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 097813e310..2affcf5d39 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -206,12 +206,12 @@ and then run the tests with the newly built binaries.
 Configuring DTS
 ~~~~~~~~~~~~~~~
 
-DTS configuration is split into nodes and test runs,
+DTS configuration is split into nodes and a test run,
 and must respect the model definitions
 as documented in the DTS API docs under the ``config`` page.
 The root of the configuration is represented by the ``Configuration`` model.
-By default, DTS will try to use the ``dts/test_runs.example.yaml``
-:ref:`config file <test_runs_configuration_example>`,
+By default, DTS will try to use the ``dts/test_run.example.yaml``
+:ref:`config file <test_run_configuration_example>`,
 and ``dts/nodes.example.yaml``
 :ref:`config file <nodes_configuration_example>`
 which are templates that illustrate what can be configured in DTS.
@@ -228,7 +228,7 @@ DTS is run with ``main.py`` located in the ``dts`` directory after entering Poet
 .. code-block:: console
 
    (dts-py3.10) $ ./main.py --help
-   usage: main.py [-h] [--test-runs-config-file FILE_PATH] [--nodes-config-file FILE_PATH] [--output-dir DIR_PATH] [-t SECONDS] [-v]
+   usage: main.py [-h] [--test-run-config-file FILE_PATH] [--nodes-config-file FILE_PATH] [--output-dir DIR_PATH] [-t SECONDS] [-v]
                   [--dpdk-tree DIR_PATH | --tarball FILE_PATH] [--remote-source] [--precompiled-build-dir DIR_NAME]
                   [--compile-timeout SECONDS] [--test-suite TEST_SUITE [TEST_CASES ...]] [--re-run N_TIMES] [--random-seed NUMBER]
 
@@ -237,8 +237,8 @@ DTS is run with ``main.py`` located in the ``dts`` directory after entering Poet
 
    options:
      -h, --help            show this help message and exit
-     --test-runs-config-file FILE_PATH
-                           [DTS_TEST_RUNS_CFG_FILE] The configuration file that describes the test cases and DPDK build options. (default: test-runs.conf.yaml)
+     --test-run-config-file FILE_PATH
+                           [DTS_TEST_RUN_CFG_FILE] The configuration file that describes the test cases and DPDK build options. (default: test-run.conf.yaml)
      --nodes-config-file FILE_PATH
                            [DTS_NODES_CFG_FILE] The configuration file that describes the SUT and TG nodes. (default: nodes.conf.yaml)
      --output-dir DIR_PATH, --output DIR_PATH
@@ -486,12 +486,12 @@ And they both have two network ports which are physically connected to each othe
    This example assumes that you have setup SSH keys in both the system under test
    and traffic generator nodes.
 
-.. _test_runs_configuration_example:
+.. _test_run_configuration_example:
 
-``dts/test_runs.example.yaml``
+``dts/test_run.example.yaml``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. literalinclude:: ../../../dts/test_runs.example.yaml
+.. literalinclude:: ../../../dts/test_run.example.yaml
    :language: yaml
    :start-at: # Define
 
diff --git a/dts/.gitignore b/dts/.gitignore
index d53a2f3b7e..96ee0b6ac4 100644
--- a/dts/.gitignore
+++ b/dts/.gitignore
@@ -1,4 +1,4 @@
 # default configuration files for DTS
 nodes.yaml
-test_runs.yaml
+test_run.yaml
 
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index c42eacb748..5495cfc5d5 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -13,7 +13,7 @@
 
 The configuration files are split in:
 
-    * A list of test run which are represented by :class:`~.test_run.TestRunConfiguration`
+    * The test run which is represented by :class:`~.test_run.TestRunConfiguration`
       defining what tests are going to be run and how DPDK will be built. It also references
       the testbed where these tests and DPDK are going to be run,
     * A list of the nodes of the testbed which ar represented by :class:`~.node.NodeConfiguration`.
@@ -40,16 +40,14 @@
 from .node import NodeConfiguration
 from .test_run import TestRunConfiguration
 
-TestRunsConfig = Annotated[list[TestRunConfiguration], Field(min_length=1)]
-
 NodesConfig = Annotated[list[NodeConfiguration], Field(min_length=1)]
 
 
 class Configuration(FrozenModel):
     """DTS testbed and test configuration."""
 
-    #: Test run configurations.
-    test_runs: TestRunsConfig
+    #: Test run configuration.
+    test_run: TestRunConfiguration
     #: Node configurations.
     nodes: NodesConfig
 
@@ -68,40 +66,36 @@ def validate_node_names(self) -> Self:
 
     @model_validator(mode="after")
     def validate_port_links(self) -> Self:
-        """Validate that all the test runs' port links are valid."""
+        """Validate that all of the test run's port links are valid."""
         existing_port_links: dict[tuple[str, str], Literal[False] | tuple[str, str]] = {
             (node.name, port.name): False for node in self.nodes for port in node.ports
         }
 
         defined_port_links = [
-            (test_run_idx, test_run, link_idx, link)
-            for test_run_idx, test_run in enumerate(self.test_runs)
-            for link_idx, link in enumerate(test_run.port_topology)
+            (link_idx, link) for link_idx, link in enumerate(self.test_run.port_topology)
         ]
-        for test_run_idx, test_run, link_idx, link in defined_port_links:
+        for link_idx, link in defined_port_links:
             sut_node_port_peer = existing_port_links.get(
-                (test_run.system_under_test_node, link.sut_port), None
-            )
-            assert sut_node_port_peer is not None, (
-                "Invalid SUT node port specified for link "
-                f"test_runs.{test_run_idx}.port_topology.{link_idx}."
+                (self.test_run.system_under_test_node, link.sut_port), None
             )
+            assert (
+                sut_node_port_peer is not None
+            ), f"Invalid SUT node port specified for link port_topology.{link_idx}."
 
             assert sut_node_port_peer is False or sut_node_port_peer == link.right, (
-                f"The SUT node port for link test_runs.{test_run_idx}.port_topology.{link_idx} is "
+                f"The SUT node port for link port_topology.{link_idx} is "
                 f"already linked to port {sut_node_port_peer[0]}.{sut_node_port_peer[1]}."
             )
 
             tg_node_port_peer = existing_port_links.get(
-                (test_run.traffic_generator_node, link.tg_port), None
-            )
-            assert tg_node_port_peer is not None, (
-                "Invalid TG node port specified for link "
-                f"test_runs.{test_run_idx}.port_topology.{link_idx}."
+                (self.test_run.traffic_generator_node, link.tg_port), None
             )
+            assert (
+                tg_node_port_peer is not None
+            ), f"Invalid TG node port specified for link port_topology.{link_idx}."
 
             assert tg_node_port_peer is False or sut_node_port_peer == link.left, (
-                f"The TG node port for link test_runs.{test_run_idx}.port_topology.{link_idx} is "
+                f"The TG node port for link port_topology.{link_idx} is "
                 f"already linked to port {tg_node_port_peer[0]}.{tg_node_port_peer[1]}."
             )
 
@@ -111,24 +105,21 @@ def validate_port_links(self) -> Self:
         return self
 
     @model_validator(mode="after")
-    def validate_test_runs_against_nodes(self) -> Self:
-        """Validate the test runs to nodes associations."""
-        for test_run_no, test_run in enumerate(self.test_runs):
-            sut_node_name = test_run.system_under_test_node
-            sut_node = next((n for n in self.nodes if n.name == sut_node_name), None)
-
-            assert sut_node is not None, (
-                f"Test run {test_run_no}.system_under_test_node "
-                f"({sut_node_name}) is not a valid node name."
-            )
+    def validate_test_run_against_nodes(self) -> Self:
+        """Validate the test run against the supplied nodes."""
+        sut_node_name = self.test_run.system_under_test_node
+        sut_node = next((n for n in self.nodes if n.name == sut_node_name), None)
 
-            tg_node_name = test_run.traffic_generator_node
-            tg_node = next((n for n in self.nodes if n.name == tg_node_name), None)
+        assert (
+            sut_node is not None
+        ), f"The system_under_test_node {sut_node_name} is not a valid node name."
 
-            assert tg_node is not None, (
-                f"Test run {test_run_no}.traffic_generator_name "
-                f"({tg_node_name}) is not a valid node name."
-            )
+        tg_node_name = self.test_run.traffic_generator_node
+        tg_node = next((n for n in self.nodes if n.name == tg_node_name), None)
+
+        assert (
+            tg_node is not None
+        ), f"The traffic_generator_name {tg_node_name} is not a valid node name."
 
         return self
 
@@ -160,10 +151,12 @@ def load_config(ctx: ValidationContext) -> Configuration:
     Raises:
         ConfigurationError: If the supplied configuration files are invalid.
     """
-    test_runs = _load_and_parse_model(ctx["settings"].test_runs_config_path, TestRunsConfig, ctx)
+    test_run = _load_and_parse_model(
+        ctx["settings"].test_run_config_path, TestRunConfiguration, ctx
+    )
     nodes = _load_and_parse_model(ctx["settings"].nodes_config_path, NodesConfig, ctx)
 
     try:
-        return Configuration.model_validate({"test_runs": test_runs, "nodes": nodes}, context=ctx)
+        return Configuration.model_validate({"test_run": test_run, "nodes": nodes}, context=ctx)
     except ValidationError as e:
         raise ConfigurationError("the configurations supplied are invalid") from e
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 1b3045730d..c1e534e480 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -206,14 +206,13 @@ class TestSuiteConfig(FrozenModel):
 
     .. code:: yaml
 
-        test_runs:
-        - test_suites:
-            # As string representation:
-            - hello_world # test all of `hello_world`, or
-            - hello_world hello_world_single_core # test only `hello_world_single_core`
-            # or as model fields:
-            - test_suite: hello_world
-              test_cases: [hello_world_single_core] # without this field all test cases are run
+        test_suites:
+        # As string representation:
+        - hello_world # test all of `hello_world`, or
+        - hello_world hello_world_single_core # test only `hello_world_single_core`
+        # or as model fields:
+        - test_suite: hello_world
+            test_cases: [hello_world_single_core] # without this field all test cases are run
     """
 
     #: The name of the test suite module without the starting ``TestSuite_``.
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index 801709a2aa..a0016d5d57 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -6,7 +6,7 @@
 
 """Test suite runner module.
 
-The module is responsible for preparing DTS and running the test runs.
+The module is responsible for preparing DTS and running the test run.
 """
 
 import os
@@ -47,8 +47,8 @@ def __init__(self):
     def run(self) -> None:
         """Run DTS.
 
-        Prepare all the nodes ahead of the test runs execution,
-        which are subsequently run as configured.
+        Prepare all the nodes ahead of the test run execution, which is subsequently run as
+        configured.
         """
         nodes: list[Node] = []
         try:
@@ -59,11 +59,9 @@ def run(self) -> None:
             for node_config in self._configuration.nodes:
                 nodes.append(Node(node_config))
 
-            # for all test run sections
-            for test_run_config in self._configuration.test_runs:
-                test_run_result = self._result.add_test_run(test_run_config)
-                test_run = TestRun(test_run_config, nodes, test_run_result)
-                test_run.spin()
+            test_run_result = self._result.add_test_run(self._configuration.test_run)
+            test_run = TestRun(self._configuration.test_run, nodes, test_run_result)
+            test_run.spin()
 
         except Exception as e:
             self._logger.exception("An unexpected error has occurred.")
diff --git a/dts/framework/settings.py b/dts/framework/settings.py
index cf82a7c18f..256afd5cfb 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -14,10 +14,10 @@
 
 The command line arguments along with the supported environment variables are:
 
-.. option:: --test-runs-config-file
-.. envvar:: DTS_TEST_RUNS_CFG_FILE
+.. option:: --test-run-config-file
+.. envvar:: DTS_TEST_RUN_CFG_FILE
 
-    The path to the YAML configuration file of the test runs.
+    The path to the YAML configuration file of the test run.
 
 .. option:: --nodes-config-file
 .. envvar:: DTS_NODES_CFG_FILE
@@ -125,7 +125,7 @@ class Settings:
     """
 
     #:
-    test_runs_config_path: Path = Path(__file__).parent.parent.joinpath("test_runs.yaml")
+    test_run_config_path: Path = Path(__file__).parent.parent.joinpath("test_run.yaml")
     #:
     nodes_config_path: Path = Path(__file__).parent.parent.joinpath("nodes.yaml")
     #:
@@ -323,14 +323,14 @@ def _get_parser() -> _DTSArgumentParser:
     )
 
     action = parser.add_argument(
-        "--test-runs-config-file",
-        default=SETTINGS.test_runs_config_path,
+        "--test-run-config-file",
+        default=SETTINGS.test_run_config_path,
         type=Path,
         help="The configuration file that describes the test cases and DPDK build options.",
         metavar="FILE_PATH",
-        dest="test_runs_config_path",
+        dest="test_run_config_path",
     )
-    _add_env_var_to_action(action, "TEST_RUNS_CFG_FILE")
+    _add_env_var_to_action(action, "TEST_RUN_CFG_FILE")
 
     action = parser.add_argument(
         "--nodes-config-file",
diff --git a/dts/test_run.example.yaml b/dts/test_run.example.yaml
new file mode 100644
index 0000000000..330a31bb18
--- /dev/null
+++ b/dts/test_run.example.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright 2022-2023 The DPDK contributors
+# Copyright 2023 Arm Limited
+
+# Define the test run environment
+dpdk:
+  lcores: "" # use all available logical cores (Skips first core)
+  memory_channels: 4 # tells DPDK to use 4 memory channels
+  build:
+    dpdk_location:
+      # dpdk_tree: Commented out because `tarball` is defined.
+      tarball: dpdk-tarball.tar.xz
+      # Either `dpdk_tree` or `tarball` can be defined, but not both.
+      remote: false # Optional, defaults to false. If it's true, the `dpdk_tree` or `tarball`
+                    # is located on the SUT node, instead of the execution host.
+
+    # precompiled_build_dir: Commented out because `build_options` is defined.
+    build_options:
+      # the combination of the following two makes CC="ccache gcc"
+      compiler: gcc
+      compiler_wrapper: ccache # Optional.
+    # If `precompiled_build_dir` is defined, DPDK has been pre-built and the build directory is
+    # in a subdirectory of DPDK tree root directory. Otherwise, will be using the `build_options`
+    # to build the DPDK from source. Either `precompiled_build_dir` or `build_options` can be
+    # defined, but not both.
+traffic_generator:
+  type: SCAPY
+perf: false # disable performance testing
+func: true # enable functional testing
+skip_smoke_tests: false # optional
+# by removing the `test_suites` field, this test run will run every test suite available
+test_suites: # the following test suites will be run in their entirety
+  - hello_world
+vdevs: # optional; if removed, vdevs won't be used in the execution
+  - "crypto_openssl"
+# The machine running the DPDK test executable
+system_under_test_node: "SUT 1"
+# Traffic generator node to use for this execution environment
+traffic_generator_node: "TG 1"
+port_topology:
+  - sut.port-0 <-> tg.port-0  # explicit link. `sut` and `tg` are special identifiers that refer
+                              # to the respective test run's configured nodes.
+  - port-1 <-> port-1         # implicit link, left side is always SUT, right side is always TG.
diff --git a/dts/test_runs.example.yaml b/dts/test_runs.example.yaml
deleted file mode 100644
index 4f225d1b82..0000000000
--- a/dts/test_runs.example.yaml
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2022-2023 The DPDK contributors
-# Copyright 2023 Arm Limited
-
-# Define one test run environment
-- dpdk:
-    lcores: "" # use all available logical cores (Skips first core)
-    memory_channels: 4 # tells DPDK to use 4 memory channels
-    build:
-      dpdk_location:
-        # dpdk_tree: Commented out because `tarball` is defined.
-        tarball: dpdk-tarball.tar.xz
-        # Either `dpdk_tree` or `tarball` can be defined, but not both.
-        remote: false # Optional, defaults to false. If it's true, the `dpdk_tree` or `tarball`
-                      # is located on the SUT node, instead of the execution host.
-
-      # precompiled_build_dir: Commented out because `build_options` is defined.
-      build_options:
-        # the combination of the following two makes CC="ccache gcc"
-        compiler: gcc
-        compiler_wrapper: ccache # Optional.
-      # If `precompiled_build_dir` is defined, DPDK has been pre-built and the build directory is
-      # in a subdirectory of DPDK tree root directory. Otherwise, will be using the `build_options`
-      # to build the DPDK from source. Either `precompiled_build_dir` or `build_options` can be
-      # defined, but not both.
-  traffic_generator:
-    type: SCAPY
-  perf: false # disable performance testing
-  func: true # enable functional testing
-  skip_smoke_tests: false # optional
-  # by removing the `test_suites` field, this test run will run every test suite available
-  test_suites: # the following test suites will be run in their entirety
-    - hello_world
-  vdevs: # optional; if removed, vdevs won't be used in the execution
-    - "crypto_openssl"
-  # The machine running the DPDK test executable
-  system_under_test_node: "SUT 1"
-  # Traffic generator node to use for this execution environment
-  traffic_generator_node: "TG 1"
-  port_topology:
-    - sut.port-0 <-> tg.port-0  # explicit link. `sut` and `tg` are special identifiers that refer
-                                # to the respective test run's configured nodes.
-    - port-1 <-> port-1         # implicit link, left side is always SUT, right side is always TG.
diff --git a/dts/tests_config.example.yaml b/dts/tests_config.example.yaml
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.43.0

