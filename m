Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02D0C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 21:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5999540DDA;
	Thu,  6 Mar 2025 22:47:55 +0100 (CET)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7E9F840E09
 for <dev@dpdk.org>; Thu,  6 Mar 2025 22:47:53 +0100 (CET)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-47520132245so8496911cf.2
 for <dev@dpdk.org>; Thu, 06 Mar 2025 13:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741297673; x=1741902473; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GE8KEyWdtCGv7wwuj4vvJxHPO7JUvhppXlOX4vIm4xU=;
 b=geqwJxxQLbX9XbURXbLhRPzIRXM7d69fCZMb/2c+mEwA9O+yspneXC58/iiz0C3489
 8UsKo7CCSDcCP7FI7o6s81Qy2AdMFUwZHJ2QY13EgE5ML5wsuJTVv3SrIPkdHA3IiNQg
 CmTu3dwB43r/PCciM+hRhK/62B1pEZqCHoiyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741297673; x=1741902473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GE8KEyWdtCGv7wwuj4vvJxHPO7JUvhppXlOX4vIm4xU=;
 b=h6IJ/DKW/wHe7FWrsNUnqYgEjc+DFAj9hIYTbtbHWP61qpYCoWJGG4i/IaeMWHamxE
 HM8wQbL/gWbw9MeXv5K1O/03Lr4D3gewB12RMZMKpIETK3XzUJSdOrmH24PrR/6YfNEz
 /BYHCcJly4e4SXEHPHVvRmryFedciyw0DN3f+6fOfKrC1eZZ1aZYZaGJ6ZYpineS31+v
 HtqfOAnVEGWC/AFtabY/dYWAxjGGKc5YYeg4detfZIMIAB61VxJtawH+tOMectc5nPph
 51omcHyE74JtyjYeCKZT/vGuFy9vhD695W6n+F/INkItUOhCszVjXRJWlVn1pfAACo1V
 ee6g==
X-Gm-Message-State: AOJu0YzUlojXIwKSe8nQ2HjjDpIVjQLkHJrHP6FdTjVxoIeFsP3PgczM
 ArQnlm2GGsOTaw1x2IyAd7LAtkFtdmbE+uPwd6j64A0N6gWnS65q6HP4QF/x/8Y=
X-Gm-Gg: ASbGnctzbIRL9AjafzMS7PbujLuidRKTYeuKmdAjVnRasKBzJlRSOcXhtyqrR6ktGJr
 l1186GNggzE6YT+B3x1L8cb91X++pcHZyeThRDeBtTvQbO25Ciu1TvQE07qF9Fw9ozgxjWnzpx7
 X8uO707n0Jyj/VCe/A9Wt5Q9oms4CRIkyR3euiV26s5zCAGqZyUD9712XM4PdyuFtN8MQiu5vfw
 1aAfCLSvy7V4ptvsJHEO9IJYQZXYTf44s6e4vSJlYlOCeFmSD6yWytaC6tNCL5r9n5EwtZeU9cm
 gKNulEboitsjJqu/Eot341kUhPv/9hNLcEdqCkWQp9fikNZhFkDhypXYjDiswSbqLTqnxi8qiBl
 0G5GZEvRH
X-Google-Smtp-Source: AGHT+IEilQEeS+FSza12WeBcZx0Dy/dl+foJH0N9+HGXIEvQkMswN6up6o8C1FccFaU1GwTy5TvYQw==
X-Received: by 2002:ac8:5f47:0:b0:475:74c:c86e with SMTP id
 d75a77b69052e-476109af373mr11735061cf.23.1741297672704; 
 Thu, 06 Mar 2025 13:47:52 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751db4ca3fsm11892341cf.70.2025.03.06.13.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 13:47:52 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 2/4] dts: change verification field in checksum offload
 suite
Date: Thu,  6 Mar 2025 16:47:45 -0500
Message-ID: <20250306214747.579340-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306214747.579340-1-dmarx@iol.unh.edu>
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
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

Changes the checksum offload testing suite to use layer 4
destination ports as packet verification IDs.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_checksum_offload.py | 130 ++++++++++++++----------
 1 file changed, 77 insertions(+), 53 deletions(-)

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index b38d73421b..83879b0512 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -70,7 +70,7 @@ def send_packets_and_verify(
             )
 
     def send_packet_and_verify_checksum(
-        self, packet: Packet, good_L4: bool, good_IP: bool, testpmd: TestPmdShell, id: str
+        self, packet: Packet, good_L4: bool, good_IP: bool, testpmd: TestPmdShell, id: int
     ) -> None:
         """Send packet and verify verbose output matches expected output.
 
@@ -81,13 +81,13 @@ def send_packet_and_verify_checksum(
             good_IP: Verifies RTE_MBUF_F_RX_IP_CKSUM_GOOD in verbose output
                 if :data:`True`, or RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN if :data:`False`.
             testpmd: Testpmd shell session to analyze verbose output of.
-            id: The destination mac address that matches the sent packet in verbose output.
+            id: The destination port that matches the sent packet in verbose output.
         """
         testpmd.start()
         self.send_packet_and_capture(packet=packet)
         verbose_output = testpmd.extract_verbose_output(testpmd.stop())
         for testpmd_packet in verbose_output:
-            if testpmd_packet.dst_mac == id:
+            if testpmd_packet.l4_dport == id:
                 is_IP = PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD in testpmd_packet.ol_flags
                 is_L4 = PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD in testpmd_packet.ol_flags
         self.verify(is_L4 == good_L4, "Layer 4 checksum flag did not match expected checksum flag.")
@@ -120,13 +120,13 @@ def test_insert_checksums(self) -> None:
             Verify packets are received.
             Verify packet checksums match the expected flags.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         payload = b"xxxxx"
         packet_list = [
-            Ether(dst=mac_id) / IP() / UDP() / Raw(payload),
-            Ether(dst=mac_id) / IP() / TCP() / Raw(payload),
-            Ether(dst=mac_id) / IPv6(src="::1") / UDP() / Raw(payload),
-            Ether(dst=mac_id) / IPv6(src="::1") / TCP() / Raw(payload),
+            Ether() / IP() / UDP(dport=dport_id) / Raw(payload),
+            Ether() / IP() / TCP(dport=dport_id) / Raw(payload),
+            Ether() / IPv6(src="::1") / UDP(dport=dport_id) / Raw(payload),
+            Ether() / IPv6(src="::1") / TCP(dport=dport_id) / Raw(payload),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -136,7 +136,7 @@ def test_insert_checksums(self) -> None:
             self.send_packets_and_verify(packet_list=packet_list, load=payload, should_receive=True)
             for i in range(0, len(packet_list)):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
     @func_test
@@ -152,13 +152,13 @@ def test_no_insert_checksums(self) -> None:
             Verify packets are received.
             Verify packet checksums match the expected flags.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         payload = b"xxxxx"
         packet_list = [
-            Ether(dst=mac_id) / IP() / UDP() / Raw(payload),
-            Ether(dst=mac_id) / IP() / TCP() / Raw(payload),
-            Ether(dst=mac_id) / IPv6(src="::1") / UDP() / Raw(payload),
-            Ether(dst=mac_id) / IPv6(src="::1") / TCP() / Raw(payload),
+            Ether() / IP() / UDP(dport=dport_id) / Raw(payload),
+            Ether() / IP() / TCP(dport=dport_id) / Raw(payload),
+            Ether() / IPv6(src="::1") / UDP(dport=dport_id) / Raw(payload),
+            Ether() / IPv6(src="::1") / TCP(dport=dport_id) / Raw(payload),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -167,7 +167,7 @@ def test_no_insert_checksums(self) -> None:
             self.send_packets_and_verify(packet_list=packet_list, load=payload, should_receive=True)
             for i in range(0, len(packet_list)):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
     @func_test
@@ -183,12 +183,12 @@ def test_l4_rx_checksum(self) -> None:
         Verify:
             Verify packet checksums match the expected flags.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IP() / UDP(),
-            Ether(dst=mac_id) / IP() / TCP(),
-            Ether(dst=mac_id) / IP() / UDP(chksum=0xF),
-            Ether(dst=mac_id) / IP() / TCP(chksum=0xF),
+            Ether() / IP() / UDP(dport=dport_id),
+            Ether() / IP() / TCP(dport=dport_id),
+            Ether() / IP() / UDP(chksum=0xF, dport=dport_id),
+            Ether() / IP() / TCP(chksum=0xF, dport=dport_id),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -196,11 +196,11 @@ def test_l4_rx_checksum(self) -> None:
             self.setup_hw_offload(testpmd=testpmd)
             for i in range(0, 2):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )
             for i in range(2, 4):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
     @func_test
@@ -216,12 +216,12 @@ def test_l3_rx_checksum(self) -> None:
         Verify:
             Verify packet checksums match the expected flags.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IP() / UDP(),
-            Ether(dst=mac_id) / IP() / TCP(),
-            Ether(dst=mac_id) / IP(chksum=0xF) / UDP(),
-            Ether(dst=mac_id) / IP(chksum=0xF) / TCP(),
+            Ether() / IP() / UDP(dport=dport_id),
+            Ether() / IP() / TCP(dport=dport_id),
+            Ether() / IP(chksum=0xF) / UDP(dport=dport_id),
+            Ether() / IP(chksum=0xF) / TCP(dport=dport_id),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -229,11 +229,11 @@ def test_l3_rx_checksum(self) -> None:
             self.setup_hw_offload(testpmd=testpmd)
             for i in range(0, 2):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )
             for i in range(2, 4):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=True, good_IP=False, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=True, good_IP=False, testpmd=testpmd, id=dport_id
                 )
 
     @func_test
@@ -249,16 +249,16 @@ def test_validate_rx_checksum(self) -> None:
         Verify:
             Verify packet checksums match the expected flags.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IP() / UDP(),
-            Ether(dst=mac_id) / IP() / TCP(),
-            Ether(dst=mac_id) / IPv6(src="::1") / UDP(),
-            Ether(dst=mac_id) / IPv6(src="::1") / TCP(),
-            Ether(dst=mac_id) / IP(chksum=0x0) / UDP(chksum=0xF),
-            Ether(dst=mac_id) / IP(chksum=0x0) / TCP(chksum=0xF),
-            Ether(dst=mac_id) / IPv6(src="::1") / UDP(chksum=0xF),
-            Ether(dst=mac_id) / IPv6(src="::1") / TCP(chksum=0xF),
+            Ether() / IP() / UDP(dport=dport_id),
+            Ether() / IP() / TCP(dport=dport_id),
+            Ether() / IPv6(src="::1") / UDP(dport=dport_id),
+            Ether() / IPv6(src="::1") / TCP(dport=dport_id),
+            Ether() / IP(chksum=0x0) / UDP(chksum=0xF, dport=dport_id),
+            Ether() / IP(chksum=0x0) / TCP(chksum=0xF, dport=dport_id),
+            Ether() / IPv6(src="::1") / UDP(chksum=0xF, dport=dport_id),
+            Ether() / IPv6(src="::1") / TCP(chksum=0xF, dport=dport_id),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -266,15 +266,19 @@ def test_validate_rx_checksum(self) -> None:
             self.setup_hw_offload(testpmd=testpmd)
             for i in range(0, 4):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
                 )
             for i in range(4, 6):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=False, good_IP=False, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i],
+                    good_L4=False,
+                    good_IP=False,
+                    testpmd=testpmd,
+                    id=dport_id,
                 )
             for i in range(6, 8):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
     @requires(NicCapability.RX_OFFLOAD_VLAN)
@@ -291,13 +295,29 @@ def test_vlan_checksum(self) -> None:
         Verify:
             Verify packet checksums match the expected flags.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         payload = b"xxxxx"
         packet_list = [
-            Ether(dst=mac_id) / Dot1Q(vlan=1) / IP(chksum=0x0) / UDP(chksum=0xF) / Raw(payload),
-            Ether(dst=mac_id) / Dot1Q(vlan=1) / IP(chksum=0x0) / TCP(chksum=0xF) / Raw(payload),
-            Ether(dst=mac_id) / Dot1Q(vlan=1) / IPv6(src="::1") / UDP(chksum=0xF) / Raw(payload),
-            Ether(dst=mac_id) / Dot1Q(vlan=1) / IPv6(src="::1") / TCP(chksum=0xF) / Raw(payload),
+            Ether()
+            / Dot1Q(vlan=1)
+            / IP(chksum=0x0)
+            / UDP(chksum=0xF, dport=dport_id)
+            / Raw(payload),
+            Ether()
+            / Dot1Q(vlan=1)
+            / IP(chksum=0x0)
+            / TCP(chksum=0xF, dport=dport_id)
+            / Raw(payload),
+            Ether()
+            / Dot1Q(vlan=1)
+            / IPv6(src="::1")
+            / UDP(chksum=0xF, dport=dport_id)
+            / Raw(payload),
+            Ether()
+            / Dot1Q(vlan=1)
+            / IPv6(src="::1")
+            / TCP(chksum=0xF, dport=dport_id)
+            / Raw(payload),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -307,11 +327,15 @@ def test_vlan_checksum(self) -> None:
             self.send_packets_and_verify(packet_list=packet_list, load=payload, should_receive=True)
             for i in range(0, 2):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=False, good_IP=False, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i],
+                    good_L4=False,
+                    good_IP=False,
+                    testpmd=testpmd,
+                    id=dport_id,
                 )
             for i in range(2, 4):
                 self.send_packet_and_verify_checksum(
-                    packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=mac_id
+                    packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
     @requires(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
@@ -328,10 +352,10 @@ def test_validate_sctp_checksum(self) -> None:
         Verify:
             Verify packet checksums match the expected flags.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IP() / SCTP(),
-            Ether(dst=mac_id) / IP() / SCTP(chksum=0xF),
+            Ether() / IP() / UDP(dport=dport_id) / SCTP(),
+            Ether() / IP() / UDP(dport=dport_id) / SCTP(chksum=0xF),
         ]
         with TestPmdShell(enable_rx_cksum=True) as testpmd:
             testpmd.set_forward_mode(SimpleForwardingModes.csum)
@@ -339,8 +363,8 @@ def test_validate_sctp_checksum(self) -> None:
             testpmd.csum_set_hw(layers=ChecksumOffloadOptions.sctp)
             testpmd.start()
             self.send_packet_and_verify_checksum(
-                packet=packet_list[0], good_L4=True, good_IP=True, testpmd=testpmd, id=mac_id
+                packet=packet_list[0], good_L4=True, good_IP=True, testpmd=testpmd, id=dport_id
             )
             self.send_packet_and_verify_checksum(
-                packet=packet_list[1], good_L4=False, good_IP=True, testpmd=testpmd, id=mac_id
+                packet=packet_list[1], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
             )
-- 
2.48.1

