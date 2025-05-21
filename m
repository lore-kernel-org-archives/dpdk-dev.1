Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285AEC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:58:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD8664113D;
	Wed, 21 May 2025 08:57:39 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
 by mails.dpdk.org (Postfix) with ESMTP id 4B9C3410EA
 for <dev@dpdk.org>; Wed, 21 May 2025 08:57:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQyDwFLykhEsZHfrXQMMZT5/y9WUuSmEhjRL82whAAx4x0YCPP7Vh6s+lZcPxGNBcH0x0u4Onyhnihlt1Uhb10chgUkauWbci6K6kwKJDXJN5mFJRil2+sjSZAs3zxZOEBLhXVT+mrVp1yhD8hKm/ncq5AuMpcr1WZ+Zp2FkivPYjTfoKSGdjon1KLE/As2RSPNT2w7uvCS2gHBWf5+AT80r21xwtVowxyaAkpBkQk9HtDXMTullty8atPYxcSPKj/Wr89QncMIFqHn75ip5VH+P46YwEl8VDZMnC5dCmFzPmQcxXcwR7qiw1YfikM8xcatj1f5pOtO6POpWF6WqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdYQi8rydS1gANf1zfpgO/Z9Uy68rXkHbT3CpPYO2+w=;
 b=jZ0gnC7JSkv0TqF9d95jmif+o/4oTlQmAYiQvIjW52NuLG384IAWDY/a4y/7SiI/qTurrKxufCFzBgel/Hxq+2jpABT63UG4tzI+ABJ5EvTs6oOOClrzeE8hlqZaPVS1OXzvlotqc+Qb7T5dN9K6bSblhLqQ1HmEzCaTxQFfMtUtJRlJF3Omiu2hloF6e1sAH7GGhIjbHFiAaiz6mD7rFbx5C+fxF8TatTRZlCcY6z1YctA8y0AptSVlbicygBPsYAtkSWVnZmMn76rYN1zKk19qJkn+/HVAt/6Fhzv3MMduTich9yE+3c//d67+czdjAKoAssKRvNXrleEm3hncwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdYQi8rydS1gANf1zfpgO/Z9Uy68rXkHbT3CpPYO2+w=;
 b=I4WcElVqveDjeuC2MVmSsrZKGPkDyq8215VdzBag6XoOUpnWAnI0lLG8FxSXEdpFtXC0KY8yf0a9PQvZGjxmzILNdOHyQ5i3J8aJsdCYjbQOuc/VPUShdrYMQuxLKFno78G+4En7LPR28iP7WrGZVj6zLikFZczrzUvjvaZYj1s6CcQYASYMGWxT7CcoVv7SR2a2tMClCTPrFou5p/J5CTlB3Eat10JKC2D4V7wjcMjQK7R/+cgotH9DSxK8eLcPCyyL8g4DT8z/lFxAWF3U8domQncNtVplw0eAn6+vfXO021NsOJDcEoZzivvv0u7sPU4J6o5/1xhUtnotkTwiwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:57:37 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:36 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 9/9] crypto/dpaa2_sec: add support for simple IPsec FD
Date: Wed, 21 May 2025 12:26:58 +0530
Message-Id: <20250521065658.857707-10-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 091c699a-4915-4065-c291-08dd9834c4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7plljgdX9MIYrsky7vaFRsphXPkkO2xn5wOQkqBti5kSYGxc1HajX+2ZdLez?=
 =?us-ascii?Q?kYKmZCCS2R2VMU7F9sXIoBqLXLLMbHCR8/tTSsgSuBIpD4WN6nkcWBTMeWho?=
 =?us-ascii?Q?RaAupzIx3SDixdtpoL23GfEzvr6AVLfT3rM6VExJ347h3QeqjXZSu4LbDHYH?=
 =?us-ascii?Q?uGUJ32YcNZzNcFppNNl5wLaSyqOVVaesNU1BVBmKJJns96sgyqh7JC+wRGtm?=
 =?us-ascii?Q?Kx4BvxKwP2PtGXIOijQmQ/Bo9ZLzMHNywMJSnkRtDFs+tYR/V2dG+ul7qNT4?=
 =?us-ascii?Q?ZAPhV+L0zBcxWJhXwKbg/MFWZ/C+DFuN25octn84hN4b3zrffkM6BLVUNDJF?=
 =?us-ascii?Q?CLv36AWeVP4KAeGj+z6cnqGl/3OXFqvdAaYeqYL6UOqgcj20OKHFkRswbiyb?=
 =?us-ascii?Q?FmkfTpW4K0jJYdhwP/uN6DI9VclAP/sOVa32deweY5KTK8ELamJGETS1qq+z?=
 =?us-ascii?Q?NbuabPYrCPd4GVgH3Fdy1vyBwYbFrJrsBKU1TriT5E1scOXEQkuZt2LnfSdv?=
 =?us-ascii?Q?4AnJm3mqtmk+aChC7Fd1Xi49Mak0Mmyret5micjnO5NMFeieLfxEtdUK0kQc?=
 =?us-ascii?Q?1C1+nj/ncPrmIoCepRKQ91iqOekwOQtMFOIPtwAzPhKK4LLV7TxBbFjRkt6m?=
 =?us-ascii?Q?ezOSmTs0eUTnbR84MchN48jxnFRodJb8X8fbm+o22rPlRelGVAluzrfO4FDU?=
 =?us-ascii?Q?G6puNIPLkEv9K8oNOZYwlnkLog5xpApUEJHkXqjHhD2TrH0KSLYm+EFpn7Ze?=
 =?us-ascii?Q?EDp701pZ/P4DvdWMP3GIfn05CesDfmI1BBFg5f4rLQQ8B1GOqCTL7FhTxllP?=
 =?us-ascii?Q?1VLad1Xf7T5TXyONqq8XqzuwR98rBIz7vXQwKQ/PebNXlkysbdb5NHmB/lDn?=
 =?us-ascii?Q?0dpogkliE3sibTwSvPPlle6zHRiK7Lt8KxN8qPz5V/peJw4+/qdBUSYefZr/?=
 =?us-ascii?Q?S8rHjrWheW4l2PWHhJtuijSF+OxYNB4Fk1gjqlRrq+f5NU3S+qTQZGv5qd3Q?=
 =?us-ascii?Q?TCxW6ph3lC9rn1wNKgSQHB9gGzRyXNP+pHG12x+YEbA0x3bOq5MdbIRCGaB1?=
 =?us-ascii?Q?yJho7lwR+3BfkzuxnQjFQ6E1jsqW4MNwBSLARLmZu8sqmBuI+ydbGeSmas9d?=
 =?us-ascii?Q?hXlD89MAg1nt+a75RVaeYS9M8WpLxQxa48LyuDVefzJeXaQ76I97W/GbrmMR?=
 =?us-ascii?Q?INryjFSS43OumaIkIJUv6KXidYN2yT471YF3cseikjUPLfGRMDX/uL0N7vnq?=
 =?us-ascii?Q?lepsUQLWMiyt+EySm5d0ly4Xm8SFqSuvDLINhYN2RCX5NE1q1L1w8kpvTxdG?=
 =?us-ascii?Q?grS82s4Csvm5qQ3MK2XSNeKRc8cQZEvWslOmjGWpM6FpDjwCwP7Ltf1wTTKS?=
 =?us-ascii?Q?kGDwzDFZivGBWDIigArb08ChuTa40gM0ALV7vdzo6OcxCxcRSfgwpnd1EC4r?=
 =?us-ascii?Q?orGvxvURJfWoy2vnQ6kG9q45PHaO7GhWbEvIqTzaZU7nbnvS9oiGyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JJl5ETfanQ/t94QaWyjfPLBH+u873gmVHBF+xfyEr3M0Qyok+sQY41ZOsO4?=
 =?us-ascii?Q?V1y2omvZcOzmp6Hw353G6qTZEalQAxDW9PiPGhNh2s0VhZZmkM9JR1qz1Fbd?=
 =?us-ascii?Q?kwuIc9iebz72uo6oFmBkiMK2LA5+HzJgw2i9FodGmJT8hbgwiH+viyEzdBNS?=
 =?us-ascii?Q?wnqpe0mL1DoBJrYkp32bHTbs2FQtKi899/4J/GACYA/9Zcp53/YULUCyGzvX?=
 =?us-ascii?Q?/m+bajh6rbTz37GfBYrMA3TugmgURSDUkXgrK2s6kw9AR9RSeQcqswSBOCGo?=
 =?us-ascii?Q?YySHDeb+KQ03UE+QRQ0u0oyqsXunzYwMgw75sLAliofNJ6Cj8Vv2s3i54bSh?=
 =?us-ascii?Q?MRqSPnOBjRoEuR2clJqkxM8z01rM4S6JXqF0Wz6LhgFXzb1sv5OzZeJmhc9z?=
 =?us-ascii?Q?srHvKk1wl64bGW8UavbpFjNXozfkGDyi849nuCljq3ZXXQ0NAn5YuiqIQmnP?=
 =?us-ascii?Q?AaeRU4kpxAC3tUSZzMZGhJ+2rUz0V8vtD2i3E/SfNN69SKTDLoXmyoU9QjQy?=
 =?us-ascii?Q?t8cKxD4uxB53mfk3P69M2RRUSSHbFlECQZmAKFbySAT4rA2p8RvcjzDsrhLM?=
 =?us-ascii?Q?7OWsEFdOES8EInLRg8ujrz+39Y5DHbIBTLG6/i/pOaMoA4YLHYrQj3GRGuCo?=
 =?us-ascii?Q?+7GmdV0KZN6Slta5xFQKKwi/eFoveHz7PDEMBUBIXBVXBBq/R9lmhQbuicMr?=
 =?us-ascii?Q?Yn3Hw8QIjTgNHFVZUVJ+Zr4EnV5mg/WXYhC9RhpB3Um0I0fmFIO1zR3nRBGe?=
 =?us-ascii?Q?i/HXpnBYQBj6epyGIgzOBfWNE0/qp0DIDAv3DTtmezq0iBhuHjTtewmAqLMX?=
 =?us-ascii?Q?hLFRtM4J4M6XoKGBpfy/6T/1j8M7VvtKyJQVYXbOV7nggbjUKJHiLt6QHcov?=
 =?us-ascii?Q?sPTTOw626a5b+93LdZpKjCZMpnwhWT8VbQv12TWLQV6rNkY8TJXvTwDIutjz?=
 =?us-ascii?Q?M6Cet6gvcDDFBGcVe0qGi2vty2iAQqH5+s2+Z2zj9A6yYTA1dwcNxIyeqt2+?=
 =?us-ascii?Q?CMajnh2lBGTmvGGGPmD09YL0waK1atjvkjBkyZzmOWI8ioKQXhhZcGmZ6nDo?=
 =?us-ascii?Q?PYaeW1993ceLGibmqqXptW1grukT76aCi9suHRFHGjT23RsgZD0c3xYis0mk?=
 =?us-ascii?Q?/pneAo5iyyjzSmyKOOtscL7VCtPuoWZFatxcw/uH0m0ya+Cp7RRJDiYpHQ/W?=
 =?us-ascii?Q?Mt2T4zHbdC2jRYQ1WgUejH+6I11YF7O6tKHtebcNQBNe/fA9VPLvwWRIKxb3?=
 =?us-ascii?Q?rwVAlYm8Ht5pb6CBryiGBxsKS6T0DIfVfxv37UbuDD4eqEnpvp6Pgje9png1?=
 =?us-ascii?Q?1JJoKGKYi0u9qF2yqlMOjUn9oYXUeH7XHe5yAvKS0vyADj83Oy4TQxfGgf+n?=
 =?us-ascii?Q?sQG3ZGJmSaVcxwIU5E1kIis6H5oGgYINzMVcjSPmHBbQdjcXq1Pp0T14MRTP?=
 =?us-ascii?Q?zbM61Qg39EBSut/BXENg+xVYp3aEzvVPfDkBknh7DYtB4NpKX7G95CP6TH/4?=
 =?us-ascii?Q?5LZESDMftsQqDzWbzsS2UILp5+lccBf23XIAaR1398uEfG/Iv/ZI7isGsOLa?=
 =?us-ascii?Q?dJFF3mcNRxkFm3vEZ301vQDH1qaFt3y0K73NsmFy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091c699a-4915-4065-c291-08dd9834c4a8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:36.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqYXZQDxnVWxeKeC/rwRdrIFjY14WjUZVRYlbZYX6qDtbH6CiBNGSiypu4KSsHL4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
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

From: Jun Yang <jun.yang@nxp.com>

For IVP mode of simple IPsec FD, store op context point just
before expansion and align with point size(8).
Otherwise, store op context point in offset to mbuf with
rte_mbuf_dynfield register.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 143 +++++++++++++++-----
 drivers/crypto/dpaa2_sec/meson.build        |   3 +-
 2 files changed, 108 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 5995eb58d8..ca10d88da7 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -35,6 +35,7 @@
 #include "dpaa2_sec_priv.h"
 #include "dpaa2_sec_event.h"
 #include "dpaa2_sec_logs.h"
+#include "dpaa2_hw_dpni_annot.h"
 
 /* RTA header files */
 #include <desc/ipsec.h>
@@ -67,6 +68,14 @@ enum dpaa2_sec_dump_levels {
 uint8_t cryptodev_driver_id;
 uint8_t dpaa2_sec_dp_dump = DPAA2_SEC_DP_ERR_DUMP;
 
+static int s_dpaa2_sec_cntx_pos = -1;
+
+static const struct rte_mbuf_dynfield s_dpaa2_sec_cntx_pos_dyn = {
+	.name = "dpaa2_sec_cntx_pos_dyn",
+	.size = sizeof(void *),
+	.align = alignof(void *),
+};
+
 static inline void
 dpaa2_sec_dp_fd_dump(const struct qbman_fd *fd, uint16_t bpid,
 		     struct rte_mbuf *mbuf, bool tx)
@@ -319,30 +328,58 @@ build_proto_fd(dpaa2_sec_session *sess,
 	       struct qbman_fd *fd, uint16_t bpid, struct dpaa2_sec_qp *qp)
 {
 	struct rte_crypto_sym_op *sym_op = op->sym;
+	struct sec_flow_context *flc;
+	struct ctxt_priv *priv = sess->ctxt;
+	int min_hdr;
+	void **op_context;
+
 	if (sym_op->m_dst)
 		return build_proto_compound_fd(sess, op, fd, bpid, qp);
 
-	struct ctxt_priv *priv = sess->ctxt;
-	struct sec_flow_context *flc;
-	struct rte_mbuf *mbuf = sym_op->m_src;
-
-	if (likely(bpid < MAX_BPID))
-		DPAA2_SET_FD_BPID(fd, bpid);
+	if (sess->dir == DIR_ENC)
+		min_hdr = -SEC_FLC_DHR_OUTBOUND;
 	else
-		DPAA2_SET_FD_IVP(fd);
+		min_hdr = SEC_FLC_DHR_INBOUND;
 
-	/* Save the shared descriptor */
 	flc = &priv->flc_desc[0].flc;
 
+	if (likely(bpid < MAX_BPID)) {
+		if (unlikely(s_dpaa2_sec_cntx_pos < 0)) {
+			DPAA2_SEC_ERR("SEC context position not registered!");
+			return -EINVAL;
+		}
+		op_context = (void *)((uint8_t *)sym_op->m_src +
+			s_dpaa2_sec_cntx_pos);
+		*op_context = op;
+		DPAA2_SET_FD_BPID(fd, bpid);
+	} else {
+		op_context = rte_pktmbuf_mtod_offset(sym_op->m_src,
+			void **, -(min_hdr + sizeof(void *)));
+		op_context = (void **)RTE_ALIGN_FLOOR((uintptr_t)op_context,
+			sizeof(void *));
+		if (unlikely((uint64_t)op_context <
+			(uint64_t)sym_op->m_src->buf_addr)) {
+			DPAA2_SEC_ERR("Too short offset to save context %p < %p",
+				op_context, sym_op->m_src->buf_addr);
+			return -EINVAL;
+		}
+		if (unlikely(sess->dir == DIR_ENC &&
+			(uint64_t)op_context <
+			((uint64_t)sym_op->m_src->buf_addr +
+			DPAA2_DYN_TX_MIN_FD_OFFSET))) {
+			DPAA2_SEC_ERR("ENC FAEAD being overlapped %p < %p + %" PRIu64,
+				op_context, sym_op->m_src->buf_addr,
+				(uint64_t)DPAA2_DYN_TX_MIN_FD_OFFSET);
+			return -EINVAL;
+		}
+		DPAA2_SET_FD_IVP(fd);
+	}
+
 	DPAA2_SET_FD_ADDR(fd, DPAA2_MBUF_VADDR_TO_IOVA(sym_op->m_src));
 	DPAA2_SET_FD_OFFSET(fd, sym_op->m_src->data_off);
 	DPAA2_SET_FD_LEN(fd, sym_op->m_src->pkt_len);
 	DPAA2_SET_FD_FLC(fd, DPAA2_VADDR_TO_IOVA(flc));
 
-	/* save physical address of mbuf */
-	op->sym->aead.digest.phys_addr = mbuf->buf_iova;
-	mbuf->buf_iova = (size_t)op;
-
 	return 0;
 }
 
@@ -1503,7 +1540,11 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 			/*Clear the unused FD fields before sending*/
 			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
 			mb_pool = (*ops)->sym->m_src->pool;
-			bpid = mempool_to_bpid(mb_pool);
+			if (mb_pool->ops_index ==
+				rte_dpaa2_mpool_get_ops_idx())
+				bpid = mempool_to_bpid(mb_pool);
+			else
+				bpid = MAX_BPID;
 			ret = build_sec_fd(*ops, &fd_arr[loop], bpid, dpaa2_qp);
 			if (ret) {
 				DPAA2_SEC_DP_DEBUG("FD build failed");
@@ -1549,37 +1590,51 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 }
 
 static inline struct rte_crypto_op *
-sec_simple_fd_to_mbuf(const struct qbman_fd *fd)
+dpaa2_sec_simple_fd_to_mbuf(const struct qbman_fd *fd)
 {
 	struct rte_crypto_op *op;
-	uint16_t len = DPAA2_GET_FD_LEN(fd);
+	uint16_t len = DPAA2_GET_FD_LEN(fd), bpid = MAX_BPID;
 	int16_t diff = 0;
-	dpaa2_sec_session *sess_priv __rte_unused;
+	struct rte_mbuf *mbuf;
+	dpaa2_sec_session *sess_priv;
+	uint8_t *vir;
+	void **op_context;
+
+	vir = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+
+	if (likely(!DPAA2_GET_FD_IVP(fd))) {
+		bpid = DPAA2_GET_FD_BPID(fd);
+		mbuf = DPAA2_INLINE_MBUF_FROM_BUF(vir,
+			rte_dpaa2_bpid_info[bpid].meta_data_size);
+		if (unlikely(s_dpaa2_sec_cntx_pos < 0)) {
+			DPAA2_SEC_ERR("SEC context position not registered!");
+			return NULL;
+		}
+		op_context = (void *)((uintptr_t)mbuf + s_dpaa2_sec_cntx_pos);
+		op = *op_context;
+	} else {
+		op_context = (void **)RTE_PTR_ALIGN_FLOOR(vir +
+			DPAA2_GET_FD_OFFSET(fd) - sizeof(void *),
+			sizeof(void *));
 
-	if (unlikely(DPAA2_GET_FD_IVP(fd))) {
-		DPAA2_SEC_ERR("error: non inline buffer");
-		return NULL;
+		op = *op_context;
+		mbuf = op->sym->m_src;
 	}
-	struct rte_mbuf *mbuf = DPAA2_INLINE_MBUF_FROM_BUF(
-		DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd)),
-		rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size);
+	sess_priv = SECURITY_GET_SESS_PRIV(op->sym->session);
 
 	diff = len - mbuf->pkt_len;
 	mbuf->pkt_len += diff;
 	mbuf->data_len += diff;
-	op = (struct rte_crypto_op *)(size_t)mbuf->buf_iova;
-	mbuf->buf_iova = op->sym->aead.digest.phys_addr;
-	op->sym->aead.digest.phys_addr = 0L;
 
-	sess_priv = SECURITY_GET_SESS_PRIV(op->sym->session);
 	if (sess_priv->dir == DIR_ENC)
 		mbuf->data_off += SEC_FLC_DHR_OUTBOUND;
 	else
 		mbuf->data_off += SEC_FLC_DHR_INBOUND;
 
 	if (unlikely(fd->simple.frc)) {
-		DPAA2_SEC_ERR("SEC returned Error - %x",
-				fd->simple.frc);
+		DPAA2_SEC_ERR("SEC %s returned Error - %x",
+			sess_priv->dir == DIR_ENC ? "encap" : "decap",
+			fd->simple.frc);
 		op->status = RTE_CRYPTO_OP_STATUS_ERROR;
 	} else {
 		op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
@@ -1589,14 +1644,15 @@ sec_simple_fd_to_mbuf(const struct qbman_fd *fd)
 }
 
 static inline struct rte_crypto_op *
-sec_fd_to_mbuf(const struct qbman_fd *fd, struct dpaa2_sec_qp *qp)
+dpaa2_sec_fd_to_mbuf(const struct qbman_fd *fd,
+	struct dpaa2_sec_qp *qp)
 {
 	struct qbman_fle *fle;
 	struct rte_crypto_op *op;
 	struct rte_mbuf *dst, *src;
 
 	if (DPAA2_FD_GET_FORMAT(fd) == qbman_fd_single)
-		return sec_simple_fd_to_mbuf(fd);
+		return dpaa2_sec_simple_fd_to_mbuf(fd);
 
 	fle = (struct qbman_fle *)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
 
@@ -1728,7 +1784,7 @@ dpaa2_sec_free_eqresp_buf(uint16_t eqresp_ci,
 
 	dpaa2_qp = container_of(dpaa2_q, struct dpaa2_sec_qp, tx_vq);
 	fd = qbman_result_eqresp_fd(&dpio_dev->eqresp[eqresp_ci]);
-	op = sec_fd_to_mbuf(fd, dpaa2_qp);
+	op = dpaa2_sec_fd_to_mbuf(fd, dpaa2_qp);
 	/* Instead of freeing, enqueue it to the sec tx queue (sec->core)
 	 * after setting an error in FD. But this will have performance impact.
 	 */
@@ -1843,7 +1899,11 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 			/*Clear the unused FD fields before sending*/
 			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
 			mb_pool = (*ops)->sym->m_src->pool;
-			bpid = mempool_to_bpid(mb_pool);
+			if (mb_pool->ops_index ==
+				rte_dpaa2_mpool_get_ops_idx())
+				bpid = mempool_to_bpid(mb_pool);
+			else
+				bpid = MAX_BPID;
 			ret = build_sec_fd(*ops, &fd_arr[loop], bpid, dpaa2_qp);
 			if (ret) {
 				DPAA2_SEC_DP_DEBUG("FD build failed");
@@ -1965,7 +2025,7 @@ dpaa2_sec_dequeue_burst(void *qp, struct rte_crypto_op **ops,
 		}
 
 		fd = qbman_result_DQ_fd(dq_storage);
-		ops[num_rx] = sec_fd_to_mbuf(fd, dpaa2_qp);
+		ops[num_rx] = dpaa2_sec_fd_to_mbuf(fd, dpaa2_qp);
 
 		if (unlikely(fd->simple.frc)) {
 			/* TODO Parse SEC errors */
@@ -3374,6 +3434,15 @@ dpaa2_sec_set_ipsec_session(struct rte_cryptodev *dev,
 		goto out;
 	}
 
+	ret = rte_mbuf_dynfield_register(&s_dpaa2_sec_cntx_pos_dyn);
+	if (ret < 0) {
+		DPAA2_SEC_ERR("Failed to register context pos");
+		goto out;
+	}
+	DPAA2_SEC_INFO("Register mbuf offset(%d) for sec context pos",
+		ret);
+	s_dpaa2_sec_cntx_pos = ret;
+
 	flc->word1_sdl = (uint8_t)bufsize;
 
 	flc_iova = DPAA2_VADDR_TO_IOVA(flc);
@@ -4028,7 +4097,7 @@ dpaa2_sec_process_parallel_event(struct qbman_swp *swp,
 	ev->sched_type = rxq->ev.sched_type;
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
-	ev->event_ptr = sec_fd_to_mbuf(fd, qp);
+	ev->event_ptr = dpaa2_sec_fd_to_mbuf(fd, qp);
 
 	qbman_swp_dqrr_consume(swp, dq);
 }
@@ -4053,7 +4122,7 @@ dpaa2_sec_process_atomic_event(struct qbman_swp *swp __rte_unused,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
-	crypto_op = sec_fd_to_mbuf(fd, qp);
+	crypto_op = dpaa2_sec_fd_to_mbuf(fd, qp);
 	dqrr_index = qbman_get_dqrr_idx(dq);
 	*dpaa2_seqn(crypto_op->sym->m_src) = QBMAN_ENQUEUE_FLAG_DCA | dqrr_index;
 	DPAA2_PER_LCORE_DQRR_SIZE++;
@@ -4080,7 +4149,7 @@ dpaa2_sec_process_ordered_event(struct qbman_swp *swp,
 	ev->sched_type = rxq->ev.sched_type;
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
-	crypto_op = sec_fd_to_mbuf(fd, qp);
+	crypto_op = dpaa2_sec_fd_to_mbuf(fd, qp);
 
 	*dpaa2_seqn(crypto_op->sym->m_src) = DPAA2_ENQUEUE_FLAG_ORP;
 	*dpaa2_seqn(crypto_op->sym->m_src) |= qbman_result_DQ_odpid(dq) <<
@@ -4355,7 +4424,7 @@ dpaa2_sec_dev_init(struct rte_cryptodev *cryptodev)
 	}
 
 	/* Initialize security_ctx only for primary process*/
-	security_instance = rte_malloc("rte_security_instances_ops",
+	security_instance = rte_zmalloc("rte_security_instances_ops",
 				sizeof(struct rte_security_ctx), 0);
 	if (security_instance == NULL)
 		return -ENOMEM;
diff --git a/drivers/crypto/dpaa2_sec/meson.build b/drivers/crypto/dpaa2_sec/meson.build
index acca4176b0..31a441824d 100644
--- a/drivers/crypto/dpaa2_sec/meson.build
+++ b/drivers/crypto/dpaa2_sec/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2018,2021 NXP
+# Copyright 2018,2021-2024 NXP
 
 if not is_linux
     build = false
@@ -14,3 +14,4 @@ sources = files(
 )
 
 includes += include_directories('mc', '../../common/dpaax', '../../common/dpaax/caamflib')
+includes += include_directories('../../net/dpaa2/base')
-- 
2.25.1

