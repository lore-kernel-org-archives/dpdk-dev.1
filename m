Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E01606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=infotecs.ru header.i=@infotecs.ru header.a=rsa-sha256 header.s=mx header.b=QwwVW4Kj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5542340296;
	Mon, 16 Nov 2026 08:37:27 +0100 (CET)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTPS id B5F4E400EF;
 Mon, 16 Nov 2026 08:37:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 91FCD2C0BAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1794814644; bh=Bk2JQCpoubN9dLG9MafAmQ3FYsifb+TiILvMfhJxbio=;
 h=From:To:CC:Subject:Date:From;
 b=QwwVW4KjE6T+0orguyZwY7qN3PDVyS2LGcfsPTvFfTSQtN1WLT3N/83VzgrGFllTJ
 9PYZoyW6TzAnrbFzR1AYXHqKHEEjzOzFiyn73expoj3c8wPGAm+HV4x3bP4NSnTXUG
 v0s4/vpN0gO5PfG92r0+V6zu8o71KUVisdMBwjhw=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 91FCD2C0BAA;
 Mon, 16 Nov 2026 10:37:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 4DB4D2C0B99
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 4DB4D2C0B99;
 Mon, 16 Nov 2026 10:37:24 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Bruce Richardson <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Evgeny Sokolov
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru> Date: Mon,
 26 Oct 2026 20:39:23 +0300 Subject: [PATCH] net/bnxt: remove
 redundant lines
Date: Mon, 16 Nov 2026 07:37:21 +0000
Message-ID: <20261116073721.236658-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/11/16 06:45:00 #28892229
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the redundant lines

The return value of the _mm256_permutevar8x32_epi32 function
stored in the info3_v varable is overwritten a line below
and can be safely removed.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 80074a56c4..07806f7357 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -570,9 +570,6 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		 * bits and count the number of set bits in order to determine
 		 * the number of valid descriptors.
 		 */
-		const __m256i perm_msk =
-				_mm256_set_epi32(7, 3, 6, 2, 5, 1, 4, 0);
-		info3_v = _mm256_permutevar8x32_epi32(errors_v2, perm_msk);
 		info3_v = _mm256_and_si256(errors_v2, info3_v_mask);
 		info3_v = _mm256_xor_si256(info3_v, valid_target);
 
-- 
2.47.3

