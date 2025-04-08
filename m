Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E8C369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 17:19:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 756F9402CD;
	Tue,  8 Apr 2025 19:19:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4845E40264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 19:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744132749; x=1775668749;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ctSObVBZVSlirE0ZJCK85x9m0pyP7XldS+/0g2gNzfw=;
 b=KdWBYIU/KtLHYZw+PWnh06bWxtGBItOIobZHtlPJ+PvLdwFUdQzgkRvf
 owX+eRGTsHPb+rmUt+dIqBtDmOb1JImdrVsKDH2gjssv8G6kjIYqzUks6
 oQmrMO++ftKTjFf7VsAqxaXl1QnjNGGHeIiXZjHCRTdx617MJawH1ibBj
 sNXEIyUoHGUaQZ3LxHu02VbyOdq4LkBcNLh3AbR9QSiwIE2bQ6C2T0pL8
 wQYgZFgfOZZQQw/xXACyWsFTQZnJvGHnjWt7bpNzv0Ap7DpN1LuU8yt94
 nBo6ZeTJKT7D8+4D4TNeNJ9JkNBBik4Iun9Lt6NxrUqZwYB78i/xAfT8D A==;
X-CSE-ConnectionGUID: expCcPstR8ObrhQDbSMG3g==
X-CSE-MsgGUID: HHcifabZRoSjIEZJaqvTdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56247222"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="56247222"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 10:19:08 -0700
X-CSE-ConnectionGUID: JScBjEwBQUeCg3uY2lPN/Q==
X-CSE-MsgGUID: 2DppgNIMT8GgRtwTsi2cQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128231262"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa010.jf.intel.com with ESMTP; 08 Apr 2025 10:19:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] doc/linux_gsg: remove note referring to old pkg-config
Date: Tue,  8 Apr 2025 18:19:02 +0100
Message-ID: <20250408171902.2833850-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

Latest DPDK releases no longer officially support RHEL 7 as a target
platform, so remove the note about pkg-config not working on those
systems.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/sys_reqs.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 5a7d9e4a43..4c9d0c55c0 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -35,13 +35,6 @@ Compilation of the DPDK
     * For Ubuntu/Debian systems these can be installed using ``apt install build-essential``
     * For Alpine Linux, ``apk add alpine-sdk bsd-compat-headers``
 
-.. note::
-
-   pkg-config 0.27, supplied with RHEL-7,
-   does not process the Libs.private section correctly,
-   resulting in statically linked applications not being linked properly.
-   Use an updated version of ``pkg-config`` or ``pkgconf`` instead when building applications
-
 *   Python 3.6 or later.
 
 *   Meson (version 0.57+) and ninja
-- 
2.45.2

