Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05129CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 22:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E288D40BA5;
	Fri, 17 Oct 2025 00:10:05 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 4DCCD402C1
 for <dev@dpdk.org>; Fri, 17 Oct 2025 00:10:04 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-33bb0472889so1316610a91.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760652603;
 x=1761257403; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7ZolnN5V8QctWdiWBbQ6Vi/+NJ6ACWg5eSIrV2cRjY=;
 b=v/aL64AT4VXDqMb+CY82sNTqvdJTbr2NrM4ZfGJh49pqaRtYPXwsqP+7M1eRPaEL04
 fi3Kq3KFGX7EKtcldOz4zbOjkjQ0veaTV0362oJmOPEuYJAgCzbu7e/32hM0dk0RknKn
 jhfOXbJ7WHdJL8Q0G1osVsRBB9BUk3zaBq2E8joCxAzpvfVERybB/XK/6mDsxnG1Z1aX
 Ix7JsAmQThLdE8ZFjrzPZNCd+ewPl/Q+/aPUnZiNT9yzwr/Ao5PkDgWDslejIlO9tzSJ
 EQSBNHDkTFrYAPJACmFLv/eAjr4JbivNo26hD1grEguHldDc7AHnvnu1re2rFS5KQDfW
 IxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760652603; x=1761257403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7ZolnN5V8QctWdiWBbQ6Vi/+NJ6ACWg5eSIrV2cRjY=;
 b=K1jr4+Tq0jS1qTMuKvD+zErOaxxvnj5zFPv8vsII9Va/oYUmikiXbWkF45fFBgXYGC
 yhtYUeGIfRD8OKtw3jb6OyeUtJuseuiyKQHQOJewo+0VijQHx3SOi/jOS3ZCOT+ghbAs
 Fkp65cvXoU07oEI7aI61OMWFPMf1wB8ADYGZewxrkY7dp3R72bAXus5RDhjXav6wxCd2
 TOGl+gJ8PcXrL8n+75l7xE1ae7A1ANm3yYo8r8Xa8c73iQmkdToOgRFJoWahR2eh+mVv
 qwpAdIcL5vVYnP6HsdPDXnpDbdvp7aqVYX8BmeDbuhpY1UFSiiVPCiyA1FpJmVu4ni0e
 7lpg==
X-Gm-Message-State: AOJu0Yx1C7Rp4IdSzjH67wj6NpSrNfpgF0OGcNNEOuvp0VpIyUfZIWBY
 4qtuzhBpSH6J7zc/lXrlVmoZE4M9aWVksSoCTeoZGYSH5Z+ouh+wiNYE2aGBSwyVTeBzjJk23/1
 /7xx4xSU=
X-Gm-Gg: ASbGncslhHpBYFo7asTBq79MQKDyaNORa/Qog8i9Pjp1MjbeS8QnwLWszx/bV3UlBYu
 KYpzLB5x2tfnPHki/OdEV0uEvUcS+rAS6iaPEvZWZjvwRAdczCDgcQEJ1j0t+oVB0t8DKnlbNYF
 up7Us/x/Gfz16fZyWBezK2VFIMB7CjDLoF/U4BSrYJAGzA7jO7x6kEjfOr4loKOmbQ+yHdBwSs1
 0s1y6lwR1uaP7k1/XRlQ9r4iBTrPv2bw5NcGQsXLUbuuig/4WMYEmRm5VbDKVGJMBWwE0N4V1+K
 4vzZTlbIrurPztco+AcQZHgLllt7pNc3LjP/B9EZ1CgDEigDmcsIpofTgOYayFp7UBB4eurUc7S
 zY4C5ExOlwj9rNIoCg0NZOSW3IbA7yrPNDdJ5Nd4eyy8eRSLqy94UoPxGjLU0nLB4nlA/CXsc6O
 bP1FqXekN7c1udahUOqWx3PaZN5J37q3GTG0Rf0yyGKJx1whokcA==
X-Google-Smtp-Source: AGHT+IG6517Z7HMsWGEcImz23CLuoP/DSSAV6FWK7Au/46xnsh2ltIQrAXUxjw1b+eLfiaWOjQlkNg==
X-Received: by 2002:a17:90b:5104:b0:330:a228:d2c with SMTP id
 98e67ed59e1d1-33bcf899d55mr1443132a91.15.1760652603406; 
 Thu, 16 Oct 2025 15:10:03 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bae2a4e03sm1731259a91.4.2025.10.16.15.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 15:10:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 1/3] net/dpaa2: remove unused frame array
Date: Thu, 16 Oct 2025 15:09:01 -0700
Message-ID: <20251016220959.15671-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016220959.15671-1-stephen@networkplumber.org>
References: <20251015230933.875860-1-stephen@networkplumber.org>
 <20251016220959.15671-1-stephen@networkplumber.org>
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
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

