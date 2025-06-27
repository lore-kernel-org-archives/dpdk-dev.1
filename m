Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2DC7EE33
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 09:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CF304026D;
	Fri, 27 Jun 2025 11:04:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 227C14025D;
 Fri, 27 Jun 2025 11:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751015063; x=1782551063;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=W4Ru//F6hIVDrYv9PW6U19/ITtgNKpyBzfLaWBHEFZM=;
 b=TyHIftrVVpHvs+j0jkXYJMb/py18AXFrxIJwI7LpPQBHXlYsZ8TUL+SZ
 zDxwXdoXWxDZr/A4nlyDsytBBLrwx3L2zqKk3FNkqtteEmlA3LV8mLtKJ
 XM8zm9SyhRX/uNnKLvh4/9QfjcxoFQf2sGup8QUEqcTunfai6PtJaAmUN
 l7zFf+MqcjOzUp2M3iOK08Br1E2YJ2HgKyi1ct7iG64Ab5hIuw4MPqmtD
 ZPcZqDTJdHO5BsCdgIptmKecm5SPw2PjCR0EDodKM24qMNaw1h0KWOk6n
 1CEUpWl4QpQwIHoTTAvcHRODyp16lbPvWtzU9dfvhEqInIp9jdeXuJU+S w==;
X-CSE-ConnectionGUID: twBdL+PRTcC2rzUj89zvZw==
X-CSE-MsgGUID: 9bSXsKlGQtqhA5XARdHq2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53449389"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="53449389"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 02:04:21 -0700
X-CSE-ConnectionGUID: wotGXjacS3StEHtvGDUlPw==
X-CSE-MsgGUID: S0kqjVZ3RAq8JxGy5AzBPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="189948602"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.210])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 02:04:19 -0700
From: Yuan Wang <yuanx.wang@intel.com>
To: anatoly.burakov@intel.com,
	vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	Yuan Wang <yuanx.wang@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ixgbe: fix sctp mask in flow director
Date: Fri, 27 Jun 2025 16:59:53 +0800
Message-ID: <20250627085953.286939-1-yuanx.wang@intel.com>
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

Since the default value of the port mask is set to 0, the port mask does
not change in some cases when creating SCTP flow rules, which results in
incorrect L4P register configuration.

This patch fixes this issue by setting the mask to 0xffff in these cases.

Fixes: c81daae2383a (net/ixgbe: fix port mask default value in filter)
Cc: stable@dpdk.org

Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6278646720..9f2e470ad9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2161,6 +2161,8 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 					item, "Not supported by fdir filter");
 				return -rte_errno;
 			}
+			rule->mask.src_port_mask = 0xffff;
+			rule->mask.dst_port_mask = 0xffff;
 		}
 
 		item = next_no_fuzzy_pattern(pattern, item);
-- 
2.47.1

