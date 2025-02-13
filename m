Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFAC021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7DF540651;
	Thu, 13 Feb 2025 23:18:38 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id C05364060B
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:34 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso1266797a91.3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485114;
 x=1740089914; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryB8gYuMivydFfpfOBP5OdqnuMeQySFS+zV15pplPDA=;
 b=wpla1Sf/4sfbKpPYe3/nuIbgduSDlI+oHcZPljl/QzbqPAOFLdJ1RXslz+CrxTcT8S
 JqMXVvkuHuFQ0xIUvrcWLijJVvMcSYk99RWPtuqcY5Ks5WDqWl6XLkLFBF5baAePX1nr
 UyzRXzzgJdmLqRgDcWaNQ5CEyqAaTIWmredNwJaOzNNYNVCLE7/ZisLzoLxPczeELPCf
 TKQfH/EKFXmVeRGwBCcU43udestpqvl30QeG2esHEG4VviCHSY+qc3MZPE4n5QFkdPEu
 SOBJxyGGJ2AGuRJKNcBdK+PEFSZ0RroA07Nb3msWwTEqRunF5MZ4OWHD1kR+9QFV4bXR
 Be7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485114; x=1740089914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ryB8gYuMivydFfpfOBP5OdqnuMeQySFS+zV15pplPDA=;
 b=PAwwOoeGfJ72krDM+yAiyC9xHjaCDY8DabEa/V2co3+W1FDS7o0jXNgn+gVxS/onoB
 m2FUgi+vkj/AS3wA75dNl/ezhvl1lQIcKbMBJgB8mTrVxLq91vG3V/g+8aKv/1Mc1IZl
 vYFCn1ul32lW5o+0u6Fwqt79jkLcQ/J1eMi7lI8uyjd2Jn/Y/2T0Yn2484UwyBlCqV6b
 YkzUkSp4hyRh5cr0tf148sPW95Q+w+SVbKHC+txVSpUhkG6YyxzfgxyKUr+ur/gS2wI6
 97+bfrPfgHLBjnVwIFnD/zSKIS2hXr6kXjhRRl6HQAAoxnKu1y51Gsaftge6RA05nIil
 C4Gw==
X-Gm-Message-State: AOJu0YxyFJv0R3HVI6NvPq9WeZvGXcNfaguUM9XZf7Z18iOgessJNlOM
 +qnYKRRthGdQMEpUdfZrQ7ArAqzZ88E9dBam15Pj/z1VQZj3zZccgr+IDRpg379j9ShN0DbDwcF
 R
X-Gm-Gg: ASbGncsNU9pCT7hTGVct4AEGzSLX1gOZiaRcEQicpTHuAmKSs1DUle/Flo19Aw8PSdw
 Cm6J666TKi4phJzmMMt1qecPa6Q2ddgSjKsiFlS4BG4IGQYJ1FPA3zUyaDd2m2zNO9grMaIYDlS
 MzHrGmjP+8L1vnBKf6jfSw+tduI11fOVZirb7G9DgBXhKy9q2GkR2PUG/Jg3QnZwUnczmkoggyA
 gFgrnWB/PvDOElm21ZjwTUaLlyIf9ARqW1yfXiOOXqbuWtal3gVYuDjnLHx1SjIRJGU1zDH34Ph
 YlARKwdf+VcBSkW4aU6p/WQf8x2IvxJquh+VmGGemu18JXz1XVI0BrcHMPYpQoySw4dC
X-Google-Smtp-Source: AGHT+IHhId6WTz4O/tMhDTbMDja5NuP6fm6ffDg27uO+JavGH5FRdxWD68kvhF/v64Ygrk15bCYKnQ==
X-Received: by 2002:a17:90b:2d44:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2fbf5baed84mr11729536a91.6.1739485113893; 
 Thu, 13 Feb 2025 14:18:33 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v6 03/11] crypto/qat: force zero of keys
Date: Thu, 13 Feb 2025 14:16:16 -0800
Message-ID: <20250213221819.1856769-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

