Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5797CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EC0440A7D;
	Wed, 15 Oct 2025 09:17:50 +0200 (CEST)
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.34.181.151]) by mails.dpdk.org (Postfix) with ESMTP id 1555240A71
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512669; x=1792048669;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=+AhOl2ywWGXZg949s5bMUtpoL5GtsZEPDAeA2Kh4/Ds=;
 b=UCIkKJb29SzxkRKEnsp0ax2iAEImrlBXyyFoqcs6DhY3InMEbOtq1zQ2
 aTjXU8Gl/IDc1fj41b74L4qHmMEWpqA/wMkcJ6uU5ricgZfB9IojhbPDI
 A0XJIfJyUXmRCp0tG3HRi9HDAhsmVhp/eetME8tagw8Ou2e3/v/2+ZIj1
 6wdZ12wC+iuRiGanvX4yyJY+fhQoBiMpi8kj9KHMny2ua9uiWkphFUoxm
 3T+1rV3EfFf/XviZRbKdrBfhrlCxha228VHeJOti/8MMztE0c9FC1Jmve
 m6bSXNpbFo3c7jzHUc5C8TKe/+df33lNbHQLhCNL6waBtg3IghwrRe0Fp Q==;
X-CSE-ConnectionGUID: sn6l5a/WRUiZgaN5iDHkSg==
X-CSE-MsgGUID: c0fedLfaTZyo9SRR2rQyUw==
X-IronPort-AV: E=Sophos;i="6.18,263,1751241600"; 
   d="scan'208";a="4917434"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:17:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:23247]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.171:2525]
 with esmtp (Farcaster)
 id 7b0c0117-4945-4615-9300-fcbb1cc8c540; Wed, 15 Oct 2025 07:17:48 +0000 (UTC)
X-Farcaster-Flow-ID: 7b0c0117-4945-4615-9300-fcbb1cc8c540
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:17:41 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:17:40 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 21/21] net/ena: upgrade driver version to 2.14.0
Date: Wed, 15 Oct 2025 10:17:30 +0300
Message-ID: <20251015071730.1286-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
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

driver version incremented to 2.14.0

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 3274ecfb46..805990836d 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -23,7 +23,7 @@
 #include <ena_eth_io_defs.h>
 
 #define DRV_MODULE_VER_MAJOR	2
-#define DRV_MODULE_VER_MINOR	13
+#define DRV_MODULE_VER_MINOR	14
 #define DRV_MODULE_VER_SUBMINOR	0
 
 #define __MERGE_64B_H_L(h, l) (((uint64_t)h << 32) | l)
-- 
2.17.1

