Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD13FD1F9C2
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 11:29:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D779C4060A;
	Thu,  4 Dec 2025 12:29:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0D4F24060A;
 Thu,  4 Dec 2025 12:29:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764847757; x=1796383757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uvolt1EYpL0xgTsLqYCwutleslYV+gqCYupOpscxLcw=;
 b=hXUANadCzxmUKvy/VqC5X9BbWO3ffLEapHUAVo4W5BNwYPvV3uCHljkZ
 IIKHPueRfgwMytMEs9kLQvCMs8S04f7pxMGbQtqxwqGjlKX17vOTZXyN0
 qQVlq4q55Zxs0uSwn35IdC9P5wFOruNE8owOTaC7OdONXQORExQKVEV5z
 0QBwsiwHy+2ABwryosuCWNyuAY+geG3QpBhWFOg5gDxGGvjiBXs+HpAag
 heV5Zoi9VFOsRBLuyXSN9z8aAQlCqGBfnW+qsBgWSAA6U0w5NbbWNyb5Y
 4FCPC5XeNppsHUF41Ay8tTMzMlZnfJrebg8E5kednsr6bVGl1jI9gx5k4 Q==;
X-CSE-ConnectionGUID: dkiDeFQORpaaJnTkWOuzsA==
X-CSE-MsgGUID: FLZhxRPyR6m13jGBGNXzcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="78330221"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; d="scan'208";a="78330221"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 03:29:11 -0800
X-CSE-ConnectionGUID: UlvNBxitQLiUZ6NXxPYb5w==
X-CSE-MsgGUID: N4EpXNNbQtKWtO637hXrWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; d="scan'208";a="195370587"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2025 03:29:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 2/2] net/ice: disable warning in base code for Windows builds
Date: Thu,  4 Dec 2025 11:29:03 +0000
Message-ID: <20251204112904.2869502-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204112904.2869502-1-bruce.richardson@intel.com>
References: <20251204112904.2869502-1-bruce.richardson@intel.com>
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

Disable warning about "zero extending 'unsigned long' to 'u64' of
greater size" in base code builds.

Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/base/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
index f46dbb265f..fd079c41cf 100644
--- a/drivers/net/intel/ice/base/meson.build
+++ b/drivers/net/intel/ice/base/meson.build
@@ -35,6 +35,7 @@ if is_ms_compiler
     error_cflags = [
             '/wd4101', # unreferenced local variable
             '/wd4334', # result of 32-bit shift implicitly converted to 64 bits
+            '/wd4319', # zero extending 'unsigned long' to 'u64' of greater size
     ]
 else
     error_cflags = [
-- 
2.51.0

