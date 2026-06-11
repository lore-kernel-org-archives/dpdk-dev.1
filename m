Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D07CD98CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27AB542F63;
	Thu, 11 Jun 2026 16:21:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BF335427CE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:21:23 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXVk62190486 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 g1kLfzoBPDW4O3LPWKfZggrK5Nfmo41GQh2ftPliZk=; b=eYZWXfdwjH6BZd6rt
 Nkc5yrhFM2hrhNbNZfC+oD/QaGBNDTAWunulLdkv/2vgQkCb7lqk3FbWwxUH70Le
 CW2QGsh6KwZIhv7AZOJS6qIUfSRILYVr8rsGgmMKt4SGIcb6BB7jRCZj5whKQJOi
 g0hSaJYUbbEnHW274hL3TB+hwtwbglQKeQS4wot6Oc+yuy4AzIRASG+ikI3GRY/Y
 sSwRmsvbpO/C3T1FCR+4YZIJwkt1dN6wQRNWOmo5LkUHiwbddSY22JxnmUrOKe2O
 BINk0r3EpQfE4mvO3UPgipxKpIg4Tk8VEmtTau4W7KVwZXE6HLHFasXyoPMiezIs
 0sj4A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5rb7vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:21:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:21:22 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 5EB515B6974;
 Thu, 11 Jun 2026 07:21:19 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 08/22] net/cnxk: update inbound SA pkind for skip size
Date: Thu, 11 Jun 2026 19:50:15 +0530
Message-ID: <20260611142029.3351415-8-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2ac463 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=u9dVf1uGL-Be0CbOw4sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 71XR-TiLman5K7QYTqfEiMBoLST1j6-I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX9Gm8PqNxgmsE
 uO+qFScRZGla8yysGGH67Y4LT9uXQeYwbftKSI22RYlWFT3lT7UgB3Odc2mJyFnAThza48G0+Pt
 johWye9Us29x8O5afKwHUMzbPXcHkEA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfXyxYj1781KgTV
 ERv2RSwYYG3MLoCFJpYP720UimNjRMuzlUqN5jyTtX4nHk2P582bdKHSWCDkXwrdQdzk2Y9SphV
 X1BOAEOZH94z3as5mLoBPIxVwhtvY3RSKG7QhJuFgz7S005onAyZJGeMEtFYNiqciUav7JdQkkj
 9KSt34qiRFCHXypAr+a6B4qHGuBOB/4Iboqns+DTcSmptiADF89AHMJbvHgH7E3s0i6KzMC6YXg
 04QbKuzu9OKnEtttcodgncWUdAOEzY39sn16N8LGkNx9T1BQSxB/4R+/uQmOu0XuIhLtGjfefYe
 A8HGC8osHkrOpb3nGUcRNBWU3eBd2PmvimGw+MlDwwpg1cY5dXUbFoC6ippmeSr3HMBZ6Oerxv2
 5HeJA8to82f7wdI9+MUyf9Rczrc98P9b54r6zjI4r13c5gGy+txdrCFpfgY6tfX1G0uZjEtkRwA
 9V0VHa0IDhLBvD6KRmA==
X-Proofpoint-ORIG-GUID: 71XR-TiLman5K7QYTqfEiMBoLST1j6-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

