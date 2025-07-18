Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE419C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 14:34:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 670DE40A6F;
	Fri, 18 Jul 2025 16:34:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id ABFAB4014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 16:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752849245; x=1784385245;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4lHg7FQDAWnRbONKXMcKUl0C6d5fCZD0D72XrRwn150=;
 b=jAl9Fa3FHmxEud1kT1L9RyFcRDnfV8TFsQnE9yZHJ0cwxFJ51SzrBKE6
 0F/5bZ4yonvN6HduGVIxOe1l9Zf5YTtaZ1gIt8oylKl6ZiQEOvlzbFoAN
 VQQFzeRsTpAMpjLVNHF18L5kh8akZ8gFkkR+A2N8UFO19Y60qZ8qxn5YT
 H7K3LEiyOxJhNryzrt3WGRtzZdbKmZ/E5DN3+ZUHLAyEC4MW0lCtJAnwk
 B6ym1MK2p5DQ9ylObha+WMqnWsKwOmUHw5En5kkOnTU5VxNtyV68cmmEe
 EMnTifoG0lXafsE0k48zeCcrT8kl6VL5HMIkTiIF5Bm6Y5xHb6LBqeI1R g==;
X-CSE-ConnectionGUID: s7vLoQsqTTaA9qqdsQHYwA==
X-CSE-MsgGUID: s63RsKuDQjicZ72NXavuVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="72597072"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="72597072"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 07:34:04 -0700
X-CSE-ConnectionGUID: pxzNv9sERCqaOI4K7n4bug==
X-CSE-MsgGUID: PbrbtkV3QGiBg1QqrHXtwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="162389297"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa005.fm.intel.com with ESMTP; 18 Jul 2025 07:34:02 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 1/9] build: add define for the OS environment name
Date: Fri, 18 Jul 2025 15:33:47 +0100
Message-ID: <20250718143356.1578988-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250718143356.1578988-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250718143356.1578988-1-bruce.richardson@intel.com>
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

