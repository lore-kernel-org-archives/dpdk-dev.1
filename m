Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9DACDB479
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E12A04065B;
	Tue, 23 Jun 2026 18:52:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 119FB4065B;
 Tue, 23 Jun 2026 18:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233540; x=1813769540;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=08CA6v/v1i70BFMvlnzUjeiVu6HwnZeYqzNgSFHBEO0=;
 b=MvFsprzh26wdaa3zO2OiMLwEQ5nENB0XJ9hM5iSZELElfSd2LDW4oZw7
 Ga26t2I3nAHYV7oxw9bUuMMoa9WyMPO1NbgTHkoF7biuLrzQQXNx+rObU
 RSl7cmFpGBgnGeASJH3wCtwHwTHAISiqhksf6gQ9tyAn3lDRf/TCdNRt+
 qVuqvh2bAgv2VHENLLtxTDwdJ0TtZsRG7S6euXqDZt1/IJrqHanCWuy5T
 Ebl0v8KHcXGmTDb/NGdBTfGZs88QJX3ouleVKXZqjqnJRyespbak37eBF
 qs+HblT80JgKCMVqVunMIO1Kw++oxgAQlGWLVxVn8yL8MSMnPVR60s2iA Q==;
X-CSE-ConnectionGUID: WUKP6/dARJqg4KzpcIZbgQ==
X-CSE-MsgGUID: PdlbeSbEQoiVqTK1GUEX7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534672"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534672"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:19 -0700
X-CSE-ConnectionGUID: 9TooCyiVRJ+0KHEpO0cTsw==
X-CSE-MsgGUID: WTzr8M9KTiGOJQePqxD+5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928374"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chaoyong He <chaoyong.he@corigine.com>,
 Alejandro Lucero <alejandro.lucero@netronome.com>
Subject: [PATCH 13/17] net/nfp: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:43 +0100
Message-ID: <20260623165150.765443-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

