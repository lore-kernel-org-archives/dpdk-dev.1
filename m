Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D320AC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 12:24:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3E374060F;
	Thu, 22 Jan 2026 13:24:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C4D734060F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:24:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769084663; x=1800620663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c+4tA7fnaOddpmYymeAQ+R9mrRjS3lufXEUFW8huloU=;
 b=TQZKq1C1Ty4MyA99VOnR5UbvFpe+ty5RkhQ/HfX87XQycP9t8szh873Z
 r8zZSVxSHGoSn79Vdl8u9uEt65pRMBo4klndY2aNQV2zvalM3POcrjXwK
 Kqvi9BYcKIgeBepaBlx1LXhk3Z2cX7+XYyiACbEFd7NLoJgA3OGl4ROu5
 02prltDYSStIUqXA7TflCr2ZdS6cggP5vZO7aMJvHQQVUBEAZNPkH5bX0
 z7QPwqSK6967fVcdSjhBLA7JwQFImVyVXdawHKdODqBgNNHy4KHssBi19
 AyxmMFoX+vHUyEY44vK88RcWv2OwrH43wL6cCHRBRdu7pVXlvW00dq7/8 w==;
X-CSE-ConnectionGUID: MpcvsueeROiEaaB+Nr8y3w==
X-CSE-MsgGUID: sAnr3RPuTVeO5aQEB0d51Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81436285"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="81436285"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 04:24:22 -0800
X-CSE-ConnectionGUID: YMBvruY+S2+CyZaYCeuspw==
X-CSE-MsgGUID: cDNdtTdHS7Knp/GgDSpEqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="205971754"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 22 Jan 2026 04:24:22 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Date: Thu, 22 Jan 2026 12:23:53 +0000
Message-ID: <20260122122354.1820368-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122122354.1820368-1-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
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

Having the net_null driver always available can be convenient and allows
use by unit tests, so add this trivial driver to the always-enable list.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

---
I'm not sure if we want this to be always enabled or not, so sending
this as an RFC. I can see definite advantages to doing so, but I also
dislike having too many components on the always-enable list.

Since I'm ambivilent myself, including this patch so the community can
decide.
---
 drivers/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 3fe3be48fb..9ed0dba786 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -80,6 +80,8 @@ endif
 always_enable = ['bus/pci', 'bus/vdev']
 # we always need a mempool driver, and ring is default, so make it mandatory
 always_enable += ['mempool/ring']
+# unit tests take advantage of net/null driver, so always enable it
+always_enable += ['net/null']
 enable_drivers += always_enable
 
 default_cflags = machine_args
-- 
2.51.0

