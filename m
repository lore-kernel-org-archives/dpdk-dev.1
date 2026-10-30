Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CD606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nztTdIaf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65DBF40299;
	Fri, 30 Oct 2026 11:02:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id B94A440285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 11:02:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793354528; x=1824890528;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XGDCRAHKn12Vu1RYlGQAzSlCnHorwPi81EnFxeyocJw=;
 b=nztTdIafzM7v8gz3tmXl4lpZ1UD+6tdONSlwmNIBl49UmUlp0gcZSOvo
 i/3uYHf8l2MjNcMCH0spj9UL3YzRYIUOqhrfz+R16uZ9jLRKP2gwgOgp9
 Luxe+SMg87Q5086rfOFJy7lDd2Qx2YjiNrvglllKDUHwnRGYAqYY/CqmE
 EX2xiqqv0QlbBfMHTC18Iv/Leab0aW4mFLhwYME5oseDi7LNXMWMQNMsA
 xpGjYFAmYoFyR4OnArBuzs52/y7RGiON/HgwETxV45W/4XAXLidc/hJyM
 jSzAePkvY2JsgSKolH37I/phXyyjZtnU6nbQb+Ln+4Queignp1L+Qxm63 A==;
X-CSE-ConnectionGUID: 7DldNX1GSzyPJUcOU3RChA==
X-CSE-MsgGUID: VfXCEyYOTF2JM9B0mOcEVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1992158"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1992158"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 03:02:06 -0700
X-CSE-ConnectionGUID: QYRlD4DlTLe8N6cTbMsgEA==
X-CSE-MsgGUID: cq4pn9yVRruuXUhfFca1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5479450"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 30 Oct 2026 03:02:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/1] net/ixgbe: fix EEPROM read callback check
Date: Fri, 30 Oct 2026 10:02:00 +0000
Message-ID: <1877a0177de01bc832f96c8fe99f05fea7370bf1.1793354493.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

The NULL check added for the E610 EEPROM write path was placed in the
EEPROM read handler, so a missing write callback rejects reads while the
write handler still dereferences it. Check the read callback in the read
handler and move the write callback check to the write handler.

Fixes: 04c3e44b4aee ("net/ixgbe: fix null dereference on EEPROM write for E610")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 46db8c49d09..9b43619bb79 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -7016,7 +7016,7 @@ ixgbe_get_eeprom(struct rte_eth_dev *dev,
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return -E_RTE_SECONDARY;
 
-	if (eeprom->ops.write_buffer == NULL)
+	if (eeprom->ops.read_buffer == NULL)
 		return -ENOTSUP;
 
 	first = in_eeprom->offset >> 1;
@@ -7047,6 +7047,9 @@ ixgbe_set_eeprom(struct rte_eth_dev *dev,
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return -E_RTE_SECONDARY;
 
+	if (eeprom->ops.write_buffer == NULL)
+		return -ENOTSUP;
+
 	first = in_eeprom->offset >> 1;
 	length = in_eeprom->length >> 1;
 	if ((first > hw->eeprom.word_size) ||
-- 
2.52.0

