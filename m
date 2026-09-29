Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C4CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 290D940E50;
	Tue, 29 Sep 2026 02:21:04 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 612F740E39
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:02 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2dd664da0f5so13125115ad.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641261; x=1791246061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1gHtsK2uaRfqHMNlJr91wZXAtAMIT0f7Zgili9N5sfE=;
 b=W02AH3vFhWRJZstGH3VNmeDG4lTCmYCx5xjUQeWQlBcUujBOGqdM7uEJ8p3g4R78IB
 rfaceIAMhxYgiDZkNTcqOS8gnJVbtV6LuhDgwuEsh0G5wp7u2zNKCyt4A1QGqPIfVQpd
 98Z/tRo1X/AUMSObp0z115dQkryaDS3LrHo0khB44flBprFy0xIMqrLLD0Sn9saDfxnY
 uQoGsdcdHpZ418Uw0UO7TZ+lgxTJrHJ9rA2lLo6HpHSf3Bi1ljPoEq+9X5oHdV7uLTHI
 qLWEiP/gvmMaS/b+CskX6cHce3CLigE9zBv6KUmx0WGuEc9NmNaqR5dQKFwdgQntLNSx
 I0Fg==
X-Gm-Message-State: AFq9FYKXZDD06brKkF3DjMYGg3fStrbUVIGHJPUV4rLHto2ujfHMS62f
 J27YQq7XAk1+0JTNnXX1l7/Zrn1tMkNJWm2kWtUUAjM+7pTLfUYGWbhrcwi9hZvtnIOAVp03VXt
 jGFYZAVVNt9z9Oand+9ZGVun+zcvj0FbwXvl+oYN4SAS7RPQiM3K+rPNbGALd2rTKlt+y3ndcyw
 oO6GA5fFqa/GRbxzkkaPgScsNXq6IMvNHFNfpsQdsCgtM2CDZdvpa3s/SAQELKCb+CcTgcObpME
 XgAsejWZlOj
X-Gm-Gg: AYBFou09IkLnSWQ6fCPyU3r9/r3TN/N3wV7tpJuZLaRL9VqP9wFj0uZd+vODo43JaRV
 zxTQAqIF3U2okOPKCt57s6xGy8a2v2ojkOCs65XXelr03gQa1qADQEQa8OouLcg+UZjCK9NBPHv
 /A6LdLAGwS5WNlfdLXKOMb7cmUYYmDI1lLth7bvJADCUY87sxUx8ke7pYYMBUXqubP8fpHxJ72B
 GuCwUvfWu18oj7HYEsWzOHdX6m/5obbFLwAJvLgPE+ndpU2kuCcQ2rWyJQyCYI3qclGpcDhKWi9
 Xd+S+C4UEUD6fKYvFFRU29yujEww+4vZE7ZJ6YjHBzydOtq5paQJDdG6CPLiW2/VNifcMdFMu68
 c8+c2WoSGBsU94jrAwJn6hAd7z30rUlVrXf7ch5n5p2Kp5QYbS1noyfum049FOsdbsATILyFlOd
 ujn/KziAQGdHcbdlUjqtqX89mW9jlTrAx2GTMifY47IcrLiFLMwg==
X-Received: by 2002:a17:903:120d:b0:2df:81d0:7c40 with SMTP id
 d9443c01a7336-2df81d07e31mr104333755ad.55.1790641261332; 
 Mon, 28 Sep 2026 17:21:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2e2c9d04eccsm64135ad.41.2026.09.28.17.21.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934956beec8so773806885a.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641260; x=1791246060; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1gHtsK2uaRfqHMNlJr91wZXAtAMIT0f7Zgili9N5sfE=;
 b=KuNClfwA/Bw5KCXgYk/Q3++ZPpjhvBtikIRyLIP+iZFQVNgy99IMXB1SsJyuC5rYYd
 kgwfcpB2sg1AX97sI+tvh1P4B6bsO/AxA1l5J/ZIw1yMsTkTCivkZDb1gve8viopzB5u
 cfiHX1O8Mz1TOBe6v14KXpUvgVLaFggTOGEDc=
X-Received: by 2002:a05:620a:4009:b0:93c:677c:778d with SMTP id
 af79cd13be357-93c677c7985mr1362697285a.59.1790641260048; 
 Mon, 28 Sep 2026 17:21:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4009:b0:93c:677c:778d with SMTP id
 af79cd13be357-93c677c7985mr1362693685a.59.1790641259501; 
 Mon, 28 Sep 2026 17:20:59 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91456d0a762sm49474406d6.2.2026.09.28.17.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:20:58 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3] net/bnxt: remove duplicate branches and conditions
Date: Mon, 28 Sep 2026 18:24:00 -0600
Message-ID: <20260929002400.1208437-1-Mohammad-Shuab.Siddique@broadcom.com>
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
v3:
* No code change. Stephen Hemminger asked to drop whitespace churn
  that supposedly misaligned several lines; checked the checksum-
  branch continuation lines byte-for-byte and they already match the
  file's own pre-existing 3-tab-plus-3-space continuation alignment
  used throughout this function.
v2:
* No code change. The AI-review bot flagged the merged Tx checksum-flag
  branches as a possible correctness regression, on the theory that a
  packet with a combined flag (e.g. PKT_TX_OIP_IIP_TCP_UDP_CKSUM) might
  now hit a different branch than before. Checked the flag definitions
  in bnxt_txr.h: each combined flag is defined as the bitwise OR of its
  constituent single flags, so a masked equality check against either
  single-flag macro already matches the combined-flag case too.

 drivers/net/bnxt/bnxt_flow.c | 14 ++++--------
 drivers/net/bnxt/bnxt_txr.c  | 44 ++++++++----------------------------
 2 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index 4bf38043b5..7a46604cb6 100644
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
index 36188346f1..6dc843e821 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -409,55 +409,31 @@ static int bnxt_start_xmit(struct rte_mbuf *tx_pkt,
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
 			   PKT_TX_OIP_IIP_CKSUM) {
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
-- 
2.47.3

