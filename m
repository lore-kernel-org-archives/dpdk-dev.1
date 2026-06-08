Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53905CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:13:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66CF240655;
	Mon,  8 Jun 2026 18:13:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 35212402DD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780935238; x=1812471238;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Hl07m97i/PLVAqGQ66NrhI10Pxit0T31ImCCH3a34Ao=;
 b=ZupRkpUT8Yotoo6RBlGwFhckgmnDrl3/rOG6LPu1qNCBz2tFnKUWXbvG
 VpPK9LHNErTVBND2FTsuqubUy3MBxlSZpqNrL9I4DGLJ165CGmPNoM/HJ
 4ppeMnQFt//kpn7Y4BF4cCiuknSKfrPM11kMCuNl1E4XATQTDxC62Xkcl
 EcH2X7HFkHofXFDOV2N6JThAwByT0ZPsWOzavEUQNp2VpScEaAmqYLMdZ
 MA/6+mHhBmbYr/MMN62fneUdVvoQ/7F19jTBKZqfTmEdCHPuP25cg52rv
 8TSI9FoIQfL8gvvb94JAsl/r2Maw2hcEHtlyVWCMeXup4J9r02+yN0GEJ Q==;
X-CSE-ConnectionGUID: o1D2a7MHQMecgdfI+EUwSw==
X-CSE-MsgGUID: XDeF6vCZQ1uQLS3F9eHQIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="80809466"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="80809466"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:13:56 -0700
X-CSE-ConnectionGUID: yDxv0NwaSrKn8/43spPOzg==
X-CSE-MsgGUID: xw2Rt1EmQX+RNl1qAaIzIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245457398"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa008.jf.intel.com with ESMTP; 08 Jun 2026 09:13:54 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, "Wesierski, Dawid" <dawid.wesierski@intel.com>
Subject: [PATCH 0/7] intel network and pcapng updates
Date: Mon,  8 Jun 2026 12:40:52 -0400
Message-ID: <20260608164059.65420-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
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

From: "Wesierski, Dawid" <dawid.wesierski@intel.com>

These patches provide various updates for Intel iavf/ice drivers and pcapng.
The changes include:
- Hardware limit ring descriptor increases for iavf.
- Runtime queue rate limit configuration for iavf.
- Scheduler burst size reductions for ice base.
- Global PTP timestamping for ice.
- Disabling runtime queue setup for iavf.
- User-supplied timestamp support in pcapng.
- Header split mbuf callback support for ice.

Marek Kasiewicz (7):
  net/iavf: increase max ring descriptors to hardware limit
  net/iavf: allow runtime queue rate limit configuration
  net/ice/base: reduce default scheduler burst size
  net/ice: timestamp all received packets when PTP is enabled
  net/iavf: disable runtime queue setup capability
  pcapng: add user-supplied timestamp support
  net/ice: add header split mbuf callback support

 drivers/net/intel/common/rx.h         |  2 +
 drivers/net/intel/iavf/iavf_ethdev.c  |  3 --
 drivers/net/intel/iavf/iavf_rxtx.h    |  2 +-
 drivers/net/intel/iavf/iavf_tm.c      | 11 ++--
 drivers/net/intel/ice/base/ice_type.h |  2 +-
 drivers/net/intel/ice/ice_ethdev.c    |  1 +
 drivers/net/intel/ice/ice_rxtx.c      | 72 ++++++++++++++++++++++++---
 drivers/net/intel/ice/ice_rxtx.h      |  2 +
 lib/ethdev/ethdev_driver.h            | 10 ++++
 lib/ethdev/rte_ethdev.c               | 17 +++++++
 lib/ethdev/rte_ethdev.h               | 46 +++++++++++++++++
 lib/pcapng/rte_pcapng.c               | 19 ++-----
 lib/pcapng/rte_pcapng.h               | 41 ++++++++++++++-
 13 files changed, 196 insertions(+), 32 deletions(-)

-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

