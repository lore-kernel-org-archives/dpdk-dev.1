Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E90CD116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:48:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2795340E26;
	Mon,  1 Dec 2025 12:45:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id CDCDF40DF5
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589534; x=1796125534;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CelLIm6zw9UWnK41NiaSwbaAACWAdNpPSnr14FcXtrc=;
 b=U52TMiSFA8KaXaK5RUCgoQYBRek1IAxmyOAgEyEmF25UIqOJrTAoYjZD
 iElSbJetDQ8Qfh+jqCCrrIGCNnfD/l+gDR+yhM8x6XEOF9UrgutQ9n9kg
 Pyll5WUuiISKZdwxpSvFTWuvJkxGlqF2PbHhNviE1DUYHfuMw1Qk0Scei
 TcSbxnCk6QOOBh4WwEIs6UXBFr3JNKFR2vce561y7atx8krJQaO9iuQyW
 QtoQb/8f+9BuQX+X6cwarutb/EhpdnchYSvnSFXxe1/ZyNQm7vDUD0H0m
 l1pSt3PkaMOpSv8wafyXKumdE1g5hSky89GjwdDB/8Cx5X4fo7dUjJYvp A==;
X-CSE-ConnectionGUID: hemYsA+KTi6eom06dYQOFw==
X-CSE-MsgGUID: dSL546JkSTOjpziEtnYaCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991778"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991778"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:33 -0800
X-CSE-ConnectionGUID: JrkiFPBWTQOvRDtrb+8zzQ==
X-CSE-MsgGUID: fwiJmofcTG+WQ1IuDeAFYw==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:33 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 29/31] app/test: disable shadowing warnings for unit tests
Date: Mon,  1 Dec 2025 11:44:46 +0000
Message-ID: <20251201114448.1441377-30-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..f4d04a6e42 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -256,6 +256,7 @@ foreach d:optional_deps
 endforeach
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
-- 
2.51.0

