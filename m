Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D1D37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:48:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B93F40E38;
	Wed, 14 Jan 2026 16:45:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6B0C640B95
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405556; x=1799941556;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CelLIm6zw9UWnK41NiaSwbaAACWAdNpPSnr14FcXtrc=;
 b=a9DIkyn1A16s3ZFmSPiqxQTejbPVJKlZdOrS7st0n/UyFkAkeYzaBD+3
 LHcqn31ZGUGItG1IoyaKeE6+REsRRZ6njp8U3O0BMC62oHgVXdAoC2x+Y
 hlfgrhc9Df5MZEXb8jEXXhu8sv1Pm13ZXXNv3pmz4cQ3D9g5PVEMc9ZJD
 K8oWYT3IQxvnifZzN4sIY/utvqQzIWiLLInmIYWxMoyV5mkaJFRKD3ySa
 zSIMLzidm41slgBKm7HljJAABjjGuUigmXm/0OIoytg/HtSnQnO9khAxo
 e06ws6ULmqHpsCyqxNENTTWGH14bcacYpmVkBQRg3ls97+5kCSAuyKVY0 A==;
X-CSE-ConnectionGUID: keeJpYioTcCjzR+1fpywUA==
X-CSE-MsgGUID: G/w5Gn3aTPaUTMtLpeK4nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69871000"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69871000"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:56 -0800
X-CSE-ConnectionGUID: 9Fl+rahuTkyqW8hgilDmQg==
X-CSE-MsgGUID: MK5VP26oRxWwsYMxk1cchw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925135"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:54 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 29/31] app/test: disable shadowing warnings for unit tests
Date: Wed, 14 Jan 2026 15:44:43 +0000
Message-ID: <20260114154450.2969716-30-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

