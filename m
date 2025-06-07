Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C2BC61CE7
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 01:18:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80CC5402C2;
	Sun,  8 Jun 2025 03:18:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0E454402BD
 for <dev@dpdk.org>; Sun,  8 Jun 2025 03:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749345524; x=1780881524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eCIFHZFca5rkzk2GEjIG8U9+LyvPjVJO7I3OSnoWSXw=;
 b=cQGqH70p2JjFG7zBsBXjL7xMxXslzQTMZkZzvuGPH2zupoRZZ9wcj7VT
 5ztCbEjH+NObk5iQfe+xNDp8k3KmI4B55uUPP410+3IYupmDmaq6d6oiH
 akG5codutXOnMU4lC2L0PTt5jvaReHHMKrKc2GEANeOsqirl50X9lQX3r
 fX5KLb1+25a/TRKc2gneXz2eTehIUXCUHLvZNQ4bIF+chg707wKKpEVQm
 38IOvfif8G4Eqb7Q+KBHaVXvOyVuGSZQoMEnSFFJ/wNdxWJY7NGW715/g
 CA0pZFkgpkSw7vSSgR6JMNSMA8Aeph0kIr9/DzEV6w6f9fxF5H2NDtc1F g==;
X-CSE-ConnectionGUID: 8fCU41VwTJObI7aRME2Q0A==
X-CSE-MsgGUID: zhZ7+52vQ4SmzzwohkURIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="62856896"
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; d="scan'208";a="62856896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2025 18:18:43 -0700
X-CSE-ConnectionGUID: +7WkagcCTsKYISPvvwkXTA==
X-CSE-MsgGUID: SrXR7ZvzQfepA86pJ6SiWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; d="scan'208";a="146676568"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa010.fm.intel.com with ESMTP; 07 Jun 2025 18:18:42 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v2 2/6] net/intel: add read clock feature in ICE
Date: Sat,  7 Jun 2025 17:09:00 +0000
Message-ID: <20250607170904.480937-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607170904.480937-1-soumyadeep.hore@intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250607170904.480937-1-soumyadeep.hore@intel.com>
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

Adding eth_ice_read_clock() feature to get current time
for scheduling Packets based on Tx time.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 7cc083ca32..9478ba92df 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -187,6 +187,7 @@ static int ice_timesync_read_time(struct rte_eth_dev *dev,
 static int ice_timesync_write_time(struct rte_eth_dev *dev,
 				   const struct timespec *timestamp);
 static int ice_timesync_disable(struct rte_eth_dev *dev);
+static int eth_ice_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
 static int ice_fec_get_capability(struct rte_eth_dev *dev, struct rte_eth_fec_capa *speed_fec_capa,
 			   unsigned int num);
 static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
@@ -317,6 +318,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.timesync_read_time           = ice_timesync_read_time,
 	.timesync_write_time          = ice_timesync_write_time,
 	.timesync_disable             = ice_timesync_disable,
+	.read_clock					  = eth_ice_read_clock,
 	.tm_ops_get                   = ice_tm_ops_get,
 	.fec_get_capability           = ice_fec_get_capability,
 	.fec_get                      = ice_fec_get,
@@ -6935,6 +6937,17 @@ ice_timesync_disable(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+eth_ice_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
+{
+	struct timespec system_time;
+
+	clock_gettime(CLOCK_REALTIME, &system_time);
+	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
+
+	return 0;
+}
+
 static const uint32_t *
 ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 					  size_t *no_of_elements)
-- 
2.43.0

