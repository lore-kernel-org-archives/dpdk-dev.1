Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7327DC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 17:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3736C402CC;
	Thu,  9 Jul 2026 19:53:20 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 0EA5C40268
 for <dev@dpdk.org>; Thu,  9 Jul 2026 19:53:19 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-92e53581361so3269485a.1
 for <dev@dpdk.org>; Thu, 09 Jul 2026 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783619598; x=1784224398; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v8DUAJDyHxbwarhAY2BuZXZBG/QbcM/eWx5HILc5y2M=;
 b=dzeTW70cxg24o11AQDiBdoRaqoyrxxlsiILG3Rn0mNwLiIAte6v0JXtlaG3EG9yssv
 8I7++o+BpiE50NGTWPEBbYO4fTf+YGafKY15P6cC5+V9Zcsq+lT0MQJStWFEkt0dM0pE
 GtdJ65grukClcxDPhbC5SWI6kfS0/wUAiC3BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783619598; x=1784224398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v8DUAJDyHxbwarhAY2BuZXZBG/QbcM/eWx5HILc5y2M=;
 b=X9ixz42RY1QhCRa4L1Az4peY28shINbva9wFy752d2xvZQKs+1mSk2wjLcJFwbvEgq
 4XreRxTmh6J/JnEnbKGK7WVTLzU+nAHHsVx74d/0x+IJRE4PewaC3WD2TyAodY+eeeOK
 frhD/41vWDF4I513Zgqb9nxQKTxBqKiDi0+k5hkW9upjUjWTZ7AaLWLBivJ+KvimIskt
 Zgu9IjNGKJY5RJJCa1TbiWmALrRIjTSm8bQS8hJrE3nwDG3rlV9gFCSGk73emtl96VSS
 8kLTlrlPXzmSeAYv4pijG4fIisAVsFxHh6VFf3PjXpmRqwRfjjnSIrQp1OqQHMF6T5WT
 8dtg==
X-Gm-Message-State: AOJu0Yzi4l5Ztd1aI57HPk09uJQs9PMp9ZNPHcm34irzv2//R4dKsIDY
 bkqma69dNe/82ffIa1dZyeJ8WU9z455kBKp1viZP/F2aE3apEerEDBkMr7vDotRkqC0oGooRwmd
 lZVe2Kls9i0uh7E6R8pyNph3Q1TSSQX1iXoYL0ZkpqRLzcbSOOyTLm+llXRWwskR9q/Zky8iqPv
 ZgpQ7wj96fQg9oGhEFWjySTKM3WPE=
X-Gm-Gg: AfdE7cnptrcnUwioywSsBQaH8gJKpDnZnrbKNxmloNylrzE9ohrW625gj8VxjTsNXSn
 Vvewue/KjXHdVsgsUZpEB/T286Ww/lhZlEeqPGkPSK2MM8k4iA+QBA395PwaG9YYqv9ji8Ve7FE
 4LjtQ0XNT8y033++QgAXTlx0lFV9V16VUUOxC3R5j4+zG6UmTAaXJMOXICadoR1oHryV2S6ppHf
 mPh6nWsIpuKoccS8XZK7/C/Mg/ScOyffWlCEvhgyDDha9U2N4UYAw7/df3mNv+MQLmjDzR7CG3X
 bAez854fd6cFUpnYzAgyRmMyixy2Jd0zjZ2lGPHsOeWfOA4hUC8uShBhAR/P0f1aH74/jLYJ6Xi
 ZyH3YrDXuHHxmEFEvUe2+bIsgg8IeQR81FCg3x7kRg3KbzuFfXUYGkirfAAcWkdIBwOjjFKBYRD
 TEQ5DlMtNRZsFhJSCrQLn276rOl/RaYKGlXX2q2YIHFJ4ndx8ypuTYWA==
X-Received: by 2002:a05:620a:45a2:b0:92e:4bac:9078 with SMTP id
 af79cd13be357-92ecf696e63mr812002885a.42.1783619597816; 
 Thu, 09 Jul 2026 10:53:17 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210:5d7f:246:cd51:1b62])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90c923c4sm1768289185a.24.2026.07.09.10.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:53:17 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v6] dts: add support for no link topology
Date: Thu,  9 Jul 2026 13:53:12 -0400
Message-ID: <20260709175312.1018085-1-abailey@iol.unh.edu>
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
not used. The specified option to build DPDK with 16 byte descriptors
for ice drivers is removed in the case of a no link topology since it is
not required when traffic is not present. Additionally, leaving the logic
as is would cause DTS to crash when the topology was no link but does
not with this change.

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
v6:
* Updated commit message and typo in comment

 dts/api/test.py                          | 11 ++-
 dts/configurations/test_run.example.yaml | 10 ++-
 dts/framework/config/__init__.py         | 36 ++++-----
 dts/framework/config/test_run.py         |  4 +-
 dts/framework/context.py                 |  2 +-
 dts/framework/remote_session/dpdk.py     |  4 +-
 dts/framework/runner.py                  |  6 +-
 dts/framework/test_run.py                | 95 ++++++++++++++----------
 dts/framework/testbed_model/topology.py  | 17 ++++-
 9 files changed, 112 insertions(+), 73 deletions(-)

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
index ee641f5dce..51f9ab8237 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -25,6 +25,12 @@
 #       By removing the `test_suites` field, this test run will run every test suite available.
 #   `vdevs`:
 #       Uncomment to add a specific virtual device to run on the SUT node.
+#   `port_topology`:
+#   	By providing an empty list, DTS will run in no link topology mode and will not allocate a TG
+#   	node.
+#   `traffic_generator_node`:
+#   	This field may be None When `port_topology` is specified as a no link topology, Otherwise it
+#   	is required.

 # Define the test run environment
 dpdk:
@@ -58,8 +64,8 @@ test_suites: # see `Optional Fields`; the following test suites will be run in t
 # The machine running the DPDK test executable
 system_under_test_node: "SUT 1"
 # Traffic generator node to use for this execution environment
-traffic_generator_node: "TG 1"
-port_topology:
+traffic_generator_node: "TG 1" # see `Optional Fields`
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
--
2.54.0

