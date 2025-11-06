Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E33CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 301584067B;
	Wed,  5 Nov 2025 19:06:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6C07C4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 19:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762365966; x=1793901966;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C+voSdz3JgOUBs29M9+twwXo3UJfXKp36cZMjmDFShA=;
 b=c8o4TZm7xJtHwAAms7TvsCbKXNnJWRUcOfSazS66Iw4ql+UguAe164y3
 /PZGbDBpARPmvZySUxH2jgzulMLCQT7RKn54grgZnIe5XN+Izo2/LfVga
 NlinoQOR6vmTSeJTyBNR0iyUhoh/GrDgQ23nsfKIbiPSnEPavb3NrIj+4
 NfsObfhcxjM1EwR/8b5TKyII0ziUv7qpDh7imfqLLIQI+zotAiprB1MH7
 +P2vIxZAXOpHnee8cX752LyT4M8ie/2SJ1ogyHGOsLsBDd/WOl69ZPtQr
 85yFvwdN/K15HEAinTOZo9LsYAnpgtdwxfxvqPZQjdjzO1DtsgLG+EznN Q==;
X-CSE-ConnectionGUID: R3FbfTOpRGKU0ksuomqNOg==
X-CSE-MsgGUID: KFB2D1RbQXy0X+bLjW6Xdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75841999"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="75841999"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 10:06:05 -0800
X-CSE-ConnectionGUID: NhBY+FPFQCCAX5GmsMTLsw==
X-CSE-MsgGUID: sPSCEKE+QB2w9548/ceM7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="187368612"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2025 10:06:02 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v3 0/4] Update TxPP feature
Date: Thu,  6 Nov 2025 01:46:33 -0500
Message-ID: <20251106064638.23020-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251030173304.260209-3-soumyadeep.hore@intel.com>
References: <20251030173304.260209-3-soumyadeep.hore@intel.com>
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

Fix bugs in TxPP implementation and update the documentation
for the same.

---
v3:
- Addressed Bruce's comments
- Enabled ieee1588 fwd with TxPP
---
v2:
- Addressed Ciara's comments
---
Soumyadeep Hore (4):
  net/ice: restrict ice PMD to scalar path for TxPP
  net/ice: fix PTP clock corruption with TxPP
  net/ice: enable PTP packet forward with TxPP
  doc: update TxPP documentation

 doc/guides/nics/ice.rst                     |  4 ++++
 drivers/net/intel/ice/ice_ethdev.c          | 18 ++++++++++++++++++
 drivers/net/intel/ice/ice_ethdev.h          |  2 ++
 drivers/net/intel/ice/ice_rxtx.c            |  2 --
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  3 ++-
 5 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.47.1

