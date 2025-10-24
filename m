Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0ACCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 11:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84564402A1;
	Fri, 24 Oct 2025 13:53:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E9CF34025E
 for <dev@dpdk.org>; Fri, 24 Oct 2025 13:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761306781; x=1792842781;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LqFuB/94xseZwPWrHYdhrc0dsCYckIAYdDQ+JHhi+eo=;
 b=RZUfPVTzfu7v4Vl0RNF5xMRUXP/15sdilKer16f6pu+1yiCieR9E1an0
 XwuA4VRCetZJ7UztrsGO5a2LBuvk7JvXhJPZS13RVG8348I+hisEjRU3G
 kfhFlRN+88vSVmtLrgaMMZc06YHWnJD9XRZcrpi7hXsOezavO5RYo4G8K
 pHQGRKSouThEbc7eLiZJhyHZrR4Rcks5o7rqnKgu8ij3Sk1zfcUIYvyXm
 Hs2SVn540h9FPemzgUMQofBv3IWSafwKCrYQA0UNe1vXlaOnTpA0bqqh5
 eLE4+0V+vDdQY+WKCuwR/Hh9ZZsLvvLhGeVSn+ZNusmcwOw1ksBdgp48+ g==;
X-CSE-ConnectionGUID: +sxjOYZMSJGaVYw26nmZNA==
X-CSE-MsgGUID: RmXxsWgpQo24rGQc6RZYBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63394267"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="63394267"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 04:52:59 -0700
X-CSE-ConnectionGUID: 3NbAaRF/T8udwyk9Lim6aQ==
X-CSE-MsgGUID: 0W8dTqgYT7aQg0JKsTtWOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="188709770"
Received: from npg-npf-wlpr-srv12.iind.intel.com ([10.190.212.197])
 by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 04:52:58 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 0/4] Enable PTP feature for MEV
Date: Fri, 24 Oct 2025 17:38:36 +0530
Message-Id: <20251024120840.420016-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.34.1
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

Enabling basic PTP feature in IDPF PMD using virtchnl messages.

Milena Olech (1):
  net/idpf: add a new API for PTP support

Soumyadeep Hore (3):
  net/idpf: add PTP virtchnl2 support
  net/intel: add support for Precision Time Protocol
  doc: add PTP IDPF documentation

 doc/guides/nics/idpf.rst                      |  16 +
 drivers/net/intel/common/tx.h                 |   1 +
 drivers/net/intel/idpf/base/virtchnl2.h       | 324 ++++++---
 drivers/net/intel/idpf/idpf_common_device.h   |   4 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 186 +++--
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  10 +
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  34 +-
 drivers/net/intel/idpf/idpf_ethdev.c          | 275 ++++++++
 drivers/net/intel/idpf/idpf_ptp.c             | 646 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ptp.h             | 227 ++++++
 drivers/net/intel/idpf/meson.build            |   1 +
 11 files changed, 1562 insertions(+), 162 deletions(-)
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.h

-- 
2.34.1

