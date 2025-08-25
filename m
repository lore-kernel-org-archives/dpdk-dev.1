Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13606CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 12:35:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DA14402DE;
	Mon, 25 Aug 2025 14:35:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 68A944025A
 for <dev@dpdk.org>; Mon, 25 Aug 2025 14:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756125354; x=1787661354;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3DgieAGHAIWcIpXyOlmxPbvKFaDp2gnPzdwic1sTTSs=;
 b=KVXxcH/YDg/+yuzQi2u+7DuM2YJQUOrMEpGOnqWRqhNkAhZATxttG1U0
 KgAtZsDmMU/TPRmwCPKWwJkJ5UhytrPVyXK+MNM1RFMUkPH2y9yFx5N5s
 skUnjz9JFfpSjPNWuHDdlnXCys1kkM1chZ3DRiRu4RO+SshCkQcIu8ztv
 sk64Y/jAP07dWfG6I7NmL0n1bS1UtEhlHpiB38401oswb2E5t15xS323i
 6ScTvieTMU6DlBRjVdQCnCEM2kdAsCyB1YqJOwsyocyEoh5ag8R9Wl5aY
 O+Es4xW/3PMIshncnOLSB9lk8q+3JPJLEq7nHdCzWVKUdGKPuxPdGuGpV w==;
X-CSE-ConnectionGUID: TAK7yfjyRxS3ORC0LWOTdQ==
X-CSE-MsgGUID: 3wKN9vBaR/+0bGl7hfYTAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69049688"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="69049688"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 05:35:53 -0700
X-CSE-ConnectionGUID: wKD6g+tIRKOMyr+FeHhk3A==
X-CSE-MsgGUID: SQgk7AOYS2iSa+U9FcdSWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="168791947"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa007.fm.intel.com with ESMTP; 25 Aug 2025 05:35:53 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/4] Remove SSE from some Intel drivers
Date: Mon, 25 Aug 2025 12:35:44 +0000
Message-Id: <20250825123548.1177090-1-ciara.loftus@intel.com>
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

This patch removes the SSE Rx and Tx paths from the i40e, iavf and ice
driverss. Each of these drivers have faster vector paths (AVX2 and AVX-512)
which have feature parity with the SSE paths. In environments where AVX2 or
AVX-512 are not supported, the scalar path will still be used, which also
has feature parity.

This series is intended for the next-net-intel tree.

Ciara Loftus (4):
  net/i40e: remove SSE vector path
  net/iavf: remove SSE vector path
  net/ice: remove SSE vector path
  doc: add release note entry for SSE removal

 doc/guides/rel_notes/release_25_11.rst      |    5 +
 drivers/net/intel/i40e/i40e_rxtx.c          |   57 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c |   26 +
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c  |  723 ----------
 drivers/net/intel/i40e/meson.build          |    1 -
 drivers/net/intel/iavf/iavf_rxtx.c          |   46 +-
 drivers/net/intel/iavf/iavf_rxtx.h          |    2 -
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c |   27 +
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c  | 1395 -------------------
 drivers/net/intel/iavf/meson.build          |    1 -
 drivers/net/intel/ice/ice_rxtx.c            |   43 +-
 drivers/net/intel/ice/ice_rxtx.h            |    6 -
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |   29 +
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  743 ----------
 drivers/net/intel/ice/meson.build           |    1 -
 15 files changed, 158 insertions(+), 2947 deletions(-)
 delete mode 100644 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
 delete mode 100644 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
 delete mode 100644 drivers/net/intel/ice/ice_rxtx_vec_sse.c

-- 
2.34.1

