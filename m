Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C37DC83038
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 05:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D483440609;
	Wed,  2 Jul 2025 07:27:39 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 418F4402EB
 for <dev@dpdk.org>; Wed,  2 Jul 2025 07:27:38 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7d20f79a00dso540322385a.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751434057; x=1752038857; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CckDSgWwynXDpvNV7fzxnLWflmH66sWhGuXag0GCSr4=;
 b=F84AXkJePGXOcw3wFYYKh+rjT686iPXDUPQTZNmx9t3+FuPGVoXw/uSM9VtnFbQ2r5
 MF+PtnEPFA06EYwN4tsCelScUbeObeNiyrmMbSuq5boE8kG9a8KKQQZ+Mcwr+e+R2xYa
 Tyty8CbrgrIrwyPryn0kOERjkUlobWa871zQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751434057; x=1752038857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CckDSgWwynXDpvNV7fzxnLWflmH66sWhGuXag0GCSr4=;
 b=RInkKG2+5juhzsCuCTN1Qj7TbUThHEtBUn9RxquwQakOEerftMHyOybbIfHVehKYRe
 xWxmGG4b1y7VdogGve2eYeZBrXLfiVbDbVRV9xTxuGvF/ZlNA0pA2ChUcBE2nUeNLnw6
 K8cg8IUZ4Ps5yXfolSPVHlb7qcl98a94AaaGROag4ep9BYdGN6QpdaxPDqUD/wBIQfZJ
 NYHfHxPqGJhl88RdyJ2TIgaLtnDHDjIrmL6G3IvOAR5vMlTyvuWISfc+wQGPUHpU3hNh
 X3vm0CjPJYMmJ/HQ3C026Vp3msuKumEIBkoLyqnUTg+62glW8hahmKiXHbdKC/JwY98l
 xkxg==
X-Gm-Message-State: AOJu0YzCDHDAmwctyq8DycaI1H5fUMU8jemZoT466LU98kQK9eRy2Vm/
 5DPdEbXCLSnyVaGjpHdvvoPh5FRPFjNRlQB3kT7AFuN6XF3UhDTlbKO/9pYpqMlEiLA=
X-Gm-Gg: ASbGncsYHpZbdfCEwlue2jo1tdkeyZRHfY2OP+tPQOt45LrwbRvRe16hhhRh7YCZOJM
 pbM6SentnrPu3n7Uct9TlDVTGwCRQ3Pnv5ydPEP9aHisVNisQ9uRdlV/F9BsGXpeZ+Tb+fyMHLO
 6ojOqJSSCLqBDKohPHbHviSplqbWWN9G2wjjogdB476agj/edPS/IYi36mNv8dBBdrZuW7nDuv2
 O3cPA8CrUH41K3y7rvBiEk7aGLMWjVk3k0HqOj2b8gCmbBsIESgvtLWuoC+G4egQdym16VudvLX
 O1xw/gyNSY74366MYJbAP99FicD3BlxxZYR2/hVi6Xu1oabJkPwf3ptsE9dRY6e0
X-Google-Smtp-Source: AGHT+IGasLjVTtdS2MA5RvB1zRtgwgtKqT3wh8mqNnYQEgfgLcOg7B0ckUqPdvNfGdkYx+W95r65XA==
X-Received: by 2002:a05:620a:4689:b0:7d4:43e5:7b52 with SMTP id
 af79cd13be357-7d5c46ffeccmr227489685a.33.1751434057343; 
 Tue, 01 Jul 2025 22:27:37 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d45c0fe6dfsm469274185a.58.2025.07.01.22.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 22:27:36 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, Luca.Vizzarro@arm.com,
 thomas.wilks@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v3 2/5] dts: rework traffic generator inheritance structure
Date: Wed,  2 Jul 2025 01:21:51 -0400
Message-ID: <20250702052154.381690-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702052154.381690-1-probb@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250702052154.381690-1-probb@iol.unh.edu>
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
 .../testbed_model/traffic_generator/scapy.py  | 10 ++-
 .../traffic_generator/traffic_generator.py    | 44 -------------
 4 files changed, 104 insertions(+), 47 deletions(-)
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py

diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index a85858ba07..110244a7b0 100644
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
index 0000000000..59dac6a075
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
@@ -0,0 +1,63 @@
+"""Traffic generators for performance tests which can generate a high number of packets."""
+
+from abc import ABC, abstractmethod
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
+class PerformanceTrafficStats(ABC):
+    """Data structure to store performance statistics for a given test run.
+
+    Attributes:
+        frame_size: The total length of the frame
+        tx_pps: Recorded tx packets per second
+        tx_cps: Recorded tx connections per second
+        tx_bps: Recorded tx bytes per second
+        rx_pps: Recorded rx packets per second
+        rx_bps: Recorded rx bytes per second
+    """
+
+    frame_size: int
+
+    tx_pps: float
+    tx_cps: float
+    tx_bps: float
+
+    rx_pps: float
+    rx_bps: float
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
+        send_mpps: int,
+        duration: float,
+    ) -> PerformanceTrafficStats:
+        """Send packet traffic and acquire associated statistics.
+
+        Args:
+        packet: The packet to send.
+        send_mpps: The millions packets per second send rate.
+        duration: Performance test duration (in seconds).
+
+        Returns:
+            Performance statistics of the generated test.
+        """
+
+    def setup(self, topology: Topology) -> None:
+        """Overrides :meth:`.traffic_generator.TrafficGenerator.setup`."""
+        for port in self._tg_node.ports:
+            self._tg_node.main_session.configure_port_mtu(2000, port)
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index e21ba4ed96..602b93d473 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -26,7 +26,7 @@
 from scapy.packet import Packet
 
 from framework.config.node import OS
-from framework.config.test_run import ScapyTrafficGeneratorConfig
+from framework.config.test_run import TrafficGeneratorConfig
 from framework.exception import InteractiveSSHSessionDeadError, InternalError
 from framework.remote_session.python_shell import PythonShell
 from framework.testbed_model.node import Node
@@ -285,7 +285,7 @@ class also extends :class:`.capturing_traffic_generator.CapturingTrafficGenerato
     first.
     """
 
-    _config: ScapyTrafficGeneratorConfig
+    _config: TrafficGeneratorConfig
     _shell: PythonShell
     _sniffer: ScapyAsyncSniffer
 
@@ -296,7 +296,7 @@ class also extends :class:`.capturing_traffic_generator.CapturingTrafficGenerato
     #: Padding to add to the start of a line for python syntax compliance.
     _python_indentation: ClassVar[str] = " " * 4
 
-    def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs):
+    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
         """Extend the constructor with Scapy TG specifics.
 
         Initializes both the traffic generator and the interactive shell used to handle Scapy
@@ -332,6 +332,10 @@ def setup(self, topology: Topology):
         self._shell.send_command("from scapy.all import *")
         self._shell.send_command("from scapy.contrib.lldp import *")
 
+    def teardown(self):
+        """Overrides :meth:`.traffic_generator.TrafficGenerator.teardown`."""
+        pass
+
     def close(self):
         """Overrides :meth:`.traffic_generator.TrafficGenerator.close`.
 
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index 8f53b07daf..ea3075989d 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -10,14 +10,10 @@
 
 from abc import ABC, abstractmethod
 
-from scapy.packet import Packet
-
 from framework.config.test_run import TrafficGeneratorConfig
 from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.node import Node
-from framework.testbed_model.port import Port
 from framework.testbed_model.topology import Topology
-from framework.utils import get_packet_summaries
 
 
 class TrafficGenerator(ABC):
@@ -54,46 +50,6 @@ def setup(self, topology: Topology):
 
     def teardown(self):
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
2.49.0

