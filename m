Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36C0C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 07:45:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B61F8400D6;
	Fri, 18 Apr 2025 09:45:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F332C400D5;
 Fri, 18 Apr 2025 09:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744962305; x=1776498305;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lUzHfu8Jlw8wgDAVrQykCpBKA0K69ZuVQlC/MEw4ksg=;
 b=OZwRQ5LZRgQ1nAvs7xD3OUso1TQoTqn+DVIqlCMZHmr1NXw0QTowJNSX
 Iw3cEAb71Nge9K1LjVoM5oZI43z4IGPB1QkCKgOGsIp7Zqu19Ibonp/mW
 ++7YLGkzmRMvHIBB9eS1K/Xqg6nMj9D0H0NVcT+kZKwydtb3QJ2oaqSqc
 NnbYXbi9ZVRnLOX8L5TORQ6NjSoInltCO22MSd5bvwMr27rL+vAi3VHAw
 RIuP3BVkgYukNi1FoWR7N1qukEmNinAs7XXMiwf3LJQqy0DnE5SOe5rjr
 5iTlphMhbMS7VcqR08C76oDmvsBlU1uqnFIGHgOHA8vDM323N42FKopGx Q==;
X-CSE-ConnectionGUID: f2KltSX4TTmT8Nik5Rh7EQ==
X-CSE-MsgGUID: exXlIf15RTOmvpiOwdj/xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="71974818"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="71974818"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 00:45:03 -0700
X-CSE-ConnectionGUID: RZMGX52xR6GPiHaKPPX9PA==
X-CSE-MsgGUID: LUY8M8IUTYigl3/13Z7R3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="132033378"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.210])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 00:45:00 -0700
From: Yuan Wang <yuanx.wang@intel.com>
To: anatoly.burakov@intel.com,
	vladimir.medvedkin@intel.com,
	dev@dpdk.org
Cc: Yuan Wang <yuanx.wang@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ixgbe: fix port mask default value in flow director
Date: Fri, 18 Apr 2025 15:43:09 +0800
Message-ID: <20250418074309.705337-1-yuanx.wang@intel.com>
X-Mailer: git-send-email 2.47.1
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

The fdir filter should mask L4 protocol in order to process raw IP packets.
However, the initial value of port mask is 0xFF and the filter will not
process raw IP packets if the flow rule does not change it.

Fixed by setting the default value to 0.

Fixes: 444505f933f1 (net/ixgbe: fix IPv6 mask in flow director)
Cc: stable@dpdk.org

Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 33da2f47ec..1e3804bb15 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1644,6 +1644,8 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
 	rule->mask.vlan_tci_mask = 0;
 	rule->mask.flex_bytes_mask = 0;
+	rule->mask.dst_port_mask = 0;
+	rule->mask.src_port_mask = 0;
 
 	/**
 	 * The first not void item should be
-- 
2.47.1

