Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA06FC54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:27:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BE8D4066E;
	Thu, 22 May 2025 15:26:57 +0200 (CEST)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com
 [207.171.188.204])
 by mails.dpdk.org (Postfix) with ESMTP id DE89C402E5
 for <dev@dpdk.org>; Thu, 22 May 2025 15:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747920414; x=1779456414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=mjViE5GihM/7hPFITPO6iPt4X7jcaYJLZw737c3eB+M=;
 b=IFCfsPQD+SpFlsw7IGxHVN2Sa95BPQUfzObPvSy1mCPsfWPtHeki1v42
 fKkS5pPmDy2kolp7NPXFefeWmdDz2/ZnogXdzJPlc2FNIcRB78OLP+nwG
 rqOUxqtYPZzzSLxRHk4mgcfR5RH6PnEhEZOgqEwkz/2rU3UMI21Kuv2on
 N2p6YsvTDgkgknWCt6en3iX+LevHvnX6BeOAsXIebIudKJV+Vhw2bQwi2
 z8WD6gTBf8u0f5m6FGMKZeIJkL5TfHlfQGCrvHd1aRZLymp191tmhl+Vk
 5raqlyrdnrcv55TMS75flx6zS7hFnbZFMYHd7WpmBMMuPrzoD8hC1k8w9 A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="22706338"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:26:53 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:21935]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.182:2525]
 with esmtp (Farcaster)
 id 13ee592d-de8b-4bc0-a963-1ce90cf35098; Thu, 22 May 2025 13:26:51 +0000 (UTC)
X-Farcaster-Flow-ID: 13ee592d-de8b-4bc0-a963-1ce90cf35098
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:26:51 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:26:49 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 1/7] net/ena/base: avoid recalculating desc per entry
Date: Thu, 22 May 2025 16:26:08 +0300
Message-ID: <20250522132614.3379-2-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250522132614.3379-1-shaibran@amazon.com>
References: <20250522132614.3379-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
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

