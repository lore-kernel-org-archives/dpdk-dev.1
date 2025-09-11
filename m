Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5681CAC587
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 14:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C21D402C4;
	Thu, 11 Sep 2025 16:32:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 77FA740285
 for <dev@dpdk.org>; Thu, 11 Sep 2025 16:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757601125; x=1789137125;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nmVYJYB1T2dc2zVBTf1q8f62CkMMsjWq/avqjonNyj4=;
 b=jJo6xNNMngZnvLQOTcyCfJMbdlwXV/ivsdg053F1MuLNJA93iChaE0df
 cr77M9JfKhPbfmB9ehXGOnNKrGnbI4a4KDWoMKoRPlKY8EHL4qBKJ24Dw
 y5li8n470NsEertAbTbub0z7rUBJpv4qNCq25t3mKsBuj3GEX+ctz7WhD
 RvpqqviTNTljGfd8ZS2vNY5ALizqDsCyh0G//XlkigadLRwrtqcqp4WLa
 sY5+dGqrwtzNHkVgpMvX6bK/A6xbeq+mbl5m7qGFKswCZZeOvwdcM04GZ
 kiGMQoYfOM4sNF593EPy6XFv0X9yqHHAx9/Dfl9nlCRP5z0z+wmYbxJpo A==;
X-CSE-ConnectionGUID: W/qo1JTfTH++T54cf1QjZw==
X-CSE-MsgGUID: Mu+OckneTQGREdoQi6qDgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="62562479"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="62562479"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 07:32:03 -0700
X-CSE-ConnectionGUID: 7UYu6sRVRV2XvyoT5gcdzw==
X-CSE-MsgGUID: 3zd8wYnGSPGIMvi6jvwVDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="210845010"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 11 Sep 2025 07:32:03 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/4] idpf and cpfl rx path selection simplification
Date: Thu, 11 Sep 2025 14:31:41 +0000
Message-Id: <20250911143145.3355960-1-ciara.loftus@intel.com>
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

This series refactors the vector capability detection and Rx path
selection code in the idpf and cpfl PMDs to use the common functions
provided in drivers/net/intel/common/rx.h.

Ciara Loftus (4):
  net/idpf: use the new common vector capability function
  net/idpf: use the common Rx path selection infrastructure
  net/cpfl: use the new common vector capability function
  net/cpfl: use the common Rx path selection infrastructure

 drivers/net/intel/common/rx.h                 |   5 +
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 143 +++++-------------
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  20 +++
 drivers/net/intel/idpf/idpf_common_device.h   |  17 ++-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  24 +++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 ++
 drivers/net/intel/idpf/idpf_ethdev.c          |   2 +
 drivers/net/intel/idpf/idpf_rxtx.c            | 141 +++++------------
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  19 +++
 9 files changed, 167 insertions(+), 216 deletions(-)

-- 
2.34.1

