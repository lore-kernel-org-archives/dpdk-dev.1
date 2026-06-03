Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91ADCD6E60
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 14:34:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB3D840615;
	Wed,  3 Jun 2026 16:34:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 12085402A9
 for <dev@dpdk.org>; Wed,  3 Jun 2026 16:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780497280; x=1812033280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WbZhwXWTX1Ysy9BAeUcc/UMbR6jA940DWoTdxsKGDs8=;
 b=V3mszXfngi4JAMj1WvKHxomHSqG4axU3ulgMLZKcThY84zVWeObtDd6j
 vB4taLRiaoodu38byq+P12MDbWbQWXUbNQ4D7Y4hBPBibwwPvUvtBvbFY
 gAmW4/he8jYyOZA7rSUukk88hV/JYPIeaJulCCTFWW8PXGJZj9CWILi2H
 6vpk/X0Tsjvz9wxFaDEehcmCYQr0HTv/3sxjnq2nZbTgG0e20PwVzqGXG
 JKy983T4Dhg3cQ/qa0G/3BgVT70yLfxkPzy8J9uVKUql+nnOsbmLrR21S
 mNqM/q1RXoTWI1QBJJIluR4PABWFyDwvY86NLlPWk5iLy4VHkjtA/1ZcT w==;
X-CSE-ConnectionGUID: obSFbNpMS/Of+55X5cJrWQ==
X-CSE-MsgGUID: cormofhURjCVUe0AoBXD+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91882184"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="91882184"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 07:34:39 -0700
X-CSE-ConnectionGUID: hyxzKjTJSF6cJf8zplg06Q==
X-CSE-MsgGUID: MdfW7nlQQMaUju3zSV6CQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="244106819"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 03 Jun 2026 07:34:38 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/2] net/ice: revert fix link up when starting device
Date: Wed,  3 Jun 2026 14:34:06 +0000
Message-ID: <20260603143407.1108527-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603143407.1108527-1-ciara.loftus@intel.com>
References: <20260603143407.1108527-1-ciara.loftus@intel.com>
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

This reverts commit 6c76b76dc64183eb2f24a52b90d4ff9feb4872f4.

The reverted commit worked around a potential timing issue where the
link could be reported down immediately after the link was enabled
during device start. The commit introduced a blocking wait which gave
the driver a better chance to read the correct link state before
returning from device start. However, since the auto link update flag is
set when setting the link up in device start, an adminq notification
should arrive once the link is up, which will be handled and correctly
set the link status. This means we can remove the delay from device
start as it does not need to guarantee link up before returning.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index d2734b6688..da570d03cb 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4464,7 +4464,7 @@ ice_dev_start(struct rte_eth_dev *dev)
 	ice_dev_set_link_up(dev);
 
 	/* Call get_link_info aq command to enable/disable LSE */
-	ice_link_update(dev, 1);
+	ice_link_update(dev, 0);
 
 	pf->adapter_stopped = false;
 
-- 
2.43.0

