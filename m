Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8D4C44536
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 11:27:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFF074021F;
	Thu, 22 Jan 2026 12:27:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9FA2A40156
 for <dev@dpdk.org>; Thu, 22 Jan 2026 12:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769081260; x=1800617260;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BIeWDkthdDiAB1PfFgLM0FHXYy57OWb0y45ztN7jXdU=;
 b=dzWwvw59krpuTrBzMbeS//NLFhtZsCKHZPYyRxga4WNS6JtCfbe6bYmt
 EI4Q+NMCr75g8Pa5wnouPrqER2RisUUZJKzyBgxlAjTtzufqTSSfh2LzV
 y4+z95dwiaHH5qjzbGRH1uFtrBqsp2P8ImqGxaoJegS/Cahk3qZiI2y8Y
 /sI1GdzQ/quUcOWPFMY8neQKX1IHRj65MMYMhEbCjwR23LBms1NKxo91R
 SKS/ocULyLulu7OgFuO552jNANd19XMwA4Y6Egil1f6C+hs4umLWWXbVD
 jnWt7n6mzwXXbDNXaV59h/g//QZgnnRxwTpyznHZB8+Rt3C5DMHtcQjki Q==;
X-CSE-ConnectionGUID: 82Ihv59cRwWShn8XD0K47g==
X-CSE-MsgGUID: Esn51a7zTjmvYMyZf6sriQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74180081"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="74180081"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 03:27:39 -0800
X-CSE-ConnectionGUID: mxN/BLUUQa6jRjlOYCzw3w==
X-CSE-MsgGUID: nBTHE1tkSQy4HqC75wNqPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="229678071"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa002.fm.intel.com with ESMTP; 22 Jan 2026 03:27:36 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v5 0/4] Enable PTP feature for MEV
Date: Thu, 22 Jan 2026 19:04:45 -0500
Message-ID: <20260123000449.188008-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260120191120.137078-4-soumyadeep.hore@intel.com>
References: <20260120191120.137078-4-soumyadeep.hore@intel.com>
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

---
v5:
- Addressed AI comments
---
v4:
- Addressed Bruce's comments
---
v3:
- Fixed checkpatch warnings
- Addressed Bruce's comments
---
v2:
- Fixed essential checkpatch warnings
---

Milena Olech (1):
  net/idpf: add a new API for PTP support

Soumyadeep Hore (3):
  net/idpf: add PTP virtchnl2 support
  net/intel: add support for PTP
  doc: add PTP IDPF documentation

 doc/guides/nics/features/idpf.ini             |   1 +
 doc/guides/nics/idpf.rst                      |  15 +
 doc/guides/rel_notes/release_26_03.rst        |   4 +
 drivers/net/intel/common/tx.h                 |   1 +
 drivers/net/intel/idpf/base/virtchnl2.h       | 324 ++++++---
 drivers/net/intel/idpf/idpf_common_device.h   |   4 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 186 +++--
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  10 +
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  34 +-
 drivers/net/intel/idpf/idpf_ethdev.c          | 270 ++++++++
 drivers/net/intel/idpf/idpf_ptp.c             | 639 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ptp.h             | 227 +++++++
 drivers/net/intel/idpf/meson.build            |   1 +
 13 files changed, 1554 insertions(+), 162 deletions(-)
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.h

-- 
2.47.1

