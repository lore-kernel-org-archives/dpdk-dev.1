Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C21CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A484540E22;
	Thu,  2 Oct 2025 19:43:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 25ECE4060B
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427006; x=1790963006;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o9KwQwOwTQAtMRGhwRRD81Fg3UqipV/jbIFr+3/nwvY=;
 b=IrV3U3dfh11nBdmixRFwV4cqCE4BRDy5seU0DIib+FVSBaUjZDXo3veD
 3UXTRU6PdnOuwUxtTy4ZXptG8AAViay2aD/LKtu2QfahRbqUEKzmq33sX
 GO44wDO4JnZJfJ8CIINYB/mct8yyqPL6RwylCD79qEFNhacmHmHCBRmLl
 NFwCws8hx0ahBsixMDC9pthPokziVw3PHA8lv7gFGCduimLSOIfjDBclb
 BoqlUzKDke248MtlhRkEczuGW1JAlEP/QFtGutj4WW4cbCXnT9L0dC8uj
 gg/DW27WuDj/xTHd9qrKNlEX3pnsibNh91kNTknidS89cFPNIQui6lLZz w==;
X-CSE-ConnectionGUID: MFWLvLZcRT6ZN4ZmLBJswg==
X-CSE-MsgGUID: beSueCxySoyocICFvKhutQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271834"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271834"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:26 -0700
X-CSE-ConnectionGUID: G4s9T0YhR7arCDQftIF+5g==
X-CSE-MsgGUID: JL+cWJ7JSb+ysSE8t6Pg3w==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 01/18] build: add define for the OS environment name
Date: Thu,  2 Oct 2025 18:42:58 +0100
Message-ID: <20251002174315.962992-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251002174315.962992-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
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
index 55497f0bf5..495245d527 100644
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

