Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861BC021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 050F540E4C;
	Sun, 16 Feb 2025 18:01:35 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id CF4FB40E32
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:28 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-221050f3f00so20580025ad.2
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725288;
 x=1740330088; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryB8gYuMivydFfpfOBP5OdqnuMeQySFS+zV15pplPDA=;
 b=uwh4UIIkCbPey1hXaBZTJCiM0QPSO1nCcSTcpPuNdm21iD8tMcYcb7xtfsGkHhqvmC
 FTT9m3msBCr+1OzGfyl3WKFuqMm07HiAZULXwJ5HZyB7bG6xfv4Mudi8bX4bdzZHqEn/
 0hlQl4JR44mPRQG5Y8BbYswRo3CqhLaao4fKpJ7Huq/xdB4mDAEIWL3Xoa1QQUBFBA1u
 PcMBbMVb14xTWO2CwEnYpVgR1rTxS7MD1Sk6G3//R3EetwAf4UUCFC6qEHGAo6CSDyAH
 S3T3SGGNDJNfY85qC3fmd1Zygx1GfMMPNJ/CUEMi+oo3y+eSYicixnCFOWH4qAsudQV3
 dzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725288; x=1740330088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ryB8gYuMivydFfpfOBP5OdqnuMeQySFS+zV15pplPDA=;
 b=Sv94ecJFoNGW0zTKMtaN2fjoQ7EB4nNKtF/mIGMY5kEKY2etk5CKRmFY4Ie5uBSSDk
 Zip8H3asJ6p7EqLy++tbCscWJaKnfFVJeVy/JQqka4U1Px8bTW0ctXuK2cFAOY47kUpB
 DaKttSIgavsXa8dOHC4huVKfjgo9mss3z1jSz5YIhljzwumNdLiJXSigE8fTRrgxJ5yO
 PFMQcUDgvrUFrdyqaYPrLXaWQ/oAFqvluVGHoz/V7shyLz7JjkCVab+FO3VIdKC233L1
 L7eU5UkdD3tYUY4tJ85yytizl+tNQ1xilm1vic5Q9jzXJLe+wvUpGRZQjhxCauS42MEW
 s0Ew==
X-Gm-Message-State: AOJu0YxkA7Qvb+294vYjJ21oB0Hib/V5VoNgdTQK1q1lcjSwKbw1idW+
 XYhxaOA/XfAZgjZEzo4fu0PE11kbMGPPnXpX8RRmce0IJkvZwZJsY9JAsL4GNWBCP9qZ2zMe2ri
 9
X-Gm-Gg: ASbGncuR22ji44evNbTBe3TyTe3Ssg2gjAgZ8xDzZXkS2J2Z+fSmu830aiC6RjZWZF9
 fAS32uwZTLfnAxAak68SJZxYNGXfSdQUkssoCgRXIDL+LcPoG+XvNlhTwoaJ/FwIQvgar472hpi
 8sUqn2RzjegcQU+X3d2xlfDq/Zl+O29ebj8HfyduT901cpnGLT2HrUq3gp89UhyuR9yLnfIr4pS
 L8RgRNEyxcsgUluD2JZuU/ggbb99CocGpND6tLZKdaZZS7dmzjdTL2VbHJfA5If44ilpTKskDWD
 oKcpr9Qx9fKiyb8Jh1Ar3Lt94LkG9fRY5RPFt1ZoUSywRlbvh8V8Ld2GcUoiqdpcMPDG
X-Google-Smtp-Source: AGHT+IFrjRUm5IchU9gdsL1mS/DXkzDZPKUTRRhzRNtEByLdKF46PT9RKh9OHLxs0OQW9EJRL94Y2Q==
X-Received: by 2002:a17:902:e5d0:b0:220:c94b:83a7 with SMTP id
 d9443c01a7336-2210405cc72mr89036115ad.29.1739725288001; 
 Sun, 16 Feb 2025 09:01:28 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v8 09/17] crypto/qat: force zero of keys
Date: Sun, 16 Feb 2025 08:53:08 -0800
Message-ID: <20250216170110.7230-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

