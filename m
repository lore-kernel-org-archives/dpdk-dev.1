Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5556CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B16040A76;
	Wed, 24 Jun 2026 12:37:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 48AE84067A;
 Wed, 24 Jun 2026 12:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297441; x=1813833441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JOgJqqUd1gjaFLR00KY0jG1O/eCgP8fFGSUQ3DyCu84=;
 b=N7iq0cw0u8LWrMLzxg2JcQp2IFNm4FLqCaq38LN9bIPvAakZD7ckN6rZ
 exNMDXaG0fShefva19OpxWOPhvXU2douA3aIQYkH6391giGzjhR33M/Au
 v30vcNWdMXnykcTc161Uj26jFbdBiQ0m/mg5tOP0FFbNR2c8+1ATPunVf
 i/Uk2o5bsnWTtyRktWpgDIBkriy7/dsGMfo4hfGeFJ/9HSfNnahBd8DEq
 jweOmUiOozijYR0IL/TkEkV+oRBdtwKRQBng/JSj5MP9xv8vbz4SZUh4n
 a64mB464fAqT9GIuHbYbroQcZqUgWQZZLoVIjW7emTWHzzt6iVX5kGZ91 A==;
X-CSE-ConnectionGUID: wIlMaOfxQgynaoIjlrrZsA==
X-CSE-MsgGUID: K5j0ozfpRsOoneq+0QzV8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652364"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652364"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:20 -0700
X-CSE-ConnectionGUID: /GWBYE7fTsmkl48DmV+Bvw==
X-CSE-MsgGUID: 4s0u9EqqQ9awZEbyXURepw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460076"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Andrew Boyer <andrew.boyer@amd.com>,
 Alfredo Cardigliano <cardigliano@ntop.org>,
 Shannon Nelson <snelson@pensando.io>
Subject: [PATCH v2 10/17] net/ionic: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:49 +0100
Message-ID: <20260624103658.792750-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 5ef518098ec6 ("net/ionic: register and initialize adapter")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/ionic/ionic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ionic/ionic_main.c b/drivers/net/ionic/ionic_main.c
index 814bb3b8f4..d5545b1ecb 100644
--- a/drivers/net/ionic/ionic_main.c
+++ b/drivers/net/ionic/ionic_main.c
@@ -393,8 +393,8 @@ ionic_identify(struct ionic_adapter *adapter)
 	ident->drv.kernel_ver = 0;
 	snprintf(ident->drv.kernel_ver_str,
 		sizeof(ident->drv.kernel_ver_str), "DPDK");
-	strncpy(ident->drv.driver_ver_str, IONIC_DRV_VERSION,
-		sizeof(ident->drv.driver_ver_str) - 1);
+	strlcpy(ident->drv.driver_ver_str, IONIC_DRV_VERSION,
+		sizeof(ident->drv.driver_ver_str));
 
 	nwords = RTE_MIN(drv_size, cmd_size);
 	for (i = 0; i < nwords; i++)
-- 
2.53.0

