Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC89FFCE086
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7706740654;
	Thu, 26 Feb 2026 14:59:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9554340609
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772114393; x=1803650393;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=imkW3UklRL1ZnO+ISMeLsKnPpXibIx4IiIKnW9fYO20=;
 b=Ke53SQTQbnZoYCLpDVIAjolBo9o5OcEg+hsTuO2sqnS0Jwsun4VjuaJf
 G74EVTK2dHEF5s3ADOqugTYNwk0M+5stDfDijU8RL6nHG7aZowrBfHxSp
 Vt7YKtxQh6wI1F+ZOJiATb9ykd265IGSE1BBFsrq1Ho6dzQVXlxHMqmBl
 pb8UB1Ck4Q1X+cmYYWqw+K/KgFtwvQZKY7mBD0y38Z3EvEE6EfyEjHtC3
 +vZgXDlsYE5wtnfv8Ew1CmTNATt0gkV//WD9bF4qgRicWtj40Zj3T+tLZ
 N9CGVSGgJkThpDZjeD3zSa+yGgcwkv9YhP2hBS7Z/7BN7VHqWfeQn0Hla g==;
X-CSE-ConnectionGUID: jjSwW/wNSrGyTAjVml9RNA==
X-CSE-MsgGUID: GVbhF/5bQuOpUGXmAyOKtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73219060"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73219060"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:59:52 -0800
X-CSE-ConnectionGUID: 46ZWLZT7RlK4cG4Fr2sZ5Q==
X-CSE-MsgGUID: MixQMXlSQlSN6xRtlLIIkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216588108"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 26 Feb 2026 05:59:52 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 2/2] doc: add deprecation notice for vDPA driver API
Date: Thu, 26 Feb 2026 13:59:48 +0000
Message-ID: <23a68460300ca4fd5e0b66c09b1e580b878af0ea.1772114309.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772114309.git.anatoly.burakov@intel.com>
 <cover.1772114309.git.anatoly.burakov@intel.com>
References: 
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

Currently, vDPA driver API is partly built around VFIO group API, which
will be removed in a future release and replaced with a device container
assignment API. Make this know in deprecation notice.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index a94691daf6..4bfbb7468e 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -143,3 +143,6 @@ Deprecation Notices
 * eal: The entire VFIO API (``rte_vfio_*``) will be made internal only, and will only be available to EAL and drivers.
   Group-based API (``rte_vfio_*_group_*``) will be removed and replaced with unified container device assignment API.
   This change will be made in 26.11 release.
+
+* vdpa: vDPA driver API will no longer offer ``get_vfio_group_fd`` as part of its internal API.
+  All drivers will be adjusted to use the new unified VFIO container device assignment API.
-- 
2.47.3

