Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5823C02190
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 05:11:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 856D940287;
	Mon,  3 Feb 2025 06:11:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1EBA740264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 06:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738559491; x=1770095491;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=bm4cq9GXejTfQZ/EAXGORYXS80Zh2W4447tpnFIXZD0=;
 b=kEJuhutgY5KKkLiipOlS56Bc2YEC78WBrGfH8/U4xLmzeZu4iS5pZHC5
 rT+Ox9uaPDsIwdnHwLiiYgJNHOj16Zg4PthWjES88+0RaiqeUtCxedKNg
 rNmEz09fnqJ4iENP/wP6VREeNmBzC1ozZbCeIgz0qDEmkIrmb0hLXnWcQ
 N/iZPj8ZpZJvA6YiN9V5EBXAjp/r89hZsEuwuJ5YYDeLPQ71fQ/e8rr9o
 QHMEa9dt0Hb3JCTWzxpTQ3jXkwz+DxUEjoIzrDd7gbKBJ8mE6cTnFKTIl
 jwOghYbR5qkvpHqgsV7RTExvGm30pg36qKO6n/h4JBu+Mhee5+ERQD1qi A==;
X-CSE-ConnectionGUID: C2pjOsMEQVeSLPwsB1nxqA==
X-CSE-MsgGUID: KTWIcDfBRyG2QwreVdBOKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="38924511"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; d="scan'208";a="38924511"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2025 21:11:29 -0800
X-CSE-ConnectionGUID: /0zlUqJBRR6zfEoCiutXUg==
X-CSE-MsgGUID: VtYqhWEXRXiA2FL+OrCBrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; d="scan'208";a="110348890"
Received: from npg-npf-wlpr-srv12.iind.intel.com ([10.190.212.205])
 by fmviesa008.fm.intel.com with ESMTP; 02 Feb 2025 21:11:27 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v4 0/2] enable AVX2 for single queue Rx/Tx
Date: Mon,  3 Feb 2025 10:54:28 +0530
Message-Id: <20250203052430.1243485-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130082445.1112043-2-shaiq.wani@intel.com>
References: <20250130082445.1112043-2-shaiq.wani@intel.com>
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

v4:
- Addressed review comments.
- Used newly introduced macros as suggested.

*** BLURB HERE ***

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

