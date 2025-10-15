Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B97CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7520406BB;
	Wed, 15 Oct 2025 09:16:20 +0200 (CEST)
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [50.112.246.219])
 by mails.dpdk.org (Postfix) with ESMTP id 553F240A4B
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:16:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512579; x=1792048579;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=koMGowxBW5qn+i44PZw/BQ37LgqmKd7cgNBEPF93P+U=;
 b=XcQncig81/pJklbo1Gq1oPnLeGCqWZCAzZPaie8xBYSvJ5y2jr7iJMIe
 8kz2SZVZCgLIDJuMdhk35guc82KPAWPLiH2wMXMRX9ypncx/JPAsSZafM
 4OXxkl/SU8OErpmPKHjKJR4+C4Zv5Kg3wI9Wc9p2I382tuffgRLqm5nGH
 /lKwQGFFGojgugueq/jQtPvqRTG3NXqrRDJyzH5HyumV6NNCp9RO5w+z4
 h96f71m2N7ErvlaAstJ+IHZEoTckfjw+GkFLPiup7Mu5KFmW9Z2ds/bDd
 QLtdHKcvuxq34b12WZ2gAlR6qSZbep/R/890KnbuWENrS/hrBoMOYKn5y g==;
X-CSE-ConnectionGUID: R/BOWhnYSECIF1FVsrly2w==
X-CSE-MsgGUID: ElimQCUERmORHUpf0vq2dg==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4716409"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:16:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:21569]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.225:2525]
 with esmtp (Farcaster)
 id 381d914e-172a-4b67-9986-23f70f6de089; Wed, 15 Oct 2025 07:16:16 +0000 (UTC)
X-Farcaster-Flow-ID: 381d914e-172a-4b67-9986-23f70f6de089
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:16:16 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:16:15 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 17/21] net/ena/base: remove redundant if sentence
Date: Wed, 15 Oct 2025 10:16:04 +0300
Message-ID: <20251015071604.1090-1-shaibran@amazon.com>
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

The driver supports only host/device IO queue modes
making the if sentence redundant.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 7ce80bde37..b4437f532b 100644
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

