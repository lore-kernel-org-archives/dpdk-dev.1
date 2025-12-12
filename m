Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF1D4417D
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 817CB40E7C;
	Fri, 12 Dec 2025 12:06:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id ACCEE40E39;
 Fri, 12 Dec 2025 12:06:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765537606; x=1797073606;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pEZS93UgnNITXxHhp6T2erx6mmHtayOQme4rX1vZxV8=;
 b=XL3lurduOuiCToHrVs2Dq23dMA6JKEL8k3HpoUt2eO3YZnflqbbvtg5v
 WSRmugWN1kTigiXh9a6MXcEi6LPo7L4EdFmxJBF98qIeEX7BwT05INPIC
 kNq4aKc9pwCtlkTvYYsI+bOYARW6d7L0XIx5OsHhJLXn46TBhxGhRVTGV
 7G7bvqsoGyBO5PMe3WTU1BIbPSRUddcNq8+BHeVzm4qc6+0lScvqJCuyc
 Jwq0zaF7YmjRxc6tA3wTQli35wtwGJObXvGZFbWdYpI/lm51h9+9/Bkj0
 CZuukrK9LO42e1U9xoV5pJtnkvJNl8WHkPbxv4Y+70OIZPqvLHA3fcMTZ w==;
X-CSE-ConnectionGUID: YhwXJY29S2SEg4fCOjT4fg==
X-CSE-MsgGUID: oUSM6XZKR1SYIXSzmDLXEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67472057"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67472057"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 03:06:45 -0800
X-CSE-ConnectionGUID: R8WOax7bTM6GfobZr+Pa3w==
X-CSE-MsgGUID: 0K45kgVMQJ6B9TKUJJNkzA==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:06:44 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 09/10] docs: fix inline crypto feature status in iavf
 driver doc
Date: Fri, 12 Dec 2025 11:06:27 +0000
Message-ID: <20251212110628.1634703-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212110628.1634703-1-ciara.loftus@intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
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

inline crypto is only supported on the scalar path so change its status
to partially supported.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/iavf.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 6c9e97594f..0ba6f7dfd7 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -27,7 +27,7 @@ RSS key update       = Y
 RSS reta update      = Y
 VLAN filter          = Y
 Traffic manager      = Y
-Inline crypto        = Y
+Inline crypto        = P
 CRC offload          = Y
 VLAN offload         = P
 QinQ offload         = P
-- 
2.43.0

