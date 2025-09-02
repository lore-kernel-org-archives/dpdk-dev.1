Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB64CA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:27:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A0840647;
	Tue,  2 Sep 2025 19:27:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B9F594042C
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834042; x=1788370042;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DE7ojjokBAqrnpl5sOOOjT1bXKuGCFuEPbfV8m8Xk1E=;
 b=OwE6bf36AvvkOAdaHu/dASNYrvKT5Hs5FhBb2KrXsboaGkzbmzO4CyuR
 0Y1Z7qob9DSZHAVBqFsjFWxZuqVm5RDhGhZdyUApxQ6NaBnujifGwLR6m
 ho9qsnnXdUmSt+iyn9J92XOXNz55j5vBR4jNtPYE7984772x2QgmgqTqc
 sp5lxOY+HDp6eGsc2NQNpz58uYmm10HrzC1ejCX2QHxeq8/nKxzuOE3RO
 IP254m0Ms7jsYzqTV9Oof8yst4YKdRCRn6Y6BaKn+nLriKZLbDvUbCKg8
 b7jrs1V87+NRLPujd8mEaj0wl8ZuCtKHtifPYvF/Iu3y1PHiXle0g6Ugg w==;
X-CSE-ConnectionGUID: 5uJTI50PTviDQxYHRRQNOA==
X-CSE-MsgGUID: g4LXQM14RCyw3nKFIYkUTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69731921"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69731921"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:11 -0700
X-CSE-ConnectionGUID: 1mIYRYSZTYqZuPHgpOYNhw==
X-CSE-MsgGUID: FvBBSPHhT+WqyKBAVIpRCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229099"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:11 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v1 00/12] net/ice: update to latest version
Date: Tue,  2 Sep 2025 18:26:50 +0100
Message-ID: <cover.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

This patch adds an assortment of fixes and updates for net/ice driver,
bringing it up to date with latest shared code.

This patchset includes fixes submitted by Shaiq Wani [1], with a small change of
dropping a direction lookup flag as it's not necessary.

[1] https://patches.dpdk.org/project/dpdk/cover/20250731044132.110174-1-shaiq.wani@intel.com/

Anatoly Burakov (2):
  net/ice/base: add E835 device ID's
  net/ice: update README

Jacob Keller (2):
  net/ice/base: fix memory leak in HW profile handling
  net/ice/base: improve global config lock behavior

Jaroslaw Ilgiewicz (1):
  net/ice/base: add 40G speed

Marcin Szycik (1):
  net/ice/base: add direction metadata

Pandi Kumar Maharajan (2):
  net/ice/base: fix memory leak in recipe handling
  net/ice/base: allow overriding recipe ID

Przemek Kitszel (1):
  net/ice/base: clean up RSS LUT selection

Shaiq Wani (2):
  net/ice/base: fix adding special words
  net/ice: count drop-all filter stats in Rx stats

Stefan Wegrzyn (1):
  net/ice/base: add missing health status defines

 drivers/net/intel/ice/base/README             |   4 +-
 drivers/net/intel/ice/base/ice_adminq_cmd.h   |  21 ++-
 drivers/net/intel/ice/base/ice_common.c       | 133 ++++++++++--------
 drivers/net/intel/ice/base/ice_ddp.c          |  34 +++--
 drivers/net/intel/ice/base/ice_devids.h       |  18 +++
 drivers/net/intel/ice/base/ice_flow.c         |   4 -
 .../net/intel/ice/base/ice_protocol_type.h    |   1 +
 drivers/net/intel/ice/base/ice_switch.c       |  38 ++++-
 drivers/net/intel/ice/base/ice_switch.h       |   4 +
 drivers/net/intel/ice/ice_ethdev.c            |  12 +-
 10 files changed, 184 insertions(+), 85 deletions(-)

-- 
2.47.3

