Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEDEC369D5
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 19:40:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68F4E40609;
	Wed, 23 Apr 2025 21:40:50 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 653CC402EA
 for <dev@dpdk.org>; Wed, 23 Apr 2025 21:40:48 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7c5f20d512fso2793385a.2
 for <dev@dpdk.org>; Wed, 23 Apr 2025 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745437248; x=1746042048; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ntl08QIQUvBPgBWHW5L9gNTdGmhbbpIst+z7VPU9BZg=;
 b=XrPV9Cm8KbsFwxjVZUBQG7sUatsZJQh6Xk7aVI2adb6oQufrXP94bGAI9tvWW7s2gx
 /S3EoQEEkToPYa70C4vDdWQuHxeIX3N6CsJeExZmQ1GusvQNE0FPwuYoMc8igGdY7oRM
 PbEciw8ou/wGSEh++bZ/IkO8YGMJ/SsbwJgNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745437248; x=1746042048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ntl08QIQUvBPgBWHW5L9gNTdGmhbbpIst+z7VPU9BZg=;
 b=l7+WL1riMDk7dIgjbyaYXvOUxqyKId9JOtokwxUjeSiqJ4eGLw4r+mspWVjRIDz9uu
 mMN5aJ3dN6QHlUHCyG0LdG88+/EMrgd6YSA15ODg2KjA1F5iPc+R1a1iocfaKwg03ESQ
 FyMdWV/ePnUrIeBHmx1ArGWbtBLAQaO69JQ77ako001P/rODilzqxxzocyINelJFPDvE
 CcgWZE9sLC3WQehnBS/34zo73On7yiVYmTXGViYO4KXRRnIwCaXngHbgVexINGulY03N
 XUk587mZ2GOeCIPX9/5p0XT6c4aiP555ViIsPT2NJQNdQtMiD/scRVxiziEr1tpi4V9H
 qD4Q==
X-Gm-Message-State: AOJu0YynHjsVK3/zZXWgh9g50hHPkHl+9twfKkfn+e5tFIwLUVA9Y6tz
 eEqVpd0xH9nTsOc4OirlgIFuerR0ysUzQn1tE8s8LIUY67dDpHUgMsyLbDo9LTY=
X-Gm-Gg: ASbGncsGBaSQNkdB4LexAyEw2qIfxHU9/ea3Yfz1ZvMdnJ9kzSxL6pyuWJ1PZQRMYSk
 aKZSNVPjNXdz+tnU6sqQCBhRhoqWsHqQ0LbEhwV/nkQTLrRWda82sCJp2Zd/nlPDEaxojqpqjv6
 KQOFHmxuHx80iCT7OBCDKo1rdOrbQcmZEUSCF/mgZdstCYXrh/Jeoon+A6NJXIeivW+b2VcJ5Fq
 473n3i/5w2TyeAO396gapGWVcEivKKRURokxcGffRledOEaKsXjUba9obJTYQO65Z5XI4WSgun5
 MGo/jFe6eAM80+58nabbSxpMiMYlbe/YeeUFRzg7rR/iDOX7iwAgJIj3MWCMxisQGNQod7int/j
 lEJaWhg==
X-Google-Smtp-Source: AGHT+IHlr8roTMn2cuGoGonMhHc/ACX3Nst0NP0ep1MvcWk9Nc5UTYta77aRfrdasOXwnKrqueXqNA==
X-Received: by 2002:a05:620a:4244:b0:7c0:bb63:5375 with SMTP id
 af79cd13be357-7c956eb119cmr3839285a.4.1745437247437; 
 Wed, 23 Apr 2025 12:40:47 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ae9cf9f7dsm71635691cf.74.2025.04.23.12.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 12:40:47 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: ian.stokes@intel.com, yoan.picchi@foss.arm.com, probb@iol.unh.edu,
 paul.szczepanek@arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net,
 luca.vizzarro@arm.com, thomas.wilks@arm.com, dmarx@iol.unh.edu,
 stephen@networkplumber.org
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC Patch v1 2/5] dts: rework traffic generator inheritance
 structure.
Date: Wed, 23 Apr 2025 15:40:08 -0400
Message-ID: <20250423194011.1447679-3-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250423194011.1447679-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
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
 .../capturing_traffic_generator.py            | 34 ++++++++++
 .../performance_traffic_generator.py          | 62 +++++++++++++++++++
 .../traffic_generator/traffic_generator.py    | 43 +------------
 3 files changed, 97 insertions(+), 42 deletions(-)
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py

diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index e31ba2a9b7..41b70f7f48 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -63,6 +63,40 @@ def is_capturing(self) -> bool:
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
index 0000000000..7a384cf6e0
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
@@ -0,0 +1,62 @@
+"""Performance testing capable traffic generatiors."""
+
+from abc import ABC, abstractmethod
+from dataclasses import dataclass
+from typing import Callable
+
+from scapy.packet import Packet
+
+from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
+
+
+@dataclass(slots=True)
+class PerformanceTrafficStats(ABC):
+    """Data structure for stats offered by a given traffic generator."""
+
+    frame_size: int
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
+        duration: float,  # Default of 60 (in seconds).
+    ) -> PerformanceTrafficStats:
+        """Send packet traffic and acquire associated statistics."""
+        return self._calculate_traffic_stats(packet, duration, self._generate_traffic)
+
+    def setup(self, ports):
+        """Preliminary port setup prior to TG execution."""
+        for port in self._tg_node.ports:
+            self._tg_node.main_session.configure_port_mtu(2000, port)
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
index 804662e114..12b9568d1a 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -11,13 +11,11 @@
 from abc import ABC, abstractmethod
 from typing import Iterable
 
-from scapy.packet import Packet
-
 from framework.config.test_run import TrafficGeneratorConfig
 from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import Port
-from framework.utils import MultiInheritanceBaseClass, get_packet_summaries
+from framework.utils import MultiInheritanceBaseClass
 
 
 class TrafficGenerator(MultiInheritanceBaseClass, ABC):
@@ -56,45 +54,6 @@ def setup(self, ports: Iterable[Port]):
     def teardown(self, ports: Iterable[Port]):
         """Teardown the traffic generator."""
 
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
-
     @abstractmethod
     def close(self) -> None:
         """Free all resources used by the traffic generator."""
-- 
2.47.1

