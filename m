Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178B2CCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 06:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E09C40A72;
	Sun, 18 Oct 2026 08:42:27 +0200 (CEST)
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [34.218.115.239])
 by mails.dpdk.org (Postfix) with ESMTP id DE4B440276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 08:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792305746; x=1823841746;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ceNYB8+k+LFaAwbM8Jb2j9MifMQyGWpcniNOP6PGKnw=;
 b=ZwrDS6rWyVpPjGQflK6blYoM3/e3IyGfONksqXf+MaFYZzSKxdB4ShnL
 NG5arZpcZDDjPstDrGcWB+qqh+cHOxV4Y3a82y/NPEpW1H02IyOqNSQ3W
 LiXckOf3hYnVwI5sm0ZbVuGPl545qZufp3bV5a4k2Eo2t3lnwCjV+Ay8O
 nM/NSkf+vP5e0lzjJ+BG2A7ftN0+KJq/wH3IkmyS1ZELuM67SgcDa4fuk
 CJtY9fSnv4kROWH/i9Rpi2PBlhlT9/KzXyxrnkbrg3GpLIAsM1F5sU0KD
 33w2WawhreWb6xVRxUpzeFtr0pO3uE6c/KZyWdObZHvFe+TWC8rltyA1d A==;
X-CSE-ConnectionGUID: c2dP4s7YTOaNmCt/9/yIIw==
X-CSE-MsgGUID: GJCJDRP8RKiKp2f9Wv8t7Q==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31338811"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 06:42:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:9971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.154:2525]
 with esmtp (Farcaster)
 id 1890a0eb-6a5a-4050-947f-9296ed0b589c; Sun, 18 Oct 2026 06:42:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1890a0eb-6a5a-4050-947f-9296ed0b589c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 06:42:22 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 06:42:20 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 13/13] net/ena: upgrade driver version to 2.15.0
Date: Sun, 18 Oct 2026 09:42:10 +0300
Message-ID: <20261018064210.1601-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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

Upgrade driver version to 2.15.0

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 3eee5e2545..435c2af477 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -23,7 +23,7 @@
 #include <ena_eth_io_defs.h>
 
 #define DRV_MODULE_VER_MAJOR	2
-#define DRV_MODULE_VER_MINOR	14
+#define DRV_MODULE_VER_MINOR	15
 #define DRV_MODULE_VER_SUBMINOR	0
 
 #define __MERGE_64B_H_L(h, l) (((uint64_t)h << 32) | l)
-- 
2.17.1

