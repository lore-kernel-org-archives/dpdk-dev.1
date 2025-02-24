Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801ABC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 10:35:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C30C54066E;
	Mon, 24 Feb 2025 11:35:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 12BE7402A4;
 Mon, 24 Feb 2025 11:35:23 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O8UbdJ015288;
 Mon, 24 Feb 2025 02:35:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 IM4A7SSgEO6UkQnjLLFeT41E8OdjrvKGiSW5U2bMjQ=; b=JD/rBAo86r5e34qja
 I7lnJnn/106gfAQEASy5xSHEPZRp97B5DbpeF7xRtQDSRC2nTzl4lfLpPPysrMcr
 Oj6lBs5R5i4P8/h8BVxd8Ruq35HL1CyRA/WhKxkVOozwwY2dkDzmcvAuCBgoonsI
 hQwOWEBJVw25v/1iUhlaH2Af43RCgyAEx2oFm8oj9wZDUWpllWNeCr1O32DWCYxy
 3sdn2EFaURFMB230Sxp4WJn8D85MBVo5jrQG4REJaPDcCEWvESXk6u5cD0jmRCz4
 TyP1Bu7fzyxtNL+hTWltzYOuF+nNXYW25yGJhtKi1eM7FwmFe6XDijOJqFiDwn8p
 tYMBg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450nasg8hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 02:35:23 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 02:35:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 02:35:21 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.21.204])
 by maili.marvell.com (Postfix) with ESMTP id 36A6B3F705D;
 Mon, 24 Feb 2025 02:35:18 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v5 1/5] vhost: skip crypto op fetch before vring init
Date: Mon, 24 Feb 2025 16:05:03 +0530
Message-ID: <c1aa7cdd5e1d58a6f484fcd45bbbe0f115c7b521.1740390893.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740390893.git.gmuthukrishn@marvell.com>
References: <cover.1740390893.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7UTFojlEG-ZOZN0xP_1CG4pvhOvK99WS
X-Proofpoint-GUID: 7UTFojlEG-ZOZN0xP_1CG4pvhOvK99WS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

Until virtio avail ring is initialized (by VHOST_USER_SET_VRING_ADDR),
worker thread should not try to fetch crypto op, which would lead to
memory fault.

Fixes: 939066d96563 ("vhost/crypto: add public function implementation")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
---
 lib/vhost/vhost_crypto.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 3dc41a3bd5..55ea24710e 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1580,6 +1580,16 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 
 	vq = dev->virtqueue[qid];
 
+	if (unlikely(vq == NULL)) {
+		VC_LOG_ERR("Invalid virtqueue %u", qid);
+		return 0;
+	}
+
+	if (unlikely(vq->avail == NULL)) {
+		VC_LOG_DBG("Virtqueue ring not yet initialized %u", qid);
+		return 0;
+	}
+
 	avail_idx = *((volatile uint16_t *)&vq->avail->idx);
 	start_idx = vq->last_used_idx;
 	count = avail_idx - start_idx;
-- 
2.25.1

