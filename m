Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49BDCD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 077E040676;
	Mon, 15 Jun 2026 18:26:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 31E08406B4
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:35 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFc6NP1125356 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 24WUGwgI9x5QlCR4101YnOOnadJxZ+7I9inL+8e4wo=; b=TmYpl16EMSsnVGZGZ
 Z5CBDrAaTu2mrifO9ZaCo04ZR57kDRvIRHMbytGb3R/CMKMd8DaRyuOSnCir9Waw
 E+L8t2j80z1ILq3Wi9gF3wRS+pHlrzeTFILFoyEs/1wqyfUclLDV8FlB5uowz5oO
 vSZjBeRJ21cOtmDKA5OWh/jhNmsJmnH+Moiol/KWe4S3uPDYHzjwXKKQGwJ/U5rP
 wWQqZuoPGcupqbMg70A1s03yEC3EKn8zjnrOckRK66DlFL8aNUmMMXlk6J6uK6sW
 qp4qKDOlbBiKObl0FOaykllYe15vmuxJwI1fkN+ILU3a5faboNq6Xer8vxXzpEJT
 40V8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jk0643-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:33 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 229623F7063;
 Mon, 15 Jun 2026 09:26:29 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v3 08/20] net/cnxk: update inbound SA pkind for skip size
Date: Mon, 15 Jun 2026 21:54:34 +0530
Message-ID: <20260615162446.578336-8-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SB8zwPdWukxS4AkzNk0KNvyqJQhOfAbX
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a3027ba cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=u9dVf1uGL-Be0CbOw4sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX4jhv8V8kOyMt
 EY0jQwwAugJ6yMSZtslx8ww2e8DmlS/JNjPPXYOl4PEJQ37v6JSNuud+XGN/Cgn7Xtv5N2UgKjv
 pjq0Uyo12aciJ8Zv1bgTwQ3oR5x8hUk=
X-Proofpoint-GUID: SB8zwPdWukxS4AkzNk0KNvyqJQhOfAbX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfXyr9xWA+6/kut
 03CXQ3TsmqWq2yt8tvaysPTsWAM8RQCjLB3fbhE3c/9BHaSDX55YOkFnGEno5TjbAILfTxkTOMc
 VxhCdqlC/KrWgOTD/QzwzzPSIc5XnROyrLrFmKgm6K74lDKPR92OF68bHzzLv3C8oFWIvy0/Zh9
 7WI5IAErUTZQPtN2tXJDEbpBqSg13Zetly/SvUfdRCB3uZyRZcBwvmIOWhDORTqjvcetSje9IK8
 nCUWx1fO/EGSUjBwsoZ/1llk6blfFT1yWp0foYlLfv+jb3SwFM55Ukq0oAtcZ9GgH/ENkLBr+Bl
 hXbaHp6wr3nJ8ndi1PlOe9p9/meoL8i1weT/AnTGWtHEpgnmJRhsTS98E8X/qu6eXdsrqPfKhJu
 W6V3lONWOvMoUP8tZ6uvjqF4KSGMwqkEXUZVj+NdlymPLe/7PF4ortDgmANK7Ft0sp0aBS2UM0f
 p1S5GVHN8MngnJ+wF+g==
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Update the inbound SA pkind using roc_npc_skip_size_pkind_get()
during session create and session update for both CN10K and CN20K.
This ensures the CPT second pass uses the correct pkind when
skip size is configured, retaining the default pkind otherwise.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/net/cnxk/cn10k_ethdev_sec.c | 9 +++++++++
 drivers/net/cnxk/cn20k_ethdev_sec.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 855bea1796..2f1fdf34fc 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -853,6 +853,10 @@ cn10k_eth_sec_session_create(void *device,
 			goto err;
 		}

+		rc = roc_npc_skip_size_pkind_get(&dev->npc);
+		if (rc >= 0)
+			inb_sa_dptr->w0.s.pkind = rc;
+
 		inb_priv = roc_nix_inl_ot_ipsec_inb_sa_sw_rsvd(inb_sa);
 		/* Back pointer to get eth_sec */
 		inb_priv->eth_sec = eth_sec;
@@ -1151,6 +1155,11 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto, 0);
 		if (rc)
 			goto err;
+
+		rc = roc_npc_skip_size_pkind_get(&dev->npc);
+		if (rc >= 0)
+			inb_sa_dptr->w0.s.pkind = rc;
+
 		/* Use cookie for original data */
 		inb_sa_dptr->w1.s.cookie = inb_sa->w1.s.cookie;

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 5d0debb81d..31f2518ea3 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -865,6 +865,10 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 			goto err;
 		}

+		rc = roc_npc_skip_size_pkind_get(&dev->npc);
+		if (rc >= 0)
+			inb_sa_dptr->w0.s.pkind = rc;
+
 		cn20k_eth_sec_inb_sa_misc_fill(inb_sa_dptr, ipsec);

 		inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(inb_sa);
@@ -1137,6 +1141,10 @@ cn20k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		if (rc)
 			return -EINVAL;

+		rc = roc_npc_skip_size_pkind_get(&dev->npc);
+		if (rc >= 0)
+			inb_sa_dptr->w0.s.pkind = rc;
+
 		cn20k_eth_sec_inb_sa_misc_fill(inb_sa_dptr, ipsec);

 		/* Use cookie for original data */
--
2.34.1

