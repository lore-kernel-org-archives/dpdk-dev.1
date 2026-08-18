Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D56C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:20:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E791240698;
	Tue, 18 Aug 2026 15:19:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id C9C5840671
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787059182; x=1818595182;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UaXIieC6flcqiYqHOHlnuqP6vGZ+Fw5oSwNAgbMXyMg=;
 b=amGUp2aAwpsjUEYpw9JESY0hvhBoL4vxM3DhRqG9zw5Raej+vbdyw6ty
 SX/9uZjSW8Py1upseCoHbClDR/g09vYpCkewv+yAX37JSmw0Q9wjPfumT
 Lp6OaO5wGyRGBSDnC89pjrLvv00Emi9olrJ3lO4x9Rh6SPSprfPZc5tso
 JuV3L5e5pw7uWrG6o48xSIuDwM0hndetXvbBlqVxddU1a3Lsf1fwfp1ih
 4bp8N/QpF5qeXWRTO/sE5OnEoQFIWl6cTEAA650fM9y//5gLAh7k59wdY
 +C3XfIG/fHFwRobqIIJNnmldeatPP3utNVYZT8P1Youq9zzgWbYO+hDet w==;
X-CSE-ConnectionGUID: obbg7ao1SASvz/+Q+odTRw==
X-CSE-MsgGUID: C4Q2xAluTVST++KdfyR51w==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86669427"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="86669427"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:19:41 -0700
X-CSE-ConnectionGUID: H1jlX0H8QgK7llhZ0eUV2A==
X-CSE-MsgGUID: NnsqRmU0TjWHnpAB6Q4sIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="261015716"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:19:40 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 4/6] net/ixgbe: get rid of unnecessary malloc in IPsec
Date: Tue, 18 Aug 2026 14:19:30 +0100
Message-ID: <9ce87f49c55d1b9ad94f46e32306c12a0191caf6.1787059138.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787059137.git.anatoly.burakov@intel.com>
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
compile time and is pretty tiny.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index 41fc7551ff..1d001b955b 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -94,10 +94,12 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 			dev_data->dev_private);
 	uint32_t reg_val;
 	int sa_index = -1;
+	uint8_t key[16] = {0};
+
+	memcpy(key, ic_session->key, ic_session->key_len);
 
 	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
 		int i, ip_index = -1;
-		uint8_t *key;
 
 		/* Find a match in the IP table*/
 		for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++) {
@@ -191,13 +193,6 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 				priv->rx_sa_tbl[sa_index].ip_index);
 		IXGBE_WAIT_RWRITE;
 
-		/* write Key table entry*/
-		key = malloc(ic_session->key_len);
-		if (!key)
-			return -ENOMEM;
-
-		memcpy(key, ic_session->key, ic_session->key_len);
-
 		reg_val = IPSRXIDX_RX_EN | IPSRXIDX_WRITE |
 				IPSRXIDX_TABLE_KEY | (sa_index << 3);
 		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(0),
@@ -214,10 +209,7 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 				priv->rx_sa_tbl[sa_index].mode);
 		IXGBE_WAIT_RWRITE;
 
-		free(key);
-
 	} else { /* sess->dir == RTE_CRYPTO_OUTBOUND */
-		uint8_t *key;
 		int i;
 
 		/* Find a free entry in the SA table*/
@@ -238,12 +230,6 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 		priv->tx_sa_tbl[i].used = 1;
 		ic_session->sa_index = sa_index;
 
-		key = malloc(ic_session->key_len);
-		if (!key)
-			return -ENOMEM;
-
-		memcpy(key, ic_session->key, ic_session->key_len);
-
 		/* write Key table entry*/
 		reg_val = IPSRXIDX_RX_EN | IPSRXIDX_WRITE | (sa_index << 3);
 		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(0),
@@ -257,8 +243,6 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 		IXGBE_WRITE_REG(hw, IXGBE_IPSTXSALT,
 				rte_cpu_to_be_32(ic_session->salt));
 		IXGBE_WAIT_TWRITE;
-
-		free(key);
 	}
 
 	return 0;
-- 
2.52.0

