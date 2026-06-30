Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC9C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:40:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB129402BE;
	Tue, 30 Jun 2026 13:40:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1852840278
 for <dev@dpdk.org>; Tue, 30 Jun 2026 13:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782819620; x=1814355620;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2Qd4369EJcJxKqd4IqEDbtds7EG5zMRSG0cQYwHY/l4=;
 b=hShe8BCLTRZdrkjMeR7ZgW5wa4Y5KdrHKihkZEDzpgixikR3lnqtjmV5
 6oeaUCaukn9UBhFX5CFv5KoI3QPIX2uRQr6KnUendgeA9RJVRofLurX8X
 4biIvpbjnOUAKBMUv6R/wmPzV1VjtT68TQgC1O+IAZ00L6g5HTQwsuZwl
 9z7TbDW2SHUFdlC6ZYHrlVvhKlFuq4FayWb31DUlq5grsdtPVhovAAXLm
 K6cOTwVgeKNa0G6j4J0lVqT+LJrphrP7OFziIrXGZgeXugECT/FlOE6KG
 Au3nDJSuxm16PIqInYB0emEA2CRhAjrY7xV/gZ6HJRYksGKs9UL2/upK1 A==;
X-CSE-ConnectionGUID: BBgzgQ5SSTOndkJBvmJG9Q==
X-CSE-MsgGUID: romVxiCdSr6FXJbQYN6MzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82643703"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="82643703"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:40:19 -0700
X-CSE-ConnectionGUID: Ryelq0pFRjGk9aWS+zcr/g==
X-CSE-MsgGUID: CWngwjkzRV+5xudZZAAT+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="245891126"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 04:40:17 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v3 0/6] Intel network drivers enhancements
Date: Tue, 30 Jun 2026 08:06:50 -0400
Message-ID: <20260630120657.1046588-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618144442.312844-8-dawid.wesierski@intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
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

This series collects Intel E810 iavf and ice driver enhancements developed
for the Media Transport Library (MTL) to support high-performance SMPTE
ST 2110 media streaming workflows.

The "new code" in this series (specifically the testpmd enhancement in
patch 6) demonstrates how the standard DPDK buffer-split offload can be
orchestrated with pinned external-buffer mempools
(RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) to achieve this. By pinning mbufs to
contiguous hugepages, the NIC DMAs RTP payloads directly into application-
owned memory. This eliminates the need for the header-split.

Documentation and a concrete configuration example for this workflow are
included in the testpmd user guide (patch 6/6). The new 'create pinned-rxpool'
command serves as both a test vehicle and a reference implementation for
integrators.

In this series:
- iavf maximum ring descriptor count to raised 4096 (HW limit).
- iavf queue rate limit enabled reconfiguration at runtime.
- Added opt-in "rl_burst_size" ice devarg for tighter packet spacing (jitter reduction).
- Enabled PTP timestamping for all packets on ice.
- Added opt-in "no_runtime_queue_setup" iavf devarg to restore strict
  initialization semantics when required.

- Dropped the ethdev and net/intel "header-split mbuf callback" API
- Replaced the out-of-tree approach with a testpmd demonstration (patch 6)
  of the standard, upstream-preferred pinned-external-buffer workflow.
- Fixed iavf error propagation and committed-state logic (Stephen Hemminger).
- Converted the ice scheduler burst reduction and iavf runtime-config
  disabling into opt-in devargs to preserve default behavior.
- Updated documentation, commit messages, and .mailmap.

Dawid Wesierski (1):
  app/testpmd: add pinned external-buffer Rx pool command

Marek Kasiewicz (5):
  net/iavf: increase max ring descriptors to hardware limit
  net/iavf: allow runtime queue rate limit configuration
  net/ice: add scheduler rate-limiter burst size devarg
  net/ice: timestamp all received packets when PTP is enabled
  net/iavf: disable runtime queue setup capability

 .mailmap                                    |   2 +
 app/test-pmd/cmdline.c                      | 123 ++++++++++++++++++++
 doc/guides/nics/ice.rst                     |  12 ++
 doc/guides/nics/intel_vf.rst                |   9 ++
 doc/guides/rel_notes/release_26_07.rst      |   7 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  82 +++++++++++++
 drivers/net/intel/iavf/iavf.h               |   1 +
 drivers/net/intel/iavf/iavf_ethdev.c        |  22 +++-
 drivers/net/intel/iavf/iavf_rxtx.h          |   2 +-
 drivers/net/intel/iavf/iavf_tm.c            |  25 ++--
 drivers/net/intel/ice/ice_ethdev.c          |  46 ++++++++
 drivers/net/intel/ice/ice_ethdev.h          |   1 +
 drivers/net/intel/ice/ice_rxtx.c            |   9 +-
 13 files changed, 321 insertions(+), 20 deletions(-)

-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

