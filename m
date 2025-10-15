Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53725CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE3574111B;
	Wed, 15 Oct 2025 14:12:24 +0200 (CEST)
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.83.148.184]) by mails.dpdk.org (Postfix) with ESMTP id 7BE534111B
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530343; x=1792066343;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=gz1pSyJQUBcs27fccuYDL6NfuydDtJP11UOGN8m2mUE=;
 b=hcPY2pR6mgbhIIk5Nu4tpHEqPJSQvd9RJqC0/ezdEgRn++3NwXHkPyA7
 uKxvQROF6P4xQvMAIcIl7fyVfgX9/Xo+QzUySHdbbwJWaBl2fHIZpVw4K
 E0bD7wH46YNt65PRCcFB1V0qazkte8Nkh2jNmwL7mfnykXA+1FMltx/wU
 voc5kX1dRloVYXXi0nGRJ95zHLBYkWXWN5pOYQkGoM0e8gDqzxsoU8A05
 5n4xh6KOis3oTFB4n55DGf6aZAeBAUwgHtl5PKdW42HHzU14Up2xZ3r03
 fddYzl9hIdF/LVdquIVJUxIr2iXWWsp5vdJmAAjpp6XG8Gqs3CmtUQujN A==;
X-CSE-ConnectionGUID: TP43FvjHS02igUOMFZx2DA==
X-CSE-MsgGUID: RIzUlBLLR4K9gBePeTabyQ==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4729249"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:12:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:10553]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.137:2525]
 with esmtp (Farcaster)
 id 9d1794a4-db19-4dbe-9dc9-411310ea0505; Wed, 15 Oct 2025 12:12:22 +0000 (UTC)
X-Farcaster-Flow-ID: 9d1794a4-db19-4dbe-9dc9-411310ea0505
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:12:22 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:12:20 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 16/20] net/ena/base: remove redundant if sentence
Date: Wed, 15 Oct 2025 15:12:11 +0300
Message-ID: <20251015121211.2975-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
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

The driver supports only host/device IO queue modes
making the if sentence redundant.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index c3f3ca2bbe..ede3c06139 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -364,9 +364,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			ena_trc_err(ena_dev, "Memory allocation failed\n");
 			return ENA_COM_NO_MEM;
 		}
-	}
-
-	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV) {
+	} else {
 		/* Allocate bounce buffers */
 		io_sq->bounce_buf_ctrl.buffer_size =
 			ena_dev->llq_info.desc_list_entry_size;
-- 
2.17.1

