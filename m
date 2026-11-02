Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94D606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HFunM33U
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F2DD40264;
	Mon,  2 Nov 2026 08:22:37 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 5554B40264
 for <dev@dpdk.org>; Mon,  2 Nov 2026 08:08:12 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so18855425e9.0
 for <dev@dpdk.org>; Sun, 01 Nov 2026 23:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793603292; x=1794208092; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QysZNpYABIhx7OcbY4j6j5dOrO3BoJKLAI62096K9Mo=;
 b=HFunM33Ux2xAFHRGyz7UTRowpYxivLhQVO0HsJjDE61lLwGUKj4Bg5rmfuw3K0/gvK
 1TVNu7vKeut0hq42W4fOObkBGusC3dOG21I6WKwdJX2tMGBU1Bt5scMqiZbWJhgW58xh
 gDKhsfeAzYenIwmpDQHv1g86nrwBVzwYB/qK/2O8c7oneQxy8KDYmcnkq8qcZR6HvriO
 XKx5UXpWfjwett3eEGPoFwyR3LRqR1usWHXnpzlgMNrr4CLE1qoswsGSnWYDVj3axhnP
 X9qkl43ZlEUNKX1eLbNZ6ncsb+QnZg0BicYPemHCHGcY6RZW5O/bM9tBtQcGGFd60dEE
 f+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793603292; x=1794208092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QysZNpYABIhx7OcbY4j6j5dOrO3BoJKLAI62096K9Mo=;
 b=mAT9kL7DlUl0V3Rdw7jIZ6JdVbP8cg00hILW8fUOc2BOgEoSCWywNQ43+pCatdOpUR
 dZTxUanDHJnjXYoo2a+dDkewjTim4sZjlcqtyo4eTwwXf4NNG810bE/oZXqeM1bTlWnn
 KE6ZB6BzGWvCr9ixsKRyKlEFJDE6r5dHmwdF0s/pNeGTCALaa32RMWh0X9Ph2QsCZuSI
 +Kjp7XMZCnIg+HHXU63bx40vqI2ST7joUNN6WPG5+9CIh77kIw5NQG39ARHyFI3C+KOx
 DtoGWg+kIoybLL455nSA2GjPkVC49+ukC3bIb6iQE6p+ZmIcDUDUM69+n+aolTC3rXtd
 FrzA==
X-Gm-Message-State: AFq9FYLEvdK1EdbfO6Q1iFbxy9EUiDFK2sTJJxCKGKt1ax8uaUKT3l9/
 0jJTqkS8QwnkU8I0p8VqTq+ssry+8qpFoiZGu2a1kSvn4u1iHwEHyvqU4PNbW+QBdO4=
X-Gm-Gg: AYBFou0evAq18p2jgrXeVz14PFmlcoVOHsaMDv8pSm278UkyxGlP/TFBFedslyzLf6i
 3aNCR7BXbjS1EhxuuhXA1I4I+1AzGvJ/BNeDeZ0SgjksWHrdGsi0ZE8CNMvwBTbLC9Y4KNVI6Nz
 zIOZSOoAbBX3+LjBamQc4I7xn/U1naOtawj7PTFSU7yR9wgu5Yd0ZLn/oEDaVVqX9xfocCnE40i
 9p6WILIAKHYzWd6QX3FMTFAr+HyzDLlpD+73uvXYysogzEJY1jnUIib6b5JVRgH9HQXBRa9PnjB
 TXKN3wbjvLBmKANHglqBWmovXUzmwdk49swrN9KjOJYEjVEBgYA8W6duWYdB830OyMXWC0MWRpm
 gNBgdVhzvUl2O19uZZvMdOuRUOCJuKgKREBl0bZBWH0siPvuBueTX4CTejABP89DZJiveWemPSX
 8l/4haUIWKn7cGXOc2oCAaHv4FUNcCJjKKxQHYkMw6vQtrO4yCeXUa18ygi33CDY5vqST6HXTlW
 8CaQtWxYxffxwj2SdFVPXvvdN632gx1KQphkK2cbTuaro3uOO0vq6W9YJe2i/cV6GgIt+vz3KhK
 jp9LylqI+2ePCaJjc8gnZlM42CszuvCRUYu05BiRidokgGh+N6N80rzQTd/XgpUDxnSExBaHgW7
 4YrKFHjWOANvufS627JFAZxeDknd3a6S45NfEqwBRtnOBR7rl+N7fgsriQyh4W3OBa1xc
X-Received: by 2002:a05:600c:4e08:b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4ac17287d04mr215647045e9.9.1793603291548; 
 Sun, 01 Nov 2026 23:08:11 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net
 ([131.189.143.225]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm339616535e9.9.2026.11.01.23.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 23:08:10 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: dev@dpdk.org
Cc: Wei Hu <weh@microsoft.com>, Long Li <longli@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH 1/2] net/mana: fix Rx interrupt vector beyond device count
Date: Mon,  2 Nov 2026 07:08:08 +0000
Message-ID: <20261102070809.813033-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:22:35 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With Rx interrupts enabled, the CQ of Rx queue i is created on
completion vector i. The device may expose fewer completion vectors
than Rx queues (the RHEL 8.10 mana_ib driver reports one), so
ibv_create_cq() fails with EINVAL for queue 1 and the port does not
start.

Spread the queues over the vectors the device has.

Fixes: afd5d170727e ("net/mana: support Rx interrupts")
Cc: stable@dpdk.org

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
Builds on main (meson -Dwerror=true, gcc 14, rdma-core 56).
In use on 26.07 on an Azure MANA VF.

 .mailmap              | 1 +
 drivers/net/mana/rx.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 08317e81e6..61d5c6df00 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1265,6 +1265,7 @@ Omkar Maslekar <omkar.maslekar@intel.com>
 Omri Mor <omrimor2@illinois.edu>
 Ophir Munk <ophirmu@nvidia.com> <ophirmu@mellanox.com>
 Or Ami <ora@mellanox.com>
+Orgad Shaneh <orgads@gmail.com>
 Ori Kam <orika@nvidia.com> <orika@mellanox.com>
 Ouyang Hao <ouyanghao@tencent.com>
 Owen Hilyard <ohilyard@iol.unh.edu>
diff --git a/drivers/net/mana/rx.c b/drivers/net/mana/rx.c
index 274c6e88ce..aa21136167 100644
--- a/drivers/net/mana/rx.c
+++ b/drivers/net/mana/rx.c
@@ -289,7 +289,8 @@ mana_start_rx_queues(struct rte_eth_dev *dev)
 
 		rxq->cq = ibv_create_cq(priv->ib_ctx, rxq->num_desc,
 					NULL, rxq->channel,
-					rxq->channel ? i : 0);
+					rxq->channel ?
+					i % priv->ib_ctx->num_comp_vectors : 0);
 		if (!rxq->cq) {
 			ret = -errno;
 			DRV_LOG(ERR, "failed to create rx cq queue %d", i);
-- 
2.53.0

