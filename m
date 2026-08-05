Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B05DC56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 13:51:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3A21402BB;
	Thu,  6 Aug 2026 15:51:48 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 0E46E4021F
 for <dev@dpdk.org>; Wed,  5 Aug 2026 17:44:17 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-81f36179dd5so17004787b3.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weka.io; s=google; t=1785944656; x=1786549456; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xYNv38ZXNfzvM/beu+YfJtKwqdurpWzU1D3eULnvQMI=;
 b=jd4ffeSV+2NkQmZIQoH/+YtsL5Am87Jt1t6Xg2Nl1n2GVUwKua/FJFUR3USu+kV0zK
 3N38o5X3QE8eXNCIUUovGgmOKKoQCCcF2ba9Cc3FR1tven0Gjmze4Cj8i9yAe6ezFmdZ
 fBvAYxmjQCw1UxW2K6/oIgDJa+mb758XKDe24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785944656; x=1786549456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xYNv38ZXNfzvM/beu+YfJtKwqdurpWzU1D3eULnvQMI=;
 b=sxtyC3jb+vUGr1rvM4O0nR5SMkaOhIPBTzuoSUe6o4fBfnT6obgX91BJfrghge4RTF
 ODU4yXkqulxAd9VF+BuvpNfR5BCxmteoD7QV5w8WubvDhZKjj05t6UFzH+6YJ4pU5caF
 bvv8t337EX0hirtjbZJL4OC6j/cAapXCg4GJ1lF72si6d5xHSZk8+anci6iUkugCEGpD
 o/djrt64vcWuIHteoR56bz8Mlz0AKH6XAHEOiLKE/djS5sqNX6BCq3R3PPtutp/7mW0p
 sIg67erQqTv4c3WkbmCIn5frAdVEZlwVuAuJBQ+bcUb7u7Cpp+xWWZOd0IcuMmVtsPxK
 JGXw==
X-Gm-Message-State: AOJu0Yx9k+KLEIdyqjhPe4nqF/JyaMVQcp8gWGbfKScwafvRtTNUaQrm
 KoXo4pvydCsLVkJpm/OrYO3enoziW1HuSZt1i+slU4uPfVBz61X00GsurocMh5uHi+Td+iqjzlO
 ojpWrYlB0GqOvcoSGwZRCjt+PlpSpvy4oS905x5kMsXx+ADbBVv1/ixYCMmUgNFXWhNiwjpPXuX
 4jhW3uqJDdUZAiYfKEaPHBkAEBWarW8ERkjjqJJMEp
X-Gm-Gg: AR+sD11BdI3CNHLYdO8sWNXULyPZbRnrR8Q/qnB8xUTlXNviMAgbBXB7R81RKie7hDA
 uB9TLH9EzfRDuccOMVSX+ezvVDVesInYN7blQKnJOENU3t7Aizyp+Gfp7vLnzxblgew8RxKtF4v
 IGFVe6F4HXNsSvnD5jOnBFOe/okEA/gI2lcjCfbK83Orxn2AoA7RdOooo0FO2rVsGzRRwxXI1Gp
 lWi84C5Oso30OvFA3ZXXHaUxlfCwTKhw+Uq8LOBjQIRZGBlOBgRBGix1KmtbgA2fQ1aCKOYPcXn
 578Lhwqcm8vlIxqEwG8iFULlaSi9ywHvxhQDMhgKVi2mf5n7Ms4Q5W/NeNfHlf6yeB2VzqxPk9v
 Apm8PGMsX43xVYTgQqzvXY0jb8jZUuRA/m6mnQ2NIqL6r0RVbDHlxGSuF0IuhjdDA+3sSe7c/yQ
 N+LaCH95FJJvnZhj6vLLa+bYDXjx/qwwYGVGLqrJ41i90VOxurNbcHF9zaYAEKXAb2nR0RCsnYU
 mReMyNI7ojgKu5uyxbd79TEq5XDctUKV2BtjK6Org==
X-Received: by 2002:a05:690c:7247:b0:81e:4aa9:d025 with SMTP id
 00721157ae682-8201bc8540bmr44545717b3.6.1785944656077; 
 Wed, 05 Aug 2026 08:44:16 -0700 (PDT)
Received: from rita-ruvinsky-Precision-3490.wekalab.io ([185.114.120.1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-820134a9e21sm22878737b3.42.2026.08.05.08.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:44:14 -0700 (PDT)
From: Rita Ruvinsky <rita.ruvinsky@weka.io>
To: dev@dpdk.org
Cc: longli@microsoft.com, weh@microsoft.com,
 Rita Ruvinsky <rita.ruvinsky@weka.io>, stable@dpdk.org
Subject: [PATCH 1/2] net/mana: fix MR length truncation for chunks over 4GB
Date: Wed,  5 Aug 2026 18:44:06 +0300
Message-ID: <20260805154407.1965063-1-rita.ruvinsky@weka.io>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 15:51:47 +0200
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

mana_range.len is a uint32_t, so a mempool chunk of 4GB or more
truncates modulo 2^32 -- exactly 4GB becomes 0, 15GB becomes 3GB.

The guard against priv->max_mr_size cannot catch this because it
compares the already-truncated value, and the device advertises
max_mr_size as UINT64_MAX. ibv_reg_mr() then fails with EINVAL on a
zero length, or silently registers a region far shorter than the pool,
so lookups for buffers past that boundary never find an MR and no Rx
WQE can be posted.

Widen the length to uint64_t through the MR path, including the
multi-process request that forwards it to the primary process.

Fixes: 0f5db3c68ba7 ("net/mana: implement memory registration")
Cc: stable@dpdk.org
Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
---
 drivers/net/mana/mana.h |  4 ++--
 drivers/net/mana/mp.c   |  4 ++--
 drivers/net/mana/mr.c   | 11 ++++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 7d94840dc4..552865ff9d 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -553,7 +553,7 @@ struct mana_mp_param {
 
 	/* MANA_MP_REQ_CREATE_MR */
 	uintptr_t addr;
-	uint32_t len;
+	uint64_t len;
 };
 
 #define MANA_MP_NAME	"net_mana_mp"
@@ -562,7 +562,7 @@ int mana_mp_init_secondary(void);
 void mana_mp_uninit_primary(void);
 void mana_mp_uninit_secondary(void);
 int mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev);
-int mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len);
+int mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint64_t len);
 
 void mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type);
 
diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c
index 5467d385ce..5cc29de3a1 100644
--- a/drivers/net/mana/mp.c
+++ b/drivers/net/mana/mp.c
@@ -17,7 +17,7 @@ extern struct mana_shared_data *mana_shared_data;
  * Process MR request from secondary process.
  */
 static int
-mana_mp_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len)
+mana_mp_mr_create(struct mana_priv *priv, uintptr_t addr, uint64_t len)
 {
 	struct ibv_mr *ibv_mr;
 	int ret;
@@ -257,7 +257,7 @@ mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev)
  * Request the primary process to register a MR.
  */
 int
-mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len)
+mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint64_t len)
 {
 	struct rte_mp_msg mp_req = {0};
 	struct rte_mp_msg *mp_res;
diff --git a/drivers/net/mana/mr.c b/drivers/net/mana/mr.c
index c4045141bc..7405755df8 100644
--- a/drivers/net/mana/mr.c
+++ b/drivers/net/mana/mr.c
@@ -13,7 +13,8 @@
 struct mana_range {
 	uintptr_t	start;
 	uintptr_t	end;
-	uint32_t	len;
+	/* 64-bit: a mempool chunk can be 4GB or more, which overflows uint32_t. */
+	uint64_t	len;
 };
 
 void
@@ -47,13 +48,13 @@ mana_new_pmd_mr(struct mana_mr_btree *local_tree, struct mana_priv *priv,
 
 	for (i = 0; i < pool->nb_mem_chunks; i++) {
 		if (ranges[i].len > priv->max_mr_size) {
-			DP_LOG(ERR, "memory chunk size %u exceeding max MR",
+			DP_LOG(ERR, "memory chunk size %" PRIu64 " exceeding max MR",
 			       ranges[i].len);
 			return -ENOMEM;
 		}
 
 		DP_LOG(DEBUG,
-		       "registering memory chunk start 0x%" PRIxPTR " len %u",
+		       "registering memory chunk start 0x%" PRIxPTR " len %" PRIu64,
 		       ranges[i].start, ranges[i].len);
 
 		if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
@@ -62,7 +63,7 @@ mana_new_pmd_mr(struct mana_mr_btree *local_tree, struct mana_priv *priv,
 						    ranges[i].len);
 			if (ret) {
 				DP_LOG(ERR,
-				       "MR failed start 0x%" PRIxPTR " len %u",
+				       "MR failed start 0x%" PRIxPTR " len %" PRIu64,
 				       ranges[i].start, ranges[i].len);
 				return ret;
 			}
@@ -98,7 +99,7 @@ mana_new_pmd_mr(struct mana_mr_btree *local_tree, struct mana_priv *priv,
 				return ret;
 			}
 		} else {
-			DP_LOG(ERR, "MR failed at 0x%" PRIxPTR " len %u",
+			DP_LOG(ERR, "MR failed at 0x%" PRIxPTR " len %" PRIu64,
 			       ranges[i].start, ranges[i].len);
 			return -errno;
 		}
-- 
2.43.0

