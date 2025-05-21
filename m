Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA04C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C8E342D78;
	Wed, 21 May 2025 16:06:45 +0200 (CEST)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mails.dpdk.org (Postfix) with ESMTP id 3E17642D76
 for <dev@dpdk.org>; Wed, 21 May 2025 16:06:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747836404; x=1779372404;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=uyPlO5mIiDN/BYtqPLU5l7LlVJd5Kqmvnaa4wFzumIU=;
 b=XjScher78kWjkXIQmPHIhxkgaBStidVC4fgRoqQpLl1s0W/1IgL+yT8r
 d94HIEb+4y52w5AmF9jyFzL2IIPOlxp02IVuLyrIc1cQQ3dj12/2SkEZ3
 A7Vv+H4zuTnnj2gCtbJUB8KmkEVb0lsCdelG14B8S/4Cd8Z0lxRv3XKLy
 EnZ6U/w32N9HUuE3pDHziBKZfpzk/Mo17ukLy5rVa8DdIT/N98NXa7TQg
 42qclF805q5cBd1KI+8rWS0Z1eSFE7un2kYZpL2yLDasg46OdAZ1poHvm
 u8nKTUDoL3NsmHthhl8gVflSrzACKWdpffRBbj4GupWoUP0q2/jkmlnUH Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; d="scan'208";a="522852169"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:06:38 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:21551]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.53:2525]
 with esmtp (Farcaster)
 id 89abe6e6-2e74-4ca4-95c0-26b877a2e942; Wed, 21 May 2025 14:06:37 +0000 (UTC)
X-Farcaster-Flow-ID: 89abe6e6-2e74-4ca4-95c0-26b877a2e942
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:06:36 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.30) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:06:34 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 8/8] net/ena: upgrade driver version to 2.13.0
Date: Wed, 21 May 2025 17:06:20 +0300
Message-ID: <20250521140620.2841-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.30]
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
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
index bdb4938231..6136d8c6b9 100644
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

