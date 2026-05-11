Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6411CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 09:17:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5870402BD;
	Mon, 11 May 2026 11:17:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id BDCA2402BC
 for <dev@dpdk.org>; Mon, 11 May 2026 11:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778491071; x=1810027071;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mGW4Dg/+s1nbcs9EcQW3/79GcoqiLQXdtjzmeWgQBDg=;
 b=Y7qRYDv9UbmTmWvLpWQYIhsKhl+VdFqhCQZ9FtOG9aeR8YDx7OZ4SdSg
 7flRqD1l06YkGtx+dAWZ/kK4CSHWpt6saWr6SwS227fP6hMhHA2Zbwbfq
 ykdIGL5et5LXjtPbBiAiKLKPno6cz3Z532Vl4XbTkygHrb1FvonvZwgiD
 V5/zfR0p0Xr7UoNfNIumfyv68famf7essb8458r2NtYCdiQduwYFh/BWu
 F37rzVNGU9OvMjVGWwf0MSaSoCiDaKZ79UqzD1gxqmZF25184/LoheDCj
 TdI6UVGEhvzAo7iDPto/nWR7Kd4+lnfscHYbjcrvge0qE+eyWPjLxBssw g==;
X-CSE-ConnectionGUID: 1FplKrmPSByhbx/euqZejA==
X-CSE-MsgGUID: nUKAqHofR0iYy6k59zvttg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96937037"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="96937037"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:17:49 -0700
X-CSE-ConnectionGUID: mK3bDpRiRBaDAvsEIaMfUQ==
X-CSE-MsgGUID: UnM4TtQRRvu1H4GNglyqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="234739673"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa008.fm.intel.com with ESMTP; 11 May 2026 02:17:48 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH 0/6] net/idpf: fix split queue AVX2 datapath
Date: Mon, 11 May 2026 14:39:29 +0530
Message-ID: <20260511090935.2288837-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix the split queue AVX2 vectorized path to correctly handle the
virtchnl2_rx_flex_desc_adv_nic_3 completion descriptor format and
the flex scheduled Tx descriptor encoding.

The split queue completion descriptor layout is significantly
different from the single queue path — the generation bit, DD bit,
and packet length occupy different positions than the base Rx
descriptor, and the buffer queue owns the mbuf pool rather than the
completion queue.

On Rx, four issues are fixed:
  - Generation bit extraction order (mask-before-shift)
  - DD bit byte offset (byte 8 not byte 1)
  - mbuf initializer sourced from bufq2 instead of the completion queue
  - Packet type inserted into the correct AVX2 lane

On Tx, two issues are fixed:
  - Buffer size shift corrected from 34 to 48 for flex descriptors
  - Burst clamped to tx_rs_thresh with proper tx_next_rs tracking

Shaiq Wani (6):
  net/idpf: fix gen bit extraction in split queue AVX2 Rx
  net/idpf: fix DD bit byte offset in split queue AVX2 Rx
  net/idpf: fix mbuf initializer source in split queue AVX2 Rx
  net/idpf: fix ptype insert position in split queue AVX2 Rx
  net/idpf: fix split queue AVX2 Tx buffer size shift
  net/idpf: fix split queue AVX2 Tx burst and completion

 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 72 +++++++++++--------
 1 file changed, 43 insertions(+), 29 deletions(-)

-- 
2.34.1

