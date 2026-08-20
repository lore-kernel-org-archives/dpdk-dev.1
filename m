Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA753C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D36C40A7D;
	Thu, 20 Aug 2026 07:23:47 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 686D040A71
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:46 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so1529636a91.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203425;
 x=1787808225; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vTknedP8rELR0QS7EhMrAI5m1jHv9hvnYFvdLDgu0Rg=;
 b=EtwLYiY9hhsSHdH74OETzRpGsmCwrAgnCBZ5/WxS7n5chVulrtxshGfxa2ad9K5A2Q
 P0aNvLW4DOI8WtkUadwdlWlQxmbLxsY6Af6fOPQpqgNcJjGwkVSzITXKMpF1dF8lUXv3
 oDG5sOnxmyIqX4zbfDl6n7ee5wSjvNNBr23mrxgrP+UjOU1HLuPKy9lpc6aDQqMsaB5h
 Igs6XG8hmvGrM7fNveBfFzoKuXOo4Ngx7QLqSi2lkEpzkrSCpWfistyiWNFkBNuz/qZj
 Bi2FrS/2pZFw6xXHlScmeBaTjr39g2/SCOm3lFVxmoxoy57jsd0PVTKDlNf4sMlUVSQ4
 TGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203425; x=1787808225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vTknedP8rELR0QS7EhMrAI5m1jHv9hvnYFvdLDgu0Rg=;
 b=c6wU2xJRii6d9L/WslGEBsERxR7KvIgu9f/w2+g9C56cvAXkQbOx4pgAwOJgA6L8Lg
 KydoaTLo0uIiWhmpURT3jBMqRQ4ZNMjXMubEyo84/s5O51JTmAZwd92zaZgcI224ukMm
 ze4hMtWLBl/zR9vimTtwR2HReIuUbcAGCAGxLcJito4zZyTD17TVg6vCe0w8eq7gXRJh
 0SkKzito1kL6OSdL5Ib3j/0WnW7NckObFgFnbxv6ceSf6/e2ppb1j0NdY52XGXvvLlmQ
 0MrUukks9JQuiHCSjvRu48EPLg+gQKu3NEowWBHN2roP7RiScjvoHVHfpnccZw3xQEiM
 XEHA==
X-Gm-Message-State: AFuF++mTxiEMBv+oqrkYTjr9pglh70Ze+7NlG0I3T+dcssyK42yWwUau
 laBFVayQ0SRtgXuc8QrKt8W/OgNUdcUuc2zk5/ruIFyoJMzR3UsHzSMuSHf7W+32sahmYN/xRoj
 iCORM
X-Gm-Gg: AR+sD11yeV4U53JuWviUH9fNQs6g/5/sb6hyKOBzqE7VwL+Cd6vYVLOiE0P6iLYsjRp
 cwAhd5mSNad3F9Zn8vBhmBQyx5tunFG50wy0+Tj+1lVLOucMUR8KBeVGB7sWH3Wz4P+YGOJU4/C
 u1Vs/5edLrcM0v+aaJW1v2wRdrRBCeZYkuhMOrxFYiL0eeiBems3KQfOV98yi5BER0ENfQPLpeV
 9PvFRrsZCp/SN9ngxoOvjrJQKnG6TkTh4sVuMG++uP1DRCT/j99r1Y23qQY2Q15ZRZmfYyzGqHJ
 8IAItITX+pNFBF6+Q2I3sgDckI7lXdq/hDiiWXZ4NoEbR8h6SyW2VJnIIPFV3aNB8kRS7lyUJNq
 /iZfct27FcosjMCr0X05ouIyqsrQsD6n30t60WpKz6wZJnnzkEn+b5laIddAtqb8rZwPLkCl+hl
 VqZjJoX6nhMnLaKXs5p9C4+UGrhLWUSl/mvKm4lku893l5ONolnNjF7nhOd0BKFvy+bIyVHSuIG
 5R+1+qKfcqC5BXYq1LyrbKcOmQ=
X-Received: by 2002:a17:90b:180e:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-39580a8010amr17839647a91.8.1787203425372; 
 Wed, 19 Aug 2026 22:23:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH 11/61] pdcp: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:01 -0700
Message-ID: <20260820052251.1453273-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't use rte_memcpy because compiler has more bounds checking
with regular memcpy.

Also, use include-what-you-use to fill in some of the include
files that were inherited.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdcp/pdcp_process.c | 51 +++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/lib/pdcp/pdcp_process.c b/lib/pdcp/pdcp_process.c
index f55ae3bec0..12af0be5ee 100644
--- a/lib/pdcp/pdcp_process.c
+++ b/lib/pdcp/pdcp_process.c
@@ -2,13 +2,20 @@
  * Copyright(C) 2023 Marvell.
  */
 
+#include <errno.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include <rte_common.h>
 #include <rte_crypto.h>
 #include <rte_crypto_sym.h>
 #include <rte_cryptodev.h>
-#include <rte_memcpy.h>
+#include <rte_mempool.h>
+#include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_pdcp.h>
 #include <rte_pdcp_hdr.h>
+#include <rte_security.h>
 
 #include "pdcp_cnt.h"
 #include "pdcp_crypto.h"
@@ -60,7 +67,7 @@ pdcp_iv_gen_null_aes_cmac(struct rte_crypto_op *cop, const struct entity_priv *e
 
 	m = en_priv->auth_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
 
-	rte_memcpy(m_ptr, &m, 8);
+	memcpy(m_ptr, &m, 8);
 }
 
 static void
@@ -72,10 +79,10 @@ pdcp_iv_gen_null_zs(struct rte_crypto_op *cop, const struct entity_priv *en_priv
 	iv = rte_crypto_op_ctod_offset(cop, uint8_t *, PDCP_IV_OFFSET);
 
 	iv_u64[0] = en_priv->auth_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
-	rte_memcpy(iv, &iv_u64[0], 8);
+	memcpy(iv, &iv_u64[0], 8);
 
 	iv_u64[1] = iv_u64[0] ^ en_priv->auth_iv_part.u64[1];
-	rte_memcpy(iv + 8, &iv_u64[1], 8);
+	memcpy(iv + 8, &iv_u64[1], 8);
 }
 
 static void
@@ -89,7 +96,7 @@ pdcp_iv_gen_aes_ctr_null(struct rte_crypto_op *cop, const struct entity_priv *en
 
 	iv_u64[0] = en_priv->cipher_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
 	iv_u64[1] = 0;
-	rte_memcpy(iv, iv_u64, 16);
+	memcpy(iv, iv_u64, 16);
 }
 
 static void
@@ -101,8 +108,8 @@ pdcp_iv_gen_zs_null(struct rte_crypto_op *cop, const struct entity_priv *en_priv
 	iv = rte_crypto_op_ctod_offset(cop, uint8_t *, PDCP_IV_OFFSET);
 
 	iv_u64 = en_priv->cipher_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
-	rte_memcpy(iv, &iv_u64, 8);
-	rte_memcpy(iv + 8, &iv_u64, 8);
+	memcpy(iv, &iv_u64, 8);
+	memcpy(iv + 8, &iv_u64, 8);
 }
 
 static void
@@ -115,17 +122,17 @@ pdcp_iv_gen_zs_zs(struct rte_crypto_op *cop, const struct entity_priv *en_priv,
 
 	/* Generating cipher IV */
 	iv_u64[0] = en_priv->cipher_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
-	rte_memcpy(iv, &iv_u64[0], 8);
-	rte_memcpy(iv + 8, &iv_u64[0], 8);
+	memcpy(iv, &iv_u64[0], 8);
+	memcpy(iv + 8, &iv_u64[0], 8);
 
 	iv += PDCP_IV_LEN;
 
 	/* Generating auth IV */
 	iv_u64[0] = en_priv->auth_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
-	rte_memcpy(iv, &iv_u64[0], 8);
+	memcpy(iv, &iv_u64[0], 8);
 
 	iv_u64[1] = iv_u64[0] ^ en_priv->auth_iv_part.u64[1];
-	rte_memcpy(iv + 8, &iv_u64[1], 8);
+	memcpy(iv + 8, &iv_u64[1], 8);
 }
 
 static void
@@ -140,12 +147,12 @@ pdcp_iv_gen_zs_aes_cmac(struct rte_crypto_op *cop, const struct entity_priv *en_
 
 	iv = rte_crypto_op_ctod_offset(cop, uint8_t *, PDCP_IV_OFFSET);
 	iv_u64[0] = en_priv->cipher_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
-	rte_memcpy(iv, &iv_u64[0], 8);
-	rte_memcpy(iv + 8, &iv_u64[0], 8);
+	memcpy(iv, &iv_u64[0], 8);
+	memcpy(iv + 8, &iv_u64[0], 8);
 
 	m_ptr = (uint8_t *)rte_pktmbuf_prepend(mb, 8);
 	m = en_priv->auth_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
-	rte_memcpy(m_ptr, &m, 8);
+	memcpy(m_ptr, &m, 8);
 }
 
 static void
@@ -162,11 +169,11 @@ pdcp_iv_gen_aes_ctr_aes_cmac(struct rte_crypto_op *cop, const struct entity_priv
 
 	iv_u64[0] = en_priv->cipher_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
 	iv_u64[1] = 0;
-	rte_memcpy(iv, iv_u64, PDCP_IV_LEN);
+	memcpy(iv, iv_u64, PDCP_IV_LEN);
 
 	m_ptr = (uint8_t *)rte_pktmbuf_prepend(mb, 8);
 	m = en_priv->auth_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
-	rte_memcpy(m_ptr, &m, 8);
+	memcpy(m_ptr, &m, 8);
 }
 
 static void
@@ -179,15 +186,15 @@ pdcp_iv_gen_aes_ctr_zs(struct rte_crypto_op *cop, const struct entity_priv *en_p
 
 	iv_u64[0] = en_priv->cipher_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
 	iv_u64[1] = 0;
-	rte_memcpy(iv, iv_u64, PDCP_IV_LEN);
+	memcpy(iv, iv_u64, PDCP_IV_LEN);
 
 	iv += PDCP_IV_LEN;
 
 	iv_u64[0] = en_priv->auth_iv_part.u64[0] | ((uint64_t)(rte_cpu_to_be_32(count)));
-	rte_memcpy(iv, &iv_u64[0], 8);
+	memcpy(iv, &iv_u64[0], 8);
 
 	iv_u64[1] = iv_u64[0] ^ en_priv->auth_iv_part.u64[1];
-	rte_memcpy(iv + 8, &iv_u64[1], 8);
+	memcpy(iv + 8, &iv_u64[1], 8);
 }
 
 static int
@@ -614,7 +621,7 @@ pdcp_post_process_ul(const struct rte_pdcp_entity *entity,
 	}
 
 	if (unlikely(nb_err != 0))
-		rte_memcpy(&out_mb[nb_success], err_mb, nb_err * sizeof(struct rte_mbuf *));
+		memcpy(&out_mb[nb_success], err_mb, nb_err * sizeof(struct rte_mbuf *));
 
 	*nb_err_ret = nb_err;
 	return nb_success;
@@ -968,7 +975,7 @@ pdcp_post_process_uplane_dl_flags(const struct rte_pdcp_entity *entity, struct r
 	}
 
 	if (unlikely(nb_err != 0))
-		rte_memcpy(&out_mb[nb_success], err_mb, nb_err * sizeof(struct rte_mbuf *));
+		memcpy(&out_mb[nb_success], err_mb, nb_err * sizeof(struct rte_mbuf *));
 
 	*nb_err_ret = nb_err;
 	return nb_success;
@@ -1024,7 +1031,7 @@ pdcp_post_process_cplane_sn_12_dl(const struct rte_pdcp_entity *entity,
 	}
 
 	if (unlikely(nb_err != 0))
-		rte_memcpy(&out_mb[nb_success], err_mb, nb_err * sizeof(struct rte_mbuf *));
+		memcpy(&out_mb[nb_success], err_mb, nb_err * sizeof(struct rte_mbuf *));
 
 	*nb_err_ret = nb_err;
 	return nb_success;
-- 
2.53.0

