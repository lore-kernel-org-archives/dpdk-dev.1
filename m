Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C34C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E545740A6C;
	Fri, 10 Jul 2026 12:34:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id ABE0740611;
 Fri, 10 Jul 2026 12:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783679652; x=1815215652;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nBgd6Lb9bVUsj9ctXblSEWrQpGEvYyyaNNh9+xweQe0=;
 b=Q0n6/GEHVYF6IfQPzf86VFiQBHU4gwHLZq8uO3cCUIwmuCUp/8emCRkk
 5NvASwIvrGKLQEXJY332DWtuE5ZLsikR6usLLNmJbfl/LVr+bD3PMJdua
 uAprW915ou3hliKYGCR/Nr9iJPwS/G7N2ZicDYoNS6Plxjt0dAN5GZVqY
 kAvE1YY32FuKInr2E5xqzLfS4KEroDoqgqJhXrQzTBuGaLfqr6TgJBGcn
 ehL4CcmyR/9s9Ki0d6a/V60Sxcfl5AdOurYRD31gYOqdDZw2SJH8iSpZg
 KOsHGMcrpaMtAhOpvrxO1Fdq1Hx0L0dNse01H5xVafMkYPZvw85mPBG4M Q==;
X-CSE-ConnectionGUID: QOzuHEvyQ/CHYJRpohEXng==
X-CSE-MsgGUID: a1SbNFCCSvee+rWLIXPYMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84428984"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84428984"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:34:11 -0700
X-CSE-ConnectionGUID: hsUTmwr5SXWFCGtwRTFX5Q==
X-CSE-MsgGUID: JkG4h5a8T4izwb5dEHGalw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259163175"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 10 Jul 2026 03:34:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v3 3/6] net/iavf: fix memory leak on error when adding flow
 parser
Date: Fri, 10 Jul 2026 11:34:00 +0100
Message-ID: <20260710103403.1548864-4-bruce.richardson@intel.com>
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

In iavf_register_parser, the final "else" branch is an error leg which
returns immediately, without adding the newly allocated parser_node to a
TAILQ. Add a free call for that parser_node in the error case to avoid
leaking memory.

Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 84bb161bd1..92ca20031c 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -1911,6 +1911,7 @@ iavf_register_parser(struct iavf_flow_parser *parser,
 		list = &vf->dist_parser_list;
 		TAILQ_INSERT_HEAD(list, parser_node, node);
 	} else {
+		rte_free(parser_node);
 		return -EINVAL;
 	}
 
-- 
2.53.0

