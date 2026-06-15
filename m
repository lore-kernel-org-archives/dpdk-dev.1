Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A294ECD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEBFD4066A;
	Mon, 15 Jun 2026 18:26:51 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8D413400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:50 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbJUP279785 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 856wXGNOBsoVAmSBxOxTurFRmWAJ6+p9pcZulwxfn4=; b=hWFCUsJeXkIQg5Vhs
 Belkz9wu7JvpZWhjvvjJsbTZqJYJh2Ey9oEJkW8FZY6LhwnPXorWgq/me0yjpZu9
 4WVxWfr6ZvapRYGeEtMhOn5j7z/p7Di0hblgttTrj9Nch791RFgz+M6/vyrbCS9O
 CQGX4rcAz+IdMGKoz/ROVc4LYMxdHVbcsiJQEX+UBZSftO//jDwQqmTamj8BOciU
 z+uElrgbkVLfB/pIGnA5WKsLu6EZDtMmlhc5ceWQiIFgadk9dUyosPA+18fkGewV
 43/1c4dcpN6EtWRyCiWX1a8VUHyFqpum0Vmwui4SBRZP/hiiDLRYDHUceoeNHetm
 JWDdg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4esuf8vpnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:48 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 7043F3F7063;
 Mon, 15 Jun 2026 09:26:45 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v3 11/20] net/cnxk: enable CPT CQ by default for inline IPsec
Date: Mon, 15 Jun 2026 21:54:37 +0530
Message-ID: <20260615162446.578336-11-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX6umQXA4Lk/ID
 gc7Wg3Jpf0F1pb/NgSAkxgNbdzY7c8xf2t5BE5NH8O8tkzq9BFpO/nsm2ykBqxLjcsZsDQbV5jq
 ti1r2+MP8y2xi6UTpRYQILL03n1jX4QGw/70Xoxc0rDjwOa7Z4Dr9xV/CPF7DFvAGSpYaFuSjDc
 siAeDWUbQcagrI7cgw9UoYxm7mtriFMdZ7uPU8Yxx5Getv7R5ZlsvIdDBwY+bn2H2l0+/p3eV2n
 Z08qPz2EZY4aq8DKymrKTetiLXcxn2dBbfYz+9OgvLh43kWgk+qEatUhRMQzZhK1xKb0FKc77GP
 vhEBSNmqmouQtuvrkJu1RkpO4nKKBmhYVHyY9fBt/brOR7FxqFzUX7EzAjMYmcnBg6L4YgWp66t
 LHJFQDKIzqRvLYLg6URpOEPanoqrhFp9IoA3iOrEzcFxeRcrp5Yxz6bbiYxjaHeDuseywAbIWra
 nxurTnCe1lbfAHMgxVQ==
X-Proofpoint-ORIG-GUID: aACCdhVnIlKFqG2Rc5gIMCYTSfJsOk-8
X-Proofpoint-GUID: aACCdhVnIlKFqG2Rc5gIMCYTSfJsOk-8
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a3027c9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=ZZU3Wc5vmQXhhph13kQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX1LQWc9NiouTi
 ke7uQjXbW+er9Yxv/UXIHUE92Z422xGNCqqUDpmHrxv1uNCCvYF88Mp5f5lO87+enN00eGFURX4
 ij/2KOnsgHznsZdn5eYj/nwiYxK8i6c=
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

CPT Completion Queue is supported on CN20K and provides
hardware-based completion notification, eliminating the
need for software polling. Change the default value of
cpt_cq_enable devarg from 0 to 1 so that CPT CQ is
enabled by default.

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

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

