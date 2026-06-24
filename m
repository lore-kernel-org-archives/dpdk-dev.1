Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0449DCDE003
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 14:20:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB6FF40659;
	Wed, 24 Jun 2026 16:20:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 485DB402E7;
 Wed, 24 Jun 2026 16:20:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782310854; x=1813846854;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SWIN2aKG+vWfG7NtrtyfgcfxFYuxMPwyerOVGnjsgZc=;
 b=OlZ5/HAlAzDNEM6PKH8xsZtzfr6ktle7y1mkgES5Dufjr0JY4jW4Aw6y
 OQ+xgovaly28hyyciWOpwNSMkppKRIqNUYs+3aoLC/qRW8alnJXkKVxWh
 6qzKySv/1luWaC4G+fmuAaMZUVGht3odVmDvYcjkpqNtdFrwR94uRunBa
 Qn+reu2di56Pn2TC86cCFn9wlO1wOEvoD67ChOJRsFd7FMduZFp7Cnq8Z
 OAcUHP3JKUR6THnyWck/q1FjqissEI7XZbKMlSlI6JsTlVptQgM2Tv/qo
 j1Dts5UbbAzCGtYtHGTTJPyD6T5NKoy3/46zQgwcw6GanZDWpx612gmd4 g==;
X-CSE-ConnectionGUID: WyE4PvdcSR6amW1BmreVwg==
X-CSE-MsgGUID: x5BwRq/RSEKg6YMcMSnZUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94565832"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="94565832"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 07:20:51 -0700
X-CSE-ConnectionGUID: UEnCNZmlSEGr8b3hzpOrYA==
X-CSE-MsgGUID: EEfKpTx7RoCQOsL07YbDtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="247507923"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa008.fm.intel.com with ESMTP; 24 Jun 2026 07:20:49 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH] vhost/crypto: fix segfault
Date: Wed, 24 Jun 2026 14:20:23 +0000
Message-ID: <20260624142023.1525497-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

Fix potential call with dev->mem uninitialized, one common usecase
example being running the autotest with more than one device.

Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 lib/vhost/vhost_crypto.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 648e2d731b..3679eaca1e 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1512,6 +1512,10 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 		VC_LOG_ERR("Invalid descriptor");
 		return -1;
 	}
+	if (unlikely((vc_req->dev->mem) == NULL)) {
+		VC_LOG_ERR("Uninitialized vhost device");
+		return -1;
+	}
 
 	dlen = head->len;
 	src_desc = IOVA_TO_VVA(struct vring_desc *, vc_req->dev, vq,
-- 
2.52.0

