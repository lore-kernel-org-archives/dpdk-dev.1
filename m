Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F95EFCD74
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 10:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3579B40281;
	Mon,  9 Mar 2026 11:16:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D438740261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 11:16:49 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628MNPTm3370975; Mon, 9 Mar 2026 03:16:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=j3S+A31jbQxcPXo2srsnRd1
 IAeIc5oOfgJJLJq99L4U=; b=ZT1EiCJQFG+eLL5NBax7n+GVvfoMpdBNTytKMST
 MFp72FI26RW9yVu7LFKBCL+jatGXBPCmvqWTGfJmuj6PCHySFfTISsZzSChMO6gt
 BKf6H65TdsLpQEFeSWOjL8nc0DRye3GBnqsq34w8YOKJjqdV4EvIYTvJh/seC117
 +TF1EiGxXIVnPSLqyhMZJChKcS3WP1O9IxGRQj4jdc4C6gGywbUvRJMNklrEdJP9
 LK6nEn2BT3NpzvuaXEYEdp1BLs7VsDQvbPlyDVsU96U4XP34GAzfno+JrepcP6Aw
 gwDZl+sTZ0CqE3wLerNOenDrVlzwcCQVQ2tMVlJGntvv3OA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4crj8qu9nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 03:16:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Mar 2026 03:16:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 9 Mar 2026 03:16:47 -0700
Received: from LYYJYPGKF4.marvell.com (LYYJYPGKF4.marvell.com [10.28.19.12])
 by maili.marvell.com (Postfix) with ESMTP id 141FA5B6921;
 Mon,  9 Mar 2026 03:16:43 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/cnxk: disable template on generic build
Date: Mon, 9 Mar 2026 15:46:39 +0530
Message-ID: <20260309101640.32391-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA5NCBTYWx0ZWRfX5hD2tR9FxAYA
 fW4YhRyXnBF3dTCmjX+r0O6z3o2uaWZBrehBggaLgYEJQ8nIb4LAhJOIB1J2xDDVNzwGTqUpMWi
 JTe9bHrscATMK5YpZtVLpEvr3IzywKz4DDuytGUjpO7RAZowM2D9HtGfyeao+D0nuSC6YdQkb6P
 kMvl4sS3DF4UG2R89Cbo9ixX5OkVcjJOnX8MKcTF7ZbMCV2HpONYxmfwXe1XfXYhhCiUK18Va8C
 vnPc3sFHWxBTv6W3esoe1TKDw3uAf6yd3BmdSlK1Gy3GhRSK+lc4bkaew5CpoT9ddMLHW0HF3t7
 GY0uPwNeXToSeDE/dxCHh+c4bNn/JHeNxrUqhiMyHmCZxd7OeJOkyrRyOYS8psBQxXGusjg/EgG
 WVo3GUy21YrTL6DrpXQVBmyFj2akO6v28JIOoadVeVU3sj8G/2x2ONr1FCV5yaj/SZTdwldfJC2
 b50xR7q6IgRQG2eoxEA==
X-Proofpoint-GUID: OVctto12ByzJwKSSIEQ7hLg2KCLQTHj1
X-Proofpoint-ORIG-GUID: OVctto12ByzJwKSSIEQ7hLg2KCLQTHj1
X-Authority-Analysis: v=2.4 cv=WbwBqkhX c=1 sm=1 tr=0 ts=69ae9e10 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=jZVsG21pAAAA:8
 a=79eYHQRHv9CpfBLDa8QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Disable building template files for generic target
to save build time.

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/event/cnxk/meson.build |  5 +++++
 drivers/net/cnxk/cn10k_tx.h    | 38 +++++++++++++++++-----------------
 drivers/net/cnxk/cn9k_tx.h     |  6 +++---
 drivers/net/cnxk/meson.build   |  5 +++++
 4 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.build
index 24b48d045f01..c21e01c93055 100644
--- a/drivers/event/cnxk/meson.build
+++ b/drivers/event/cnxk/meson.build
@@ -36,6 +36,11 @@ if meson.version().version_compare('>=1.1.0')
         endif
 endif
 
+if soc_type == 'all'
+    disable_template = true
+    cflags += '-DCNXK_DIS_TMPLT_FUNC'
+endif
+
 if soc_type == 'cn9k' or soc_type == 'all'
 sources += files(
         'cn9k_eventdev.c',
diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index be9e020ac55e..f259ac2ccf7f 100644
--- a/drivers/net/cnxk/cn10k_tx.h
+++ b/drivers/net/cnxk/cn10k_tx.h
@@ -1445,7 +1445,7 @@ cn10k_nix_xmit_pkts(void *tx_queue, uint64_t *ws, struct rte_mbuf **tx_pkts,
 {
 	struct cn10k_eth_txq *txq = tx_queue;
 	const rte_iova_t io_addr = txq->io_addr;
-	uint8_t lnum, c_lnum, c_shft, c_loff;
+	uint8_t lnum, c_lnum = 0, c_shft = 0, c_loff = 0;
 	uintptr_t pa, lbase = txq->lmt_base;
 	uint16_t lmt_id, burst, left, i;
 	struct rte_mbuf *extm = NULL;
@@ -1453,9 +1453,9 @@ cn10k_nix_xmit_pkts(void *tx_queue, uint64_t *ws, struct rte_mbuf **tx_pkts,
 	uint64_t lso_tun_fmt = 0;
 	uint64_t mark_fmt = 0;
 	uint8_t mark_flag = 0;
-	rte_iova_t c_io_addr;
-	uint16_t c_lmt_id;
-	uint64_t sa_base;
+	rte_iova_t c_io_addr = 0;
+	uint16_t c_lmt_id = 0;
+	uint64_t sa_base = 0;
 	uintptr_t laddr;
 	uint64_t data;
 	bool sec;
@@ -1599,17 +1599,17 @@ cn10k_nix_xmit_pkts_mseg(void *tx_queue, uint64_t *ws,
 	const rte_iova_t io_addr = txq->io_addr;
 	uint16_t segdw, lmt_id, burst, left, i;
 	struct rte_mbuf *extm = NULL;
-	uint8_t lnum, c_lnum, c_loff;
+	uint8_t lnum, c_lnum = 0, c_loff = 0;
 	uintptr_t c_lbase = lbase;
 	uint64_t lso_tun_fmt = 0;
+	rte_iova_t c_io_addr = 0;
+	uint8_t shft, c_shft = 0;
+	uint16_t c_lmt_id = 0;
 	uint64_t mark_fmt = 0;
 	uint8_t mark_flag = 0;
 	uint64_t data0, data1;
-	rte_iova_t c_io_addr;
-	uint8_t shft, c_shft;
 	__uint128_t data128;
-	uint16_t c_lmt_id;
-	uint64_t sa_base;
+	uint64_t sa_base = 0;
 	uintptr_t laddr;
 	bool sec;
 
@@ -2166,14 +2166,14 @@ cn10k_nix_xmit_pkts_vector(void *tx_queue, uint64_t *ws,
 	uint64x2_t len_olflags0, len_olflags1, len_olflags2, len_olflags3;
 	uint64x2_t cmd0[NIX_DESCS_PER_LOOP], cmd1[NIX_DESCS_PER_LOOP],
 		cmd2[NIX_DESCS_PER_LOOP], cmd3[NIX_DESCS_PER_LOOP];
-	uint16_t left, scalar, burst, i, lmt_id, c_lmt_id;
+	uint16_t left, scalar, burst, i, lmt_id, c_lmt_id = 0;
 	uint64_t *mbuf0, *mbuf1, *mbuf2, *mbuf3, pa;
-	uint64x2_t senddesc01_w0, senddesc23_w0;
-	uint64x2_t senddesc01_w1, senddesc23_w1;
-	uint64x2_t sendext01_w0, sendext23_w0;
-	uint64x2_t sendext01_w1, sendext23_w1;
-	uint64x2_t sendmem01_w0, sendmem23_w0;
-	uint64x2_t sendmem01_w1, sendmem23_w1;
+	uint64x2_t senddesc01_w0 = {0}, senddesc23_w0 = {0};
+	uint64x2_t senddesc01_w1 = {0}, senddesc23_w1 = {0};
+	uint64x2_t sendext01_w0 = {0}, sendext23_w0 = {0};
+	uint64x2_t sendext01_w1 = {0}, sendext23_w1 = {0};
+	uint64x2_t sendmem01_w0 = {0}, sendmem23_w0 = {0};
+	uint64x2_t sendmem01_w1 = {0}, sendmem23_w1 = {0};
 	uint8_t segdw[NIX_DESCS_PER_LOOP + 1];
 	uint64x2_t sgdesc01_w0, sgdesc23_w0;
 	uint64x2_t sgdesc01_w1, sgdesc23_w1;
@@ -2181,13 +2181,13 @@ cn10k_nix_xmit_pkts_vector(void *tx_queue, uint64_t *ws,
 	rte_iova_t io_addr = txq->io_addr;
 	uint8_t lnum, shift = 0, loff = 0;
 	uintptr_t laddr = txq->lmt_base;
-	uint8_t c_lnum, c_shft, c_loff;
+	uint8_t c_lnum = 0, c_shft = 0, c_loff = 0;
 	uint64x2_t ltypes01, ltypes23;
 	uint64x2_t xtmp128, ytmp128;
 	uint64x2_t xmask01, xmask23;
 	uintptr_t c_laddr = laddr;
-	rte_iova_t c_io_addr;
-	uint64_t sa_base;
+	rte_iova_t c_io_addr = 0;
+	uint64_t sa_base = 0;
 	union wdata {
 		__uint128_t data128;
 		uint64_t data[2];
diff --git a/drivers/net/cnxk/cn9k_tx.h b/drivers/net/cnxk/cn9k_tx.h
index 14594b63115f..32665d20502d 100644
--- a/drivers/net/cnxk/cn9k_tx.h
+++ b/drivers/net/cnxk/cn9k_tx.h
@@ -1182,13 +1182,13 @@ cn9k_nix_xmit_pkts_vector(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint64x2_t len_olflags0, len_olflags1, len_olflags2, len_olflags3;
 	uint64x2_t cmd0[NIX_DESCS_PER_LOOP], cmd1[NIX_DESCS_PER_LOOP],
 		cmd2[NIX_DESCS_PER_LOOP], cmd3[NIX_DESCS_PER_LOOP];
+	uint64x2_t sendext01_w0 = {0}, sendext23_w0 = {0};
+	uint64x2_t sendext01_w1 = {0}, sendext23_w1 = {0};
+	uint64x2_t sendmem01_w1 = {0}, sendmem23_w1 = {0};
 	uint64_t *mbuf0, *mbuf1, *mbuf2, *mbuf3;
 	uint64x2_t senddesc01_w0, senddesc23_w0;
 	uint64x2_t senddesc01_w1, senddesc23_w1;
-	uint64x2_t sendext01_w0, sendext23_w0;
-	uint64x2_t sendext01_w1, sendext23_w1;
 	uint64x2_t sendmem01_w0, sendmem23_w0;
-	uint64x2_t sendmem01_w1, sendmem23_w1;
 	uint64x2_t sgdesc01_w0, sgdesc23_w0;
 	uint64x2_t sgdesc01_w1, sgdesc23_w1;
 	struct cn9k_eth_txq *txq = tx_queue;
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index 53caa6c171e9..a0d98495952c 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -52,6 +52,11 @@ if meson.version().version_compare('>=1.1.0')
         endif
 endif
 
+if soc_type == 'all'
+    disable_template = true
+    cflags += '-DCNXK_DIS_TMPLT_FUNC'
+endif
+
 if soc_type == 'cn9k' or soc_type == 'all'
 # CN9K
 sources += files(
-- 
2.50.1 (Apple Git-155)

