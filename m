Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F2606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=L4FKGDlh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D2664042E;
	Sat,  7 Nov 2026 06:11:56 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 26BB3402F0
 for <dev@dpdk.org>; Sat,  7 Nov 2026 06:11:55 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A72DRGM972482 for <dev@dpdk.org>; Fri, 6 Nov 2026 21:11:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=m2ybX7jruKqOCEAy2Y26x2e
 cnJZC88s5NjqCeacmc/g=; b=L4FKGDlhraGAS3gysDPl7sW+iNAqwUeyeWHrryy
 ump1ryGuho8lRL3GEFP7optcx+WMXnfPsOBBCCi38yIsJyYK6RGPjyBnDLAtaVCm
 K/PEKv34tjzx6EpzhN23R/XQi8ysWJtkC+KHEittcCZkJyheNGv3BMlX5OM7OGkj
 +LEFppHuBmdDIjd3wLoG6k+8UBs9lvIQd/OFLajUB8QYlgTLyKVHGkS3xcZe8hGc
 EhSVIxvJOsr2+d6873CUNoJ9csjq1Ufbb2udd+1lDvoedseIKghmc4P4g5HGJO9A
 MOLH4xzeyAmD73VQ10SyvqDPW1mbt+YrfD2tGZyA1jqqXMg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hs3qunv32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 06 Nov 2026 21:11:53 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Nov 2026 21:11:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 6 Nov 2026 21:11:53 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.161.76])
 by maili.marvell.com (Postfix) with ESMTP id 414D35B6966;
 Fri,  6 Nov 2026 21:11:50 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH] event/cnxk: fix new-event burst enqueue with LMTST
Date: Sat, 7 Nov 2026 10:41:38 +0530
Message-ID: <20261107051139.37923-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FJqOVOos c=1 sm=1 tr=0 ts=6aeeb319 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=OzZod3_BVdjU1s48K54A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAyMCBTYWx0ZWRfX0SzNZTFgbd25
 i4QsH6I6nqj5FPGy/082tEoglvl8DoxAblfwrPgp22ZLSmqV9xA+U7OAYIaIFzVYw0oXJYkiAn3
 pB+s7ws2+nPGLM3XjPX7csH09rhbIZg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAyMCBTYWx0ZWRfXx+XzNMNBtrQ1
 ioZ5C2Up+ks75uStWjwPK/z52VktLIjwJHinNooZLRvKBKvj0zRQOi2W2S66HSkG6OCU3NHht5t
 TtBTYcRjQxGufClFjyxFpjYrK2zFUR87q5SN8nsamdt8NN+bWOcSRK/9SAMdMCSCj3P7eDDDWZI
 Ip5mMc0uaq6HdVQttDRBV0TJ/CSmSFfnpm6RtSuMlioXLFfAC4+Sqzx+eDFFD3ToDzEHRnt7hNE
 79lqxpgX/w5x0CdG5PrrIguwu3IekFyfbyRKxwc3cOi6z9O1BgXg83+/L7g0T0s1bsM8kMqDqHR
 f/W30brMVe2gzVPeJOSX0wVp1SqFP8nzR/jQDBwtWj8RCcrtlws20lZ/h7VZFMAXltbFPZGSGf+
 WaQLSwoH92dErWrtv7i6pCZi3F32acevXlPyR/AJmB/Jvi7TZxVtN9uHP4OCyDI6JKyyYwJNoDm
 eqN9VX4Vha/HoesYa5g==
X-Proofpoint-GUID: MaZ4ivDgYrhBvsYCXZVWYAdeHr8r9pss
X-Proofpoint-ORIG-GUID: MaZ4ivDgYrhBvsYCXZVWYAdeHr8r9pss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Add an I/O write barrier after LMTST submissions in the new-event
helper so the stores are ordered before the next iteration.

Enqueue small bursts, below one LMT line of entries, event by event
instead of using the LMTST path.

Fixes: c3320d21b475 ("event/cnxk: use LMTST for enqueue new burst")
Fixes: b08b193bceab ("event/cnxk: add CN20K SSO enqueue fast path")

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/event/cnxk/cn10k_worker.c | 9 +++++++++
 drivers/event/cnxk/cn20k_worker.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/event/cnxk/cn10k_worker.c b/drivers/event/cnxk/cn10k_worker.c
index f33c3a561a88..a8ddbc5d8bfb 100644
--- a/drivers/event/cnxk/cn10k_worker.c
+++ b/drivers/event/cnxk/cn10k_worker.c
@@ -350,6 +350,8 @@ cn10k_sso_hws_new_event_lmtst(struct cn10k_sso_hws *ws, uint8_t queue_id,
 		roc_lmt_submit_steorl(wdata[1], pa[1]);
 	}
 
+	rte_io_wmb();
+
 	left -= (sz0 + sz1);
 	if (left)
 		goto again;
@@ -395,6 +397,13 @@ cn10k_sso_hws_enq_new_burst(void *port, const struct rte_event ev[],
 	uint8_t queue_id;
 	int32_t space;
 
+	if (nb_events < BIT(ROC_SSO_AW_PER_LMT_LINE_LOG2)) {
+		for (idx = 0; idx < nb_events; idx++)
+			if (!cn10k_sso_hws_new_event(ws, &ev[idx]))
+				break;
+		return idx;
+	}
+
 	/* Do a common back-pressure check and return */
 	space = sso_read_xaq_space(ws) - ws->xae_waes;
 	if (space <= 0)
diff --git a/drivers/event/cnxk/cn20k_worker.c b/drivers/event/cnxk/cn20k_worker.c
index 8c1df3dbafc1..c15e3cd46ae7 100644
--- a/drivers/event/cnxk/cn20k_worker.c
+++ b/drivers/event/cnxk/cn20k_worker.c
@@ -308,6 +308,8 @@ cn20k_sso_hws_new_event_lmtst(struct cn20k_sso_hws *ws, uint8_t queue_id,
 		roc_lmt_submit_steorl(wdata[1], pa[1]);
 	}
 
+	rte_io_wmb();
+
 	left -= (sz0 + sz1);
 	if (left)
 		goto again;
@@ -350,6 +352,13 @@ cn20k_sso_hws_enq_new_burst(void *port, const struct rte_event ev[], uint16_t nb
 	uint8_t queue_id;
 	int32_t space;
 
+	if (nb_events < BIT(ROC_SSO_AW_PER_LMT_LINE_LOG2)) {
+		for (idx = 0; idx < nb_events; idx++)
+			if (!cn20k_sso_hws_new_event(ws, &ev[idx]))
+				break;
+		return idx;
+	}
+
 	/* Do a common back-pressure check and return */
 	space = sso_read_xaq_space(ws) - ws->xae_waes;
 	if (space <= 0)
-- 
2.50.1 (Apple Git-155)

