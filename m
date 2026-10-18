Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AF8CCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 06:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 866D94060F;
	Sun, 18 Oct 2026 08:37:01 +0200 (CEST)
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [50.112.246.219])
 by mails.dpdk.org (Postfix) with ESMTP id 25EA240276;
 Sun, 18 Oct 2026 08:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792305420; x=1823841420;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=JjXMljuTvUMWW6UQu6XNgnZWFJgdjxLisQMrwW+c3xY=;
 b=TnLQk7vuJLm5sBbP2Wvu1eQidBF+7q0tCEgNVa5S4TT3wsYV9UBgtpJ6
 GjThT9fl71o4h4hCPUQ8MeLZrxP3329tTFO5agkg58raXw9OgdlvON0ZU
 JzZLRGyCM+ILWn4VVzMdHqGGx9Pxi4sHr7sBzMnJL84lcGMwTKzEdbOLD
 VZt3O1UkbjqY+nVgYvlti62mGWuDsduIaRPtPFCpHYFCk1oJdWiZPVsaK
 M4y8wgOkYiVJc43z1jH5NfzVjLzhNr4I7YApYULBmBQ2zlnqpeQjBmgnI
 3gfRSSx4B6+COZQWys90W0vzcP1JfAaCXHaPVXzBB0sccTmDYmmsEemXv A==;
X-CSE-ConnectionGUID: HXmf3djqQiKPJu4+abqgGA==
X-CSE-MsgGUID: 12noqTH9QNK9XuCKJBCDCA==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31332923"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 06:36:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:30615]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.190:2525]
 with esmtp (Farcaster)
 id 0e17530a-91b2-4e64-ac88-09dc63c6e2d4; Sun, 18 Oct 2026 06:36:56 +0000 (UTC)
X-Farcaster-Flow-ID: 0e17530a-91b2-4e64-ac88-09dc63c6e2d4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 06:36:56 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 06:36:54 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v2 02/13] net/ena/base: fix race in PHC destroy
Date: Sun, 18 Oct 2026 09:36:46 +0300
Message-ID: <20261018063646.1069-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
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

ena_com_phc_get_timestamp() checked phc->active and cached the
resp pointer from ena_dev->phc.virt_addr before acquiring the PHC
spinlock, so neither the liveness check nor the pointer read was
serialised against teardown.

If ena_com_phc_destroy() runs in that window it clears active,
releases the lock, frees the PHC DMA memory and sets virt_addr to
NULL. The reader then dereferences either a pointer to already
freed memory or a NULL virt_addr, depending on where it was
preempted, crashing the application on PHC teardown or device
reconfiguration.

Move the phc->active check and the resp pointer assignment inside
the spinlock so that destroy cannot free the DMA memory while a
timestamp read is in progress.

Fixes: f73f53f7dc7a ("net/ena: upgrade HAL")
Cc: stable@dpdk.org

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index b1fe0bcdf7..737626bcfa 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -1996,20 +1996,23 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
 
 int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 {
-	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
 	const ena_time_high_res_t zero_system_time = ENA_TIME_INIT_HIGH_RES();
 	struct ena_com_phc_info *phc = &ena_dev->phc;
+	volatile struct ena_admin_phc_resp *resp;
 	ena_time_high_res_t expire_time;
 	ena_time_high_res_t block_time;
 	unsigned long flags = 0;
 	int ret = ENA_COM_OK;
 
+	ENA_SPINLOCK_LOCK(phc->lock, flags);
+
 	if (!phc->active) {
+		ENA_SPINLOCK_UNLOCK(phc->lock, flags);
 		ena_trc_err(ena_dev, "PHC feature is not active in the device\n");
 		return ENA_COM_UNSUPPORTED;
 	}
 
-	ENA_SPINLOCK_LOCK(phc->lock, flags);
+	resp = ena_dev->phc.virt_addr;
 
 	/* Check if PHC is in blocked state */
 	if (unlikely(ENA_TIME_COMPARE_HIGH_RES(phc->system_time, zero_system_time))) {
-- 
2.17.1

