Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D2DD1171E
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:26:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6A6040650;
	Tue,  2 Dec 2025 18:26:35 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 853EC40652
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:34 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8b2627269d5so493050685a.2
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696394;
 x=1765301194; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fKG5XcHldKbnjtm41WEDjMfuzHzxTBkdz7jQmzWz5Y=;
 b=DOe0YAI249WHrAtb2BVq1pIALJsPkWNVd8OPIZOlpnXziB0Eb1AUsLl+6Ot3GKxsIw
 jrMQPRv9JidUXrUtdVsGTEIt/lyV/yTHIgEmSHUB2tQg02c7pyILFX0qvIpZIb+8+6kw
 OXC/2zcmu4gwBRzxWRM4LU0QZuRUKmeAwPFfm32/OzMEMLPfwLL6D1e33xeO0g3/ks09
 iA+LbW7/1PrSEESiN8RZz7O4H4Cf0PFjo30NySk3fwTMKQGIJ3QpvijQ1RT2i0ExL/Zt
 XBgB4GCvCupUEYi5F2sjP0rS+HgvixybVnA1x8uH+kwPUb12l5NY4ynty5OC+aAsbJjV
 sx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696394; x=1765301194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+fKG5XcHldKbnjtm41WEDjMfuzHzxTBkdz7jQmzWz5Y=;
 b=RNiIJmKVu26ELvYu+ydJeePV4BQBQpRxcxQshjEwq4744QwVrpf2AAf8m7yDSvz8XY
 oawdYgRCB/x3Nlhklv+bn0fXmfBkuq6JcUbUCIoQDa4rfh03fZQwb9oVw94r46MQeOdj
 TgokXbGnIUUGRrV3lPhzj066xySuogekYmerB4EeVG0dPrgQH18GCe/wQ1NxLWRsu+5J
 mVFk1hhl5f7OMIv7F8D2tItRAb1FLYgcYL5m2eA/K3inJqD6ib8N7HdFblapbQJlRBmq
 qV+aeOFFkUg0kf3VLPER5nHS3z8A4JWlRZOu8ZxMMCW/QSW79yA9vyvUOmj0mbWsf+1r
 qLMg==
X-Gm-Message-State: AOJu0YwKiQWWh9kghPQRuf1NB9J0qvM6JkhXcj9zpu1nQKvncPA5V+Da
 mPcOwSL++4Ae2SnxyVaSYQ6rEtf2KYTW5784761112wg70/SIWbcn5WXxAxYHNzZRxWi7u2vfEj
 mZaIR
X-Gm-Gg: ASbGncsAI6qpZUEZIyABF4/l/45s9wodTw3seMKnQc47DKoK/BBO32ffAF1uSuEOlMK
 YTGaehctlvtk4tGVnAag0hZQWdfGutDyvKHswNFfEZkg1t0LB9fbZH/ZaJ7qmTEvXxkMW7uhUmY
 Surs/C1hzZIy1ARV8d+gp0fOxJUazJsmsBK/abAcTDngQpZNw3/xQf0omZLvBZaQhYoSzxbD6hP
 lPTDOW9nkAZ8FdfR9EpWYlG6977E7GlBtg4JCeBDcgFIcvBqpBPewJ/daCXpIoSLW0cXM4lIujF
 WhH2hKl89SFX7NN5tAUhR+8zb+VA9vqCqIfar0jzt/bwhHINKK7nh4NX67LhWzW1MW0i4vGDOk5
 tlsEPtrHXKYBVZqraw/9gybLh53ogZj/yEV62DBotaQy7DZMIyk9+J3PYmJ0lf25f0ebvW8gsL3
 rxvnPm2NvT6pAw9vs+JXDvkQi1HZxNgODOJmScQ2vWHIV2qly4Gw==
X-Google-Smtp-Source: AGHT+IH+RpPp+7+2WqfOlqlw2Q9WHV8rZ1ucosYFBxi6WTk3Go4xMvNtnUxcIzP1pQu3ab34dUENoQ==
X-Received: by 2002:a05:620a:3945:b0:8b2:e6b1:a9a6 with SMTP id
 af79cd13be357-8b33d1d01bbmr6274491785a.17.1764696393513; 
 Tue, 02 Dec 2025 09:26:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 2/8] hash: fix possible ring name overflow
Date: Tue,  2 Dec 2025 09:24:28 -0800
Message-ID: <20251202172626.283094-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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

The maximum possible hash parameter name will cause the generated
ring names to overlow in snprintf(). Potentially causing conflicting
ring names and trouble.

For reference:
   RTE_MEMPOOL_NAMESIZE = 32
   RTE_RING_NAMESIZE  =  29
   RTE_HASH_NAMESIZE = 32
The hash name is concatenated with a prefix like "HT_RCU_"
the hash name string needs to be enforced as having space
for the resulting string (ie 22).

Since the NAMESIZE's are part of ABI they can't change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_cuckoo_hash.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 2c92c51624..3a521a1a1e 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -77,6 +77,11 @@ struct __rte_hash_rcu_dq_entry {
 	uint32_t ext_bkt_idx;
 };
 
+#define HASH_QSBR_PREFIX	"HT_RCU_"
+#define HASH_EXT_PREFIX		"HT_EXT_"
+#define HASH_RING_PREFIX	"HT_"
+
+
 RTE_EXPORT_SYMBOL(rte_hash_find_existing)
 struct rte_hash *
 rte_hash_find_existing(const char *name)
@@ -231,6 +236,20 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		return NULL;
 	}
 
+	/*
+	 * The API for hash allows 32 characters but maximimu length
+	 * would overflow ring name which is limited to 29 characters (RTE_RING_NAMESIZE).
+	 * To avoid breaking ABI, enforce limit of 25 characters on
+	 * the hash table name.
+	 */
+	if (strnlen(params->name, RTE_HASH_NAMESIZE)
+	    > RTE_RING_NAMESIZE - sizeof(HASH_QSBR_PREFIX)) {
+		rte_errno = EINVAL;
+		HASH_LOG(ERR, "%s: hash name too long to fit in qsbr ring name",
+			 __func__);
+		return NULL;
+	}
+
 	/* Check extra flags field to check extra options. */
 	if (params->extra_flag & RTE_HASH_EXTRA_FLAGS_TRANS_MEM_SUPPORT)
 		hw_trans_mem_support = 1;
@@ -272,7 +291,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	else
 		num_key_slots = params->entries + 1;
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", params->name);
+	snprintf(ring_name, sizeof(ring_name), HASH_RING_PREFIX "%s", params->name);
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create_elem(ring_name, sizeof(uint32_t),
 			rte_align32pow2(num_key_slots), params->socket_id, 0);
@@ -286,8 +305,8 @@ rte_hash_create(const struct rte_hash_parameters *params)
 
 	/* Create ring for extendable buckets. */
 	if (ext_table_support) {
-		snprintf(ext_ring_name, sizeof(ext_ring_name), "HT_EXT_%s",
-								params->name);
+		snprintf(ext_ring_name, sizeof(ext_ring_name),
+			 HASH_EXT_PREFIX "%s", params->name);
 		r_ext = rte_ring_create_elem(ext_ring_name, sizeof(uint32_t),
 				rte_align32pow2(num_buckets + 1),
 				params->socket_id, 0);
@@ -299,7 +318,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		}
 	}
 
-	snprintf(hash_name, sizeof(hash_name), "HT_%s", params->name);
+	snprintf(hash_name, sizeof(hash_name), HASH_RING_PREFIX "%s", params->name);
 
 	rte_mcfg_tailq_write_lock();
 
@@ -1582,7 +1601,8 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 	char rcu_dq_name[RTE_RCU_QSBR_DQ_NAMESIZE];
 	struct rte_hash_rcu_config *hash_rcu_cfg = NULL;
 
-	if (h == NULL || cfg == NULL || cfg->v == NULL) {
+	if (h == NULL || cfg == NULL || cfg->v == NULL ||
+	    strlen(h->name) > RTE_RCU_QSBR_DQ_NAMESIZE - sizeof(HASH_QSBR_PREFIX)) {
 		rte_errno = EINVAL;
 		return 1;
 	}
@@ -1606,8 +1626,7 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_HASH_QSBR_MODE_DQ) {
 		/* Init QSBR defer queue. */
-		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
-					"HASH_RCU_%s", h->name);
+		snprintf(rcu_dq_name, sizeof(rcu_dq_name), HASH_QSBR_PREFIX "%s", h->name);
 		params.name = rcu_dq_name;
 		params.size = cfg->dq_size;
 		if (params.size == 0)
-- 
2.51.0

