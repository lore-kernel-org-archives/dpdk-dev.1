Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9892CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:16:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 283A040A6B;
	Wed, 15 Oct 2025 09:16:47 +0200 (CEST)
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
 by mails.dpdk.org (Postfix) with ESMTP id 1D756402CA;
 Wed, 15 Oct 2025 09:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512605; x=1792048605;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=CnUK1MryJ+8cDWx0ExBMwdD2bApZgICFyPEtRus7GDs=;
 b=VvFjNI1nW3z1PWhK8eYlHNFUHG7p8RNE0B7gT7S4V1xKoJUwGpML+g/H
 0xAuQwV0t7b8C1QoQqvns+JIfdttjdOOYnTLoCIoRGiRgEiQyUZ1PhaAY
 UfInhsovLhc4/f6uVYNSwI5kaNugZXkZ2xP07egPfBjr1alwig/fDyZkj
 7ieP8LVRy8LHvWtb1VboJByzVZ2afa5AAIzUNE23RzVckmWEj2z3FyEx4
 w5w4atEQeeNy0oVt0gaGGuCBPf++fRDQDsZLvDLjNfYExdemp5XwrgqY8
 Xdns4TZTyXMV1PsFjDRs6Uy+2tw8OuWOC35LYrXYqvAFo+ba8W7eX43SC A==;
X-CSE-ConnectionGUID: 8MJ65GIjS5KNro2DW/sbkw==
X-CSE-MsgGUID: F3ojUX95TmKEZLaHqt/uZA==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4915491"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:16:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:4024]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.71:2525]
 with esmtp (Farcaster)
 id e6fbebe4-ed00-4419-a845-52cd100946b7; Wed, 15 Oct 2025 07:16:44 +0000 (UTC)
X-Farcaster-Flow-ID: e6fbebe4-ed00-4419-a845-52cd100946b7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:16:36 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:16:34 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH 18/21] net/ena/base: fix unsafe memcpy on invalid memory
Date: Wed, 15 Oct 2025 10:16:25 +0300
Message-ID: <20251015071625.1139-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

The return status check was placed after a memcpy operation,
which could result in copying from an invalid memory region
if the feature fetch failed.

Fixes: b68309be44c0 ("net/ena/base: update communication layer for the ENAv2")
Cc: stable@dpdk.org
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index b4437f532b..b003167bed 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -2476,13 +2476,13 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 	} else {
 		rc = ena_com_get_feature(ena_dev, &get_resp,
 					 ENA_ADMIN_MAX_QUEUES_NUM, 0);
+		if (rc)
+			return rc;
+
 		memcpy(&get_feat_ctx->max_queues, &get_resp.u.max_queue,
 		       sizeof(get_resp.u.max_queue));
 		ena_dev->tx_max_header_size =
 			get_resp.u.max_queue.max_header_size;
-
-		if (rc)
-			return rc;
 	}
 
 	rc = ena_com_get_feature(ena_dev, &get_resp,
-- 
2.17.1

