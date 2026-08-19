Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E1C5DF81
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 14:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 527E4402DD;
	Wed, 19 Aug 2026 16:24:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id C505C402C4
 for <dev@dpdk.org>; Wed, 19 Aug 2026 16:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787149442; x=1818685442;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zgzzDb2IjCxgAOGJ6/i6jIMPQuT9LhdPt5ztuyZZafE=;
 b=ZpAIpZINFOeK6ZDwyI1pvwbg3tvDrcF5sFLnYtNHRNQT1zLBN2OjZ+aw
 ZaKdd84ff5HeHeTWUNo/X6f5lIw83cUvoxgEIRqeOJ/S1N1aeqQM+k2lS
 aQdXfkVqAaw52y+hlAYbq2YULJV/SSUVpiJlek38jwSVMC5P6Ry/TUY8d
 jBJIIzrLxe3VQ38TDPnEipoJ3/wuU3gzRCPOEYSiAruXCzKXnD5xte8Fi
 JESXvM+aU1BdOCecEPqP7T/kgtIXRKh35p356KWyJCHfYmMq1k8MDIVIE
 dqbOFjm65A9TDJg0qWRpI84qAX2S6niIVWHOBDeED/t9U8pIc488mo7W9 w==;
X-CSE-ConnectionGUID: r5b5bn7KQfKfva8iXgfT0w==
X-CSE-MsgGUID: SOQcNG/nSW69E7YwTkDDPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86785501"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="86785501"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 07:24:00 -0700
X-CSE-ConnectionGUID: rMW07u6xTtWIsezyGEDwGw==
X-CSE-MsgGUID: 9Vxtl9klSsed+vly8+Lnqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="261357608"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 19 Aug 2026 07:24:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/2] I40E refactors
Date: Wed, 19 Aug 2026 15:23:55 +0100
Message-ID: <cover.1787149329.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

A small amount of refactor in hash engine to prepare for future
code. Specifically, disentangling the mutable filter list metadata
from immutable RSS configuration supplied from rte_flow API, and
getting rid of embedded rte_flow RSS conf struct and replacing it
with direct values embedded in config struct.

Anatoly Burakov (2):
  net/i40e: do not use flow RSS conf struct
  net/i40e: move mutable fields out of RSS config

 drivers/net/intel/i40e/i40e_ethdev.h |  18 +++-
 drivers/net/intel/i40e/i40e_flow.c   |  11 ++-
 drivers/net/intel/i40e/i40e_hash.c   | 125 +++++++++++++--------------
 drivers/net/intel/i40e/i40e_hash.h   |   1 -
 4 files changed, 81 insertions(+), 74 deletions(-)

-- 
2.52.0

