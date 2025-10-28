Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80DECCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:22:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F08204060B;
	Tue, 28 Oct 2025 15:22:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 131664021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761661330; x=1793197330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vpgcM2Vw3Rd+Wulggi2rni3VhqdsFpLs5UGYBss9PU8=;
 b=lGGog06L/yUvgk4XAJx0NZFVVIu5MyasSjJDsUkAEOTPuP0FBkS35lVU
 i0GqFGNqK6gxX93B5J9FRYogQywbjEQze/PoGi/OzoWBwKFesRI1DOfdQ
 s1JWPNeWGkGMLSbU5sGjWcLEu/x/Hh+pUZWCiVDB8g3z6rgOdlZ0DR8DS
 ARqUUKQ6hlfIxLLxUhB8XnOKLxT0f9GmbkFeQaO1KRvnbdgCm8iH0DcDZ
 DoOLz4KOKAQKbk7+3sbb27XY+dlq1+0/I2/1KGKCIoOTulmwuCRbiPx5O
 AHnC5I2FwpscspoJr3P+3vvrcolMEuSO0vuc41j+IFWVj1wEKfKb/x9Gd Q==;
X-CSE-ConnectionGUID: Az4SD8HIR1SEeHN7DTaWTQ==
X-CSE-MsgGUID: YH6oQkBxRy2PvTWOZCQd7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67626436"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="67626436"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 07:22:09 -0700
X-CSE-ConnectionGUID: rpg9jH1gQr65X9/NVNoVEw==
X-CSE-MsgGUID: 3skpMss6Q9mTaGjNoCQrSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="185681755"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 07:22:08 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v9 0/3] net/idpf: enable AVX2 for split queue Rx/Tx
Date: Tue, 28 Oct 2025 19:51:59 +0530
Message-Id: <20251028142202.137392-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917052658.582872-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
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

v10:
*Changed desc reading style in Rx path.

v9:
*Some minor fixes.

v8:
*Reworked the receive func to avoid race conditions in Rx path.
*Removed unnecessary compiler barriers.

v7:
*Removed (char) casts, ifdef block as suggested.
*Fixed indentation, line wrapping.
*Did blind write of data to avoid branching.
*changed desc building and writing  order for Tx.

v6:
*used single load/store in splitq_recv_pkts function.
*removed x86-specific intrinsics from common code.

v5:
*Fixed CI errors.
*Used defined constants instead of numbers.

v4:
*moved splitq_rearm_common to a common location.
*reduced duplication of code.
*fixed splitq_recv_pkts function.

v3:
*Fixed some indentation issues.
*Collapsed wrapper and core function into one.
*Fixed some pointer casting and naming inconsistency issues.

v2:
*Fixed CI build related issues.
*Rebased on top of idpf/cpfl rx path selection simplication patch.

Shaiq Wani (3):
  net/idpf: enable AVX2 for split queue Rx
  net/idpf: enable AVX2 for split queue Tx
  doc: note on unsupported completion queue sharing

 doc/guides/nics/idpf.rst                      |   5 +
 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 299 +++++++++++++++++-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ----
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 7 files changed, 379 insertions(+), 58 deletions(-)

-- 
2.34.1

