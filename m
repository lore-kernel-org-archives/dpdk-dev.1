Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6871C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 14:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9D9240668;
	Tue, 22 Jul 2025 16:04:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0FAE34003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 16:04:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753193068; x=1784729068;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4lHg7FQDAWnRbONKXMcKUl0C6d5fCZD0D72XrRwn150=;
 b=ds4dDA6QL7VY2tH7O8/s5sTlziO/Z2pyTCQBI8QDOz+OOFimoFBz/qzL
 6kCVlbf0pvvLWOWzC9BNYZ2CMZY5cOwvCjEASdS9zf/Pyqvaso2Feg0+d
 d9VccR7DOvyq/G0BjLpdTN+NImhlf5ybT7THr6jDgzr3LGz3AT/FOe6cW
 gXRcSFVHC92BqRf9qxzInA+LQcVHKxuoB7Gq8FCT6RyYPKs5J2pjSYsYa
 3N5DvEfedIjODUvHB11fXYkThZbaTbdUiA/yQTcxuSh36C2pbJX5V2oo4
 rIN5kqDEltonQjDzeeCL2WnaPLF+Vl/dD6uwA7YZJHboAYXsJ29x9/EUa g==;
X-CSE-ConnectionGUID: 1/twMsEcQIGPoDP00JN41g==
X-CSE-MsgGUID: LxrMNKYjTReindPJXgGHFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59241920"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="59241920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 07:03:56 -0700
X-CSE-ConnectionGUID: hyrZnlrFQJiQdfffH8DNCA==
X-CSE-MsgGUID: qJxG5SBJQ7y3UBSRgBU75Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="190104368"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa001.fm.intel.com with ESMTP; 22 Jul 2025 07:03:54 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 1/9] build: add define for the OS environment name
Date: Tue, 22 Jul 2025 15:03:06 +0100
Message-ID: <20250722140316.3568603-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250722140316.3568603-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250722140316.3568603-1-bruce.richardson@intel.com>
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

Introduce a string define for the currently running OS, or execution
environment.

Originally, with old make build system, CONFIG_RTE_EXEC_ENV used to hold
this name string, but the variable seems to have been missed in the
meson build system, until commit cadb255e25d6 ("eal: add OS defines for
C conditional checks") which introduced the RTE_EXEC_ENV for a different
purpose. Now we can fix the docs with the new name reference.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 config/meson.build                 | 1 +
 doc/guides/contributing/design.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config/meson.build b/config/meson.build
index f31fef216c..40f33816aa 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -20,6 +20,7 @@ foreach env, id:exec_envs
     dpdk_conf.set10('RTE_EXEC_ENV_IS_' + env.to_upper(), (exec_env == env))
 endforeach
 dpdk_conf.set('RTE_EXEC_ENV', exec_envs[exec_env])
+dpdk_conf.set_quoted('RTE_EXEC_ENV_NAME', exec_env)
 dpdk_conf.set('RTE_EXEC_ENV_' + exec_env.to_upper(), 1)
 
 # MS linker requires special treatment.
diff --git a/doc/guides/contributing/design.rst b/doc/guides/contributing/design.rst
index b724177ba1..5517613424 100644
--- a/doc/guides/contributing/design.rst
+++ b/doc/guides/contributing/design.rst
@@ -50,7 +50,7 @@ Per Execution Environment Sources
 
 The following macro options can be used:
 
-* ``RTE_EXEC_ENV`` is a string that contains the name of the executive environment.
+* ``RTE_EXEC_ENV_NAME`` is a string that contains the name of the executive environment.
 * ``RTE_EXEC_ENV_FREEBSD``, ``RTE_EXEC_ENV_LINUX`` or ``RTE_EXEC_ENV_WINDOWS`` are defined only if we are building for this execution environment.
 
 Mbuf features
-- 
2.48.1

