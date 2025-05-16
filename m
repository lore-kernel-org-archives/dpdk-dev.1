Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7486EC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:19:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED90C4065C;
	Fri, 16 May 2025 22:19:04 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id BE05740657
 for <dev@dpdk.org>; Fri, 16 May 2025 22:19:03 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7c5a55bf777so32793585a.0
 for <dev@dpdk.org>; Fri, 16 May 2025 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747426743; x=1748031543; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OntZ21HgP/xPZp9pF7yRVZ+qohJGsJ+4h7fljKe0gCM=;
 b=TPsy6LGUAX1caWPwbc0oCajW3iWTg6FwMq+jsXfSQ3o63gtIU0P4PfhvZmZX6jn/1v
 Na+s1Zg9Dj1zf4P9ryNnh/ZS+cRQRcYmWdiF+XyOyTmZXzs21S2QKFUC4E08Nh+fucYn
 z5avhDhVu2b98qS0KMD3K8XQSF2FzjtNY2h6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747426743; x=1748031543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OntZ21HgP/xPZp9pF7yRVZ+qohJGsJ+4h7fljKe0gCM=;
 b=AeB2v293CA5IBy3RUaJ4MJI/LfaMC6U8Sep3kZ/PwOZU8k47x73sh+WoLXMBXP22zV
 orlCb5ELqosaw2U3O5WvQVSUe/s1DZ80iOyGXOgnYaRorZhK+bUzayaFUNLrVWs0flMu
 GGoiNA9MtBtfpJJ0N7My6yzzF7PKhykTvpGcGBtU+h0E5378NHLDgoD81nJPvNqjxFEC
 BXuPmsxxHu4/j+BFUSW5g5b7on2EwJ/ZaSrVI/a2MkjnmquTI7StB3LS2mvSEmie+//k
 UKcanY2PJ3qmyNDFSWEHOUwFZXPannv0weSgRSFUgSpYiBHW1GVQDyLLjngBntTXOCSk
 OdQg==
X-Gm-Message-State: AOJu0YwZlofi+TkhZLbOrcCDazHNh/Ayo8J21X2GLks9RvUkzFXHiMmc
 uGZda2Qb7SRvW2lwVg5DzpzJ5hbs7RRKN6KY/7gGhRryFxzbjCFMk6iepo7UBPMeZ38=
X-Gm-Gg: ASbGncv8aoNlJ4Z8qmU2g8EGBEmBjSM9rCHJH6A74ccOrhKNWQFlQpYdHChESARqVPH
 f0DJmGy5IjCdKmgdjIbSpcBkk/WUdWp5qi7pLuwN4oW4lNUEc5dwb4aFAGZdewPM+T0OXEFP/sv
 6c28MjepCejByuZWqq9yQdNt0u8mQAvWN8pc2ysOcH508fSRXXbqrHgm2atjCam3RmPb8dcnf1C
 4N9tzOctU2Uqndp+1/FpK//Jq83pSZL9VVWsY+nXI6ZMX9CPQbwF/OZZv//GbrW9k3y/Th9vGj/
 x+FKDeYbDtM7qt2kykeoRtlfTWSYL8WyDM/qu30TvG7+8Y5z+mbfhKbqu9zQ+WmJUP0iD8fyng=
 =
X-Google-Smtp-Source: AGHT+IEE4U9eVnYghdm/BunOorteSS91j6KwLnW6OgVNiwMqpKROV2RYIpTrTyDCpxT8CwoOiQDunQ==
X-Received: by 2002:a05:620a:6609:b0:7c9:2465:8731 with SMTP id
 af79cd13be357-7cd4608d11emr311290085a.0.1747426743034; 
 Fri, 16 May 2025 13:19:03 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467d93d5sm159673685a.31.2025.05.16.13.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 13:19:02 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: stephen@networkplumber.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 paul.szczepanek@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, thomas.wilks@arm.com,
 probb@iol.unh.edu
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC v2 2/6] dts: rework traffic generator inheritance structure.
Date: Fri, 16 May 2025 16:18:30 -0400
Message-ID: <20250516201834.626206-3-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250516201834.626206-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
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

Rework TG class hierarchy to include performance traffic generators, in
addition to capturing traffic generators. As such, methods garnered
to capturing traffic have been moved to the CapturingTrafficGenerator
subclass.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 .../capturing_traffic_generator.py            | 34 +++++++++
 .../performance_traffic_generator.py          | 69 +++++++++++++++++++
 .../traffic_generator/traffic_generator.py    | 43 ------------
 3 files changed, 103 insertions(+), 43 deletions(-)
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py

diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index 61e5033f0b..124a1e5b86 100644
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
index 0000000000..54458325e2
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
@@ -0,0 +1,69 @@
+"""Performance testing capable traffic generatiors."""
+
+from abc import ABC, abstractmethod
+from dataclasses import dataclass
+from typing import Callable
+
+from scapy.packet import Packet
+
+from .traffic_generator import TrafficGenerator
+
+
+@dataclass(slots=True)
+class PerformanceTrafficStats(ABC):
+    """Data structure for stats offered by a given traffic generator."""
+
+    frame_size: int
+    tx_expected_bps: float
+    tx_recorded_bps: float
+
+
+class PerformanceTrafficGenerator(TrafficGenerator):
+    """An Abstract Base Class for all performance-oriented traffic generators.
+
+    Provides an intermediary interface for performance-based traffic generator.
+    """
+
+    _test_stats: list[PerformanceTrafficStats]
+
+    @property
+    def is_capturing(self) -> bool:
+        """Used for synchronization."""
+        return False
+
+    @property
+    def last_results(self) -> PerformanceTrafficStats | None:
+        """Get the latest set of results from TG instance.
+
+        Returns:
+            The most recent set of traffic statistics.
+        """
+        return self._test_stats.pop(0)
+
+    def generate_traffic_and_stats(
+        self,
+        packet: Packet,
+        duration: float,
+    ) -> PerformanceTrafficStats:
+        """Send packet traffic and acquire associated statistics."""
+        return self._calculate_traffic_stats(packet, duration, self._generate_traffic)
+
+    def setup(self, ports):
+        """Preliminary port setup prior to TG execution."""
+        for port in self._tg_node.ports:
+            self._tg_node.main_session.configure_port_mtu(2000, port)
+
+    def teardown(self, ports):
+        """Port teardown after TG execution."""
+        for port in self._tg_node.ports:
+            self._tg_node.main_session.configure_port_mtu(1500, port)
+
+    @abstractmethod
+    def _calculate_traffic_stats(
+        self, packet: Packet, duration: float, traffic_gen_callback: Callable[[Packet, float], str]
+    ) -> PerformanceTrafficStats:
+        """Calculate packet traffic stats based on TG output."""
+
+    @abstractmethod
+    def _generate_traffic(self, packet: Packet, duration: float) -> str:
+        """Implementation for :method:`generate_traffic_and_stats`."""
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index 6b9705d025..e6154ef1df 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -11,13 +11,10 @@
 from abc import ABC, abstractmethod
 from typing import Iterable
 
-from scapy.packet import Packet
-
 from framework.config.test_run import TrafficGeneratorConfig
 from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import Port
-from framework.utils import get_packet_summaries
 
 
 class TrafficGenerator(ABC):
@@ -54,46 +51,6 @@ def setup(self, ports: Iterable[Port], rx_port: Port):
 
     def teardown(self, ports: Iterable[Port]):
         """Teardown the traffic generator."""
-        self.close()
-
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
-    @property
-    def is_capturing(self) -> bool:
-        """This traffic generator can't capture traffic."""
-        return False
 
     @abstractmethod
     def close(self) -> None:
-- 
2.47.1

