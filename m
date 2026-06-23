Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4268CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0915440691;
	Tue, 23 Jun 2026 18:52:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 4A97B4029D;
 Tue, 23 Jun 2026 18:52:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233526; x=1813769526;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aeIc1pHzB5c/i6Ju9kpJYIjfQHoXVm05hwDmuzOiRKk=;
 b=fGVTPPc7FvsbY9zZq6j0pW0z1cBDk6mxBdOdylItcW+x2RXs4vbOMrlj
 6ZsAP3ut/8+N2aicClk1JnJB5pEbh0dlny70xKsNRIkDhQEFqZAeyAgls
 mny+vqIsmw1ABKJ7eSmZMjObJLF81NyJW/TwRvr1FYZERghfME74HKl3W
 gtw7Dvt64rySEpfB+avdyvyjhNFhKd958ZWNroooe99nn/DQ5cLpe3DxS
 0n0ah2h1IWQ+0YBVYEQ8XeIHDqSCSPY8pdODyW+vQltvPgvnLLlsD9jFF
 kA7L7rqUWe7PMxOQ23gLPq8pPhKN5yd7DdXt/+qypzYa7DuGvrbwVuSuX Q==;
X-CSE-ConnectionGUID: 9L691NLfTjuSqEQFjL2HVA==
X-CSE-MsgGUID: x3iIuTeLRQCVcWCRuYMzlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534637"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534637"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:05 -0700
X-CSE-ConnectionGUID: FeUL8MSKQ6e/zbsfiI78EQ==
X-CSE-MsgGUID: N2OogoGZQ5Wcq6jfAaM/6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928304"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>
Subject: [PATCH 05/17] event/cnxk: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:35 +0100
Message-ID: <20260623165150.765443-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

