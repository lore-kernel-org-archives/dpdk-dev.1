Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5BFFCC9DB
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 08:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 154ED4069F;
	Tue, 10 Mar 2026 09:14:41 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 70228402B8
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:39 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A6bqia1846213; Tue, 10 Mar 2026 01:14:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
 mYxPcGrMHbWPrZNwa770VRjuRe7lcp4He0C5Onm7MQ=; b=eMSEJORvM8/A+0x9k
 RFrYTndarxW/hYQXpOGbq7pbiKMjaCt6z7xtdk9bjeGP/Jtmqe7PrY2Rt407MCR7
 PwmauV08fBtEBtuUmYeCSADjdfW+3B8+4rl5z6Wa1OT5ssOVdx34cOn2vTNvjVq0
 lQdGa6D4jARV83Ez0PsKf8LeFlR+k9HFC5jA+wIrCCWizbGYG7j2pifJSQZZyVWs
 ozPaw0EusRQV5clmUN9tluT4deCy2IyJB+l1Ixu6x+qXuhsU8lRsmHMWmWKRwAgg
 0lAL5agURnR6bsAPBQtygapdsKQa/IaurSEGXpPdNDznJPR3gfR8Fp3ZLK6t93Ea
 SMxXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cte6ug6h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 01:14:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Mar 2026 01:14:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 10 Mar 2026 01:14:37 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id 94D4F3F704D;
 Tue, 10 Mar 2026 01:14:33 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] net/cnxk: disable template on generic build
Date: Tue, 10 Mar 2026 13:44:29 +0530
Message-ID: <20260310081431.67199-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309101640.32391-1-pbhagavatula@marvell.com>
References: <20260309101640.32391-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SPlPlevH c=1 sm=1 tr=0 ts=69afd2ee cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=jZVsG21pAAAA:8
 a=GmBNg97MXbEiH9v-qZYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2NyBTYWx0ZWRfX1xNdiaTR7nvv
 NpcvF7LHpjve8fe/rwqIeswZk0UbPxfcHEp/W6lPxcUw79/IpPDTQiCNz72I8jh1clcYDz/0PIg
 OEDCpEi2o1b84kNpAtseTdt3LB1MEItnUPXsp/60ZvsFuGK4qI/bboyph1TWyrtuGWe9LXWV2ZN
 T42d1AwyfLt4W3f5BZRU5vrSZ0oYdvey8T35aNw6TmlfAycaYuD1SwZkYtrE+UCcdA0T1znut/k
 m0tPlzpH5p+3+6y+HA1TN+QNwgrB5x0BUiK7dPpc6uVstcSjNs1ky7DgJJizEF2g5VPoYqCt/PM
 lZ5DhcZnxk++b+q88S6zdeJ9/4Y8ZyncanUN+hRFgGcJ23iyAO5F3MYFyGpNkLW7MK/uwaig1nM
 gYQyG843OL6IoSk9DDsQgaptmzkEQAd5kmrcx/AE7wLJQAmWoGu/nk9HTU3Y1KUmUR87zXgw6fL
 IvLbksDqUwGE3Wb59xQ==
X-Proofpoint-GUID: OFFTZInFMUgI4lMzeHjIo6QFbpkJDoZZ
X-Proofpoint-ORIG-GUID: OFFTZInFMUgI4lMzeHjIo6QFbpkJDoZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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
v2 Changes:
- Compilation fix

 drivers/event/cnxk/meson.build |  5 +++++
 drivers/net/cnxk/cn10k_tx.h    | 40 +++++++++++++++++-----------------
 drivers/net/cnxk/cn9k_tx.h     |  6 ++---
 drivers/net/cnxk/meson.build   |  5 +++++
 4 files changed, 33 insertions(+), 23 deletions(-)

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
index be9e020ac55e..8c912a1f3561 100644
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
@@ -1599,19 +1599,19 @@ cn10k_nix_xmit_pkts_mseg(void *tx_queue, uint64_t *ws,
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
-	bool sec;
+	bool sec = 0;

 	if (flags & NIX_TX_OFFLOAD_MBUF_NOFF_F && txq->tx_compl.ena)
 		handle_tx_completion_pkts(txq, flags & NIX_TX_VWQE_F);
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

