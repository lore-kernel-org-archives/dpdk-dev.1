Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D11FCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 15:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 519C0402F1;
	Fri, 31 Oct 2025 16:23:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 59009402F1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 16:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761924190; x=1793460190;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Aojth9ymN60Xgxaew633CEoLgQ/m+eqgIvWXdGr1skc=;
 b=Cd7k5NKGEFIopwl/vZcnvS7CticJcfpHlqLKHC2w06ButwTZJNhey7O9
 eJxUeM2WysIkeQce6qCpZSl8KruD68khEb9+JlKeVrFMg7nMySEhUcFio
 jPibUa5nSsugc4c/YUhbamiiaNbWSHP5vdWmSv5ffCwH/gO19t/FflK65
 9PsozZiKz4LSXSx+VJBR02WvE/Smw21UwHcjVmR9z44IH/XRLrMpGU8yU
 fM84+rHDXqjuKFHXuCuRJ3vbMtG9CLEq3sJQlxkxEi2/EszE+wr3xdo6S
 8RQPHzj2i2a1trvOKDGK+CZ0/Fd6fuWSvkNluOVFP0VshWY7Jwh4SW5tt g==;
X-CSE-ConnectionGUID: Ksd2nuy1SuKPxYVOKE4z3w==
X-CSE-MsgGUID: UUbiF9jmTDeJcAWwxbbGUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63106779"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; d="scan'208";a="63106779"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2025 08:23:09 -0700
X-CSE-ConnectionGUID: lAlqeaXhRsODURV8tq5vYw==
X-CSE-MsgGUID: hm+zphvVTuKy7WNQ0vFGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; d="scan'208";a="190607053"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa004.jf.intel.com with ESMTP; 31 Oct 2025 08:23:08 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/2] Fixes for iavf VLAN insertion offload
Date: Fri, 31 Oct 2025 15:22:48 +0000
Message-Id: <20251031152250.2441980-1-ciara.loftus@intel.com>
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

The first patch fixes double VLAN offload in the AVX-512 path.
The second fixes single VLAN insertion offload across all paths.

Ciara Loftus (2):
  net/iavf: fix AVX-512 double VLAN (QinQ) insertion
  net/iavf: fix single VLAN insertion positioning

 drivers/net/intel/iavf/iavf_rxtx.c            | 50 +++++---------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 68 ++++++++++---------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 15 ++--
 3 files changed, 60 insertions(+), 73 deletions(-)

-- 
2.34.1

