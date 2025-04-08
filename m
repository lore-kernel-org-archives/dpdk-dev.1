Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1BBC369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 17:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62C5C40267;
	Tue,  8 Apr 2025 19:18:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 44C8440264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 19:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744132721; x=1775668721;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KSzZSty3e19XD04rhRyHfe7MTBOq+n3Rghwwgo6PxmE=;
 b=gGeFI8Hbj5B+IV/17kI8+TQHqRrdO6mPgOhuh7xMYmq/I01CYho2Agpi
 3yUTf5idJlNN8sZJ1O0dJ4Oal1wcL3GqBh/zHJ3MVybspALnTOG1ZlPdU
 Nbfs+WwiNoZVlAIj/omdWRarIwLBt7VMZjXkh10dCCNXn3fLlzXVom4t8
 OseRASuElRpe/exT0jjPVS2VKGaU5kS4fLemV6Yo502w2Pt1jYyuCGgAD
 z5LEyc6YOPYq8jBjBbUudW7nx4FnxRZKadHfHK/EEphg9mCGnlEfwkFq3
 r1A4xfKMrpU5vYSH9VHAneMi+dCZYX19Ax6/V7luCpcp0+XCD6nmJzZPq Q==;
X-CSE-ConnectionGUID: 73JBMmSNTyGt0c5dvbbJEg==
X-CSE-MsgGUID: Z+RVakTjTPS4a2zqamIV6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56247178"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="56247178"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 10:18:40 -0700
X-CSE-ConnectionGUID: t1rR8KKDSBGnYHwNwYUbXQ==
X-CSE-MsgGUID: V5ncqAgLQbiP8PgIVq6yRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128231191"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa010.jf.intel.com with ESMTP; 08 Apr 2025 10:18:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] doc/linux_gsg: update recommended compiler versions
Date: Tue,  8 Apr 2025 18:18:35 +0100
Message-ID: <20250408171835.2833766-1-bruce.richardson@intel.com>
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

Rather than specifying a minimum compiler version, update the docs to
recommend a particular compiler version. In other words, earlier
versions may work, but are not officially supported, or may give reduced
functionality.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/sys_reqs.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 4c9d0c55c0..0acd26f260 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -28,7 +28,8 @@ Compilation of the DPDK
     For details on Linux distributions and the versions tested, please consult the DPDK Release Notes.
 
 *   General development tools including a C compiler supporting the C11 standard,
-    including standard atomics, for example: GCC (version 5.0+) or Clang (version 3.6+),
+    including standard atomics, for example:
+    GCC (version 8.0+ recommended) or Clang (version 7+ recommended),
     and ``pkg-config`` or ``pkgconf`` to be used when building end-user binaries against DPDK.
 
     * For RHEL/Fedora systems these can be installed using ``dnf groupinstall "Development Tools"``
-- 
2.45.2

