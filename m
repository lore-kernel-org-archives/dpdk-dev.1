Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED6BCD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1011E40673;
	Mon, 15 Jun 2026 18:26:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E547440663
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:24 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbZZF1123717 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
 v9iQG/IDZY4wDhM71XFSDkDSLSZS8XnLv2c3t6/58Q=; b=bUbKB7RtpDrDh8crR
 t79BDiOlneuA2V/ZFtkKnp8im+bAu1u1ypNcLprDJDwDy99oo4DaN+yq9rewoObC
 KIsbFVwxPW0LqyumDAWE7k0a4UhfSQmaCibMYaZky5BJ0HVHI9u3PvGWtgPA2nHf
 4rJYlVZQRrmmAeVnFR4h15QFFfjOZmi2zjUMtg8/vfdkcPBo1WPMlFlcAv8m+kgT
 CHzFUuX6yQdXORQAg6ZcnlSqnUjoRRn/be9CdaZaRJnQXSrToyqPKiq+fRc5jDGG
 sp1in+PJt5+bz303sjg4JF40FgAfUf2ERfab75xviQ6tyfk5n1vrMeplwXqr+gwy
 Uyi8w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jk0632-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:22 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 41B373F7065;
 Mon, 15 Jun 2026 09:26:19 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH v3 06/20] net/cnxk: reserve memory for lookup mem at probe
Date: Mon, 15 Jun 2026 21:54:32 +0530
Message-ID: <20260615162446.578336-6-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Vs5sdukWKZGib-vDyuwV16O_cBdXuwcx
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a3027af cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=tSCCWPZjXUxveK0l6ZoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX7g2lLivzMq25
 2TOVGMmdNPQnZm2RASFxsQBw60kKdnU3ayjZujBkq7POZbdwiFSCc8J+7K6fHMqRKO7tXjUCyN9
 KHXK409ydmDK9wBl8TV1ngmvxV0EaVA=
X-Proofpoint-GUID: Vs5sdukWKZGib-vDyuwV16O_cBdXuwcx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX+nCz9OZkuc6u
 0AHXvdmwHb7ZjluIlyjKCL9sV3sagURtH7UkrH9IHsfORYA5V+GTpkJlOuhLvb0UJd6oX58QeaM
 9/02hn5o/7ULaQvQ/vNgu8A7nOwOY8Jyo1880Th48jwaDRLrlFU+5DDGew+teUKgWWmGizK6TtV
 x4mGWF1eThbBFWP+ihtuYfVgqyxkI+WjprLl6XBgDYhOYF7KjWzRz59M/EhEdvkjsVKDkzwvct0
 MU/oLobO9YSnaMXvuTr1nBVGsfYZ/fOddEyFS0OV8pi00uEhmslwdkfYL9ho4iakwoeizOXyPv6
 iDXppMQQLUfvCy549FEW6mpTpyuiI+dfHQ1B9xOIyD+tJZVhXiI+EOUogsd0l9V1WsrJDlDKFaC
 hnwcE8ciHybpsxvhy1zvPs97pyK8XUyeenwl6Ok0eDraXT+yvlQV8ZkBt6VlQNhDwkhDb7atmbA
 MBeD2aQ+8TBlYYQexJA==
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

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Reserve memory for lookup mem at probe that is global for
all cnxk ethdev devices to avoid race at later stage.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
Changes in v3: Addressed review comments from Stephen Hemminger.
Changes in v2: No change.

 drivers/net/cnxk/cnxk_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 06d1c9b362..edd9f09c4f 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -2220,6 +2220,13 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
 	/* Register callback for inline meta pool create 1:N pool:aura */
 	roc_nix_inl_custom_meta_pool_cb_register(cnxk_nix_inl_custom_meta_pool_cb);

+	/* Reserve memory for lookup_memory */
+	if (!cnxk_nix_fastpath_lookup_mem_get()) {
+		plt_err("Failed to reserve lookup memory");
+		rc = -ENOMEM;
+		goto dev_fini;
+	}
+
 	dev->eth_dev = eth_dev;
 	dev->configured = 0;
 	dev->ptype_disable = 0;
--
2.34.1

