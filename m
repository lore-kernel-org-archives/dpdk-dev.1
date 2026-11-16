Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2ED606A329
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=ewO26/Tg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D67CB40150;
	Mon, 16 Nov 2026 07:58:59 +0100 (CET)
Received: from lf-1-37.ptr.blmpb.com (lf-1-37.ptr.blmpb.com [103.149.242.37])
 by mails.dpdk.org (Postfix) with ESMTPS id 6698C400EF
 for <dev@dpdk.org>; Mon, 16 Nov 2026 07:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794812331; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=jkvuyTwddtF8rxw7GpOi1neK3KRXqs0t4dGTRK3tm2s=;
 b=ewO26/TgIcRWx+8jhTYywrFWkCtbG28a6Pry6gUU7A2kyjkgKcHzMpfHkfFmDqDkQmH7xq
 inMkAI7DkE66Apv7Xk7ksLoeqXY2ITGN0AXIWlehpzwQmCz+q8W8SMuClbC+Qp01TiwIYq
 WgbvFEUPxqMldjbff39ZE7b8NR3XyUZwHQwTO3JLuaAGpRrHNI+EBGe4fT7WK7yoTYm6Zs
 rxNkVI+Vrvh95W2fKi4grVy4sCpJy+eyHOrkt1MPa7feg50uMcTF1yyk0gcPF3MgjEZTQ3
 ymboKBoCbePdkTIVhfq8mEt1Ue30GeKmhvVSa66hcDZbFIVG9ClgA2e6BRKBBw==
Received: from [127.0.0.1] ([14.103.216.154]) by smtp.feishu.cn with ESMTPS;
 Mon, 16 Nov 2026 14:58:48 +0800
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26afaa9a9+b2d0b3+dpdk.org+wanry@yunsilicon.com>
Cc: <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
Message-Id: <179481232343.1639.15317349483624427514@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Date: Mon, 16 Nov 2026 06:58:43 -0000
To: <dev@dpdk.org>
Subject: [PATCH v2 0/3] net/xsc: fix issues reported by GCC analyzer
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2 addresses the issues raised in the AI review of v1:
- allocate the jumbo buffer once per device, fail the queue setup when
  there is no IOVA, and free it on device close
- fix the leak in xsc_dev_init() and the unchecked rte_malloc_socket()
- rename the jumbo buffer fields, they held the opposite of what their
  names say

Renyong Wan (3):
  net/xsc: fix jumbo buffer allocation and leak
  net/xsc: fix leak and missing null check
  net/xsc: rename jumbo buffer fields

 drivers/net/xsc/xsc_dev.c    |  2 ++
 drivers/net/xsc/xsc_dev.h    |  4 +--
 drivers/net/xsc/xsc_ethdev.c |  6 ++++
 drivers/net/xsc/xsc_rx.c     | 53 ++++++++++++++++++++----------------
 4 files changed, 39 insertions(+), 26 deletions(-)
