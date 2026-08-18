Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E96CC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:59:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D16F406BB;
	Tue, 18 Aug 2026 06:58:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 329DE4067B
 for <dev@dpdk.org>; Tue, 18 Aug 2026 06:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787029132; x=1818565132;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2MNTB4kqDN+ITeIC+KAxrF29lTs43W7lWPvm80skz4Y=;
 b=Osw26zKBQm++gGfCiBLmn+m4ZxtpNRoj1qitSf8v261SPHvCU63YfI54
 sBRaF+D/Y+YUNGokrmxeLi4JhgkDCTYQCLYaWllBauH74Vwg6IqSR9ZPR
 H8SGKBV3NYbSLJQQ3YoVW6F/fiIJ8q7e2LfesqiwpL57BNZ5nEurl4foR
 98v4vMA9tzyy01rR5ZLc6XNj8RT6DjitazsI9ArH0QBARH9Rjm91Qp+BK
 7y7JRT4cgTrvXwzKg02XopfPkvALv175Vgn/PiGyWs/uVw1Sz2gW+77n/
 JyZw67TT38Q0MsOLvCfqBN3n7HyW+L2eScyVpWIMKMUXdxV+vcYCUxMdH A==;
X-CSE-ConnectionGUID: DXBdzrcqQ6CmaNhCMp0plA==
X-CSE-MsgGUID: +WnYQkiYQH+UssXgCHmi5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87633024"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87633024"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 21:58:52 -0700
X-CSE-ConnectionGUID: dJVVxhxiQnGCHfOwg6rXzg==
X-CSE-MsgGUID: +2kOH/3uRGy3ylJ5eDdG8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="268611301"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa003.jf.intel.com with ESMTP; 17 Aug 2026 21:58:50 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v4 7/7] net/iavf: skip flow flush during PF-initiated reset
Date: Tue, 18 Aug 2026 04:57:32 +0000
Message-Id: <8c5626e9d3fd1dbb66df020b841b4ba5ccb66695.1787028683.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787028683.git.anurag.mandal@intel.com>
References: <cover.1787028683.git.anurag.mandal@intel.com>
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

