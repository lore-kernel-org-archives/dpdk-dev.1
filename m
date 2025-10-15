Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D37CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:11:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA5364067D;
	Wed, 15 Oct 2025 09:11:14 +0200 (CEST)
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.34.181.151]) by mails.dpdk.org (Postfix) with ESMTP id 2876140678
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512273; x=1792048273;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=M8s2033FRZI8f4ElHBGeYuOVnIce7a1ZB+cJGfuKJpo=;
 b=LkAyZ9if/ZyCr4ds5Iv077zDFhIgKlESOb7RRhBRtSzCQjDoPdKHVxPo
 LpWsgxG6p68oDxte7NWW976u6tjdFNROEOFLaY3jYnF5PzAUN+/sVzybD
 e07BeGaS2UYr6P1mYOyEzp3eqDypfcDVoer4b8RwI4idiwQvnfO7A2HW+
 zsIR9xtTgTem11DGBIlk1IqKCGu20tBZyYzDdUbUUErBquos2cZcoWsGK
 MLsv1FgP+6sV/TFX59stf0YCwDj2n6aeGjXV7chX+DEP1ZVpcRoS/ffEl
 6pch6OsLnjY2Jv9Gj/tPBGOAmeDAXWOBr5uo0qoGlXzHDybhjwReKj3+G Q==;
X-CSE-ConnectionGUID: MS9lhcSOTzeUiMCB4CazNQ==
X-CSE-MsgGUID: NYgKPY22RsiiYHcXJMaatg==
X-IronPort-AV: E=Sophos;i="6.18,263,1751241600"; 
   d="scan'208";a="4917138"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:11:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:8885]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.171:2525]
 with esmtp (Farcaster)
 id a7df8fae-9602-4a9c-af66-887286d60c65; Wed, 15 Oct 2025 07:11:12 +0000 (UTC)
X-Farcaster-Flow-ID: a7df8fae-9602-4a9c-af66-887286d60c65
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:11:11 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:11:10 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH 09/21] net/ena: add verification of DMA address width
Date: Wed, 15 Oct 2025 10:10:59 +0300
Message-ID: <20251015071059.651-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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

