Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C3CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 10:49:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 072704066D;
	Tue,  2 Sep 2025 12:49:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9B6034064F
 for <dev@dpdk.org>; Tue,  2 Sep 2025 12:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756810167; x=1788346167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xsx2XaDhdd3+iAJfEJMDPUaTnk/WtfSqRxj9MJYWGoQ=;
 b=IkBVTsZt0TrmxzbkrgSiv+ANlZ/mOZqFhPhgSodHZf8umGYF/+yJsFlT
 gPkusIx1WkpE2R8Aj2LQbdBQQtxG8KkBuRvyHrGR/r6RS4hF84tQbeUjM
 rsTXHkrAXqKQqIeqGw1oFk15uS+muc63ta+vi5L160EN/ggQpDhPuClSR
 faO48/pKWeGF4whKEyg0WqqAvpr9wvvvVb3hhsiwUiQWSbF61FDaIVuTu
 nrBD3jmVDiqSU1hOsCQW8faxyBFTabEcrm+ux8Vh++sdyXLXsKz+aXgM3
 ORhtMFEWyn/7UR4objUtOce5g+XgbhpGtSecPL7Q+bmll64eWekMCGoCR g==;
X-CSE-ConnectionGUID: RvUJ+NURRim20WDPszVUYg==
X-CSE-MsgGUID: IfhPg6XMRkqcdcTtDUASGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59014553"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="59014553"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 03:49:27 -0700
X-CSE-ConnectionGUID: xLL5SnKrQOmAJWDst4r9Kg==
X-CSE-MsgGUID: tSgUx6bXSEyTLqN9e+Z3JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="175609400"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa004.jf.intel.com with ESMTP; 02 Sep 2025 03:49:27 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 4/4] net/iavf: remove duplicate in scalar offload list
Date: Tue,  2 Sep 2025 10:48:59 +0000
Message-Id: <20250902104859.2100141-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902104859.2100141-1-ciara.loftus@intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
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

The scatter offload was listed twice as a supported offload for the Rx
scalar path. Remove it.

Fixes: cd9889d90b84 ("net/iavf: use the common Rx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 723c30d05b..10812533c2 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -68,7 +68,6 @@
 		RTE_ETH_RX_OFFLOAD_SCATTER |		\
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
 		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
-		RTE_ETH_RX_OFFLOAD_SCATTER |		\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH |		\
 		RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |	\
 		RTE_ETH_RX_OFFLOAD_KEEP_CRC)
-- 
2.34.1

