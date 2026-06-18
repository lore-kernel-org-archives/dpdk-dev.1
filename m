Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D08CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:17:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38C8040696;
	Thu, 18 Jun 2026 16:17:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id E50A540670
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:17:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781792258; x=1813328258;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E4helDl2iWiTWSD9IEBGo6xTlHwrkOpaNIfhkmAGbRw=;
 b=foOGLP6DizvzrqiC70AUrp9nwF/rMSQsWYTf0gm+F4b2fuYn7N6cwjfe
 A3Ec5ivRKkj539/2Njt0Xb0i2+DD46/v98R7fgM7dEIzBMx1LvYMIVq7I
 RIcEt5KdjdEHgpHvjQupuwtV4ewRe82K06o79ly6LqxXfgIfqEtUWsHEK
 5PKwHlAiI8Ez6rEsAe8dt6sP+T5FkDZwIP8Lr/2KEL1ig015sFaBAWmze
 AOTs8RDIsp+deDPCpth1SDs40Nm+Dq1i5a2gIzNOCd06QBbAmxlTbjd/L
 LdxjfCYHvW/WERZiI8wvOD7GNi/mRCFSHGYnbL/UKfjW5OhNLAGMK7zsH Q==;
X-CSE-ConnectionGUID: +djd05sKS7eTa6a2k4malA==
X-CSE-MsgGUID: tmtaI5VEQAWVvEts7ZCQfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81736948"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="81736948"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:17:37 -0700
X-CSE-ConnectionGUID: wJPVMUHkTeqN+3tdTIXGOA==
X-CSE-MsgGUID: guBvQVIuSu67sHmJzUy56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="248457617"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 07:17:36 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>
Subject: [PATCH v2 0/7] Intel network drivers enhancements
Date: Thu, 18 Jun 2026 10:44:35 -0400
Message-ID: <20260618144442.312844-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608164059.65420-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
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

This series introduces several improvements to Intel iavf and ice
drivers, including a new ethdev API for header split mbuf callbacks,
increased ring descriptors, and improved PTP timestamping.

Marek Kasiewicz (7):
  ethdev: add header split mbuf callback API
  net/iavf: increase max ring descriptors to hardware limit
  net/iavf: allow runtime queue rate limit configuration
  net/ice/base: reduce default scheduler burst size
  net/ice: timestamp all received packets when PTP is enabled
  net/iavf: disable runtime queue setup capability
  net/intel: support header split mbuf callback

 drivers/net/intel/common/rx.h         |  2 +
 drivers/net/intel/iavf/iavf_ethdev.c  |  3 --
 drivers/net/intel/iavf/iavf_rxtx.h    |  2 +-
 drivers/net/intel/iavf/iavf_tm.c      | 11 ++--
 drivers/net/intel/ice/base/ice_type.h |  2 +-
 drivers/net/intel/ice/ice_ethdev.c    |  1 +
 drivers/net/intel/ice/ice_rxtx.c      | 72 ++++++++++++++++++++++++---
 drivers/net/intel/ice/ice_rxtx.h      |  2 +
 lib/ethdev/ethdev_driver.h            | 15 +++++++
 lib/ethdev/rte_ethdev.c               | 51 ++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h               |  7 +++
 11 files changed, 153 insertions(+), 15 deletions(-)

-- 
2.47.3
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

