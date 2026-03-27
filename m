Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D7310ED674
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 13:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F078942E45;
	Fri, 27 Mar 2026 14:05:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 88F2742D8C
 for <dev@dpdk.org>; Fri, 27 Mar 2026 14:05:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774616712; x=1806152712;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GZMOjUR8UVF0GXzG7L764hWKAaPZDcheVrd23Y3ugMw=;
 b=ATxA0rKlUtsJvGgGprryx91obgSGKbblk/omkjVMkZCrak/01riRRuOJ
 VRjvSBTjwb656SebsImVczGjCJghtfe3RbmsTLr7Jk5YF5Xp5CFPXUA0I
 zJuGSdXeNUYTvxWb7kOWGRUCqiNyFBbicaf3jw5eE15pYiOGPiDtc3SfK
 rVUVk6w0CP1+VDO29Dxnb1Osh3ecukOxouckvV66zkc3D00d1rSeGCVLa
 asPHy4mJ+FAmxci1mnUGOm/mvqXIo/IYhrd/lJFkwOlySPlpr8JkOttln
 jqDHxrMIew5WNgFcwy0a5CoYAPqjpv+fuu6wrkkpgU8NFTv07QjRhCe8A g==;
X-CSE-ConnectionGUID: +BbzIcrNTiuTi/EAZj/q8A==
X-CSE-MsgGUID: 6dazjkT2TKilI223rR8RKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75654590"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="75654590"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:05:11 -0700
X-CSE-ConnectionGUID: U5HpqQL8RnK7OTM5YwbGOA==
X-CSE-MsgGUID: LrGQhesGQwWrE56T27Jf9Q==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2026 06:05:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: john.mcnamara@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 2/4] net/ice: remove non-LTS releases from version table
Date: Fri, 27 Mar 2026 13:04:45 +0000
Message-ID: <20260327130448.1033651-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327130448.1033651-1-bruce.richardson@intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
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

Since non-LTS releases are not supported with updates beyond their
release cycle, and 21.11 is now well past its support date, remove all
unsupported releases from our version table.  Also reverse the order of
the entries to be newest first, to match that in i40e.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/ice.rst | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 65fb2c7718..086d075707 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -61,31 +61,13 @@ are listed in the Tested Platforms section of the Release Notes for each release
    +-----------+---------------+-----------------+-----------+--------------+----------+----------+
    |    DPDK   | Kernel Driver | OS Default DDP  | COMMS DDP | Wireless DDP |  E810 FW |  E830 FW |
    +===========+===============+=================+===========+==============+==========+==========+
-   |    21.11  |     1.7.16    |      1.3.27     |  1.3.31   |    1.3.7     |    3.1   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    22.03  |     1.8.3     |      1.3.28     |  1.3.35   |    1.3.8     |    3.2   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    22.07  |     1.9.11    |      1.3.30     |  1.3.37   |    1.3.10    |    4.0   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    22.11  |     1.10.1    |      1.3.30     |  1.3.37   |    1.3.10    |    4.1   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    23.03  |     1.11.1    |      1.3.30     |  1.3.40   |    1.3.10    |    4.2   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    23.07  |     1.12.6    |      1.3.35     |  1.3.45   |    1.3.13    |    4.3   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    23.11  |     1.13.7    |      1.3.36     |  1.3.46   |    1.3.14    |    4.4   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    24.03  |     1.13.7    |      1.3.35     |  1.3.45   |    1.3.13    |    4.4   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    24.07  |     1.14.11   |      1.3.36     |  1.3.46   |    1.3.14    |    4.5   |          |
+   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    4.9   |    1.11  |
    +-----------+---------------+-----------------+-----------+--------------+----------+----------+
    |    24.11  |     1.15.4    |      1.3.36     |  1.3.46   |    1.3.14    |    4.6   |          |
    +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    25.03  |     1.16.3    |      1.3.39     |  1.3.53   |    1.3.14    |    4.7   |          |
-   +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    4.8   |    1.0   |
+   |    23.11  |     1.13.7    |      1.3.36     |  1.3.46   |    1.3.14    |    4.4   |          |
    +-----------+---------------+-----------------+-----------+--------------+----------+----------+
-   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    4.9   |    1.11  |
+   |    22.11  |     1.10.1    |      1.3.30     |  1.3.37   |    1.3.10    |    4.1   |          |
    +-----------+---------------+-----------------+-----------+--------------+----------+----------+
 
 
-- 
2.51.0

