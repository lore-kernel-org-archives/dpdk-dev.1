Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C03C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:28:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A2A440655;
	Thu, 26 Jun 2025 17:28:07 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9F7434021F
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:28:03 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7d09f11657cso111076785a.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750951683; x=1751556483; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VM89Dc9IpCSaWHp/WKsd/SkDD5strNfXhEwEcHgkKo=;
 b=YRmW05UX3wvDy7KLPI+455lmkKv6XKMDp8rGpuPzEs1MEzuW+eQbRLZ3I2LjIIn02j
 hetS3Vj2ewWwklurQZOi14iviztZXy0FRO1jBWsejrqm89guMIe56SoFNjZBgZ2fJUfI
 uNVavoj+Yw4g7BtNDSCkExSpa8YQi9isZYbp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750951683; x=1751556483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VM89Dc9IpCSaWHp/WKsd/SkDD5strNfXhEwEcHgkKo=;
 b=o0ooq5tWeVekWqu5I2nKye3hlcFqGv7idRcAsO8EVJqUIkvK5OzePgmgPJX1LMnSuK
 zK0Dx8fueMMTohDkPQz+kYVLR0gq8/rBiwJcEyIIrujliH83IuF1MVIG8c9FTaWzhrYG
 3NNmfEXrzZMG8FZoLZ3LSSO5+FwDLY+d83U9MMVLkIcefGR1pobpgYGbimmuEfxM9kB6
 u5qIIBPVBTngvJSa4BRiW82XxB8urmBb00W6vHpSPHEz6VfZxnR7XLKyoBdkVdKoeH6a
 W/PkD6u2y/EVNbR1of92bUbxNYU4CmPCrbWE6qzOqGYeCWuUjO4SiQfUOF60eKIrzLLH
 Ks3A==
X-Gm-Message-State: AOJu0YyV+2crKTi1HP/tcbmMd24hKJTZbhM3ddlRivGjsFrErT61pW/o
 VjVkgJ725UaSWnjsvJc4mI09Ku6sDJLlCg5R6u/SynJE0NM5woEAdNPHGRsZrOVjY7E=
X-Gm-Gg: ASbGnctbO/rp6+HMReT5rqYq/RBAyzSLobxmGgxcLhYmp12ql/VkdB8LSHjhjJojJbc
 62+C+7hDRBEiQAXkcaIUxko6Lsf0sR5Btx7u/Tp79i54UgM1zx2s5GymEvwI63eK8GvCCrRzsID
 Ab0LlnQG1Ww9zcNvGQ4vcqSCg9d1VQVjDtjddpU+5mz0CDlS6sZ/ix5t8JLnjM0MebIP5WzVmpS
 bUgpPZOngWVc9mV5MSNiRk6uToyVxTTZWw4f058Mio0GqHpQC63+XmQ4fy54K9Ndx7LRo2dDiTF
 JtLArGZOtgYkfxdvSoeq93XiOPiEm7Z4ZclcBNnzAbRCLZOtnuM4XAYDKudlirMDP6jH6dUt
X-Google-Smtp-Source: AGHT+IHyKBDbGEyzti7xhL3NAndbTiOBxtUIpIaiU7Fuhce9/1F8mYLi2mEj218mf/2VaJeAWNKahw==
X-Received: by 2002:a05:620a:9046:b0:7d3:8a6b:d24d with SMTP id
 af79cd13be357-7d43bac736fmr441800885a.24.1750951682689; 
 Thu, 26 Jun 2025 08:28:02 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443219fb7sm12287085a.80.2025.06.26.08.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:28:02 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 3/4] dts: modify existing suites to work with VFs
Date: Thu, 26 Jun 2025 11:27:54 -0400
Message-ID: <20250626152755.197560-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626152755.197560-1-dmarx@iol.unh.edu>
References: <20250617201358.708638-1-dmarx@iol.unh.edu>
 <20250626152755.197560-1-dmarx@iol.unh.edu>
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

Modify existing test suites to use broadcast destination
MAC addresses when possible, rather than a default
MAC address assigned by DTS during execution.

VFs do not consistently receive and forward packets
unless the MAC address is broadcast or matches the
VF address, even with promiscuous mode enabled.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_checksum_offload.py   | 69 ++++++++++++-----------
 dts/tests/TestSuite_dual_vlan.py          |  6 +-
 dts/tests/TestSuite_dynamic_queue_conf.py |  2 +-
 dts/tests/TestSuite_mtu.py                |  7 ++-
 dts/tests/TestSuite_packet_capture.py     | 23 ++++----
 dts/tests/TestSuite_queue_start_stop.py   |  2 +-
 dts/tests/TestSuite_vlan.py               |  4 +-
 7 files changed, 62 insertions(+), 51 deletions(-)

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index c9efdcaa1c..9d8d38b0f0 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -89,8 +89,13 @@ def send_packet_and_verify_checksum(
             if testpmd_packet.l4_dport == id:
                 is_IP = PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags
                 is_L4 = PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags
-        self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
-        self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
+        try:
+            self.verify(
+                is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag."
+            )
+            self.verify(is_IP == good_IP, "IP checksum flag did not match expected checksum flag.")
+        except NameError:
+            self.verify(False, f"Test packet {packet} was not found in verbose output.")
 
     def setup_hw_offload(self, testpmd: TestPmdShell) -> None:
         """Sets IP, UDP, and TCP layers to hardware offload.
@@ -122,10 +127,10 @@ def test_insert_checksums(self) -> None:
         dport_id = 50000
         payload = b"xxxxx"
         packet_list = [
-            Ether() / IP() / UDP(dport=dport_id) / Raw(payload),
-            Ether() / IP() / TCP(dport=dport_id) / Raw(payload),
-            Ether() / IPv6(src="::1") / UDP(dport=dport_id) / Raw(payload),
-            Ether() / IPv6(src="::1") / TCP(dport=dport_id) / Raw(payload),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP(dport=dport_id) / Raw(payload),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / TCP(dport=dport_id) / Raw(payload),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6(src="::1") / UDP(dport=dport_id) / Raw(payload),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6(src="::1") / TCP(dport=dport_id) / Raw(payload),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -154,10 +159,10 @@ def test_no_insert_checksums(self) -> None:
         dport_id = 50000
         payload = b"xxxxx"
         packet_list = [
-            Ether() / IP() / UDP(dport=dport_id) / Raw(payload),
-            Ether() / IP() / TCP(dport=dport_id) / Raw(payload),
-            Ether() / IPv6(src="::1") / UDP(dport=dport_id) / Raw(payload),
-            Ether() / IPv6(src="::1") / TCP(dport=dport_id) / Raw(payload),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP(dport=dport_id) / Raw(payload),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / TCP(dport=dport_id) / Raw(payload),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6(src="::1") / UDP(dport=dport_id) / Raw(payload),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6(src="::1") / TCP(dport=dport_id) / Raw(payload),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -184,10 +189,10 @@ def test_l4_rx_checksum(self) -> None:
         """
         dport_id = 50000
         packet_list = [
-            Ether() / IP() / UDP(dport=dport_id),
-            Ether() / IP() / TCP(dport=dport_id),
-            Ether() / IP() / UDP(chksum=0xF, dport=dport_id),
-            Ether() / IP() / TCP(chksum=0xF, dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / TCP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP(chksum=0xF, dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / TCP(chksum=0xF, dport=dport_id),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -217,10 +222,10 @@ def test_l3_rx_checksum(self) -> None:
         """
         dport_id = 50000
         packet_list = [
-            Ether() / IP() / UDP(dport=dport_id),
-            Ether() / IP() / TCP(dport=dport_id),
-            Ether() / IP(chksum=0xF) / UDP(dport=dport_id),
-            Ether() / IP(chksum=0xF) / TCP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / TCP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP(chksum=0xF) / UDP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP(chksum=0xF) / TCP(dport=dport_id),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -250,14 +255,14 @@ def test_validate_rx_checksum(self) -> None:
         """
         dport_id = 50000
         packet_list = [
-            Ether() / IP() / UDP(dport=dport_id),
-            Ether() / IP() / TCP(dport=dport_id),
-            Ether() / IPv6(src="::1") / UDP(dport=dport_id),
-            Ether() / IPv6(src="::1") / TCP(dport=dport_id),
-            Ether() / IP(chksum=0x0) / UDP(chksum=0xF, dport=dport_id),
-            Ether() / IP(chksum=0x0) / TCP(chksum=0xF, dport=dport_id),
-            Ether() / IPv6(src="::1") / UDP(chksum=0xF, dport=dport_id),
-            Ether() / IPv6(src="::1") / TCP(chksum=0xF, dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / TCP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6(src="::1") / UDP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6(src="::1") / TCP(dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP(chksum=0x0) / UDP(chksum=0xF, dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP(chksum=0x0) / TCP(chksum=0xF, dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6(src="::1") / UDP(chksum=0xF, dport=dport_id),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6(src="::1") / TCP(chksum=0xF, dport=dport_id),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -297,22 +302,22 @@ def test_vlan_checksum(self) -> None:
         dport_id = 50000
         payload = b"xxxxx"
         packet_list = [
-            Ether()
+            Ether(dts="FF:FF:FF:FF:FF:FF")
             / Dot1Q(vlan=1)
             / IP(chksum=0x0)
             / UDP(chksum=0xF, dport=dport_id)
             / Raw(payload),
-            Ether()
+            Ether(dts="FF:FF:FF:FF:FF:FF")
             / Dot1Q(vlan=1)
             / IP(chksum=0x0)
             / TCP(chksum=0xF, dport=dport_id)
             / Raw(payload),
-            Ether()
+            Ether(dts="FF:FF:FF:FF:FF:FF")
             / Dot1Q(vlan=1)
             / IPv6(src="::1")
             / UDP(chksum=0xF, dport=dport_id)
             / Raw(payload),
-            Ether()
+            Ether(dts="FF:FF:FF:FF:FF:FF")
             / Dot1Q(vlan=1)
             / IPv6(src="::1")
             / TCP(chksum=0xF, dport=dport_id)
@@ -353,8 +358,8 @@ def test_validate_sctp_checksum(self) -> None:
         """
         dport_id = 50000
         packet_list = [
-            Ether() / IP() / UDP(dport=dport_id) / SCTP(),
-            Ether() / IP() / UDP(dport=dport_id) / SCTP(chksum=0xF),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP(dport=dport_id) / SCTP(),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP(dport=dport_id) / SCTP(chksum=0xF),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index 6af503528d..de58af8c74 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -197,7 +197,7 @@ def insert_second_vlan(self) -> None:
             testpmd.tx_vlan_set(port=self.tx_port, enable=True, vlan=self.vlan_insert_tag)
             testpmd.start()
             recv = self.send_packet_and_capture(
-                Ether() / Dot1Q(vlan=self.outer_vlan_tag) / Raw(b"X" * 20)
+                Ether(dst="FF:FF:FF:FF:FF:FF") / Dot1Q(vlan=self.outer_vlan_tag) / Raw(b"X" * 20)
             )
             self.verify(len(recv) > 0, "Did not receive any packets when testing VLAN insertion.")
             self.verify(
@@ -224,7 +224,7 @@ def all_vlan_functions(self) -> None:
             VLAN functions work as expected.
         """
         send_pkt = (
-            Ether()
+            Ether(dst="FF:FF:FF:FF:FF:FF")
             / Dot1Q(vlan=self.outer_vlan_tag)
             / Dot1Q(vlan=self.inner_vlan_tag)
             / Raw(b"X" * 20)
@@ -264,7 +264,7 @@ def maintains_priority(self) -> None:
             Priorities are unchanged.
         """
         pkt = (
-            Ether()
+            Ether(dst="FF:FF:FF:FF:FF:FF")
             / Dot1Q(vlan=self.outer_vlan_tag, prio=1)
             / Dot1Q(vlan=self.inner_vlan_tag, prio=2)
             / Raw(b"X" * 20)
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index 344dd540eb..62da208c45 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -165,7 +165,7 @@ def send_packets_with_different_addresses(self, number_of_packets: int) -> None:
                 generator.
         """
         packets_to_send = [
-            Ether()
+            Ether(dst="FF:FF:FF:FF:FF:FF")
             / IP(src=self.src_addr, dst=f"{self.dst_address_subnet}.{(i % 254) + 1}")
             / Raw()
             for i in range(number_of_packets)
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index af6ab88501..ee5242a9c1 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -68,7 +68,12 @@ def send_packet_and_verify(self, pkt_size: int, should_receive: bool) -> None:
         """
         padding = pkt_size - IP_HEADER_LEN
         # Insert '    ' as placeholder 'CRC' error correction.
-        packet = Ether() / Raw(load="    ") / IP(len=pkt_size) / Raw(load="X" * padding)
+        packet = (
+            Ether(dst="FF:FF:FF:FF:FF:FF")
+            / Raw(load="    ")
+            / IP(len=pkt_size)
+            / Raw(load="X" * padding)
+        )
         received_packets = self.send_packet_and_capture(packet)
         found = any(
             ("X" * padding) in str(packets.load)
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index e162bded87..4cefdc97d3 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -28,6 +28,7 @@
 
 from framework.context import get_ctx
 from framework.params import Params
+from framework.params.testpmd import SimpleForwardingModes
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.remote_session.interactive_shell import InteractiveShell
 from framework.remote_session.testpmd_shell import TestPmdShell
@@ -118,16 +119,16 @@ def set_up_suite(self) -> None:
         Prepare the packets, file paths and queue range to be used in the test suite.
         """
         self.packets = [
-            Ether() / IP() / Raw(b"\0" * 60),
-            Ether() / IP() / TCP() / Raw(b"\0" * 60),
-            Ether() / IP() / UDP() / Raw(b"\0" * 60),
-            Ether() / IP() / SCTP() / Raw(b"\0" * 40),
-            Ether() / IPv6() / TCP() / Raw(b"\0" * 60),
-            Ether() / IPv6() / UDP() / Raw(b"\0" * 60),
-            Ether() / IP() / IPv6() / SCTP() / Raw(b"\0" * 40),
-            Ether() / Dot1Q() / IP() / UDP() / Raw(b"\0" * 40),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / Raw(b"\0" * 60),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / TCP() / Raw(b"\0" * 60),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / UDP() / Raw(b"\0" * 60),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / SCTP() / Raw(b"\0" * 40),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6() / TCP() / Raw(b"\0" * 60),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IPv6() / UDP() / Raw(b"\0" * 60),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / IPv6() / SCTP() / Raw(b"\0" * 40),
+            Ether(dst="FF:FF:FF:FF:FF:FF") / Dot1Q() / IP() / UDP() / Raw(b"\0" * 40),
             Ether(dst="FF:FF:FF:FF:FF:FF", type=0x88F7) / Raw(b"\0" * 60),
-            Ether(type=0x88CC)
+            Ether(dst="FF:FF:FF:FF:FF:FF", type=0x88CC)
             / LLDPDUChassisID(subtype=4, id=self.topology.tg_port_egress.mac_address)
             / LLDPDUPortID(subtype=5, id="Test Id")
             / LLDPDUTimeToLive(ttl=180)
@@ -192,7 +193,7 @@ def test_dumpcap(self) -> None:
             * The expected packets are the same as the Rx packets.
             * The Tx packets are the same as the packets received from Scapy.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start()
             received_packets = self._send_and_dump()
 
@@ -221,7 +222,7 @@ def test_dumpcap_filter(self) -> None:
         Verify:
             * The dumped packets did not contain any of the packets meant for filtering.
         """
-        with TestPmdShell() as testpmd:
+        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
             testpmd.start()
             self._send_and_dump("tcp", rx_only=True)
             filtered_packets = [
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_start_stop.py
index d739ddedfe..3a5d4b6147 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_start_stop.py
@@ -42,7 +42,7 @@ def send_packet_and_verify(self, should_receive: bool = True) -> None:
         Args:
             should_receive: Indicate whether the packet should be received.
         """
-        packet = Ether() / IP() / Raw(load="xxxxx")
+        packet = Ether(dst="FF:FF:FF:FF:FF:FF") / IP() / Raw(load="xxxxx")
         received = self.send_packet_and_capture(packet)
         contains_packet = any(
             packet.haslayer(Raw) and b"xxxxx" in packet.load for packet in received
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index d2a9e614d4..1cc5a200d4 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -48,7 +48,7 @@ def send_vlan_packet_and_verify(self, should_receive: bool, strip: bool, vlan_id
                 (as it has been stripped off.)
             vlan_id: Expected VLAN ID.
         """
-        packet = Ether() / Dot1Q(vlan=vlan_id) / Raw(load="xxxxx")
+        packet = Ether(dst="FF:FF:FF:FF:FF:FF") / Dot1Q(vlan=vlan_id) / Raw(load="xxxxx")
         received_packets = self.send_packet_and_capture(packet)
         test_packet = None
         for packet in received_packets:
@@ -83,7 +83,7 @@ def send_packet_and_verify_insertion(self, expected_id: int) -> None:
         Args:
             expected_id: The VLAN id that is being inserted through tx_offload configuration.
         """
-        packet = Ether() / Raw(load="xxxxx")
+        packet = Ether(dst="FF:FF:FF:FF:FF:FF") / Raw(load="xxxxx")
         received_packets = self.send_packet_and_capture(packet)
         test_packet = None
         for packet in received_packets:
-- 
2.49.0

