Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F093C88E75
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0DC540270;
	Fri, 18 Sep 2026 05:23:45 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 1E35540262
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:23:44 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-39b35105ba4so243795a91.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701823; x=1790306623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AI4yNITqoEeGR/GyrfxsUgHbZ9lH/Jc0pFZOc+A187w=;
 b=pwY+p3WPg8hal7geFYQmF2jiXJxmbYbeks3ScRafAIKju+i3IpSe5RSmVnDSeHcppz
 4zvB6Z3Kru8SRQpLjcNWBygVkKwSiJaqZtK6luptT0Uofx50cYT0vAWsPlQSzZpUcJBx
 97h7cIzGa79DHpnCXtO10afxjHmE+7ILpa0e/PHbdDfnmRcvo7D6rC1q+s75CbbIbZ0B
 HSmMnuM+B0WEtTdFC5kF6pehB38ptprWzzv9JZ8+TCVWqbwXlryvQB0t3uguydiqPbCw
 ayOxvZPehA4iFYTUFQqXG6Frani8SwaB2NGnJjAe2KepC8BgoBRd8NcDQYEzWWhfXmBC
 2CBw==
X-Gm-Message-State: AFuF++lrihMs5ZSjYd7XDBef4BOXf2HDICwUb/rkCZSSNOuI/Qj8xN/R
 1pjX+wePW0YWcAMe5zAD64scRVRBKM3QJ/3GYih50QGZckDFtnZY/3tC8okIFRe3sa6nTpyhwQi
 gleeui10OnO7JUa8GRhuWc2ChdzL0dsV0izqe4XhqXMliw3r/QE0td+5LpSe5NiAr04BYRhynWn
 QlgAqkNOfP3InzYbIGgHUckfOvPUyIifZeU1srvl0EagPvlxOFe9R98QlivTnkMziW7ekoV+53G
 s4VCwC+YXcy
X-Gm-Gg: AYBFou1Ez08eYtmCsF8ULwSL5nA0kDHwKbjvB7rleMJ0piqH2oCDHauFg6CbaZFrf1Q
 vy6+uMwgeqVOjioEq4+ihT6KrUQlyAHbyhn3d5KJeTV7vW6B/pZyQy72fFFa4ARf8uTEu5PpoX+
 CMS1l2vrYhDtXS197Vly8mGOVlec5uPibEWrFrMrxgyoESpIOCQMGLfWfThR0PoyYaJwJD7wnC4
 jXNBBTBsnQ72m7c7gfCcljdDn7Srk28mCzf7UtfU2oJF4z9AtVFC9PmFetzan2fK43NQnZmhXos
 iisgtoKRpUcAfE3tUYlVbwgpsO0V8Lsy7Pm2Oa4HvN9slxFvFH1WBJtm/uRGP+kfRgqcpiaYI91
 yE8CWhW6g59V97Kf6OMet+rgyyYKQUqmrtrA0Q6VawCBR7CscG3rdqdktFUI9Ji/0Foh1o4f45M
 c5Ua4FpcpK7jLVXfaTTIBqI9jy3nIrv+l7RV0b5dyNvV2Nb0vevxa5
X-Received: by 2002:a17:90b:5545:b0:39d:e54c:8643 with SMTP id
 98e67ed59e1d1-39e54d13929mr2702140a91.11.1789701822882; 
 Thu, 17 Sep 2026 20:23:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39e5a514555sm279319a91.5.2026.09.17.20.23.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:23:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc52c77089bso358966a12.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701821; x=1790306621; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AI4yNITqoEeGR/GyrfxsUgHbZ9lH/Jc0pFZOc+A187w=;
 b=XyDDKzDQzQ54grHGHf627lPTcQJDWVcanSA1jwQ/FnQoV5FJx/k3R9PdrAp+fEOJGY
 d385r+GDrGmKarKnW8ChZ4jaVhvVY5rFtlNOulUcJJ7SMVtuH0jh/eS0KXgojqGjM8Nn
 h8OwlN6PbPguIwANStbrzmdDhcJLU0Mp8Ibkw=
X-Received: by 2002:a05:6a20:4309:b0:3d0:88f5:f806 with SMTP id
 adf61e73a8af0-3dd8c36d005mr2331826637.15.1789701821037; 
 Thu, 17 Sep 2026 20:23:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:4309:b0:3d0:88f5:f806 with SMTP id
 adf61e73a8af0-3dd8c36d005mr2331775637.15.1789701820456; 
 Thu, 17 Sep 2026 20:23:40 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c2872052fsm576892eec.11.2026.09.17.20.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:23:40 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: remove duplicate branches and conditions
Date: Thu, 17 Sep 2026 21:26:45 -0600
Message-ID: <20260918032645.763349-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

