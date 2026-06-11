Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C707CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:34:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EF9442EF2;
	Thu, 11 Jun 2026 09:34:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9603642EF3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:34:02 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0QrcH856281 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
 Ag2b1WGN2Xzj7dkMZHMUw+3Js/XtwW5FIFB9WLz6Jk=; b=Yx8wAknb0HtOVuHuP
 weqF5wh2a9y7sfB1wfzdyq3H2PzBCc/Cbl6Mn+6iPL9Sv7uC0/U/xnRccyXLfyYa
 uBWYKzEZxqVJ/4dD5JhK0IeYsmy1HB4JSzfdCOZb+tCdv15+goCvjsnEJsbrrEgU
 pcxD7pe2UVrVgwU7P4Nbt8RqLENEab8qBIC2ltFktQ6/FdfRsh8kBegf45bo9+TG
 Na1hG29HDAwzeZdwpFW7dcOtPy9hcBDcufh5fZyC/XnwhffwlrHC0pbMzFq+tj0R
 yzdJMRXLzyCPTIXlZy2JxmsedPvVzQZmDs33MB7WwdyFaZS7WOpfe/NTAmIl/oYU
 2929w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r9y8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:34:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:34:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:34:01 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 71C065B6973;
 Thu, 11 Jun 2026 00:33:58 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 08/17] net/cnxk: update inbound SA pkind for skip size
Date: Thu, 11 Jun 2026 13:03:02 +0530
Message-ID: <20260611073311.3129711-8-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2a64e9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=u9dVf1uGL-Be0CbOw4sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: vMV9qPB-B8Tz2LatbQNk-r-CEJpIqyCa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX6Ouzo2zewFEu
 EOnIBBSGQOk6qny5pPMKbSXE8bG91lFfUrgj4XYFNZhRs/V32bOjnCE66Q2uA5kev9fwBY1/EBv
 ntUCM7Xiju5xUtMFfAanjhJ8vtzh1u8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfXxSVzx256qXs9
 YIxuDy+fbjqS5cHnQ6OkKEN24bX2rIIg2KRlttqFooXFKws5wqKbLjHIl/u3th4L8CLrBu6lPOs
 Stj7jIUYhHXjeP7wZWD8HWpWh5ul7zt7hL/raICH6jo5/xbquVQVgr7dGX0Zz+Cp6xyglzpjVOM
 +SuvGuH2BXZ/96qZTm3F0GU1gaZQLjS7ipvcIiJlaCjYtDnikhAv6f19Q2pTIAlhOg9txzUNG5Z
 Q7H91DqSDyPoAVA42Z8w3zRHPSVNBD5+oRJCOtZcbMfge+Wu/o0cyDSzpXWXef+Ujt1O9EkLKPg
 ke3Jwo2bHrsVWuWZ0LtOMlik954+rIQ2auGamU4CPXuAy0Gqxd+EOgS0MZm53zmLffQrZ/+s5Eg
 59kNsxPTF/Cdtd9/E7d1vXhsj7ZPpwYnktsYjbIVIThHBpg2pxsltdSJR+2xT2SNYdxXZOE/Qap
 55VxnOTn59xrCXBIzqQ==
X-Proofpoint-ORIG-GUID: vMV9qPB-B8Tz2LatbQNk-r-CEJpIqyCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

