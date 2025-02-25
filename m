Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98576C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 10:23:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE54D42D7A;
	Tue, 25 Feb 2025 11:23:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 94361427C5
 for <dev@dpdk.org>; Tue, 25 Feb 2025 11:23:47 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D9A51516;
 Tue, 25 Feb 2025 02:24:03 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.31.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E2123F6A8;
 Tue, 25 Feb 2025 02:23:45 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: add TG setup and teardown
Date: Tue, 25 Feb 2025 10:22:22 +0000
Message-ID: <20250225102222.345716-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
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

Add traffic generator setup and teardown respectively in
TestRunSetup and TestRunTeardown.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/test_run.py                                       | 2 ++
 .../testbed_model/traffic_generator/traffic_generator.py        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 9f37c4bb6c..2808d013f6 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -334,6 +334,7 @@ def next(self) -> State | None:
         test_run.remaining_tests = deque(test_run.selected_tests)
 
         test_run.ctx.dpdk.setup(test_run.ctx.topology.sut_ports)
+        test_run.ctx.tg.setup(test_run.ctx.topology.tg_ports)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
         self.result.sut_info = test_run.ctx.sut_node.node_info
@@ -416,6 +417,7 @@ def description(self) -> str:
 
     def next(self) -> State | None:
         """Next state."""
+        self.test_run.ctx.tg.teardown(self.test_run.ctx.topology.tg_ports)
         self.test_run.ctx.dpdk.teardown(self.test_run.ctx.topology.sut_ports)
         self.result.update_teardown(Result.PASS)
         return None
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

