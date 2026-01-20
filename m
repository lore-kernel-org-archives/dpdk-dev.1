Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7259D2ECF9
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 06:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91C6B406A2;
	Tue, 20 Jan 2026 07:34:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5DF4340273
 for <dev@dpdk.org>; Tue, 20 Jan 2026 07:34:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768890842; x=1800426842;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LEEc+DGaYcLN3oK5yWEvc4/h07j17gAe7d1PNTgVnJc=;
 b=M82Lp3ezNit+aJ3tIS362fkTXqAPqj9jK6uhrq1GxbXzcTdSwsV7m+l0
 alSTyLbBTvxP6ZNLoxULxclU8bhYtUlslGeQI+lGa2As1UCO4o/7lEhHw
 z5PegwA9XgsW5aIYHk4s7ID4ebtjfj7VaE4gB9XzyQXs0x4mK1Vnqotxi
 pSx3BXL4s7SHhBmzvUTuZNAfbkxZyLmzlv4mpP7T4gpP5CAXP2O6tp3l6
 msEf078I56Zg8RtyG8ba6w3BQq3+CoZp4sg3ywxW/1waQ7nljZGSNYoY7
 MMhu5b57B/xk4WCyeRbjcXsU97IiaejgfplYjOE0yu+p0JRAqrrVpftl/ w==;
X-CSE-ConnectionGUID: hj0EgPZLRSS0d48oUiCaUQ==
X-CSE-MsgGUID: XsjYjzYpTx6pUdiLK2nsOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81200580"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="81200580"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 22:34:00 -0800
X-CSE-ConnectionGUID: 0DuqigerTm+DNF5R1cDEZw==
X-CSE-MsgGUID: yiSSo6gUQw2t9f+6RZwn4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="205836417"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa009.jf.intel.com with ESMTP; 19 Jan 2026 22:33:57 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v4 0/4] Enable PTP feature for MEV
Date: Tue, 20 Jan 2026 14:11:16 -0500
Message-ID: <20260120191120.137078-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251103160646.140084-1-soumyadeep.hore@intel.com>
References: <20251103160646.140084-1-soumyadeep.hore@intel.com>
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
  net/intel: add support for Precision Time Protocol
  doc: add PTP IDPF documentation

 doc/guides/nics/idpf.rst                      |  15 +
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
 11 files changed, 1561 insertions(+), 162 deletions(-)
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/intel/idpf/idpf_ptp.h

-- 
2.47.1

