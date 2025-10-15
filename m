Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ED2CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 23:09:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAE0540DF6;
	Thu, 16 Oct 2025 01:09:39 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 26B4440273
 for <dev@dpdk.org>; Thu, 16 Oct 2025 01:09:38 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b632a6b9effso37684a12.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760569777;
 x=1761174577; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rx+T+sr9tILDKI/Z6Z2DOACuhjlZWdWPF6WOGDbzoPw=;
 b=ECyMWxPRj1vjKGmRw/PXCH6okeA+4JTFGKXvCWvbCqFsNpLIAsIU4nWSjD7JjUGbtM
 QbQi+cQ/B66mjVcAC4+WZEz26GbKeDbu3qCUfzOo5tacKzTwqTH5v+OfJsc7uobY5+S0
 AXeFXx8VRgQl3hOaarFAYet9qqgYPqLZy3xCg4LpB1rr1XZ0x2S9GDQKA8N4s8+JztSy
 L/lrwhd4FQMJooMPK7zubAIpZilvMa5gTLkDqnRSLKqB39ny3Sam8ApF/Mru7oJHQVuZ
 i2edAaKDtqnCQ7WtYhrEV4TpidpvEjD/hq7wS3flffh3Evzrg2szYH5wdSxrsKey88L9
 EBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569777; x=1761174577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rx+T+sr9tILDKI/Z6Z2DOACuhjlZWdWPF6WOGDbzoPw=;
 b=PN0k6KIFZdJAYN/tMArFt1gXeKtqe0gzrvxQOgSPo1J3iIFx2twRqpeMzafOaBrCR4
 Mhi0wd57dzVEHPYRPlrUrRZl7/s9lePrsXvUe9tq7HGP9IdWl+f0KaV9uTmg21P8CDZO
 PD5VybuKfDbEw/au/rmxQKMXCHCINDehz/p5dYe0fBkNR1FiwPgs0su999rCha5KaajZ
 olFy2Uxohf/UyMfNSA20+//dyc0NAa+oJoigMl1xfVd1vi5fTTc0P7TO1zyrVi4FUJSg
 YX1KA/o75lDqG7rciJBcGaG4nS7nh5FP55uXBLZipWHmcc4TkQBUbsvF3xucPliABPHE
 kghg==
X-Gm-Message-State: AOJu0YzolWYARMHf7yrWJ+GJcvI6belKbILbx0CAHbzL6PgFzBXR0ahL
 Fe/BRLdB7PlbJ2ae+MyAiaosMG7qr2s7dn+lQHy8kNL73Crjln6c8iegpZ/kpT7/mxSkNuNj9lm
 3Bb0Xp6c=
X-Gm-Gg: ASbGncu7yVYLDZ93CKQRFha4slB2US0gABN/lOEXc0jMqj6tR8dfetW7nvxciGSVGxJ
 b6K/0f+2A8r1w8X9rY866BLVTnmSUCvVwZ2/AhAhpCZ5FY10Bxuh2b0gFpZlHUWIuYwDKgs5hix
 yt8DT1mAtJ5+ltcIypfQ494PIVWiy2ySYJgBcCju5PqpCOw9wy9h2AYnOFxok7EfeOHIJuekVzF
 0FsfmGIT070Woe0/Ge6A3IPlBWIhQYL9Eta8A4OuirVOYTR8rfvpkVzTM3j2Q4+l1OTlJizUTo8
 d95e+s7+Nd3NiTqhJevgCe+xW8uFo9qnmagdCJdFwhgqYSn4nR1TtCh7nhxoeMqQb1timi6MLtv
 ocPIAKg+AI4qYFjsjAr2CMDeTSUH8+wRYGq25vZlFC6d752BqxYBxbz6TAfhAVgErMmqfgtG/OG
 yNHM0lzQM/ghjqrmyeWm1sr+8X2MjuvjFff7m+lJO7fjBeBYRYiRgmMtZXhwYy
X-Google-Smtp-Source: AGHT+IGkXgul9uSGMr+6yXvSVw3j4B/vr2w4tnmO8EhY1KLJPGRp91Hre17nGb1pvErIj5+sRxJmew==
X-Received: by 2002:a17:902:f612:b0:277:9193:f2ca with SMTP id
 d9443c01a7336-290273564e8mr317552905ad.9.1760569777169; 
 Wed, 15 Oct 2025 16:09:37 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7de45sm7600155ad.54.2025.10.15.16.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 16:09:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFT 1/3] net/dpaa2: remove unused frame array
Date: Wed, 15 Oct 2025 16:07:37 -0700
Message-ID: <20251015230933.875860-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015230933.875860-1-stephen@networkplumber.org>
References: <20251015230933.875860-1-stephen@networkplumber.org>
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

The frame attribute variables were global but never used.
Tried making them local, but then compiler flags as unused
so remove them.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa2/dpaa2_sparser.c | 117 ------------------------------
 1 file changed, 117 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_sparser.c b/drivers/net/dpaa2/dpaa2_sparser.c
index 265c9b5c57..0b3e9f1920 100644
--- a/drivers/net/dpaa2/dpaa2_sparser.c
+++ b/drivers/net/dpaa2/dpaa2_sparser.c
@@ -28,123 +28,6 @@ uint8_t wriop_bytecode[] = {
 	0x18, 0x00, 0x87, 0x3c, 0x00, 0x02, 0x18, 0x00, 0x00, 0x00
 };
 
-struct frame_attr frame_attr_arr[] = {
-	/* Frame Attribute Flags 1 */
-	/* 000 */ {"Routing header present in IPv6 header 2 ", 0, 0x80000000},
-	/* 001 */ {"GTP Primed was detected                 ", 0, 0x40000000},
-	/* 002 */ {"VLAN with VID = 0 was detected          ", 0, 0x20000000},
-	/* 003 */ {"A PTP frame was detected                ", 0, 0x10000000},
-	/* 004 */ {"VXLAN was parsed                        ", 0, 0x08000000},
-	/* 005 */ {"A VXLAN HXS parsing error was detected  ", 0, 0x04000000},
-	/* 006 */ {"Ethernet control protocol was detected  ", 0, 0x02000000},
-	/* 007 */ {"IKE was detected at UDP port 4500       ", 0, 0x01000000},
-	/* 008 */ {"Shim Shell Soft Parsing Error           ", 0, 0x00800000},
-	/* 009 */ {"Parsing Error                           ", 0, 0x00400000},
-	/* 010 */ {"Ethernet MAC Present                    ", 0, 0x00200000},
-	/* 011 */ {"Ethernet Unicast                        ", 0, 0x00100000},
-	/* 012 */ {"Ethernet Multicast                      ", 0, 0x00080000},
-	/* 013 */ {"Ethernet Broadcast                      ", 0, 0x00040000},
-	/* 014 */ {"BPDU frame (MAC DA is 01:80:C2:00:00:00)", 0, 0x00020000},
-	/* 015 */ {"FCoE detected (Ether type is 0x8906)    ", 0, 0x00010000},
-	/* 016 */ {"FIP detected (Ether type is 0x8914)     ", 0, 0x00008000},
-	/* 017 */ {"Ethernet Parsing Error                  ", 0, 0x00004000},
-	/* 018 */ {"LLC+SNAP Present                        ", 0, 0x00002000},
-	/* 019 */ {"Unknown LLC/OUI                         ", 0, 0x00001000},
-	/* 020 */ {"LLC+SNAP Error                          ", 0, 0x00000800},
-	/* 021 */ {"VLAN 1 Present                          ", 0, 0x00000400},
-	/* 022 */ {"VLAN n Present                          ", 0, 0x00000200},
-	/* 023 */ {"CFI bit in a \"8100\" VLAN tag is set   ", 0, 0x00000100},
-	/* 024 */ {"VLAN Parsing Error                      ", 0, 0x00000080},
-	/* 025 */ {"PPPoE+PPP Present                       ", 0, 0x00000040},
-	/* 026 */ {"PPPoE+PPP Parsing Error                 ", 0, 0x00000020},
-	/* 027 */ {"MPLS 1 Present                          ", 0, 0x00000010},
-	/* 028 */ {"MPLS n Present                          ", 0, 0x00000008},
-	/* 029 */ {"MPLS Parsing Error                      ", 0, 0x00000004},
-	/* 030 */ {"ARP frame Present (Ethertype 0x0806)    ", 0, 0x00000002},
-	/* 031 */ {"ARP Parsing Error                       ", 0, 0x00000001},
-	/* Frame Attribute Flags 2 */
-	/* 032 */ {"L2 Unknown Protocol                     ", 1, 0x80000000},
-	/* 033 */ {"L2 Soft Parsing Error                   ", 1, 0x40000000},
-	/* 034 */ {"IPv4 1 Present                          ", 1, 0x20000000},
-	/* 035 */ {"IPv4 1 Unicast                          ", 1, 0x10000000},
-	/* 036 */ {"IPv4 1 Multicast                        ", 1, 0x08000000},
-	/* 037 */ {"IPv4 1 Broadcast                        ", 1, 0x04000000},
-	/* 038 */ {"IPv4 n Present                          ", 1, 0x02000000},
-	/* 039 */ {"IPv4 n Unicast                          ", 1, 0x01000000},
-	/* 040 */ {"IPv4 n Multicast                        ", 1, 0x00800000},
-	/* 041 */ {"IPv4 n Broadcast                        ", 1, 0x00400000},
-	/* 042 */ {"IPv6 1 Present                          ", 1, 0x00200000},
-	/* 043 */ {"IPv6 1 Unicast                          ", 1, 0x00100000},
-	/* 044 */ {"IPv6 1 Multicast                        ", 1, 0x00080000},
-	/* 045 */ {"IPv6 n Present                          ", 1, 0x00040000},
-	/* 046 */ {"IPv6 n Unicast                          ", 1, 0x00020000},
-	/* 047 */ {"IPv6 n Multicast                        ", 1, 0x00010000},
-	/* 048 */ {"IP 1 option present                     ", 1, 0x00008000},
-	/* 049 */ {"IP 1 Unknown Protocol                   ", 1, 0x00004000},
-	/* 050 */ {"IP 1 Packet is a fragment               ", 1, 0x00002000},
-	/* 051 */ {"IP 1 Packet is an initial fragment      ", 1, 0x00001000},
-	/* 052 */ {"IP 1 Parsing Error                      ", 1, 0x00000800},
-	/* 053 */ {"IP n option present                     ", 1, 0x00000400},
-	/* 054 */ {"IP n Unknown Protocol                   ", 1, 0x00000200},
-	/* 055 */ {"IP n Packet is a fragment               ", 1, 0x00000100},
-	/* 056 */ {"IP n Packet is an initial fragment      ", 1, 0x00000080},
-	/* 057 */ {"ICMP detected (IP proto is 1)           ", 1, 0x00000040},
-	/* 058 */ {"IGMP detected (IP proto is 2)           ", 1, 0x00000020},
-	/* 059 */ {"ICMPv6 detected (IP proto is 3a)        ", 1, 0x00000010},
-	/* 060 */ {"UDP Light detected (IP proto is 136)    ", 1, 0x00000008},
-	/* 061 */ {"IP n Parsing Error                      ", 1, 0x00000004},
-	/* 062 */ {"Min. Encap Present                      ", 1, 0x00000002},
-	/* 063 */ {"Min. Encap S flag set                   ", 1, 0x00000001},
-	/* Frame Attribute Flags 3 */
-	/* 064 */ {"Min. Encap Parsing Error                ", 2, 0x80000000},
-	/* 065 */ {"GRE Present                             ", 2, 0x40000000},
-	/* 066 */ {"GRE R bit set                           ", 2, 0x20000000},
-	/* 067 */ {"GRE Parsing Error                       ", 2, 0x10000000},
-	/* 068 */ {"L3 Unknown Protocol                     ", 2, 0x08000000},
-	/* 069 */ {"L3 Soft Parsing Error                   ", 2, 0x04000000},
-	/* 070 */ {"UDP Present                             ", 2, 0x02000000},
-	/* 071 */ {"UDP Parsing Error                       ", 2, 0x01000000},
-	/* 072 */ {"TCP Present                             ", 2, 0x00800000},
-	/* 073 */ {"TCP options present                     ", 2, 0x00400000},
-	/* 074 */ {"TCP Control bits 6-11 set               ", 2, 0x00200000},
-	/* 075 */ {"TCP Control bits 3-5 set                ", 2, 0x00100000},
-	/* 076 */ {"TCP Parsing Error                       ", 2, 0x00080000},
-	/* 077 */ {"IPSec Present                           ", 2, 0x00040000},
-	/* 078 */ {"IPSec ESP found                         ", 2, 0x00020000},
-	/* 079 */ {"IPSec AH found                          ", 2, 0x00010000},
-	/* 080 */ {"IPSec Parsing Error                     ", 2, 0x00008000},
-	/* 081 */ {"SCTP Present                            ", 2, 0x00004000},
-	/* 082 */ {"SCTP Parsing Error                      ", 2, 0x00002000},
-	/* 083 */ {"DCCP Present                            ", 2, 0x00001000},
-	/* 084 */ {"DCCP Parsing Error                      ", 2, 0x00000800},
-	/* 085 */ {"L4 Unknown Protocol                     ", 2, 0x00000400},
-	/* 086 */ {"L4 Soft Parsing Error                   ", 2, 0x00000200},
-	/* 087 */ {"GTP Present                             ", 2, 0x00000100},
-	/* 088 */ {"GTP Parsing Error                       ", 2, 0x00000080},
-	/* 089 */ {"ESP Present                             ", 2, 0x00000040},
-	/* 090 */ {"ESP Parsing Error                       ", 2, 0x00000020},
-	/* 091 */ {"iSCSI detected (Port# 860)              ", 2, 0x00000010},
-	/* 092 */ {"Capwap-control detected (Port# 5246)    ", 2, 0x00000008},
-	/* 093 */ {"Capwap-data detected (Port# 5247)       ", 2, 0x00000004},
-	/* 094 */ {"L5 Soft Parsing Error                   ", 2, 0x00000002},
-	/* 095 */ {"IPv6 Route hdr1 present                 ", 2, 0x00000001},
-	/* 096 */ {NULL,                                       0, 0x00000000}
-};
-
-struct frame_attr_ext frame_attr_ext_arr[] = {
-	/* Frame Attribute Flags Extension */
-	/* 096 */ {"User defined soft parser bit #0         ", 0, 0x8000},
-	/* 096 */ {"User defined soft parser bit #1         ", 0, 0x4000},
-	/* 096 */ {"User defined soft parser bit #2         ", 0, 0x2000},
-	/* 096 */ {"User defined soft parser bit #3         ", 0, 0x1000},
-	/* 096 */ {"User defined soft parser bit #4         ", 0, 0x0800},
-	/* 096 */ {"User defined soft parser bit #5         ", 0, 0x0400},
-	/* 096 */ {"User defined soft parser bit #6         ", 0, 0x0200},
-	/* 096 */ {"User defined soft parser bit #7         ", 0, 0x0100},
-	/* 097 */ {"Reserved                                ", 0, 0x00ff},
-	/* 112 */ {NULL,                                       0, 0x0000}
-};
-
 int dpaa2_eth_load_wriop_soft_parser(struct dpaa2_dev_priv *priv,
 				     enum dpni_soft_sequence_dest dest)
 {
-- 
2.47.3

