Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A949CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 17:27:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52BC24028C;
	Mon, 27 Oct 2025 18:27:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id DBC8D4021E
 for <dev@dpdk.org>; Mon, 27 Oct 2025 18:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761586054; x=1793122054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eLDvfINGuu9BvOr8hi4C2yqEClCkfkcfv5+UmAFUjlY=;
 b=CEq1D3ai9wk6dZ/qTHsv515jQs1GKXKxkg1PSiMwhW9U6ia7pwzx6o+r
 qHd6qeM6TAqzp5yg1ieV3EOBqqg9ctGG1qRATQSpri7OjBSCF72zlt49d
 vNf7/kBIa+bKkNEHKYCVTuQ4w6yMVwiVa7fmaHYhEjreysMiyIle2r/O0
 /Z/zaGdt/qiOrWrUIlh6UdlhyWV8o5rI/Uknsru0wS+hU6FTVxazEaEow
 mAs5sKtnFweplgZDlzinQkIzbLuM9ZJ/9oWixUlvGokHJiGNFJm9D8oKP
 zH+V+0goowdGvd7L64uP8hxfr8D5ztGn+HSAyRznfjm3+8ygzuZN6gSr7 A==;
X-CSE-ConnectionGUID: fusrVocPT+OL4ihVAWeXiA==
X-CSE-MsgGUID: 0zpyyVSWToWYTnS5y6K1Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74350881"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; d="scan'208";a="74350881"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 10:27:33 -0700
X-CSE-ConnectionGUID: bypESbO3SISluockl5SYWg==
X-CSE-MsgGUID: 4uci6rNkQXuDX0CtdJJPzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; d="scan'208";a="189140734"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa003.jf.intel.com with ESMTP; 27 Oct 2025 10:27:31 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v2 0/4] Enable PTP feature for MEV
Date: Tue, 28 Oct 2025 02:07:54 -0400
Message-ID: <20251028060758.233929-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024120840.420016-5-soumyadeep.hore@intel.com>
References: <20251024120840.420016-5-soumyadeep.hore@intel.com>
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
v2:
- Fixed essential checkpatch warnings
---
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
2.47.1

