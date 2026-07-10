Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF52C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:34:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7808640B9F;
	Fri, 10 Jul 2026 12:34:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7BB4140A71;
 Fri, 10 Jul 2026 12:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783679656; x=1815215656;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YdwapKFEB+5WOn+QJvFw68I8C0jc0WICncXmRPQ9frE=;
 b=m8Y4I9YxPhqxsf2wnj5o8dKm8NqRriQIERO/EX5xNl/CD+8UGGA8Yrnq
 kactwqv0Ue1kM03xrTQjk2AP1+Ksa87l9QipMJqI9uQl9U5hIWPBbCGKS
 7RykyOmjTYIARJb3kpCrI8OUHdu3fcEOyBoTzQyeEopjGBhhXDXHiDwn2
 dBSo3nYOX5/WmrMTj+q8aj7DKk3bbsxJ8n8yS5LxklC32IzFMaZydgUpo
 EOLj4WSk33lRtxAmvJav9X8oC8C1haMNBkNhMA16B8NzDzVdNyKwunaPN
 nBFTf1G3sJ//Lv6Dqg3W1jpS3xtZKJqD44IqKEs/A+H3tm3vFgXndnwuX w==;
X-CSE-ConnectionGUID: bTy4vKLfTy+Q36fzILW8sA==
X-CSE-MsgGUID: T++TRVPGSqCrxh8oQ3nvtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84428989"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84428989"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:34:14 -0700
X-CSE-ConnectionGUID: /s2GjFAgR7OMD+cEE6b48Q==
X-CSE-MsgGUID: K/joAkfoTGqKibiAjlVcGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259163191"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 10 Jul 2026 03:34:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v3 6/6] net/iavf: fix leak of IPsec crypto capabilities array
Date: Fri, 10 Jul 2026 11:34:03 +0100
Message-ID: <20260710103403.1548864-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710103403.1548864-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260710103403.1548864-1-bruce.richardson@intel.com>
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

The security context setup allocates a crypto capabilities array and
stores it in iavf_sctx->crypto_capabilities. However, the security
context destroy path frees iavf_sctx and sctx directly, without first
freeing that array.

Fix this by freeing iavf_sctx->crypto_capabilities in
iavf_security_ctx_destroy() before freeing the security context itself.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index b2e08da0aa..9c8f694de5 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1572,6 +1572,8 @@ iavf_security_ctx_destroy(struct iavf_adapter *adapter)
 		return -ENODEV;
 
 	/* free and reset security data structures */
+	rte_free(iavf_sctx->crypto_capabilities);
+	iavf_sctx->crypto_capabilities = NULL;
 	rte_free(iavf_sctx);
 	rte_free(sctx);
 
-- 
2.53.0

