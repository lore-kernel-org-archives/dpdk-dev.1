Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6384C369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 09:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3445402A1;
	Tue, 15 Apr 2025 11:51:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9F59640289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 11:51:22 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29BD51595;
 Tue, 15 Apr 2025 02:51:20 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.27.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B0703F66E;
 Tue, 15 Apr 2025 02:51:20 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: add ICMP to packet filter config
Date: Tue, 15 Apr 2025 10:48:49 +0100
Message-ID: <20250415094923.487014-1-luca.vizzarro@arm.com>
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

NICs like the Intel E810-C often produce ICMP packets. These packets
are stray and can interfere with testing. Therefore, add an ICMP
filtering option in the packet filter.

Moreover, use Scapy constants for the header values.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
Hi there,

sending in a new simple patch to introduce a new packet filter.

Best,
Luca
---
 .../capturing_traffic_generator.py            |  2 ++
 .../testbed_model/traffic_generator/scapy.py  | 20 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index e31ba2a9b7..61e5033f0b 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -34,10 +34,12 @@ class PacketFilteringConfig:
     Attributes:
         no_lldp: If :data:`True`, LLDP packets will be filtered out when capturing.
         no_arp: If :data:`True`, ARP packets will be filtered out when capturing.
+        no_icmp: If :data:`True`, ICMP packets will be filtered out when capturing.
     """
 
     no_lldp: bool = True
     no_arp: bool = True
+    no_icmp: bool = True
 
 
 class CapturingTrafficGenerator(TrafficGenerator):
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index 09adcafcd8..57d79aa3d4 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -19,6 +19,9 @@
 from typing import ClassVar
 
 from scapy.compat import base64_bytes
+from scapy.data import ETHER_TYPES, IP_PROTOS
+from scapy.layers.inet import IP
+from scapy.layers.inet6 import IPv6
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet
 
@@ -234,10 +237,23 @@ def _set_packet_filter(self, filter_config: PacketFilteringConfig):
 
         def _filter(packet: Packet) -> bool:
             if ether := packet.getlayer(Ether):
-                if filter_config.no_arp and ether.type == 0x0806:
+                if filter_config.no_arp and ether.type == ETHER_TYPES.ARP:
                     return False
 
-                if filter_config.no_lldp and ether.type == 0x88CC:
+                if filter_config.no_lldp and ether.type == ETHER_TYPES.LLDP:
+                    return False
+
+            if ipv4 := packet.getlayer(IP):
+                if filter_config.no_icmp and ipv4.proto == IP_PROTOS.icmp:
+                    return False
+
+            if ipv6 := packet.getlayer(IPv6):
+                next_header = ipv6.nh
+
+                if next_header == IP_PROTOS.hopopt:
+                    next_header = ipv6.payload.nh
+
+                if filter_config.no_icmp and next_header == IP_PROTOS.ipv6_icmp:
                     return False
 
             return True
-- 
2.43.0

