Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306ECCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91FAB40678;
	Wed, 15 Oct 2025 09:14:16 +0200 (CEST)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92]) by mails.dpdk.org (Postfix) with ESMTP id 11D17402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512455; x=1792048455;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=F7NKFlg5AsxMTFYb6oTfIoW7kKA/73WlhQjWBtkTt0I=;
 b=iDaDmlm4easa7q9S6HNOAwHkXzZFIqY4q/Y5NiIXj4fH8pahnO49/L0n
 T1iBIeTZaYugykrwrEjQQ1CcvsZd2SjvhT7VCMjHAPFZb3ZCSGizQszbx
 DcTIujPd42ZCWUeIvvHZzxvywpH/zLb84rVdiQ9I8ICA1B2AvSHcVOEK3
 48STB1QeHEKQKV1Dh4WPnvQwQK9MioUdu/xE9vIap0/880EvXNe2/AfsE
 hjUPcPOyA4KAiXssoaAc4/JNTBxx9Ic/94gPfbHK4VcB352IXyIQjwXr4
 ZX8TTv9N2gw8UEcsC6O3tGWZ8XkTue0AC0vWnlhPg9brKE6scBn0Xw4ST Q==;
X-CSE-ConnectionGUID: /OxOOjYISPaPr9+vUMWf+g==
X-CSE-MsgGUID: L81t9714QoaBcqDRIho2iw==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4918641"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:14:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:6388]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.225:2525]
 with esmtp (Farcaster)
 id 1a2cc830-d68d-41ff-ad5c-2343ccb4420d; Wed, 15 Oct 2025 07:14:14 +0000 (UTC)
X-Farcaster-Flow-ID: 1a2cc830-d68d-41ff-ad5c-2343ccb4420d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:14:13 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:14:12 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH 12/21] net/ena/base: rework log format
Date: Wed, 15 Oct 2025 10:14:01 +0300
Message-ID: <20251015071401.845-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
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
index 18c6837566..7923fbebf5 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -114,7 +114,7 @@ extern int ena_logtype_com;
 	(								       \
 		ENA_TOUCH(dev),						       \
 		rte_log(RTE_LOG_ ## level, ena_logtype_com,		       \
-			"[ENA_COM: %s]" fmt, __func__, ##__VA_ARGS__)	       \
+			"ENA_COM: %s():" fmt, __func__, ##__VA_ARGS__)	       \
 	)
 
 #if (defined RTE_ETHDEV_DEBUG_TX) || (defined RTE_ETHDEV_DEBUG_RX)
-- 
2.17.1

