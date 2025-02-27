Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7176C282C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 18:16:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C5C640E0C;
	Thu, 27 Feb 2025 19:15:58 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 108B140BA5;
 Thu, 27 Feb 2025 19:15:55 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHiKPc013085;
 Thu, 27 Feb 2025 10:15:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 uOus+kblO3E0kLXqz2O6ZZ/hYF/aOY2AkpaUXU0yco=; b=bAC/T/P7Rs69VgiNn
 85pTpIn6YzsJEwZg7TJDuVukonH/nOarPLWfJcyxnZieg3RScKuU7zzqJb1hnEUz
 X4/c3MxMJEC2CC6efmmZygfdn4Ok+0nky4l/O4gCQABGStcOqUm8wuJQID7OglYB
 T5i7gEnY9UuggnT5VCj74ikROpKUu+8zLSyPmWeu7ZG2BfwlVfW1GecFKUqzf6LV
 gOwIu1MYhi/kEkoIZvrO6LrKFD7hAvgCI2wWosf+BLXT0nLEVgae/28HTXTdA3Gs
 OYl/WOvYgF9r/edkiQWQsfz2vCQSkytJCVqRgxfaN32AaQ5Z649os2/PmGrTG3O+
 17pDA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 452vpv02mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 10:15:55 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 10:15:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 10:15:54 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 488C93F7076;
 Thu, 27 Feb 2025 10:15:51 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v8 3/5] examples/vhost_crypto: fix user callbacks
Date: Thu, 27 Feb 2025 23:45:24 +0530
Message-ID: <3d01705e5ae4d8dd511cc5952b28fb76ec927479.1740679955.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740679955.git.gmuthukrishn@marvell.com>
References: <cover.1740679955.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: F45dtg5dk77kYXBZBtNme_mag9qmPYBv
X-Proofpoint-ORIG-GUID: F45dtg5dk77kYXBZBtNme_mag9qmPYBv
X-Authority-Analysis: v=2.4 cv=JOjBs9Kb c=1 sm=1 tr=0 ts=67c0abdb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=T2h4t0Lz3GQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=cGNggxaUmQD6pPA5iYsA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
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

In order to handle new vhost user connection, use new_connection
and destroy_connection callbacks.

Fixes: f5188211c721 ("examples/vhost_crypto: add sample application")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
---
 examples/vhost_crypto/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 558c09a60f..b1fe4120b9 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -362,8 +362,8 @@ destroy_device(int vid)
 }
 
 static const struct rte_vhost_device_ops virtio_crypto_device_ops = {
-	.new_device =  new_device,
-	.destroy_device = destroy_device,
+	.new_connection =  new_device,
+	.destroy_connection = destroy_device,
 };
 
 static int
-- 
2.25.1

