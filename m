Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ACFCDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0B5E4066F;
	Wed, 24 Jun 2026 12:37:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B2E1740663;
 Wed, 24 Jun 2026 12:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297433; x=1813833433;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aeIc1pHzB5c/i6Ju9kpJYIjfQHoXVm05hwDmuzOiRKk=;
 b=HNgQP74zAVuPELfyu0NBeGgMXMpJFfySKuv98oNApRP2ptIbKpTTe0Zs
 QudEpUc017YDS3qwvVIjPzHZv9BGSmgKrI8BhfHIKOeDMGXoe8H7W0gPL
 bRXtPywU1VJl+CC1DiIiywkQ17RlyL3571SgOtaazBmbE59s5gG6Uhz/O
 unVTa0i/NWir/Xa0y3eTWPEmDSpmRA0pj7Vu+ZmcsGTRrN0JNcCXcc2Wx
 YKBbVrltJV0oRzPqYwGih6sYALBXkMrnh+Ms7N4riCAOiKytM5dqetlZb
 gVWITkSyw0hjGNfHmtgYx4Fn3uXij9TsRnAacu+w4eIf+t4v5KIIvTZNV w==;
X-CSE-ConnectionGUID: TlV14I9CQu6dSRMjZ4mCXQ==
X-CSE-MsgGUID: Cq/vXu45RfK7nLMmxOtlZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652346"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652346"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:12 -0700
X-CSE-ConnectionGUID: eMVqvYrSTnCCVbm2hJPPug==
X-CSE-MsgGUID: nmfUK6cjRbapZlJOR690eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460023"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>
Subject: [PATCH v2 05/17] event/cnxk: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:44 +0100
Message-ID: <20260624103658.792750-6-bruce.richardson@intel.com>
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

Fixes: b5a52c9d97e2 ("event/cnxk: add event port and queue xstats")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/event/cnxk/cnxk_eventdev_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/event/cnxk/cnxk_eventdev_stats.c b/drivers/event/cnxk/cnxk_eventdev_stats.c
index 6dea91aedf..288d34bd7e 100644
--- a/drivers/event/cnxk/cnxk_eventdev_stats.c
+++ b/drivers/event/cnxk/cnxk_eventdev_stats.c
@@ -283,7 +283,7 @@ cnxk_sso_xstats_get_names(const struct rte_eventdev *event_dev,
 
 	for (i = 0; i < xstats_mode_count; i++) {
 		xidx = i + start_offset;
-		strncpy(xstats_names[i].name, xstats_names_copy[xidx].name,
+		strlcpy(xstats_names[i].name, xstats_names_copy[xidx].name,
 			sizeof(xstats_names[i].name));
 		ids[i] = xidx;
 	}
-- 
2.53.0

