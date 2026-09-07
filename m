Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE66C79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 13:08:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDE3740693;
	Mon,  7 Sep 2026 15:08:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E0CA84027F
 for <dev@dpdk.org>; Mon,  7 Sep 2026 15:07:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788786479; x=1820322479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rn64Q0obL7/QLCrVLDixHj6I7m1+HuzjoDzvdLed02w=;
 b=NdqkzzaH3clI5G3Rh9lymoXpTTolYdjQa5T2IzhNTHTn4JVqybXD5zxv
 NKYECtyjkYUfZRkkhPFTXPT3ZgCN7L6XahbtZpieUmoQkvcoE/3Cr6+d8
 2Nz34nTdxwnYk7qxeNRl/2kvsjGuFgSVnEvvIUxHK3woh5RsjAMrX03Cr
 m9rT5BUTu0v/WfNFyfwTaYmi1VCwg8XLnCxfpTIenk0GyaYGDcJFS4C9q
 ScURf1Eo3fhW3c3lBV4JgTzKCpPiPqz9hPoDbaL08rQxdctWXrUt6W2n7
 CxIVJu1f49pkMIzttRF/LVnn5kQ90b9qFigXWQhcIuLy4SrZ5dYRkI6uG w==;
X-CSE-ConnectionGUID: ht11zZB3SXyLuN4qOrcKRw==
X-CSE-MsgGUID: RNB/3c93ThSxoWVjdNdoCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="106705966"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="106705966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 06:07:58 -0700
X-CSE-ConnectionGUID: FxXtKiFsTFS9Tyu4JKBtrg==
X-CSE-MsgGUID: NY0r/9kjTH+n5uQ0qJWJ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="270682379"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 07 Sep 2026 06:07:57 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/4] net/ice: fix Tx scheduler hierarchy queue accounting
Date: Mon,  7 Sep 2026 13:07:46 +0000
Message-ID: <20260907130750.3406004-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904105139.3117640-1-ciara.loftus@intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Committing a Tx scheduler (rte_tm) hierarchy on ice can grow the port's
usable Tx queue count beyond what was available when the port was first
probed. This series fixes three bugs related to this, and makes a
cosmetic change by renaming variables related to queue counting.

v2:
* Variable renaming in patch 3 nb_tm_qps -> nb_tm_txqs
* Added a forth patch to split VSI qps variable into separate Rx/Tx
varaibles

Ciara Loftus (4):
  net/ice: fix Tx queue capacity sizing after TM commit
  net/ice: skip TC validation if hierarchy committed
  net/ice: fix Rx queue count reporting after TM commit
  net/ice: split VSI queue count into Rx/Tx

 drivers/net/intel/ice/ice_ethdev.c | 42 ++++++++++++++++--------------
 drivers/net/intel/ice/ice_ethdev.h |  5 +++-
 drivers/net/intel/ice/ice_rxtx.c   | 33 ++++++++++++++---------
 drivers/net/intel/ice/ice_tm.c     | 10 +++----
 4 files changed, 51 insertions(+), 39 deletions(-)

-- 
2.43.0

