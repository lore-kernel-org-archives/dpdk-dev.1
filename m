Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BECCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02BB8406B6;
	Thu, 18 Jun 2026 16:11:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7576B4027C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781791906; x=1813327906;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ruWbS0ANOnV76tbaaufKwWkHV6MImLHZITysH+pOLlY=;
 b=AZNEBRjQO39/ZQP2HJqYJTF+5G6WT5hAaGtYBOBR0wJMGA+m8SuNpHkD
 9R+L1x2ywIwcTrIvAWeegYywDUXOsWkJYDMXQKEcAfu256WvwqKmWUbBh
 2CaENUzHNikOtJNVASksoJnlhl95r5sXKWdM3c7Jf6F8y2QcmHzPeqWtu
 CyFL5S5/pWLuFHgkORkZCa7NrbbYcGKBM+g7LbfZyO8ks01PIfaOOtn8p
 0lns0+tNA6z2D2khTAJtQ2zRcnuYgzz6h4e/xn4D4Doy9RZFkwjsB6Gkk
 EloIbBilhq3qhZOxn9giicN55glh2XvLuzSQ8zPpGpTGH6oDlD3AIe+Do g==;
X-CSE-ConnectionGUID: XAwy+W7EQ8KVcUycyFfrwA==
X-CSE-MsgGUID: TKY8GWP2T16vG+mXjoRjxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82628742"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82628742"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:11:46 -0700
X-CSE-ConnectionGUID: KMDhYSEVRyK8HHooCo1svw==
X-CSE-MsgGUID: hHKb7srySKeP/9VYJLUe4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="244211241"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2026 07:11:44 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v2 4/7] net/ice/base: reduce default scheduler burst size
Date: Thu, 18 Jun 2026 10:38:34 -0400
Message-ID: <20260618143837.310156-5-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618143837.310156-1-dawid.wesierski@intel.com>
References: <20260618143837.310156-1-dawid.wesierski@intel.com>
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

