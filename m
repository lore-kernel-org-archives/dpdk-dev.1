Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BE606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=hEJ+eq6/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78555402E4;
	Tue, 17 Nov 2026 07:45:30 +0100 (CET)
Received: from lf-2-45.ptr.blmpb.com (lf-2-45.ptr.blmpb.com [101.36.218.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 9ADF040294
 for <dev@dpdk.org>; Tue, 17 Nov 2026 07:45:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794897918; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cv/b0xJU4Mgx9YEILjwqmMYGMqpak0Hw9RmdOhqmuZc=;
 b=hEJ+eq6/Gl3j77e0P8QK/rrYsN4mnIVFj7hGkzkvZ6F79bZx6CqIhthHo4hhGlBMEHUy85
 hJyOBiAeMZVFvAWUYFlLJucG23HDmskLMLTR9lq6YwyP4qrYFKUVKyaZxdIBPiY1dYMr4y
 jjri9TvmSzgzNn5+PdUtn2UMkNk/+FdiYjRho96mQqiNRCFoodwjtbaFYhNErnIE6ZPsMk
 9NT8I1miSE/Erm9VU/ucUshAEob3Nyon7FvWyKZTZz18bvPsMcrwevsdLzav57zAkdINzh
 rzch7BIaIKBhtomYn7NoCvJuEP8S8MBuKrfHBhc9cS3cqeNRsfLNtAZtZH7KfA==
Subject: [PATCH v3 0/3] net/xsc: fix issues reported by GCC analyzer
Date: Tue, 17 Nov 2026 14:45:14 +0800
Message-Id: <1794897914.9800@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26afbf7fc+e6b47c+dpdk.org+wanry@yunsilicon.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Received: from [10.211.5.164] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS;
 Tue, 17 Nov 2026 14:45:15 +0800
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
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

 drivers/net/xsc/xsc_dev.c    | 12 ++++++--
 drivers/net/xsc/xsc_dev.h    |  4 +--
 drivers/net/xsc/xsc_ethdev.c |  6 ++++
 drivers/net/xsc/xsc_rx.c     | 53 ++++++++++++++++++++----------------
 4 files changed, 47 insertions(+), 28 deletions(-)
