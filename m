Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C906CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 23:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F43E40661;
	Thu,  2 Oct 2025 01:17:42 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 21B054065E
 for <dev@dpdk.org>; Thu,  2 Oct 2025 01:17:41 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-85cee530df9so48476985a.3
 for <dev@dpdk.org>; Wed, 01 Oct 2025 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759360660; x=1759965460; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ba+vog0pkzc/0h9JzZIsh5+3JJfvgZrix0BC3BhuP9Q=;
 b=YVpTAvM5PCz+Z4/birjJD7HrSGRDtHo+SDCAHJQd7jkLbnaWByB9MG9hBT25WVbBlk
 ARSsB9sESJtj7wdimyD2ih1OUTxcoCJrkRqpen4uNu5Axqyc6nezLStCx+9RcHbv928s
 XD55OOKxCHNOFdz0pL4BPBiOg632UAERJ4jns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759360660; x=1759965460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ba+vog0pkzc/0h9JzZIsh5+3JJfvgZrix0BC3BhuP9Q=;
 b=oQKXMDSMIP4hzUVpNdoNnlxA9SXgCKckEgXlTT5XR7nwv/jndYQGHq6SMp6IkpTQIp
 QMp6aR2GvNx3Ewu6o2eFht+xaVKw4KihGiktHs0GqnpGVM0zkcLnb6WXrWlmBqJ7Schb
 90beH3HAjUyMLAJdOWW6hWx7m85pqUCGW/csgP8uD3RvSMuqUE07ZVt2k+hkvvip5ENH
 lqAgPnFhcw9iUrK+zypwRnXQd7WuwBIbej5JdEi+JU66ntd74oOEh1LWO37ry6uIBgv4
 p0AAsv3Fh0HPpOndzU7LGiTKTPYG/Q8m1Mo5JsHIUMXLW8gsEitY6tlk1ZmO5hQmBdYl
 3dTQ==
X-Gm-Message-State: AOJu0YxxjjqyoCcD7X7QYWZex/t387W/MnDstb1I2eEHRm1lRVWmCp8u
 bdsAfoJupDXaKg9hUM7asPk7Zs7WkAefDHGmV7lOZIzv+8KfcY3EjdiG7FZByKuwAog=
X-Gm-Gg: ASbGncsqDr0IbdhWKa8sMAiwuugCJOnMdPFNAeqqBwngI4aPbViLfAlKWk6w1UGJcJq
 GTo+2ribB532YW9f254IN4ezK7nE16N4JLAtoxceskC4wEwV3IErt+w2FIQKrwVx038VXB/T8nr
 SWCgm5HPPn5SCozaLULM8yfkaI58FIcp1BDO4ziq6jX7fl+YxVVEXbXdumKxa9xjDvmuEdiB6es
 eRsQsGA6NHl+mVPYqyszyPnM73o6bOVVNlYpD/k2leSDHjlzM5CFNYxnL/IFQ1IlkwaIXIUsshi
 1ufb4wXJK77o7s2CRf8xQZp6KkOqpK0lUU8UbYtmh14G8/NRdhOr/9UXZ+g2xjIigYUQEYkXU5F
 6GcHlz+rauEo7I6J+E4wOApEcZ0uBhADUAschkw8Cf3AKI0Yj
X-Google-Smtp-Source: AGHT+IGkkCH9SqjtoFhvbfOZ+Sn8TD7qU1+3kPG740rFC5eI4R3apG37IUfDK3ZLdC7gOkPnkvPzOg==
X-Received: by 2002:a05:620a:bca:b0:828:b765:64d with SMTP id
 af79cd13be357-87370f81b59mr789718285a.13.1759360660308; 
 Wed, 01 Oct 2025 16:17:40 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8777aabeac7sm95224285a.64.2025.10.01.16.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 16:17:39 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 1/3] dts: rework traffic generator inheritance structure
Date: Wed,  1 Oct 2025 19:16:57 -0400
Message-ID: <20251001231659.2297751-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251001231659.2297751-1-probb@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20251001231659.2297751-1-probb@iol.unh.edu>
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

