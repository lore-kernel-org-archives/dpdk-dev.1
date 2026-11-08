Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D1606A31C
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HndfB8jd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD56E40264;
	Sun,  8 Nov 2026 12:00:58 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 83E1E4003C
 for <dev@dpdk.org>; Sun,  8 Nov 2026 12:00:56 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36f6295304dso30929eec.1
 for <dev@dpdk.org>; Sun, 08 Nov 2026 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794135655; x=1794740455; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2/tSN5/1o9FmiG6qKPS8SdHAyL0/9ru+qYVWu7wxkoM=;
 b=HndfB8jdQmGedmpF88YvofldLQptOXvxWhChlv5/GaEHJbbZzoM9JY3HVY2l7wB/W0
 4QeslYZSZmwMYidns+fDu2DiA47JSeOjm7MQC5RVfmdj4dmWgWrYOBCv0x53P4AETK1I
 teNX0mDhG9QhkrPXBtUP1PgEQgqI2VYUFD7KFlpG9dU77q1eum8I9SkwxQsEo3BX/Myh
 LlpBWvLQhjqH8+WxRHD80roGkK0f3SLacIT1yeptjdYg3eldsXd7NLwr8WKG8gUVFdnq
 BIpVcB8AbnetngdlO5QbdhHlXpe8O3jD+NibAY21Bx1cWAYcMC7dnkQMLeR7XT/Dcy2T
 568g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794135655; x=1794740455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2/tSN5/1o9FmiG6qKPS8SdHAyL0/9ru+qYVWu7wxkoM=;
 b=RgaOngz+0wZb6jZkK3Rwtd4PFe9JDkTNQmizRJKvEZFA5FI/75d3nKPcFoYYhOg7JW
 ZsSU3A37b1Ol2hDCncs0AQaT2HuW+5oVuyYZ1kI+dtRm25okXu+8nZwm5uBtEobf55Fi
 NecdTfat+tdvlSw7Etqqvjn2UKxCzsdA/vHYTKvFSQtBLJD+AapyBFZS9/0UDau/NTlA
 GKaTPqIaCDazdySJVzZQzapfPH4d1fpUL+bhflqbTfvM/uLZ5LrWTkl5+urZqONGdVos
 Y3X4powduoHUt7bVp21FTKfqmaq5DtMsgG3wkAdwBLSVLLRbhCN+/6R0P9S8E/BYyfD8
 UrXQ==
X-Gm-Message-State: APuU4Z/pxoou+GnVzV34tqrPS0iQK6BVWkMDF+pcLim2v4lCprZLxr8m
 rbyQqNJl+MfTqwlhZuYDNdyS+T1T5mJ+jlagXOTAS/mc2FqiNN46PD5RIa0fNA==
X-Gm-Gg: AYBFou1m446Euo16jbnYwZkdjX5t0447gpwpDJOjk2V1GdMiem/Ga/dvqurH9wjTNEn
 zrfQ0xQMBcKT5TTtBgEH5g4jRmbIfMYLEhr60JYiO/mVKqfq4VHfCuBoao5a7JU3KG+buMUw1aA
 ODquSjapZd1zOpw622E9ulm3hoHcINvueynxBry98PBWsS+SHthj2ZRcFGG4YBKCqfPcBmUc56V
 hs5oPwINrTaKOuiKIKyxwDyEMZas9RxiWyDKz7j240HOdmhEvx86UT739+tbi0124KYHTZEY2p2
 jZ9/fzgzbVp7o8z95RICmkgtptfSkI1OPdFEjvLbOT1p2r6/fmCBqDObPuasPax0xdU16OScL/F
 +Wxh+O0EprzTtRfHuMXgBsxfk7OoZdOIWDF4bB5nwyk4nZ4nAwFV324yhzVGcG7RIF6qMcksQoC
 x0JoMKdP5YSvxRM/PPouOMwadIYl9FijzZELfzp8xJEKmsjkKgRAcoSD+1z39sKxqe4EZLWIPC0
 /yvgQTgtmwaTkaWm7RjPYVIMVYJLAHaahqAvFexEkeKSmzDDKxeVoRAa28eZVQ/c38zt0hJT63p
 Ma0qaj0lZp12hphDeR7XgT8RfSkv3Q==
X-Received: by 2002:a05:7300:3e8a:b0:36f:5861:69a2 with SMTP id
 5a478bee46e88-372544b01d9mr3191054eec.3.1794135654655; 
 Sun, 08 Nov 2026 03:00:54 -0800 (PST)
Received: from gentoo ([49.204.145.8]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372632d95e0sm4382805eec.2.2026.11.08.03.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 03:00:52 -0800 (PST)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Jasvinder Singh <jasvinder.singh@intel.com>
Cc: dev@dpdk.org
Subject: [PATCH] test: add CRC length and alignment sweep
Date: Sun,  8 Nov 2026 16:30:48 +0530
Message-ID: <20261108110048.1314351-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a length sweep test to compare SIMD CRC implementations against the
scalar reference implementation for CRC16-CCITT and CRC32-ETH.

Exercise input lengths from 0 to 512 bytes with starting offsets from
0 to 7 bytes to cover different alignment conditions and vector
processing boundaries.

Also accumulate the return value of the CRC16-CCITT Test 4 so that
failures from this test are correctly propagated to the autotest result.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 app/test/test_crc.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/app/test/test_crc.c b/app/test/test_crc.c
index 11645d323d..460a50ccda 100644
--- a/app/test/test_crc.c
+++ b/app/test/test_crc.c
@@ -8,6 +8,7 @@
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_net_crc.h>
+#include <rte_random.h>
 
 #define CRC_VEC_LEN        32
 #define CRC32_VEC_LEN1     1512
@@ -101,6 +102,46 @@ crc_all_algs(const char *desc, enum rte_net_crc_type type,
 	return ret;
 }
 
+static int
+crc_length_sweep(void)
+{
+	static const enum rte_net_crc_alg algs[] = {
+		RTE_NET_CRC_SSE42, RTE_NET_CRC_AVX512, RTE_NET_CRC_NEON,
+	};
+	static const enum rte_net_crc_type types[] = {
+		RTE_NET_CRC16_CCITT, RTE_NET_CRC32_ETH,
+	};
+	uint8_t buf[512 + 8];
+	unsigned int i, a, t, off, len;
+
+	for (i = 0; i < sizeof(buf); i++)
+		buf[i] = rte_rand();
+
+	for (t = 0; t < RTE_DIM(types); t++) {
+		struct rte_net_crc *ref =
+			rte_net_crc_set_alg(RTE_NET_CRC_SCALAR, types[t]);
+
+		for (a = 0; a < RTE_DIM(algs); a++) {
+			struct rte_net_crc *ctx =
+				rte_net_crc_set_alg(algs[a], types[t]);
+
+			for (off = 0; off < 8; off++)
+				for (len = 0; len <= 512; len++)
+					if (rte_net_crc_calc(ctx, buf + off, len) !=
+							rte_net_crc_calc(ref, buf + off, len)) {
+						printf("alg %u type %u off %u len %u\n",
+								algs[a], types[t], off, len);
+						rte_net_crc_free(ctx);
+						rte_net_crc_free(ref);
+						return TEST_FAILED;
+					}
+			rte_net_crc_free(ctx);
+		}
+		rte_net_crc_free(ref);
+	}
+	return TEST_SUCCESS;
+}
+
 static int
 crc_autotest(void)
 {	uint8_t *test_data;
@@ -128,7 +169,7 @@ crc_autotest(void)
 		CRC32_VEC_LEN2, crc32_vec2_res);
 
 	/* 16-bit CCITT CRC:  Test 4 */
-	crc_all_algs("16-bit CCITT CRC:  Test 4", RTE_NET_CRC16_CCITT, crc_vec,
+	ret |= crc_all_algs("16-bit CCITT CRC:  Test 4", RTE_NET_CRC16_CCITT, crc_vec,
 		sizeof(crc_vec), crc16_vec_res);
 
 	/* 16-bit CCITT CRC:  Test 5 */
@@ -145,6 +186,7 @@ crc_autotest(void)
 		rte_memcpy(&test_data[i], crc16_vec1, 12);
 	ret |= crc_all_algs("16-bit CCITT CRC: Test 7", RTE_NET_CRC16_CCITT, test_data,
 		CRC16_VEC_LEN3, crc16_vec3_res);
+	ret |= crc_length_sweep();
 	return ret;
 }
 
-- 
2.56.0

