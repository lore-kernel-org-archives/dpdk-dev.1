Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE975CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE1CF40A6E;
	Tue, 23 Jun 2026 18:52:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 21F6340677;
 Tue, 23 Jun 2026 18:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233533; x=1813769533;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IY2dQqP5arOJQdPB0ZpU3CVIPycEiIaAN46OGTf2w50=;
 b=VmZ98mvsFSl1bXgK8WysSiMQE92krdsTFkVJqhDAv4HzVVR4GpExYZg/
 h3fSMQ0WU+vKr1qWoK2Zb9HauAH6tSGsUxGtSDrZIy91/NwIkpawV+qLc
 N605YVhHH2eaoRkgYHE5jccHbxcd6TGUaexUIkVDNqHK66+dzyKXzz4zZ
 ND0rXRXv9XPGIshmCuQnFO/+tLp6PkSpWkQpMl4g4BCmvi53sOIEbKDE0
 ep9gD4K7u3k3Ij6260F/8rQ1wXCIQyl1ClQXQqjhHrB5P28VJEwYiug/9
 HvkdmDwRQ/tMfEAm0MuK00BWQpfwk4cM/QNKmAeVEKdv+DJxZA11nTCqT Q==;
X-CSE-ConnectionGUID: QuaZCiDNTH6u3moW//roIQ==
X-CSE-MsgGUID: xFpXreJpRumCDwp2ku8KqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534650"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534650"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:12 -0700
X-CSE-ConnectionGUID: KXIuRwyzTTyG1+UwxXu/tQ==
X-CSE-MsgGUID: +KGSTxSfRd+0sH1rj5woWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928335"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rohit Raj <rohit.raj@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 09/17] net/dpaa: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:39 +0100
Message-ID: <20260623165150.765443-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

