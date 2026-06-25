Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E09CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2051940651;
	Thu, 25 Jun 2026 19:49:15 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 11CA5402D1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:49:13 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30c09f29b64so54567eec.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782409752;
 x=1783014552; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uF8gt5WTEsEiWNNxvomuFuukqfxnZWcKMsJyYrCLPkg=;
 b=ok+Qfu1WCMW3hGPyo+Sb+LSkgq3UyNM1AlUj+cehIdqJASRS7lGHtwe53EA3SvKU+e
 huD/eEiKoyUfYHaQbDgAqrsMDBTNkrNxMg/9nCx68+GtiBHIzN7c3BytLKl9B4baQlTE
 YFyInJj6A5PIwCrgFkM5gtr5xDpiFuA3RwdgisH/Cvxb4WjMRpKADIBKk1wne+IphZ9X
 OqmGOXj/2OfyHvfhqJ/WnCHs9rHMgt/cUXKSn2cwN7lWME16tVlXHVaIxXAD1GiLsl7H
 gmCtzqWhUdML7BGb/YizPkLUXnuDsVJTNL8UUI1WvjLSXcoJ+4W9NVyCIF+gB82CtmYx
 ONSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409752; x=1783014552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uF8gt5WTEsEiWNNxvomuFuukqfxnZWcKMsJyYrCLPkg=;
 b=PU3/7BODLycoXPpKShAPWSvpfM/lGOKSZrOhicg8mGMZUcKTb+jigpHJoI2cSb6Tbb
 6W44W6qAJYAxeMlusFt7ULUWMAxXBz3ArFSdb0FSbtlji4W0BhzcmDP32fkoVLhVzZF0
 CYJsA1ceZMmqeNK/5AIoO4dXj+17xCFKQ1+EyPVl9fBoniNnG9nnroQkwZzD/kx4yF5V
 gWxHug/bDMXXv8uQzrweNDJcdm2wk9htdu0dKWc5UL/eU1aXPBhPOaNu8XHpQvHV0xtS
 vtCb+ykCE87htzs4Im8+360hweNW13piC07BmPc8LIgLKfSaJzgCqZfAbcm/b3UQs1XQ
 0iYQ==
X-Gm-Message-State: AOJu0YxiPQ5Ki3w9gDxU6qLuQDZ+wmDWKNXW6S0Iz+hLsgJgObpTcP5L
 fcx4TSj6i4UrfxxMp0341AqqGuyknF7kq9OA8jDlRk3B/BYUgSL4KDv4CwZ8JCwaxqD5cg+7+T0
 joL6h
X-Gm-Gg: AfdE7cnBZkdUnGCnTaxFCUw/7SWwioqob/jyUxRbWbSSxXhVMIvg0auP6DR81OISINk
 U8MdIvIDbVAwohhVAk65ic6l2WzYBmheHXIMshS8Pt0T137WdFI6zrUj8XdL4lnOYRnKt2XibdA
 6nb5omTXcpJd3sXutGQyI7/RdVhry478/mkx44x0hxAjtd5zaVfv/8RvFSTWqkOIZW4Ig+Pq9CX
 lWhc841k8HgZlg8qbDC+8FwXfz9LCpt3V8RPFDLk1ZoE3EtIQFdR+GofXxz/7wjFB9pvrOeM5bw
 +guzXSsRjuA2ew1UZ6E2jryGbL5XJ7U9N7+k9FwH0U7g+b4gImIcuY5GxOmx9aIuL0Gl0R7bp8d
 92Ctz83NmqKBbK9evKW/RtMMUWRJRn3TwR0JTseqs8iuW8uulTivFKYOLHSn29IxYM5keGkilrx
 ayiM51jFSzs8Lbm9N2HsZiXtqURGLL6dvUNVEJYgwrZXSyxZ62DUQ=
X-Received: by 2002:a05:7300:8cab:b0:30c:a0f:3bd0 with SMTP id
 5a478bee46e88-30c85aec166mr3028977eec.13.1782409752110; 
 Thu, 25 Jun 2026 10:49:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca240sm10594472eec.4.2026.06.25.10.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:49:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, ndabilpuram@marvell.com,
 stable@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v3 1/6] examples/l3fwd-graph: remove redundant Tx queue limit
Date: Thu, 25 Jun 2026 10:46:51 -0700
Message-ID: <20260625174908.278408-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625174908.278408-1-stephen@networkplumber.org>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <20260625174908.278408-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>

In `l3fwd-graph` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
introduced an artificial constraint on the number of Tx queues
and limited core-scaling performance.

This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
redundant Tx queue check, allowing Tx queues to scale directly
with the no. of lcores.

Fixes: 08bd1a174461 ("examples/l3fwd-graph: add graph-based l3fwd skeleton")
Cc: ndabilpuram@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/l3fwd-graph/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 01c65b0abd..5f89286dce 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -49,7 +49,6 @@
 #define RX_DESC_DEFAULT 1024
 #define TX_DESC_DEFAULT 1024
 
-#define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
 #define MAX_RX_QUEUE_PER_PORT 128
 
 #define MAX_RX_QUEUE_PER_LCORE 16
@@ -1076,8 +1075,6 @@ main(int argc, char **argv)
 
 		nb_rx_queue = get_port_n_rx_queues(portid);
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 		printf("Creating queues: nb_rxq=%d nb_txq=%u... ",
 		       nb_rx_queue, n_tx_queue);
 
-- 
2.53.0

