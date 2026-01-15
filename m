Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094CFD41168
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 10:38:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54D50410F9;
	Thu, 15 Jan 2026 11:38:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4B0764003C;
 Thu, 15 Jan 2026 11:38:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768473525; x=1800009525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N6v+wc4yiytecywbjzhnTWv+Kfozu6tzylqk6N/6K1Q=;
 b=ZMgp0CukWYA/Kjr72vg661z5TvocX3VULWAQA19zY+faOTxvSdQ5w/9t
 2eNrP02SLzqFVMC6aNb1/8jZ1tH6stgWD9kw1hrr29xdYfKh/ZRcoh2lw
 6PLE5CSZUSwVg9gGBrKiBuqyhtT6TupyMceBKzyzIyahTL0UdUJvHN7TM
 VWGgrRd90+gNGBoijS30U985oNW3wSLG54gwayyJBt41SVcDeAy4b3JkT
 UH1OQL05AqAivtQCCLQFUJYeycReb33oFhArGOookTwNZReJtvW0ZVoxs
 zQOly3DMHDzYmfWAOq0MQC2IJqszy3flVlJZQ3nWPBzgNP2O/T31AOrNG w==;
X-CSE-ConnectionGUID: zgVfhuJWSOalni/Ynr+sWg==
X-CSE-MsgGUID: hO3++JngRES9pg1C4bgEmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87187961"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="87187961"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:38:44 -0800
X-CSE-ConnectionGUID: Pi+KrTOVS2+eovAqtOxNpQ==
X-CSE-MsgGUID: P0XaeiNnQ7WcLHfzTvdAFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="205204800"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 02:38:43 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/3] net/ice: fix priority mode printing in Tx scheduler dump
Date: Thu, 15 Jan 2026 10:38:22 +0000
Message-ID: <20260115103824.1982220-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115103824.1982220-1-ciara.loftus@intel.com>
References: <20260115103824.1982220-1-ciara.loftus@intel.com>
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

A value of zero in bit 4 of the generic data means that strict priority
is enabled. Prior to this commit it was being interpreted as WFQ being
enabled. Fix this.

Fixes: ab4eaf9a8a31 ("net/ice: dump Tx scheduling tree")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_diagnose.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
index 298d1eda5c..a58279a116 100644
--- a/drivers/net/intel/ice/ice_diagnose.c
+++ b/drivers/net/intel/ice/ice_diagnose.c
@@ -641,7 +641,7 @@ void print_node(const struct rte_eth_dev_data *ethdata,
 	fprintf(stream, "\t\t\t\t<tr>\n");
 	fprintf(stream, "\t\t\t\t\t<td> priority mode</td>\n");
 	fprintf(stream, "\t\t\t\t\t<td>");
-	print_priority_mode(stream, ((data->data.generic >> 4) & 0x1) != 0);
+	print_priority_mode(stream, ((data->data.generic >> 4) & 0x1) == 0);
 	fprintf(stream,	"</td>\n");
 	fprintf(stream, "\t\t\t\t</tr>\n");
 
-- 
2.43.0

