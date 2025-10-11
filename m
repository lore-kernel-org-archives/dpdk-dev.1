Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB7CCCD183
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Oct 2025 04:33:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F219402CA;
	Sat, 11 Oct 2025 06:32:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1C5544003C;
 Sat, 11 Oct 2025 06:32:57 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59B3WA0N005017;
 Fri, 10 Oct 2025 21:32:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Kk0R+vTAUdAs9KXJJlyV3B3
 ghxbG0RMXLq3yISnb40U=; b=c4y9f2UVKpiUNThweiUnqN587o4v/LpIhVg+GSh
 l7qrVOjn15gkjQAzQz2ER94rj2jOi4zFGpD8sr8emKZhoKInOZpipXZj1fPLd7uv
 JLAIllW2NASbjLotIeFs5sjt1idZMwoKcjA9T1ufpD9N6NAUZEOLszLEZCO9Giqo
 Qie4A/8A0H2BhTgWp9uwKWBppAlfAbmbnFmMllDA9xBQyrJkdoyWk5AVzYajJvkz
 pu1c4r34yJv0u1BfxQU0+xrIdRVXhrAg+cqWHskCcxn0mR4toGFUZQAu62k3KT+U
 s12CFw4UHSB8mgQE8Fpamu9XJsiD5eptUv6VFkexfPBYytQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49qfdhg2rv-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 21:32:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 10 Oct 2025 21:33:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 10 Oct 2025 21:33:02 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.101])
 by maili.marvell.com (Postfix) with ESMTP id BFDEE3F7087;
 Fri, 10 Oct 2025 21:32:49 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v1] crypto/virtio: free memory used by op cookies
Date: Sat, 11 Oct 2025 10:02:34 +0530
Message-ID: <20251011043238.1508-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nUuMqFzqLBGSKqq0gDgZzdPzJxQaTW6m
X-Proofpoint-GUID: nUuMqFzqLBGSKqq0gDgZzdPzJxQaTW6m
X-Authority-Analysis: v=2.4 cv=F4Bat6hN c=1 sm=1 tr=0 ts=68e9ddf8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=WgGiPuiIi85xBtdyxAoA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6CRu4h/pPIG7
 uca8ZDF+AUYn6DN6KY0YQolZ/k7Im4NPhsMyHtV3VPs7lTiRiZcQrOYOTMjQpZTn0zvl18C8yMP
 7kUjV8+ZveWgpG/LnRL3ksHQb44hJnP5IVhODRuO+qeAZhP/b0o0P0zwE7UlO2fTpBeA+CZlK+B
 Mn0i0HQCpXVaT45IrIw0HJ3rGnI2wOmqB+wYZPsh8PxehR36awtcuD7nUJ6uQS7JipHuK3lGPoj
 3eAG1TxaAM5gv/Cdwy082vqcAsUFF2JhDXXy0hZe+DauShsIGlQG0D7h64HrprKljfktg+PUoOw
 biMWGE4+THA1PttOSUWbyUE6+C3VgXaOelNzLNS+XZAwYXpHOditHQoKqNL/SAGv89m5g3fPGfQ
 HwDq84BzhcxvSdrL36b2AuDIA2lFVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_01,2025-10-06_01,2025-03-28_01
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

Free memory used by virt queue op cookies in dev close.

Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Change-Id: Idbf87e6ef5bede3cadfae587b5a6d7592f5d5cf3
---
 drivers/crypto/virtio/virtio_cryptodev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index d661ce8025..6f079f15f6 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -68,6 +68,7 @@ void
 virtio_crypto_queue_release(struct virtqueue *vq)
 {
 	struct virtio_crypto_hw *hw;
+	uint16_t i;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -79,6 +80,9 @@ virtio_crypto_queue_release(struct virtqueue *vq)
 		hw->vqs[vq->vq_queue_index] = NULL;
 		rte_memzone_free(vq->mz);
 		rte_mempool_free(vq->mpool);
+		for (i = 0; i < vq->vq_nentries; i++)
+			rte_free(vq->vq_descx[i].cookie);
+
 		rte_free(vq);
 	}
 }
-- 
2.37.1

