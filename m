Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F98C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B91D42C24;
	Wed, 21 May 2025 16:02:45 +0200 (CEST)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com
 [99.78.197.218]) by mails.dpdk.org (Postfix) with ESMTP id 58389427E7
 for <dev@dpdk.org>; Wed, 21 May 2025 16:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747836164; x=1779372164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=mjViE5GihM/7hPFITPO6iPt4X7jcaYJLZw737c3eB+M=;
 b=ZBUKJ3QGmw1yCOd7wxuym9BmwX/f8m9ZfztmKC7ZZcqt9XPL9sx3CNW3
 OlqXtWwHP9MUegGWdGW1gbutH93Hz7fwIfC0lis5QahI40hbhVRZy/k6u
 JPp5r99YbTi5880TkAGxtzfOI7iFBF+5cHCtfnt1kE2cJ25a3T4dUcWtK
 7qEkPYH6K5nBt7HMpPjfJBRllsCSx72dBohaD/qx2GrQ/tLIUH7nnKDNE
 +dWk27JFvcEsDUpeh9c9DsgQqwfeAHITYIwYAoZ7suzZp6dcOVeVU9d4S
 vl97yr3Pfzk4oW4NXUruPsY5osQ9MK4gH1B60muy3PvPNXy0mWsCE0zV0 g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; d="scan'208";a="407705929"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:02:39 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:13531]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.44:2525]
 with esmtp (Farcaster)
 id 04d1f61f-fd29-4330-8b55-0dae2cb08ced; Wed, 21 May 2025 14:02:37 +0000 (UTC)
X-Farcaster-Flow-ID: 04d1f61f-fd29-4330-8b55-0dae2cb08ced
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:02:37 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.30) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:02:35 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 1/8] net/ena/base: avoid recalculating desc per entry
Date: Wed, 21 May 2025 17:02:06 +0300
Message-ID: <20250521140213.2576-2-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250521140213.2576-1-shaibran@amazon.com>
References: <20250521140213.2576-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.30]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
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

