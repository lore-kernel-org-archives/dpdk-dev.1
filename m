Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C179CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:23:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2567B402E9;
	Wed, 14 Oct 2026 14:23:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8CCC54021E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 14:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791980611; x=1823516611;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bYs6UDfJBfzzwQ84nUwSNwkeZQlVaNwfpFAcIX1i9O8=;
 b=KSf4or2BbILJ+QB+j5qhKs7r2J5hbuH/vCD2usP186scFvdIkn8e18St
 JyUkxLd3Ej198X1XDoPq9qiYDQlLThXYYNkp7T/kIoqHJpKnLZ0bpouxy
 UssFCk7p7YJLWdhQqPoVC6lQo5NQvLhjmeHgkw43SVxNI8ny3Qbxoi13s
 kZolEPkFsTH/n9N0PEu2ySMm1NI91oBpIu0Ep5CjTVf/XfomK7x75zLZL
 3VtEgEmuEwW3Ddgm+I9bSfHqpx5hCTVd0xbLqF7QeUbgg/7RvdSTXi+lH
 XHqTJWgE0MQe0CfUnRdQTcQe7D89gOFfPKyGcG/n/D9TOa0K7MbBdlDem Q==;
X-CSE-ConnectionGUID: tQqZ/T8TRW+rCaI2vshLXQ==
X-CSE-MsgGUID: wVDh1sYiSfWxf4rBCN3jKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="717288"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="717288"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:23:30 -0700
X-CSE-ConnectionGUID: Hxihh7rFTK2vZovKLlKb0Q==
X-CSE-MsgGUID: WpuuHbxaQX+h7KG23OyYJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1524770"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by fmviesa002.fm.intel.com with ESMTP; 14 Oct 2026 05:23:29 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com
Subject: [PATCH 0/3] net/iavf: fix TM hierarchy commit and TM ops without QoS
Date: Wed, 14 Oct 2026 12:24:15 +0000
Message-ID: <20261014122419.631288-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
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

Three fixes in the iavf traffic manager.

Patch 1 removes a second free of the queue TC map. The fault is in main
only, after commit f6e33f09f766. No release has it.

Patch 2 sets the queue ID and TC of each queue node in the queue
bandwidth message. Without it, a queue node with no shaper profile
resets queue 0, and its own queue keeps the rate limit that the PF
holds from an earlier process.

Patch 3 returns -ENOTSUP from the TM ops that read qos_cap when the PF
does not grant VIRTCHNL_VF_OFFLOAD_QOS, for example the in-tree ice PF.
These ops cause a segmentation fault now.

The Media Transport Library carries patches 2 and 3 on DPDK 26.07, and
tests them on E830 VFs with the out-of-tree ice PF. On a VF that an
earlier process rate limited, a TSC-paced 1080p59.94 stream runs at
27.5 fps. With patch 2, a commit of queue nodes without shaper profiles
removes the old limits, and the stream runs at 59.9 fps.

Dawid Wesierski (3):
  net/iavf: fix invalid free of queue TC map
  net/iavf: fix bandwidth config of unshaped queues
  net/iavf: fix crash in TM ops without QoS capability

 drivers/net/intel/iavf/iavf_tm.c | 42 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 5 deletions(-)


base-commit: b39ee12b030f49c524b9d8c350a0f4b04141ccf9
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

