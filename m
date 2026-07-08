Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B624C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 22:53:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7556D40608;
	Thu,  9 Jul 2026 00:53:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id CA60A40265
 for <dev@dpdk.org>; Thu,  9 Jul 2026 00:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783551190; x=1815087190;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2S/jmZsOhGHis1gwoWD0/pOGXbvu3W1W8rErnRwLfOM=;
 b=OMev7w0nbTFwxEmP5uANF9rs2Q7DeCXAH256F/eys+DdJYkSldI7K4r8
 bl/NsBROpMSJe4Hr2E+owfMlNDp1FkWQ2+yDswjagVgAlptuuwK0tKXve
 e96CbhjVK+S8H0HY2IxXLtkFnCuEmRKHm715gpJUpbuc+7kSKSn3DI+kA
 Gt/0tqKtUTx1FpcZ9yNorWczrx5FBdj0xLL79qoAXhKVFbHBbX2vAW84V
 nxItLZ7R2dVbt+s+9auvzSJp2cSCJeBo8RgR0KAr7xduzWJlps+Bt5RKS
 MDExxgXROtcIrykNpHfkeRA6Li2cA3MSszYY2BaoWqJ4q52NU/K7uZjs7 g==;
X-CSE-ConnectionGUID: e2WsyiepRlGIsmWjMqZO8g==
X-CSE-MsgGUID: EXvG2xe3SWCtBAHLSFDGKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84342794"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84342794"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 15:53:09 -0700
X-CSE-ConnectionGUID: r6/TgvRRQeaMgz4vhufRtA==
X-CSE-MsgGUID: 544RBGEGQFCN5juTyaKRqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="292608228"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa001.jf.intel.com with ESMTP; 08 Jul 2026 15:53:07 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v5 0/2] net/iavf,
 ice: fix runtime queue setup race and burst-size doc
Date: Wed,  8 Jul 2026 19:19:24 -0400
Message-ID: <20260708231926.1550698-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703121952.1277387-6-dawid.wesierski@intel.com>
References: <20260703121952.1277387-6-dawid.wesierski@intel.com>
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

This addresses Bruce Richardson's review of the v4 "Intel network drivers
enhancements" series. Bruce questioned the no_runtime_queue_setup devarg
added in v4:

> Do we really need a commandline arg for this? If it's known enough to
> have the extra arg passed at device init, is it not also known enough
> to have the app not do dynamic reconfiguration in the first place?
>
> Alternatively, if the user configures packet pacing through rte_tm,
> can we not at that point adjust the driver to disallow runtime config
> by returning -ENOTSUP when reconfig is attempted, and no longer
> advertising the capabilities? Runtime configuration, whether with or
> without user interaction, should be preferred over devargs whenever
> possible.

Patch 2/2 drops the devarg and makes the driver withdraw
RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP / _TX_QUEUE_SETUP automatically
as soon as a per-queue bandwidth rte_tm hierarchy is committed, and
re-advertise them once it is torn down. Two bugs found while making the
committed-hierarchy pointer load-bearing for that check (a leak on
repeated commits, and a stale pointer surviving a VF reset) are fixed
alongside it.

Patch 1/2 is a small documentation fix for the rl_burst_size devarg
wording, spotted while touching the same area.

This v5 replaces v4 patches 3/5 and 4/5 with the two patches below.
v4 patches 1, 2 and 5 (max ring descriptors, queue rate limit
configuration, and the testpmd pinned-rxpool command) are unchanged
and are not reposted here.

Dawid Wesierski (2):
  doc: fix ice scheduler rate-limiter burst size description
  net/iavf: disable runtime queue setup during queue rate limiting

 doc/guides/nics/ice.rst                |  7 ++++---
 doc/guides/nics/intel_vf.rst           | 10 ++++++++++
 doc/guides/rel_notes/release_26_07.rst |  3 +++
 drivers/net/intel/iavf/iavf_ethdev.c   | 23 ++++++++++++++++++++---
 drivers/net/intel/iavf/iavf_tm.c       |  2 ++
 5 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

