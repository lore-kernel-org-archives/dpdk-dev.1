Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064FBC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 16:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 431A64067A;
	Mon, 26 May 2025 18:58:40 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7D3FD40668
 for <dev@dpdk.org>; Mon, 26 May 2025 18:58:38 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QBOEQk015289
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 z5dJdtGrBGqK2Ixppg5ySU8x5u3SOcEaX+80RaA534=; b=B4VSf4mEBw7EaxaCi
 Uzmhr0q33Lx6g1JbClMOIMWhPYiTX8kFhQC2vacpKo4dracgl5iba9dz/Gx/rPM0
 t2jLpBu1C+iUNlKwYoF1nvcbk0tr1ycYdj9WZMc1GlASXujTsSImE1BOFBUz8uQn
 sBttoZRoodOHhwD5GvEr4/L2nQS57mlorUFgRrFd+p7ZZI1Ff7zvXQwx7Iw6nUEP
 tZ5XRjG20uEO5sN47yVL8DwIWn57AamCk7Fu8llUXPLXQviHvHU5VDjBzbQrD6GF
 wYnb8l19ZTU1ByhzXJJ3Cb3/VevpG6+SgwPJAP6KkX85kN2RA8DdoCjw1ic0lF+4
 8us1A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vp9krp95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:58:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:58:36 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 29ACF3F7063;
 Mon, 26 May 2025 09:58:33 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Aakash Sasidharan <asasidharan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 04/40] crypto/cnxk: fail Rx inject configure if not
 supported
Date: Mon, 26 May 2025 22:27:43 +0530
Message-ID: <20250526165819.2197892-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VYn3PEp9 c=1 sm=1 tr=0 ts=68349dbd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ybEC1PMvOLKgKtgHzEMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfXyY2f/AeBllj+
 wounJLE/4S7mK/zWr+BOkv4GRGVC5nwJmPaUfqg+1hgx+taUDnzTOKQx8nXkCxA5vP/j+rgSae7
 t8vbG2Dbke5bpYtl0eP6jBB/N/52dfQzBEisMpC+o8URFllk+9JYbymVqk4FfVMkgcHn3hRlaN2
 yF0fh9PMOMth42XAgWbemc/8y9cRv8AuXb3Jk9UBibfnSikEYPXac1gS5dCE2XZcNWQVvtPCfqt
 xGTWEWmd4zJWLOnCRoyROzO8nuEzU/Xp+CjYYc+JqueSf2BeX6zqAYeWRgdrVrQvRjO/f19vTT3
 PUspd9RwC8B0nhfVARVHM2DDfuV2PblS2Zo6LIG18ZCSTAAETOQufTq/xzjgXAQ9fq9EghvFkjm
 7SvPXM/20ikIJ11BDzBSegl1lT7TOvULr3WDUKU+edfQ0b+oeqa4BCwoIsaL0EFnRe3vpZFQ
X-Proofpoint-ORIG-GUID: uT8YS8Q15pKtE2var33vD3T4BxHhTKEz
X-Proofpoint-GUID: uT8YS8Q15pKtE2var33vD3T4BxHhTKEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

