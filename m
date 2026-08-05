Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0261C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 13:52:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 725694066C;
	Thu,  6 Aug 2026 15:51:50 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id A8C3A4027E
 for <dev@dpdk.org>; Wed,  5 Aug 2026 21:27:51 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-934944f2d22so98572185a.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 12:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1785958071; x=1786562871; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CNH4sw64kB0Zlij7NNCqy/NZVctu06pOz5Y+K/B9Z5k=;
 b=QCOU5vyTyKznN2YxxN89BAUyDTKM3x3ToxZ+4bASX08Sb06DyLhpmt0c+y86Ya+gnj
 70BUC7/zdGZK1poYtY11Ai4SCCvRQPEFriB+LrfRFNj7ng/K+1uI4UMXG+FNwij21E6s
 8Rz+AHCv1gdy0SFxpeLlV338LGVBz0EMByRKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785958071; x=1786562871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CNH4sw64kB0Zlij7NNCqy/NZVctu06pOz5Y+K/B9Z5k=;
 b=KaKQWMzMH5KGAtkhRzMzDK0QlU5JqsNd7MUERFqjjq09brXl2QISd1sRv13/jSuVky
 B2aVV3q34FG0WjQLWwTh9SY3x/AstYqTBeWWgsK7LByjX84vTEVJyBBm0+EPz9/Yo4Ox
 5CXk91X9G3fhHAVV2UF9PFYRZLW1FvCs1cXrP1SURwjLYwOtgaBH7ms6hu1mxUa8X0mg
 K4txENMUSSs3uhDR5cu2i0I9Hea03Ir7UPu/XkNkppw9tTdzPjYLhQ6jrduDhAAZ0f79
 tC2QoRdxaOzVZ/nab8ikBsNVNSOYkgPJz70m0hTsozkpdxSrx83xxMp/uCMTrycwJ0kI
 bSiw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roj0k0POMwwmhotfywum84U3V0egajHsbMKhhJ4HSTI0oMvrEPCSmhISUXAjbJ+bXA09pk=@dpdk.org
X-Gm-Message-State: AOJu0Yw/tFF9olv5cx9R/tMnPuCGwdl10/3Gd2CKlq8r7QO3fvObJGcn
 FXo2fLg9Tx3QXMIVLnL8fkb2yl+c6QbWqWAlEBhnyJ6dTEhOnSDl4fHC2NXpkBEGCdI=
X-Gm-Gg: AR+sD1011hmpfwtiGPJdmXNPMYLw/ZsFZw5awJP5RRi5AGCLayaksgCKUe3sS1wcV9F
 pjwYGc8H3yJuBIOh58xfQuI4Km/gIpkyc/TRkBlmA0y+UiqkI0XNbCTFwM2eZeN9k+rlsDgQ63J
 myGsHDUkihyVoiMwhqiy03X8BS/HoVuPs/L8dgznSeJiift6nCcwUCTq8GonFLAbwburwQPbuL5
 54rM1Ko44dr4NyZEJm2o1h/x8Q/uNVGf454n6xTZwG5ic27/W6Rh8ifgPHmvwIbYW5/dHycs8HS
 cHj1IEi7z4Tx1PaDN2O96X2lreqT9C7iAZQKXQ6PpD3Db0O5ue+3Do7DlkpaKQYTyXv1ZUKgONG
 OwNIkYyzL73ol7sQvScKAdHDJNAxpMleNosGfryYqpLtsJT9vYbxUCQp0GL+0S6oUc6ZEY0prGs
 EM7PyqrEgPNx7AXsO58oqKSkQbIohiGpr97T8Ru4F8nJjA8vMoxAwBXxxgYNvhDTe+KomdBWrY9
 MtmYj6BIYR8zMK458J4x9pqv3sa6T7zL+/40B9I
X-Received: by 2002:a05:620a:a010:b0:915:75ba:1797 with SMTP id
 af79cd13be357-9364921bc56mr821872585a.29.1785958070854; 
 Wed, 05 Aug 2026 12:27:50 -0700 (PDT)
Received: from X1-Gen-9.iol.unh.edu ([2606:4100:3880:1210:a1f7:dfad:a461:24e1])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a598792sm225859185a.44.2026.08.05.12.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:27:50 -0700 (PDT)
From: Dillon Ladd <dladd@iol.unh.edu>
To: patrick.robb1997@gmail.com,
	luca.vizzarro@arm.com,
	dev@dpdk.org
Cc: knimoji@iol.unh.edu, llavoie@iol.unh.edu, Dillon Ladd <dladd@iol.unh.edu>,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: fix TRex packet stream handling for line rate testing
Date: Wed,  5 Aug 2026 15:27:32 -0400
Message-ID: <20260805192732.464422-1-dladd@iol.unh.edu>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 15:51:47 +0200
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

Packets were not reaching line rate on certain hardware configurations.
Investigation revealed two root causes in the TRex traffic generator
implementation.

The first issue was that a single unidirectional packet stream could not
adequately represent bidirectional traffic patterns. The second issue was
that TRex ports were not configured with promiscuous mode enabled. When
network devices forward traffic without rewriting L2 addresses, the return
traffic arrives at the traffic generator addressed to the device's ingress
MAC rather than the traffic generator's port MAC. Without promiscuous mode,
the traffic generator discards these packets and reports incomplete
statistics.

This patch addresses both issues by refactoring packet stream creation to
generate two streams per direction, each operating at 50% port capacity for
balanced traffic distribution. Promiscuous mode is now explicitly enabled
on all ports during TRex client setup. Additionally, error handling in the
traffic start procedure has been improved to better distinguish failure
modes and provide more informative diagnostics.

Bugzilla ID: 1977
Fixes: d77d7f04f24c ("dts: add single-core performance test suite")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dillon Ladd <dladd@iol.unh.edu>
---
 .mailmap                                      |  1 +
 dts/api/packet.py                             |  1 +
 .../testbed_model/traffic_generator/trex.py   | 97 +++++++++++++------
 3 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..58107ffe3a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -402,6 +402,7 @@ Dheemanth Mallikarjun <dheemanthm@vmware.com>
 Dhruv Tripathi <dhruv.tripathi@arm.com>
 Diana Wang <na.wang@corigine.com>
 Didier Pallard <didier.pallard@6wind.com>
+Dillon Ladd <dladd@iol.unh.edu>
 Dilshod Urazov <dilshod.urazov@oktetlabs.ru>
 Dima Ruinskiy <dima.ruinskiy@intel.com>
 Dimon Zhao <dimon.zhao@nebula-matrix.com>
diff --git a/dts/api/packet.py b/dts/api/packet.py
index 3dda18e781..9a8c081621 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -348,4 +348,5 @@ def assess_performance_by_packet(
     )
     tg: PerformanceTrafficGenerator = cast(PerformanceTrafficGenerator, get_ctx().perf_tg)
     # TODO: implement @requires for types of traffic generator
+    packet = adjust_addresses([packet])[0]
     return tg.calculate_traffic_and_stats(packet, duration, send_mpps)
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index d53791b0a6..eceb79b1ee 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -9,6 +9,7 @@
 from enum import auto
 from typing import ClassVar
 
+from scapy.layers.inet import IP
 from scapy.packet import Packet
 
 from framework.config.node import OS, NodeConfiguration
@@ -66,7 +67,6 @@ class TrexTrafficGenerator(PerformanceTrafficGenerator):
 
     Attributes:
         stl_client_name: The name of the stateless client used in the stateless API.
-        packet_stream_name: The name of the stateless packet stream used in the stateless API.
     """
 
     _os_session: OSSession
@@ -78,7 +78,6 @@ class TrexTrafficGenerator(PerformanceTrafficGenerator):
     _python_indentation: ClassVar[str] = " " * 4
 
     stl_client_name: ClassVar[str] = "client"
-    packet_stream_name: ClassVar[str] = "stream"
 
     _streaming_mode: TrexStatelessTXModes = TrexStatelessTXModes.STLTXCont
 
@@ -86,6 +85,9 @@ class TrexTrafficGenerator(PerformanceTrafficGenerator):
 
     _trex_app: BlockingApp
 
+    _topology: Topology
+    _stream_names_by_port: dict[int, list[str]]
+
     def __init__(self, tg_node: Node, config: TrexTrafficGeneratorConfig) -> None:
         """Initialize the TRex server.
 
@@ -108,6 +110,7 @@ def __init__(self, tg_node: Node, config: TrexTrafficGeneratorConfig) -> None:
     def setup(self, topology: Topology):
         """Initialize and start a TRex server process."""
         super().setup(topology)
+        self._topology = topology
 
         self._shell = PythonShell(self._tg_node, "TRex-client", privileged=True)
 
@@ -196,30 +199,54 @@ def _setup_trex_client(self) -> None:
         procedure = [
             f"{self.stl_client_name}.connect()",
             f"{self.stl_client_name}.reset(ports = [0, 1])",
+            f"{self.stl_client_name}.set_port_attr(ports=[0, 1], promiscuous=True)",
             f"{self.stl_client_name}.clear_stats()",
-            f"{self.stl_client_name}.add_streams({self.packet_stream_name}, ports=[0, 1])",
         ]
 
+        for port_id, stream_names in self._stream_names_by_port.items():
+            procedure.append(
+                f"{self.stl_client_name}.add_streams("
+                f"[{', '.join(stream_names)}], ports=[{port_id}])"
+            )
+
         for command in procedure:
             self._shell.send_command(command)
 
     def _create_packet_stream(self, packet: Packet) -> None:
-        """Create TRex packet stream with the given packet.
+        """Create TRex packet streams, two per direction.
 
         Args:
             packet: The packet being used for the performance test.
         """
-        # Create the tx packet on the TG shell
-        self._shell.send_command(f"packet={packet.command()}")
-
-        packet_stream = [
-            f"{self.packet_stream_name} = trex.stl.trex_stl_streams.STLStream(",
-            f"name='Test_{len(packet)}_bytes',",
-            "packet=trex.stl.trex_stl_packet_builder_scapy.STLPktBuilder(pkt=packet),",
-            f"mode=trex.stl.trex_stl_streams.{self._streaming_mode}(percentage=100),",
-            ")",
-        ]
-        self._shell.send_command("\n".join(packet_stream))
+        forward: Packet = packet.copy()
+        reverse: Packet = packet.copy()
+        reverse.src = "52:00:00:00:00:00"
+        reverse.dst = self._topology.sut_port_egress.mac_address
+
+        self._stream_names_by_port = {}
+
+        for port_id, direction_packet in ((0, forward), (1, reverse)):
+            stream_names: list[str] = []
+            ip_prefix: str = direction_packet[IP].dst.rsplit(".", 1)[0]
+
+            for index in range(2):
+                packet_var = f"packet_p{port_id}_{index}"
+                stream_var = f"stream_p{port_id}_{index}"
+                direction_packet[IP].dst = f"{ip_prefix}.{index}"
+                self._shell.send_command(f"{packet_var}={direction_packet.command()}")
+
+                # percentage=50 per stream: two streams share the port.
+                stream_definition = [
+                    f"{stream_var} = trex.stl.trex_stl_streams.STLStream(",
+                    f"name='Test_{len(packet)}_bytes_p{port_id}_{index}',",
+                    "packet=trex.stl.trex_stl_packet_builder_scapy.STLPktBuilder("
+                    f"pkt={packet_var}),",
+                    f"mode=trex.stl.trex_stl_streams.{self._streaming_mode}(percentage=50),",
+                    ")",
+                ]
+                self._shell.send_command("\n".join(stream_definition))
+                stream_names.append(stream_var)
+            self._stream_names_by_port[port_id] = stream_names
 
     def _send_traffic_and_get_stats(
         self, duration: float, send_mpps: float | None = None, retry_attempts: int = 5
@@ -236,28 +263,38 @@ def _send_traffic_and_get_stats(
             retry_attempts: The number of times to retry this command on failure.
 
         Raises:
-            SSHTimeoutError: If TRex fails to send traffic in the allotted attempts.
+            SSHTimeoutError: If TRex refuses to start traffic in the allotted attempts.
         """
-        link_down = True
+        started = False
         attempt = 0
 
-        while link_down and attempt < retry_attempts:
-            if send_mpps:
-                result = self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
-                    mult = '{send_mpps}mpps',
-                    duration = {duration})""")
-            else:
-                result = self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
-                    mult = '100%',
-                    duration = {duration})""")
-            link_down = "link is DOWN" in result
-            if link_down:
+        mult = f"'{send_mpps}mpps'" if send_mpps else "'100%'"
+        while not started and attempt < retry_attempts:
+            # Capture the RC and verify that a refused start can never silently produce a
+            # 0.0 Mpps measurement.
+            self._shell.send_command("_start_rc = None")
+            result = self._shell.send_command(
+                f"_start_rc = {self.stl_client_name}.start(ports=[0, 1], "
+                f"mult={mult}, duration={duration})"
+            )
+            ok = self._shell.send_command(
+                "bool(_start_rc is not None"
+                " and (not hasattr(_start_rc, 'good') or _start_rc.good()))"
+            )
+            started = "True" in ok
+            if not started:
+                error_text = result + self._shell.send_command(
+                    "str(getattr(_start_rc, 'err', lambda: '')()) if _start_rc is not None else ''"
+                )
                 self._logger.info(
-                    f"Generate traffic command failed (attempt {attempt + 1} of {retry_attempts})"
+                    f"Traffic start refused (attempt {attempt + 1} of {retry_attempts}): "
+                    f"{error_text.strip()}"
                 )
+                if "link is DOWN" not in error_text:
+                    raise SSHTimeoutError(f"TRex refused to start traffic: {error_text.strip()}")
                 time.sleep(0.25)
             attempt += 1
-        if link_down:
+        if not started:
             raise SSHTimeoutError("Link failed to come up, Traffic could not be generated.")
 
         time.sleep(duration)
-- 
2.53.0

