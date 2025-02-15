Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E0C021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C29EE40DCF;
	Sat, 15 Feb 2025 20:06:06 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 12FDB40B9A
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:03 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fc0026eb79so5833686a91.0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646362;
 x=1740251162; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryB8gYuMivydFfpfOBP5OdqnuMeQySFS+zV15pplPDA=;
 b=kFbjMLUmjGUmptISl22/A/6bAu3kVqXImTTj2SqJJSWioQbwHc3S20hIkWy+I2vkm1
 9vEzf35eiowPdVWJ14TmdlbPXbv4W/T1oMcG6jquGEPGac3pXPCd3AYRfONcDUwfupua
 xOaQQ5WACXfh7mRlWv/HHr7Ahp4Nq+YlWXAoASWHm0UFDfcmcP5rH2AijLcXzPMqMYx9
 W6DxpvWuXGnv5G6lPkfI1pLeL3wTXKRGAuHnejIS1vREQcFU8/ece83zr9wckBrqBiYd
 b0IzxSGt4Mxy5T91yE33XOjt/PqT7lBlZ6JbUpAz3ExUi8Wy25zOo8krDjHhYhJfYYyp
 w6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646362; x=1740251162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ryB8gYuMivydFfpfOBP5OdqnuMeQySFS+zV15pplPDA=;
 b=FKPIw6aoiSXNXFQX/DJ31/vLHIN29FvcyE3LJZoN+ldWSerJviSu4VJTFbrGC5aa8l
 fRzyxbW/RHZ6Wqh6HOWa2iAHgo53K8GNgeunUXeZNHDFoyXlxbVRMQz/XMM4RsTydmHk
 HDsPz72xcA4kBaLFcFqfvHMSvqdf94jt1Eps+IAVXhoBgOJdptAw+Hkt5bdhZFxl+2fI
 UCLhrul7NSyZuY1ZgqcCtYM3akQhEUo7uNChmbbTAE3pxTc64DBjhhvb2s67z/etdxr5
 52YA2PZ+5vyTwdg1ytiiEpMO5a7T7NW4fc0yMqNGHLeuLd9kzdTtBrPWTrSXXEARSSRy
 gfDA==
X-Gm-Message-State: AOJu0YwMLmkqi0KlV2OcVIEcoRTHqrHM1fqotZLNd9EuP90XzzU40wrT
 Wg9x13QvD42Nyl2v/u2hkT9vvrxZVq/4cNbBuJWIkwzDeiqm0pXZYwJjnJuQEHSF5X+Gc+PWwkh
 7
X-Gm-Gg: ASbGncsjB4BbST2icpC/SwLr8xmVIwkQQNpMcAx85RZQobRz5iBzOxr10F1Fmbe7UYH
 k/rUGBAuX/X2xAkbs/F2OnQ+bLZkzXSHuG61p3OLXRivVRJ2zo6CwVihbg/xU65lk6ZXBTspfsS
 oKg+AdFhf/F/RVfjZHyA0FlpHJV3i/jvvvGiBhGM2VWn/BbWBJfhWGROXrX+PVkhQk/tEtOX4Ni
 DlejEATkX6va4+BBaPvdgXl/Zhc0w17Y4MICinACHIwWu/mnc0lOE3ozkr68Kyn2JceUf0Fru54
 2NwF5/bU/RVUFZaJKEoypevcHgeAj2REgV/v0rUmsloUk6NjmTI6V3e7Gh8dLFzgRJL8
X-Google-Smtp-Source: AGHT+IE9jLVKGFDRssSXAFKZDlXDT+/9qPqtGbYkae/b4NjGB6ARlwY0Iwo6zM237/G0VQNObcQtLw==
X-Received: by 2002:a05:6a00:1903:b0:730:8ed8:6cd0 with SMTP id
 d2e1a72fcca58-732618c0c91mr7216044b3a.16.1739646362287; 
 Sat, 15 Feb 2025 11:06:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v7 08/16] crypto/qat: force zero of keys
Date: Sat, 15 Feb 2025 11:04:36 -0800
Message-ID: <20250215190544.988310-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

Just doing memset() on keys is not enough, compiler can optimize
it away. Use new rte_memzero_explicit() and rte_free_sensitive().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/qat/qat_sym_session.c | 33 ++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 9b26f8a89b..3564a33484 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -26,6 +26,7 @@
 #include <rte_crypto_sym.h>
 #include <rte_security_driver.h>
 #include <rte_ether.h>
+#include <rte_string_fns.h>
 
 #include "qat_logs.h"
 #include "qat_sym_session.h"
@@ -1621,7 +1622,7 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 
 			if (AES_set_encrypt_key(auth_key, auth_keylen << 3,
 				&enc_key) != 0) {
-				rte_free(in);
+				rte_free_sensitive(in);
 				return -EFAULT;
 			}
 
@@ -1633,9 +1634,9 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 			aes_cmac_key_derive(k0, k1);
 			aes_cmac_key_derive(k1, k2);
 
-			memset(k0, 0, ICP_QAT_HW_AES_128_KEY_SZ);
+			rte_memzero_explicit(k0, ICP_QAT_HW_AES_128_KEY_SZ);
 			*p_state_len = ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ;
-			rte_free(in);
+			rte_free_sensitive(in);
 			goto out;
 		} else {
 			static uint8_t qat_aes_xcbc_key_seed[
@@ -1666,11 +1667,11 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 				if (AES_set_encrypt_key(auth_key,
 							auth_keylen << 3,
 							&enc_key) != 0) {
-					rte_free(in -
-					  (x * ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ));
-					memset(out -
-					   (x * ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ),
-					  0, ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ);
+					rte_free_sensitive(in -
+							   (x * ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ));
+					rte_memzero_explicit(out -
+							     (x * ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ),
+							     ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ);
 					return -EFAULT;
 				}
 				AES_encrypt(in, out, &enc_key);
@@ -1678,7 +1679,7 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 				out += ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ;
 			}
 			*p_state_len = ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ;
-			rte_free(in - x*ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ);
+			rte_free_sensitive(in - x*ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ);
 			goto out;
 		}
 
@@ -1698,7 +1699,7 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 			return -ENOMEM;
 		}
 
-		memset(in, 0, ICP_QAT_HW_GALOIS_H_SZ);
+		rte_memzero_explicit(in, ICP_QAT_HW_GALOIS_H_SZ);
 		if (AES_set_encrypt_key(auth_key, auth_keylen << 3,
 			&enc_key) != 0) {
 			return -EFAULT;
@@ -1707,7 +1708,7 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 		*p_state_len = ICP_QAT_HW_GALOIS_H_SZ +
 				ICP_QAT_HW_GALOIS_LEN_A_SZ +
 				ICP_QAT_HW_GALOIS_E_CTR0_SZ;
-		rte_free(in);
+		rte_free_sensitive(in);
 		return 0;
 	}
 
@@ -1757,8 +1758,8 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 	}
 
 	/*  don't leave data lying around */
-	memset(ipad, 0, block_size);
-	memset(opad, 0, block_size);
+	rte_memzero_explicit(ipad, block_size);
+	rte_memzero_explicit(opad, block_size);
 out:
 	return 0;
 }
@@ -2006,8 +2007,8 @@ static int qat_sym_do_precomputes_ipsec_mb(enum icp_qat_hw_auth_algo hash_alg,
 
 out:
 	/*  don't leave data lying around */
-	memset(ipad, 0, block_size);
-	memset(opad, 0, block_size);
+	rte_memzero_explicit(ipad, block_size);
+	rte_memzero_explicit(opad, block_size);
 	free_mb_mgr(m);
 	return ret;
 }
@@ -3240,7 +3241,7 @@ qat_security_session_destroy(void *dev __rte_unused,
 		if (s->mb_mgr)
 			free_mb_mgr(s->mb_mgr);
 #endif
-		memset(s, 0, qat_sym_session_get_private_size(dev));
+		rte_memzero_explicit(s, qat_sym_session_get_private_size(dev));
 	}
 
 	return 0;
-- 
2.47.2

