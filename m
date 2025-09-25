Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F0CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 09:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31F6440672;
	Thu, 25 Sep 2025 11:20:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 70FC84028F
 for <dev@dpdk.org>; Thu, 25 Sep 2025 11:20:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758792035; x=1790328035;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Ob710WaPN9I1sZ7I4ju6Gbo/OM0GAHXRJy20XsZZZjk=;
 b=G+PE4gZ0VliOrzV64ifkpAB8H/1CVN+116lK0B/Z1N9Nc/WueamV8yrj
 FW3lQrvqzs17S69kC2nwpF/ZpHkSW3ss96CoAviX3I9UBBvEtLD9GPEwP
 daE/LC5oIJIiMo/mp1y8w31XFKBEWTAxUPcFDb4tf4Doc3wDlBbX/GVTm
 2dzCIJYZsOKAXI8UMDX8g3sAjjQii/09n/P5I73Udy3rsN4ONEDjqZDMa
 /eXpNO6XjWc3frrWRl4FB6Dv0MS0Cx2Bb3ZIq6xNdT6bT6crlrBNkAUNg
 JDgK32Q0xFct4oEY533G79NKbukW2oqXnKksKaVmypbBZ6y9UormmAp+0 g==;
X-CSE-ConnectionGUID: pUMz2lbCQ6uKfcBZjvtPiw==
X-CSE-MsgGUID: LQf6g/aDT9WvurPWckGBpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71788286"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="71788286"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 02:20:34 -0700
X-CSE-ConnectionGUID: nBPx0V7eRQ6O1J32anmvoQ==
X-CSE-MsgGUID: U67Zg3+mSEerazHsv0DDLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="200969398"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa002.fm.intel.com with ESMTP; 25 Sep 2025 02:20:33 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2 0/2] net/idpf: enable AVX2 for split queue Rx/Tx
Date: Thu, 25 Sep 2025 14:50:18 +0530
Message-Id: <20250925092020.1640175-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917052658.582872-1-shaiq.wani@intel.com/>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

In the single queue model, the same descriptor queue is used by SW
to post descriptors to the device and used by device to report completed
descriptors to SW. While as the split queue model separates them into
different queues for parallel processing and improved performance.

v2:
*Fixed CI build related issues.
*Rebased on top of idpf/cpfl rx path selection simplication patch.

Shaiq Wani (2):
  net/idpf: enable AVX2 for split queue Rx
  net/idpf: enable AVX2 for split queue Tx

 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |   7 +
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   6 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 451 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 5 files changed, 474 insertions(+)

-- 
2.34.1

