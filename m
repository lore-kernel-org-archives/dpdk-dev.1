Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEFECCF9FE
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 03:26:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF65340270;
	Mon,  3 Nov 2025 04:26:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9B6D64021E
 for <dev@dpdk.org>; Mon,  3 Nov 2025 04:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762140373; x=1793676373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1l88qPzvCqhlsO2IiQDbaHCIaDuvClhqkgl9xKPPaaY=;
 b=NVhJTQ0Vwtxg2REhgLJvjCUw3Av06p703W8i78x6FQfblzc8zhBP2QX6
 y4Qo76gZOvhfpUkzqE7R+J80IwRHCsiXnXexcGh7MZLI9sjBNwgSSGpbG
 NT8Re8AuTm4209dRY1QAfd2Y4TFSi1+plTud9Ks3fWxAa0EPssgNVmeST
 Ka+zO5L91B9KvBldgW+aywdElX3BNOt+3khuHwlfKjE1HPK4jz48oSVGm
 YYu9GVLp4HuzuyKBwvhm0mchpa8sonv7//QCzwLNMMB1qR9H+9E+lQGJQ
 gi37cO9vyMhiQKL+KXn23ZCVUcMfHYAqTzS+0R0id56e+jY7IIRriUW4H w==;
X-CSE-ConnectionGUID: gcuXJV9fR36rNRQeWrfVFg==
X-CSE-MsgGUID: qQqDkS2lQliMqw5pyV5e/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="86836197"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="86836197"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2025 19:26:12 -0800
X-CSE-ConnectionGUID: +QwWHWgsR9i5P7XJ7SDUUg==
X-CSE-MsgGUID: vXkMuL/SR9C1VihfQRPEvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="187481817"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by fmviesa010.fm.intel.com with ESMTP; 02 Nov 2025 19:26:10 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: rajesh3.kumar@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v3 0/4] Enable PTP feature for MEV
Date: Mon,  3 Nov 2025 11:06:41 -0500
Message-ID: <20251103160646.140084-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251028060758.233929-1-soumyadeep.hore@intel.com>
References: <20251028060758.233929-1-soumyadeep.hore@intel.com>
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

