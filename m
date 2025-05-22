Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0302EC54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:30:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59DE040663;
	Thu, 22 May 2025 15:30:51 +0200 (CEST)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com
 [207.171.188.204])
 by mails.dpdk.org (Postfix) with ESMTP id D933C402E5
 for <dev@dpdk.org>; Thu, 22 May 2025 15:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747920650; x=1779456650;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=jVQ/LmCnQbR0plpYUGkGpZrn1XBft7BFZ4fDebpO/SM=;
 b=BiqsVxUKg2ciucoaXhCSF2EPqyQq4Y9k7VNo4n+yk+PYIsz92Y0asgRV
 I6rOoclE8tgWIYEJfBKRuLlYQinRsCpxlSbo2+w8WgPuDTwhX2NmMCShC
 lNKmc9ot1YT3s+ZX0iK71yNPdyWogVm55Z109CLingbS95Rp8DYZAJaV1
 YoJbUuutCNHfnkEjWhS4fmq1UqT9xysXClAO2o0Ptvx7zPUDR7xvptw2+
 aqDqBRVK7kmrvhdLVE7m7+eAFOV1LFKm/1kWq3qo8ulbGW20Y/41lUL8Z
 UW/o1kdXGE8cVbYR2DFJxc80i9sh58Y+VXRGn9ssmbZTjc5QNR1LQq2Mi g==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="22707888"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:30:49 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:47812]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.206:2525]
 with esmtp (Farcaster)
 id 3207ffb2-969e-4446-ab1c-54efac148781; Thu, 22 May 2025 13:30:47 +0000 (UTC)
X-Farcaster-Flow-ID: 3207ffb2-969e-4446-ab1c-54efac148781
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:30:46 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:30:44 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 7/7] net/ena: upgrade driver version to 2.13.0
Date: Thu, 22 May 2025 16:30:29 +0300
Message-ID: <20250522133029.3575-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
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
index 182e063bf4..55b8d35285 100644
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

