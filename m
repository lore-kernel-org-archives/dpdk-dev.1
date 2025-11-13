Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F5CD4F35
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 01:28:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE9E54066B;
	Thu, 13 Nov 2025 02:28:43 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id C0B2C4067E
 for <dev@dpdk.org>; Thu, 13 Nov 2025 02:28:41 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4ed65fa5e50so1434341cf.0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 17:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762997321; x=1763602121; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qp2ALCQPcrZxaSZlXEPRBFr1K0dAkrAeuCMyqDNXhtA=;
 b=cpXM7Qt7tyX7H/hJ0jw6zkjvhuO+J4kr0ixEXW5tWEzlxP6D+EpTvu1EoVzMaFS9w6
 XKm0VpOjvY8xUQTfEWRr4JwJU1Dy+1P7D+6ausEi6IJKbuOWFyNGGqOkF9i7i5NqF37Z
 C407GOJeN1gOq+AkS3UZWkdzNrSHoSXbDoHbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762997321; x=1763602121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qp2ALCQPcrZxaSZlXEPRBFr1K0dAkrAeuCMyqDNXhtA=;
 b=GIQv3aUYMk4adt6WdM2ONhzy3Y26WDIfPFWHpXP3x654sFAseDGvo1NhlaJU8wlWDp
 hH7B/q0NbDdDDMqLxawwcj2NVGVUnD4sSzqN6+VG8kkQ+TSk2AkfDUg9yruXcbsisLTx
 U9LrrbEO0jSsI2qnX7Yx+wWw670XE98zMKNVKsjXrPITz5jjECOQRcOT9i3HEiceV/XV
 MF4apornpvP9L/nw8aTOSthwnX0/PzLCXGKHnJkBvbG/8zr4s2RPoTRBYDEjt46KvdA0
 Ut1fO5GSckpEYXKqJvDZyM2Gh/AiIVuko/Pma6gppwW1Ea2I7CM3gjVaXXrI9UqN9qo8
 QF9w==
X-Gm-Message-State: AOJu0YzinrTKTvxGKJOgK/sea1gjXIO586n6MxhOei0ETDmDWoN9rhcC
 Ya4Z4zFqKhNh0t64vQ1me/Em03wMUobmCAiv84A2mQoWkenvnlHQag9v5kn1Q2chzKM=
X-Gm-Gg: ASbGncsWS9LmK45sahIUc1JPQeu21vP6eyfo15iBZZN6sM0a85e24gUmUvGwKs9FuRU
 wwrxR2HYgEIpL/i+6XYGq+t5DwZIz4Fhm3oUenO6rF2kLYea4Wt/8UDzePkbTXptx1S5YklDAke
 UOp+BrqTJ0026BoOU7KjuQtHoSnQhLOY0iB1BiRQIefnw2xQDqZRWfHZjVsd76S7kI+FRBSIr+H
 qZwpfFFGBSMid9jyvbaQW0UV1ea6PHLXfj4Xv4GrtnRVqbq7Q8MdaaOzVNdXcvJy2AlKjLEUdGZ
 d+Un5DC6+3FQJUWR5tgCe7u4ZEU701uGVnaoyzWuMJjOey34ECNriHDveSwVpiKSMz9iNqd3Ec2
 GP00q4TOXm3Gs8QoEO5okG9kzj8p5HpPv6U0vhwRJkq+wTeYQmVdogKurQ0tzh/6NRjXt/shZj6
 gK
X-Google-Smtp-Source: AGHT+IE7HfkHR3IgzvaFTBucU+r454LS9yiCPq85TOI6yz37L4EHQ5alJ9kBfuFIFl4z5jQx28KXVA==
X-Received: by 2002:a05:622a:11c7:b0:4ed:6a9c:7234 with SMTP id
 d75a77b69052e-4eddbdf3fc1mr66552081cf.82.1762997321010; 
 Wed, 12 Nov 2025 17:28:41 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede86b3820sm3567821cf.4.2025.11.12.17.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:28:40 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 Paul.Szczepanek@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v7 1/3] dts: rework traffic generator inheritance structure
Date: Wed, 12 Nov 2025 20:27:30 -0500
Message-ID: <20251113012732.1059669-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251113012732.1059669-1-probb@iol.unh.edu>
References: <20251105223628.1659390-1-probb@iol.unh.edu>
 <20251113012732.1059669-1-probb@iol.unh.edu>
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

From: Nicholas Pratte <npratte@iol.unh.edu>

Rework TG class hierarchy to include performance traffic generators.
As such, methods specific to capturing traffic have been moved to the
CapturingTrafficGenerator subclass.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .../capturing_traffic_generator.py            | 34 +++++++++++
 .../performance_traffic_generator.py          | 59 +++++++++++++++++++
 .../traffic_generator/traffic_generator.py    | 38 ------------
 3 files changed, 93 insertions(+), 38 deletions(-)
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py

diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index 6f7ae022dd..7655751d7e 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -65,6 +65,40 @@ def is_capturing(self) -> bool:
         """This traffic generator can capture traffic."""
         return True
 
+    def send_packet(self, packet: Packet, port: Port) -> None:
+        """Send `packet` and block until it is fully sent.
+
+        Send `packet` on `port`, then wait until `packet` is fully sent.
+
+        Args:
+            packet: The packet to send.
+            port: The egress port on the TG node.
+        """
+        self.send_packets([packet], port)
+
+    def send_packets(self, packets: list[Packet], port: Port) -> None:
+        """Send `packets` and block until they are fully sent.
+
+        Send `packets` on `port`, then wait until `packets` are fully sent.
+
+        Args:
+            packets: The packets to send.
+            port: The egress port on the TG node.
+        """
+        self._logger.info(f"Sending packet{'s' if len(packets) > 1 else ''}.")
+        self._logger.debug(get_packet_summaries(packets))
+        self._send_packets(packets, port)
+
+    @abstractmethod
+    def _send_packets(self, packets: list[Packet], port: Port) -> None:
+        """The implementation of :method:`send_packets`.
+
+        The subclasses must implement this method which sends `packets` on `port`.
+        The method should block until all `packets` are fully sent.
+
+        What fully sent means is defined by the traffic generator.
+        """
+
     def send_packets_and_capture(
         self,
         packets: list[Packet],
diff --git a/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
new file mode 100644
index 0000000000..5be846361c
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Traffic generators for performance tests which can generate a high number of packets."""
+
+from abc import abstractmethod
+from dataclasses import dataclass
+
+from scapy.packet import Packet
+
+from .traffic_generator import TrafficGenerator
+
+
+@dataclass(slots=True)
+class PerformanceTrafficStats:
+    """Data structure to store performance statistics for a given test run.
+
+    Attributes:
+        tx_pps: Recorded tx packets per second.
+        tx_bps: Recorded tx bytes per second.
+        rx_pps: Recorded rx packets per second.
+        rx_bps: Recorded rx bytes per second.
+        frame_size: The total length of the frame.
+    """
+
+    tx_pps: float
+    tx_bps: float
+    rx_pps: float
+    rx_bps: float
+
+    frame_size: int | None = None
+
+
+class PerformanceTrafficGenerator(TrafficGenerator):
+    """An abstract base class for all performance-oriented traffic generators.
+
+    Provides an intermediary interface for performance-based traffic generator.
+    """
+
+    @abstractmethod
+    def calculate_traffic_and_stats(
+        self,
+        packet: Packet,
+        duration: float,
+        send_mpps: int | None = None,
+    ) -> PerformanceTrafficStats:
+        """Send packet traffic and acquire associated statistics.
+
+        If `send_mpps` is provided, attempt to transmit traffic at the `send_mpps` rate.
+        Otherwise, attempt to transmit at line rate.
+
+        Args:
+            packet: The packet to send.
+            duration: Performance test duration (in seconds).
+            send_mpps: The millions packets per second send rate.
+
+        Returns:
+            Performance statistics of the generated test.
+        """
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index cac119c183..e5f246df7a 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -11,14 +11,10 @@
 from abc import ABC, abstractmethod
 from typing import Any
 
-from scapy.packet import Packet
-
 from framework.config.test_run import TrafficGeneratorConfig
 from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.node import Node
-from framework.testbed_model.port import Port
 from framework.testbed_model.topology import Topology
-from framework.utils import get_packet_summaries
 
 
 class TrafficGenerator(ABC):
@@ -57,40 +53,6 @@ def teardown(self) -> None:
         """Teardown the traffic generator."""
         self.close()
 
-    def send_packet(self, packet: Packet, port: Port) -> None:
-        """Send `packet` and block until it is fully sent.
-
-        Send `packet` on `port`, then wait until `packet` is fully sent.
-
-        Args:
-            packet: The packet to send.
-            port: The egress port on the TG node.
-        """
-        self.send_packets([packet], port)
-
-    def send_packets(self, packets: list[Packet], port: Port) -> None:
-        """Send `packets` and block until they are fully sent.
-
-        Send `packets` on `port`, then wait until `packets` are fully sent.
-
-        Args:
-            packets: The packets to send.
-            port: The egress port on the TG node.
-        """
-        self._logger.info(f"Sending packet{'s' if len(packets) > 1 else ''}.")
-        self._logger.debug(get_packet_summaries(packets))
-        self._send_packets(packets, port)
-
-    @abstractmethod
-    def _send_packets(self, packets: list[Packet], port: Port) -> None:
-        """The implementation of :method:`send_packets`.
-
-        The subclasses must implement this method which sends `packets` on `port`.
-        The method should block until all `packets` are fully sent.
-
-        What fully sent means is defined by the traffic generator.
-        """
-
     @property
     def is_capturing(self) -> bool:
         """This traffic generator can't capture traffic."""
-- 
2.49.0

