Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD37C54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:09:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C86AB406BA;
	Thu, 22 May 2025 15:08:56 +0200 (CEST)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mails.dpdk.org (Postfix) with ESMTP id 5924040685
 for <dev@dpdk.org>; Thu, 22 May 2025 15:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747919335; x=1779455335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=jVQ/LmCnQbR0plpYUGkGpZrn1XBft7BFZ4fDebpO/SM=;
 b=OaG7uSiAE+WeZj4di0bscWTqtyAtKmowxrP+al4JyK6DxdGWRRNghRye
 efCWnCocOC63l1gQN8gwVLCS5vOHS6TzlN6uU83QFqELjmZLmfYPQCR1T
 IGWdqvQ52DkvzUuuCDXla5nVlSkkVwxfJg7ShaOddmVsBUeBhH8HrnQj9
 eIscwU0b8o4B6i8orKut6cyvvZLIj/ab3p77xKAKJsk+W9yix21EBYUIJ
 bj0onOxm9Of/3SK5Sq1T6BAh/hMx+Dr8rVW822JK7ygopuxR5rxTWSoFW
 OLu6SnMNq1iWba3eUBkgeiGpYO6piQH0j3PhRQEYSb17lKvdJco84u3WI Q==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="523295186"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:08:53 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:56056]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.128:2525]
 with esmtp (Farcaster)
 id 46f43179-8455-4239-bcc3-ee71d09d82eb; Thu, 22 May 2025 13:08:52 +0000 (UTC)
X-Farcaster-Flow-ID: 46f43179-8455-4239-bcc3-ee71d09d82eb
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:08:51 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:08:49 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 7/7] net/ena: upgrade driver version to 2.13.0
Date: Thu, 22 May 2025 16:08:26 +0300
Message-ID: <20250522130826.3246-4-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250522130826.3246-1-shaibran@amazon.com>
References: <20250522130826.3246-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
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

