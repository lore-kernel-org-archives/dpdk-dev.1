Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87854606A323
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=I0Ja/N4t
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB7CF40609;
	Fri, 13 Nov 2026 04:10:42 +0100 (CET)
Received: from lf-2-32.ptr.blmpb.com (lf-2-32.ptr.blmpb.com [101.36.218.32])
 by mails.dpdk.org (Postfix) with ESMTPS id 24337402C4
 for <dev@dpdk.org>; Fri, 13 Nov 2026 04:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794539432; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=WfkngP2DFF5mxO8jhgM6mUjDVWyWsOmJQVxm7wVNu5o=;
 b=I0Ja/N4tW3DueNWf1bDlfUgdG79HeNsHYwTHkz2sCxcJgiAOx5d0MFrBMrTc8ObdvyM0pM
 +69hg5Gkg9rhalyhiDm7mdXTfrhHPRc50b/c4SPRThwob+xza7dHIxFr+KtaGdDb00uZCC
 AQt1M6Al22Ery78AVQYoiD+YwD65S30MozbQ3kEhc+7jRaPfsZFfVpBsXB0bIHV7glRUl3
 830XjaLdiiwvD9HwKQDYDxBqYvpHwTg+AGnxH5TXDx0xEtz5mGFfc8JJ18RueKAMTuJ3sF
 8Hmqp55q65ojBdPk9slGoeAIK9LGdPPKfG9+ItTCm1/3RjyFK1rUGrXmGWu4Ag==
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: <dev@dpdk.org>
Message-Id: <179453942560.1554.11439899391590171416@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
Subject: [PATCH 0/2] net/xsc: fix two issues reported by GCC analyzer
Date: Fri, 13 Nov 2026 11:10:25 +0800
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Received: from [127.0.0.1] ([14.103.216.154]) by smtp.feishu.cn with ESMTPS;
 Fri, 13 Nov 2026 11:10:27 +0800
X-Lms-Return-Path: <lba+26af67fa5+8187b1+dpdk.org+wanry@yunsilicon.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>From 0fe3f49419330852df7d2a82fcf179fa6f80a9a0 Mon Sep 17 00:00:00 2001
From: Renyong Wan <wanry@yunsilicon.com>
Date: Fri, 13 Nov 2026 10:44:51 +0800
Subject: [PATCH 0/2] net/xsc: fix two issues reported by GCC analyzer

Two fixes for net/xsc coming out of the GCC -fanalyzer report.

45: when rte_malloc_virt2iova() fails, the jumbo buffer is leaked and
RTE_BAD_IOVA ends up in the WQE.

46: xsc_dev_init() leaks a structure on the dev_ops failure path, and
the Tx queue allocation is dereferenced without a NULL check.

The two patches are independent.

Renyong Wan (2):
  net/xsc: fix jumbo buffer on IOVA conversion failure
  net/xsc: fix leak and missing NULL check

 drivers/net/xsc/xsc_dev.c    | 1 +
 drivers/net/xsc/xsc_ethdev.c | 6 ++++++
 drivers/net/xsc/xsc_rx.c     | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)
