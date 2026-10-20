Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E0606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YsddpJJE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8574940283;
	Tue, 20 Oct 2026 17:21:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 559084025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792509686; x=1824045686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QHJKSfEhYTGwi46Pt7U2D9dH1vVeyu69f0BSZ7WCWB4=;
 b=YsddpJJEwuG111qeOgp+ofnKYhSkQO7AZFCzkNoy546AOr/5tjNtQ6CC
 r20UCNaT07daGOIScWgw7+JPgpR1maLFxDxVoWQC8MhfG23YS+uNmW5Sn
 B0pZkuM9tslZW0y+RcIVXyQI+DrkSjh6XZVzEDNeEgYHg+PAhLQ2ttYSe
 6p0SKe/3lQmlsu5Etd9vTd9vGsMTO/nacU2t7HBCIFUzrgKjywpIgWK00
 H/RBcSQQMXfmW2L48ON4fq+66Oy1abDunQ8vWxWbPRxxPkBZWOliUIjQS
 hDrUuvlay8LxFAnGEqCrGimVP1KcLumQBbU26+NfvQqVkUwVQk9f0tGtL A==;
X-CSE-ConnectionGUID: GaKJeIO4Qy6UiUEgmaOUeg==
X-CSE-MsgGUID: y8JNN/krSq2LhS+7ghHF2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1226842"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1226842"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:21:25 -0700
X-CSE-ConnectionGUID: o+bU3i2NSZWJNbkMen5Lxw==
X-CSE-MsgGUID: CNNNfFeYSYeO2Ip0qD0Ngw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3240939"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa010.jf.intel.com with ESMTP; 20 Oct 2026 08:21:24 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com
Subject: [PATCH v2 0/3] net/iavf: fix TM hierarchy commit and TM ops without
 QoS
Date: Tue, 20 Oct 2026 15:22:09 +0000
Message-ID: <cover.1792504817.git.dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014122419.631288-1-dawid.wesierski@intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Tested with testpmd on an E830 VF, out-of-tree ice PF:
- Patch 1: three hierarchy commits on a started port. Without the
  patch, an ASan build reports a heap-buffer-overflow in rte_free()
  from iavf_hierarchy_commit() at the second commit. With it, there is
  no report, also after port reset and close.
- Patch 2: one process sets 100 Mbit/s on two queues and exits. The
  next process commits two queue nodes without a shaper profile.
  Without the patch, only queue 0 gets back its full rate. With it,
  both queues do.
- Patch 3: in-tree ice PF, so the VF has no QoS offload. Without the
  patch, TM capabilities get, shaper profile add and node add give a
  segmentation fault. With it, they return an error.

v2:
- Patch 1: also remove the rte_free() of the map in iavf_uninit_vf()
  (Bruce Richardson).
- Patch 2: commit message from Bruce Richardson.
- Add the Acked-by of Bruce Richardson to the three patches.
- Rebase on the current next-net-intel.

Dawid Wesierski (3):
  net/iavf: fix invalid free of queue TC map
  net/iavf: fix bandwidth config of unshaped queues
  net/iavf: fix crash in TM ops without QoS capability

 drivers/net/intel/iavf/iavf_ethdev.c |  8 ------
 drivers/net/intel/iavf/iavf_tm.c     | 42 ++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 13 deletions(-)


base-commit: 1ca8f490fd725ccdd558654144b11777e37d68fe
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

