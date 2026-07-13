Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7BC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BF6E40298;
	Mon, 13 Jul 2026 11:16:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6A15A4028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 11:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783934202; x=1815470202;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wSfucJIjwmCKX4uvnKLpPrxEeFpswWv7V7CeotBY+9U=;
 b=VkmEqQJAN5zjOeUQ69oFfODPSchi7J0gBjnWAwBvChHBN6JFj5V3l+lm
 qLMo5QRjdH93ExasoeMvpOsLe06stZK5NkO3d08uHd0kvr7G3quwboeFg
 tZ6XfO5LUUErvb/FE2OFWM1S1yJCHbg8xk1QGy4yVzQG+9unVBozsxf+/
 V6OoUbIXMbpY9wzuRobIc2gP0yIX2K12k92uvRHnbi6U0nXv7J5KHlzwz
 7plyL450PmEIO1nH66jPuoKuh+pdseSXOQClkFX6HpEe7uGzDlmsZY15u
 WmyjZh+GHM6qgYY6kwV67ITKvdlw8Jv0sUwHeWt/O2MmaWi682TwgMQDK g==;
X-CSE-ConnectionGUID: Siaq5TsARGCFV4Ah5ZwCgA==
X-CSE-MsgGUID: ZAfj2JJhRJ2FcvTtM3oNDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88218159"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="88218159"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 02:16:32 -0700
X-CSE-ConnectionGUID: HTGq7ItmQ9SIIW3yBdYDMg==
X-CSE-MsgGUID: /ogZSdnbQ+GMsXGb62FVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="279911364"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa001.fm.intel.com with ESMTP; 13 Jul 2026 02:16:31 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v6 0/2] Intel network driver enhancements
Date: Mon, 13 Jul 2026 05:42:38 -0400
Message-ID: <20260713094240.1721105-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708231926.1550698-1-dawid.wesierski@intel.com>
References: <20260708231926.1550698-1-dawid.wesierski@intel.com>
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

This series contains enhancements for Intel ice and iavf drivers.

v6:
- doc/ice: addressed Bruce's review comments. Dropped re-wrapping of 
  existing text to follow DPDK policy (starting each sentence on a new line).
- doc/ice: explicitly noted that invalid rl_burst_size values cause the 
  driver to fail to initialize (hard failure).
- net/iavf: re-submitted patch 2 (runtime queue setup race fix) which 
  had application issues in v5.

v5:
- Added documented rejection of invalid values to rl_burst_size.
- Improved commit message for iavf runtime queue setup fix.

Dawid Wesierski (2):
  doc: fix ice scheduler rate-limiter burst size description
  net/iavf: disable runtime queue setup during queue rate limiting

 doc/guides/nics/ice.rst                |  1 +
 doc/guides/nics/intel_vf.rst           | 10 ++++++++++
 doc/guides/rel_notes/release_26_07.rst |  3 +++
 drivers/net/intel/iavf/iavf_ethdev.c   | 23 ++++++++++++++++++++---
 drivers/net/intel/iavf/iavf_tm.c       |  2 ++
 5 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

