Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B85C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 18:33:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F076410D2;
	Thu, 15 May 2025 20:33:35 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2AAD040E03
 for <dev@dpdk.org>; Thu, 15 May 2025 20:33:32 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7c922734cc2so154263485a.1
 for <dev@dpdk.org>; Thu, 15 May 2025 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747334011; x=1747938811; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVx2EFm7wcLtPOUFaMc2YHfunkVw5ktA9wJEQ1H+KLI=;
 b=W5O3/N+JQdYOzicTyMudM9MpFpXSLJlSy2+wKE+Xcdh6EOuWjnXymzk6sI2xzscc6l
 8RvwqV2AB8jWiLKSSuYI06NwlCjuZT7aAKBs2qzvlAO2E6NaxyDsyBVxLuXvRnEKjS9m
 k/MAk9EBhUvy7Q+az49VEwQp+NFKK6sqYaQYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747334011; x=1747938811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVx2EFm7wcLtPOUFaMc2YHfunkVw5ktA9wJEQ1H+KLI=;
 b=XLFFW7m4UQ219/rBekAmGNO4ZBUep6K9kXjxPG/kCJPcYycxxDV9U2sp6FCCwHhn7s
 yPP1TkgNQ2anjVThTCzu8yMd9xlRsYy263RjecF54HhI71WTOf7yMziU98cNNYNmeN00
 sGbkM9LTNBplJJn5SdRn03TuxxnNXW3H8i85rTYwj473sBdb/oY9VC5F0hBYjCnnWNMB
 PSPhDjlldotykByOVm3c1gLl2JvfaS1tZVIKUiQbJze/WLq2ORbLQc4wRY0blkQAzaF8
 8FgqG5mCKGvZdCUAQ46f1EQEVyczUONVQ1p1smUxbAflWvtm0h2epbK9SzuJuBqK1ZfL
 BfbQ==
X-Gm-Message-State: AOJu0YwMW3yAYeKV/c+MAwU2XSSkdA7Voz98jotoHgzzl+BrQKrPnIg2
 QiYEKOxdQTF/OWbj6empKT3zonWsoYXBAJ4OHKNnfHAhsjT43jjvjE2xAz/ueqcSFlg=
X-Gm-Gg: ASbGncuEXL0svEJEvwZW/PecDayEtAY3uBh0pxtDc1u2aJ6TnA6PGU1TZF0GDaEWiB+
 VlnI5kvJk99ep5WAi8Hmau4NrTe81qKS5+JTiQ38Y7KuWG56ej8g/mFXSdIwiBD0jF8ryknG5I6
 4NXrsT5f3FWIKtlnpEPe3w8Ayx7D5ZEr/TJm0ZNYiH1Modyd4gXpEHCWmE6SMawDKQfWb7wmmJX
 /Zi9WnDeP4nliB7DZGTsDMX2BPETr/JnazhuhUfxpNYjj5AlTYpsgV/OxtEcM9d+6sHg9dSHT0N
 jmXWw9aUAnX7LRSLa0TXMR9g6WDZI27eWFudQS4MThJUXufR3Fw+Ww9NOyUtOg==
X-Google-Smtp-Source: AGHT+IHv9y+Ptro1GgJMDXBqkv/s6NYgOokpvRBXx+7KH3ePd++L6rfIDgwCXB04e5Qrsk6KhGzsJA==
X-Received: by 2002:a05:620a:3197:b0:7c7:a5aa:fc2b with SMTP id
 af79cd13be357-7cd46b14474mr74075785a.16.1747334011415; 
 Thu, 15 May 2025 11:33:31 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bc7d1sm18100185a.1.2025.05.15.11.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 11:33:30 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 2/4] dts: change verification field in checksum offload
 suite
Date: Thu, 15 May 2025 14:33:25 -0400
Message-ID: <20250515183327.191912-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515183327.191912-1-dmarx@iol.unh.edu>
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
 <20250515183327.191912-1-dmarx@iol.unh.edu>
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

Change the checksum offload testing suite to use layer 4
destination ports as packet verification IDs.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>
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
2.49.0

