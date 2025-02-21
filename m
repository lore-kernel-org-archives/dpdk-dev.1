Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ECBC021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:30:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F092542708;
	Fri, 21 Feb 2025 18:30:52 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 27A1D42670;
 Fri, 21 Feb 2025 18:30:51 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCs6Rk015868;
 Fri, 21 Feb 2025 09:30:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 CGJJDyvnL2oPW1wmRvIdZ16hfB4QK+DUjS9pjD8C10=; b=aakinN/m0sl3uyHfQ
 jqySqCIpPr/DVoAB349ZWfrFdZb+d8M6jz+0UWJXOpS/0khyIiJYeSvpNaNTrzKT
 Omj9n+bbz0Su5jl/zMDksn+FwDMqgvZf7yPXY0Vx/k69JjvL7xfgyxB4BvL5mnw2
 oUdSVqZBuVcvtvxO/U0WmeA6aKLhfgRS8UsCAnBGJwk12ATD2PG/HicvcxJQU+xe
 eeTSqrTTnyH+lhN8ChcgS+Vhp0iOi/ScB9USa/9eP/wyrl1b54Pu1bnEVZRAMZjJ
 4KG0pPt68Kl4mZvwDtEV99MEicsLJNFLlEwij7Z2oCd6hPXbKwr11aUtCbPbe0vf
 HUGgg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44xnxu91dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:30:50 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:30:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:30:49 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id 133053F708D;
 Fri, 21 Feb 2025 09:30:45 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, Jay Zhou
 <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v3 3/5] examples/vhost_crypto: fix user callbacks
Date: Fri, 21 Feb 2025 23:00:11 +0530
Message-ID: <cd9c3a5f248ee8b6c0ad174a003993875bb3ee97.1740156665.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740156665.git.gmuthukrishn@marvell.com>
References: <cover.1740156665.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Y4Ldr6aF3jm3pzk6ip4vn8BjC0TNb8v0
X-Proofpoint-ORIG-GUID: Y4Ldr6aF3jm3pzk6ip4vn8BjC0TNb8v0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
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
---
v3:
 - decoupled from v2 single patch.
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

