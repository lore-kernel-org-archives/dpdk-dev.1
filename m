Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F83AC021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 11:40:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F19D40ECF;
	Mon, 24 Feb 2025 12:40:31 +0100 (CET)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by mails.dpdk.org (Postfix) with ESMTP id 89BD340E42
 for <dev@dpdk.org>; Mon, 24 Feb 2025 12:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1740397228; x=1771933228;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=qZDaWBX2Xqt/zbWXpz3PQuecanKEpRuzKtDpys+XOp4=;
 b=IDAdg8HALXdFR57/c7G2UGODbh6NYnn2mXe64hOUJ0AKqQHMTXCIK3Xl
 mLXydQLkTfmoEQV2N8nQHcLw/+800SXQhm8679UcS+Rqg5GMhDQPKIAe/
 Nuh59dBoFE78vsLUwVcJXIyUA7F4kJuju+D1Wp5jG1AH1Jsp3ME9OlH6N 8=;
X-IronPort-AV: E=Sophos;i="6.13,311,1732579200"; d="scan'208";a="465250476"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-6001.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:40:25 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:28072]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.214:2525]
 with esmtp (Farcaster)
 id 2deb9f0a-fff4-45fc-87ad-2554ec78cecc; Mon, 24 Feb 2025 11:40:23 +0000 (UTC)
X-Farcaster-Flow-ID: 2deb9f0a-fff4-45fc-87ad-2554ec78cecc
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:23 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:22 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 11:40:22 +0000
Received: from HFA15-CG15235BS.amazon.com (unknown [10.1.213.12])
 by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix)
 with ESMTP id 103AD801E3; Mon, 24 Feb 2025 11:40:20 +0000 (UTC)
From: <shaibran@amazon.com>
To: <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 4/4] net/ena: upgrade driver version to 2.12.0
Date: Mon, 24 Feb 2025 13:40:11 +0200
Message-ID: <20250224114011.1789-5-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224114011.1789-1-shaibran@amazon.com>
References: <20250224114011.1789-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
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

From: Shai Brandes <shaibran@amazon.com>

Upgrade ENA driver version to 2.12.0.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 705b0b3a85..038b10eec2 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -22,7 +22,7 @@
 #include <ena_eth_io_defs.h>
 
 #define DRV_MODULE_VER_MAJOR	2
-#define DRV_MODULE_VER_MINOR	11
+#define DRV_MODULE_VER_MINOR	12
 #define DRV_MODULE_VER_SUBMINOR	0
 
 #define __MERGE_64B_H_L(h, l) (((uint64_t)h << 32) | l)
-- 
2.17.1

