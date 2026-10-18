Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE76CCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49FD44064C;
	Sun, 18 Oct 2026 11:47:32 +0200 (CEST)
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [34.218.115.239])
 by mails.dpdk.org (Postfix) with ESMTP id 6458640276;
 Sun, 18 Oct 2026 11:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792316850; x=1823852850;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=JjXMljuTvUMWW6UQu6XNgnZWFJgdjxLisQMrwW+c3xY=;
 b=R9C+mxQRfdbGVfHaXoppaN9Ck5Ia+bxfIU/d+KvRlsaDO2Wv1AQz3LtV
 49uVlT1iH3Bj/gitEYwlDK0rw+UQIs5hsiIrLFGWS3SBhPI3pUXq+p1Hs
 XL9zhupyXZP4oQmIhPuOnOi9UsU/KGI7FOWSPPv1YBeqN59iVONecYPOv
 W/6lsSDn6Ek25uqArkv+2f908bBG+sy9d3amc1mAvLJe7hjWmOO6EDCVX
 97QbP6chRuEwvA3IaOZ181mERlKmA3QduzqeaHSg8iG4/55dXe8DCxGHc
 w2Ea8K71TbDEIrwJkWbRt7yXNg7foyi2BYs2cqGiydv8WrFpkMVzprbsn A==;
X-CSE-ConnectionGUID: yX86cb7JS46JFCC+O2EUVA==
X-CSE-MsgGUID: ZEN4NwChQqGFuJ3ADbijqA==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31345625"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 09:47:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:23626]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.190:2525]
 with esmtp (Farcaster)
 id d82671f4-c857-40fa-a317-cd1f79392d56; Sun, 18 Oct 2026 09:47:24 +0000 (UTC)
X-Farcaster-Flow-ID: d82671f4-c857-40fa-a317-cd1f79392d56
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 09:47:23 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 09:47:22 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v3 02/13] net/ena/base: fix race in PHC destroy
Date: Sun, 18 Oct 2026 12:47:12 +0300
Message-ID: <c0d448f6fe5b76262e57f4345260976a945ce657.1792312030.git.shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1792312029.git.shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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

