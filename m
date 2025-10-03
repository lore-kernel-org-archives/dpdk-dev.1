Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E70CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02B10402B5;
	Fri,  3 Oct 2025 10:15:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4B74540262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479316; x=1791015316;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6DgX2Oz92RSyYqiVVJmLE82m4QpP3C0nWu7kicAI6ZU=;
 b=hlPVaG81f+BIgynaZAa11Qz2WAGaB11s8tLwhhC0ED9qn1+gSNS09QtT
 7FDWSLOTtK2a7BwQdDp+GTxW3D7xsx2wcNGweZJqvnPU1gt5gpO2f34/k
 6Nr3slxLeYPEjcHAs18zFTFdWIjfXMHhDXQ4Kc01gS8/e++W2kzsTArbF
 BPSzGDguSlF3jYIFAgKUUyCUCKuM/opT7+c3iJMBvQprbYDvs3GUtLPYm
 Hw99E3A4l6tQCMGm5Cz3Si2qr8zxEQJFApSh0vFqDGVk/PDqm2jAeRrxj
 W+nt/JI+2jfz5SLnGoKSTab1vIw0RiIjk37YizJkQGTEb159ghY+0/3Ga A==;
X-CSE-ConnectionGUID: Uq/SP75qSW+A+wfzC3/W4w==
X-CSE-MsgGUID: VC8OFcFiS/aXfyUiBAfW+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473537"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473537"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:14 -0700
X-CSE-ConnectionGUID: DYzhRTV+RkquVus7NsNk+Q==
X-CSE-MsgGUID: h1WgvUKWRlOP+TA7vyLkeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525797"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 01/18] build: add define for the OS environment name
Date: Fri,  3 Oct 2025 09:14:53 +0100
Message-ID: <20251003081510.1197166-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003081510.1197166-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
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
index ca63ee10b1..b8c1f127a2 100644
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

