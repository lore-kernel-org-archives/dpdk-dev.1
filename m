Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C2BC0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:37:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AE7B40DC9;
	Tue, 11 Feb 2025 18:37:38 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id D2A4C40A77
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:35 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so8959226a91.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295455;
 x=1739900255; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rak0DAZty8x40YM3GMr0xefCf11aYKehi8ijiDm9mi4=;
 b=O6h6kyrGA6jlg9E+YRal2SBxBNwSLcvtUm9auyIA66A5Wa7UKfqb4CxNfVkLYHtAZ3
 h1H8+C/xRCPltVmsy9iaK5/fAhGjMQba3SjCe3eRKFj9RBfjjLkXdJ5eQP884QSXA5uX
 9gMSmYopqwgZsfoIGMZa5YyFFWqJk/CI3rer5C5s93akXfg1LqkKx9yXpQDssS9RGvJ0
 EfDaS9aS+sEYLU1bfltfGBv0gHaB9IOq8dn9BfVYql9Ns2NwkWb58jdPPaDTyl25ln9r
 gnm8rIIgGsAzpc18I/XL5ctp0iJmU8PHRXbBrzLTITlLbMAPOlItGAe8kktgMXByaBp7
 I+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295455; x=1739900255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rak0DAZty8x40YM3GMr0xefCf11aYKehi8ijiDm9mi4=;
 b=pxWrQ5gUfuWarB7MvepEMHBrtUEOfyxaoFIsgRBU1akc3w/BCs5twhZS4xWGtnvYdI
 QZan8iUmITIiBkcYjq9Oy+XQygGSjLHP6lUxy9AmIachVWUXPCK6MjiDYAYxDfmBXFpo
 gHoMuBuLB5Ad/FfmUKtWSuvCUso6wdTmSHJBA4Cne+0qF3s7te3E9+RvKp1prmcEvfiO
 gi1V+yqmxTucrZK/IBOyQs7iavI77GEd4wthWyMtUFtPdWSDntHpf7QjBDuZAUxbIX5D
 jcRUE9XXPU2EvA3vWfo3C428ruADI2UaNkb8T6GnXLvBkUupGw8mOzM3fJafzhrMnR1w
 60jA==
X-Gm-Message-State: AOJu0YwJCfqHPE00ThJuDC+RVBVLhWkkppLzbarthTWtcWU8UbdUCesh
 MjNMQDi6YugFx5hYQbXbxnDjB6mRpmWQuzeIp1t6+U48qkpkOD1dYL+Uo2bRcBd2PgPHAF5R6r0
 /
X-Gm-Gg: ASbGncv4QOUoZYlSYsNCqc6Ahm1jAC/otlZvVrGoywPePUCKjOxBlafvoLSb2Cys3Hx
 UeO6g5YnP/vypqO5OC64Ib9V00hyojfYUnHtawcax7cXNUGflUe9OEvQYcpFZcOZaxz62d8A5es
 xKO0UFttL8PaRjKhIJA9x8e15XSLVorUrQ6JJxnW1q8TI+77+d0LJ262bHz2NaGX9zg9zltPBCf
 OpDvb1ZowqZ/kaALqLq5GyVEKHP+hwEoAWx4KcXSvKA635LaDR+zAliEDGjws9+/ZtFzfMZkBcJ
 Q5Aut38luUa124pUA5uQwzq1AkWwleqwAI+tA9tgMUO42Ayo+lPAJqph3vaTwDKS0e5n
X-Google-Smtp-Source: AGHT+IGT9iK4S4w6DvupyvWd765qWIFJMI7yLOc99G9OFZyWdmpVE71Fe23epA+AMHauTh0FoGYj8g==
X-Received: by 2002:a17:90b:3552:b0:2f6:be57:49cd with SMTP id
 98e67ed59e1d1-2fa242d9f42mr27619089a91.25.1739295455029; 
 Tue, 11 Feb 2025 09:37:35 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v5 03/11] crypto/qat: force zero of keys
Date: Tue, 11 Feb 2025 09:35:23 -0800
Message-ID: <20250211173720.1188517-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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
it away. Need something with a barrier.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/qat/qat_sym_session.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 50d687fd37..2fce8fcb16 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -26,6 +26,7 @@
 #include <rte_crypto_sym.h>
 #include <rte_security_driver.h>
 #include <rte_ether.h>
+#include <rte_string_fns.h>
 
 #include "qat_logs.h"
 #include "qat_sym_session.h"
@@ -1633,7 +1634,7 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 			aes_cmac_key_derive(k0, k1);
 			aes_cmac_key_derive(k1, k2);
 
-			memset(k0, 0, ICP_QAT_HW_AES_128_KEY_SZ);
+			rte_memset_sensitive(k0, 0, ICP_QAT_HW_AES_128_KEY_SZ);
 			*p_state_len = ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ;
 			rte_free(in);
 			goto out;
@@ -1668,7 +1669,7 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 							&enc_key) != 0) {
 					rte_free(in -
 					  (x * ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ));
-					memset(out -
+					rte_memset_sensitive(out -
 					   (x * ICP_QAT_HW_AES_XCBC_MAC_KEY_SZ),
 					  0, ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ);
 					return -EFAULT;
@@ -1698,7 +1699,7 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 			return -ENOMEM;
 		}
 
-		memset(in, 0, ICP_QAT_HW_GALOIS_H_SZ);
+		rte_memset_sensitive(in, 0, ICP_QAT_HW_GALOIS_H_SZ);
 		if (AES_set_encrypt_key(auth_key, auth_keylen << 3,
 			&enc_key) != 0) {
 			return -EFAULT;
@@ -1757,8 +1758,8 @@ static int qat_sym_do_precomputes(enum icp_qat_hw_auth_algo hash_alg,
 	}
 
 	/*  don't leave data lying around */
-	memset(ipad, 0, block_size);
-	memset(opad, 0, block_size);
+	rte_memset_sensitive(ipad, 0, block_size);
+	rte_memset_sensitive(opad, 0, block_size);
 out:
 	return 0;
 }
@@ -2006,8 +2007,8 @@ static int qat_sym_do_precomputes_ipsec_mb(enum icp_qat_hw_auth_algo hash_alg,
 
 out:
 	/*  don't leave data lying around */
-	memset(ipad, 0, block_size);
-	memset(opad, 0, block_size);
+	rte_memset_sensitive(ipad, 0, block_size);
+	rte_memset_sensitive(opad, 0, block_size);
 	free_mb_mgr(m);
 	return ret;
 }
@@ -3232,7 +3233,7 @@ qat_security_session_destroy(void *dev __rte_unused,
 		if (s->mb_mgr)
 			free_mb_mgr(s->mb_mgr);
 #endif
-		memset(s, 0, qat_sym_session_get_private_size(dev));
+		rte_memset_sensitive(s, 0, qat_sym_session_get_private_size(dev));
 	}
 
 	return 0;
-- 
2.47.2

