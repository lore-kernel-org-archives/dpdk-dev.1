Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34936CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2328242DF0;
	Wed,  7 Oct 2026 23:41:41 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 63E3242DDC
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:36 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2df982e04c1so15506285ad.2
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409295;
 x=1792014095; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8OKrQ43RylyjcQwbdkrPnHUPIu32YHKqbnD1QCjIweQ=;
 b=JtYQ82dyFH7/KTqMnOv3Jk/c3rNEe4dOeBSnUiT6Bx589yGYGwlBDCDRQTC2mZdiwm
 BmWNzAYjtq2KtE388BnNP/kkdsZJnK3Bh7f/6vQofk+ardkjbkp3LLdSa71jfd61PSTC
 xDMxbgmfh8fSyIV66adhLtNebhEUxE8vh1XxH+YwifQsnCfNTt8xQBFQGeN9A7xemMC2
 vuEU/MNdgLDY/L6+NMxZQnMrQ8Tb0pgjH4F+PL3MkoadSV4FwDayiIGyHFmapU2wun5V
 nAN1d4kw5NPd8YgF+qf4LSSCG5zQpyS+4Q8gHVcs5jHU4nNmDrVLD3RQHcpbdYXkuHo8
 KfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409295; x=1792014095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8OKrQ43RylyjcQwbdkrPnHUPIu32YHKqbnD1QCjIweQ=;
 b=AgDn1gzkeQs0YIHaEQw/9S16+mQrRcmi7CLm5Jg9gyKWBqFKo+WoJHQL0du2yZmsJf
 L/kog2HZN0ESu7oDiFFqT1gHCgUJ01631Tp7zMt27rIqZs1+krlsdbsQuPN+HaswDbij
 wIv43Mzs2roGAxRHLxZ56JaqVmLgFV3lUWgr8m9PgFiTg7nr1J6yzarFUwmJVV3zxAT4
 ak+ROYFfVNdaLJQ2L7h2AgMj2eR5wNeNMzN+LK9AsXpDf1PnYd12+6j5j7lDQjnfZq94
 Pn6PutWroBLuXMKq3NmEbEfQQtcTj0HLNm6mx1oOIIjBlpBWxnpFL/onUp9psS8DX+qu
 wO9g==
X-Gm-Message-State: AFq9FYJH1ywHESv8QFQ320md+gLWm0O3gFiLkKAlUhZmzgFBQcMM+tS/
 0Qphv4A/jG7AsmFDz1cdLei3+Nao0vINtlbjdAuckgxF592buf8yCWDxkcQZFl0oQOU5QqDVsmq
 VdWM7Mhc=
X-Gm-Gg: AYBFou2zTWBJdl7bUJPSzsEjCpfrKTT4E1C1u73X8FrOKX9uDdF9XYkUAi2maNMC87F
 IxPJC8n/o9ICwqlUaiMvclTk04WdL/XIeMKAufGACXJ4YJVYPVSp5dm28BdJLNtBH0REjjakC6A
 1QQaE8Mv7gFuFrHEVLwMyM/EzlkkrK66qDgnOjAkm+PaI2dqGgE/naGxqmn51dgBWaONR4ISQaN
 omFTZrTwEBX24RwF2CSqolYDmSde+J9pTdt+XA+CxwB4VLKaYDb8FeNy0r34c2qB+BrWUd3Ouic
 DFD0UqjSG91llKKfjEkdnk52JdU80rcUw1Ka1rxDc9O1y16QynZC9S9KDWuYiA+wKyI4HN3rYjV
 qPy36K0G4mdBWVw4n0jm3cobPs4N1wYjCEmUs8lKkXwA6iFVXOi2LPsrf8mmRwn+4MtMuFDcOKp
 ZoQ/cFVgcD9UIiYWDj5H0RVVzW1JegCiUaMJGBYRvFQ8Sz5cLryIAEucyH1kJHT01ZN9QkkMN6W
 vxhU+AuxWzMrICOYdaoFzmcSLI83uLGVVIP3g==
X-Received: by 2002:a17:903:906:b0:2df:917a:adcb with SMTP id
 d9443c01a7336-2e5ffabc44dmr29491275ad.6.1791409295583; 
 Wed, 07 Oct 2026 14:41:35 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 17/20] hash: promote RCU reclaim and thash key generation to
 stable
Date: Wed,  7 Oct 2026 14:39:47 -0700
Message-ID: <20261007214115.3092715-18-stephen@networkplumber.org>
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

rte_hash_rcu_qsbr_dq_reclaim() was added in 24.07 and
rte_thash_gen_key() in 24.11. Neither prototype has changed and the
rest of both APIs is already stable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 3 +++
 lib/hash/rte_cuckoo_hash.c             | 2 +-
 lib/hash/rte_hash.h                    | 1 -
 lib/hash/rte_thash.c                   | 2 +-
 lib/hash/rte_thash.h                   | 4 ----
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 009db40708..f689f08338 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -349,6 +349,9 @@ API Changes
     ``rte_event_port_profile_links_get`` and
     ``rte_event_port_profile_unlink``
 
+* hash: Promoted ``rte_hash_rcu_qsbr_dq_reclaim`` and ``rte_thash_gen_key``
+  from experimental to stable.
+
 * node: Promoted the whole library API from experimental to stable.
   The ``rte_node_*`` control path functions date from 23.07 to 25.07 and
   are used by the graph application and the l3fwd-graph example.
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 5d495ae973..f01b796200 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -1921,7 +1921,7 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_hash_rcu_qsbr_dq_reclaim, 24.07)
+RTE_EXPORT_SYMBOL(rte_hash_rcu_qsbr_dq_reclaim)
 int rte_hash_rcu_qsbr_dq_reclaim(struct rte_hash *h, unsigned int *freed, unsigned int *pending,
 				 unsigned int *available)
 {
diff --git a/lib/hash/rte_hash.h b/lib/hash/rte_hash.h
index e33f0aea0f..4435941537 100644
--- a/lib/hash/rte_hash.h
+++ b/lib/hash/rte_hash.h
@@ -700,7 +700,6 @@ int rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg);
  *   Possible rte_errno codes are:
  *   - EINVAL - invalid pointer
  */
-__rte_experimental
 int rte_hash_rcu_qsbr_dq_reclaim(struct rte_hash *h, unsigned int *freed,
 		unsigned int *pending, unsigned int *available);
 
diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index fcd41248b9..10f3f978dc 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -836,7 +836,7 @@ rte_thash_adjust_tuple(struct rte_thash_ctx *ctx,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_thash_gen_key, 24.11)
+RTE_EXPORT_SYMBOL(rte_thash_gen_key)
 int
 rte_thash_gen_key(uint8_t *key, size_t key_len, size_t reta_sz_log,
 	uint32_t entropy_start, size_t entropy_sz)
diff --git a/lib/hash/rte_thash.h b/lib/hash/rte_thash.h
index 8bca430663..f0e382277a 100644
--- a/lib/hash/rte_thash.h
+++ b/lib/hash/rte_thash.h
@@ -465,9 +465,6 @@ rte_thash_adjust_tuple(struct rte_thash_ctx *ctx,
 	rte_thash_check_tuple_t fn, void *userdata);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Modify RSS hash key such that subtuple bits corresponding to `entropy_sz`
  * bits starting from `entropy_start` will have the most even distribution with
  * this key with a given ReTa size.
@@ -488,7 +485,6 @@ rte_thash_adjust_tuple(struct rte_thash_ctx *ctx,
  * @return
  *  0 on success negative otherwise
  */
-__rte_experimental
 int
 rte_thash_gen_key(uint8_t *key, size_t key_len, size_t reta_sz_log,
 	uint32_t entropy_start, size_t entropy_sz);
-- 
2.53.0

