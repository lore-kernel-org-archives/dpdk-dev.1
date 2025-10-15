Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62398CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:12:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA27742788;
	Wed, 15 Oct 2025 14:12:52 +0200 (CEST)
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
 by mails.dpdk.org (Postfix) with ESMTP id 51EEA40E40;
 Wed, 15 Oct 2025 14:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530371; x=1792066371;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=B9weZ9Y5eErD/nLAoJuXuvSOgtc6IsbS7G8Ggusyjm4=;
 b=rC3CicnJsiVNisODYeGU344b+U56G1FalJODDldN/JtXvK+itPKkrYIo
 De2F0DpX2TpxWD355fx1e2q5jd/qAXOf/f2PX1kgQe7oana6g/vFfcRKW
 MGagpjKk2eQ3AfkQvTN9jV4RWiqE8/dWJ4+YNjiT4aqXjKxO8V+XW+k6F
 5JS0Bv8GV1cuqUCg/5isSBvLTR6QBPY2MqvSzJayotZ/Vq5X9zDS3W8Ds
 PNIIieTYvx52vNczU0hLM7Mgh6WkhrE6D9mSJFUh20baiiCPhq3uJkFrx
 XOs7nmN3Z8cWPBaRO+DQZxm6jX6QhtpYf9BCEdKlP4yzLNOiqcb7OetTn w==;
X-CSE-ConnectionGUID: mmXoxbzMTGmD7L9kGB2eRw==
X-CSE-MsgGUID: XTACWroKSQGXPKBD/WFp9g==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4928943"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:12:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:28319]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.42:2525]
 with esmtp (Farcaster)
 id 6e6934cd-d85d-48b7-a401-43c8a061e481; Wed, 15 Oct 2025 12:12:50 +0000 (UTC)
X-Farcaster-Flow-ID: 6e6934cd-d85d-48b7-a401-43c8a061e481
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:12:43 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:12:41 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v2 17/20] net/ena/base: fix unsafe memcpy on invalid memory
Date: Wed, 15 Oct 2025 15:12:30 +0300
Message-ID: <20251015121230.3024-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
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
index ede3c06139..f0936a6262 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -2453,13 +2453,13 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
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

