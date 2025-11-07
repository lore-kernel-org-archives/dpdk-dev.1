Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06368CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:54:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E34A40E32;
	Fri,  7 Nov 2025 16:51:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id CEF52402F0
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530714; x=1794066714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=od4tMa8xgrP6SQEJWd111nqy4vHCc54XvwxbNlSPSwA=;
 b=gfppv7Vr0jt1LhjjG3ryiEBHKw2LTtUCyw+KwXdTmcCGtxeGqySCHoCL
 iBm+eh45Fmwe768CwULNBc4YugvlDrjPA0Ofcb4dsjb5LaZRvzf4QaJ6K
 7RQRaz9HReba2KEw0wHp7TCKJfYKw7b2z5buxHyzkbm4AGA80boosHwLP
 vQ18nYPlyfsowaYm3q9+xkYS2z60ROlfJiha2Zlu+mvKIFTUPA21uRLcU
 D7K3lg1bgZCfCp1qS0D99x/mNG/FNB/kMAUVMEIcstEJMX1PoTsXJRQDE
 AYIxGb6GbKYh3C+CFH+3zf9AvJMSTfkrQZCJOzGKUr9cEQNxk/lBp5RrE g==;
X-CSE-ConnectionGUID: vFdHsrNNRD6J0Mw/V2sHYA==
X-CSE-MsgGUID: BeV/ZMjiRqSkJxtq931Fpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64589362"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64589362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:53 -0800
X-CSE-ConnectionGUID: 8ybkht9ARiqOYJ5NXAWbXw==
X-CSE-MsgGUID: I5u7qPVwSCi49cdEpWV3MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321814"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:52 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v2 31/33] app/test: disable shadowing warnings for unit
 tests
Date: Fri,  7 Nov 2025 15:50:27 +0000
Message-ID: <20251107155034.436809-32-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

The dpdk-test binary has multiple issues with variable shadowing. For
now, explicitly ignore shadowing warnings in this app.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test/meson.build b/app/test/meson.build
index 8df8d3edd1..9d4a88d976 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -256,6 +256,7 @@ foreach d:optional_deps
 endforeach
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
-- 
2.48.1

