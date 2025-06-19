Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1C0C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:14:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9343B42E68;
	Thu, 19 Jun 2025 09:14:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C284C42E65
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:14:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750317259; x=1781853259;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j+CQ/xVB9OzrLaJjhzhhW3iHQQgZ5yzOobi8w4xkJcY=;
 b=hqxTifrAmfQKItye5RLrkKz0JMHVUFr/1/FvfpHuo+7YLeeR74PUcvXV
 rOYJiEff3HRR1vjXbLIiqtO74V36MNNe6wgmYTqBfbD4pa1WKvRGEeo3g
 qP6taOP3JkwqPUMZVcUYC/Hgy/vTFaKeIcHUQDDC9PyJkqxZ57zpsiyyE
 t6Y1H5cljla+Y4LbbpPn0hyREphD+dxvD0srqkPNasUB8ic3ovEtaDyhc
 LEevJNuPlMJXJw0bJySvE2cBzMZhKHyqgF78GDmfY3/wFqEECY+jM3b6t
 XToU5sq2OhHiwAeEZUnoU1B39kppGI4+haVnxB5WhjtM1O1hbgjD5wXCC g==;
X-CSE-ConnectionGUID: TmDylehjQdGdYkCzSgjyYg==
X-CSE-MsgGUID: U3rhO8BdTCaqrDXo27n67A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="55193468"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="55193468"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 00:14:19 -0700
X-CSE-ConnectionGUID: aaAhS7VMSyGXR2MsDvOWvw==
X-CSE-MsgGUID: wyiCsMCxTT2vaADskobecQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150990827"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 19 Jun 2025 00:14:14 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2 1/2] doc: update recommended matching list for cpfl PMD
Date: Thu, 19 Jun 2025 12:45:01 +0530
Message-Id: <20250619071502.442214-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619071502.442214-1-shaiq.wani@intel.com>
References: <20250612121322.146355-1-shaiq.wani@intel.com>
 <20250619071502.442214-1-shaiq.wani@intel.com>
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

Updated the recommended MEV-ts release version corresponding
to DPDK release in the cpfl driver documentation.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/cpfl.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index 3bfab2136d..aa5bed4136 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -39,6 +39,8 @@ Here is the suggested matching list which has been tested and verified.
    +------------+------------------+
    |    24.11   |       1.6        |
    +------------+------------------+
+   |    25.07   |       2.0        |
+   +------------+------------------+
 
 
 Configuration
-- 
2.34.1

