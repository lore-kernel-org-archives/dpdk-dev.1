Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2649DC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:28:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B29D40268;
	Wed,  8 Jul 2026 16:28:45 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6FCEC40265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 16:28:43 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-92e5d6f35c1so62491485a.0
 for <dev@dpdk.org>; Wed, 08 Jul 2026 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783520923; x=1784125723; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2o647gLfLsWkSVcqjKfNMU8g4qc3TTXNDlmnhKQlhcQ=;
 b=Uio7kfM+76yl5ptA1fHJ+ijLO5y98dyfYAgWuKrMGxOIwbSKMKB9imerCclTbLYjAf
 H2w8t78UcV8dDSyewVEfAhSCSjIy4X4d/b8E1JCNCjhGu3vK5YDotYwSBksB2wilhEqr
 u5XcsWwYwECwiavH8lPW9vTcRb321eJ9syxcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783520923; x=1784125723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2o647gLfLsWkSVcqjKfNMU8g4qc3TTXNDlmnhKQlhcQ=;
 b=AuAa9rJOwNbT4cSrJJgBOT+1C/8XEckgjGqKZeyCGgPUZtWGPReEoZweb9yb0h477h
 dpkmEiJfBhY6aQ8HbUbCNrwAOuOX54G+TpfOyqYc9zzQ/ZjFoZhdTDjDIx5L0PCSie2Y
 yG0Wlp+MqC/KV0qJ/0qhbll9K6LpcVoposDgZoJPLe0CKeQ2bSfXygIEarNnj4N7Oh8/
 QuZ0fWiMgUNtysQPkY36l5SWCCpjw1B2USV0HpnUbz/aOozNGORiJZzNoP/kEQ8e/vh5
 jV/Qu8FsB+cN8aVE4f4rfBQ40od/A2iBH+Vyb4uegvmHrVZWO55Zc0eIQhu00CBgxyaA
 QjEg==
X-Gm-Message-State: AOJu0Yxa99n0ggkcYaGY1yzfu4Z+7WcXrp5hHs9WH11/fYUHZy4lnRj6
 oDgAYoS7rAvJEE5gc1FbHaFEJvNqbmP/K3SrSjLGGmfKMXIKmnIRqQrGPRfcaFbYxBzMFIm9zbF
 SWzYMeLoE9ONOHzyB/q0aYi8svPMH6yLzXicVxj5jQRab17D128mzjQpnyRHv8vdqje6aklgiKi
 SxF1PouhqTM5kcmge3c+KNIVAprCY=
X-Gm-Gg: AfdE7cnuRq9XT+8sjZTWu+cYh+nNMKxHU576D2WRsy9Zb3Ipu34JvjynfBsctAVD3f9
 +CSk89OGR7rARn2v5dv96yG+tk7/6twPR5ezqXYS8tSA0JdyZa1zPVzuER89YPXFqQPBeVZ8HPE
 PSE2T9IOTTr7aNDpc1OomcDSapbhLjZCpF9tRcjTaOVs6WJ5DrzZfJMwrnrb3r6x75oNy/IVaYw
 9a3m5qF6s/THR/TtCgFWecjQShTuPkSVYqN4td++WmJnt/gSYPKUPlkPB5f5jvGh1VtPtM9GsTn
 mZE2qa9kcIMn5FuN303/QhB8xoL0fI3pUxqBc2GbxJfe7l4dlgtYBaU6hjzEzqYrKPHxsWc0XMj
 YjbZhdJnGPQoImq8VpEm7iLNW5gq1c6mdjRO2qjMhImujVtceKOCdJ/EFqe8NVwAbgTbGX1QlEl
 My5t9gU/rKISCQaB2r8GvoEa9dZH7904aSIP4pZWEQ6p9KFT6GA5oRTXSriY+QZ3Kj
X-Received: by 2002:a05:620a:1986:b0:92e:c118:18b3 with SMTP id
 af79cd13be357-92ecf941f5emr301822485a.82.1783520922115; 
 Wed, 08 Jul 2026 07:28:42 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210:5d7f:246:cd51:1b62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471815818sm188001796d6.31.2026.07.08.07.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:28:41 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5] dts: add support for no link topology
Date: Wed,  8 Jul 2026 10:28:35 -0400
Message-ID: <20260708142835.780873-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260220192510.37163-1-abailey@iol.unh.edu>
References: <20260220192510.37163-1-abailey@iol.unh.edu>
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

Add support for running DTS with no traffic generator node and no ethdev
interfaces. Some applications, like dpdk-test-crypto-perf run without
ethdev interfaces and no traffic generator. In these cases, it is
beneficial to remove the overhead of creating a node and ports that are
not used. The specified build option for ice devices is removed since
the query to sut port ingress causes python to crash when there are no
ports. Notably, since this is only the case in which there are no ports,
traffic will not be sent and therefore the build argument is not
required. For these reasons it is skipped when running a no-link
topology.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---

v4:
* Made it possible to run no link topology even if a TG node is
  present in the config.
* Updated the test run example config file to properly document how no
  link topology is run.
v5:
* Rebased on main to resolve merge conflicts
* Ran the format script with the new updated tooling

 dts/api/test.py                          | 11 ++-
 dts/configurations/test_run.example.yaml |  7 +-
 dts/framework/config/__init__.py         | 36 ++++-----
 dts/framework/config/test_run.py         |  4 +-
 dts/framework/context.py                 |  2 +-
 dts/framework/remote_session/dpdk.py     |  4 +-
 dts/framework/runner.py                  |  6 +-
 dts/framework/test_run.py                | 95 ++++++++++++++----------
 dts/framework/testbed_model/topology.py  | 17 ++++-
 dts/tests/TestSuite_cryptodev_latency.py |  4 +-
 10 files changed, 111 insertions(+), 75 deletions(-)

diff --git a/dts/api/test.py b/dts/api/test.py
index e17babe0ca..7947c407d2 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -10,6 +10,7 @@
 from datetime import datetime

 from api.artifact import Artifact
+from api.capabilities import LinkTopology
 from framework.context import get_ctx
 from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger
@@ -109,12 +110,14 @@ def fail(failure_description: str) -> None:
     Raises:
         TestCaseVerifyError: Always raised to indicate the test case failed.
     """
+    ctx = get_ctx()
     get_logger().debug("A test case failed, showing the last 10 commands executed on SUT:")
-    for command_res in get_ctx().sut_node.main_session.remote_session.history[-10:]:
-        get_logger().debug(command_res.command)
-    get_logger().debug("A test case failed, showing the last 10 commands executed on TG:")
-    for command_res in get_ctx().tg_node.main_session.remote_session.history[-10:]:
+    for command_res in ctx.sut_node.main_session.remote_session.history[-10:]:
         get_logger().debug(command_res.command)
+    if ctx.topology.type is not LinkTopology.NO_LINK and ctx.tg_node is not None:
+        get_logger().debug("A test case failed, showing the last 10 commands executed on TG:")
+        for command_res in ctx.tg_node.main_session.remote_session.history[-10:]:
+            get_logger().debug(command_res.command)
     raise TestCaseVerifyError(failure_description)


diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index ee641f5dce..127aa51152 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -25,6 +25,9 @@
 #       By removing the `test_suites` field, this test run will run every test suite available.
 #   `vdevs`:
 #       Uncomment to add a specific virtual device to run on the SUT node.
+#   `port_topology`:
+#   	By providing an empty list, DTS will run in no link topology mode and will not allocate a TG
+#   	node.

 # Define the test run environment
 dpdk:
@@ -58,8 +61,8 @@ test_suites: # see `Optional Fields`; the following test suites will be run in t
 # The machine running the DPDK test executable
 system_under_test_node: "SUT 1"
 # Traffic generator node to use for this execution environment
-traffic_generator_node: "TG 1"
-port_topology:
+traffic_generator_node: "TG 1" # see
+port_topology: # see `Optional Fields`
   - sut.port-0 <-> tg.port-0  # explicit link. `sut` and `tg` are special identifiers that refer
                               # to the respective test run's configured nodes.
   - port-1 <-> port-1         # implicit link, left side is always SUT, right side is always TG.
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index a8861894b7..573f55471a 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -94,17 +94,19 @@ def validate_port_links(self) -> Self:
                 f"already linked to port {sut_node_port_peer[0]}.{sut_node_port_peer[1]}."
             )

-            tg_node_port_peer = existing_port_links.get(
-                (self.test_run.traffic_generator_node, link.tg_port), None
-            )
-            assert tg_node_port_peer is not None, (
-                f"Invalid TG node port specified for link port_topology.{link_idx}."
-            )
-
-            assert tg_node_port_peer is False or sut_node_port_peer == link.left, (
-                f"The TG node port for link port_topology.{link_idx} is "
-                f"already linked to port {tg_node_port_peer[0]}.{tg_node_port_peer[1]}."
-            )
+            if self.test_run.port_topology != []:
+                assert self.test_run.traffic_generator_node is not None, "No TG node specified."
+                tg_node_port_peer = existing_port_links.get(
+                    (self.test_run.traffic_generator_node, link.tg_port), None
+                )
+                assert tg_node_port_peer is not None, (
+                    f"Invalid TG node port specified for link port_topology.{link_idx}."
+                )
+
+                assert tg_node_port_peer is False or sut_node_port_peer == link.left, (
+                    f"The TG node port for link port_topology.{link_idx} is "
+                    f"already linked to port {tg_node_port_peer[0]}.{tg_node_port_peer[1]}."
+                )

             existing_port_links[link.left] = link.right
             existing_port_links[link.right] = link.left
@@ -121,13 +123,13 @@ def validate_test_run_against_nodes(self) -> Self:
             f"The system_under_test_node {sut_node_name} is not a valid node name."
         )

-        tg_node_name = self.test_run.traffic_generator_node
-        tg_node = next((n for n in self.nodes if n.name == tg_node_name), None)
-
-        assert tg_node is not None, (
-            f"The traffic_generator_name {tg_node_name} is not a valid node name."
-        )
+        if self.test_run.port_topology != []:
+            tg_node_name = self.test_run.traffic_generator_node
+            tg_node = next((n for n in self.nodes if n.name == tg_node_name), None)

+            assert tg_node is not None, (
+                f"The traffic_generator_name {tg_node_name} is not a valid node name."
+            )
         return self


diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 3cd643981d..81630df77d 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -492,11 +492,11 @@ class TestRunConfiguration(FrozenModel):
     #: The SUT node name to use in this test run.
     system_under_test_node: str
     #: The TG node name to use in this test run.
-    traffic_generator_node: str
+    traffic_generator_node: str | None = Field(default=None)
     #: The seed to use for pseudo-random generation.
     random_seed: int | None = None
     #: The port links between the specified nodes to use.
-    port_topology: list[PortLinkConfig] = Field(max_length=2)
+    port_topology: list[PortLinkConfig] = Field(default=[], max_length=2)

     fields_from_settings = model_validator(mode="before")(
         load_fields_from_settings("test_suites", "random_seed")
diff --git a/dts/framework/context.py b/dts/framework/context.py
index efe9af0645..b1c36f90a6 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -72,7 +72,7 @@ class Context:
     """Runtime context."""

     sut_node: Node
-    tg_node: Node
+    tg_node: Node | None
     topology: Topology
     dpdk_build: "DPDKBuildEnvironment"
     dpdk: "DPDKRuntimeEnvironment"
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index c3575cfcaf..e43e1f2123 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -13,6 +13,7 @@
 from pathlib import Path, PurePath
 from typing import ClassVar, Final

+from api.capabilities import LinkTopology
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -263,7 +264,8 @@ def _build_dpdk(self) -> None:
         ctx = get_ctx()
         # If the SUT is an ice driver device, make sure to build with 16B descriptors.
         if (
-            ctx.topology.sut_port_ingress
+            ctx.topology.type is not LinkTopology.NO_LINK
+            and ctx.topology.sut_port_ingress
             and ctx.topology.sut_port_ingress.config.os_driver == "ice"
         ):
             meson_args = MesonArgs(
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index 6ea4749ff4..fa4f06844e 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -61,7 +61,11 @@ def run(self) -> None:
             self._check_dts_python_version()

             for node_config in self._configuration.nodes:
-                nodes.append(Node(node_config))
+                if self._configuration.test_run.port_topology == []:
+                    if node_config.name == self._configuration.test_run.system_under_test_node:
+                        nodes.append(Node(node_config))
+                else:
+                    nodes.append(Node(node_config))

             test_run = TestRun(
                 self._configuration.test_run,
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 94dc6023a7..9b973532da 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -106,6 +106,7 @@
 from types import MethodType
 from typing import ClassVar, Protocol, Union

+from api.capabilities import LinkTopology
 from framework.config.test_run import TestRunConfiguration
 from framework.context import Context, init_ctx
 from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
@@ -190,24 +191,33 @@ def __init__(
         self.logger = get_dts_logger()

         sut_node = next(n for n in nodes if n.name == config.system_under_test_node)
-        tg_node = next(n for n in nodes if n.name == config.traffic_generator_node)
-
-        topology = Topology.from_port_links(
-            PortLink(sut_node.ports_by_name[link.sut_port], tg_node.ports_by_name[link.tg_port])
-            for link in self.config.port_topology
-        )
+        if config.port_topology != []:
+            tg_node = next(n for n in nodes if n.name == config.traffic_generator_node)
+            topology = Topology.from_port_links(
+                PortLink(sut_node.ports_by_name[link.sut_port], tg_node.ports_by_name[link.tg_port])
+                for link in self.config.port_topology
+            )
+        else:
+            tg_node = None
+            topology = Topology.from_port_links(iter([]))

         dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
         dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)

         func_traffic_generator = (
             create_traffic_generator(config.func_traffic_generator, tg_node)
-            if config.func and config.func_traffic_generator
+            if config.func
+            and config.func_traffic_generator
+            and topology.type is not LinkTopology.NO_LINK
+            and tg_node is not None
             else None
         )
         perf_traffic_generator = (
             create_traffic_generator(config.perf_traffic_generator, tg_node)
-            if config.perf and config.perf_traffic_generator
+            if config.perf
+            and config.perf_traffic_generator
+            and topology.type is not LinkTopology.NO_LINK
+            and tg_node is not None
             else None
         )

@@ -336,39 +346,40 @@ def description(self) -> str:
     def next(self) -> State | None:
         """Process state and return the next one."""
         test_run = self.test_run
-        init_ctx(test_run.ctx)
+        ctx = test_run.ctx
+        init_ctx(ctx)

-        self.logger.info(f"Running on SUT node '{test_run.ctx.sut_node.name}'.")
+        self.logger.info(f"Running on SUT node '{ctx.sut_node.name}'.")
         test_run.init_random_seed()
         test_run.remaining_tests = deque(test_run.selected_tests)

-        test_run.ctx.sut_node.setup()
-        test_run.ctx.tg_node.setup()
-        test_run.ctx.dpdk.setup()
-        test_run.ctx.topology.setup()
+        ctx.sut_node.setup()
+        if ctx.topology.type is not LinkTopology.NO_LINK and ctx.tg_node is not None:
+            ctx.tg_node.setup()
+        ctx.dpdk.setup()
+        ctx.topology.setup()

         if test_run.config.use_virtual_functions:
-            test_run.ctx.topology.instantiate_vf_ports()
-        if test_run.ctx.sut_node.cryptodevs and test_run.config.crypto:
-            test_run.ctx.topology.instantiate_crypto_ports()
-            test_run.ctx.topology.bind_cryptodevs("dpdk")
+            ctx.topology.instantiate_vf_ports()
+        if ctx.sut_node.cryptodevs and test_run.config.crypto:
+            ctx.topology.instantiate_crypto_ports()
+            ctx.topology.bind_cryptodevs("dpdk")

-        test_run.ctx.topology.configure_ports("sut", "dpdk")
-        if test_run.ctx.func_tg:
-            test_run.ctx.func_tg.setup(test_run.ctx.topology)
-        if test_run.ctx.perf_tg:
-            test_run.ctx.perf_tg.setup(test_run.ctx.topology)
+        ctx.topology.configure_ports("sut", "dpdk")
+        if ctx.func_tg and ctx.topology.type is not LinkTopology.NO_LINK:
+            ctx.func_tg.setup(ctx.topology)
+        if ctx.perf_tg and ctx.topology.type is not LinkTopology.NO_LINK:
+            ctx.perf_tg.setup(ctx.topology)

         self.result.ports = [
-            port.to_dict()
-            for port in test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
+            port.to_dict() for port in ctx.topology.sut_ports + ctx.topology.tg_ports
         ]
-        self.result.sut_session_info = test_run.ctx.sut_node.node_info
-        self.result.dpdk_build_info = test_run.ctx.dpdk_build.get_dpdk_build_info()
+        self.result.sut_session_info = ctx.sut_node.node_info
+        self.result.dpdk_build_info = ctx.dpdk_build.get_dpdk_build_info()

         self.logger.debug(f"Found capabilities to check: {test_run.required_capabilities}")
         test_run.supported_capabilities = get_supported_capabilities(
-            test_run.ctx.sut_node, test_run.ctx.topology, test_run.required_capabilities
+            ctx.sut_node, ctx.topology, test_run.required_capabilities
         )
         return TestRunExecution(test_run, self.result)

@@ -443,20 +454,22 @@ def description(self) -> str:

     def next(self) -> State | None:
         """Next state."""
+        ctx = self.test_run.ctx
         if self.test_run.config.use_virtual_functions:
-            self.test_run.ctx.topology.delete_vf_ports()
-        if self.test_run.ctx.sut_node.cryptodevs:
-            self.test_run.ctx.topology.delete_crypto_vf_ports()
-
-        self.test_run.ctx.shell_pool.terminate_current_pool()
-        if self.test_run.ctx.func_tg and self.test_run.ctx.func_tg.is_setup:
-            self.test_run.ctx.func_tg.teardown()
-        if self.test_run.ctx.perf_tg and self.test_run.ctx.perf_tg.is_setup:
-            self.test_run.ctx.perf_tg.teardown()
-        self.test_run.ctx.topology.teardown()
-        self.test_run.ctx.dpdk.teardown()
-        self.test_run.ctx.tg_node.teardown()
-        self.test_run.ctx.sut_node.teardown()
+            ctx.topology.delete_vf_ports()
+        if ctx.sut_node.cryptodevs:
+            ctx.topology.delete_crypto_vf_ports()
+
+        ctx.shell_pool.terminate_current_pool()
+        if ctx.func_tg is not None and ctx.func_tg.is_setup:
+            ctx.func_tg.teardown()
+        if ctx.perf_tg is not None and ctx.perf_tg.is_setup:
+            ctx.perf_tg.teardown()
+        ctx.topology.teardown()
+        ctx.dpdk.teardown()
+        if ctx.topology.type is not LinkTopology.NO_LINK and ctx.tg_node is not None:
+            ctx.tg_node.teardown()
+        ctx.sut_node.teardown()
         return None

     def on_error(self, ex: BaseException) -> State | None:
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 34862c4d2e..1db444fc01 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -73,6 +73,8 @@ def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
             ConfigurationError: If an unsupported link topology is supplied.
         """
         type = LinkTopology.NO_LINK
+        sut_ports = []
+        tg_ports = []

         if port_link := next(port_links, None):
             type = LinkTopology.ONE_LINK
@@ -103,10 +105,12 @@ def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node,
             case "sut":
                 return ctx.sut_node, self.sut_ports
             case "tg":
-                return ctx.tg_node, self.tg_ports
-            case _:
-                msg = f"Invalid node `{node_identifier}` given."
+                if ctx.tg_node is not None:
+                    return ctx.tg_node, self.tg_ports
+                msg = "node tg does not exist with current topology."
                 raise InternalError(msg)
+        msg = f"Invalid node `{node_identifier}` given."
+        raise InternalError(msg)

     def get_crypto_vfs(self, num_vfs: int) -> list[Port]:
         """Retrieve virtual functions from active crypto vfs.
@@ -139,6 +143,8 @@ def setup(self) -> None:

         Binds all the ports to the right kernel driver to retrieve MAC addresses and logical names.
         """
+        if self.type is LinkTopology.NO_LINK:
+            return
         self._prepare_devbind_script()
         self._setup_ports("sut")
         self._setup_ports("tg")
@@ -148,6 +154,8 @@ def teardown(self) -> None:

         Restores all the ports to their original drivers before the test run.
         """
+        if self.type is LinkTopology.NO_LINK:
+            return
         self._restore_ports_original_drivers("sut")
         self._restore_ports_original_drivers("tg")

@@ -338,7 +346,8 @@ def prepare_node(node: Node) -> None:
             node.main_session.devbind_script_path = devbind_script_path

         ctx = get_ctx()
-        prepare_node(ctx.tg_node)
+        if ctx.tg_node:
+            prepare_node(ctx.tg_node)
         prepare_node(ctx.sut_node)

     @property
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index 411196c4c5..4e7d814faa 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -99,12 +99,12 @@ def _print_stats(self, test_vals: list[dict[str, int | float | str]]) -> None:
         print(f"{'Latency Results'.center(border_len)}\n{'=' * border_len}")
         for k, v in test_vals[0].items():
             print(f"|{k.title():<{element_len}}", end="")
-        print(f"|\n{'='*border_len}")
+        print(f"|\n{'=' * border_len}")

         for test_val in test_vals:
             for k, v in test_val.items():
                 print(f"|{v:<{element_len}}", end="")
-            print(f"|\n{'='*border_len}")
+            print(f"|\n{'=' * border_len}")

     def _verify_latency(
         self,
--
2.54.0

