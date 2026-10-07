Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E78CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4FDB42D72;
	Wed,  7 Oct 2026 23:41:32 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 027BC42D0C
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:30 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2db710396ffso393495ad.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409289;
 x=1792014089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6MyfD+9amDR87wtTopYUKwOh7kAnyHZae2APCynjGkE=;
 b=bvypBRGzMQl0+KpMRMB0lZTHYKoaVHZq/1ITDc4EEtaRiXeaO56QX6PlU0D/PdJKti
 QfS7FtzZQfJqGEDNnE7tD4aRaUsLVRfiZYzM46nZqgwFRwqhFpByQnyL8Q914tFR5f7L
 Cb/vmMiChizQ6LElb+VY/hxKlc8jLx3beJeBot8A9ojUWx6L896p34VbAAtT6qwCVSnR
 RvnIdXzIcxOXm+qWMSXtqfgshhmEcPEQu+XsC4mArXt8VeRpiK5ZAKjFVJzrUx2dCwUn
 GXpbboem4dCDY8MU0JdPy7bm2ZMd/auGm69TV0kodxs8ZDeowify/cnlF1696oqXhrjI
 0z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409289; x=1792014089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6MyfD+9amDR87wtTopYUKwOh7kAnyHZae2APCynjGkE=;
 b=JAm2QqfG7K+m0tcSY9AeYjCCPhHOOBmYKbVRPs3D9/VexxqHV8x/EQyzOBLDd/k+lF
 jGyJ25rQu0S7DXURw5TRcUKPb74QOxYvMqhVAACtmY+ml6laJvE8GCr+j1qk+7BMD1Ef
 eaC00sV+w0o8p/ltieMNKW83laMXJOx9k0aMzqD+ISvL6+EdGd9G+zU/4y/TPJauv+Cf
 CgYhYvlFr9yvW7R8CJEc8WO2P5TbE4eENk+eEdpUzSFbcvaam7pfwVMDIPX+hcqRyqyJ
 uEZrDXNhUmEoQHvmVYj6spFzEGeqEX107LBRso8LVb/ke3Tv/YS94G73k2+/SXCkvH9w
 rR5w==
X-Gm-Message-State: AFq9FYIiOHPOu5aaye7iBhCADMV5aCCCQILGxmjD2u067KGazkT61f26
 ztqFuZWe8ZNvL6bg5ogVnyOJdNwOW0wbhnTKjJHlEg0P3k0jYX8xD6Zc9rB1Wpy/N6hFYna9yys
 pXbBkAus=
X-Gm-Gg: AYBFou2jeLwNwe3mYCH0e3LIWyUwhMrCvV9jfrzYzoF4hl5Uirr2HajQelcJVtoNmtO
 S8FkuTW5BjEzgdoSZZBwrliEPygMSkNHaX/ckCUij90hcVPirwukzcrDAsk478eei74yvtlwRyh
 bortkqABs3dZJJEtooCRYkqrv+E+IBp4nphQq1Kx/rBVrCdFHdIcPDiNIPFjQnS0gkoejsfcg04
 kjDoRypFs0+AE0rstlJgiFtJLwxDsLw91u1gdT+uNDk27Q9Q8qdERw1z3jUxyVmEsADTsJxnRhC
 di89oglBJukVfchvPzWPK8DGbMCVaQJfGtErC/HwxP/4zEZVFGcOL5ROx7VeKJ/OcY+77y/Z404
 GyCHVZhj/xuQ3PBbwIe0pPUo82LkRzvMTxOrv3VxJuevCzWs6B1mVOzHBPrGlOQu036bSCc8djy
 4Fy4NLR4ZzH26DRGfRQY2P9QjCjoJG710KpfEOXyHHTykUxssoYTZpQTF6F9hfcCxDZJeqxwbE9
 L6gTpGt391INRVXuTjt8bKK81FKt7G5s1griUVqsR4bLatG
X-Received: by 2002:a17:903:32d0:b0:2e4:cc75:2728 with SMTP id
 d9443c01a7336-2e7ffe8ff60mr2569155ad.36.1791409289091; 
 Wed, 07 Oct 2026 14:41:29 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 10/20] pipeline: promote SWX IPsec API to stable
Date: Wed,  7 Oct 2026 14:39:40 -0700
Message-ID: <20261007214115.3092715-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The rte_swx_ipsec_* symbols have been experimental since 23.03 and have
had no functional change since. Promote them to stable along with the
rest of the SWX pipeline API.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pipeline/rte_swx_ipsec.c | 14 +++++++-------
 lib/pipeline/rte_swx_ipsec.h |  8 --------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/lib/pipeline/rte_swx_ipsec.c b/lib/pipeline/rte_swx_ipsec.c
index 553056fad2..2b2b5e5e5f 100644
--- a/lib/pipeline/rte_swx_ipsec.c
+++ b/lib/pipeline/rte_swx_ipsec.c
@@ -178,7 +178,7 @@ static struct rte_tailq_elem rte_swx_ipsec_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_ipsec_tailq)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_find, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ipsec_find)
 struct rte_swx_ipsec *
 rte_swx_ipsec_find(const char *name)
 {
@@ -263,7 +263,7 @@ ipsec_unregister(struct rte_swx_ipsec *ipsec)
 static void
 ipsec_session_free(struct rte_swx_ipsec *ipsec, struct rte_ipsec_session *s);
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_free, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ipsec_free)
 void
 rte_swx_ipsec_free(struct rte_swx_ipsec *ipsec)
 {
@@ -294,7 +294,7 @@ rte_swx_ipsec_free(struct rte_swx_ipsec *ipsec)
 	env_free(ipsec, ipsec->total_size);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_create, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ipsec_create)
 int
 rte_swx_ipsec_create(struct rte_swx_ipsec **ipsec_out,
 		     const char *name,
@@ -722,7 +722,7 @@ rte_swx_ipsec_post_crypto(struct rte_swx_ipsec *ipsec)
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_run, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ipsec_run)
 void
 rte_swx_ipsec_run(struct rte_swx_ipsec *ipsec)
 {
@@ -1134,7 +1134,7 @@ do {                                   \
 	}                              \
 } while (0)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_read, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ipsec_sa_read)
 struct rte_swx_ipsec_sa_params *
 rte_swx_ipsec_sa_read(struct rte_swx_ipsec *ipsec __rte_unused,
 		      const char *string,
@@ -1768,7 +1768,7 @@ ipsec_session_free(struct rte_swx_ipsec *ipsec,
 	memset(s, 0, sizeof(*s));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_add, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ipsec_sa_add)
 int
 rte_swx_ipsec_sa_add(struct rte_swx_ipsec *ipsec,
 		     struct rte_swx_ipsec_sa_params *sa_params,
@@ -1808,7 +1808,7 @@ rte_swx_ipsec_sa_add(struct rte_swx_ipsec *ipsec,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_delete, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ipsec_sa_delete)
 void
 rte_swx_ipsec_sa_delete(struct rte_swx_ipsec *ipsec,
 			uint32_t sa_id)
diff --git a/lib/pipeline/rte_swx_ipsec.h b/lib/pipeline/rte_swx_ipsec.h
index 6cff18084f..cfd6140d02 100644
--- a/lib/pipeline/rte_swx_ipsec.h
+++ b/lib/pipeline/rte_swx_ipsec.h
@@ -46,7 +46,6 @@
 #include <stdio.h>
 #include <netinet/in.h>
 
-#include <rte_compat.h>
 #include <rte_crypto_sym.h>
 #include <rte_ip6.h>
 
@@ -125,7 +124,6 @@ struct rte_swx_ipsec_input_packet_metadata {
  * @return
  *   Valid IPsec instance handle if found or NULL otherwise.
  */
-__rte_experimental
 struct rte_swx_ipsec *
 rte_swx_ipsec_find(const char *name);
 
@@ -147,7 +145,6 @@ rte_swx_ipsec_find(const char *name);
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Pipeline with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_ipsec_create(struct rte_swx_ipsec **ipsec,
 		     const char *name,
@@ -160,7 +157,6 @@ rte_swx_ipsec_create(struct rte_swx_ipsec **ipsec,
  * @param[in] ipsec
  *   IPsec instance handle.
  */
-__rte_experimental
 void
 rte_swx_ipsec_free(struct rte_swx_ipsec *ipsec);
 
@@ -174,7 +170,6 @@ rte_swx_ipsec_free(struct rte_swx_ipsec *ipsec);
  * @param[in] ipsec
  *   IPsec instance handle.
  */
-__rte_experimental
 void
 rte_swx_ipsec_run(struct rte_swx_ipsec *ipsec);
 
@@ -297,7 +292,6 @@ struct rte_swx_ipsec_sa_params {
  * @return
  *   0 on success or error code otherwise.
  */
-__rte_experimental
 int
 rte_swx_ipsec_sa_add(struct rte_swx_ipsec *ipsec,
 		     struct rte_swx_ipsec_sa_params *sa_params,
@@ -314,7 +308,6 @@ rte_swx_ipsec_sa_add(struct rte_swx_ipsec *ipsec,
  * @param[in] sa_id
  *   The SA ID.
  */
-__rte_experimental
 void
 rte_swx_ipsec_sa_delete(struct rte_swx_ipsec *ipsec,
 			uint32_t sa_id);
@@ -367,7 +360,6 @@ rte_swx_ipsec_sa_delete(struct rte_swx_ipsec *ipsec,
  * @return
  *   Pointer to valid IPsec SA parameters data structure on success or NULL on error.
  */
-__rte_experimental
 struct rte_swx_ipsec_sa_params *
 rte_swx_ipsec_sa_read(struct rte_swx_ipsec *ipsec,
 		      const char *string,
-- 
2.53.0

