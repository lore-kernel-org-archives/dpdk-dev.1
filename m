Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110D7C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:26:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DA5D40A77;
	Wed, 28 May 2025 12:26:04 +0200 (CEST)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com
 [52.119.213.154])
 by mails.dpdk.org (Postfix) with ESMTP id 7F67940279
 for <dev@dpdk.org>; Wed, 28 May 2025 12:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1748427962; x=1779963962;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=mjViE5GihM/7hPFITPO6iPt4X7jcaYJLZw737c3eB+M=;
 b=a32RmyacKaUzj7rgmIQ+ALkk4/3epqgVCjetQByzW02k572IZt3pnPHC
 9gxTAtgNKA6qpgzLqXDyQQBr9l6kPyAaqsoE0nTkqqxwUgbJoOYMt7QhA
 iNCUu/40XZ9z4h3rBPnzoeDBOEF7HFMRsiEi4U0JJm/RhSMrz2rPGGcmU
 rnIIc8IztBkeb7WC+qF2Z89tpz4ef0H886+1RSCbLDBZPMDo6HPiG0lCQ
 jJSMrSHn9ZO2R/5w30whXrH27w/715FBUmz+BxbCMmN7jr/XX0jmagTVG
 YQWxjS3ZSwRnm0v8+aeZw4aQvun4u7OqYK/piDnznAjWGsgvYkHvK8X7F Q==;
X-IronPort-AV: E=Sophos;i="6.15,320,1739836800"; d="scan'208";a="302405108"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:26:00 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:34740]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.243:2525]
 with esmtp (Farcaster)
 id 9cfe63e6-6931-4eb5-9677-28f04f30269f; Wed, 28 May 2025 10:25:58 +0000 (UTC)
X-Farcaster-Flow-ID: 9cfe63e6-6931-4eb5-9677-28f04f30269f
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:25:57 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:25:55 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v4 1/7] net/ena/base: avoid recalculating desc per entry
Date: Wed, 28 May 2025 13:25:25 +0300
Message-ID: <20250528102531.9876-2-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528102531.9876-1-shaibran@amazon.com>
References: <20250528102531.9876-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
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

