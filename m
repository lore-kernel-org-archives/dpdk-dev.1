Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E995C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:09:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E4D240DF8;
	Fri, 28 Aug 2026 15:07:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 4A1854060B
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922457; x=1819458457;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZzXHI6ZTcQormyzjronNiYQSBtUlHbJJmm+fMyqplLA=;
 b=ZmqQN3hmmxoszBLVPQZZB4y7FOjjupJc9QCa4RmdnY5eTFhvpIsJhecM
 Pqld2YM+t3jZXFU/VV982MWAbt7RgK9A8bO84gNKYxreW8cCR5lMx/3SV
 IMtqEZp8as3PI299cLL4Hcg6lyAv6/zPs4BNBXczwY6MiMGxP5GqZAsvu
 rY9eOI/m2JT23l0F4lvh4vCLywRFPhVEieF8J+lAz4iiDqlc6HlZ+Ujzy
 ELn/uDLuPD9NU7lWU4HogUM1ojS+2R3fLW81kzn5YhQgjb27T9YKVku5i
 UgyluAUGLvYDVPmKn3O3XAGKOdjUZdX2duUJFVe3jXMUWGF1KEdnYecye A==;
X-CSE-ConnectionGUID: ML0AAdvVTGig1Qu+bUxyiQ==
X-CSE-MsgGUID: DZJikZ3lRhm6qFj3LtJCkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964633"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964633"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:36 -0700
X-CSE-ConnectionGUID: 9Ru1zkaqTlGzZkNpRPR1vg==
X-CSE-MsgGUID: V8EgkbLzQdGp2LHddx7/Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271960168"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:35 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v14 20/25] bus/pci: use the new VFIO mode API
Date: Fri, 28 Aug 2026 14:06:48 +0100
Message-ID: <75ed33a355c2c48c157a38c0793bb2631456961a.1787922363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787922362.git.anatoly.burakov@intel.com>
 <cover.1787922362.git.anatoly.burakov@intel.com>
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

Use the new VFIO mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index af37a65c45..b9fe4797fb 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -596,7 +596,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (dev_vfio_noiommu_is_enabled() == 1)
+			if (dev_vfio_get_mode() == DEV_VFIO_MODE_NOIOMMU)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
-- 
2.52.0

