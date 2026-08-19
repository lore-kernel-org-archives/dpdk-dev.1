Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2421C5DF6D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ACD540685;
	Wed, 19 Aug 2026 14:33:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 44A1B40655
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142781; x=1818678781;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IRTz8PUgGrQia0hWw03r3OkoN+Qlj9Fpyhtib1Q5kZI=;
 b=Os/7Bo0gDdRWFM8nL1RM+qU6/lUKpgMB7WZIlxE0Eq3sbAHnSgJ28/89
 smHYYFlXmskH3yIlrKh6MV+4AOIPduj+EyTVNffyTcwGRwcyOENKQ7D6t
 52R/Rj5YoULU4T6Sjyxrwnmu0qS39B6ZAuALvfAPq4kRgeGmK+UrDVNyp
 4lYZ53FDuT2MaH0CcQEjdQo76suwDHmgVB8zbBZ2A3qK4FysrsOS6aLkn
 JURnBcRzpkVVQjNNMmyBF2DzXm2tTXYGt0q9VlOINGSpB2nrNI2a3Fcyp
 1GU39I/KXOvC5a+HrvpW6UYPDLzCtPBoMSpH/tutXnZVcYoeIOnmWH066 g==;
X-CSE-ConnectionGUID: 6A0ivHfbR2yIqJfqzSnJrQ==
X-CSE-MsgGUID: iSDeioHwTgeL+q7XKM4cBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87775534"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87775534"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:33:01 -0700
X-CSE-ConnectionGUID: W2Snc5HkSWOU9ncg2uv/tg==
X-CSE-MsgGUID: JVl+hESmQ9uNWaCkYwv/xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269382559"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 19 Aug 2026 05:33:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 5/7] net/ixgbe: use correct index variable in IPsec
Date: Wed, 19 Aug 2026 13:32:37 +0100
Message-ID: <5cf7d8f5cc8470159d7ef69c4c36189d20ea1852.1787142684.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787142684.git.anatoly.burakov@intel.com>
 <cover.1787142684.git.anatoly.burakov@intel.com>
References: 
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

Currently, one of the Tx SA table accesses uses `i` iterator instead of the
`sa_index` variable that was assigned from said iterator. While this is
technically not a bug because `i` and `sa_index` always carry the same
value, it should still be fixed for readability purposes.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index 9c4937fcba..f026a41690 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -229,7 +229,7 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 
 		priv->tx_sa_tbl[sa_index].spi =
 			rte_cpu_to_be_32(ic_session->spi);
-		priv->tx_sa_tbl[i].used = 1;
+		priv->tx_sa_tbl[sa_index].used = 1;
 		ic_session->sa_index = sa_index;
 
 		memcpy(key, ic_session->key, ic_session->key_len);
-- 
2.52.0

