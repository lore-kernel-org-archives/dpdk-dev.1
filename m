Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B84C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D76FD402A4;
	Mon, 21 Sep 2026 04:11:11 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 3B63140291
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:11:10 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso8421395ad.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789956669; x=1790561469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PqpncR5hgaK9VvjOyW40c05YymHGBZKbH0TIt6XFCZ4=;
 b=Mf9w9Gpi3HLPoAKjicVY1kWfKRKdnGXlPz+YBhnY0NUNz6jh+i34aPPMFunTsLfzr9
 uU93JozT/Wwi6rRcWpY4NLVz4A99nnpzkqptLPQZbXwHPeGy6yJpXXPdwziMJH5nGl3F
 EYrL5u/MCGMLHuiySWjxnYYXEqBaP0ACtYoG6Zz6LnMU17B2fy+PiyT1MpU5Ineekqxi
 NsY6Yu/8av8CWhRaYioxq4jise2btJ00/8Fv230eNv3igUaDoxXepGEbh0z77xenVIER
 7ngnAYnT0b51Wi5BriKZJX6Z9DKK12Sfp05EAcCKFdV6EaKWJeADvaqmgHiufgo9VcjU
 CbbA==
X-Gm-Message-State: AFuF++lWe4+V2B1Bbs1bSaUPGOkTLj0S0+bV10O3Fd5XVQhdwqYsStgB
 etQOYswZJfDqh3h9paPdCRlrW+hUsi8Sb4P8GZTZckStS3YYI17zVxsVW9YNecOeQ3WG3b01urV
 ym/z1JwV+XY+EDgyIP/O300dt/wikr55Kc/61Pfe1C2O7iVWblCUz9gVET3GFbGGxSJ8YnkBu5M
 StDSAIhHZsK0uG0DsLOs4Hp5dc3v1HqpOemCLHZVMj7PbcFCmjyyOMg4BnWYjlkH43bYLGmOcp/
 ixMg+vnG6HG
X-Gm-Gg: AYBFou0gVuaFt3LcfCBC1zYy4Fn16auyAbTQ2IAwhTjGHwerBvQMEtidTkXmnvYGfGU
 nmitvFCJyhyd9fp5Q2gCbU9WFAxpj//ADo+PuEu02FMECxLnVzgKZgDDdZKhWi2IeIbVTin7QAJ
 klaPQzQRDjkyAyswWedd8Ens6mpTPK7O4a95a+VXyD6gt3gKv/ZwkbQ8/5t1Gyz36HwdqpMVPcU
 rDY6BiX80ltE6m5/ylCk3S74Iy1v0l9eGZOak1NLVuhoOgKC76wu8LFgazYsbjfKf+J+9/S7UgI
 iEtVzl8r9euUhsoW+Im25Pbyph6yiRm2zvu0Qcb5/qNKkV2+AgGR693Tvy5SuYL1vcMt0V1qipe
 J07NSE/4b5wDRyIP74zNMuqGkLT7TQyoRaMrd0W76bNXaFUiQlD1ywYPq1iZIkV9/+23crXT2xl
 /i8wAcW2E+aQNsgWmaYihwyteK0zJmjs/QCWLe+huIZLsJ6H2/SSyc
X-Received: by 2002:a17:90b:5706:b0:39e:6c6a:209e with SMTP id
 98e67ed59e1d1-39e6c6a234emr7283392a91.63.1789956668862; 
 Sun, 20 Sep 2026 19:11:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a053b937adsm286087a91.0.2026.09.20.19.11.08
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:11:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530f5e827c6so61607661cf.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789956667; x=1790561467; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PqpncR5hgaK9VvjOyW40c05YymHGBZKbH0TIt6XFCZ4=;
 b=BqiNx/r6YUDjLEeVTL4WkXn47EKA0vXxn6pU3MRO8jhaLKjNLbt/KjguzJklLCpcFG
 nm2hukBVEYLzZx5jfuSA74KM3nRslOhAOT2QHO8q/YionxqPap0O4602/sXUVDAGVIIV
 aNKgSdtyX6GreA07rpO03pW6N4wU6cuJDXvbY=
X-Received: by 2002:a05:622a:94f:10b0:532:c057:9564 with SMTP id
 d75a77b69052e-532c0579fc4mr35903171cf.23.1789956667554; 
 Sun, 20 Sep 2026 19:11:07 -0700 (PDT)
X-Received: by 2002:a05:622a:94f:10b0:532:c057:9564 with SMTP id
 d75a77b69052e-532c0579fc4mr35902971cf.23.1789956667073; 
 Sun, 20 Sep 2026 19:11:07 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532ae5eea5fsm52348741cf.8.2026.09.20.19.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:11:06 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: remove duplicate branches and conditions
Date: Sun, 20 Sep 2026 20:14:11 -0600
Message-ID: <20260921021411.1033724-1-Mohammad-Shuab.Siddique@broadcom.com>
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

