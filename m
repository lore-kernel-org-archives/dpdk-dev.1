Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E08FC0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDB5E427C7;
	Fri, 31 Jan 2025 09:07:09 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 68B01410E8
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:07:08 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V8012x000704
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:07:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 w5++MnVuCJ2J60OTf/RcPXmKfezn2wNz7VtnObLcT8=; b=LKHceGG7HuHxsNj7X
 xjiQTIBCIDKN9x51zMaH8TgFKRoHeJgDqvB5rslc5XeNgWWYUjnw/utJBYHr5Rfh
 xiTAOJ5HiiCPzlKzA8pMOB/6P9N0ToBCHzichE/XmeQQRdBdcGiM8/Y65rna8SLZ
 oi9bdZ6CeIEaMIn5Ur2gpIXZM5C097t6TwYQb1XcsY3wV/8spyGzY2xwe2kGnfzv
 w+OIe6YEDmYZdlfcuux93/j8KI8fuHxEnfSoTjj7HNhDShua9gtfn0xsUMwY1MqX
 1osy4ZhGguXPNK3+eX23NQYThYUhrSePHrpta3mwLuKDYhdvHJT6QfSl8TNlCh9z
 azXnw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44gmhnghnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:07:07 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:07:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:07:06 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 0B9DB3F7045;
 Fri, 31 Jan 2025 00:07:03 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 29/34] net/cnxk: fix of NIX send header L3 type
Date: Fri, 31 Jan 2025 13:35:24 +0530
Message-ID: <20250131080530.3224977-29-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: edobfFhbnL_edCJVW3ngjkhL4gZS6ek3
X-Proofpoint-GUID: edobfFhbnL_edCJVW3ngjkhL4gZS6ek3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

For small packets less than 55 bytes, SQ error interrupts are
observed.
When checksum offload flag is enabled and mbuf ol_flags are not
set, then default L3 type will be set to IPv6 in vector
processing. Based on this, HW will still validate for minimum
header size and generate send header error if mismatch.

To address this, will set default L3 type to none. Mbuf ol_flags
RTE_MBUF_F_TX_IPV6 will set with offload feature TSO or L4
checksum only, so handled in corresponding routine.

Fixes: f71b7dbbf04b ("net/cnxk: add vector Tx for CN10K")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn10k_tx.h | 7 +++++--
 drivers/net/cnxk/cn20k_tx.h | 7 +++++--
 drivers/net/cnxk/cn9k_tx.h  | 7 +++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index 5a8e728bc1..809fafb2f7 100644
--- a/drivers/net/cnxk/cn10k_tx.h
+++ b/drivers/net/cnxk/cn10k_tx.h
@@ -1773,6 +1773,9 @@ cn10k_nix_prepare_tso(struct rte_mbuf *m, union nix_send_hdr_w1_u *w1,
 	w0->lso_mps = m->tso_segsz;
 	w0->lso_format = NIX_LSO_FORMAT_IDX_TSOV4 + !!(ol_flags & RTE_MBUF_F_TX_IPV6);
 	w1->ol4type = NIX_SENDL4TYPE_TCP_CKSUM;
+	w1->ol3type = ((!!(ol_flags & RTE_MBUF_F_TX_IPV4)) << 1) +
+		      ((!!(ol_flags & RTE_MBUF_F_TX_IPV6)) << 2) +
+		      !!(ol_flags & RTE_MBUF_F_TX_IP_CKSUM);
 
 	/* Handle tunnel tso */
 	if ((flags & NIX_TX_OFFLOAD_OL3_OL4_CSUM_F) &&
@@ -2477,7 +2480,7 @@ cn10k_nix_xmit_pkts_vector(void *tx_queue, uint64_t *ws,
 			 */
 			const uint8x16_t tbl = {
 				/* [0-15] = il4type:il3type */
-				0x04, /* none (IPv6 assumed) */
+				0x00, /* none */
 				0x14, /* RTE_MBUF_F_TX_TCP_CKSUM (IPv6 assumed) */
 				0x24, /* RTE_MBUF_F_TX_SCTP_CKSUM (IPv6 assumed) */
 				0x34, /* RTE_MBUF_F_TX_UDP_CKSUM (IPv6 assumed) */
@@ -2681,7 +2684,7 @@ cn10k_nix_xmit_pkts_vector(void *tx_queue, uint64_t *ws,
 			const uint8x16x2_t tbl = {{
 				{
 					/* [0-15] = il4type:il3type */
-					0x04, /* none (IPv6) */
+					0x00, /* none */
 					0x14, /* RTE_MBUF_F_TX_TCP_CKSUM (IPv6) */
 					0x24, /* RTE_MBUF_F_TX_SCTP_CKSUM (IPv6) */
 					0x34, /* RTE_MBUF_F_TX_UDP_CKSUM (IPv6) */
diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index 7674c1644a..c419778970 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -1733,6 +1733,9 @@ cn20k_nix_prepare_tso(struct rte_mbuf *m, union nix_send_hdr_w1_u *w1, union nix
 	w0->lso_mps = m->tso_segsz;
 	w0->lso_format = NIX_LSO_FORMAT_IDX_TSOV4 + !!(ol_flags & RTE_MBUF_F_TX_IPV6);
 	w1->ol4type = NIX_SENDL4TYPE_TCP_CKSUM;
+	w1->ol3type = ((!!(ol_flags & RTE_MBUF_F_TX_IPV4)) << 1) +
+		      ((!!(ol_flags & RTE_MBUF_F_TX_IPV6)) << 2) +
+		      !!(ol_flags & RTE_MBUF_F_TX_IP_CKSUM);
 
 	/* Handle tunnel tso */
 	if ((flags & NIX_TX_OFFLOAD_OL3_OL4_CSUM_F) && (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)) {
@@ -2395,7 +2398,7 @@ cn20k_nix_xmit_pkts_vector(void *tx_queue, uint64_t *ws, struct rte_mbuf **tx_pk
 			 */
 			const uint8x16_t tbl = {
 				/* [0-15] = il4type:il3type */
-				0x04, /* none (IPv6 assumed) */
+				0x00, /* none */
 				0x14, /* RTE_MBUF_F_TX_TCP_CKSUM (IPv6 assumed) */
 				0x24, /* RTE_MBUF_F_TX_SCTP_CKSUM (IPv6 assumed) */
 				0x34, /* RTE_MBUF_F_TX_UDP_CKSUM (IPv6 assumed) */
@@ -2595,7 +2598,7 @@ cn20k_nix_xmit_pkts_vector(void *tx_queue, uint64_t *ws, struct rte_mbuf **tx_pk
 			const uint8x16x2_t tbl = {{
 				{
 					/* [0-15] = il4type:il3type */
-					0x04, /* none (IPv6) */
+					0x00, /* none */
 					0x14, /* RTE_MBUF_F_TX_TCP_CKSUM (IPv6) */
 					0x24, /* RTE_MBUF_F_TX_SCTP_CKSUM (IPv6) */
 					0x34, /* RTE_MBUF_F_TX_UDP_CKSUM (IPv6) */
diff --git a/drivers/net/cnxk/cn9k_tx.h b/drivers/net/cnxk/cn9k_tx.h
index 9370985864..902a17860c 100644
--- a/drivers/net/cnxk/cn9k_tx.h
+++ b/drivers/net/cnxk/cn9k_tx.h
@@ -889,6 +889,9 @@ cn9k_nix_prepare_tso(struct rte_mbuf *m, union nix_send_hdr_w1_u *w1,
 	w0->lso_mps = m->tso_segsz;
 	w0->lso_format = NIX_LSO_FORMAT_IDX_TSOV4 + !!(ol_flags & RTE_MBUF_F_TX_IPV6);
 	w1->ol4type = NIX_SENDL4TYPE_TCP_CKSUM;
+	w1->ol3type = ((!!(ol_flags & RTE_MBUF_F_TX_IPV4)) << 1) +
+		      ((!!(ol_flags & RTE_MBUF_F_TX_IPV6)) << 2) +
+		      !!(ol_flags & RTE_MBUF_F_TX_IP_CKSUM);
 
 	/* Handle tunnel tso */
 	if ((flags & NIX_TX_OFFLOAD_OL3_OL4_CSUM_F) &&
@@ -1402,7 +1405,7 @@ cn9k_nix_xmit_pkts_vector(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 */
 			const uint8x16_t tbl = {
 				/* [0-15] = il4type:il3type */
-				0x04, /* none (IPv6 assumed) */
+				0x00, /* none */
 				0x14, /* RTE_MBUF_F_TX_TCP_CKSUM (IPv6 assumed) */
 				0x24, /* RTE_MBUF_F_TX_SCTP_CKSUM (IPv6 assumed) */
 				0x34, /* RTE_MBUF_F_TX_UDP_CKSUM (IPv6 assumed) */
@@ -1606,7 +1609,7 @@ cn9k_nix_xmit_pkts_vector(void *tx_queue, struct rte_mbuf **tx_pkts,
 			const uint8x16x2_t tbl = {{
 				{
 					/* [0-15] = il4type:il3type */
-					0x04, /* none (IPv6) */
+					0x00, /* none */
 					0x14, /* RTE_MBUF_F_TX_TCP_CKSUM (IPv6) */
 					0x24, /* RTE_MBUF_F_TX_SCTP_CKSUM (IPv6) */
 					0x34, /* RTE_MBUF_F_TX_UDP_CKSUM (IPv6) */
-- 
2.34.1

