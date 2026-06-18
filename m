Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A44CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BD0340DDB;
	Thu, 18 Jun 2026 16:17:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8FCB340E13
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781792264; x=1813328264;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ruWbS0ANOnV76tbaaufKwWkHV6MImLHZITysH+pOLlY=;
 b=EQKAC/3KGq2Z1HOfyfp1t71I4qnoad95ie6fY9EOJ4Ai1ogMU/6fGVV6
 QHkhppHPEKp3uD0hX/KKMxiMNLJMxlnjYp8G+kUGoQPxE2UJjR6ZsP/cB
 qCS/pdcp6o7tznlyu9cE839IDXKKZ0mTrPDi/Arm4nr8RoLaGRhYCfb38
 wz4/Ih6nhW925Co/g+abOlXpbStLt77O/J0SByDYs4v0VX22EZXUSYdiK
 +F/Y9NrxmFk0AzgzJmFIMVwgr+PikgakJAr6ABSDRw4g4yN8fgkBQ3a3u
 rmQnbRTVdxg58jHpbLvdbBE1DKI0G7Y5eB0GhTEofQBoJZSRve5XPoQvi A==;
X-CSE-ConnectionGUID: n55blqknSxKrl+QXgvF4gg==
X-CSE-MsgGUID: Ebcth64qS1mWqjntgaAESA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81736972"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="81736972"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:17:43 -0700
X-CSE-ConnectionGUID: V+36+wl4ReyGUCLf5uMnVg==
X-CSE-MsgGUID: 2h7xSrFQRwyKVy0+Z9gbGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="248457630"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 07:17:42 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v2 4/7] net/ice/base: reduce default scheduler burst size
Date: Thu, 18 Jun 2026 10:44:39 -0400
Message-ID: <20260618144442.312844-5-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618144442.312844-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
 <20260618144442.312844-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

Reduce ICE_SCHED_DFLT_BURST_SIZE from 15 KB to 2 KB to improve
TX rate limiter granularity. The E810 TX scheduler uses a token
bucket algorithm where the burst size controls the maximum bytes
sent in a single burst before the rate limiter throttles.

A 15 KB burst allows micro-bursts of ~10 max-size frames, which
violates tight inter-packet spacing requirements in time-sensitive
networking applications such as SMPTE ST 2110-21 narrow-sender
compliance. Reducing to 2 KB forces near-constant-rate output
matching the configured shaper profile.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/ice/base/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 6d8c187689..39569ff3e3 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -1100,7 +1100,7 @@ enum ice_rl_type {
 #define ICE_SCHED_NO_SHARED_RL_PROF_ID	0xFFFF
 #define ICE_SCHED_DFLT_BW_WT		4
 #define ICE_SCHED_INVAL_PROF_ID		0xFFFF
-#define ICE_SCHED_DFLT_BURST_SIZE	(15 * 1024)	/* in bytes (15k) */
+#define ICE_SCHED_DFLT_BURST_SIZE	(2 * 1024)	/* in bytes (2k) */
 
 /* Access Macros for Tx Sched RL Profile data */
 #define ICE_TXSCHED_GET_RL_PROF_ID(p) LE16_TO_CPU((p)->info.profile_id)
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

