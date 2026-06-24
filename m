Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB6CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD0BB40A6F;
	Wed, 24 Jun 2026 12:37:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 40F3340A6B;
 Wed, 24 Jun 2026 12:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297446; x=1813833446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=08CA6v/v1i70BFMvlnzUjeiVu6HwnZeYqzNgSFHBEO0=;
 b=TLNm/DLjRR16oMW0MUd6yv0dS2/6ceMvbDxrVU5hgJ3KqW4bvhIu2Kiw
 U5RJkPRdj+x8qlhRr4gwUXtHcFT6VGvWndDob6JJgj+UJ/DZMlP79C5hJ
 bnBq9St5tYxhwJDeG+Qah7+PtBChuk2sVBDUHyLUAowSabjX3NtCCSObP
 2lRrZTKNfqVxEP41LqxzLPRsq4e2yF157/vqYgDBNTVdmv+85CRLOffOX
 qFW8SivjnAJEs5rm06Df5Vrr1j3NVjfCVA3NxC14j2p9IBW9LkazP6LkQ
 HV5+lcx6s1uYRapwnl5vot3ybmpaqtzKSFSzYscYvdjqTNCQKk3xY+9vW A==;
X-CSE-ConnectionGUID: JCvDbZfqR5mBFeuzDiAmxA==
X-CSE-MsgGUID: IkFb8wzDRxKBVjvWu7nKGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652376"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652376"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:25 -0700
X-CSE-ConnectionGUID: EgwQTVmZRBCHUdeTU828zw==
X-CSE-MsgGUID: 9yzBI2aqTPyohKn8/ogZoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460125"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chaoyong He <chaoyong.he@corigine.com>,
 Alejandro Lucero <alejandro.lucero@netronome.com>
Subject: [PATCH v2 13/17] net/nfp: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:52 +0100
Message-ID: <20260624103658.792750-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: c7e9729da6b5 ("net/nfp: support CPP")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/nfp/nfpcore/nfp_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/nfp/nfpcore/nfp_resource.c b/drivers/net/nfp/nfpcore/nfp_resource.c
index 6437a78852..781350c46f 100644
--- a/drivers/net/nfp/nfpcore/nfp_resource.c
+++ b/drivers/net/nfp/nfpcore/nfp_resource.c
@@ -168,7 +168,7 @@ nfp_resource_acquire(struct nfp_cpp *cpp,
 
 	memset(res, 0, sizeof(*res));
 
-	strncpy(res->name, name, NFP_RESOURCE_ENTRY_NAME_SZ);
+	strlcpy(res->name, name, sizeof(res->name));
 
 	dev_mutex = nfp_cpp_mutex_alloc(cpp, NFP_RESOURCE_TBL_TARGET,
 			NFP_RESOURCE_TBL_BASE, NFP_RESOURCE_TBL_KEY);
-- 
2.53.0

