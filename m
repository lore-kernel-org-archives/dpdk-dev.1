Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B53606A335
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=NEmi7GyL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D5874029E;
	Tue, 17 Nov 2026 12:14:34 +0100 (CET)
Received: from lf-2-14.ptr.blmpb.com (lf-2-14.ptr.blmpb.com [101.36.218.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 60E994026F
 for <dev@dpdk.org>; Tue, 17 Nov 2026 12:14:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794914064; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+/AVOE0jlmccjIT/723mzNxkku9ejvseGNgMs3+mDsE=;
 b=NEmi7GyL0bahQ1YAU2kxogp7Dz6ClDLVxnSWOeVJsHEHbMnZ/QfEk6e2bGpg7Osv9HXq91
 iBrCVjkWyqAyeDDRJOG+suueCWfXnMfdBLNJ/fvnXq1w6VVS7Rd7uIdUTDPE04YMVC23xs
 +LpDARH97lhOOcNNPDs9kQQT04GuXjRVZtaL4tNpxeQBAN5B6zrO0X9lKrTV3uqcPfFO9F
 TjToLjo/Ogt7FLNzlhlY+AxMHFffcb/DDD+p0eImBq4uxzA9b1mA/sHh52bH4hwPS/TiVX
 WcZacZCyfwSPy0QbMn44SQE2D4tRZhqr+qmvEnxQwH0FlPxXIFx8WpbiEWukVw==
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH v4 0/3] net/xsc: fix issues reported by GCC analyzer
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
Received: from [10.211.5.164] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS;
 Tue, 17 Nov 2026 19:14:21 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: <dev@dpdk.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1794914060.606144@yunsilicon.com>
X-Lms-Return-Path: <lba+26afc370e+b6fda4+dpdk.org+wanry@yunsilicon.com>
Date: Tue, 17 Nov 2026 19:14:20 +0800
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

v4:
- free the jumbo buffer only when the last representor stops the device, it
  is shared by every port and their Rx queues still point at it

v3:
- free the jumbo buffer in xsc_dev_close(), the device removal path does not
  go through xsc_dev_uninit()
- drop the redundant parentheses reported by checkpatch, no functional
  change

v2:
- address the AI review of v1: allocate the jumbo buffer once per device,
  fail the queue setup when there is no IOVA, and free it on device close
- fix the leak in xsc_dev_init() and the unchecked rte_malloc_socket()
- rename the jumbo buffer fields, they held the opposite of what their
  names say

Renyong Wan (3):
  net/xsc: fix jumbo buffer allocation and leak
  net/xsc: fix leak and missing null check
  net/xsc: rename jumbo buffer fields

 drivers/net/xsc/xsc_dev.c    | 17 ++++++++++--
 drivers/net/xsc/xsc_dev.h    |  4 +--
 drivers/net/xsc/xsc_ethdev.c |  6 ++++
 drivers/net/xsc/xsc_rx.c     | 53 ++++++++++++++++++++----------------
 4 files changed, 51 insertions(+), 29 deletions(-)
