Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D504C61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 12:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5720140150;
	Thu, 27 Aug 2026 14:18:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id EA9BD4003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787833101; x=1819369101;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kJ9b9znC5Ao517bGqW/9wRtJXe11X/AXTaokY762hGA=;
 b=OoI8Se2fqOBNhn/mdhM/ajLqSoAhkMghvHisf1aXk3/leEok/pcUcZv7
 RyiHJ7HFYdfyUHakibMEQDEf89QFbzQ9S895QEo8c3nz37rApIyiQ13JL
 ICLFjhA+MiXWuqRsh3O+TnKWpyeQ2vKWrRGIRVkCc1SjG5tnNjPj1brMS
 7aRTn2K+fFj62v2ocNu1kMYTC/+WdZy4XQF+1ixagPwVz4LmseQrXWVli
 LRw1BiilCxPIkLhLj5xJa5HZFj9bthT2ACbevMMd2mFo523euEJGaYDjF
 j2Q9ypQnYVUYTYV2QBAEIU835c6edLflZ2L/7tPVahQxhQuCpBWLlaIPW g==;
X-CSE-ConnectionGUID: lRs5TQUeScWTaCYmJG0erw==
X-CSE-MsgGUID: gmnDok/VQPO7biHwAucDRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98665710"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="98665710"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 05:18:20 -0700
X-CSE-ConnectionGUID: trCIbhvgQw6M8d7WQ+WRfg==
X-CSE-MsgGUID: 5kdtojQ0S12FKy9mzDyHNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="266559821"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by orviesa010.jf.intel.com with ESMTP; 27 Aug 2026 05:18:18 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v3 0/1] ethdev: add Tx timestamp slot APIs
Date: Thu, 27 Aug 2026 17:48:15 +0530
Message-ID: <20260827121815.339114-1-rajesh3.kumar@intel.com>
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
 doc/guides/prog_guide/ethdev/timesync.rst | 217 +++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst    |   7 +
 lib/ethdev/ethdev_driver.h                |  25 +++
 lib/ethdev/rte_ethdev.c                   | 158 ++++++++++++++
 lib/ethdev/rte_ethdev.h                   | 242 ++++++++++++++++++++++
 7 files changed, 662 insertions(+), 4 deletions(-)
 create mode 100644 doc/guides/prog_guide/ethdev/timesync.rst

-- 
2.55.0

