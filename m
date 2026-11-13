Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22698606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=FOWWH55U
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7460742795;
	Fri, 13 Nov 2026 04:10:44 +0100 (CET)
Received: from lf-2-34.ptr.blmpb.com (lf-2-34.ptr.blmpb.com [101.36.218.34])
 by mails.dpdk.org (Postfix) with ESMTPS id 94055402C4
 for <dev@dpdk.org>; Fri, 13 Nov 2026 04:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794539436; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Z+Aasgfp05zxlipkMtYVYG32a5bNslD30WaPuuuyW8E=;
 b=FOWWH55Uw14sJ8E8YRM2yb+9e7PsL8s2pWxKvi7yroqGdyKyiVn4f6QbT4YqaDHcR9Q/7Y
 1SJw2QLx7psEwUzN46fgvFeQH33104X7cQsWokXHNBqXARteprByj3sB0PqV80w7jGjQPQ
 fr7oYNsmj9E4Ubop9b4z3kDcXmNB7NUMU9V6PUKZk/haUAIR0udEOZrHMtqd8Ie6Bepa47
 4Adxhp2BrRPBO0V5cAjK6JsWep919oEQigPs9nlgHas12e0NiM0U+ylSBbHtW+YAfmSw/y
 BxpoUolBK0cULBv3oha8cBkgcNecowkQorJeoJ95HwHBpVPHK+MXgpkifhUrew==
X-Lms-Return-Path: <lba+26af67fa8+51b0fe+dpdk.org+wanry@yunsilicon.com>
References: <179453942560.1554.11439899391590171416@yunsilicon.com>
Received: from [127.0.0.1] ([14.103.216.154]) by smtp.feishu.cn with ESMTPS;
 Fri, 13 Nov 2026 11:10:30 +0800
To: <dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <stable@dpdk.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1/2] net/xsc: fix jumbo buffer on IOVA conversion failure
Date: Fri, 13 Nov 2026 11:10:25 +0800
Message-Id: <179453942560.1554.5221755720671808072@yunsilicon.com>
In-Reply-To: <179453942560.1554.11439899391590171416@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>From c13caa60c5c285d775697e5564d9465b4a22b136 Mon Sep 17 00:00:00 2001
From: Renyong Wan <wanry@yunsilicon.com>
Date: Fri, 13 Nov 2026 10:44:50 +0800
Subject: [PATCH 1/2] net/xsc: fix jumbo buffer on IOVA conversion failure

When rte_malloc_virt2iova() fails, the buffer is leaked and the local
jumbo_buffer_va keeps RTE_BAD_IOVA. The next iterations skip the
allocation, as it is no longer NULL, and use that value as the address
of the second data segment.

Free the buffer and reset both variables.

Fixes: 0ff4b93c318f ("net/xsc: support device start")
Cc: stable@dpdk.org
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 13b2e269..3324b849 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -238,8 +238,11 @@ xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
 					jumbo_buffer_va =
 						(void *)rte_malloc_virt2iova(jumbo_buffer_pa);
 					if ((rte_iova_t)jumbo_buffer_va == RTE_BAD_IOVA) {
+						rte_free(jumbo_buffer_pa);
+						jumbo_buffer_pa = NULL;
+						jumbo_buffer_va = NULL;
 						seg->seg_len = XSC_MAX_RECV_LEN;
-						PMD_DRV_LOG(ERR, "Failed to turn jumbo_buffer");
+						PMD_DRV_LOG(ERR, "Failed to get IOVA of jumbo_buffer");
 						continue;
 					}
 				}
