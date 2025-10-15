Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C6DCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:09:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 347D640E78;
	Wed, 15 Oct 2025 14:09:06 +0200 (CEST)
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.162.73.231]) by mails.dpdk.org (Postfix) with ESMTP id AB81C40E36
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:09:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530144; x=1792066144;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=M8s2033FRZI8f4ElHBGeYuOVnIce7a1ZB+cJGfuKJpo=;
 b=ny0LUuVvc3r8SkJaDJVN8vEAhFBW42jl8qQRMQarhSU+psyUlJ7mw/BK
 yLtpItgguLlMHpfSwkbbgmDZtMyuHk4+LRQC9Xcn1JppXdZMJDoQ+n9nB
 A+Aq9M6W7IvxvMy6PT3uu/QesUf0cYvKpfkbJjzJd3Mb6ttn/Mrwc4WnC
 pMEuREDcMgeBYEcHVhHFzgYkijlbq+LAoTwcUyd4SBcGYsnrF6ViUIPRi
 VqZllt+FgPa2M1Bt1zStnhMzVIT8foXkBtSYYVC5p027198h9mi4nyqX7
 43LVOVn64v8bepKwKSp4HP2BA+RliecJZLt3RbSX5AOUx/vAJsvOdgdW+ A==;
X-CSE-ConnectionGUID: WvJrDjUrSKeWqp4LIqT2Vg==
X-CSE-MsgGUID: wh6EtR0uT8ugIlJV7QRxUw==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4732863"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:09:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:28595]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.84:2525]
 with esmtp (Farcaster)
 id 14d35d59-f2a0-4884-b3c1-524f6ebee78d; Wed, 15 Oct 2025 12:09:03 +0000 (UTC)
X-Farcaster-Flow-ID: 14d35d59-f2a0-4884-b3c1-524f6ebee78d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:09:03 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:09:01 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH v2 08/20] net/ena: add verification of DMA address width
Date: Wed, 15 Oct 2025 15:08:51 +0300
Message-ID: <20251015120851.2537-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
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

Fixed improper handling of error conditions when retrieving the
physical DMA address width from the device.
Currently, in case ena_com_get_dma_width() timeouts or retrieves invalid
value, it will go unnoticed and the flow will continue as usual using
error value as the dma width address.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 568aca1152..5147a754b2 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -1948,7 +1948,7 @@ static int ena_device_init(struct ena_adapter *adapter,
 {
 	struct ena_com_dev *ena_dev = &adapter->ena_dev;
 	uint32_t aenq_groups;
-	int rc;
+	int dma_width, rc;
 	bool readless_supported;
 
 	/* Initialize mmio registers */
@@ -1978,7 +1978,12 @@ static int ena_device_init(struct ena_adapter *adapter,
 		goto err_mmio_read_less;
 	}
 
-	ena_dev->dma_addr_bits = ena_com_get_dma_width(ena_dev);
+	dma_width = ena_com_get_dma_width(ena_dev);
+	if (unlikely(dma_width < 0)) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid dma width value %d", dma_width);
+		rc = dma_width;
+		goto err_mmio_read_less;
+	}
 
 	/* ENA device administration layer init */
 	rc = ena_com_admin_init(ena_dev, &aenq_handlers);
-- 
2.17.1

