Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D63C5DF86
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD78C4064C;
	Wed, 19 Aug 2026 14:32:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8ED74402C4
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142777; x=1818678777;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fZSKlSBOKtOql0xO4YUxmtJ6R/T4Ent7ilBwXuHl/Pw=;
 b=bZwrZBOwN+O5wGayGk2AorbdHZmrIsJ17mXJp7fON0FvgqDVmwtIgYRD
 RZH+YHZl31ExbKyiUoF7p8YFAqigS9G1yFft98FaHJ6LkV8gYRA0cQaor
 4JPc4Zo/v/1dBLWOJDOaPFSa9hJY3ctuNRDAgBh/Qf2HEGyAPatGTmJOk
 8ZcswbvJsFZ0dttbnOxVQlAq8XXQEBIh3QRh+erEoBz91rMykGQTPQpB6
 dDyWnvKknTjeTSfR+y2e5scYSyL2ByDi+fRbdmdTR6+B3G0Gmi3Maa+vF
 QIHOAvkNRByM98Oa7bDyZ4fpzft/buUFD9fCxugjKeUWBTtxb32u/t36R Q==;
X-CSE-ConnectionGUID: CPclH/slSB+JlZ3+Te9OOQ==
X-CSE-MsgGUID: 0HdDzC3MToab3vedS5L6iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87775526"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87775526"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:32:56 -0700
X-CSE-ConnectionGUID: l/4sn9OSQymNUUcKDzwnrg==
X-CSE-MsgGUID: ST7hZF45Q9qivZ6R/PR/pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269382539"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 19 Aug 2026 05:32:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 1/7] net/ixgbe: add key length check in IPsec
Date: Wed, 19 Aug 2026 13:32:33 +0100
Message-ID: <27a3ad50c499ecaa88ebf5676a6182b96d88231e.1787142684.git.anatoly.burakov@intel.com>
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

The cryptodev API does not check for user parameters being within the
bounds of what the driver supports. Currently, the only key size supported
by ixgbe is 16 bytes, so that is what we will check for. Add the check.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
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

