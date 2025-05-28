Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3968C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:28:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 182494028D;
	Wed, 28 May 2025 12:28:37 +0200 (CEST)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com
 [207.171.188.206])
 by mails.dpdk.org (Postfix) with ESMTP id 18B9240279
 for <dev@dpdk.org>; Wed, 28 May 2025 12:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1748428115; x=1779964115;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Q6l8eUt0N4sicMkGhn5myEydrzPWCLXXVnU0s1xQQFQ=;
 b=XM4CUTPbp5GF5HWQfWCVFQGSHSRzKlAoBBy7G3DTSwDsIXGIuaWiyluu
 TJd5cd04mpanzG8nvMWjM05Xi90E3H6UeER+Chy1a/y9g8E6nNd/m/+kL
 p2tepl0dHmA+ZQOz/qQ0aYe5iUWQYPXCSLWQBfhcBmcYHXE3b7UAbIdp/
 bu8rAW5lguHhlpAS+G2YdCKK6qCm8pwrebg+GGpPqwoM69yIN265WADOW
 ttl0/hkNMUleIogiu39m7cKt1r7FYXx00adfN5Nwxt8wFghC+gOiNARJy
 cPFP4VxwplfG9ip4PXxhVP6hdfApxmW7aZkIAw6ypKiWPBaUJU2YGhUq1 Q==;
X-IronPort-AV: E=Sophos;i="6.15,320,1739836800"; d="scan'208";a="829116188"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:28:29 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:34238]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.185:2525]
 with esmtp (Farcaster)
 id 02f2d2b6-43e2-4104-9240-617a54cce521; Wed, 28 May 2025 10:28:27 +0000 (UTC)
X-Farcaster-Flow-ID: 02f2d2b6-43e2-4104-9240-617a54cce521
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:28:27 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:28:25 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v4 7/7] net/ena: upgrade driver version to 2.13.0
Date: Wed, 28 May 2025 13:28:06 +0300
Message-ID: <20250528102806.10030-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

Upgraded the driver version to 2.13.0.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index d249701144..7e75eddcd9 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -22,7 +22,7 @@
 #include <ena_eth_io_defs.h>
 
 #define DRV_MODULE_VER_MAJOR	2
-#define DRV_MODULE_VER_MINOR	12
+#define DRV_MODULE_VER_MINOR	13
 #define DRV_MODULE_VER_SUBMINOR	0
 
 #define __MERGE_64B_H_L(h, l) (((uint64_t)h << 32) | l)
-- 
2.17.1

