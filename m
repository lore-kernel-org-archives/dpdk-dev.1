Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F941CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:11:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 256B940609;
	Thu, 18 Jun 2026 16:11:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 12A5E40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781791894; x=1813327894;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E4helDl2iWiTWSD9IEBGo6xTlHwrkOpaNIfhkmAGbRw=;
 b=JYj2QaLOwy65ja0JXKAaL8wblV0tLyo7T2iyXo28+7paB11VB4k18wpa
 eql779LydKxi6/oRJBsomH49R1/NWOFvRjLn7JyTIAwPyXfz3LBucFnvs
 kPLvENx1IERG1IaVYTcuFG/y+ixFqwrpgWhwrJwpMAz0RF06/W+yIo7TL
 gbzDRlCG9V+DayOipHYdl1ZBeFHO8gH5kXMKo0L4LsggwQG5cvEnaOqN+
 GcuSR8zu1Orc4C5ZzgnbViwO2J6mtRu3ZtwbB7Haxu4JmurcPqzfm2YbY
 sXiHlHBN9vk3Aw3oVltt0438IRVxNfmJsTMD0LFYYtXuEz2gQewO2H3Ix Q==;
X-CSE-ConnectionGUID: IR2dn9C9TPSj3EM48w7vrw==
X-CSE-MsgGUID: bILZYNeSRiiJ/sHOoXAs8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82628707"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82628707"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:11:33 -0700
X-CSE-ConnectionGUID: y5q/ne87RnKIYtDIKKER0Q==
X-CSE-MsgGUID: v765lXCNSOyzwfVzqcJROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="244211154"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2026 07:11:32 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>
Subject: [PATCH v2 0/7] Intel network drivers enhancements
Date: Thu, 18 Jun 2026 10:38:30 -0400
Message-ID: <20260618143837.310156-1-dawid.wesierski@intel.com>
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

