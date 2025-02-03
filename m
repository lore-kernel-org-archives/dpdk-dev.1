Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204DBC02193
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 07:42:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11C2C40287;
	Mon,  3 Feb 2025 08:42:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8898340264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 08:42:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738568523; x=1770104523;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lHRFX2Idb7ZXul53JKx8Ke3TCfo1aFDkginWFOFc7vc=;
 b=I3LZRTegnfdtW6NmTutT/f7kzuD1+URvMiKo13UyV58wGKwMqzvCLDtZ
 tZ3TuQ/6Y8OEi+ElFvOfMTBHkHGl/+RKOHQX2qsRE/fJQLfUwOrv9MtW6
 9lWhLMgTnoJ5WTPGh82Who2NjaZalN6dbET9/imJsZPI9gxtHzPXS8ABG
 ucMFsZ3DfQerWL51ZmbKj7tOL0xwxhkGHZySUAjeeaFCZBdbfmp93GRgF
 YJIMikphY2CVkrjsPDzxUCvC5Y+jGjJw7UFGQ/jsK8O4A8lNZVefHdama
 41KKQA4RkMxZq1FbkunecRk2rnk+Ip+i/mkkyeq98GBUTybgquAAzJJiE g==;
X-CSE-ConnectionGUID: 6dbrtLuXTnKmQETUldfBQg==
X-CSE-MsgGUID: hHHhn8ldRIy2p/NbtaQlSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="56479580"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; d="scan'208";a="56479580"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2025 23:42:02 -0800
X-CSE-ConnectionGUID: aNfENXJAQhCj/+cykMIQDQ==
X-CSE-MsgGUID: IUYnqZahRhKE0sI4FQ7J9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="133466621"
Received: from npg-npf-wlpr-srv12.iind.intel.com ([10.190.212.205])
 by fmviesa002.fm.intel.com with ESMTP; 02 Feb 2025 23:42:01 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 0/2] enable AVX2 for single queue Rx/Tx
Date: Mon,  3 Feb 2025 13:25:06 +0530
Message-Id: <20250203075508.1304702-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203052430.1243485-2-shaiq.wani@intel.com>
References: <20250203052430.1243485-2-shaiq.wani@intel.com>
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


v5:
- Addressed review comments.
- Used newly introduced macros as suggested.
- Fixed build and compilation issues.

Shaiq Wani (2):
  common/idpf: enable AVX2 for single queue Rx
  common/idpf: enable AVX2 for single queue Tx

 doc/guides/nics/idpf.rst                    |   8 +-
 doc/guides/rel_notes/release_25_03.rst      |   7 +
 drivers/common/idpf/idpf_common_device.h    |   2 +
 drivers/common/idpf/idpf_common_rxtx.h      |   8 +
 drivers/common/idpf/idpf_common_rxtx_avx2.c | 704 ++++++++++++++++++++
 drivers/common/idpf/meson.build             |   7 +
 drivers/common/idpf/version.map             |   2 +
 drivers/net/intel/idpf/idpf_rxtx.c          |  24 +
 8 files changed, 759 insertions(+), 3 deletions(-)
 create mode 100644 drivers/common/idpf/idpf_common_rxtx_avx2.c

-- 
2.34.1

