Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F69CE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABEEC40A8A;
	Wed, 11 Feb 2026 14:53:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 09B3540A76
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818025; x=1802354025;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=L2JbbECeKjNdzt1A0ekdFvPkp1R0uJ7jTa/ad/ZlAQ4=;
 b=FntBjYY/b+NQ0xTh848+TmEcALcvq2+3tzgyWb9TJQN5CxtBkCWg4y7R
 VBUMaLMlHrlsJSJq2HHijFzeGKg9WlTVUpVc9RsfVznFcs1HlKKu+yWMz
 akrpy5lNusaGcE9+W4w3S//tYCoGiwznpFUBNlxjedkewXXhzdEHI4IbQ
 ZYzyf3U3PaPjpvASO2l34+FLodSCrtl1sKNH5dx2jG9GtihLuwqL4JDPB
 h95m7s9IQWzL19d+v85fUwkNw8b653ZIW+w7s+y5fIys/1FT4psrxtDM5
 IJdP7FjaiSlyeO8/PfEhgPYB8xkozfjKe+WtEXMF3zdEPFXxswKTsaV+9 A==;
X-CSE-ConnectionGUID: i3/E48zBSvGN3CHqjIx9rw==
X-CSE-MsgGUID: LmVkPOOaSGmwbdhu8+DpLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808247"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808247"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:44 -0800
X-CSE-ConnectionGUID: Es4+vPUoQ4uA8Exn0stFlw==
X-CSE-MsgGUID: D1XKWCXSRkaluYVItMycWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359588"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:44 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 10/27] net/i40e: avoid rte malloc in RSS RETA operations
Date: Wed, 11 Feb 2026 13:52:52 +0000
Message-ID: <18276a5e4876d084096cccf6f40ef9af87fedacf.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
References: 
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

Currently, when updating or querying RSS redirection table (RETA), we
are using rte_zmalloc followed by an immediate rte_free. This is not
needed as this memory is not being stored anywhere, so replace it with
regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 06430e6319..654b0e5d16 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4630,7 +4630,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -4649,7 +4649,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
 	pf->adapter->rss_reta_updated = 1;
 
 out:
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
@@ -4673,7 +4673,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -4690,7 +4690,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
 	}
 
 out:
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
-- 
2.47.3

