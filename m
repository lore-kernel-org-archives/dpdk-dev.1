Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C3C28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 01:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41AD940276;
	Fri, 21 Mar 2025 02:16:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B562240268
 for <dev@dpdk.org>; Fri, 21 Mar 2025 02:16:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742519786; x=1774055786;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n+4c2Kqo8XpLElUfo9Vst8nJ0QkvLdjBlAgCWaGlEOo=;
 b=dHZ6CbgcwNiMf1DqbujOLf5NMkElz7t5zs93HOBoYhD5l+YZbiJSD/me
 YPePFqmFIFFXmkiGxJZRO6vF6HYzPHBYXHsccSsSZZJLnfpzVoEvfi+vt
 4EnhZP2O0RQOO7EG8EtOfDMtp+ePscfLKzZ+njdIyVfZJrLLXiPZZTjBE
 7YUJNcMJ0uxBHPAnPwIpUWZ4m2zur2sTGx85WLhI1VPhzk+BqPzYQM5cJ
 koZvC4sxDDE4yreABcSttJrLocvmQZ2wZ1jFv+9OKDGwBCb6DIVTVB1c3
 rUXmjydj6FBYsr4LSgfDlzyQvM0elWc/EoRaUI5aR0turUwgteRdolS7w Q==;
X-CSE-ConnectionGUID: ej7RtbXZT2Ost1zQWKAHCA==
X-CSE-MsgGUID: kYY3mJ9rR/CiqUz69R8OGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43657727"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="43657727"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 18:16:25 -0700
X-CSE-ConnectionGUID: SjHTqDqeTBWjEq0onOq2Jw==
X-CSE-MsgGUID: jc5dzz4uQzuIypT+S2bEJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="123432806"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.12])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 18:16:22 -0700
From: hailinx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, hailinx <hailinx.xu@intel.com>
Subject: [PATCH v1] net/ice: updated latest recommended matching list
Date: Fri, 21 Mar 2025 08:36:22 +0800
Message-Id: <20250321003622.988446-1-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: hailinx <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 2603ef42d6..77985ae5a2 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -83,6 +83,8 @@ are listed in the Tested Platforms section of the Release Notes for each release
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    24.11  |     1.15.4    |      1.3.36     |  1.3.46   |    1.3.14    |    4.6    |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
+   |    25.03  |     1.16.3    |      1.3.39     |  1.3.53   |    1.3.14    |    4.7    |
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
 
 Dynamic Device Personalization (DDP) package loading
 ----------------------------------------------------
-- 
2.25.1

