Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D5CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DE3E402BE;
	Tue,  9 Jun 2026 15:11:41 +0200 (CEST)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47]) by mails.dpdk.org (Postfix) with ESMTP id B7DBD4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 15:11:39 +0200 (CEST)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-66049669d78so4913857d50.0
 for <dev@dpdk.org>; Tue, 09 Jun 2026 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781010699; x=1781615499; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKmtQA3HT5isU6erdo+/QFvQiyPEOU+S9iyeFhMnl3s=;
 b=WgtdyK46Gkyuowx7ZzEO5D8TQAnRHttgzL4WG6AYcGgWbtuVT02jk6+cMQDerYhi0C
 ONLZuWgLkO77KynMCEHZSp6RB6CzoAAUuw/Ir0kqb5yyebJM1Qcy4vyIo/0EIFDFyjJK
 tBT2mx8IADoNWKJxj5Zhg9yRtJj9oBNp3fYn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781010699; x=1781615499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XKmtQA3HT5isU6erdo+/QFvQiyPEOU+S9iyeFhMnl3s=;
 b=bML4m4lqqzN9wqNKJ9kd5k8bWTFUo/tYx6oGnbyuJViqMpjbmoZPUx5Gn5JE0pESG2
 zZ3y6EK8d1rx8O+cbYp9EaCluiWtP6eZNE4ldOvSPV95KuHCeGTtEMsxkaTF/pXW4IOs
 AJ7Ug0PeGGFWTwIpjn2zHB7TFl89oO0pxJkjsAoccVQn7SS3GYXHzyJNKaZU1SCv2GHa
 oiZv8eVS9hPaZK966IxhpNz9mh+SZwVlG8d41TBiFZEa5OWHGFFJ6D17Yw31+TvLJzeb
 ol2aHobUemsom50TBIDHhfLoPiWFYGR3ugnSJFhDQHII+VSmEQIuZZxaXaKCNSxrsg/d
 6pag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fsjGYcNWozHQ5qFWExf2fkiFcUFhm9pIQ3Xr3e2Q7eF+H0g2tmopoQxaTYB8JDM2WQ40=@dpdk.org
X-Gm-Message-State: AOJu0YzHztOP7LjTA/l1Xu2tyLj4VP1/uOF9WPL7LEwMOsL+nkPyZDIZ
 0K/2n+uqGItq9xw3WURgO75lufgup4G02Cbf2Gmod1i/lViQpCdp0YQZCenA++xL2rw=
X-Gm-Gg: Acq92OGepOMvJCbLqTqnmbU4CRhx/fdUPl38PKPt5j6YDlvhS5Ry7ON8+0OHoxU0vKx
 7S2Z65PuCTulj/k1CdBuvURz1hB9Rs0gFmmOti7NhYy2L1PjnvX541N/DZN58OiwLCQ4duS1chQ
 qPw1y9XBaVunsd6dZZjqmaRARSGKmxyMb5p0SdWIkI+EICtrej4Y68UKonCI65daQhtc25CdeJ3
 osXt/9f0rbMhkOugj5jwPb31q26lHjZRZH1nWLi34elYOQ5K7m01LJhN1tOqwb3QMJArTgAqzTn
 3shgaosiaMBlvjnh2YdSPQaPwUrfLHevy6kGdfuWuDKMwaFGC57DPw+egl6lr0/p7JSjX28Q1Gp
 tmHzs3ZLRe5myC8EVvt2kNZ3GAgW27pc5Yww2XqO5uHGIP06By1+Zw2khg95Xu8HGW1IOjAF+fM
 lmLVqUSsURvFXCIc/IbEQROk8E3OIO8Hf2ec+gcsFa2GBpmx+skFW1TMDtbWygYP2ND5HI0szto
 so=
X-Received: by 2002:a05:690e:168f:b0:65c:c744:36c0 with SMTP id
 956f58d0204a3-66106e79adcmr17734262d50.23.1781010698773; 
 Tue, 09 Jun 2026 06:11:38 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:2a32:2ddf:c455:dafe])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd053032sm208767026d6.24.2026.06.09.06.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:11:37 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, ahassick@iol.unh.edu,
 knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3] dts: add support for no link topology
Date: Tue,  9 Jun 2026 09:11:34 -0400
Message-ID: <20260609131134.233735-1-abailey@iol.unh.edu>
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
 dts/api/test.py                          |  8 +++++---
 dts/configurations/test_run.example.yaml |  2 +-
 dts/framework/config/__init__.py         | 16 ++++++++-------
 dts/framework/config/test_run.py         |  4 ++--
 dts/framework/context.py                 |  2 +-
 dts/framework/remote_session/dpdk.py     |  4 +++-
 dts/framework/test_run.py                | 25 ++++++++++++++----------
 dts/framework/testbed_model/topology.py  | 17 +++++++++++-----
 8 files changed, 48 insertions(+), 30 deletions(-)

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
index ee641f5dce..af5f72d305 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -59,7 +59,7 @@ test_suites: # see `Optional Fields`; the following test suites will be run in t
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
 
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 76e24d1785..f9143dfc4e 100644
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
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 94dc6023a7..93fc5ee93f 100644
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
 
@@ -455,7 +459,8 @@ def next(self) -> State | None:
             self.test_run.ctx.perf_tg.teardown()
         self.test_run.ctx.topology.teardown()
         self.test_run.ctx.dpdk.teardown()
-        self.test_run.ctx.tg_node.teardown()
+        if self.test_run.ctx.tg_node:
+            self.test_run.ctx.tg_node.teardown()
         self.test_run.ctx.sut_node.teardown()
         return None
 
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 34862c4d2e..01333da716 100644
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
@@ -103,10 +105,10 @@ def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node,
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
 
     def get_crypto_vfs(self, num_vfs: int) -> list[Port]:
         """Retrieve virtual functions from active crypto vfs.
@@ -139,6 +141,8 @@ def setup(self) -> None:
 
         Binds all the ports to the right kernel driver to retrieve MAC addresses and logical names.
         """
+        if self.type is LinkTopology.NO_LINK:
+            return
         self._prepare_devbind_script()
         self._setup_ports("sut")
         self._setup_ports("tg")
@@ -148,6 +152,8 @@ def teardown(self) -> None:
 
         Restores all the ports to their original drivers before the test run.
         """
+        if self.type is LinkTopology.NO_LINK:
+            return
         self._restore_ports_original_drivers("sut")
         self._restore_ports_original_drivers("tg")
 
@@ -338,7 +344,8 @@ def prepare_node(node: Node) -> None:
             node.main_session.devbind_script_path = devbind_script_path
 
         ctx = get_ctx()
-        prepare_node(ctx.tg_node)
+        if ctx.tg_node:
+            prepare_node(ctx.tg_node)
         prepare_node(ctx.sut_node)
 
     @property
-- 
2.54.0

