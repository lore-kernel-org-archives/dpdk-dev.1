Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6FE606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=cprpuS0Q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14B8340E54;
	Mon,  2 Nov 2026 13:22:39 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 8014B4003C;
 Mon,  2 Nov 2026 13:22:36 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29DcOW545956; Mon, 2 Nov 2026 04:22:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 Vo3bCtARxk0lS2lM3nkRbHeWXk27Biww16ABM0G1wE=; b=cprpuS0Qf/rCaaOql
 lE5cUPGZc681BRwZicKY00T1j3cwp+kCmuAa0OqE19DWQzO3P2FIpFCw2jAp5NgQ
 FdESAKOrJGTSBLaZBDi8i7aoTjp7l965cGyf/3cOGnKsuf6AHXvm3ZVJKsGQaN+q
 pKcUvPfgdIoTtLmSQl3mms8/5zEfaOC3HM/d9dIFJx/zwQdYJTvJqApj8VxQJ7S3
 x6pS6y8WjPnz/w4X106vve8m7nMROSPFt21qjnmy1hhnDRr5BqY7LMJZcTLTMPSI
 D45czeDdo6Ll/bihBN5DZE+2bRWlenlKrmknVOg3QizeZXSoBCopI5I487LCtH1p
 owG3g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hp5fd35mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 04:22:34 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Nov 2026 04:22:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Nov 2026 04:22:32 -0800
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id 73AF43F7078;
 Mon,  2 Nov 2026 04:22:29 -0800 (PST)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
CC: <jerinj@marvell.com>, <rbhansali@marvell.com>, Aarnav JP
 <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 3/5] common/cnxk: fix null callback deref in CPT IRQ
Date: Mon, 2 Nov 2026 17:51:51 +0530
Message-ID: <20261102122154.2611710-3-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102122154.2611710-1-ajp@marvell.com>
References: <20261102122154.2611710-1-ajp@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX7rYPWIdezYkO
 9B6uIqgNiQJSSLp53fQyQcU3lT6Tv0gPhEMQ4AuJM50zmKkg21xgYfGSp5DJrMAYklDQGzqAHvw
 ypWsqHyagVm7h6UXgE/Vl+xnvZfhSLl8M9cUwzMmbD2qFYF0Jj+RHuM+f5YNIgZPf6PYISxtpSJ
 O5hsddk4WKAOLTqgPrw4RxrTbWfjpDH4RzNPmIU92yeOQ59Pr4ld3KWaF+CcHTC6zeptirnbVe5
 ZsGFpqLtSLdSzXrjKUZZ9uu4BPZf57oo+o245aNb9eTUt/XwctZ8BK2oPBPtXBpfPQmd5TROqWA
 iEZmj+LFTZv8IqoZquffKkbjmz03IcE+U/251FX52XCqemTVX7gmWxAH0+gp4CGfgSFKWMALP/R
 +FPXDhXE0KofU/XaePiPm8PA97YEO32VAAkWue0vzL/fdVjQnycLzqN4Z2t8cMSntJJEgjPY5Yn
 zqIP0o5/qfmGWIA2mrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX0Co+lx9eI56Y
 oIEg5zVavzlCATeieUo4FlgvM//W1wTD8kqReJl5DGMeGydncB2BG9jek2eQ2NF3+5xMxvXYoen
 bMnVdapNvp7LkZU5tLPSpFB7WSmj9Y4=
X-Proofpoint-GUID: TwVU7OYKJ5JLiinn5crf7_85IwQj0LPZ
X-Authority-Analysis: v=2.4 cv=bszZl0ai c=1 sm=1 tr=0 ts=6ae8808a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=eH_QsFHi88tnT3YjQ34A:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: TwVU7OYKJ5JLiinn5crf7_85IwQj0LPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
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

nix_inl_cpt_cq_cb() dispatched through inl_dev->work_cb() without a NULL
check, unlike the SSO sibling path. A CPT completion processed before the
callback is registered or after it is cleared caused a NULL
function-pointer call on the interrupt thread, crashing the PMD.

Snapshot the callback once and skip dispatch when it is NULL; the entries
are still drained and the interrupt acknowledged, so the queue does not
stall.

Fixes: a7d64a7740e0 ("net/cnxk: handle soft expiry")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev_irq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev_irq.c b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
index 977b5e05e2..82f8c5edfb 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev_irq.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
@@ -50,6 +50,7 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 {
 	struct idev_cfg *idev = idev_get_cfg();
 	struct nix_inl_dev *inl_dev = NULL;
+	roc_nix_inl_sso_work_cb_t work_cb;
 	enum nix_inl_event_type cq_type;
 	uint32_t port_id = UINT32_MAX;
 	union cpt_lf_cq_base cq_base;
@@ -102,6 +103,9 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 		port_id = roc_nix->port_id;
 	}
 
+	/* Snapshot once so the test and the call use the same pointer */
+	work_cb = inl_dev->work_cb;
+
 	for (i = 0; i < count; i++) {
 		cq_s = (struct cpt_cq_s *)(uintptr_t)((((uint64_t)cq_base.s.addr << 7)) +
 						      (head << 5));
@@ -129,7 +133,8 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 				goto done;
 			}
 			gw[1] = (uint64_t)(uintptr_t)wqe;
-			inl_dev->work_cb(gw, sa, cq_type, (void *)cq_s, port_id);
+			if (work_cb)
+				work_cb(gw, sa, cq_type, (void *)cq_s, port_id);
 		}
 done:
 		head = (head + 1) % lf->cq_size;
-- 
2.43.0

