Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E25CCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 22:37:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC34F40DF5;
	Wed,  5 Nov 2025 23:37:40 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id BC08240DFB
 for <dev@dpdk.org>; Wed,  5 Nov 2025 23:37:39 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-88f8f346c2cso34618285a.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762382259; x=1762987059; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oi39eoE39MFtc2feMNJCK0EtV7hJBR5RhUEDw/ytz5Q=;
 b=IubOKvQ/qSdoHuBlHlm+vHxsOL9044mBO++0zKA8LGFnAjBiLqWalXA3nXWF8uydkt
 X8ZTzGvjjJAzkXMWDUmRLyEj7FogqD0cPLrdqGQIeDAqcRKeyGJZ6FoLWgQfYjlbWoAX
 arhmQwRn6R3YymnIlvppAukUc+09pUJmTQHMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762382259; x=1762987059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oi39eoE39MFtc2feMNJCK0EtV7hJBR5RhUEDw/ytz5Q=;
 b=lw4uYxUT2xlaL0/nQCb+hSlwqbFmT+/AyuCG/CUZelo4CUfEa9cJzaC07h7uXxSbwp
 SPu9x97e4ja7pqLsa6bCKpudD9IFBgZBnUlhRw5WKeUGl6IOc+K4CinEhkQvKWjP0FXW
 e8ClUXJQsQpT2kId9P1zk48oVoULf3xXd92/83pZKbXLtCUn77+3zdsOHndtK3b1UFVE
 KSW5C6nSHDefejW8qTaC7n3b4ORJOuX08a+ea54KbFohQ+D6F3DEKsizmcYLyq3559ml
 6LrDtpkj/fvNr8FU1eDBphrfD6oW9yTckn9A63qNDeJnl5iPNAmj8m+MPk3axFnWUvjh
 wI7w==
X-Gm-Message-State: AOJu0YyMkx23qaQDpqxqu8EWlhbYP+MZuHk1s/aRTZxipVP30VnNaPnA
 nJNYR0zbPlUwPrM5QrmjcwwbNgoQ0A5lmRvbeVdTM8PhQi4RqRAjaJFAHeC+Vjav+cw=
X-Gm-Gg: ASbGnctgByXu65wT0am5ESTm2ywEe7oDVi8yN0/3kmILmKfnkV+VVgB9Oks/Ent182I
 cRoUNj6QSbkC5x4Xow1J22KM3HA6KCvTmzYEyoUbORAb6xCRySryU2xw+MoGQ9EDDtJ7LAE+aUP
 0RtSlvQl7K6X4UVP101UbTaf2jw1KlO9IlbxPDDX8K2NVBEoD/Uf3PVYAtvVL6dSZzPQ5EHMBn8
 1hhl0DI6MzqKqnMTMbLlVZMk3qy6RErplGaAUr2F3T9tvcpfdBD/zTgmIWtKWJdtPR6oSKfdIAm
 ol7Lwg7eC/3AQKtk9uBX4ugYNpvvfc89UfRWTXgDmC+GpvvoFxkKj9teWcJ4Yhs5dT8yTSimu3G
 /yvapRvEj6oCuw4gCrQi/PQRoY4yK6td0j4aLgzYpmzOWkkVI/7GpOwLEX+65Hbo7W9PaN41572
 f3
X-Google-Smtp-Source: AGHT+IGIHGLrUsbT8ix9QtL0DO42vgiblFFzwPDACeeOwh9E8XjofQzGRlNMitzXYh+HLxvo0tpNOQ==
X-Received: by 2002:ac8:5903:0:b0:4ed:18dd:fd4 with SMTP id
 d75a77b69052e-4ed72354fddmr67721221cf.19.1762382258931; 
 Wed, 05 Nov 2025 14:37:38 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed813da43asm4883981cf.27.2025.11.05.14.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 14:37:38 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v6 1/3] dts: rework traffic generator inheritance structure
Date: Wed,  5 Nov 2025 17:36:26 -0500
Message-ID: <20251105223628.1659390-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251105223628.1659390-1-probb@iol.unh.edu>
References: <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251105223628.1659390-1-probb@iol.unh.edu>
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
 .../performance_traffic_generator.py          | 56 +++++++++++++++++++
 .../traffic_generator/traffic_generator.py    | 38 -------------
 3 files changed, 90 insertions(+), 38 deletions(-)
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
index 0000000000..09abe9a66b
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
@@ -0,0 +1,56 @@
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

