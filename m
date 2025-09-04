Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D5DCA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8633042759;
	Thu,  4 Sep 2025 13:47:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B3CB741148
 for <dev@dpdk.org>; Thu,  4 Sep 2025 13:47:19 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B744E1756;
 Thu,  4 Sep 2025 04:47:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79E183F6A8;
 Thu,  4 Sep 2025 04:47:18 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 7/7] dts: save received packets with artifacts
Date: Thu,  4 Sep 2025 12:45:07 +0100
Message-ID: <20250904114653.199080-8-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904114653.199080-1-luca.vizzarro@arm.com>
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250904114653.199080-1-luca.vizzarro@arm.com>
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

The CapturingTrafficGenerator class manually creates pcaps to store the
received packets into. Change the behaviour to rely on Artifacts for
this operation.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 .../traffic_generator/capturing_traffic_generator.py     | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index a85858ba07..ec0993e6b7 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -16,7 +16,7 @@
 import scapy.utils
 from scapy.packet import Packet
 
-from framework.settings import SETTINGS
+from framework.testbed_model.artifact import Artifact
 from framework.testbed_model.port import Port
 from framework.utils import get_packet_summaries
 
@@ -131,6 +131,7 @@ def _send_packets_and_capture(
         """
 
     def _write_capture_from_packets(self, capture_name: str, packets: list[Packet]) -> None:
-        file_name = f"{SETTINGS.output_dir}/{capture_name}.pcap"
-        self._logger.debug(f"Writing packets to {file_name}.")
-        scapy.utils.wrpcap(file_name, packets)
+        artifact = Artifact("local", f"{capture_name}.pcap")
+        self._logger.debug(f"Writing packets to {artifact.local_path}.")
+        with artifact.open("wb") as file:
+            scapy.utils.wrpcap(file, packets)
-- 
2.43.0

