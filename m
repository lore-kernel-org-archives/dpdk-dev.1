Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDD310F3DCD
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE7BC40668;
	Mon, 30 Mar 2026 16:14:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7E735402D3
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880066; x=1806416066;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bRxJ0iyMRDOpC5k5+D5GfJfOMZfeDzQYC3HUfUDPII4=;
 b=aF04UZDBbIUHUJsNdbQ5W61Bp8hn2TEu9ZFD1qqPPX+Y1f1aUzeCp5np
 nVY2tNwSx673YKHTtHiiS2rG7RjvRBwe1dYCUKgSg63hcO19ZbXn3oKxV
 CHIKUu7xMcndb/R7TcaxP2N6I/MRp/Z363/PCdWxwOo923F+AWctTp07Z
 ZDP7KKXBLJBIQZYgiWILC+RWD89C64+nZpqdrPRWJt/PQakrkqQK6ZoMO
 shPJXnlRaQ6HFqtabMH7nyZIl5RllcUWFBZ9/FNTXUng1zYPHbNEwX7w7
 7DuUruY8HUw4yuxu8ZSHsAKmoGnOyrawjHJW6Dv7chiYE9ErSahpfPWGa A==;
X-CSE-ConnectionGUID: ovsKa94tQu26XPMwduDSTA==
X-CSE-MsgGUID: P8bFV73gQdmqvLbCVGJ5FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75761662"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75761662"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:14:25 -0700
X-CSE-ConnectionGUID: LRx+Dw6LTnOp/1C6tm9X2w==
X-CSE-MsgGUID: veeeoXlyRW6nbYtyLaXWUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249123037"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 07:14:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org,
	john.mcnamara@intel.com
Cc: Hailin Xu <hailinx.xu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/6] net/ice: update version matching table
Date: Mon, 30 Mar 2026 15:11:04 +0100
Message-ID: <20260330141415.1267233-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330141415.1267233-1-bruce.richardson@intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
 <20260330141415.1267233-1-bruce.richardson@intel.com>
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

From: Hailin Xu <hailinx.xu@intel.com>

Update table with latest versions verified for 26.03 release.

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/ice.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index da3da3d396..4b0f4c4e44 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -61,6 +61,8 @@ are listed in the Tested Platforms section of the Release Notes for each release
    +-----------+---------------+--------------+-----------+--------------+----------+----------+
    |    DPDK   | Kernel Driver | Default DDP  | COMMS DDP | Wireless DDP |  E810 FW |  E830 FW |
    +===========+===============+==============+===========+==============+==========+==========+
+   |    26.03  |     2.4.5     |   1.3.53     |  1.3.61   |    1.3.25    |    4.91  |    1.20  |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
    |    25.11  |     2.3.14    |   1.3.43     |  1.3.55   |    1.3.25    |    4.9   |    1.11  |
    +-----------+---------------+--------------+-----------+--------------+----------+----------+
    |    24.11  |     1.15.4    |   1.3.36     |  1.3.46   |    1.3.14    |    4.6   |          |
-- 
2.51.0

