Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D264C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1BCB40661;
	Mon, 30 Jun 2025 13:16:51 +0200 (CEST)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com
 [207.171.188.204])
 by mails.dpdk.org (Postfix) with ESMTP id B41804025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:16:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751282210; x=1782818210;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=MVmM70bRxgmmJMryVO/ANBpSKgscdorVf92zh3iinbY=;
 b=j4stGZjpPGQgNOw2u+/D+sfJo8FKXvMSqIPIO80ChXUY3KTsENmsanyi
 FKK5aVlq7HPGGHKAywJj48aYWRnT+TXj/I4pQWqtVtA2TDYPUfCQOrcBz
 CSQN0kySg4wWkoJgmybfXMRW8KK5SL6Kp3/QkXdEhCU+QAgHyR1LIN2HD
 cqQ6o8VQhELYzYIAAKmYsHNhV024qhno1iIVK+Rlang55pBe8vyh6HZbE
 djIDvS0aulGDhRqBd7ImyyC92FuiSRi9YLW5em8UGiB2IYzAMeajQIFdC
 X0bQofnh7NUICf7pqbm4l7G0TDVAYLIwYMzzJIrD3CDkTjXgDsleswkNn g==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="34658808"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:16:43 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:19795]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.208:2525]
 with esmtp (Farcaster)
 id 35e17f6f-5c61-4e42-a917-3e0461a3679d; Mon, 30 Jun 2025 11:16:42 +0000 (UTC)
X-Farcaster-Flow-ID: 35e17f6f-5c61-4e42-a917-3e0461a3679d
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:16:41 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:16:39 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 7/7] net/ena: upgrade driver version to 2.13.0
Date: Mon, 30 Jun 2025 14:16:24 +0300
Message-ID: <20250630111624.3677-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
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
index 04a698b58c..f5cf5c3811 100644
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

