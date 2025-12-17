Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BDAD65C5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 15:03:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BB1740275;
	Wed, 17 Dec 2025 16:03:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E7EB44026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 16:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765983793; x=1797519793;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GyYrQjM9JgU7AOYhqR/SYofQBSq+aI4n+8+i0TZ9yok=;
 b=dGrDQ+TV0nT480eA+P02AbwB2BkMLNw2O/u00qZag6sAzHQtxW1+Sm+P
 dvB5JKrzCLaE4JorGN3Ww3ilP8BzS72liz/vS5QcswsXwgLmopvJnzrpz
 wyX97q4YbE2k0NNaBATb4a82lYVH6sXv6HoP1x14+6f3U8oWwEa4l45Pz
 6vVjaoKgGlApI0YNaIuTRjoOmtiYEtdKTCPAwD54N6JGVZb+TCO10iYWH
 IS8xGRmhJ5463Q+wous6Dg/6QxmD4v9qmAjBpWKLYvcs0l5qxYPgEgXor
 fvB4a0KW2dwZ9eYY0l5MJR7tZXVwzqSE6LjAps0YnylJKvhHV855wEM0D w==;
X-CSE-ConnectionGUID: V+2fE5EZR664/usIVB6nrg==
X-CSE-MsgGUID: Rwif3xmjTtyeBygttkNlzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67811377"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="67811377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 07:03:11 -0800
X-CSE-ConnectionGUID: Dnl/zIRUSYmIrb7faZLNjA==
X-CSE-MsgGUID: 6I0M8JdQTG6DWgOpxTomww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="198212936"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa006.fm.intel.com with ESMTP; 17 Dec 2025 07:03:10 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/1] net/i40e: unset vector flag when scalar path is chosen
Date: Wed, 17 Dec 2025 14:54:35 +0000
Message-ID: <20251217145436.3217068-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

The tx_vec_allowed flag should be set to false if a scalar Tx path is
chosen.

If possible this commit can be squashed into the commit it fixes on the next-net-intel tree.
If the SSE removal series [1] is merged before this patch is applied, this patch does not require
any changes.

[1] https://patches.dpdk.org/project/dpdk/cover/20251217143223.3208830-1-ciara.loftus@intel.com/

Ciara Loftus (1):
  net/i40e: unset vector flag when scalar path is chosen

 drivers/net/intel/i40e/i40e_rxtx.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.0

