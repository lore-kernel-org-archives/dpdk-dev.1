Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA4EC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:19:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAA474060F;
	Tue, 18 Aug 2026 15:19:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id AECAA40269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787059179; x=1818595179;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Wv5Ywv9rxXXjsASlW2PNS6KLuERsJhZ0i1ShhJjNsbI=;
 b=SdUiqFA+dSl8o8WZMHqEvunap1m4/E+Bu87trpWuuWw/Zqa7AeYiAQrq
 xaNzSepSc561md1gMk06pec2PmRl2jOg2aEqFjKOIyBhchRQnTni+WKdS
 ZDmB3auCpm1oFc9T1axw6HUubTpq35TIzDZEUsfkGb0wvIYQUmIcAkWzv
 Ubflpk3LRy6mymV1mhH8MRKjZEC13XFSa9y+WSxUbbhp45T8SsTQVCqe1
 TgcL5uDfLLPhfAxojqg+4rv8lRrROwe4j4xJeaSeAlbT/S83+FzxwilXy
 3AjLt1N4tEcmlZoS+QlFx0WcqfbgY9FfvUQrHAaJ279jQ7yezMCE9TL1d g==;
X-CSE-ConnectionGUID: QzKbqlZYQ/SLErTucRs7QA==
X-CSE-MsgGUID: 3wRlabinRFysuwGClJ9Kcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86669414"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="86669414"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:19:38 -0700
X-CSE-ConnectionGUID: nga1aZd4Q5KWJYY3O/uB8g==
X-CSE-MsgGUID: D97zjMJmT9WSjzaJbamyrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="261015681"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:19:37 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/6] net/ixgbe: add key length check in IPsec
Date: Tue, 18 Aug 2026 14:19:27 +0100
Message-ID: <48a36c08be9e2e5ef8a955847da67ee9e76fda1b.1787059138.git.anatoly.burakov@intel.com>
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

The cryptodev API does not check for user parameters being within the
bounds of what the driver supports. Currently, the only key size supported
by ixgbe is 16 bytes, so that is what we will check for. Add the check.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index bdd34344e8..aaf657af5f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -384,6 +384,12 @@ ixgbe_crypto_create_session(void *device,
 	}
 	aead_xform = &conf->crypto_xform->aead;
 
+	/* Only 16-byte keys are supported. */
+	if (aead_xform->key.length != 16) {
+		PMD_DRV_LOG(ERR, "Unsupported key length %u", aead_xform->key.length);
+		return -ENOTSUP;
+	}
+
 	if (conf->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS) {
 		if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
 			ic_session->op = IXGBE_OP_AUTHENTICATED_DECRYPTION;
-- 
2.52.0

