Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7FFC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13F33402E3;
	Mon, 17 Aug 2026 08:50:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 383AD406B6
 for <dev@dpdk.org>; Mon, 17 Aug 2026 08:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786949406; x=1818485406;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2MNTB4kqDN+ITeIC+KAxrF29lTs43W7lWPvm80skz4Y=;
 b=ndPiy8gW58JvLkzma51xWLRvgBRAlOzbvOtvrkzNuoVaZpuE5v7cV594
 jaAqOV1pTZOsMpRy893HUNFv5+ERJzOxMH7a7QyZPS7D1dJ+bBf/oZnVD
 5M0q7XOeI8Es6Mlys6MmPTpHcJpIEMl/FEy6NRKQtgQEQMzbR043m5dfS
 CgKCchjovb71EeRaaSQpXlQ/aEkFCHvnXZ0pwtkaK59tDvDUG/nVFakqP
 YXZg3n84ZGsZFCAvyvxfixMqFAH/i8HQZBsnNFreJwW566yCMkbAQtDAt
 cFO4SF+7Mr4tak95AKTvQo2r6I0rUKiRy06JWq6odFlJrLnlPxlvNQ7bL g==;
X-CSE-ConnectionGUID: yLO93zxaTra1ZxaOfmm+6A==
X-CSE-MsgGUID: W4VWyyG4RUaP6PwcBbZ7Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91095608"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="91095608"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:50:05 -0700
X-CSE-ConnectionGUID: E7h8ItAPSEORZUVA3R3GxQ==
X-CSE-MsgGUID: YhKvr7U6Rrmu8E/tIxcsjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="262196020"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 16 Aug 2026 23:50:03 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v3 7/7] net/iavf: skip flow flush during PF-initiated reset
Date: Mon, 17 Aug 2026 06:48:46 +0000
Message-Id: <82e083fd8536156e2452e6afc7638de9cae1063d.1786948817.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786948817.git.anurag.mandal@intel.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
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

Skip the virtchnl-emitting teardown on a PF-initiated reset.

Fixes: ada64daa1a5b ("net/iavf: fix VF reset for flow director rule")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 322b59d68c..5373e71b69 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3235,7 +3235,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	/* remove RSS configuration */
 	iavf_hash_uninit(adapter);
 
-	iavf_flow_flush(dev, NULL);
+	/* Skip the virtchnl-emitting teardown on a PF-initiated reset */
+	if (!vf->pf_reset_in_progress)
+		iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
 	/*
-- 
2.34.1

