Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D42F4368B
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:56:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4E13402B0;
	Fri, 17 Apr 2026 12:56:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D2800402A3
 for <dev@dpdk.org>; Fri, 17 Apr 2026 12:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776423390; x=1807959390;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h1BuS0ITHbuEHFLtUP3az7y8lMp5OZGFm0Tlo9IUwTU=;
 b=YTZajUPVzrLDhURQOUu0/WdcD2kzQMcz176rkE2AdJKHbN/j1kMNmEvm
 EA9uKcG0Vg5YVPxMrhnRxlkf4kCjWtbKjlJAHEX7He2S5cx0u8ggiXtvY
 mftKgRxcwtYgcroI8d9Y7YPfO0N8JeQIXcIfHIcpYkyJRs2V7a4FcPHYu
 Bfr1ySzQrbCdAVimm3gQmdQhdsyUdTHSVHWor+2uoNSyWDSwj8f3cAbhu
 ZVEAgcI+amejCUWVBals+yUf3lrBYvtURi2DstWBjcDeNc0u0a5750iyk
 nDWwqDJwuVOHdH0F1zjx2ZjqyQVvVIErgBXfAIjeaBo8mK9itrH3RDnZi A==;
X-CSE-ConnectionGUID: S5d43gugTOGmti5ZJ1PvVA==
X-CSE-MsgGUID: kfVPYm8bTEqW4mscvRtp6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="87739757"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="87739757"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:56:28 -0700
X-CSE-ConnectionGUID: q67Tric0Q3m4VFpQceNCkA==
X-CSE-MsgGUID: EIlcvUTzT5iz/GUleIJRtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="224498002"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa009.fm.intel.com with ESMTP; 17 Apr 2026 03:56:28 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v4 0/3] iavf: LLDP ptype and AVX2 ctx paths
Date: Fri, 17 Apr 2026 10:56:07 +0000
Message-ID: <20260417105610.1161242-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417100804.1143121-1-ciara.loftus@intel.com>
References: <20260417100804.1143121-1-ciara.loftus@intel.com>
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

v4:
* Fix build error by replacing commas with semicolons in patch 2

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

