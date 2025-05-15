Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F3C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 18:33:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B727B410EA;
	Thu, 15 May 2025 20:33:37 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id C9D4B41060
 for <dev@dpdk.org>; Thu, 15 May 2025 20:33:34 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7cadc92771dso124298585a.1
 for <dev@dpdk.org>; Thu, 15 May 2025 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747334014; x=1747938814; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/ucywzfv3Nd5Fz1DrOGf/y49K172+LrrxrusgMZFgo=;
 b=fGZKCWbZyK6HV8ylJItBVi/QYx+78SOAGp7PiJRogvo4Yq5zrP+f/wGPZpAnQca03C
 CSjR9lLM9e0neVBZmKAvxCkzeht7Y1/x9XP/HRHJ2iX81XkzmloqspW5WHVMGmSLK1v4
 OITlXcohE7SKHJ8nsARLsmHPDJAby6K65Zy8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747334014; x=1747938814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/ucywzfv3Nd5Fz1DrOGf/y49K172+LrrxrusgMZFgo=;
 b=LKiBz/DnOxQ5tqMtybZRZI+VQGRSeWINvw5lr1jG92yCoa5vTtF2qSfgM3jdUxBG/1
 87ZykwLbAAKr6xHKvkYwBfD85eIAJD9TF3fYvjNewoSVEksPra2gpZX+XCERb0VI/Yra
 WGObVzvFVTruiTHgwz6IgTINhvCoS177+4ldNfr61w9H4lzDuwhmF74l4dV++KUbMSKV
 A/6l/sVj0NDEmiI+JhgqrbLEiaGoX3KJ/7j2IyMAKWcTBLrG0O+fVjIiJIqy7Wa9jM1A
 WlY+aWLJYveOERmm7waY4Y3yVNq/qiik30c72xNwU/ls9NSIyEeW1YuqijO55xSAhz94
 8WQg==
X-Gm-Message-State: AOJu0YxKNu1W/rOFY+fY8axGeHJl9YdhqwUzo3QTwMK24mnWl6LxK0+Q
 8BGR/TMdqPYC51n4/Z7DkEdEtmSVpGvnTGJ0SMRPWqFxrSzKsrrAhw0kkIKL2id4pHM=
X-Gm-Gg: ASbGncsmzMiv2Pj5/bSEWwU+1fasWQ/W3uFikFUIF10IIbB7fxt8pSV4xgiAlLeEsbp
 XxtuHQRQ6S2TqAZRutmVifSkn2duYSQO2tNDs4DyE7SXAZEeuEImqNRaN3m8a00umhy6n7ekYzr
 +TUeptW+ct4phCu+Rq3OUVURYv/VilI6TVItOTYUmS/HKUzmqwzXBl8OUPVLbb+aB961LIJBSks
 UjQ7UH6nYdQrgPanOu5Xy6aOHDygqxndVBzN3Jh5k0HilpPnpcO0xEjSWrQ1jyhZITSiIKfTVcY
 3gvaA92IUajK5vf3pkUG5Q5fXcY3W+uE3/4L4OTmcm7KI6qAn7nL1hPBnPHMdw==
X-Google-Smtp-Source: AGHT+IE9IVenkcLXAPakwGyI2CVjJpo1ud9syjDVS9dP2eWn+LETVXzVzOe/Pa+mUBjqIavLiBLxxQ==
X-Received: by 2002:a05:620a:414f:b0:7c9:2383:afef with SMTP id
 af79cd13be357-7cd4677e54dmr61502785a.37.1747334013951; 
 Thu, 15 May 2025 11:33:33 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bc7d1sm18100185a.1.2025.05.15.11.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 11:33:33 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 4/4] dts: change verification field in unified packet suite
Date: Thu, 15 May 2025 14:33:27 -0400
Message-ID: <20250515183327.191912-4-dmarx@iol.unh.edu>
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

Change the unified packet testing suite to use layer 4
destination ports as packet verification IDs.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/tests/TestSuite_uni_pkt.py | 106 ++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 55 deletions(-)

diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index 656a69b0f1..fdb9c29059 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -44,7 +44,7 @@ def check_for_matching_packet(
     ) -> bool:
         """Returns :data:`True` if the packet in verbose output contains all specified flags."""
         for packet in output:
-            if packet.dst_mac == "00:00:00:00:00:01":
+            if packet.l4_dport == 50000:
                 if flags not in packet.hw_ptype and flags not in packet.sw_ptype:
                     return False
         return True
@@ -82,8 +82,8 @@ def test_l2_packet_detect(self) -> None:
             Check that each packet has a destination MAC address matching the set ID.
             Check the packet type fields in verbose output, verify the flags match.
         """
-        mac_id = "00:00:00:00:00:01"
-        packet_list = [Ether(dst=mac_id, type=0x88F7) / Raw(), Ether(dst=mac_id) / ARP() / Raw()]
+        dport_id = 50000
+        packet_list = [Ether(type=0x88F7) / UDP(dport=dport_id) / Raw(), Ether() / ARP() / Raw()]
         flag_list = [RtePTypes.L2_ETHER_TIMESYNC, RtePTypes.L2_ETHER_ARP]
         with TestPmdShell() as testpmd:
             self.setup_session(testpmd=testpmd, expected_flags=flag_list, packet_list=packet_list)
@@ -101,14 +101,14 @@ def test_l3_l4_packet_detect(self) -> None:
             Check that each packet has a destination MAC address matching the set ID.
             Check the packet type fields in verbose output, verify the flags match.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IP() / Raw(),
-            Ether(dst=mac_id) / IP() / UDP() / Raw(),
-            Ether(dst=mac_id) / IP() / TCP() / Raw(),
-            Ether(dst=mac_id) / IP() / SCTP() / Raw(),
-            Ether(dst=mac_id) / IP() / ICMP() / Raw(),
-            Ether(dst=mac_id) / IP(frag=5) / TCP() / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / Raw(),
+            Ether() / IP() / UDP(dport=dport_id) / Raw(),
+            Ether() / IP() / TCP(dport=dport_id) / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / SCTP() / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / ICMP() / Raw(),
+            Ether() / IP(frag=5) / TCP(dport=dport_id) / Raw(),
         ]
         flag_list = [
             RtePTypes.L3_IPV4 | RtePTypes.L2_ETHER,
@@ -134,12 +134,12 @@ def test_ipv6_l4_packet_detect(self) -> None:
             Check that each packet has a destination MAC address matching the set ID.
             Check the packet type fields in verbose output, verify the flags match.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IPv6() / Raw(),
-            Ether(dst=mac_id) / IPv6() / UDP() / Raw(),
-            Ether(dst=mac_id) / IPv6() / TCP() / Raw(),
-            Ether(dst=mac_id) / IPv6() / IPv6ExtHdrFragment() / Raw(),
+            Ether() / UDP(dport=dport_id) / IPv6() / Raw(),
+            Ether() / IPv6() / UDP(dport=dport_id) / Raw(),
+            Ether() / IPv6() / TCP(dport=dport_id) / Raw(),
+            Ether() / UDP(dport=dport_id) / IPv6() / IPv6ExtHdrFragment() / Raw(),
         ]
         flag_list = [
             RtePTypes.L2_ETHER | RtePTypes.L3_IPV6,
@@ -163,15 +163,15 @@ def test_l3_tunnel_packet_detect(self) -> None:
             Check that each packet has a destination MAC address matching the set ID.
             Check the packet type fields in verbose output, verify the flags match.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IP() / IP(frag=5) / UDP() / Raw(),
-            Ether(dst=mac_id) / IP() / IP() / Raw(),
-            Ether(dst=mac_id) / IP() / IP() / UDP() / Raw(),
-            Ether(dst=mac_id) / IP() / IP() / TCP() / Raw(),
-            Ether(dst=mac_id) / IP() / IP() / SCTP() / Raw(),
-            Ether(dst=mac_id) / IP() / IP() / ICMP() / Raw(),
-            Ether(dst=mac_id) / IP() / IPv6() / IPv6ExtHdrFragment() / Raw(),
+            Ether() / IP() / IP(frag=5) / UDP(dport=dport_id) / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / IP() / Raw(),
+            Ether() / IP() / IP() / UDP(dport=dport_id) / Raw(),
+            Ether() / IP() / IP() / TCP(dport=dport_id) / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / IP() / SCTP() / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / IP() / ICMP() / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / IPv6() / IPv6ExtHdrFragment() / Raw(),
         ]
         flag_list = [
             RtePTypes.TUNNEL_IP | RtePTypes.L3_IPV4_EXT_UNKNOWN | RtePTypes.INNER_L4_FRAG,
@@ -198,14 +198,14 @@ def test_gre_tunnel_packet_detect(self) -> None:
             Check that each packet has a destination MAC address matching the set ID.
             Check the packet type fields in verbose output, verify the flags match.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IP() / GRE() / IP(frag=5) / Raw(),
-            Ether(dst=mac_id) / IP() / GRE() / IP() / Raw(),
-            Ether(dst=mac_id) / IP() / GRE() / IP() / UDP() / Raw(),
-            Ether(dst=mac_id) / IP() / GRE() / IP() / TCP() / Raw(),
-            Ether(dst=mac_id) / IP() / GRE() / IP() / SCTP() / Raw(),
-            Ether(dst=mac_id) / IP() / GRE() / IP() / ICMP() / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / GRE() / IP(frag=5) / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / GRE() / IP() / Raw(),
+            Ether() / IP() / GRE() / IP() / UDP(dport=dport_id) / Raw(),
+            Ether() / IP() / GRE() / IP() / TCP(dport=dport_id) / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / GRE() / IP() / SCTP() / Raw(),
+            Ether() / UDP(dport=dport_id) / IP() / GRE() / IP() / ICMP() / Raw(),
         ]
         flag_list = [
             RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_FRAG | RtePTypes.INNER_L3_IPV4_EXT_UNKNOWN,
@@ -231,15 +231,20 @@ def test_nsh_packet_detect(self) -> None:
             Check that each packet has a destination MAC address matching the set ID.
             Check the packet type fields in verbose output, verify the flags match.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id, type=0x894F) / NSH() / IP(),
-            Ether(dst=mac_id, type=0x894F) / NSH() / IP() / ICMP(),
-            Ether(dst=mac_id, type=0x894F) / NSH() / IP(frag=1, flags="MF"),
-            Ether(dst=mac_id, type=0x894F) / NSH() / IP() / TCP(),
-            Ether(dst=mac_id, type=0x894F) / NSH() / IP() / UDP(),
-            Ether(dst=mac_id, type=0x894F) / NSH() / IP() / SCTP(tag=1) / SCTPChunkData(data="x"),
-            Ether(dst=mac_id, type=0x894F) / NSH() / IPv6(),
+            Ether(type=0x894F) / UDP(dport=dport_id) / NSH() / IP(),
+            Ether(type=0x894F) / UDP(dport=dport_id) / NSH() / IP() / ICMP(),
+            Ether(type=0x894F) / UDP(dport=dport_id) / NSH() / IP(frag=1, flags="MF"),
+            Ether(type=0x894F) / NSH() / IP() / TCP(dport=dport_id),
+            Ether(type=0x894F) / NSH() / IP() / UDP(dport=dport_id),
+            Ether(type=0x894F)
+            / UDP(dport=dport_id)
+            / NSH()
+            / IP()
+            / SCTP(tag=1)
+            / SCTPChunkData(data="x"),
+            Ether(type=0x894F) / UDP(dport=dport_id) / NSH() / IPv6(),
         ]
         flag_list = [
             RtePTypes.L2_ETHER_NSH | RtePTypes.L3_IPV4_EXT_UNKNOWN | RtePTypes.L4_NONFRAG,
@@ -267,24 +272,15 @@ def test_vxlan_tunnel_packet_detect(self) -> None:
             Check that each packet has a destination MAC address matching the set ID.
             Check the packet type fields in verbose output, verify the flags match.
         """
-        mac_id = "00:00:00:00:00:01"
+        dport_id = 50000
         packet_list = [
-            Ether(dst=mac_id) / IP() / UDP() / VXLAN() / Ether() / IP(frag=5) / Raw(),
-            Ether(dst=mac_id) / IP() / UDP() / VXLAN() / Ether() / IP() / Raw(),
-            Ether(dst=mac_id) / IP() / UDP() / VXLAN() / Ether() / IP() / UDP() / Raw(),
-            Ether(dst=mac_id) / IP() / UDP() / VXLAN() / Ether() / IP() / TCP() / Raw(),
-            Ether(dst=mac_id) / IP() / UDP() / VXLAN() / Ether() / IP() / SCTP() / Raw(),
-            Ether(dst=mac_id) / IP() / UDP() / VXLAN() / Ether() / IP() / ICMP() / Raw(),
-            (
-                Ether(dst=mac_id)
-                / IP()
-                / UDP()
-                / VXLAN()
-                / Ether()
-                / IPv6()
-                / IPv6ExtHdrFragment()
-                / Raw()
-            ),
+            Ether() / IP() / UDP(dport=dport_id) / VXLAN() / Ether() / IP(frag=5) / Raw(),
+            Ether() / IP() / UDP(dport=dport_id) / VXLAN() / Ether() / IP() / Raw(),
+            Ether() / IP() / UDP(dport=dport_id) / VXLAN() / Ether() / IP() / UDP() / Raw(),
+            Ether() / IP() / UDP(dport=dport_id) / VXLAN() / Ether() / IP() / TCP() / Raw(),
+            Ether() / IP() / UDP(dport=dport_id) / VXLAN() / Ether() / IP() / SCTP() / Raw(),
+            Ether() / IP() / UDP(dport=dport_id) / VXLAN() / Ether() / IP() / ICMP() / Raw(),
+            (Ether() / IP() / UDP() / VXLAN() / Ether() / IPv6() / IPv6ExtHdrFragment() / Raw()),
         ]
         flag_list = [
             RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_FRAG | RtePTypes.INNER_L3_IPV4_EXT_UNKNOWN,
-- 
2.49.0

