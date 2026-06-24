Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEA3CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01393406B4;
	Wed, 24 Jun 2026 12:37:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id D7F9A40689;
 Wed, 24 Jun 2026 12:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297439; x=1813833439;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IY2dQqP5arOJQdPB0ZpU3CVIPycEiIaAN46OGTf2w50=;
 b=dzw45uS+azkCOinjA50QpPnNkpAxWw1LmsDtVZTYP68+1eKukNr3sPCw
 ukzOu/BIMnUdyfYRG0kUfmy1UY9Gn8G55nbgMXqIwGdUJsoZH+VXOk7Md
 spmsV487HbclkUvaEOXychYrZVxYZR3DHi8FJ3N3JlSdwOuJt/PdoSyBw
 CZdqkx12m36LvnGYvmwNc6j0jOcTiEv1p6r9gOeGgvSqFfDGY8cYHjb/i
 ptVm+jMG4s1n80uXfXNfFuJmd6OUtivMigxeikRqtYGHRUo8YS5h//BWO
 BFU9P59wYqob4mMU6IJ5ofuTWbSUdy/o1x/mmHaqS/oYD2muvYbMIDjET Q==;
X-CSE-ConnectionGUID: sRcKkYWEQCyCPCwT8IYWeQ==
X-CSE-MsgGUID: yX7ra3cjT8+rBfrQEBfR7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652361"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652361"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:19 -0700
X-CSE-ConnectionGUID: b7ZZu3WxR4CJlNK4NjLRLw==
X-CSE-MsgGUID: 5ySX6+VYT+iZYd8U8zaTGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460065"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
Subject: [PATCH v2 09/17] net/dpaa: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:48 +0100
Message-ID: <20260624103658.792750-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: ee0fa7552a0a ("net/dpaa: forbid MTU configuration for shared interface")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 9f976d179b..8b1072f9b9 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -247,7 +247,7 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 			DPAA_PMD_ERR("Cannot open IF socket");
 			return -errno;
 		}
-		strncpy(ifr.ifr_name, dpaa_intf->name, IFNAMSIZ - 1);
+		strlcpy(ifr.ifr_name, dpaa_intf->name, IFNAMSIZ);
 
 		if (ioctl(socket_fd, SIOCGIFMTU, &ifr) < 0) {
 			DPAA_PMD_ERR("Cannot get interface mtu");
-- 
2.53.0

