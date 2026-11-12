Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB9606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:07:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAAAF40E15;
	Thu, 12 Nov 2026 16:07:21 +0100 (CET)
Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
 by mails.dpdk.org (Postfix) with ESMTPS id 052CF40682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:07:19 +0100 (CET)
Received: (qmail 15824 invoked from network); 12 Nov 2026 15:07:19 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
 by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted);
 12 Nov 2026 15:07:19 -0000
Date: Thu, 12 Nov 2026 16:07:18 +0100
From: Marcel Telka <marcel@telka.sk>
To: dev@dpdk.org
Subject: [PATCH] net/ice: fix trailing bytes drop in get_module_eeprom()
Message-ID: <avXWJrAYifpAF9nJ@telcontar>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received: (qmail 15615 invoked from network); 12 Nov 2026 15:04:36 -0000
Received: from il-bld.in.telka.sk (HELO il-bld.localdomain)
 (il-bld@10.0.0.17) by tortuga.telka.sk with ESMTPSA
 (DHE-RSA-AES256-GCM-SHA384 encrypted); 12 Nov 2026 15:04:36 -0000
Received: by il-bld.localdomain (Postfix, from userid 5001) id D6FA76164B;
 Thu, 12 Nov 2026 16:04:35 +0100 (CET)
X-Mailer: git-send-email 2.56.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When info->length is not an exact multiple of SFF_READ_BLOCK_SIZE (8),
the final loop iteration reads the correct 8 bytes from the module into
value[], but the guard evaluates false, so the memcpy is skipped
entirely. Since the destination buffer is memset to 0 at function entry,
the trailing length % 8 bytes are silently returned as zero instead of
the real EEPROM content, with no error indication to the caller.

Bugzilla ID: 2091

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 drivers/net/intel/ice/ice_ethdev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 457c955b2e..3de9840e7c 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6750,6 +6750,8 @@ ice_get_module_eeprom(struct rte_eth_dev *dev,
 		 * SFP modules only ever use page 0.
 		 */
 		if (page == 0 || !(data[0x2] & 0x4)) {
+			uint32_t copy_len;
+
 			/* If i2c bus is busy due to slow page change or
 			 * link management access, call can fail.
 			 * This is normal. So we retry this a few times.
@@ -6777,9 +6779,12 @@ ice_get_module_eeprom(struct rte_eth_dev *dev,
 				break;
 			}
 
-			/* Make sure we have enough room for the new block */
-			if ((i + SFF_READ_BLOCK_SIZE) <= info->length)
-				memcpy(data + i, value, SFF_READ_BLOCK_SIZE);
+			/* Clamp the copy to the bytes actually requested: the final
+			 * block is shorter than SFF_READ_BLOCK_SIZE whenever
+			 * info->length is not a multiple of it.
+			 */
+			copy_len = RTE_MIN((uint32_t)SFF_READ_BLOCK_SIZE, info->length - i);
+			memcpy(data + i, value, copy_len);
 		}
 	}
 
