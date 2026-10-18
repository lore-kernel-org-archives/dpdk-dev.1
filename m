Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF20CCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:54:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FFB34060B;
	Sun, 18 Oct 2026 11:54:46 +0200 (CEST)
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
 by mails.dpdk.org (Postfix) with ESMTP id AF8B040276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 11:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792317284; x=1823853284;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=ceNYB8+k+LFaAwbM8Jb2j9MifMQyGWpcniNOP6PGKnw=;
 b=KzPdFOy2LnVFYmlhbS0z51AMFavbCnjUaKyhQQJj9D3fDrpXSdhF7/WD
 wIHaQ/v1WWB4KbekDxXDoaLVQrFrwbtwIrtDL2Yc6GDI077jUpX03ptSx
 15eg6D3VKXILhFOfVLodS5FMOKfJFZqigD9I5D7XqwO3XfU20YG0fC5wy
 q0+C1WXwahaLwJTnsb6xkEsDTsAQoKj1vxaPGftpFiFUIGhDPmejUQMzs
 H+l/AShGN1DsVgFulHAK10dWAvjCUWPj/BQPpM1NRI9rNxOEwqu3wZybc
 xmRUOK1BTWSL1pAW+T3RmAbhbrDynhAUxr+7zJhmM4sWg0vyDpImYcS9R Q==;
X-CSE-ConnectionGUID: BMGxmJWITlq6K+BcKedRMg==
X-CSE-MsgGUID: MGhtZ2c7QZqr8cbHTLNgfQ==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31562126"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 09:54:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:19720]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525]
 with esmtp (Farcaster)
 id 28c3daef-745f-45c3-84a4-261117c8bf6b; Sun, 18 Oct 2026 09:54:41 +0000 (UTC)
X-Farcaster-Flow-ID: 28c3daef-745f-45c3-84a4-261117c8bf6b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 09:54:41 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 09:54:39 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 13/13] net/ena: upgrade driver version to 2.15.0
Date: Sun, 18 Oct 2026 12:54:25 +0300
Message-ID: <803920d29c055d33f26282aaf64c367d49e2b51f.1792312031.git.shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1792312029.git.shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
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

