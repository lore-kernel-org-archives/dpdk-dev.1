Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F67EFB7F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:50:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F5B0402EF;
	Tue, 24 Feb 2026 08:50:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4FCBE402E8
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771919456; x=1803455456;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=p6tIcNPZAJUbpB7qiYTyg0s0+MOunx50I63pOWgM7fo=;
 b=dKDoOTWBYZVVRlIaleiGhir0QJICyNrfjMeDJi60os1Nxx9G6cfWxOcg
 KxL8YQ+PgyY12Ao/XxwSDkCgnTrS1Uqlb+3d/hzcs4l3E+AKdPYCBFR5P
 spKN49RMwlU32npFn4ohVUVKpc8PrEWxYmQpr5P8RGoYx8RXiQuVN4BkF
 MVMDnl64na5Mjx9aClA3tYAgrOWnwmqh4TgDJQx1MQ8NchpFfW9KRqyZ8
 IdzriJHhGQPxZxmvIFNr1t7Vulm/ioflgqCu1Blrrp94t44LYWXxFXmVb
 w2NX5DAiMniiSQOt2ruVuntLOl4ThyNy8xIbyx3trsfC0LzXxkwq+BzKp g==;
X-CSE-ConnectionGUID: j4VHxIdFRo6QsO/416AKNg==
X-CSE-MsgGUID: d5XM97kfRJGDh5tl0m8wxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="60504702"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="60504702"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 23:50:55 -0800
X-CSE-ConnectionGUID: e8GgOLdjRIqcAjz0yyL10w==
X-CSE-MsgGUID: JyfeILxaQr+vA03oQzox5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="214916767"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa006.jf.intel.com with ESMTP; 23 Feb 2026 23:50:54 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v12 0/3] net/idpf: enable AVX2 for split queue Rx/Tx
Date: Tue, 24 Feb 2026 13:17:23 +0530
Message-Id: <20260224074726.2392669-1-shaiq.wani@intel.com>
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

v12:
*Addressed AI generated comments.
*Rebased on latest next-net-intel tree.
*Included a release note entry.


v11:
*Fixed indentation issues.

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
  doc: add note on unsupported completion queue sharing

 doc/guides/nics/idpf.rst                      |   5 +
 doc/guides/rel_notes/release_26_03.rst        |   4 +
 drivers/net/intel/idpf/idpf_common_device.h   |   2 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  67 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 311 ++++++++++++++++++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ----
 7 files changed, 397 insertions(+), 56 deletions(-)

-- 
2.34.1

