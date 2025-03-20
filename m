Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6F3C28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 14:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6AAA40616;
	Thu, 20 Mar 2025 15:21:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B550C4060A
 for <dev@dpdk.org>; Thu, 20 Mar 2025 15:21:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742480481; x=1774016481;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fj/BWH2fgiSrF3oOn+WuAYrUwGE4pPRoC5JPCqbT/lI=;
 b=SarJGjfQg4f42EfbCpKyFmacb26TBYT4SARy0i+Tg2YB86Gxxnfysw7f
 +PALGU9fhCmyHhWdVzJ982HpRBKQbkTVKb5yCOEbirVSpbDxWttWmyX8v
 eXjVXJZYtUcE+RCvWyMDEo6EVUZz+lAlUW2lKthNi21KOA2fbqV6yK9zv
 46/glAbOvct3lTXUHgDO3g7RYOVMRJ/Eg06yNwY8glHGOdTsxWMAW20k0
 xOrNK7Lh1JK3WVFfpiebBbTS5NucH+ANKXEUpM9Q5oXhnj3JHMJa6bbyp
 hGhGtm+Bbvo7tm6slExb74Kx9lCleohUfHee8FIU8tUW4aQwDllWlGZAI w==;
X-CSE-ConnectionGUID: vy0lY8dkQ76LTS6+NUDpWg==
X-CSE-MsgGUID: wxAokaXEQz626tT8Ovc5Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="53932627"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="53932627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 07:21:21 -0700
X-CSE-ConnectionGUID: B4YZGm6kRpKNetdcWOCGvw==
X-CSE-MsgGUID: OmBcasOtTImN6G80zbNBPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="128204472"
Received: from unknown (HELO silpixa00400886.ger.corp.intel.com)
 ([10.237.222.180])
 by fmviesa004.fm.intel.com with ESMTP; 20 Mar 2025 07:21:19 -0700
From: Brian Dooley <brian.dooley@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, gakhil@marvell.com, kai.ji@intel.com,
 Brian Dooley <brian.dooley@intel.com>
Subject: [PATCH v1 2/2] maintainers: update for FIPS example app
Date: Thu, 20 Mar 2025 14:21:13 +0000
Message-Id: <20250320142113.1130872-2-brian.dooley@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320142113.1130872-1-brian.dooley@intel.com>
References: <20250320142113.1130872-1-brian.dooley@intel.com>
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

Removing myself as maintainer for the FIPS example app.

Signed-off-by: Brian Dooley <brian.dooley@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cdcea9aa72..4b01103f8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1979,7 +1979,6 @@ F: examples/ethtool/
 F: doc/guides/sample_app_ug/ethtool.rst
 
 FIPS validation example
-M: Brian Dooley <brian.dooley@intel.com>
 M: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
 F: examples/fips_validation/
 F: doc/guides/sample_app_ug/fips_validation.rst
-- 
2.25.1

