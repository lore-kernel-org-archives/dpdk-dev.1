Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A34CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4294942ED7;
	Thu, 11 Jun 2026 09:33:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0EBA440288
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:33:49 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0Qle2856226 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 nFBn8ylNX0aOVwxxkQn1J5qjcWdshpn5JMJ3rUzpN4=; b=GlJx810hv5lE9ksWg
 ULLUbwTND9kUxhR8eW+1ieYnZwnB+tEribfUp7mMk+IDhi670e6PkKkumV3UOzy3
 qN0/xOGywsgQ/B2wLDJBYHtckd2532szzqMqbwCJz7Hja4R1xPjAG72CtjdKm+qi
 vQxasDa84YWWdr1imVulUEGtFAflnaAUDc1B8O3ulLsjBZYxoPib0wmHOPhKF56D
 738s24aeMl6UufXTf43Ko8diqPcxx2vgdfGlz8WXrwpUWB4CPldnsnYZIEpCN41I
 wBoOXhTJKkIE07Gd/8ZgQamQ+Xyx0v8GzSdsEs6vnKKpyk7kx0PX9jk7VawSDG16
 92tFQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r9y7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:33:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:33:48 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 7B6D85B6973;
 Thu, 11 Jun 2026 00:33:45 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 05/17] common/cnxk: configure LSO mask for single segments
Date: Thu, 11 Jun 2026 13:02:59 +0530
Message-ID: <20260611073311.3129711-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2a64dd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=HkXQYvCU1nhRFysMGnkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ckvu9zhtbvf3kWey7W91bZCCaSgIpAPJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfXwkcUKx3AC6A5
 me7mbH5hQl8F/I5d8hSEYpbyamCqBflOr69EclLJ32VgrqDeBKXkABnC20/5wFnUdJ5lb+xf06M
 N7TWyKrA5UVw0l824KBOgFSiACLiWOE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX+//lwROj/JEx
 vpfd/boPF8/j9cPrqdb9zhJ90si3ri8+7QEmMMJH0k/wQK1N4HGDrkXDhhqvWuxpaH8PRTGl+ps
 KJz6cZpXEo/9FoPaESqd3mpm2RFuAQpJs5K7CoqPomAJILnID6z9rXT3/Pd1z2wI1vYJA5lwtVF
 UrMNUVzVMIeJyzoZaCQRq0tOZwhfSG9bNg2S/7P/HYFLsjtzUO8UbsV1H2v1tr5mIVPhlLvHTgU
 YskY0JhBCsdNxushOZbMbK8OwIbRELE04Qw1fWqeH/kG4Qosme9CNYLUPhZCsMTD/4mqJ+dTyFp
 +188+YF+FC76Js1WPxTvodJqOIHcLpz2WgXgaoeD4uq77ckpdleTDuFQPod4q4ZbW7YrIr41HGt
 pQ6ets+D9CHeOMzF36qXjyACmy7GP4ncpEcRkEKNrO+WUB+h/+vs6aum51xtONucAAAt1bttAkY
 h0q+m7BfRJPfWvfxEaw==
X-Proofpoint-ORIG-GUID: Ckvu9zhtbvf3kWey7W91bZCCaSgIpAPJ
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

Configures LSO flag mask for single packets.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index 12a12c6e35..4653bb2049 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -239,6 +239,8 @@ nix_lso_ipv4(struct roc_nix *roc_nix)
 
 	/* First get flags profile to update v4 flags */
 	memset(&alt_flags, 0, sizeof(alt_flags));
+	alt_flags.s.alt_ssf_set = 0;
+	alt_flags.s.alt_ssf_mask = 0xFFFF;
 	alt_flags.s.alt_fsf_set = 0x2000;
 	alt_flags.s.alt_fsf_mask = 0x5FFF;
 	alt_flags.s.alt_msf_set = 0x2000;
-- 
2.34.1

