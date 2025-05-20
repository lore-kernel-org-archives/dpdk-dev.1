Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF6EC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D3C40A84;
	Tue, 20 May 2025 07:52:18 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
 by mails.dpdk.org (Postfix) with ESMTP id D88CE40A6E
 for <dev@dpdk.org>; Tue, 20 May 2025 07:52:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFj1JwxVzE/1T2M9InijWmayOuUI6UW/Z16fToO3y27rmNnJV4OOvlJR4IrGKtK7r5L1rFhaXWmLqEOU5nrbUrrGf0dvkxotU6APr6YLaSVVWhGwnAzGgliFKaZFznAk5Hf79yI9kSdclc82xfTTaY5zxOtvaij9TfeyTbGvcZCZiHyLomTxJchZcMeLSxX+mlAGzUSJdlpVVAS7E4KGxdF2p7BstVJFa04KHMcciVc7HWftWkYjt0YwcG1ls4UXmsjqo1QzHwaZILZQS7Q0D63w1hkJcamBPN+Ij/car47ZaQx1rfjNj0HXh458BUrQOY2uDcX6cwWuBa911fjaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUA0mEC1Kyo8QdUPGFiVfLmYy4QDUxWNRpgEtdPa5yc=;
 b=AemdXGuJQUAPacw89sbMQi77dhxVB2RUvLgqbnyyWnqj947p3rzZNM4Fd7lcU57jt4PwrSjA5VAxQUUPvA/uKAvl37FaT2Ez+8n0DQQgKVkokOvsYw2YMVsa9QrRPgbbAW+tS8HCW5XMNm+BYKK+QrsO5FjbpVc94DWQJtgu7NFz2cUW9A7Yf7zv9DqO92R5fwZ7Ad/ngBHlA3ULzazsd31728IR+YPxfsXptsr7W7LL6Bykf94arQIb4+lMOLl8XS8lHi+GQAsCFy0PPSunV5ilRo16yZRN8YAPLdcLuqP08eJCM4p6YSB78KAG/0lZ2OlftFXBbS7zwArS6KHcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUA0mEC1Kyo8QdUPGFiVfLmYy4QDUxWNRpgEtdPa5yc=;
 b=YLagEIP6JNXGphzI/qL9ipMBjlWoQUh7LOBSjbfowD/QPqWwOVr6pObTLts1HOt8hfkT4MY0YCojswhclAn9be8AgWPwJIcWsVD4cNhR44EAE8dAMD4lRzaN6/2QiV8K8QgsAzhOrjzuq2+mAina6toTQ6QC/oE8BfEsL6OCog9mZ7FdXUkppOs68qaU9SrjYFFGb2xoSCD/JqLyZM04ESkV1yht5VRvvhV1CU4osnX6Jw8fL5LBcULWCioqq3GUMuoT/KUq1B1Sqjxtydm834u4v+QyiFUeVSlRX48gRHDa+8OVt8dOzwwIK6+oUVtvpk+VAr4tpvtlOChuqu2nkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 05:52:16 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:16 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 9/9] crypto/dpaa2_sec: add support for simple IPsec FD
Date: Tue, 20 May 2025 11:21:33 +0530
Message-Id: <20250520055133.506071-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250520055133.506071-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 209826b5-1171-45a5-a41a-08dd97627991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ks/yjRiX1DZ3I3ZW5rZ3GcL01yfFI20LG/VXTHcqHCAtHdFzStGb8N9Hc+rz?=
 =?us-ascii?Q?gTW+kbx+6F+slHNLZBLODZmCEPsaZ7our76hCgncLBuz2lAZn7TSbZgCVu53?=
 =?us-ascii?Q?SVFmuMHDb9DGdVWMcCcVUnuPz4wFPRkoy8TLWNWJEnwMo0kAQd5LGXcdgcK8?=
 =?us-ascii?Q?bo1TsC3owv06hyw0qhOQnhqVm7gJVF58R1S8OWZEDqMaqH/qiN+lrg+Co71l?=
 =?us-ascii?Q?3fIaCPJAM5He5LeshKAfAfsyHDFuXBpqKdpO/9Qs57/VmvtQ/btlH+HZ9N/g?=
 =?us-ascii?Q?g9/H/oIs3xTF+5HlALaPeoTRvTs/nNGWf7VIF7NWRF13Bij1zOAxb262Fxg7?=
 =?us-ascii?Q?yXQGPqj/XF2rMDnRu5G44sJrOaTnN5rFPM7H/+EwrEoPf9kkQjGhN7zLB92g?=
 =?us-ascii?Q?zet4IufSE1nBA14z0WFynWr4YakIjEBk4cbOMcszp8ot4sXn4CNe1voGp/gj?=
 =?us-ascii?Q?DZeLuh0IlI0vLp1v8+JKfO4Qr8Y92+ViKO1vFXTcnCgl/8NshoV3QjYgHr5r?=
 =?us-ascii?Q?7hThr/Kox1kpKRgnuWGN6Y2DbZUHZu23B4ob53xAsRpIrVZ76pEKvKYs7Izr?=
 =?us-ascii?Q?xnVrgqvkgBmqi2l0/+SUpnkLn4TbTz0JdUr6uJp6EwNvX/A9rm4CL5BqoIjV?=
 =?us-ascii?Q?3xgTflN1iIy+fcTgT6A0hvsTV5w9JXymbADmsINxzxLGT9kyH1CYNlN6nW9u?=
 =?us-ascii?Q?VJZ2nSdTD7AnnK6EWRlDL5KZYH4XJNXHy6wLQdZil+rKjkOkczQz9tlYYe0V?=
 =?us-ascii?Q?S+HGBPRMMxT/FwPvypVZbFPCGyIzwsS8sPCDzgQ/1V835pl6vCa5ylceXhQd?=
 =?us-ascii?Q?XWLahpPEvx1ITt6LbR4RkAAWC5RTUY5XEiaGzhowNU4XRlvdjGcfgM/5bqXg?=
 =?us-ascii?Q?gbFdTJY6Ga73Vy0zoipa8XE/E0gAfpZZo0tsya81sLiFbLrZXXwguAVNaDTt?=
 =?us-ascii?Q?7HkmZAtwGmCqr3Xn1C2cO9/7R0XXvavv7JTREyIGYR+O4+rfZk8PWN191gPI?=
 =?us-ascii?Q?1iFGIP9NY2PQDzZQqPruDN2aFUGSTNTCnAo4qZ9JpIOOjE56hu6TWAawFga7?=
 =?us-ascii?Q?GhyfW1M1/7AIWZJLJeVY7WbE++8uUc2YxN7hf/N+ZLG/j3GXUMAK9tpQxdT1?=
 =?us-ascii?Q?jbjtOnrBpDHLuQVr0qHn7ZzphNl3LSSLjYFD1RnUaJqBz/vL0CdO09mKCeUy?=
 =?us-ascii?Q?PgyYuhNx7yxbWXzMpN8Y4g7yXNLknal3MlvtdgstwzetzgxzU4yT0AdbBpnv?=
 =?us-ascii?Q?a9OGOS8/poX9lbRzhggCJk5VY01wRi6Cml3+eAApbIDSLsW5fM+5wM6Oqhy7?=
 =?us-ascii?Q?6FTM4WJHmN41slFX+vFOWqtHO4zCbGTtYUGEj9Wg7tNMzq0E7X7khtHTtFAE?=
 =?us-ascii?Q?PVm3tcgbZUbTJsgq79yhUQfOM2wKLIJq+KklUCU1usKpbUiY8k8/+gvfD2C7?=
 =?us-ascii?Q?zFyaqjSYSsPNYsHggf+/bsGqqLfyoAXhJbktOUXtquNapBGoU4SFSw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmDMCDQpqkwwule39z/UbGKa27I/hGctW9T0hbc5JF1hnwhQBBW/Bjo0vhEv?=
 =?us-ascii?Q?3YfAlVWWfDYrzZLs9bcAaELzjeyUaTqyvHZgiof0zbWqIEeWROZko0ckFZx1?=
 =?us-ascii?Q?fXtauzYGd7sINlNvA9x9NJDsKOCD7ImVuLmCnuTdJBLvmGDDI0G05HVvX1YC?=
 =?us-ascii?Q?+PdF5in0uZmOEVBbz3BgwRBS8sWvbf1gROnGXNvjuVtNW0kfkr0G0xbK1CHZ?=
 =?us-ascii?Q?8gTiX2FWdcLn7pzrPxvecN0NaxrstIZdIMhDzdIzSTN8Yap2tnHQd5QuvZYT?=
 =?us-ascii?Q?1efyhrpEl+VhvirRXLPchY9Wy3bFPeKYNvZAdqwRs9otGTDttn5HHBksG2ml?=
 =?us-ascii?Q?X3TkSFMqDzP5zXpfmbbv5BbYFfdqvoAzErs0mJZ5MalbXHqK3uZYeWPofKvy?=
 =?us-ascii?Q?5yepv7AdOj+jeK36Lf74KFT2hWJ6xLsnxzIuJdL3RTSsb8ir38CzYtkZwoNo?=
 =?us-ascii?Q?S4l+p0AzJTcrlTpjPADgY+8EeldGXTv27WC35Q97Oja/GxFNK67Wtmaqkfqd?=
 =?us-ascii?Q?m8y1zEs/e2eM1peiX2NH9ymlxsWfSg4AkDaxGJHK89gCSzvek0LA0OC8T+0H?=
 =?us-ascii?Q?7gc0FQX4LqmerxAOBXWt7rawf+EDIpoUKIAmLpTMvIaG18b/Q3AqumZuSX7W?=
 =?us-ascii?Q?AI5b2xh7VUipZkKGqJkN9z3XHqpgCWXyKm45/O64D26px0JLxvFBTYgsJE2T?=
 =?us-ascii?Q?yFNy0vVPQOgOpTtxJF9FPjtXtnvBTChoC3cpJy2flm/AKO5ZpiK9NYeubcXy?=
 =?us-ascii?Q?WFSY5JE3LBC6rjS/X+JJEoDOhBQXrDXnEplFsi+hPT4lw0eoxWnEQwZe1BuI?=
 =?us-ascii?Q?66yuIV6cpKqhJIWimR2jbYlDTg3j4nnQZzGXpiTkrS2O9x++9siMFfu8Q2jE?=
 =?us-ascii?Q?nL2zo9iL6HgNwwZjKzVdBHAXvLbQ8s89Vl6hL+CJdSQzC8OzrPjJGa6CgxUu?=
 =?us-ascii?Q?bDvdxlIreu9rvj0QGsuG+Z/o+BQvi/N4NS5rmFTcQiN4FGaD205rU6ZvgQek?=
 =?us-ascii?Q?w+EgN6nfxQ+u00CN+xLB80ZcbDk+FAcQeUqPNiQ3cYOjeY5z8ASdXMJMvhJN?=
 =?us-ascii?Q?yl58rekjiCAmr2gj9cbXYir6mSrpNzIjmQ6Hs/QGo4orDOLskfKutS2OV4BE?=
 =?us-ascii?Q?FitllFM2UvHAwEsWlhCKqTOQ2MivkLdH1bzzYKNsZah7ODAXKGFO/ai1DBWk?=
 =?us-ascii?Q?6TCdX9dbAlmgAsOwo5Yxi22447kHnI43HA8bTVWeUX0OFYQ1IiYAgs9rNLZX?=
 =?us-ascii?Q?WmLH+FHKfiDWDGwNv/f5zumiAKlS8oODn+U+wHD5nTn/hGU4HGGOHH6z/reX?=
 =?us-ascii?Q?PaOyras926unkl13c/lelVSVrlgKBdcue1baHjGKqquRTskCxiZmUSf3D9Y9?=
 =?us-ascii?Q?yt2uQZOWGwpLPOfiZ7D9Gga2S6OvINXCI+bJW2iOzNdbFt4LJu2s8MY9NzGm?=
 =?us-ascii?Q?PJKjaz4vivZEI1r+15TQGcWMKcR07DDMBaKZ7kn2Zj8TnOadr92uOZtuTyOL?=
 =?us-ascii?Q?4TrSmfEUM4k0LYkulXBhHUVfgUKNJCbbMer4c1S6aBH/zrw2d4oZ1W7e0yig?=
 =?us-ascii?Q?U7eDzNWanOmvDzb4FWI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209826b5-1171-45a5-a41a-08dd97627991
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:16.1925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjncvzUbi/+qXltT4nJtI0Gg3wUNzGDagWLcmv82I7nk855BzHJn2INKI2qeboFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
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
index 5995eb58d8..6cc42ff5e0 100644
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
+		op_context = (void **)RTE_ALIGN_FLOOR((uint64_t)op_context,
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
+			DPAA2_SEC_ERR("ENC FAEAD being overlapped %p < %p + %lu",
+				op_context, sym_op->m_src->buf_addr,
+				DPAA2_DYN_TX_MIN_FD_OFFSET);
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
+		op_context = (void *)((uint64_t)mbuf + s_dpaa2_sec_cntx_pos);
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

