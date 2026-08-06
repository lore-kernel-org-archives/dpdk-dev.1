Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB7DC56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:13:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D51A040DFD;
	Thu,  6 Aug 2026 16:11:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0BCD240E01
 for <dev@dpdk.org>; Thu,  6 Aug 2026 16:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786025511; x=1817561511;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vQS8keByxPZqIq29tz14Cyz3xTbbSPThXrPAkc9Lic4=;
 b=IHE5JEAJmAIKr+lvR58doejhDkraZ98YU6hdXsVY841MzfDzk8OUVj7N
 SW9WV6XypBhgkpJIIvbh95EooJP5cZQhFfFjjUPjDwOAaOA4trOz6Fvfs
 WoGxsf+X5Y9C38PwBeotTdMh0MlFd0kfGJuonXuhnHzyGhanU/FP6gXIr
 AGDVYlk+IDTOyYAXVn43z5GyITZql13kAz+gqTw3NEWfxUwJn0++Zr7n7
 hP3JpMu1ifujh1YKkvJH8SbGubuJue+seQlRfI4hxNGqKTOzEzjY1R3s0
 auGo49K9y9pQrCri7CIvEA3XOfwUq4JJux/MigVz48a8e0cMM7vNszOag w==;
X-CSE-ConnectionGUID: /M7DdS2bQR6X0Q3Fyq7a3g==
X-CSE-MsgGUID: qHmmpZFsTzShvTjsFuioeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85590033"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="85590033"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:11:50 -0700
X-CSE-ConnectionGUID: I0DqGz0DQUSdWiWHYgcmpA==
X-CSE-MsgGUID: hnRdE+IAQNGsV/h+poAfWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="292015198"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 06 Aug 2026 07:11:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v10 15/20] bus/pci: use the new VFIO mode API
Date: Thu,  6 Aug 2026 15:11:15 +0100
Message-ID: <7faff5a7b2d0d3218ae846e1dff1e1e4f594843d.1786025388.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786025387.git.anatoly.burakov@intel.com>
 <cover.1786025387.git.anatoly.burakov@intel.com>
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
index 9aae0a5d14..a1575b84e2 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -596,7 +596,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (rte_vfio_noiommu_is_enabled() == 1)
+			if (rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
-- 
2.52.0

