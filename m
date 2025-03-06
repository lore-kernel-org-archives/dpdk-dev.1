Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ACCC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 21:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7275940E15;
	Thu,  6 Mar 2025 22:47:58 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 77C7C40E0F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 22:47:56 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-474e0bd966dso9825881cf.0
 for <dev@dpdk.org>; Thu, 06 Mar 2025 13:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741297676; x=1741902476; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGpy7fGl4gru/cnGJXtD91X8nsFkDNW9z6BRl9FPxXQ=;
 b=Krt0NnjHVBIa2Vz3dUl3kUIjEafUduoRwHNu9m1vYBeMr2WZ1mejtQRI7usUGrJSS1
 QRKUbbL4DnxwS8LzutRGe1TnlltVS2WIdriFX8nB4RMfrNCle3jFrQwlU276KLnEA48n
 CBcQ1lCdvL47T2j1FObYXlkolshVYhANjI+jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741297676; x=1741902476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGpy7fGl4gru/cnGJXtD91X8nsFkDNW9z6BRl9FPxXQ=;
 b=rftifJDcFDw1ZP7EqhIwr4h8R/VNw89sVbq9vyz+/Rw4iYIWs1stYqJtL/6D5LG+My
 PP/V9FSYdnoijKzBUrMRMJQ09PMpMKBbSjfiTvntYkM3iVLc9Ua8RaC2TD3eTX3aMBA/
 GdHd2pItDWM6ycQYSjz0/Tj6mPdA6nWEoL9CcFhWzpVJG8wrFT69Nl9X+kjAL5tLH3Tf
 LjaaIBcciX+Iocfk7t/F0Wag71/RKUnTw3h/mgGyzZltymERF7p0Oq+x1QVFVGo8arEu
 Gk4BGkfuMImwaOlhwDRtdpyOdRt4ZlUVrhPefqfFfFR3n8RiR0Y+AuAQAeQI1pBjI6Rs
 cXKQ==
X-Gm-Message-State: AOJu0YzfiUs/qjg1GFMD57DWLDcQYEl1HwpK9zfheJnGPCTfzIG/pSWC
 3VcW6UTlk5JyWOpanotHSMt4/k+PReTkm/admFXTVnfwFBCd3KFYsBKLbz/8qhc=
X-Gm-Gg: ASbGncuO6bVYEKwk7GJlB9pKdSODqogFLwXfoiKyeGdkn7xZxLleeK90upXh/y4rGnD
 4WsRPmcbH9u3CTIjpdKx2S1ZmT9hkyUkrQi0nzHKwQdnpF01L+MYHXchWfWn/p6Dj0zgzeY1hjN
 NfQOSv7pR+tI56jNrGl+qCxGvCG+19RgDCOPilF1lOsSBME1P99XOg4TwcKGi6qndjijEVeZ+6y
 otVigSeCpqODQtLSGa+ZJnn4VQS7esiLVDq09LtaXrDUbR4CaUFp6nl5VymzPL1sl/7ohJDuA6K
 qNAzU3lGJ4l2qEMH1oOrs+601+cxPvKfHBn52ma+jklV1JgIp0bVvyhBNJLx08T4mRI8/n+0nQC
 pYk4cBD6+
X-Google-Smtp-Source: AGHT+IHf4cdUj0BVDSJ7xmx2r/h5siCX34YREzSPq1uitW1AwoORA3YQtQ7FVPQnOfkOZwUPkU12Hw==
X-Received: by 2002:a05:622a:389:b0:474:f10a:39e0 with SMTP id
 d75a77b69052e-47608bd7a6bmr11035821cf.0.1741297675847; 
 Thu, 06 Mar 2025 13:47:55 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751db4ca3fsm11892341cf.70.2025.03.06.13.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 13:47:55 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 4/4] change verification field in unified packet suite
Date: Thu,  6 Mar 2025 16:47:47 -0500
Message-ID: <20250306214747.579340-5-dmarx@iol.unh.edu>
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

Changes the unified packet testing suite to use layer 4
destination ports as packet verification IDs.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
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
2.48.1

