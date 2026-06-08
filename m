Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EFECD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F81440685;
	Mon,  8 Jun 2026 18:14:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 77CF340695
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780935256; x=1812471256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RHqRRiQT51BM1Yh975elJAJkqugimf1w4ED6xWD3omY=;
 b=NOzN/01X8CrIPJbAmDh+EklU1bjiMWjhsWZ8XEAtDwyXF06w/2SoCJGm
 +pGn99HT85ShDeuwkpg/fIkn/4Ktvmym0eF91YVdVu5wvMRLi4bqiK1nA
 TIHVAOjnjsnOTKAOejRaAvfoDqZflFpjiVhJKqJy4feCa96Tm7Os0GJmT
 EzDLI+I083c//HxCAA34LaUUIYPoVWwEXLjbwoyKKgi06/iioCuZls92o
 42k70QIb6oLB1PAqpBhT3cZRNcBmKxy8liYX1A/QygsZJ8RKUL3HhuBn0
 CY7v7sGWJ6yDGN1Y0oQvjcOYaj4nBGc2fpU+DR8jrsSv6nawPZKVFN5Yc A==;
X-CSE-ConnectionGUID: dT7oqF3tS/eRJTod5N7Zvw==
X-CSE-MsgGUID: iMP8NIaORWSGkE/CuFXqFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="80809555"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="80809555"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:14:15 -0700
X-CSE-ConnectionGUID: 5k+G8SmuRzW31yjjqguzPw==
X-CSE-MsgGUID: iJFmgr34TaaQGRGqmBqSXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245457444"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa008.jf.intel.com with ESMTP; 08 Jun 2026 09:14:13 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH 3/7] net/ice/base: reduce default scheduler burst size
Date: Mon,  8 Jun 2026 12:40:55 -0400
Message-ID: <20260608164059.65420-4-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608164059.65420-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
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

