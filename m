Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5711BCCD184
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Oct 2025 04:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F5014021E;
	Sat, 11 Oct 2025 06:37:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 98DCC4003C;
 Sat, 11 Oct 2025 06:37:13 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59B3ho85000701;
 Fri, 10 Oct 2025 21:37:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 tV+dmd/YNSyKhMYJ0NCm9ntwoT/JTMYXZyLFSTK+B8=; b=jUjTIII1yG6l/iKIh
 sCqF1N2HyQimdGi5D/PlQjYpXhEO+lBppBBhbVR5HqTuvZfP5kvkjItsmwQEg+Y7
 V+Zpr3h/vjMFbiyR2ifDHv25coDopiFm659JGYrbr5IcM8JSamG0rId3tny8ouNr
 K9hFWw+6a8kyriksvTRdUXilwWkrMJkIBNppBVuBK6KQ9Ypu9I2XLwbg9FRuPm3N
 ck2T2yhLmGJu8nrJpqzaUkMgJFALJNcMs+QBsa5nBMXJUuDBXHAz7S2jfv2YN+19
 M7evRyq4r+PTLZSlE4K4V7t06e/QYyZUDjPCe3qGJuGh0yAJQO+XVz+VXd0AC1Ze
 sxz+A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49qffj02yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 21:37:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 10 Oct 2025 21:37:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 10 Oct 2025 21:37:21 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.101])
 by maili.marvell.com (Postfix) with ESMTP id 4A11A3F7087;
 Fri, 10 Oct 2025 21:37:09 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2] crypto/virtio: free memory used by op cookies
Date: Sat, 11 Oct 2025 10:07:03 +0530
Message-ID: <20251011043706.1554-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251011043238.1508-1-gmuthukrishn@marvell.com>
References: <20251011043238.1508-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOSBTYWx0ZWRfXxwl8SsdvFSra
 SYCW8q4R5o+IVZO4iLEERP8HCOZpwvDi90Qrdo15jaXAe5wjzEZWzVl80XBIiJEckobWs2ya3+J
 gaODTUpkGenYQPtSjpgPR+orNbyHovnxRz2PFpQMXexBXqPlxYNA3QPDT794VDoq+QmaxFIuE0G
 Sm29Lwgfcf5QgLxtORFbcwFiAmRwA5/COlV2/FpZIGb05eP1hJOS4s4N0mY1M/nnnJ8gNY+VyhB
 CZOPRyV5jPreycUnnqoxzUE4SsjaB/HkkCIDHeKUR92ZBJBWZebk0XGuiPS4lcash9Eq4Vf3PPb
 VJzBLh3O4HUzj7VcjJbJ6/kurIFHWEHGhXJR63GHmiaUyUxjNE5g1kUF7bI6fqsY8W/ALBJCLzu
 LKVF+JYOyr2VgjiQsk/uNlOtm4DP0A==
X-Proofpoint-ORIG-GUID: tCnHwonl6U4Q6JHs5w_c_br3EN0W6TZr
X-Proofpoint-GUID: tCnHwonl6U4Q6JHs5w_c_br3EN0W6TZr
X-Authority-Analysis: v=2.4 cv=eJ4eTXp1 c=1 sm=1 tr=0 ts=68e9def8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=UwpCt8k1nEKr33SsngUA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
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
---
V2:
 - patch description updated.
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

