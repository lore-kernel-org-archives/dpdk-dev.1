Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A242CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:12:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7BCA4069D;
	Tue, 13 Oct 2026 17:12:38 +0200 (CEST)
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
 by mails.dpdk.org (Postfix) with ESMTP id 43DB040658
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904357; x=1823440357;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ceNYB8+k+LFaAwbM8Jb2j9MifMQyGWpcniNOP6PGKnw=;
 b=JekfN19C0lskZRdAgwu3EcNQu8sBu+79a+aX5/Loi15xoAajfuReZ4AA
 PKNevi06Z4MJyWlvVpfm//+eWzEJWrt25ZkiSe7xDwjLzbGU/fNSQ6xhJ
 WyLqFFeRpytHAPfTeOQiW8fNvhEETQ29UmE1kDyfmc1Rvim00Q5gDaBFZ
 ceGxbL4ptGf6rQnBAvXxEqTb4w8yzgPVQnm+raI9Nmk9aSktSpMDBwFSz
 GISHrr6fNjDo4vmNnKY+FC3PiN7fkwfHYx84gTpB2eLi3u/gcGG+loumB
 R5z02a/CMrQowoCiJ7MawjP3ZeNzI09qnsX8UF+6G9bQrnh9oCq5PJfop w==;
X-CSE-ConnectionGUID: bhDx+KS2QQ2H1/CYUXbydQ==
X-CSE-MsgGUID: B2lwfR3SRda/+NV6kDL6ZQ==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="30906817"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:12:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:22702]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.46:2525]
 with esmtp (Farcaster)
 id d71ba660-cdab-4fb9-ac03-86aa9a3e9071; Tue, 13 Oct 2026 15:12:36 +0000 (UTC)
X-Farcaster-Flow-ID: d71ba660-cdab-4fb9-ac03-86aa9a3e9071
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:12:36 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:12:34 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 13/13] net/ena: upgrade driver version to 2.15.0
Date: Tue, 13 Oct 2026 18:12:22 +0300
Message-ID: <20261013151222.9874-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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

