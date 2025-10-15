Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23434CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:10:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C9DE410FA;
	Wed, 15 Oct 2025 14:10:17 +0200 (CEST)
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
 by mails.dpdk.org (Postfix) with ESMTP id CB35B410FA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530216; x=1792066216;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=+Rb3HLX3nB1TJcIjaENZVKURN5udSOyiB/yyKPaVvh8=;
 b=j/NgSpGqAMqfOwpl3S5YZMxxsSI2ba56qAsurzYszx5zDKB6+/aVNyGK
 crN8cPf11i1BXpoK5T3YUM4p0G29c4tZCpO5QGBaXIMNLz3YBbt+lcY4f
 mFNqahIUcA11NPW9Jeafed/rmweEuKFBX693eO27vJXcnAFzW90pv+T3N
 tZkUIMS/KGWfhx6aEqYZkhNAH5xUXrbgX8EuBBpDlke4MEdbMQoPE4N9p
 el/LrIVVcWQ/UuO2yPD4b5CIZQ62sC3B+7hXi5xn6xGh9vx/aWelXeOtT
 VaZ2UUvPLGB5pyglHlFbkTZmEFg/Sd748zqOsx3fDR5uvKK2cuQVBPl/P A==;
X-CSE-ConnectionGUID: qmzCpGfmT7m6yBwlqGtGiA==
X-CSE-MsgGUID: Z2AxtFBrQW2n5Vatt4rBOA==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4928784"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:10:13 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:18564]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.42:2525]
 with esmtp (Farcaster)
 id 63f61bca-2350-4ae5-9f58-a39fe7606430; Wed, 15 Oct 2025 12:10:13 +0000 (UTC)
X-Farcaster-Flow-ID: 63f61bca-2350-4ae5-9f58-a39fe7606430
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:10:13 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:10:11 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH v2 11/20] net/ena/base: rework log format
Date: Wed, 15 Oct 2025 15:09:59 +0300
Message-ID: <20251015120959.2730-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
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

align hal log format to the driver log format.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_plat_dpdk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index 3b574f888a..c84420de22 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -110,7 +110,7 @@ extern int ena_logtype_com;
 	(								       \
 		ENA_TOUCH(dev),						       \
 		rte_log(RTE_LOG_ ## level, ena_logtype_com,		       \
-			"[ENA_COM: %s]" fmt, __func__, ##__VA_ARGS__)	       \
+			"ENA_COM: %s():" fmt, __func__, ##__VA_ARGS__)	       \
 	)
 
 #if (defined RTE_ETHDEV_DEBUG_TX) || (defined RTE_ETHDEV_DEBUG_RX)
-- 
2.17.1

