Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33A5C5DF6D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 849EA4067C;
	Wed, 19 Aug 2026 14:33:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 820A740655
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142780; x=1818678780;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=57mTH/PPAeQl+FN8B3hwMrLs+qWTdRmTrlvC2PgVBlQ=;
 b=QgxD+hzN3gIY9/c42nriRDCiNIM2zL7UON/Phyf7AaoqtFIRFbfrhODK
 5nZbHfDkmyuzdySytmYJTPPLHagazW5iFOn1o+9uPo9kwBR47sMqBUrs4
 9gUNTV/sOOwLV3jQaKeItjcQzUB4k+XoDMBc/2FY36ctitmUZzr88pTkT
 TW9SjrayoxfAVDHpPCLKH2fW0YhdgZ8+Y0S5lgN0zVYzcjD5KbOeCJ4l1
 IQV2hi3A4FEegVRCZHtxUMccW5VVa0zXxcOfCr4pSybPpB5E6WoFr9AQQ
 O71mwwjxQat0K23VpF0YwmQsjCeK7zCcUz+K9NhKVJ91Y45nlg9dHg7Y3 Q==;
X-CSE-ConnectionGUID: pJrUA8PfSQWx/ER3CCBRaw==
X-CSE-MsgGUID: 9VRVt1hkQhSOW16LR5/4BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87775532"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87775532"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:33:00 -0700
X-CSE-ConnectionGUID: NxtsL0mVQmGDCy+OOwn/kw==
X-CSE-MsgGUID: uEkvDgIqS9uaFWyZYAqUyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269382555"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 19 Aug 2026 05:32:59 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 4/7] net/ixgbe: get rid of unnecessary malloc in IPsec
Date: Wed, 19 Aug 2026 13:32:36 +0100
Message-ID: <83bc81814bf0df2994744b2bf0c1008c0e1c0964.1787142684.git.anatoly.burakov@intel.com>
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

Currently, when writing SA key to HW, a temporary buffer is allocated, to
which the key is written. The allocation does not have to happen on the
heap, so change the allocation to be on the stack, as key size is known at
compile time and is pretty tiny. Also, zero it out explicitly after use.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index 41fc7551ff..9c4937fcba 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -94,10 +94,10 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 			dev_data->dev_private);
 	uint32_t reg_val;
 	int sa_index = -1;
+	uint8_t key[16] = {0};
 
 	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
 		int i, ip_index = -1;
-		uint8_t *key;
 
 		/* Find a match in the IP table*/
 		for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++) {
@@ -191,11 +191,6 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 				priv->rx_sa_tbl[sa_index].ip_index);
 		IXGBE_WAIT_RWRITE;
 
-		/* write Key table entry*/
-		key = malloc(ic_session->key_len);
-		if (!key)
-			return -ENOMEM;
-
 		memcpy(key, ic_session->key, ic_session->key_len);
 
 		reg_val = IPSRXIDX_RX_EN | IPSRXIDX_WRITE |
@@ -214,10 +209,9 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 				priv->rx_sa_tbl[sa_index].mode);
 		IXGBE_WAIT_RWRITE;
 
-		free(key);
+		rte_memzero_explicit(key, sizeof(key));
 
 	} else { /* sess->dir == RTE_CRYPTO_OUTBOUND */
-		uint8_t *key;
 		int i;
 
 		/* Find a free entry in the SA table*/
@@ -238,10 +232,6 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 		priv->tx_sa_tbl[i].used = 1;
 		ic_session->sa_index = sa_index;
 
-		key = malloc(ic_session->key_len);
-		if (!key)
-			return -ENOMEM;
-
 		memcpy(key, ic_session->key, ic_session->key_len);
 
 		/* write Key table entry*/
@@ -258,7 +248,7 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 				rte_cpu_to_be_32(ic_session->salt));
 		IXGBE_WAIT_TWRITE;
 
-		free(key);
+		rte_memzero_explicit(key, sizeof(key));
 	}
 
 	return 0;
-- 
2.52.0

