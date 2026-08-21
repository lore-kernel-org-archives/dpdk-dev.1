Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E77C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9F3640B8C;
	Fri, 21 Aug 2026 21:29:02 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id E93FF406A2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:01 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84e0688b7e8so973506b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340541;
 x=1787945341; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vTknedP8rELR0QS7EhMrAI5m1jHv9hvnYFvdLDgu0Rg=;
 b=z2JwoFmm5ehV3g7p6CdEEnAImQTjfsQg7Tmaf5iMsZXh/9Kflz8DqyZSvSw0nF9Nv8
 uL0PgayZxMB3TpRaUY1dwqOG8H1fH5+hbqxwCyKQyxn2JKq3c5rzseEO3Pqi/sY/ifvJ
 i3GlMP2I2KVHoZhsIbmKc2vhxGQ0tfVr2m4I85rrNxIKP9YSV8APMzEzOXJCFcbOVJbo
 lix6zm43Os5a1kEhu1afcDq7ZZl6Efpskjtp3VRz14a2PxFlLFoo5uaofkAT0DkgohIu
 3tFm1lbkXQ/NPYtaSP+oxezfCORz7SRm44hSR2VizPptaakJMgEKdVqxr0Sy1UfuS5y6
 E/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340541; x=1787945341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vTknedP8rELR0QS7EhMrAI5m1jHv9hvnYFvdLDgu0Rg=;
 b=j2+zMyW41f54yvNmtqvZnwTdziZyMxVBWVr/vcsPp6GQAdWtEpBfU3GATtIBKIRj7U
 +ltpMf58+8aBciE5sDpQoUzgqINAmZBw+YyzHqxu7X668lxdV6HNrkf1MszfybARImXS
 x29Luadq/aL1oBFUu2BbR9j7CxI9rNvmfUNERkEL9eoM9kKRxTMNlDEfRT9Ab8C4mal6
 CPlVb6/7kI/zqG5PXnOa2WKETPW67OjbolQkW8KdugW3hR5sGV59zEda91tNdBxqqKvv
 4vEUoMpLqbL10yJRnUD6Nd3+aar5b1l5Xz9gjcw3rjMT0rFQz5yyFrip9NF5f8N7LRKD
 vAeg==
X-Gm-Message-State: AFuF++llVegddXiqdwrQIoHimttqHQMBGx2g6jPB9gsNAty0+uCzgA6o
 xtKZ+65rBFYvvar4YIhwXdeb0eZCZ55F6LbdCtnJay2NiRMTJ9+SuZ2FmO8IKHUE8zpBJ4uqVCc
 5VcoI
X-Gm-Gg: AR+sD10edU/XludCH/RzUm0MgEDhCmgke0Ch3AHfeVTKKt9hA6mfcex1Btr7y4uCGLr
 E4JG7thbX67/9BaejOMLQpTPeEWLEm+Ag0UJ4GY5df+D9+colMMsXI28sYvL5qDQoTrIygs0gas
 UzWPMb8PpIP+PaPbYIxuPsDd25pDa7KJS43NLiz31+IXEIapUltrHkDK+IA7AYK/Y0gu7+IXr4x
 pPG4wOoxeKNd4iSvqSC8DQAGe5njPTK9eAmOFyPPIhvcvBztGvr7eBf59pddTmQrURD4XRCTvk6
 Si7zFcRDZT9BVln64w9lNlhdqcUr/aDQ4Vc1JL5W3yDoWSwEPhkPTiSlGWhoFP47dRlC+7/NN84
 Gl5ijqlhLB3MCPAIecuTLjZmeXdNyOyIjDy2tfscZnPSoJlg7FzrRt+vwWoDrzE9OY5YylyPb5I
 QBbOYv3/hkrNcA+Yn90CssSdQVoAjry3dzLj0yKHPFqCyCqVX0arG9TI3pKVWFA+OR9GCPWPPVz
 iIMWyZKJsnJx+0+ud5XrOPlakA=
X-Received: by 2002:a05:6a00:3d16:b0:851:bf92:34c9 with SMTP id
 d2e1a72fcca58-8520ba23821mr1283998b3a.9.1787340541097; 
 Fri, 21 Aug 2026 12:29:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH v2 18/68] pdcp: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:13 -0700
Message-ID: <20260821192646.146382-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

