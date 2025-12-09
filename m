Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62279D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:27:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A17B40270;
	Tue,  9 Dec 2025 12:27:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id EADDE4025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279627; x=1796815627;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5MZDzkX07T7L9oiJYt1zaqwxM6ciQpS4+2OR+Hjt724=;
 b=liefrpYb0TtkkOeXE0aJI0G8x7Dbo+umbLTA/NttH/xA6KkjCCQAflzc
 0d45748hajZu18VH+A3Y8iae2ccHZN81ewqx9WVSA5xBAXJoyo2xdOxVS
 EHCxE24bDYkv/kRk55ZzDt8TiVwzI5T5/OqGtjnbwSLY7+VnhFhxoUgnB
 iO4Sxr2o2WV9gmtD3/DkOWfpfp2eBdN6qj4jlUPArpVS2hIWAyosRy8JK
 wKlpjtmJ41KXkIBqxWcqEkBd2wMxW5Mn66o8WtOz4tqGbcej9ZSjcHsaF
 a7dtQLT/t7rIqOqXHqtUsHKQ4rdJPaHgkMXqYuQrwQ5JGG8p7WoxURzGD Q==;
X-CSE-ConnectionGUID: m2K06qqvSjq+oM4yKCEZ2w==
X-CSE-MsgGUID: PW0J021qRqCYoTUGdkMw7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117024"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117024"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:06 -0800
X-CSE-ConnectionGUID: pyU+1OlDRSuACyxxuQoHjg==
X-CSE-MsgGUID: b4enGWwoSX2MEsul/OZ6zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270161"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:05 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 00/13] net/intel: tx path selection simplification
Date: Tue,  9 Dec 2025 11:26:39 +0000
Message-ID: <20251209112652.963981-1-ciara.loftus@intel.com>
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

This series aims to simplify the process of selecting a Tx burst
function for the Intel drivers i40e, iavf, ice, idpf and cpfl by:
1. enforcing the same tx burst function for both primary and secondary
processes.
2. using a common function for selecting the tx burst function based on
maximum SIMD width, function features (context descriptor, single queue, etc.)
and requested tx offloads.

Some fixes are made to errors in the documentation that became evident
while implementing the new selection infratructure in each driver.

Ciara Loftus (13):
  net/intel: introduce infrastructure for Tx path selection
  net/ice: use same Tx path across processes
  net/ice: use common Tx path selection infrastructure
  net/iavf: use same Tx path across processes
  net/iavf: use common Tx path selection infrastructure
  net/i40e: use same Tx path across processes
  net/i40e: use common Tx path selection infrastructure
  net/idpf: use common Tx path selection infrastructure
  net/cpfl: use common Tx path selection infrastructure
  docs: fix TSO and checksum offload feature status in ice doc
  docs: fix TSO feature status in iavf driver documentation
  docs: fix inline crypto feature status in iavf driver doc
  docs: fix TSO feature status in i40e driver documentation

 doc/guides/nics/features/i40e.ini             |   2 +-
 doc/guides/nics/features/iavf.ini             |   4 +-
 doc/guides/nics/features/ice.ini              |   6 +-
 drivers/net/intel/common/tx.h                 | 100 ++++++++
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 114 +++------
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  10 -
 drivers/net/intel/i40e/i40e_ethdev.h          |  13 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 186 ++++++++------
 drivers/net/intel/i40e/i40e_rxtx.h            |  20 +-
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 -
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 -
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |   6 -
 drivers/net/intel/iavf/iavf.h                 |   2 -
 drivers/net/intel/iavf/iavf_ethdev.c          |   9 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 241 +++++++++---------
 drivers/net/intel/iavf/iavf_rxtx.h            |  46 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  39 +--
 drivers/net/intel/ice/ice_ethdev.c            |   1 +
 drivers/net/intel/ice/ice_ethdev.h            |  12 +-
 drivers/net/intel/ice/ice_rxtx.c              | 201 +++++++--------
 drivers/net/intel/ice/ice_rxtx.h              |  30 ++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  35 +--
 drivers/net/intel/ice/ice_rxtx_vec_sse.c      |   6 -
 drivers/net/intel/idpf/idpf_common_device.h   |  10 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  49 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 +
 drivers/net/intel/idpf/idpf_rxtx.c            | 112 +++-----
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  10 -
 28 files changed, 664 insertions(+), 624 deletions(-)

-- 
2.43.0

