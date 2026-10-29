Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680460A2601
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ak9f8I5t
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AB454067D;
	Thu, 29 Oct 2026 17:41:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 215EE400D6
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:41:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793292088; x=1824828088;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4wTZqpspjMQ54f9O8vAK1pP55GQbMrxu8MA1v/kNBFo=;
 b=Ak9f8I5tmXWSBWFrgUKZyv/NQ+4AtDie2mxH89XiETQfhRL969cj23RA
 mfK0Yc9Gwp+7WDlKlgFZJmIllfKPJrUBmrRAPMNL0KAwB1BXbE1qhscD4
 P6N8qpkZ5Yt6iGyMBWB3nRnROu4+HwyhZjQszvZSDoecO+gwHWgCvdj9x
 xur1HGlUaMmCZX9IZz1dg6XvlTNVbioMQJYP4rs7XgcImREWk4I586mh3
 aRUFFZZ7sfpqVBV153Hqomy088f31vgpNBK00qMqUyzbX1L69j+H9dZdz
 zziP49lq7mFhhRWcyOpjzoOAJH6JWaahOWKGUtbNqgf9oJaJwA2W3kaaY g==;
X-CSE-ConnectionGUID: a75vslLcRFyGKlP8OLfZwQ==
X-CSE-MsgGUID: nPf93vsGSLWNiL/mabDJow==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1954956"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1954956"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 09:41:04 -0700
X-CSE-ConnectionGUID: d/qp7uxTSmmO2ySWN6Hf9A==
X-CSE-MsgGUID: cy3KeK33S3mK12Ymx3C16A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5280322"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 29 Oct 2026 09:41:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 4/4] net/ixgbe: fix FDIR tunnel inner MAC mask validation
Date: Thu, 29 Oct 2026 16:40:58 +0000
Message-ID: <4a4576d671da4ec92f376a5ed7230fbf021f190c.1793292050.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <9c545ac681db1bd835a88516322c1441951e3ed6.1793292050.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Flow director masks the inner destination MAC address per byte, but the
parser only accepts masks that cover either the whole address or none
of it.

Accept masks where each byte is either fully masked or unmasked.

Fixes: ea0f9067b2cf ("net/ixgbe: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
index 0a7e96a030d..5e9f8593e51 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
@@ -845,6 +845,7 @@ ixgbe_validate_fdir_tunnel_inner_eth(const void *ctx __rte_unused,
 				     struct rte_flow_error *error)
 {
 	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
+	uint8_t i;
 
 	if (eth_mask->hdr.ether_type != 0) {
 		return rte_flow_error_set(error, EINVAL,
@@ -859,11 +860,13 @@ ixgbe_validate_fdir_tunnel_inner_eth(const void *ctx __rte_unused,
 				"Masking not supported for src MAC address");
 	}
 
-	/* dst addr must be either fully masked or fully unmasked */
-	if (!CI_FIELD_IS_ZERO_OR_MASKED(&eth_mask->hdr.dst_addr)) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM, item,
-				"Partial masks not supported for dst MAC address");
+	/* Each destination MAC byte must be fully masked or fully unmasked. */
+	for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
+		if (!CI_FIELD_IS_ZERO_OR_MASKED(&eth_mask->hdr.dst_addr.addr_bytes[i])) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Partial dst MAC byte masks not supported");
+		}
 	}
 
 	return 0;
-- 
2.52.0

