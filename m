Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA48F43688
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49334402B2;
	Fri, 17 Apr 2026 12:08:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 67395402A3
 for <dev@dpdk.org>; Fri, 17 Apr 2026 12:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776420495; x=1807956495;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/LlxI7MZvhpmYT0UYBgcbl3X8QIYEYkeQGl563Wot0g=;
 b=dzG4M3OhMiB2sAbsnXIxfId4raQuP5GbLqOP/EHHoBlMiXh3ZlQHp6f4
 azx94qwxL1xLPJ6NOhoFf/oCvW68EpBoqaVFQwJmUNSW5q9BMY60MAWq5
 pPog7CU9EFOkQrA3kORVtLcY1EH55XwiRJHygtNjnTC+oQ5a9ZZ/tOb5Y
 +fe3cFPz5q4j3QxAlNjQnTvG/tXEO03UOUsiYq0emoQjcXCSv26mQSXiL
 X9IbS26B1ykgzdGa1q+WFOO0d1wNI6QwQlDGVo7ozmr91vcrrF3vo1Xtg
 PN+XT4TDJnRRTIEhjv8w3RfyoZBlGClyDOaZIrUtczHW5cddtHOAoPlrU A==;
X-CSE-ConnectionGUID: 7afmGwJEQ2WNTfLwm3gTzw==
X-CSE-MsgGUID: qMStAVZdSK2z7vVMZly2Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88887886"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="88887886"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:08:14 -0700
X-CSE-ConnectionGUID: ZZzWLG1PTueth5RBHdZk1w==
X-CSE-MsgGUID: 2R+UU6Y+S6CzE9eZa9xw8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="234987809"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa003.jf.intel.com with ESMTP; 17 Apr 2026 03:08:13 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 0/3] iavf: LLDP ptype and AVX2 ctx paths
Date: Fri, 17 Apr 2026 10:08:01 +0000
Message-ID: <20260417100804.1143121-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306115214.467033-1-ciara.loftus@intel.com>
References: <20260306115214.467033-1-ciara.loftus@intel.com>
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

This series adds another way to detect LLDP packets in the Tx paths
of the iavf PMD, which is based on the mbuf packet type field. This is
in addition to the existing method of using a dynamic field. The series
also adds new AVX2 context descriptor Tx paths that support LLDP. Finally,
a deprecation notice is added to the documentation to flag that the
dynamic mbuf field method of LLDP packet detection will be removed in a
future release.

v3:
* Enable the ptype support via a new devarg enable_ptype_lldp

Ciara Loftus (3):
  net/iavf: support LLDP Tx via mbuf ptype or dynfield
  net/iavf: add AVX2 context descriptor Tx paths
  doc: announce change to LLDP packet detection in iavf PMD

 doc/guides/nics/intel_vf.rst                |  21 +-
 doc/guides/rel_notes/deprecation.rst        |   4 +
 doc/guides/rel_notes/release_26_07.rst      |   6 +
 drivers/net/intel/iavf/iavf.h               |   3 +
 drivers/net/intel/iavf/iavf_ethdev.c        |  15 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  20 +-
 drivers/net/intel/iavf/iavf_rxtx.h          |  13 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c | 386 ++++++++++++++++++++
 8 files changed, 458 insertions(+), 10 deletions(-)

-- 
2.43.0

