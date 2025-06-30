Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C640BC8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:14:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1FBC40651;
	Mon, 30 Jun 2025 13:14:37 +0200 (CEST)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com
 [99.78.197.217]) by mails.dpdk.org (Postfix) with ESMTP id 5C3054025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751282075; x=1782818075;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=mjViE5GihM/7hPFITPO6iPt4X7jcaYJLZw737c3eB+M=;
 b=Ihk68betyswHJLfR8Vp29pi0z8gDrthqFIRP4feNNDN0xx7QF94yzZI8
 c1AsLNt6bZJomSydABbZD//Ge429dSreI08RAFtkHNxsILbZEL7VylmDw
 WZK1IzCsHiF+mcw/XfQCSA3dN5g6+7vg2Hsi0tbWPDIAbDl6NhsDuedaF
 lB5Apf+v4671Kg/cqCoiRQtv1XCg5isZl4PBNyOYlScxLtOUSR3eyjwqM
 j5nhn2YB2W9kNcyG/+esWScd1ZsgeaslspjmTBZtiL4SRECyEYlTJBJpk
 0XPdFrITDO78LuAxiP50AyCZ//Z0YIIy83gv3ONt+RCe7mA7aGRhEcsrg g==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="65540591"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:14:34 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:2561]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.108:2525]
 with esmtp (Farcaster)
 id c465ad20-e59e-46af-8087-782bbb8a9af1; Mon, 30 Jun 2025 11:14:32 +0000 (UTC)
X-Farcaster-Flow-ID: c465ad20-e59e-46af-8087-782bbb8a9af1
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:31 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:29 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 1/7] net/ena/base: avoid recalculating desc per entry
Date: Mon, 30 Jun 2025 14:13:52 +0300
Message-ID: <20250630111358.3476-2-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250630111358.3476-1-shaibran@amazon.com>
References: <20250630111358.3476-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

desc_per_entry is precomputed in ena_com_config_llq_info() using
desc_stride_ctrl and desc_list_entry_size, which remain unchanged after
device negotiation. Reuse the existing value instead of recalculating it
in the fast path.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index 90dd85c7ff..c6668238e5 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -248,11 +248,7 @@ static int ena_com_sq_update_llq_tail(struct ena_com_io_sq *io_sq)
 		       0x0, llq_info->desc_list_entry_size);
 
 		pkt_ctrl->idx = 0;
-		if (unlikely(llq_info->desc_stride_ctrl == ENA_ADMIN_SINGLE_DESC_PER_ENTRY))
-			pkt_ctrl->descs_left_in_line = 1;
-		else
-			pkt_ctrl->descs_left_in_line =
-			llq_info->desc_list_entry_size / io_sq->desc_entry_size;
+		pkt_ctrl->descs_left_in_line = llq_info->descs_per_entry;
 	}
 
 	return ENA_COM_OK;
-- 
2.17.1

