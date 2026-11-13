Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB4606A8BC
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 10:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C35414281D;
	Fri, 13 Nov 2026 11:53:20 +0100 (CET)
Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
 by mails.dpdk.org (Postfix) with ESMTPS id C6379427D4
 for <dev@dpdk.org>; Fri, 13 Nov 2026 11:53:19 +0100 (CET)
Received: (qmail 2713 invoked from network); 13 Nov 2026 10:53:19 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
 by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted);
 13 Nov 2026 10:53:19 -0000
Date: Fri, 13 Nov 2026 11:53:18 +0100
From: Marcel Telka <marcel@telka.sk>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v3] net/ice: fix trailing bytes drop in get_module_eeprom()
Message-ID: <avbsHttyFMKKCcmj@telcontar>
References: <avXWJrAYifpAF9nJ@telcontar>
 <avbq3hRC0CYC4f_q@telcontar>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avbq3hRC0CYC4f_q@telcontar>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When info->length is not an exact multiple of SFF_READ_BLOCK_SIZE (8),
the final loop iteration reads the correct 8 bytes from the module into
value[], but the guard evaluates false, so the memcpy is skipped
entirely. Since the destination buffer is memset to 0 at function entry,
the trailing length % 8 bytes are silently returned as zero instead of
the real EEPROM content, with no error indication to the caller.

Bugzilla ID: 2091
Fixes: 52569256583a ("net/ice: support module EEPROM")
Cc: stable@dpdk.org

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
 
