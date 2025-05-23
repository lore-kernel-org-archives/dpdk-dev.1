Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8C2C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 748AC40C35;
	Fri, 23 May 2025 15:52:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 98B0C40B8F
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:19 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8Rt006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 z5dJdtGrBGqK2Ixppg5ySU8x5u3SOcEaX+80RaA534=; b=ViLW8unlTQSl3Il+6
 a6yHSfjmsiSun+1N9t3DAmEgo6AJRIWAHbP0aewLrrJldySfumm3Q3kNyGDlcEiO
 bduaI8rUrzttOwFJ/es2AWFRQovPeD2mM0Gn38RCECg7eWcBeTCfCopVEmAP6XZx
 mvwj2pwOzwKU29wBj2AXeCClVeE5x/dit0a5LPSFQMUhFOlXycQtb47bpqF/imJB
 B9lmrEnPp73NO1SwiZNzP3cA2VD4o7V50yeaq8/cuI498ssQmdW4LZcILooUjMdi
 ftTKTXllUdOdpocCQ6UXrVueze2y0iOAOJPyocqiAXWF14AQGGM/uWYLL9VxyOvJ
 o0a5g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:28 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 82C563F707B;
 Fri, 23 May 2025 06:51:25 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Aakash Sasidharan <asasidharan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 04/40] crypto/cnxk: fail Rx inject configure if not supported
Date: Fri, 23 May 2025 19:20:35 +0530
Message-ID: <20250523135111.2178408-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX34QlYqLgIQ6M
 llUBAujtCKGtpaIivramxUnDc+UIvhTq1uuAWKrzsyFtUtjls+hcqIzQMZD3kes1LFO8B1dwW0T
 xQx+1Kit6y9Sp3952NgIYH26iF/ya8mGDN4qqk2JuOtxeetgXwaE19oh6w8mSzo62ImNxnTpTRV
 bTFNL+vJ9efQOVhKdKYHI/o8k/rtqck3guXtACMS3g6wSBG8UTaeGBuisWDdwC2USmqKrL1suvu
 jOlzpwcdi+QK+H8Mcn1zQ2vXqb09kq0MbfSTXnovT1TQBcU9QU9ZJNunvDiWiLOBy8BesVNHMbU
 kDLobyoII7nooqJpiFxoLcGGS7tW/yt3PpM/A8P2jjtPSEnWD50wSh58J/1JBcdxQh4f4D4MnIw
 7pwe8MJChsNSeNBo5EYO1DL/CNAWWmrAL9kHHOg215gEVxSyeuLbYWfQN+GEUm6SJCK2pS2C
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d92 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ybEC1PMvOLKgKtgHzEMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: _TSN5TWa6woyR-u4UOoYU8ykWqh0JClH
X-Proofpoint-ORIG-GUID: _TSN5TWa6woyR-u4UOoYU8ykWqh0JClH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

