Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBF1C61CE8
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Jun 2025 05:29:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FB56402A9;
	Sat,  7 Jun 2025 07:29:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6AB174028B
 for <dev@dpdk.org>; Sat,  7 Jun 2025 07:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749274173; x=1780810173;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GXKR06ZBmwW0pXTBNb7Dzomt5rYtwfCuTIzTtwoC9zA=;
 b=FSJHU6njCjEqWtuXrap5D/G8oz3WjM7icLQzOCzNjl+bjJwFUC+/K8v/
 IO+IcnyS28slLYw+NW1gX6FiE7o149WwScMJZBtKMN3GPfgy3F4ZYTLGE
 Zp96AKlr8Mrfh0lUw6iQk79/lvbyO161T1NizdBIermanc+dNDF2Sl+u1
 H6D3iUCbwxCwAdLHnLuxv74Zk5ebyyh3AmHt/5+IO7Vw8DwIRDNQx9sgx
 1ATkKgZKUddBxs+S90HfCaAvmAeXdJkZXyV8UhS4n3PoM0ZUeBwZhHmr8
 ajmvT1N0RrxQmCkGzPe1TDP8yqL5T9HMMUMqqSfvWPjtAI7eZWEI1sdsU Q==;
X-CSE-ConnectionGUID: abCbF3P3SsyS162MJyovMg==
X-CSE-MsgGUID: 77kP5ySxR+SxzaWKQH6asQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="55087282"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; d="scan'208";a="55087282"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 22:29:32 -0700
X-CSE-ConnectionGUID: dLn4/aFkT7iC+F1HkLKHjw==
X-CSE-MsgGUID: dP3HbApnRpujjLUoboCuLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; d="scan'208";a="146953410"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa009.fm.intel.com with ESMTP; 06 Jun 2025 22:29:29 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 0/6] Add TxPP Support for E830
Date: Fri,  6 Jun 2025 21:19:41 +0000
Message-ID: <20250606211947.473544-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
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

Added TxPP support for E830 adapters.

Paul Greenwalt (1):
  net/intel: update E830 Tx Time Queue Context Structure

Soumyadeep Hore (5):
  net/intel: add read clock feature in ICE
  net/intel: add TxPP Support for E830
  net/intel: add AVX2 Support for TxPP
  net/intel: add AVX512 Support for TxPP
  doc: announce TxPP support for E830 adapters

 doc/guides/nics/ice.rst                     |  16 ++
 drivers/net/intel/common/tx.h               |  14 ++
 drivers/net/intel/ice/base/ice_common.c     |  22 +-
 drivers/net/intel/ice/base/ice_lan_tx_rx.h  |   4 +
 drivers/net/intel/ice/ice_ethdev.c          |  16 +-
 drivers/net/intel/ice/ice_ethdev.h          |  12 +
 drivers/net/intel/ice/ice_rxtx.c            | 233 +++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.h            |   9 +
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 134 ++++++++++-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 205 ++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  17 ++
 11 files changed, 657 insertions(+), 25 deletions(-)

-- 
2.43.0

