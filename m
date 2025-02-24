Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB73C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 13:30:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A15B41141;
	Mon, 24 Feb 2025 14:30:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id AD530410FB
 for <dev@dpdk.org>; Mon, 24 Feb 2025 14:30:12 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78EE1477;
 Mon, 24 Feb 2025 05:30:28 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A13D3F5A1;
 Mon, 24 Feb 2025 05:30:11 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 6/6] dts: restore TG setup and teardown
Date: Mon, 24 Feb 2025 13:28:23 +0000
Message-ID: <20250224132823.196509-7-luca.vizzarro@arm.com>
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

The setup and teardown was previously missed when reworking the
execution internals into states. Add back the traffic generator setup
and teardown respectively in TestRunSetup and TestRunTeardown.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/test_run.py                                       | 2 ++
 .../testbed_model/traffic_generator/traffic_generator.py        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 84d8fb26ac..774036571b 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -338,6 +338,7 @@ def next(self) -> State | None:
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
         test_run.ctx.dpdk.setup(test_run.ctx.topology.sut_ports)
+        test_run.ctx.tg.setup(test_run.ctx.topology.tg_ports)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
         self.result.sut_info = test_run.ctx.sut_node.node_info
@@ -420,6 +421,7 @@ def description(self) -> str:
 
     def next(self) -> State | None:
         """Next state."""
+        self.test_run.ctx.tg.teardown(self.test_run.ctx.topology.tg_ports)
         self.test_run.ctx.dpdk.teardown(self.test_run.ctx.topology.sut_ports)
         self.test_run.ctx.tg_node.teardown()
         self.test_run.ctx.sut_node.teardown()
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index 4469273e36..804662e114 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -53,7 +53,7 @@ def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
     def setup(self, ports: Iterable[Port]):
         """Setup the traffic generator."""
 
-    def teardown(self):
+    def teardown(self, ports: Iterable[Port]):
         """Teardown the traffic generator."""
 
     def send_packet(self, packet: Packet, port: Port) -> None:
-- 
2.43.0

