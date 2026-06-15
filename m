Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A19CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D164B40A67;
	Mon, 15 Jun 2026 18:26:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 84AD640A6D;
 Mon, 15 Jun 2026 18:26:55 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFcCU11075350; Mon, 15 Jun 2026 09:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 ZGpDaQ/90gohKPVeRynVfkSS+Zu59skpo71xSiYhsg=; b=U2Q/i9q9ERlghdNqg
 G7CmmKMY004OzMrIt1cV5wuWzgCGfRQNiU7oa54PvfKoB++z8HtOFBp5sRGWj37A
 I1nlcUoTV9u2RtQf6PfomRuaxFLswg+d2SzililKSuYuHyxI1kWI8w2cDzKOZqIj
 94A9JiN07scJE5AIYGOV7ZhNz493eWIoqYR249AIwv9cA0odKy16cNjVWRcOqbsl
 c9e1X1UJ6lhL9K4EzEI0kFB/TlWjsB5rwa1gkkF3jJ2+VjT5hHE/31INW/U/12H1
 NQ3H5NAQVvTY59sJGxZMp6PmNVTJwoOzGFgxHr+vLiiqBIOzqDio9RXO7urqpq/M
 yyTcA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qefvhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:26:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:53 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id E630A3F7063;
 Mon, 15 Jun 2026 09:26:49 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
CC: Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 12/20] net/cnxk: fix unsigned integer underflow in LSO
 calculation
Date: Mon, 15 Jun 2026 21:54:38 +0530
Message-ID: <20260615162446.578336-12-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LIRHORNEmsfnTteqdQ_R-2OGnlUpxZbO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX0dZJO5wVYrkt
 gjrCzN+jhAUfh6hW/0Y+IH6jAgNsEDrOQhpqYQ2UIwDHmNp8GjJrmvXqeblYYuDf2MbLbYhFSII
 eew25sv4yw61g83/xtwzDiURevNmUVw=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a3027ce cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=4KMttb_-6IR8pCNhD48A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: LIRHORNEmsfnTteqdQ_R-2OGnlUpxZbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX+AtADtKeCCEm
 wgUsqkp3HjYp2AdtOSVMgMA9WX9B7kZpbqBXMFkBbA1PtvUDTGu0LPSYAQj4kbWiwERXYSvA6O0
 D4dqOcRppf0cWLj0nacj9SKrmM8y2iJ/rdid9iC++hm9vkc/t6Wp6GO2h4892QeSSHdlMuehtfK
 AyGCKvm+ifEcWc/D8DJvjx/Lrt2RAKQyYVpL30c6+0FtjS2qgNRvvhDgedimae2lt+ecDRgPcwr
 CjPPPAkzNQuLg8NM9EcKlh576CSYXwI1h9Kth0sSmBGxu4I5FQYlBPbIowcyNyzjSOM6h1eGrg8
 aLRi4OlPzi3ww00d2zoM9JRSGY2AyD+TH2EXPgbDsgftQtdCdM0FuSlQAV2jGkT4K6FSQBnNQe8
 vp/+1LHWU7Ie+ZvT6hC9M+KySxpdIjEd/EKbOtZ1XnBXILgM8HIeYnIVmJDnJ/exrjTUCJjD9cE
 x6WGjBRs1JGZOI3cumg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

Replace branchless mask-based selection with a ternary operator
to resolve Coverity integer underflow warning. The expression
-(!w1.il3type) assigned -1 to a uint64_t variable, which is
well-defined but flagged as an unsigned integer underflow.

Coverity issue: 502004

Fixes: 19f3af2371a7 ("net/cnxk: add Tx burst for CN10K")
Fixes: 39dc567c1955 ("net/cnxk: add Tx burst for CN9K")
Fixes: 006c1daa89b9 ("net/cnxk: support Tx burst scalar for CN20K")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/net/cnxk/cn10k_tx.h | 8 ++------
 drivers/net/cnxk/cn20k_tx.h | 8 ++------
 drivers/net/cnxk/cn9k_tx.h  | 8 ++------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index 8c912a1f35..d5cb2c3294 100644
--- a/drivers/net/cnxk/cn10k_tx.h
+++ b/drivers/net/cnxk/cn10k_tx.h
@@ -1138,10 +1138,8 @@ cn10k_nix_xmit_prepare(struct cn10k_eth_txq *txq,
 	if (flags & NIX_TX_NEED_EXT_HDR && flags & NIX_TX_OFFLOAD_TSO_F &&
 	    (ol_flags & RTE_MBUF_F_TX_TCP_SEG)) {
 		uint16_t lso_sb;
-		uint64_t mask;

-		mask = -(!w1.il3type);
-		lso_sb = (mask & w1.ol4ptr) + (~mask & w1.il4ptr) + m->l4_len;
+		lso_sb = (w1.il3type ? w1.il4ptr : w1.ol4ptr) + m->l4_len;

 		send_hdr_ext->w0.lso_sb = lso_sb;
 		send_hdr_ext->w0.lso = 1;
@@ -1766,13 +1764,11 @@ cn10k_nix_prepare_tso(struct rte_mbuf *m, union nix_send_hdr_w1_u *w1,
 		      const uint64_t flags, const uint64_t lso_tun_fmt)
 {
 	uint16_t lso_sb;
-	uint64_t mask;

 	if (!(ol_flags & RTE_MBUF_F_TX_TCP_SEG))
 		return;

-	mask = -(!w1->il3type);
-	lso_sb = (mask & w1->ol4ptr) + (~mask & w1->il4ptr) + m->l4_len;
+	lso_sb = (w1->il3type ? w1->il4ptr : w1->ol4ptr) + m->l4_len;

 	w0->u |= BIT(14);
 	w0->lso_sb = lso_sb;
diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index 8e64d2e352..a1c71f2761 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -1117,10 +1117,8 @@ cn20k_nix_xmit_prepare(struct cn20k_eth_txq *txq, struct rte_mbuf *m, struct rte
 	if (flags & NIX_TX_NEED_EXT_HDR && flags & NIX_TX_OFFLOAD_TSO_F &&
 	    (ol_flags & RTE_MBUF_F_TX_TCP_SEG)) {
 		uint16_t lso_sb;
-		uint64_t mask;

-		mask = -(!w1.il3type);
-		lso_sb = (mask & w1.ol4ptr) + (~mask & w1.il4ptr) + m->l4_len;
+		lso_sb = (w1.il3type ? w1.il4ptr : w1.ol4ptr) + m->l4_len;

 		send_hdr_ext->w0.lso_sb = lso_sb;
 		send_hdr_ext->w0.lso = 1;
@@ -1732,13 +1730,11 @@ cn20k_nix_prepare_tso(struct rte_mbuf *m, union nix_send_hdr_w1_u *w1, union nix
 		      uint64_t ol_flags, const uint64_t flags, const uint64_t lso_tun_fmt)
 {
 	uint16_t lso_sb;
-	uint64_t mask;

 	if (!(ol_flags & RTE_MBUF_F_TX_TCP_SEG))
 		return;

-	mask = -(!w1->il3type);
-	lso_sb = (mask & w1->ol4ptr) + (~mask & w1->il4ptr) + m->l4_len;
+	lso_sb = (w1->il3type ? w1->il4ptr : w1->ol4ptr) + m->l4_len;

 	w0->u |= BIT(14);
 	w0->lso_sb = lso_sb;
diff --git a/drivers/net/cnxk/cn9k_tx.h b/drivers/net/cnxk/cn9k_tx.h
index 0ec448e36c..2f9b936d56 100644
--- a/drivers/net/cnxk/cn9k_tx.h
+++ b/drivers/net/cnxk/cn9k_tx.h
@@ -478,10 +478,8 @@ cn9k_nix_xmit_prepare(struct cn9k_eth_txq *txq, struct rte_mbuf *m, struct rte_m

 	if (flags & NIX_TX_OFFLOAD_TSO_F && (ol_flags & RTE_MBUF_F_TX_TCP_SEG)) {
 		uint16_t lso_sb;
-		uint64_t mask;

-		mask = -(!w1.il3type);
-		lso_sb = (mask & w1.ol4ptr) + (~mask & w1.il4ptr) + m->l4_len;
+		lso_sb = (w1.il3type ? w1.il4ptr : w1.ol4ptr) + m->l4_len;

 		send_hdr_ext->w0.lso_sb = lso_sb;
 		send_hdr_ext->w0.lso = 1;
@@ -875,13 +873,11 @@ cn9k_nix_prepare_tso(struct rte_mbuf *m, union nix_send_hdr_w1_u *w1,
 		     uint64_t flags)
 {
 	uint16_t lso_sb;
-	uint64_t mask;

 	if (!(ol_flags & RTE_MBUF_F_TX_TCP_SEG))
 		return;

-	mask = -(!w1->il3type);
-	lso_sb = (mask & w1->ol4ptr) + (~mask & w1->il4ptr) + m->l4_len;
+	lso_sb = (w1->il3type ? w1->il4ptr : w1->ol4ptr) + m->l4_len;

 	w0->u |= BIT(14);
 	w0->lso_sb = lso_sb;
--
2.34.1

