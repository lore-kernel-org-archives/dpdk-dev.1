Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CCCC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 12:25:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E55D41104;
	Thu, 12 Jun 2025 14:25:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B8805410F6
 for <dev@dpdk.org>; Thu, 12 Jun 2025 14:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749731108; x=1781267108;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j+CQ/xVB9OzrLaJjhzhhW3iHQQgZ5yzOobi8w4xkJcY=;
 b=R9VQVypEZ0vvq5J2wCQacDNGK2BbtJNWiffJ5Ri/h+mL4Ft1vN7ptaVI
 ZqOxgncZH6FKymYbr0nLQCZHCzFz/embv6vzhDkzXjl7ISq2iTlK6u6Xo
 PzcD2aRlbNztIXycjWlFmowUPprmtoD6ZorYjiGJ19ls+/Qekgl4ODqq7
 IIETCNp2/Lh8DSA/WUQ7NVeeoioyqbr9cFMGR18U/NexgSDcRk4rSjX8v
 jPYd0f1qefV6fwHWK3IaLHuZaNpL1bwkOz8AIu/k354Pw6P9HAJ7CT5p2
 N/AV9BsoQ1qCvGLPZwEPbMr+YCyZ/JyHnSblI7ETGK6PJIPPLic1szkGC A==;
X-CSE-ConnectionGUID: 7j7bZr5aRjSoY1XlXauB1w==
X-CSE-MsgGUID: SdGoIrG6RaG1XkNL8guj8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="62557376"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62557376"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 05:25:01 -0700
X-CSE-ConnectionGUID: 9TDetH/LQciViZEy/+AJSA==
X-CSE-MsgGUID: YlPLRl9LQfetFeJBk3wetA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152650657"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 12 Jun 2025 05:24:55 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v1 1/2] doc: update recommended matching list for cpfl PMD
Date: Thu, 12 Jun 2025 17:55:42 +0530
Message-Id: <20250612122543.146876-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612122543.146876-1-shaiq.wani@intel.com>
References: <20250612121322.146355-1-shaiq.wani@intel.com>
 <20250612122543.146876-1-shaiq.wani@intel.com>
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

