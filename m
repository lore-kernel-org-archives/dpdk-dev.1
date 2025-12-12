Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B218D44166
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2717040659;
	Fri, 12 Dec 2025 11:33:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E4CE6400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:33:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535616; x=1797071616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=21XtYNXoUnMiCBnuEzBv59saebS+SYvaJF91MIiHGhQ=;
 b=M0zNzW/zVbIbEgDEr+L9ZfH+ACTAYYVQGAT58+H09GO40pl91RyAomK9
 frr9eXPeG6Uewt1i2iJJWiNQ4RF2wCpnej1XvuTM90FitU/CnOEQO5vfp
 eF9ysZ1P68TPvLw3lF5DvNkcfbfRMzY4Orbh7729ePOagcDQPQqzTK7Pg
 mmY8F2DmKT5KJgYhE4qemouRdgf2IQpaVsUw1y3QYRCn4xUuT5dlHaIQP
 B6owtACte5oop38T1GH+jv609F87UpfmGkTMlZ5WGpvXniRmj7sOKQMyW
 0QmPZEGp0BNzcush4iWN33hF0Z9cvnzJPAjZ0o3xxgs38rTeJIRE5UlMb w==;
X-CSE-ConnectionGUID: T/AmX6kbS06NoKkKZ3VFww==
X-CSE-MsgGUID: utQon5iVRDiOC6XeTTpTsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66522876"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66522876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:33:35 -0800
X-CSE-ConnectionGUID: p1YstGASQ4Cq8pGWgXrCjQ==
X-CSE-MsgGUID: 4OtrnxO3TWyuEzICifprZg==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 02:33:27 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 00/10] net/intel: tx path selection simplification
Date: Fri, 12 Dec 2025 10:33:13 +0000
Message-ID: <20251212103323.1481307-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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
 28 files changed, 675 insertions(+), 632 deletions(-)

-- 
2.43.0

