Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869B9CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FFE2402EE;
	Fri, 16 Oct 2026 13:00:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0B7C5400D5;
 Fri, 16 Oct 2026 13:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148406; x=1823684406;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MVX9RWAlAvbaUNQejalnqh2p36AkilEIyQ0Semywknw=;
 b=Q2HEufWooBt0EX6W2yuGQcO5IcuiDajd/H8/JGinTSnzDQL0usL+v98J
 Owk8Wz6CovqwLAyaiw1AZwA2xDKAcaN6IPdCMibJcPZ6zzUhpp/C6iuf7
 b+0vhvIKbLFlZKE5hxvHUw529QPV4fxTJ0QZrNs5HxmmMY/sWX3Of0Atq
 7s4DHyn5ywF6AN8vdKfjqBaElOdUhcRASr5Omf4E8gDpMpd8zQwKXq9uy
 iqcGayAi2+/UCrgeyb3vyT0X/qm2tUMDSgX1xEbJHuLPAOPbyc4pEtN6N
 npNV5DuUN4QRLxrY+A/DvoQix445jJdZZByHun+cNCfJCaiJlUSmSs3Cy w==;
X-CSE-ConnectionGUID: DSaj/jO/QQWMCl/jpaXrpg==
X-CSE-MsgGUID: M9QSz8fQRGKSL5Ot+a1j+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944131"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944131"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:05 -0700
X-CSE-ConnectionGUID: UzLZh0YGQ3Wjfj8vVxl1KA==
X-CSE-MsgGUID: kAsMwmLpQ9mXoQOX3IbQdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759371"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 02/12] build: fix ignoring requested driver when class is
 disabled
Date: Fri, 16 Oct 2026 11:59:40 +0100
Message-ID: <20261016105950.273068-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016105950.273068-1-bruce.richardson@intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
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

When a whole driver class is disabled due to missing dependencies, we
are silently ignoring the fact that the user may have requested drivers
of that class and therefore that the build configuration should fail.
This can be seen by configuring a build with parameters
"-Denable_drivers=event/sw -Ddisable_libs=eventdev". With eventdev
disabled, all event drivers are never considered and no error from this
misconfiguration results.

Fix this by adding a check for requested drivers when disabling a whole
class of devices.

Fixes: 70b6941e4e22 ("build: check drivers class dependencies early")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 02adf51173..b761e19be5 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -119,6 +119,14 @@ foreach subpath:subdirs
                 endif
                 message('Disabling @1@/* drivers: missing internal dependency "@0@"'
                         .format(d, class))
+                # error out if a driver in this class was explicitly requested,
+                # i.e. not via wildcard, since it can now never be built.
+                foreach drv_path : get_option('enable_drivers').split(',')
+                    if drv_path.startswith(class + '/')
+                        error('Cannot build explicitly requested driver "@0@".\n'.format(drv_path)
+                                +'\tReason: missing internal dependency "@0@"'.format(d))
+                    endif
+                endforeach
                 break
             endif
         endforeach
-- 
2.53.0

