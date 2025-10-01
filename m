Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E917CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 12:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11D3040E15;
	Wed,  1 Oct 2025 14:29:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5438A40DF6
 for <dev@dpdk.org>; Wed,  1 Oct 2025 14:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759321760; x=1790857760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DGy+XPhoLcjiqpbvgV9t+y+D4AB6nAbE0m3xqZrdpcA=;
 b=FdRN3XS9wAcUWxZHelDj51X3Uhw1IePEz53LXDQT+cSoQFUpULnNCZui
 4rR65RqoL7+AEH7/ipCgYPP9m5YDOnaDsWUiEvahAoJI8zckgeEyxar1Q
 vuzNtgMp2KSj0gSC+sZD9m7lmh2+30bk0EnRnJ5hmdtgVGuqchn4qdOku
 pHP3jhEp4L2PNFoXFv7jFM/tKp76aL86ekAwBfr+yvjnAXpWB/8fFZYjY
 S4VrVr+b2r8cvqodLQOTdAmEFT9E4+lUmCNZHcjSKNmCAafnv9pyzaUnb
 ZKphMQQNX/doZeeK7iHLM4JQS+NkCnUhkIgMb/vJKVGQACJ0lr32vboeJ Q==;
X-CSE-ConnectionGUID: mCI0fiAJREOubeQqQXTAdQ==
X-CSE-MsgGUID: fLG0QIGJSP6HD5BGUarY+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60807875"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="60807875"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 05:29:20 -0700
X-CSE-ConnectionGUID: V4uhU+/7TbSb46EqgLHYnw==
X-CSE-MsgGUID: CyA6uASESRuzim8dWgBxKw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2025 05:29:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Cc: vladimir.medvedkin@intel.com
Subject: [PATCH v2 5/5] net/ice/base: update README
Date: Wed,  1 Oct 2025 13:29:08 +0100
Message-ID: <207bf21102cc183944ead4f989eaf9b26d0e7891.1759321681.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759321681.git.anatoly.burakov@intel.com>
 <cover.1759321681.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update version to indicate when last driver snapshot was generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/README b/drivers/net/intel/ice/base/README
index 98182a8da6..1f6b53c4c2 100644
--- a/drivers/net/intel/ice/base/README
+++ b/drivers/net/intel/ice/base/README
@@ -6,7 +6,7 @@ Intel® ICE driver
 ==================
 
 This directory contains source code of ice base driver generated on
-2025-09-01 released by the team which develops
+2025-10-01 released by the team which develops
 basic drivers for any ice NIC. The directory of base/ contains the
 original source package.
 This driver is valid for the product(s) listed below
-- 
2.47.3

