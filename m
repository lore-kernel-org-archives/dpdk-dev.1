Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC00FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AEA640696;
	Thu, 30 Apr 2026 13:14:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4F49B4066C
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547695; x=1809083695;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mul5TBIOBzf87Ph8NRvKksRWMVICCFe9wElEsVnH/pI=;
 b=RYOdBRMxhnYG/zoXMuuU7+l4KhO7K7AxbdtUHR4rsUi/VJBg/04nK4Hv
 Y0n6ANAorUBmtXyYpiYSEZ7ZHVeHrjs1Cv83Tz7o/sqoZCxL9xE5VPM4D
 Q2qtdvsUpb6fq+e4rsMZOWohfVwqXbQdMZZx1gh8vqqbpaYKUB+QekIlI
 8MeRAEzoXRY5iVlNHV2kX/38qotWsTn3m8D5ZVgadE4K/AewFQNMnGj1L
 MN6kR71sQJUAZ+sUDoPzjE6DvrCFCRz+kvPWblCWkChpyB8StHNhftuy3
 bIVNUFKRdjUyTtJDeaEzYY5kz87erU75mQ8W4TEItlp9ulaJc4xooCJhF Q==;
X-CSE-ConnectionGUID: kBezKrfZQhGPHBbzaFuQgw==
X-CSE-MsgGUID: P+TazfuGQP2Lmne8GgUgPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482266"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482266"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:14:55 -0700
X-CSE-ConnectionGUID: MkCfeItOStiK+uH2j9UW1w==
X-CSE-MsgGUID: hhTS1b7mSlyQ9yCy+KUzlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444706"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:14:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v1 03/15] net/ixgbe: fix non-shared data in IPsec session
Date: Thu, 30 Apr 2026 12:14:32 +0100
Message-ID: <60ae27a2babb44f7a0301109728aaa2742254734.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
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

Currently, ixgbe IPsec session private data stores an ethdev pointer.
That pointer is process local, but the session private data is shared,
so a secondary process can read an invalid pointer value.

Fix this by storing ethdev data pointer in session private data instead,
and using it for session/device binding checks and dev_private lookups
when adding SAs.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 10 +++++-----
 drivers/net/intel/ixgbe/ixgbe_ipsec.h |  3 ++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index fe9a96c54d..88225bccc0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -88,10 +88,10 @@ ixgbe_crypto_clear_ipsec_tables(struct rte_eth_dev *dev)
 static int
 ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 {
-	struct rte_eth_dev *dev = ic_session->dev;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_dev_data *dev_data = ic_session->dev_data;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
 	struct ixgbe_ipsec *priv = IXGBE_DEV_PRIVATE_TO_IPSEC(
-			dev->data->dev_private);
+			dev_data->dev_private);
 	uint32_t reg_val;
 	int sa_index = -1;
 
@@ -405,7 +405,7 @@ ixgbe_crypto_create_session(void *device,
 	memcpy(&ic_session->salt,
 	       &aead_xform->key.data[aead_xform->key.length], 4);
 	ic_session->spi = conf->ipsec.spi;
-	ic_session->dev = eth_dev;
+	ic_session->dev_data = eth_dev->data;
 
 	if (ic_session->op == IXGBE_OP_AUTHENTICATED_ENCRYPTION) {
 		if (ixgbe_crypto_add_sa(ic_session)) {
@@ -430,7 +430,7 @@ ixgbe_crypto_remove_session(void *device,
 	struct rte_eth_dev *eth_dev = device;
 	struct ixgbe_crypto_session *ic_session = SECURITY_GET_SESS_PRIV(session);
 
-	if (eth_dev != ic_session->dev) {
+	if (eth_dev->data != ic_session->dev_data) {
 		PMD_DRV_LOG(ERR, "Session not bound to this device");
 		return -ENODEV;
 	}
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/intel/ixgbe/ixgbe_ipsec.h
index e7c7186264..356817c61b 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.h
@@ -5,6 +5,7 @@
 #ifndef IXGBE_IPSEC_H_
 #define IXGBE_IPSEC_H_
 
+#include <ethdev_driver.h>
 #include <rte_security.h>
 #include <rte_security_driver.h>
 
@@ -72,7 +73,7 @@ struct __rte_cache_aligned ixgbe_crypto_session {
 	uint32_t spi;
 	struct ipaddr src_ip;
 	struct ipaddr dst_ip;
-	struct rte_eth_dev *dev;
+	struct rte_eth_dev_data *dev_data;
 };
 
 struct ixgbe_crypto_rx_ip_table {
-- 
2.47.3

