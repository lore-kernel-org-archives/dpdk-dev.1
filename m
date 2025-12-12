Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD640D4417C
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:06:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDB5A40664;
	Fri, 12 Dec 2025 12:06:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7BD45400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 12:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765537598; x=1797073598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b4rYayy83OGiIqFEk8A0VqD0z8UHJtcFjVXnMQ5hbuw=;
 b=l4tMUEK9kJjyI+K8WCWFNNwisu4PK1pabKcqPJ2iqNWv2wJCQZqpHlkT
 4mkcFMzE4orBjYnH8vs5E2fh7U1cBSPSYEvDenOF89kN70ycqW4IWJAQt
 R0/ImNlJZg+CCwKcm1gDG9OC0Uk8SM3bCUkvaddT7jZSrcLCu+ONf+0CD
 vG3jkujHphxuJaiO65MZDfY89pKNP4uavc3upgyjhsZmyvoceHqNm6aVn
 sslj1SNIyDhQTsXGa2upYL0KEQnX9fqT/pcNRRYcJDHHnx0Om9jBhhzOb
 TXZMh+grWkSAAX2gP8eY2zBXeaJV+uWJbXivmdSCc5f6gsYyMg46Fhcc4 A==;
X-CSE-ConnectionGUID: WT7anieDRjOXCNnbj1vjeA==
X-CSE-MsgGUID: k5lsJAxfRGGkU0+kIUn3SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67472045"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67472045"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 03:06:36 -0800
X-CSE-ConnectionGUID: QdwAZicNQIWB1urVRRGPjw==
X-CSE-MsgGUID: jIEJbL+oSHu90Wb88melvw==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:06:35 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 00/10] net/intel: tx path selection simplification
Date: Fri, 12 Dec 2025 11:06:18 +0000
Message-ID: <20251212110628.1634703-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212103323.1481307-1-ciara.loftus@intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
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

v3:
* Fixed cross compile issue in iavf patch.

v2:
* Consolidated the patches that enforce primary/secondary path selection
alignment and the introduction of the infrastructure per driver.
* Introduce the "simple tx" feature in patch 1 rather than later.
* Changed some types and arrangements of structs in tx.h
* Fixed some issues relating to mbuf_check and tx_pkt_prepare
* Use the same path in primary and secondary for idpf and cpfl as well.

Ciara Loftus (10):
  net/intel: introduce infrastructure for Tx path selection
  net/ice: use common Tx path selection infrastructure
  net/iavf: use common Tx path selection infrastructure
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
 drivers/net/intel/common/tx.h                 |  96 +++++++
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 120 +++------
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  10 -
 drivers/net/intel/i40e/i40e_ethdev.h          |  14 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 190 +++++++-------
 drivers/net/intel/i40e/i40e_rxtx.h            |  20 +-
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 -
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 -
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |   6 -
 drivers/net/intel/iavf/iavf.h                 |   2 -
 drivers/net/intel/iavf/iavf_ethdev.c          |   9 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 240 +++++++++---------
 drivers/net/intel/iavf/iavf_rxtx.h            |  46 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  39 +--
 drivers/net/intel/ice/ice_ethdev.c            |   1 +
 drivers/net/intel/ice/ice_ethdev.h            |  14 +-
 drivers/net/intel/ice/ice_rxtx.c              | 204 ++++++++-------
 drivers/net/intel/ice/ice_rxtx.h              |  30 ++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  35 +--
 drivers/net/intel/ice/ice_rxtx_vec_sse.c      |   6 -
 drivers/net/intel/idpf/idpf_common_device.h   |  12 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  49 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 +
 drivers/net/intel/idpf/idpf_rxtx.c            | 118 +++------
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  10 -
 28 files changed, 677 insertions(+), 630 deletions(-)

-- 
2.43.0

