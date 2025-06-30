Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4407C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 13:29:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08FA94067D;
	Mon, 30 Jun 2025 15:29:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4FF6140687
 for <dev@dpdk.org>; Mon, 30 Jun 2025 15:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751290162; x=1782826162;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Aq764giFFaqETaM1SSRNIwBrEXfYiUoXB5JmSr0Eou0=;
 b=Y5M5CIcEtEdlFjuyhDqGngIU8fzCR/5WRc5QDFJFLyCMhRk77H17uB3e
 3udDM8/uD/XQ/3VxGpG5WJxQYXvQ8cJUPM4GHYfyV5JtyR1WlphgnQmB7
 s/fNwycG8yZkqZeUHhz+WVZoGYzsK8Asq09052lWeaMbY/AqLDDiyFTXp
 qHc2mX0KyUkRwuGfHNsTTrx8EWruBoYn7yL22YP9zpiC1SeVbUaRfnCER
 nMdgMb6yKB19bzRHfJEymtTLGCylpienIAV1juMP4VM0bvGDkuQuPvVos
 u3Ytz3bOnmWGGLecQLcmf8FA51vLL1jimXjQjoJ6mLBCbRAvmdcl1Xzu0 A==;
X-CSE-ConnectionGUID: p7eteKzKTzKHeSZFNNiiuQ==
X-CSE-MsgGUID: mYclgPWvR9ODKFMihDZvaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64113112"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="64113112"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 06:29:22 -0700
X-CSE-ConnectionGUID: jLA1MXm3SqCRzMwE+jUJTQ==
X-CSE-MsgGUID: jCbrUyqiQb2i7TXEApFmpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="153764372"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2025 06:29:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 25.11 2/3] vhost: : remove fallbacks for old Linux versions
Date: Mon, 30 Jun 2025 13:29:03 +0000
Message-ID: <20250630132904.1704901-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250630132904.1704901-1-bruce.richardson@intel.com>
References: <20250630132904.1704901-1-bruce.richardson@intel.com>
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

All supported linux versions support F_ADD_SEALS (Linux 3.17+) and
MFD_HUGETLB (Linux 4.14+), so no need to have #ifdefs and fallbacks to
support systems which do not support those features.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/vhost/vhost_user.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index b73dec6a22..4bfb13fb98 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -36,10 +36,7 @@
 #ifdef RTE_LIBRTE_VHOST_POSTCOPY
 #include <linux/userfaultfd.h>
 #endif
-#ifdef F_ADD_SEALS /* if file sealing is supported, so is memfd */
 #include <linux/memfd.h>
-#define MEMFD_SUPPORTED
-#endif
 
 #include <eal_export.h>
 #include <rte_common.h>
@@ -1627,11 +1624,7 @@ inflight_mem_alloc(struct virtio_net *dev, const char *name, size_t size, int *f
 	char fname[20] = "/tmp/memfd-XXXXXX";
 
 	*fd = -1;
-#ifdef MEMFD_SUPPORTED
 	mfd = memfd_create(name, MFD_CLOEXEC);
-#else
-	RTE_SET_USED(name);
-#endif
 	if (mfd == -1) {
 		mfd = mkstemp(fname);
 		if (mfd == -1) {
-- 
2.48.1

