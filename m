Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4916C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:34:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E24C40B98;
	Fri, 10 Jul 2026 12:34:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0538F4067C;
 Fri, 10 Jul 2026 12:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783679654; x=1815215654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LtAXwXHVVwj9D68d5HUZNLdAq1sKkyK9qLT+f9c07y4=;
 b=MFDEv6HG00Orf8AuAKxOsxzwVdV6V2B7kcAQKoHgWMGuIC2aPwt9XLyf
 dBHvIfj/WfkbjrtEwD7QBAh9gqcypccKszH9YgClbUCBM9VllvPpz/EAC
 08P6CJIa95b5Klma4/bRMjtMbF+ln68HJfDn3lRXDRZHZZFdgr+9+uS2a
 MNSfoVs4pAiSYg4gd7VSWtoValUmKDrHH7vPypZUV4AEhNOEGI+EDS0mV
 z1FXFNlTeMmpnWH3nw2IfV9AJbp6tFyHjjra0IUBDz4P0VwuSwVCpOeRe
 hkrcOeTjHTaT+GhJt18W+qlKJqPh8vZMQY8fe7bV71HQsByUg3FZbzQN5 Q==;
X-CSE-ConnectionGUID: RLn9igASTleeGrFe8emNPA==
X-CSE-MsgGUID: DJFZawVBQQ2DJs8dvXO/fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84428988"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84428988"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:34:13 -0700
X-CSE-ConnectionGUID: 5nFBPmU1RTSfrHfD/RHR1A==
X-CSE-MsgGUID: Ukm7J00NQJ+2O7aUIax6cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259163186"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 10 Jul 2026 03:34:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v3 5/6] net/iavf: fix leak of flex metadata extraction field
Date: Fri, 10 Jul 2026 11:34:02 +0100
Message-ID: <20260710103403.1548864-6-bruce.richardson@intel.com>
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

Function iavf_init_proto_xtr() allocates vf->proto_xtr as part of the
device init sequence, but no shutdown function frees this memory again.
Add appropriate free calls to fix this memory leak.

Fixes: 12b435bf8f2f ("net/iavf: support flex desc metadata extraction")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V3: add free call to close function to free memory on normal, non-error
    path.
---
 drivers/net/intel/iavf/iavf_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1cd8c88384..d601ec3b6a 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2757,6 +2757,8 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
 	vf->qos_cap = NULL;
 	free(vf->qtc_map);
 	vf->qtc_map = NULL;
+	rte_free(vf->proto_xtr);
+	vf->proto_xtr = NULL;
 
 	rte_free(vf->rss_lut);
 	vf->rss_lut = NULL;
@@ -3255,6 +3257,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
+	rte_free(vf->proto_xtr);
+	vf->proto_xtr = NULL;
+
 	rte_free(vf->vf_res);
 	vf->vsi_res = NULL;
 	vf->vf_res = NULL;
-- 
2.53.0

