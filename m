Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2769C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB622402DF;
	Fri,  3 Jul 2026 13:53:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 48F1B402D4
 for <dev@dpdk.org>; Fri,  3 Jul 2026 13:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783079604; x=1814615604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IgSClzt0rt1rSXTBqVWSR8z2U2DnhogIUJ4Sm5AtLUw=;
 b=T4gX90g/muwEBfL84U2n2tmKryX+O0T7/Q8/SlPwnxQEGtEDTMcaPNzJ
 GcBRm3c9RKVjiD1rp/Qw0s4UcpQ8xvLZV0a3EwmTRH+rZqzvH7mJGRwDx
 yvjFPDV5b/fwp1TzIjnO3n4RGi8ZKdFVB39UDFnTj/dgvQpXWVbH+QEJ6
 x1vN9XV6XZyIvHoOdtzCz8mbAMRXZzuHpw1hc/fN63v/e7aP+vASiXTE/
 m9JahdOKe3LibiON1graxL0Bo3yhTS2RariPpIJW/Wxr9DYL4/YAvP1o2
 2ZTasqFJ0uF2knFhD77LcawbyXBEcuFuyF5/0wHue5Nnyn/D6H2ttfcWU w==;
X-CSE-ConnectionGUID: l14bESE4QOW+OHOjb0pBdg==
X-CSE-MsgGUID: 5vc9rc0ZQteiqKKFgXYVYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101253792"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="101253792"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 04:53:22 -0700
X-CSE-ConnectionGUID: EnOAWl5kRumh3KFNLckNkA==
X-CSE-MsgGUID: kJMInndaRuqST7j2UtU95Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="291240221"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa001.jf.intel.com with ESMTP; 03 Jul 2026 04:53:20 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v4 0/5] Intel network drivers enhancements
Date: Fri,  3 Jul 2026 08:19:47 -0400
Message-ID: <20260703121952.1277387-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630120657.1046588-1-dawid.wesierski@intel.com>
References: <20260630120657.1046588-1-dawid.wesierski@intel.com>
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

The header/payload split use case is served by the standard DPDK
buffer-split offload combined with pinned external-buffer mempools
(RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF): by pinning mbufs to contiguous
hugepages, the NIC DMAs RTP payloads directly into application-owned
memory. A concrete configuration example and the 'create pinned-rxpool'
testpmd command that serves as a reference implementation are documented
in the testpmd user guide (patch 5/5).

In this series:
- iavf maximum ring descriptor count raised to the E810 hardware limit.
- iavf queue rate limit reconfiguration allowed at runtime.
- Added opt-in "rl_burst_size" ice devarg for tighter packet spacing
  (jitter reduction).
- Added opt-in "no_runtime_queue_setup" iavf devarg to restore strict
  initialization semantics when required.

v3 -> v4:
- Dropped the ice PTP documentation patch entirely. Applications that
  need a hardware Rx timestamp on all traffic (not just IEEE 1588
  packets) already have RTE_ETH_RX_OFFLOAD_TIMESTAMP available today;
  this is an existing, generic offload and does not need a dedicated
  patch to point it out. The datapath change that misidentified regular
  traffic as PTP (flagged by Bruce Richardson) is also dropped with it.
- Set the whole series author to Dawid Wesierski.
- Rebased onto latest main.

v2 -> v3:
- Dropped the ethdev and net/intel "header-split mbuf callback" API in
  favour of the upstream-preferred pinned-external-buffer workflow, now
  demonstrated in testpmd (patch 5).
- Fixed iavf error propagation and committed-state logic
  (Stephen Hemminger).
- Converted the ice scheduler burst reduction and iavf runtime-config
  disabling into opt-in devargs to preserve default behaviour.
- Updated documentation, commit messages, and .mailmap.

Dawid Wesierski (5):
  net/iavf: increase max ring descriptors to hardware limit
  net/iavf: allow runtime queue rate limit configuration
  net/ice: add scheduler rate-limiter burst size devarg
  net/iavf: disable runtime queue setup capability
  app/testpmd: add pinned external-buffer Rx pool command

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
 12 files changed, 318 insertions(+), 14 deletions(-)

-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

