Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C504CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C60242EFB;
	Thu, 11 Jun 2026 09:34:19 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B322542EF8
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:34:17 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0STZD1256951 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:34:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 5wdjB65PFyTr87hMVqyb50fYh2hiY9KvYMc44rnlLI=; b=JY5scZ1xQP09PRpt4
 3JrzRjPikODVM/VV2w8et9evBZtL4nDlB3o/UhAeEQmX2k+FtU/YHQUOBXAMUq4Y
 bXkcYqunVgxe0fjY5oNLQLUMbGKDilitxkPS34WHT2CSj1XsAC63zlD2K62dl5qa
 sEQlQakCPqYQ/86jsbUgfGrMVpT2udfXEyKXi3OJI7TXUUJ0Hn8SpkdnZB+mQaay
 iueZRO9h1du5NcNoIdkS27zYX0OYJ8e+ALXCmAw7zYEJBrHVv5FHIzQ1FWC4szdp
 MQ86WxQ4xK60moUOJinlh/lkEmp+FqjoWY7/ShIAiYJ77BJEoAZuIu5FovQg4UPt
 WbMlw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vswv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:34:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:34:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:34:15 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 9B4665B6973;
 Thu, 11 Jun 2026 00:34:12 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH 11/17] net/cnxk: enable CPT CQ by default for inline IPsec
Date: Thu, 11 Jun 2026 13:03:05 +0530
Message-ID: <20260611073311.3129711-11-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfXynDDjqeIlPd8
 xjTotMNpxG5Q6bNsDVSTM786LX30tkJydMf8z4AATy0kdZhFHMR96e29rBE0HXGz1x7ny+fKCkV
 WkyRvkK6fFENzG7uUpHr6h03gmVfUdY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX5x7+IuAAErGQ
 YC5xS1stVV+gmuEpxIMqKfjKv7+eHIJC7vrNuMdEyRcLu7IkVH3Dw5+OOVvTUE4ALcmv6cbVMI5
 ftuIw+32CGkWlEuQ2TJGLICDyU8irh/POHkW514SuVMfSDGqZmgoBsnqPOX6WEw1GbslycNF/0v
 shhG+xyoFRFwmMOgjG+FOW7jXzLSziRT9tCAuDkPVZjdSzFYLX4kngwnFLfjqYhbqFKpYG11utL
 I0Bcy8F/C48F0BnSTv5rtwz8jpD67B53eOTivEljfbnDuppJB/WaT87TOtd+xEGLK/zje0zevOT
 ZxGooM79wPwJOYSC78wR1xxD2VBlf5c8Gg/dvVti2xi3Vj6Uak3eur/I4h6rpgZF+VR0sBHhcas
 KJAM4Bt8hi+VsGkvN2UEnc1va4JGZUh1Ccf86GIXor+WeXD1a64rMp7x82aBP6Y7YMYV72u2guv
 1qcU3ZyPFsoQ5ip+nzQ==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2a64f8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=ZZU3Wc5vmQXhhph13kQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8sYHeYqhYICgMC8YlHqGyx1xj5CgRMJ4
X-Proofpoint-GUID: 8sYHeYqhYICgMC8YlHqGyx1xj5CgRMJ4
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

From: Aarnav JP <ajp@marvell.com>

CPT Completion Queue is supported on CN20K and provides
hardware-based completion notification, eliminating the
need for software polling. Change the default value of
cpt_cq_enable devarg from 0 to 1 so that CPT CQ is
enabled by default.

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 doc/guides/nics/cnxk.rst           | 13 +++++++++++++
 drivers/net/cnxk/cnxk_ethdev_sec.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 239ebcd05c..c71029e1dc 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -745,6 +745,19 @@ Runtime Config Options for inline device
    With the above configuration, inline inbound IPsec post-processing
    should be done by the application.
 
+- ``Enable CPT Completion Queue for inline IPsec`` (default ``1`` for CN20K, ``0`` otherwise)
+
+   CPT Completion Queue for inline IPsec event delivery can be enabled or disabled
+   by ``cpt_cq_enable`` devargs parameter.
+   This option is supported on OCTEON CN20K SoC family.
+
+   For example::
+
+      -a 0002:1d:00.0,cpt_cq_enable=1
+
+   With the above configuration, driver would enable CPT completion queue
+   for inline IPsec event delivery instead of using the err-ring poll thread.
+
 Port Representors
 -----------------
 
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index fa7eacfbe4..61eb55ba43 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -742,7 +742,7 @@ nix_inl_parse_devargs(struct rte_devargs *devargs,
 	uint32_t meta_buf_sz = 0;
 	uint8_t rx_inj_ena = 0;
 	uint8_t selftest = 0;
-	uint8_t cpt_cq_enable = 0;
+	uint8_t cpt_cq_enable = roc_feature_nix_has_cpt_cq_support() ? 1 : 0;
 
 	memset(&cpt_channel, 0, sizeof(cpt_channel));
 
-- 
2.34.1

