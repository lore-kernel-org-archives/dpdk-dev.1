Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB5BD5CCBF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 10:35:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86B40402F2;
	Tue, 16 Dec 2025 11:35:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 47BD14026C;
 Tue, 16 Dec 2025 11:35:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765881313; x=1797417313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a2aV2CdI7PXtoKUwW/8uy6ZWcrXJvpMQR3xSsZJ3iWg=;
 b=iIWmDHj8w0hzhZLLdzC/wPEv5fZbmOgamTsUIH/IxNEvGcWUqET+QtOh
 ItgCGIr6jVWA7uFz6rnhrysdPDjjiS4tixYZXE8Ycycws42NKVo2fAv5r
 9+r/ev3zTuuJIquGhhQpYXYtuLyVvcHH4DHuStpNEBe7iygJIKD4GMJlZ
 NJ3D4ZApzMamPpfXrCfFxCoEx7FRxH3t5Erg3jv85EfL29N4YKPMv81ZI
 I2Mj163I7TZ55nRmxMkH8IRaUJG7axcXn3U8llUntQr8sPxWPcl/9Nsfk
 fu45nt6/B0j45+uis/A7sZ4OSjshNzuWcyNz4sl+3wGglQf662au9Fl9w w==;
X-CSE-ConnectionGUID: fO5CTp2TTT2dpDn+TaWmsQ==
X-CSE-MsgGUID: 6/gwzT+oTpy0RpfA51f+wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79250833"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="79250833"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 02:35:13 -0800
X-CSE-ConnectionGUID: NZpQyWrRRpCHG0T6gtDO4Q==
X-CSE-MsgGUID: wQZl89VYR1ugR0sFw9L7Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="197259841"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 16 Dec 2025 02:35:12 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 2/3] net/intel: prevent selection of a null Rx burst
 function
Date: Tue, 16 Dec 2025 10:35:03 +0000
Message-ID: <20251216103504.2624535-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216103504.2624535-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
 <20251216103504.2624535-1-ciara.loftus@intel.com>
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

Depending on the underlying architecture and CPU flags available, a
different set of Rx paths may be defined by a driver using the common
path selection infrastructure. However the Rx path selection function
iterates through the entire array of potential Rx paths, regardless of
whether they are available for selection by that platform. This could
result in a null Rx burst function being selected. Fix this by
discarding paths with a null Rx burst function from selection.

Fixes: 9d99641d80a0 ("net/intel: introduce infrastructure for Rx path selection")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index ea7fb98b47..83259f2737 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -266,6 +266,10 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
 	for (i = 0; i < num_paths; i++) {
 		const struct ci_rx_path_features *path_features = &infos[i].features;
 
+		/* Do not select a path with a NULL pkt_burst function. */
+		if (infos[i].pkt_burst == NULL)
+			continue;
+
 		/* Do not select a disabled rx path. */
 		if (path_features->extra.disabled)
 			continue;
-- 
2.43.0

