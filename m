Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457F3CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 01:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BC38402BB;
	Thu, 23 Oct 2025 03:32:06 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 220CB402DC
 for <dev@dpdk.org>; Thu, 23 Oct 2025 03:32:03 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-88fca7a60cfso32269785a.2
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761183122; x=1761787922; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ba+vog0pkzc/0h9JzZIsh5+3JJfvgZrix0BC3BhuP9Q=;
 b=OIZDMzEIwbWqjNpFioNPZYTzeGC0j+1ffjULwxgnCoDbcZCFivfB1vZxnRsVDLzru6
 ugb0FK/irUP6a2RPcszG+3UrLFUI+Ufk0KozqYrg/TIID46R0eDJGBA9ymEE7V/fJ0Xr
 PbAwXCPZv4/jX14EKnf6eU9kETbxzaRrGmtz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761183122; x=1761787922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ba+vog0pkzc/0h9JzZIsh5+3JJfvgZrix0BC3BhuP9Q=;
 b=BZ/A1tR0NbLWewyc+/8TiIyBK8m6LykhCepqng4ME1N5YQ79Q9E6v/HJwj/RKrTvJG
 G9azRJVNB01p27OplW7OV/KkjD0cBke4c269MEFLbY4xfgVT8Sw6YF7YYq7pCdZ1a3Cc
 CJesYbYVNk8nYr05/jOh8PAfadcTkJna7I3ZKNXzxz7qGDucxMmIdhQc+ucgIkW1xPb1
 WVhjVQtJIY9sSyKg3pnU5gBcMkBauy7ibUgXqtWDezgOlbCwUVe5YtlrUkaTRtm8IcZ+
 eAJm07DCG+KLil2OTaJUKO/EzdYOX2DEPgpTSyNDfJlnDH0mK8O54qUooiYq9ZnzNyxy
 587Q==
X-Gm-Message-State: AOJu0YyM3VqXcJ80PZ1WEFWUVLtlIjgEWwuwTHhUw56AiSaJB38xr1Vb
 DDonRIIZAZGDfcJyOJoYxTuWaR9AQ53wz4jB8I1v0WWPcofPLNRHfXvCYTAwUzVjlP0=
X-Gm-Gg: ASbGncu2Ahjjs3ORnOOWqoyKKTnWEa86+E56eKDu3ktWzGtlTpfIXuDu5jdv8vPeLYc
 kV0F6iB9sNGxUIpvinnURBIcIl6+BjntaIMwKYORgQnDirDeb+Hbijp3kgHRSLUfiwZmuUmO/K0
 jQaH79QsEBI/3xb975zBm27Nl0hNqG64OtOsk+ObcuIvnLNasYFKm3FiH0LYjf5LNcZeQLzbOow
 0kThm6GYOccc53KAhMFJbjsd4dLH04j/I2jddhHlUbwqBOl34Sc+NOceWXwrgsROn4EC+vKqrdB
 E39uoUfz391cbk5ihpBFwkjZJVP/4s88Uh8NoJH7Vm7C/FPmJgea6z4vfm9ukm2fPqlVKQGZf7o
 OEDQ5k/SJrusqNynGp89pbiRqFOW4MFiMn7t9PXRzjWCCdplvF5YrlXvJqcDM6XYMHHj00MX7Ft
 beknr6k0BlBNajQzokqRTo93PNM0VuUA==
X-Google-Smtp-Source: AGHT+IEd5LZIEFIW/OMZ6cIr6DFyCrJkEl8luJVXueLhVNoH606BUk+u+Cc2RzTSypB4LS2O0Du0Vw==
X-Received: by 2002:a05:620a:a1d8:20b0:891:4c12:1dac with SMTP id
 af79cd13be357-8914c122083mr2170429285a.29.1761183122393; 
 Wed, 22 Oct 2025 18:32:02 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c12546031sm56080085a.56.2025.10.22.18.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 18:32:01 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.ed, abailey@iol.unh.edu,
 Paul.Szczepanek@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 1/3] dts: rework traffic generator inheritance structure
Date: Wed, 22 Oct 2025 21:30:47 -0400
Message-ID: <20251023013049.1368129-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251023013049.1368129-1-probb@iol.unh.edu>
References: <20251001231659.2297751-1-probb@iol.unh.edu>
 <20251023013049.1368129-1-probb@iol.unh.edu>
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
---
 .../capturing_traffic_generator.py            | 34 ++++++++++
 .../performance_traffic_generator.py          | 63 +++++++++++++++++++
 .../traffic_generator/traffic_generator.py    | 38 -----------
 3 files changed, 97 insertions(+), 38 deletions(-)
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py

diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index ec0993e6b7..734a66d1f3 100644
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
index 0000000000..6b23faa1a5
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
@@ -0,0 +1,63 @@
+"""Traffic generators for performance tests which can generate a high number of packets."""
+
+from abc import abstractmethod
+from dataclasses import dataclass
+
+from scapy.packet import Packet
+
+from framework.testbed_model.topology import Topology
+
+from .traffic_generator import TrafficGenerator
+
+
+@dataclass(slots=True)
+class PerformanceTrafficStats:
+    """Data structure to store performance statistics for a given test run.
+
+    Attributes:
+        tx_pps: Recorded tx packets per second
+        tx_bps: Recorded tx bytes per second
+        rx_pps: Recorded rx packets per second
+        rx_bps: Recorded rx bytes per second
+        frame_size: The total length of the frame
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
+
+    def setup(self, topology: Topology) -> None:
+        """Overrides :meth:`.traffic_generator.TrafficGenerator.setup`."""
+        for port in self._tg_node.ports:
+            self._tg_node.main_session.configure_port_mtu(2000, port)
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

