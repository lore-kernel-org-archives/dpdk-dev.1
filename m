Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9863910AB82D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 00:19:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EFF742D55;
	Fri, 27 Mar 2026 01:19:30 +0100 (CET)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 62EF840151
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:19:29 +0100 (CET)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2b07bd30b5eso35468845ad.1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 17:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774570768; x=1775175568; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=GMyeBVJLOZwscFDPqpOeUoRdhwe6GGBroSD0llqNt94=;
 b=sJp2ZpKgN0Jd2tGJhQS4WoL8kbCT1CCv7z/Y1Bu4qG1iy2XJMuF87Ivm6eF2wLoGqI
 XItN/NLc1nihrvOFeSgw82BjY0condaL55RPW8ZqOKjnzhTeVTfZmv6y5SSXDaM4+sXo
 HkQ9Z/zvZkDevBAK5EmDnDhV6/jYrjNpQN4b8peSfliFaRC2mWDkKF2MDoV3fcCrPswE
 4F5zdgSYzV+3ajxkHzpVkpgmRV4GtolDLVAsDl07ixLW4E8EHl5VUF5dG8qfivgANQ6M
 F6azKMe5LinVHkns52QvvMjnuCmKkM/6IDpaigouqCSnOEci7ispi7GpVTdeWTikoS/b
 ZV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570768; x=1775175568;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GMyeBVJLOZwscFDPqpOeUoRdhwe6GGBroSD0llqNt94=;
 b=NE+G1jMZWm4KOkHY7DN10NaZVpUeh7kYi0j62kZrglrzUS2SVOE1k1vso+ODfTR6Ti
 uL+a1j7/TTEPlL/5gjcOfZh7NYoaXj8G7pMgkzmoyd7ts38YflNU7jYZWZroUgv2Ql2a
 KC1YAtao5e6Y3i8wHBfQfDJuyaDjYsCT9f30vP50IVLTBpmjrjasopKN/A0IH0VOU+05
 n7QicB1shBKltdvFvcJVl09DRhknNi7+2eosCOYGyVuOPTA6jLJ+mzn+BFxKiZk2h873
 7X49BxqGmYqkSCuURyYYDCQtvEmIECoBE11j4bDXFjai5tuXgu0DGIO4t44YhZe+r1in
 bnnA==
X-Gm-Message-State: AOJu0YxzE5ENSvSdhbF71vXw8+DzPevDI/fTsDIaW49gdWm1iIhvaLrF
 RyRHt38mdUwlUj68U3H3oMCfWYbm9b7qXaJkSd971TENP3/BrYoCgeBGn0JppqPKRQuCYQqDW3X
 vzDPg5iFsoTp6/BgADcgqwwsbvA==
X-Received: from plbkc15.prod.google.com ([2002:a17:903:33cf:b0:2b0:5538:b55b])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64e:b0:2b0:c2d9:2714 with SMTP id
 d9443c01a7336-2b0c481429emr34710345ad.4.1774570767901; 
 Thu, 26 Mar 2026 17:19:27 -0700 (PDT)
Date: Fri, 27 Mar 2026 00:18:24 +0000
In-Reply-To: <20260327001827.3385001-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260327001827.3385001-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260327001827.3385001-2-jtranoleary@google.com>
Subject: [PATCH 1/4] net/gve: fix comma operator compiler warning
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The gve_adminq_create_rx_queue function initialized the admin queue
command using commas rather than semicolons after two fields'
initializations in the GQI queue format branch. Change these commas
to semicolons to remove the warning.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 9a94591..bcfc789 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -721,9 +721,9 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 			GVE_RAW_ADDRESSING_QPL_ID : rxq->qpl->id;
 
 		cmd.create_rx_queue.rx_desc_ring_addr =
-			cpu_to_be64(rxq->mz->iova),
+			cpu_to_be64(rxq->mz->iova);
 		cmd.create_rx_queue.rx_data_ring_addr =
-			cpu_to_be64(rxq->data_mz->iova),
+			cpu_to_be64(rxq->data_mz->iova);
 		cmd.create_rx_queue.index = cpu_to_be32(queue_index);
 		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 		cmd.create_rx_queue.packet_buffer_size = cpu_to_be16(rxq->rx_buf_len);
-- 
2.53.0.1118.gaef5881109-goog

