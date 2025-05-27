Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A167C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 04:01:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28A364066D;
	Tue, 27 May 2025 06:00:54 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A20BC40674
 for <dev@dpdk.org>; Tue, 27 May 2025 06:00:52 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNrBmE032052
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 z5dJdtGrBGqK2Ixppg5ySU8x5u3SOcEaX+80RaA534=; b=E5xjTQXiFNDVopkbq
 5pCa2F3F/D5wO9THhjOkS/H0qWTT4YIpGOIid1iMXgyeQx/gKVXcnvEeVgeBTs72
 F4xXaJMcYNDZGsqhWl2lFnTFxieOB2+TDxUW8rBZRyijV0xG6T3+Ehy/YaMGeljx
 WafGUurmpjdwTtn+qh0qllEFQmyKl2/B5AtK/vadmws1wDx5m3gdtzXe3ht+PAug
 bP2kdKr4FC5jN+xS464mskb09zKNzPbVwokHOt+GbsXy2ABchHO8vOiE4u/3FY3c
 Wv35SngP1YsThQhR7w2lD6ZO63mZXY6P+zf2m/5l/57yBUKS0+0i1kELi1fkRvmC
 35erA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w20e8bw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 21:00:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 21:00:50 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 360E13F707A;
 Mon, 26 May 2025 21:00:47 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Aakash Sasidharan <asasidharan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 4/6] crypto/cnxk: fail Rx inject configure if not supported
Date: Tue, 27 May 2025 09:30:34 +0530
Message-ID: <20250527040036.2280893-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527040036.2280893-1-ktejasree@marvell.com>
References: <20250527040036.2280893-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZmG0nXBLwY0TlHm-EzUXnp1X-0XLnVI-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDAyOSBTYWx0ZWRfX0hwN539BWPnB
 UUVJSagwG8rWOZ6pIHULtGOeZ/0weTfrgOQvvrq4+hgLzrIBWJcSrAg5g1h2jTRI2OWZ9TzkGHY
 cMAT0G1X71bDkmdreTeE1zJ1x/jF9Za6W8ZW/xq4pgDktVFlu1ouSurqHhhZBgGLICgKoefHaH5
 HOBe8nNv1r+xFZkYZkUw8GciOfnBoCMMVn9XQmJjx/jrDR6nnLmDKSworTeWQvdWmvSYdYhTECq
 6/y6cdpK8giGmIdQXNU23MioAd4a7atrwtAP9QH1zbK1uwgVnnGGqEgOQ9gdyyGNDPlefocCel9
 aj7qE3W9PblRKJhltgVlSxfIR2bdonFp/XfwBAGbLZ3cxmhrWtbSmn3PH8VI1dsi8osqvMV+q3/
 bPKRFeaoLgePA7zX/U9qmazjZxnaGXMJTxRKvhiTQiidnpXNZfH+UjBbRmn7oSVv2cXMei4c
X-Proofpoint-ORIG-GUID: ZmG0nXBLwY0TlHm-EzUXnp1X-0XLnVI-
X-Authority-Analysis: v=2.4 cv=G5ccE8k5 c=1 sm=1 tr=0 ts=683538f3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ybEC1PMvOLKgKtgHzEMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_02,2025-05-26_02,2025-03-28_01
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

From: Aakash Sasidharan <asasidharan@marvell.com>

Rx inject is supported only with CPT05 microcode version.
sg_ver2 indicates if CPT05 is loaded. Fail the rx inject
configuration with ENOTSUP error if sg_ver2 is not supported.

Signed-off-by: Aakash Sasidharan <asasidharan@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 851e6f0a88..947f50b4c8 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -1981,6 +1981,7 @@ cn10k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool ena
 {
 	struct rte_cryptodev *crypto_dev = device;
 	struct rte_eth_dev *eth_dev;
+	struct cnxk_cpt_vf *vf;
 	int ret;
 
 	if (!rte_eth_dev_is_valid_port(port_id))
@@ -1989,6 +1990,11 @@ cn10k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool ena
 	if (!(crypto_dev->feature_flags & RTE_CRYPTODEV_FF_SECURITY_RX_INJECT))
 		return -ENOTSUP;
 
+	/* Rx Inject is supported only with CPT05. sg_ver2 indicates that CPT05 is loaded */
+	vf = crypto_dev->data->dev_private;
+	if (!(vf->cpt.hw_caps[CPT_ENG_TYPE_SE].sg_ver2 && vf->cpt.hw_caps[CPT_ENG_TYPE_IE].sg_ver2))
+		return -ENOTSUP;
+
 	eth_dev = &rte_eth_devices[port_id];
 
 	ret = strncmp(eth_dev->device->driver->name, "net_cn10k", 8);
-- 
2.25.1

