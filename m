Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87931F3C9B6
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 16:32:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6668C40270;
	Tue, 24 Feb 2026 17:32:26 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 57D3D400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 17:32:25 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8cb38e86cf2so585653385a.1
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1771950745; x=1772555545; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfPlbUbtk4Iy1V1GyMSSSHm7Dd0WqjWx+Ubfz0hy9uU=;
 b=F0CC7f0rXLJYgCK33wqI1Nld3wIKKBBNUycVsw25g+8dY2gU77nDNdIvQIqGEXma4n
 ENy0F79pile8d1RPToP9souB77Fip9M2bcvg593+b8eFrlY1Cw9n/AUlAE6PAWfIm5Au
 a76HBN7XHP7snOKqItpAwvonb2WinPIDO+dtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771950745; x=1772555545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rfPlbUbtk4Iy1V1GyMSSSHm7Dd0WqjWx+Ubfz0hy9uU=;
 b=LoEDdy0CovK6uTuhIXAs4fX/JBzivNS6tSNOdW/7hryxRdxh+q1tTSum1aF3EzZAu9
 9Jl8JogggpL9iLrP/QGzTRAqOMJH/sFBXqR51gnIFcQBQsUBntjWjHJ/3mu7NcbW17uR
 WWZ4nDp231oksmLhkzXfF46MP/qJ/kjc4LLReQaUX5PSu5dqo3pwRHidTr7jLzazMFqa
 QUDr684gL+vb0RO/6RYvw/kNBZkBPnKDYqXQZJ3lb7YZE1Y7nE6Ix9gkenG8iuwNKBKF
 66aLR5VnXn0ERjDPBHo2+IPMLl5Jis0eiOkoWgYILVBJLcN4vP79nLlosL2GUJ3dySnJ
 T/DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQIssCsfbher+6ZF0W9bsgoLd5Ha4FlBo/6hoHiYUAZtorDf2oZp8punPy8M6FEJBrQoY=@dpdk.org
X-Gm-Message-State: AOJu0Yw1lbFbk7zOW68ZDMIpdEryoVRTx8R7f7LfQ0GwBOn3GXkQ+CXi
 J2J8Iy3TUMElbZwx0PExhT3dv2hO4vKX9zt8sNgqMX45mMHzVBmoMPvyQtHborBG9wc=
X-Gm-Gg: AZuq6aIE8PHeS/RIOzVc6hlFcUqiXVTwEx5na8JKvLekiymwlnLXnd2dyB+ys5A8BBB
 1v4fYdg+iU0han2cwb1Sbo86BVMa8N1Dio/v+DcoMzvXYiYJiW9bd9wI0iOpfbsuu+bp/TDIL2Q
 nLog5Q8M8DyxZBARd1OkU7KBzRL9UtGJ9yNUvmjnpv76mErclilmGWCYPT86+mhid9kdTzQVu0H
 1Jlhjh7h/WI6vVLdi7gWcmA7UDHVlnKZMrLiFU0CJ5+9YGd/vccA5pQXWV9h1ikPrjwES4RCawO
 RFUX/VV2ZwQx7ZSYQD13KJCNIkQU0NFMN2HTi+al2lcPM/v1L/NYWuJbYMSQFRYrvUkX3CuQHGs
 Slr9en4xNa6VCGDBjeTvYrznXREPYWHd1Y76Gg6c4Zwmq8IMv4AhzVtpQpwu+FfewIxFqBLB0JN
 sgzhmjl6X7EMfoevS69D3Izueom25ltnnRIl2L08c5iuBT0F5XFqUkahbXUxOB6eaT
X-Received: by 2002:a05:620a:2804:b0:8c7:fdc:e853 with SMTP id
 af79cd13be357-8cb8c9cc12emr1494161685a.1.1771950744060; 
 Tue, 24 Feb 2026 08:32:24 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb8d0729a3sm1028166985a.22.2026.02.24.08.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:32:23 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: add support for no link topology
Date: Tue, 24 Feb 2026 11:32:00 -0500
Message-ID: <20260224163200.39360-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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
not used.

Bugzilla ID: 1870

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/test.py                          |  8 +++++---
 dts/configurations/test_run.example.yaml |  4 ++--
 dts/framework/config/__init__.py         | 16 ++++++++-------
 dts/framework/config/node.py             |  2 +-
 dts/framework/config/test_run.py         |  4 ++--
 dts/framework/context.py                 |  2 +-
 dts/framework/remote_session/dpdk.py     |  4 +++-
 dts/framework/test_run.py                | 25 ++++++++++++++----------
 dts/framework/testbed_model/topology.py  | 17 +++++++++++-----
 9 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/dts/api/test.py b/dts/api/test.py
index e17babe0ca..046f1778a5 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -109,12 +109,14 @@ def fail(failure_description: str) -> None:
     Raises:
         TestCaseVerifyError: Always raised to indicate the test case failed.
     """
+    ctx = get_ctx()
     get_logger().debug("A test case failed, showing the last 10 commands executed on SUT:")
-    for command_res in get_ctx().sut_node.main_session.remote_session.history[-10:]:
+    for command_res in ctx.sut_node.main_session.remote_session.history[-10:]:
         get_logger().debug(command_res.command)
     get_logger().debug("A test case failed, showing the last 10 commands executed on TG:")
-    for command_res in get_ctx().tg_node.main_session.remote_session.history[-10:]:
-        get_logger().debug(command_res.command)
+    if ctx.tg_node:
+        for command_res in ctx.tg_node.main_session.remote_session.history[-10:]:
+            get_logger().debug(command_res.command)
     raise TestCaseVerifyError(failure_description)
 
 
diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index c8035fccf0..f6ca09545e 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -23,7 +23,7 @@ dpdk:
     # in a subdirectory of DPDK tree root directory. Otherwise, will be using the `build_options`
     # to build the DPDK from source. Either `precompiled_build_dir` or `build_options` can be
     # defined, but not both.
-func_traffic_generator:
+func_traffic_generator: # Remove both traffic generators when running a no-link topology
   type: SCAPY
 # perf_traffic_generator:
 #   type: TREX
@@ -42,7 +42,7 @@ vdevs: # optional; if removed, vdevs won't be used in the execution
 system_under_test_node: "SUT 1"
 # Traffic generator node to use for this execution environment
 traffic_generator_node: "TG 1"
-port_topology:
+port_topology: # provide empty list for no-link environment
   - sut.port-0 <-> tg.port-0  # explicit link. `sut` and `tg` are special identifiers that refer
                               # to the respective test run's configured nodes.
   - port-1 <-> port-1         # implicit link, left side is always SUT, right side is always TG.
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index d2f0138e4a..59d566aa0b 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -94,9 +94,10 @@ def validate_port_links(self) -> Self:
                 f"already linked to port {sut_node_port_peer[0]}.{sut_node_port_peer[1]}."
             )
 
-            tg_node_port_peer = existing_port_links.get(
-                (self.test_run.traffic_generator_node, link.tg_port), None
-            )
+            if self.test_run.traffic_generator_node:
+                tg_node_port_peer = existing_port_links.get(
+                    (self.test_run.traffic_generator_node, link.tg_port), None
+                )
             assert (
                 tg_node_port_peer is not None
             ), f"Invalid TG node port specified for link port_topology.{link_idx}."
@@ -122,11 +123,12 @@ def validate_test_run_against_nodes(self) -> Self:
         ), f"The system_under_test_node {sut_node_name} is not a valid node name."
 
         tg_node_name = self.test_run.traffic_generator_node
-        tg_node = next((n for n in self.nodes if n.name == tg_node_name), None)
+        if self.test_run.port_topology:
+            tg_node = next((n for n in self.nodes if n.name == tg_node_name), None)
 
-        assert (
-            tg_node is not None
-        ), f"The traffic_generator_name {tg_node_name} is not a valid node name."
+            assert (
+                tg_node is not None
+            ), f"The traffic_generator_name {tg_node_name} is not a valid node name."
 
         return self
 
diff --git a/dts/framework/config/node.py b/dts/framework/config/node.py
index 438a1bdc8f..d91c0835e4 100644
--- a/dts/framework/config/node.py
+++ b/dts/framework/config/node.py
@@ -69,7 +69,7 @@ class NodeConfiguration(FrozenModel):
     #: An optional hugepage configuration.
     hugepages: HugepageConfiguration | None = Field(None, alias="hugepages_2mb")
     #: The ports that can be used in testing.
-    ports: list[PortConfig] = Field(min_length=1)
+    ports: list[PortConfig] = Field(default=[], min_length=0)
 
     @model_validator(mode="after")
     def verify_unique_port_names(self) -> Self:
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 6c292a3675..07440c5250 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -490,11 +490,11 @@ class TestRunConfiguration(FrozenModel):
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
index 8f1021dc96..371473f61c 100644
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
index c3575cfcaf..eedb71c471 100644
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
+            and not ctx.topology.sut_port_ingress
             and ctx.topology.sut_port_ingress.config.os_driver == "ice"
         ):
             meson_args = MesonArgs(
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index ff0a12c9ce..536d0f33fb 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -189,25 +189,28 @@ def __init__(
         self.config = config
         self.logger = get_dts_logger()
 
+        tg_node = None
         sut_node = next(n for n in nodes if n.name == config.system_under_test_node)
-        tg_node = next(n for n in nodes if n.name == config.traffic_generator_node)
-
-        topology = Topology.from_port_links(
-            PortLink(sut_node.ports_by_name[link.sut_port], tg_node.ports_by_name[link.tg_port])
-            for link in self.config.port_topology
-        )
+        if config.traffic_generator_node:
+            tg_node = next(n for n in nodes if n.name == config.traffic_generator_node)
+            topology = Topology.from_port_links(
+                PortLink(sut_node.ports_by_name[link.sut_port], tg_node.ports_by_name[link.tg_port])
+                for link in self.config.port_topology
+            )
+        else:
+            topology = Topology.from_port_links(iter([]))
 
         dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
         dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
 
         func_traffic_generator = (
             create_traffic_generator(config.func_traffic_generator, tg_node)
-            if config.func and config.func_traffic_generator
+            if config.func and config.func_traffic_generator and tg_node
             else None
         )
         perf_traffic_generator = (
             create_traffic_generator(config.perf_traffic_generator, tg_node)
-            if config.perf and config.perf_traffic_generator
+            if config.perf and config.perf_traffic_generator and tg_node
             else None
         )
 
@@ -343,7 +346,8 @@ def next(self) -> State | None:
         test_run.remaining_tests = deque(test_run.selected_tests)
 
         test_run.ctx.sut_node.setup()
-        test_run.ctx.tg_node.setup()
+        if test_run.ctx.tg_node:
+            test_run.ctx.tg_node.setup()
         test_run.ctx.dpdk.setup()
         test_run.ctx.topology.setup()
 
@@ -450,7 +454,8 @@ def next(self) -> State | None:
             self.test_run.ctx.perf_tg.teardown()
         self.test_run.ctx.topology.teardown()
         self.test_run.ctx.dpdk.teardown()
-        self.test_run.ctx.tg_node.teardown()
+        if self.test_run.ctx.tg_node:
+            self.test_run.ctx.tg_node.teardown()
         self.test_run.ctx.sut_node.teardown()
         return None
 
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 13b4b58a74..e1abc2f0da 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -70,6 +70,8 @@ def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
             ConfigurationError: If an unsupported link topology is supplied.
         """
         type = LinkTopology.NO_LINK
+        sut_ports = []
+        tg_ports = []
 
         if port_link := next(port_links, None):
             type = LinkTopology.ONE_LINK
@@ -100,16 +102,18 @@ def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node,
             case "sut":
                 return ctx.sut_node, self.sut_ports
             case "tg":
-                return ctx.tg_node, self.tg_ports
-            case _:
-                msg = f"Invalid node `{node_identifier}` given."
-                raise InternalError(msg)
+                if ctx.tg_node:
+                    return ctx.tg_node, self.tg_ports
+        msg = f"Invalid node `{node_identifier}` given."
+        raise InternalError(msg)
 
     def setup(self) -> None:
         """Setup topology ports.
 
         Binds all the ports to the right kernel driver to retrieve MAC addresses and logical names.
         """
+        if self.type is LinkTopology.NO_LINK:
+            return
         self._prepare_devbind_script()
         self._setup_ports("sut")
         self._setup_ports("tg")
@@ -119,6 +123,8 @@ def teardown(self) -> None:
 
         Restores all the ports to their original drivers before the test run.
         """
+        if self.type is LinkTopology.NO_LINK:
+            return
         self._restore_ports_original_drivers("sut")
         self._restore_ports_original_drivers("tg")
 
@@ -264,7 +270,8 @@ def prepare_node(node: Node) -> None:
             node.main_session.devbind_script_path = devbind_script_path
 
         ctx = get_ctx()
-        prepare_node(ctx.tg_node)
+        if ctx.tg_node:
+            prepare_node(ctx.tg_node)
         prepare_node(ctx.sut_node)
 
     @property
-- 
2.50.1

