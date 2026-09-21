Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B22C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:14:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22DDB409FA;
	Mon, 21 Sep 2026 04:14:14 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 68101402A4
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:14:12 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2d942c7cc2fso11828385ad.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789956851; x=1790561651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PqpncR5hgaK9VvjOyW40c05YymHGBZKbH0TIt6XFCZ4=;
 b=vAVSyS2OsyJmQOT+iWm2BkibMGuZmRNeD0uVJrM+GnAh3OkSC9JFP44PiU5p0jpxyu
 z0CqyPxnST+RJPPUMKnTdl/yP4S29IALSbftKBdny2NNrrR2MGwfaDCGYJ+9V6Wpdb0F
 Vb+0GlEa1RfhYJnMXUMdBCGYyhLKjdPcWYN+iWfXp779EOO2VXn/t3j2JPc0sZXfhTh9
 TUdNwSF//1Z3qbrQY3rL0Lk17572UV0U7FIeq74CAccrTWDo2sUojoXBEBXVRBHypbVm
 yK2IPbB1UPGWsEP1ICV+rvdW7vvNDog19DNoZpkJIe3ND/9rIOC7hANVwMPl4M6GdcOl
 /cJw==
X-Gm-Message-State: AFuF++m9eJzay/9fzUVkf7mVF6QHJVg34l3GFuc9UTj6eA3FTlj1Jjuu
 /fJ6p82xhlkdA7+ifGa4KbZOFdRBdWxBM6GrmCKYDafr+4t+j6FE5s92wGHjeNnSPKJejkNKAwQ
 n99r758a0hpcsoJyvHyjfgiOXyDeiDUacTpzLEN1Utar+6RA6VVkyFOYHOw/YPbpckCLl1TrEek
 C20uL5iX0aeW3ked52tZ9bMmhI0UOAB8fSNkXA9HcVhbPxKzOr84thOe8w6u/Ww7j26D68xy53O
 SmeZ+ALGHzJ
X-Gm-Gg: AYBFou1HPKpcP1ywT0Ul1kSTnmmmPv8wZIa1DTJknCO2VnX5+ebf7WnI0oYcjDlIIoJ
 4FKy8aEX96S74Qtu7g8lR3ZTUnAFJyQSIa5nTfA5fxvmv6bDS/+OkTdTLxMRKgJbMbeGkgXX8Ai
 S3v5B7lQ/YZirdnjxyeFCxvwswiOfDnb8eq09CjPaF70VQ+Q7vNYagX69IKkmnAH38fc5pWAiN9
 5DIzS/Mhdkqtv83MQiMZAko6TIfKz6e7o+Z+FonXvaTLu/xwm5K0vhoS8cnNe1CxUIPEw4s+NkZ
 laCuFXLNUJ+j1YaEhjcsa08RtJTdwx7nd2FTfx4CsN8qG0t122+EBiQqrF3IgOJkf/NypHFl6sD
 geZ4Err8lbkoxLRo8STb5OnQ+48PRtuXnoQKvLXISRrnDhUX3zMeZn8Ic6TMELihX0Tz9nR+8JQ
 V7RfGDFWCZNkGiPD83j9eAqq7UuMuwIiWcpfaMWEnWj1x5M0nwjw==
X-Received: by 2002:a17:90b:3909:b0:39e:248e:fdeb with SMTP id
 98e67ed59e1d1-39e54d10e41mr14662434a91.19.1789956851199; 
 Sun, 20 Sep 2026 19:14:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39e53296f84sm999443a91.0.2026.09.20.19.14.10
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:14:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso3074541a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789956849; x=1790561649; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PqpncR5hgaK9VvjOyW40c05YymHGBZKbH0TIt6XFCZ4=;
 b=AI+tUYJt6q8GmOvyyNiMCoFhZw3gqHdbVVEfmKXWY3xH3I10YuVrpYmsDgExyNNGlt
 PjT0mXR0oMH+ABEtWfdFWGXJo+40oHW5vD/oadVWylW/HB9gZWiu7RKWdO1T4nC0qcNF
 OskRBKP698T5aBBFgTmZ4H4oV/9kVMDgIiAQ0=
X-Received: by 2002:a17:90b:37cb:b0:39e:6c6a:2090 with SMTP id
 98e67ed59e1d1-39e6c6a229fmr9158681a91.49.1789956849239; 
 Sun, 20 Sep 2026 19:14:09 -0700 (PDT)
X-Received: by 2002:a17:90b:37cb:b0:39e:6c6a:2090 with SMTP id
 98e67ed59e1d1-39e6c6a229fmr9158652a91.49.1789956848618; 
 Sun, 20 Sep 2026 19:14:08 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a6e5sm15290401eec.7.2026.09.20.19.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:14:08 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: remove duplicate branches and conditions
Date: Sun, 20 Sep 2026 20:17:11 -0600
Message-ID: <20260921021711.1033759-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032645.763349-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032645.763349-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Dakota Sicher <dakota.sicher@broadcom.com>

Removed ternary operators with identical results and consolidated
identical branches in bnxt_validate_and_parse_flow_type() and
bnxt_start_xmit(). The NTUPLE and EM_FLOW variants of several HWRM
enable-bit and IP address type macros resolve to identical values,
making the use_ntuple-conditioned ternaries redundant; several
adjacent if/else-if branches in the Tx checksum-flag dispatch were
also textually identical (same action for a checksum-combination
flag and each of its constituent single-flag variants) and have
been merged.

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
* No code change. The AI-review bot flagged the merged Tx checksum-flag
  branches as a possible correctness regression, on the theory that a
  packet with a combined flag (e.g. PKT_TX_OIP_IIP_TCP_UDP_CKSUM) might
  now hit a different branch than before. Checked the flag definitions
  in bnxt_txr.h: each combined flag is defined as the bitwise OR of its
  constituent single flags (e.g. PKT_TX_OIP_IIP_TCP_UDP_CKSUM ==
  PKT_TX_OIP_IIP_TCP_CKSUM | PKT_TX_OIP_IIP_UDP_CKSUM), so a masked
  equality check against either single-flag macro already matches the
  combined-flag case too. Since all three variants produced the same
  action in the pre-patch code, the merge is behavior-preserving.

 drivers/net/bnxt/bnxt_flow.c | 14 ++++------
 drivers/net/bnxt/bnxt_txr.c  | 52 ++++++++++--------------------------
 2 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..c2338a0f51 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -259,9 +259,7 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 				}
 				rte_memcpy(filter->src_macaddr,
 					   &eth_spec->hdr.src_addr, RTE_ETHER_ADDR_LEN);
-				en |= use_ntuple ?
-					NTUPLE_FLTR_ALLOC_INPUT_EN_SRC_MACADDR :
-					EM_FLOW_ALLOC_INPUT_EN_SRC_MACADDR;
+				en |= NTUPLE_FLTR_ALLOC_INPUT_EN_SRC_MACADDR;
 				valid_flags |= inner ?
 					BNXT_FLOW_L2_INNER_SRC_VALID_FLAG :
 					BNXT_FLOW_L2_SRC_VALID_FLAG;
@@ -379,9 +377,8 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 				     NTUPLE_FLTR_ALLOC_INPUT_EN_DST_IPADDR_MASK;
 			}
 
-			filter->ip_addr_type = use_ntuple ?
-			 HWRM_CFA_NTUPLE_FILTER_ALLOC_INPUT_IP_ADDR_TYPE_IPV4 :
-			 HWRM_CFA_EM_FLOW_ALLOC_INPUT_IP_ADDR_TYPE_IPV4;
+			filter->ip_addr_type =
+				HWRM_CFA_NTUPLE_FILTER_ALLOC_INPUT_IP_ADDR_TYPE_IPV4;
 
 			if (ipv4_spec->hdr.next_proto_id) {
 				filter->ip_protocol =
@@ -444,9 +441,8 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 				     NTUPLE_FLTR_ALLOC_INPUT_EN_DST_IPADDR_MASK;
 			}
 
-			filter->ip_addr_type = use_ntuple ?
-				NTUPLE_FLTR_ALLOC_INPUT_IP_ADDR_TYPE_IPV6 :
-				EM_FLOW_ALLOC_INPUT_IP_ADDR_TYPE_IPV6;
+			filter->ip_addr_type =
+				NTUPLE_FLTR_ALLOC_INPUT_IP_ADDR_TYPE_IPV6;
 			break;
 		case RTE_FLOW_ITEM_TYPE_TCP:
 			tcp_spec = item->spec;
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 3fae0824d1..9d249143da 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -409,68 +409,44 @@ static int bnxt_start_xmit(struct rte_mbuf *tx_pkt,
 				goto drop;
 			}
 
-		} else if ((tx_pkt->ol_flags & PKT_TX_OIP_IIP_TCP_UDP_CKSUM) ==
-			   PKT_TX_OIP_IIP_TCP_UDP_CKSUM) {
-			/* Outer IP, Inner IP, Inner TCP/UDP CSO */
-			txbd1->lflags |= TX_BD_FLG_TIP_IP_TCP_UDP_CHKSUM;
 		} else if ((tx_pkt->ol_flags & PKT_TX_OIP_IIP_TCP_CKSUM) ==
-			   PKT_TX_OIP_IIP_TCP_CKSUM) {
-			/* Outer IP, Inner IP, Inner TCP/UDP CSO */
-			txbd1->lflags |= TX_BD_FLG_TIP_IP_TCP_UDP_CHKSUM;
-		} else if ((tx_pkt->ol_flags & PKT_TX_OIP_IIP_UDP_CKSUM) ==
+			   PKT_TX_OIP_IIP_TCP_CKSUM ||
+			   (tx_pkt->ol_flags & PKT_TX_OIP_IIP_UDP_CKSUM) ==
 			   PKT_TX_OIP_IIP_UDP_CKSUM) {
 			/* Outer IP, Inner IP, Inner TCP/UDP CSO */
 			txbd1->lflags |= TX_BD_FLG_TIP_IP_TCP_UDP_CHKSUM;
-		} else if ((tx_pkt->ol_flags & PKT_TX_IIP_TCP_UDP_CKSUM) ==
-			   PKT_TX_IIP_TCP_UDP_CKSUM) {
-			/* (Inner) IP, (Inner) TCP/UDP CSO */
-			txbd1->lflags |= TX_BD_FLG_IP_TCP_UDP_CHKSUM;
-		} else if ((tx_pkt->ol_flags & PKT_TX_IIP_UDP_CKSUM) ==
-			   PKT_TX_IIP_UDP_CKSUM) {
-			/* (Inner) IP, (Inner) TCP/UDP CSO */
-			txbd1->lflags |= TX_BD_FLG_IP_TCP_UDP_CHKSUM;
 		} else if ((tx_pkt->ol_flags & PKT_TX_IIP_TCP_CKSUM) ==
-			   PKT_TX_IIP_TCP_CKSUM) {
+			   PKT_TX_IIP_TCP_CKSUM ||
+			   (tx_pkt->ol_flags & PKT_TX_IIP_UDP_CKSUM) ==
+			   PKT_TX_IIP_UDP_CKSUM) {
 			/* (Inner) IP, (Inner) TCP/UDP CSO */
 			txbd1->lflags |= TX_BD_FLG_IP_TCP_UDP_CHKSUM;
-		} else if ((tx_pkt->ol_flags & PKT_TX_OIP_TCP_UDP_CKSUM) ==
-			   PKT_TX_OIP_TCP_UDP_CKSUM) {
-			/* Outer IP, (Inner) TCP/UDP CSO */
-			txbd1->lflags |= TX_BD_FLG_TIP_TCP_UDP_CHKSUM;
-		} else if ((tx_pkt->ol_flags & PKT_TX_OIP_UDP_CKSUM) ==
-			   PKT_TX_OIP_UDP_CKSUM) {
-			/* Outer IP, (Inner) TCP/UDP CSO */
-			txbd1->lflags |= TX_BD_FLG_TIP_TCP_UDP_CHKSUM;
 		} else if ((tx_pkt->ol_flags & PKT_TX_OIP_TCP_CKSUM) ==
-			   PKT_TX_OIP_TCP_CKSUM) {
+			   PKT_TX_OIP_TCP_CKSUM ||
+			   (tx_pkt->ol_flags & PKT_TX_OIP_UDP_CKSUM) ==
+			   PKT_TX_OIP_UDP_CKSUM) {
 			/* Outer IP, (Inner) TCP/UDP CSO */
 			txbd1->lflags |= TX_BD_FLG_TIP_TCP_UDP_CHKSUM;
 		} else if ((tx_pkt->ol_flags & PKT_TX_OIP_IIP_CKSUM) ==
-			   PKT_TX_OIP_IIP_CKSUM) {
+				PKT_TX_OIP_IIP_CKSUM) {
 			/* Outer IP, Inner IP CSO */
 			txbd1->lflags |= TX_BD_FLG_TIP_IP_CHKSUM;
-		} else if ((tx_pkt->ol_flags & PKT_TX_TCP_UDP_CKSUM) ==
-			   PKT_TX_TCP_UDP_CKSUM) {
-			/* TCP/UDP CSO */
-			txbd1->lflags |= TX_BD_LONG_LFLAGS_TCP_UDP_CHKSUM;
 		} else if ((tx_pkt->ol_flags & RTE_MBUF_F_TX_TCP_CKSUM) ==
-			   RTE_MBUF_F_TX_TCP_CKSUM) {
-			/* TCP/UDP CSO */
-			txbd1->lflags |= TX_BD_LONG_LFLAGS_TCP_UDP_CHKSUM;
-		} else if ((tx_pkt->ol_flags & RTE_MBUF_F_TX_UDP_CKSUM) ==
+			   RTE_MBUF_F_TX_TCP_CKSUM ||
+			   (tx_pkt->ol_flags & RTE_MBUF_F_TX_UDP_CKSUM) ==
 			   RTE_MBUF_F_TX_UDP_CKSUM) {
 			/* TCP/UDP CSO */
 			txbd1->lflags |= TX_BD_LONG_LFLAGS_TCP_UDP_CHKSUM;
 		} else if ((tx_pkt->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) ==
-			   RTE_MBUF_F_TX_IP_CKSUM) {
+				RTE_MBUF_F_TX_IP_CKSUM) {
 			/* IP CSO */
 			txbd1->lflags |= TX_BD_LONG_LFLAGS_IP_CHKSUM;
 		} else if ((tx_pkt->ol_flags & RTE_MBUF_F_TX_OUTER_IP_CKSUM) ==
-			   RTE_MBUF_F_TX_OUTER_IP_CKSUM) {
+				RTE_MBUF_F_TX_OUTER_IP_CKSUM) {
 			/* IP CSO */
 			txbd1->lflags |= TX_BD_LONG_LFLAGS_T_IP_CHKSUM;
 		} else if ((tx_pkt->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) ==
-			   RTE_MBUF_F_TX_IEEE1588_TMST || pkt_needs_ts) {
+				RTE_MBUF_F_TX_IEEE1588_TMST || pkt_needs_ts) {
 			/* PTP */
 			txbd1->lflags |= TX_BD_LONG_LFLAGS_STAMP;
 		}
-- 
2.47.3

