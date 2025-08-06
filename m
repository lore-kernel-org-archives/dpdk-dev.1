Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7321CC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 13:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EABE5402DB;
	Wed,  6 Aug 2025 15:38:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 823FB400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 15:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754487524; x=1786023524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W29/i8VjrbwwrLeGY1Js2eK3BFdRK+Ch4qJOfHsEfMg=;
 b=aCnnXrMi4TjA5QPW4W0XcH9ntHWMgQCqO9pFyGL0oNi8sbqxeRfcz4Wn
 tsHXcBUJ3NiJ5hqaEmSk+0oI4gvzqM2qKdd1jW/1EGUISnsY+iRs2xKrD
 zHf8ckT+gmlV/m7PJ6f4c7Lt3LULh0awjzRaoiwJV/c31kvwrQC0oV5GG
 kq7fHWPEUmGErzERBHV/KejtbHDNvbzndAymahC93ifUaYvbufn97yg9c
 OkrjuWjeJyrgzv0PBMsdl6bI3nWWLuCcGlvFyy0a9wIDuqlVw+9qC1ONR
 sz1Uu0EYXF52moQ+xfmg+9PlK1EDqj4YzG7uk4HU3AFWmxmU8mAiI4nya A==;
X-CSE-ConnectionGUID: imfbUYNmQNa3Lkn2cLkIMQ==
X-CSE-MsgGUID: T2FwFf6HR122+twRUZAJhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56769214"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="56769214"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 06:38:44 -0700
X-CSE-ConnectionGUID: pUikiZwhQA6ISHbEPVQzTg==
X-CSE-MsgGUID: A0M9cBGfRfm6zvXEEA8Tzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="201942373"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by orviesa001.jf.intel.com with ESMTP; 06 Aug 2025 06:38:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/3] dma/idxd: use DPDK basename function
Date: Wed,  6 Aug 2025 13:38:33 +0000
Message-ID: <20250806133833.3236170-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806133833.3236170-1-bruce.richardson@intel.com>
References: <20250806133833.3236170-1-bruce.richardson@intel.com>
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

Even though the idxd_bus.c file is linux-only, we can simplify the code
through using rte_basename rather than just basename. Since rte_basename
does not modify its parameter, we can eliminate the strdup and free, and
since it also handles NULL sanely, we can remove an extra NULL check.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/dma/idxd/idxd_bus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index ba8076715d..5ae42151e6 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -260,17 +260,14 @@ static int search_devargs(const char *name)
 static int
 is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
 {
-	char *runtime_dir = strdup(rte_eal_get_runtime_dir());
+	char prefix[256];
 	int retval = 0;
-	int prefixlen;
-	char *prefix;
+	size_t prefixlen;
 
-	if (runtime_dir == NULL)
+	prefixlen = rte_basename(rte_eal_get_runtime_dir(), prefix, sizeof(prefix));
+	if (prefixlen >= sizeof(prefix) || strcmp(prefix, ".") == 0)
 		return retval;
 
-	prefix = basename(runtime_dir);
-	prefixlen = strlen(prefix);
-
 	if (strncmp(name, "dpdk_", 5) == 0)
 		retval = 1;
 	if (strncmp(name, prefix, prefixlen) == 0 && name[prefixlen] == '_')
@@ -283,7 +280,6 @@ is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
 			retval = !search_devargs(dev->device.name);
 	}
 
-	free(runtime_dir);
 	return retval;
 }
 
-- 
2.48.1

