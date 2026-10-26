Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C97606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 14:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 052A1402A3;
	Mon, 26 Oct 2026 15:17:11 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTPS id 0C42740275;
 Mon, 26 Oct 2026 15:17:07 +0100 (CET)
Received: from ar (unknown [42.86.112.99])
 by APP-05 (Coremail) with SMTP id zQCowADHND_UYN9qqkRoDA--.566S2;
 Mon, 26 Oct 2026 22:16:53 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Kai Ji <kai.ji@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>,
	stable@dpdk.org
Subject: [PATCH] crypto/openssl: fix SM2 encryption output length
Date: Mon, 26 Oct 2026 07:16:52 -0700
Message-ID: <20261026141652.2484406-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHND_UYN9qqkRoDA--.566S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWfWw4UXF47ZF4kuFWrAFb_yoWkJFb_ua
 s7CanrX3y7Gw18KF17Cr45ArWfX34kXryqgw1jqr13K3WDZFs0vFySqrnIvr1avrW0qF17
 CwsFqr1rJFs7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
 1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
 cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
 Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUUUU=
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBgcMAmrfXlUHigAAs8
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SM2 encryption passed a zero output length to EVP_PKEY_encrypt(),
which OpenSSL 3.6.3 and later reject as "buffer too small".
Query the required length first, as the RSA path does.

Fixes: 3b7d638fb11f ("crypto/openssl: support asymmetric SM2")
Cc: stable@dpdk.org
Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 drivers/crypto/openssl/rte_openssl_pmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 1b33470c8f..8791186fec 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -2791,6 +2791,10 @@ process_openssl_sm2_op_evp(struct rte_crypto_op *cop,
 			if (!EVP_PKEY_CTX_set_params(cctx, eparams))
 				goto err_sm2;
 
+			if (!EVP_PKEY_encrypt(cctx, NULL, &output_len,
+					op->sm2.message.data, op->sm2.message.length))
+				goto err_sm2;
+
 			if (!EVP_PKEY_encrypt(cctx, op->sm2.cipher.data, &output_len,
 								 op->sm2.message.data,
 								 op->sm2.message.length))
-- 
2.56.0

