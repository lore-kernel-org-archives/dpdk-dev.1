Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19C8C5DF9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 07:07:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98F1540150;
	Thu, 27 Aug 2026 09:07:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D1E914003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 09:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787814438; x=1819350438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tDMcX0w3HryinX4iQ03LS32qKS2EP/Zg2MxchVVB/Z8=;
 b=oAKXd7H7AcSTy0cyGOO9ygO/ERbuLQ6tEs/iUfnR6HeoCQzw/jDxYss0
 BftA7hdklqhuiXdU+HdL0iQDw9brKm9oL+XQd74/12MKFBnpyH8g5r5tD
 27Ow8sRHS88tfXl1cyDKQEaqm4jFj75+JIramp150d/VFwYyr4b80RUYA
 DmqcMbCtc9+9Nfx4v9xNqEkkewchpgsjxwc7iOGiLB/4EVrvlWHod5pVr
 MDQeFOsCcH7DhjpZYeJ+AsFZGPMtgSb1J7SPfX8Oek4KvHoruwUzyknuZ
 wpJyDq9WG0mfmVm7eli29ZAzqFnBb/YDGXkudO4jzJa+0LYHb9xcYAKD0 w==;
X-CSE-ConnectionGUID: 3tETVLGuTnuHnElGph93GA==
X-CSE-MsgGUID: +n5n4TptQ6GmNbfslz9OfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88168238"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88168238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 00:07:16 -0700
X-CSE-ConnectionGUID: jKaz+zHpSwyF91oInBoEpw==
X-CSE-MsgGUID: mc0zaDGpRJyvnDFCTPsYPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="291305753"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by fmviesa002.fm.intel.com with ESMTP; 27 Aug 2026 00:07:13 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v2 0/1] ethdev: add Tx timestamp slot APIs
Date: Thu, 27 Aug 2026 18:04:33 +0530
Message-ID: <20260827123437.243365-1-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
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

The ethdev timesync API currently exposes Tx timestamps through a shared
hardware register. This requires applications to serialize timestamped
packets and does not allow correlation when multiple packets are in
flight.

This RFC proposes an ethdev interface for hardware with independent Tx
timestamp slots. The interface reports the supported timestamping
mechanism, provides a port-global slot lifecycle, and lets applications
poll each slot asynchronously after transmission.

The proposal includes the following components:

* Capability reporting for shared-register and per-packet timestamping.
* Slot allocation, asynchronous timestamp retrieval, and slot release.
* A dual-domain timestamp structure for adjusted PHC and raw hardware
  time.
* Mbuf dynamic field and dynflag support for passing slot handles to Tx.
* Registration and process-local disabling of slot metadata.
* A compatibility alias for the mbuf stamping helper.
* Programmer-guide and NIC feature documentation.

The legacy rte_eth_timesync_read_tx_timestamp() API remains available on
devices using a shared timestamp register. This RFC adds the ethdev and
PMD interfaces but does not add a hardware-specific PMD implementation.

The following areas would benefit from review:

* Is the capability model sufficient for devices with different slot
  allocation or completion mechanisms?
* Is an mbuf dynamic field and dynflag the appropriate way to pass the
  slot handle into the Tx datapath?
* Is -EAGAIN the appropriate result while a slot timestamp is pending?
* Should the adjusted and raw timestamp domains use nanoseconds in the
  public structure, or should one domain expose hardware cycles instead?

Rajesh Kumar (1):
  ethdev: add Tx timestamp slot management APIs

 doc/guides/nics/features.rst              |  16 +-
 doc/guides/prog_guide/ethdev/index.rst    |   1 +
 doc/guides/prog_guide/ethdev/timesync.rst | 216 +++++++++++++++++++
 lib/ethdev/ethdev_driver.h                |  25 +++
 lib/ethdev/rte_ethdev.c                   | 152 +++++++++++++
 lib/ethdev/rte_ethdev.h                   | 251 ++++++++++++++++++++++
 6 files changed, 657 insertions(+), 4 deletions(-)
 create mode 100644 doc/guides/prog_guide/ethdev/timesync.rst

-- 
2.55.0

