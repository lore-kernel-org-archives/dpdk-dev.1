Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653B606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Im4O6U+E
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C5864025A;
	Wed, 28 Oct 2026 14:23:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 5324D40151
 for <dev@dpdk.org>; Wed, 28 Oct 2026 14:23:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793193835; x=1824729835;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D1tKocW9yjpm/lO7Pm8B0s0cl6NVQJZX3ZAnBbq74TI=;
 b=Im4O6U+EdlzvVw6Uv4E+gcLR6DglBZS4I8a44SkjbPDL5W/yJK2gSLiE
 FDWeYLAI/KmSMTJ9h2h4ln7DgMBPckCQvzrte0ovKuxSxd7AWwMtnA6RK
 zF0EOEcJH53vhRaMdAhVZRULzZjUCkC+g1mcfSfTY7VH+sWZZmv3FVoaN
 f867o+qKwtAN53o4fhSY/51QZcFpnkQU2ag2gl4zWyftz8K/XPZqgnANR
 tTnI7YhqJKmGAeChCgXqXWUXIUrFqjv1NijLApjAfe31DzNS3JfxA0+wi
 ULHqNgnTK5DqPXrZ6VYzxhcf8ZlC/3/eSjf+j2NH/uqbgU40vE1Pdgh+f g==;
X-CSE-ConnectionGUID: Q7z7y8vLRte1BxC6xFut0w==
X-CSE-MsgGUID: /yHoCf7tRQ+Hy8/gkDq8rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1917429"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1917429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 06:23:53 -0700
X-CSE-ConnectionGUID: PIj0Gl/hSweK9LIdFQZ8lQ==
X-CSE-MsgGUID: 94wCI99jTZqMfJFXf9Cplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4778780"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa003.jf.intel.com with ESMTP; 28 Oct 2026 06:23:52 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 soumyadeep.hore@intel.com, grzegorz.nitka@intel.com,
 marek.kasiewicz@intel.com
Subject: [PATCH 0/2] net/ice: fix E830 Tx time pacing and PHC adjustment
Date: Wed, 28 Oct 2026 13:24:32 +0000
Message-ID: <20261028132435.2113321-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two fixes for E830 from the Media Transport Library (MTL), which uses
Tx time based pacing (TxPP) for SMPTE ST 2110 video.

Patch 1 fixes the encoding of the launch time. The driver takes the
launch time modulo one second, but the 19-bit field of the descriptor
wraps every 67.1 ms of PHC time. Thus at each second boundary, the
launch time that the hardware sees moves 6.63 ms, and in half of each
10.1 s cycle the packets look late. The Linux ice driver uses the same
encoding (ts.tv_nsec >> 7). We did not test the kernel path.

MTL carries patch 1 on DPDK 26.07. With one ST 2110-20 stream on a
1024-entry Tx ring, 6 of 13 runs lost pacing without it, and 32 of 32
runs paced correctly with it. We do not have a testpmd reproduction
yet: on our E830 test port, testpmd txonly with "set txtimes" sends no
packet, with or without the patch. We investigate that separately.

Patch 2 fixes rte_eth_timesync_adjust_time() on E830. Since commit
f9767f70cb73, each adjustment sends a PHY timer command to firmware on
the admin queue, and the firmware rejects it with -100. The E830 PHY
follows the source timer, so the patch removes that command. On an
E830-CC PF (firmware 1.3833.0), "step" is the change of PHC minus
CLOCK_REALTIME across the call, about -245 ns for a delta of 0:

  delta (ns)   without patch 2       with patch 2
  0            -1, "err -100"        0, step -238 to -249 ns
  +1000        -                     0, step +691 to +890 ns (3 runs)
  -1000        -                     0, step -1128 to -1250 ns (3 runs)
  +1000000     -1, step -1279 ns     0, step +999762 ns
  -1000000     -1, step -171 ns      0, step -1000247 ns

Two more TxPP fixes are needed for a correct pacing on E830, and
Soumyadeep Hore sends them separately: the Tx time queue context does
not set timer_num, and rte_eth_read_clock() returns the system time
instead of the PHC time.

Dawid Wesierski (2):
  net/ice: fix TxPP launch time encoding
  net/ice/base: fix E830 PHY timer command

 drivers/net/intel/ice/base/ice_ptp_hw.c | 22 ++--------------------
 drivers/net/intel/ice/base/ice_ptp_hw.h |  2 --
 drivers/net/intel/ice/ice_rxtx.c        |  3 ++-
 3 files changed, 4 insertions(+), 23 deletions(-)


base-commit: cc048a01ec4c7ae5f63a6607260ac05cc1588968
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

