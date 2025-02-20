Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87EAC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EDB140653;
	Thu, 20 Feb 2025 17:42:12 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id B804B40395
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:08 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2fc3027c7aeso2410393a91.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069728;
 x=1740674528; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryB8gYuMivydFfpfOBP5OdqnuMeQySFS+zV15pplPDA=;
 b=qP2PzmXIaBMDt+nTIvBU0eU78x77X+j7N6wCuhAr8Gd0VhFlbQVkdQxggT1uDLwUbP
 DUeGirIACogbAwvWu7g6wTc7D6pz/N9jLZuZFcyrX8CgBc+DHsa3M8pUhclPELKFyK2Y
 XEAkJmzwOUwh69NGrnx+gcUdQ3Gkq6rcvZEy+ucSuI3AKYwdX6HMETQOwRmWW6MEHbFO
 Z2d8Cq6ciQbLRnfo+KQRmSbiM4F5lFUast6sh/viYoYTZmxWJ2t5Kp+VRsbRwwu0AuUC
 qGapTb7aD96gloECHdRLo5s+ZGxyQbuYhg2PwFA8r9gM1EquWTYeMD5aXRUZUU/0OWxH
 u01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069728; x=1740674528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ryB8gYuMivydFfpfOBP5OdqnuMeQySFS+zV15pplPDA=;
 b=kn/9ljfTAuwQRNtierpSF1CK8q4VlgaZFPJ6CGmMso5lRRlfz48HTgK96TT/F5FYdb
 6YvJvmliR1FhtltDN6PPn07QdolJNyvCNvvyUx4kD4Z5R2j/98O/z7YBH8+7fQ7mfDW7
 RD65E/LhkkWaIKul8VbKOWgMh7T4MqKDfOc+goR+6ORhkB+A/Jw6N1T5NSY6Z3EdUWj3
 2/Ot1+Jl6OzqPhBmQST/dyS0/s81FMQCHWr7vTgwJV3Euqy8fJVybkhDMQQfqGgMwEeZ
 XyaOx66CUiQoviAvR2liuAcDpzL7wzx2GHaYJvpI0+HcEK35vUlRQZty/xjZh+jYBJmT
 vI8g==
X-Gm-Message-State: AOJu0YzaDWwog+Q+tDXZ11e/teZUvgDzl7iJSSIohtAhBbCRcqt+dg6Y
 HdhhvE+gtidEPk1HTH8H3ySTJHgMezvwBbcxcNus8pkxtNVlp91C9hnELkcIrKWDFoMEABv8PDX
 4
X-Gm-Gg: ASbGncuYO+ziPFb4p/wdbby0uSvni8yJctwReAW0FkHC8XEpKMfO7nphCyEnY5+/j3V
 wtWq8wu+QWyT1dqHCsBnRKBBc+sC7KgAzIzcbWF+/WwzpVezQBfsceASqQZRPJy1QOY4k4r0/cS
 NCI1ggo7RWlalOsbX9yk9J/eyUHNMlc2/GSuWTaKABBZRoE2XY7wFDWcdrKHh1o84LVVUISS0FU
 X1bt3d7mPdepCHVmowoIIkCh8f8yb5ofXP48scpd9NsmY7/TGF39Sw14egpeu3O/WW7usDKQDzI
 Wb6gdj+4L/49zxBUVZTcRHleJG9Uix9DEhY8hlEFgqxpIUK4Y3wV8FIZLAXwtc2qgsHl
X-Google-Smtp-Source: AGHT+IFjqWLM2MUvLzH55rRgsomhjqbjZJ71V42y59DmGrH3G175DDPNMO/uWsP59SFd/X3RXjOOiQ==
X-Received: by 2002:a17:90b:380f:b0:2fa:ba3:5451 with SMTP id
 98e67ed59e1d1-2fc4115089fmr34960820a91.35.1740069727914; 
 Thu, 20 Feb 2025 08:42:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v9 07/15] crypto/qat: force zero of keys
Date: Thu, 20 Feb 2025 08:27:13 -0800
Message-ID: <20250220164151.9606-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

