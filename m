Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7BCD2CE0B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A353406B8;
	Fri,  5 Dec 2025 03:30:00 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 17C5340613
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:29:57 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-880503ab181so17530856d6.2
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901796;
 x=1765506596; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/9u43wz84uaw6l56XY5JM51bfzjmp6RryzvQE/ARHc=;
 b=cv747LVPEiEjNxXxfAZUHlQlrqfzGOuda9/9YW4WaqhNSXZJ5Efu4Eh065mOv8uxVS
 bzzXGokUEj5A0z6YSq9mS7gn6vSfIljf2RUdFN/hyAn+xTworeJO13ENQI8AIArFtgW6
 caqtu8UlEiR2fjuvt38bOy1hTZygz2dfaCQIHxT0BKN9fpEGrfsIwKgfWXtdQcKTZvwr
 tGSvysNprWqlJ1FCJ1/AMuNeBUnSQuDl4vpIgCgrST3JIOr+JBI48nza9rdQ+3F78cTe
 wHfiaF64isfpFZA6ayfTwcqQHYq5FPQU05PMVa5AVaLq4fJPzfwzMeZSMA/1gbWu5II9
 sAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901796; x=1765506596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+/9u43wz84uaw6l56XY5JM51bfzjmp6RryzvQE/ARHc=;
 b=jV5n5GQTk2TxUdfD0/qXVlQcaL2Sx5pimytVignwAVX0VwuG8htSfsu5T1xRlP7pC7
 zSUQtMS+IFepSot1c1mgp3LBK/KzLpr3nH62ycI//IW7JK2JjWt/y9FYnMzsRzVU6M8C
 6wvzh1cJJMyCgKsDP1hsGWoywvo11L6LUCA6Pi3Wrzky7FmgUQLKLbt9+F+CI66xrkkl
 ru4rCzhe0c0CEB/sRIjCUkbrjvstCe9MiQgzqfMGBoNg5MQCYpUhNCJYxmHc7AZwleRc
 o7pNrjhh4DHZEFEVLd2RS5EGHKcF7zyyhMj67RJuMgKC6f1Wz6q95vlyDVd3MbVeYK5G
 6UkQ==
X-Gm-Message-State: AOJu0YzeoT8jQU4dy2NukTVRfg5Rczcp4Fb6EE7EhWsk3Pp5+lmc0suh
 WU/TXKjtiZOaqSSBRqZDjnVljkTubUSvbO4VcYki9eojso0fHwCSOZfW/GBW2lAaG4w5MODfqZO
 JbT/o
X-Gm-Gg: ASbGnctOspwfqCbJw/ScdzY3JWfwNWuV0cBw22HCEuXHWRuszeVyHyL+qR4aLlBC1Gd
 iVzdKbCAUI5foP6KRFwLlqg9+l37zaRJF0QWZh0h5n+Dnrk/oJYIuYOhXmW8bUOkugd7cEdWFa+
 isPdjSRYZqSVeRRQqZ+2OpGI1byrP4zH5cmwXSP+HcO1qF7oLgxZ6dFDQA8pMIgsHwLsaZguPdL
 BaQou1o2eKnL4MT8UoJ7hvmGb0J+SBzE2EQTEJhoOFq5ypDPeFDPGsDKCrf2Th2mrvIBr5q39TG
 vfUDjwffuxFc3RAuYnWXAH7gn+e6mISwj8ARy1u+jqez+f61Dyec63Elmv6vv2JBQ6XXaznLyvz
 f7ZCbrHLXJ6b4OpgveHWDxp2IPGxnuUaMpZzyrO9UE0aI/dWW1Rbpi9F0DcUrL6zciXwldqaZg9
 FPCx4VfuDkpenm0zMXmqtSxCmsXpGStvyWwl57n4O1rJ5YhD9nqQ==
X-Google-Smtp-Source: AGHT+IHHITtn2DTQofqlbiWqX3jq0WblY2eA1++kAg9LQTXLXm7QEmbIox0FHKxeDxAcnzj2CEQ3LQ==
X-Received: by 2002:ac8:5f92:0:b0:4ee:d9a:8877 with SMTP id
 d75a77b69052e-4f01767f5b5mr124651511cf.72.1764901796213; 
 Thu, 04 Dec 2025 18:29:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:29:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 04/14] hash: avoid possible ring name overflow
Date: Thu,  4 Dec 2025 18:28:13 -0800
Message-ID: <20251205022948.327743-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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
ring names to overflow in snprintf(). Potentially causing conflicting
ring names and duplicate rings.

For reference:
   RTE_MEMPOOL_NAMESIZE = 32
   RTE_RING_NAMESIZE  =  29
   RTE_HASH_NAMESIZE = 32

This version changes RTE_HASH_NAMESIZE since not hardcoded
into any ABI.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_cuckoo_hash.c | 21 +++++++++++++++------
 lib/hash/rte_hash.h        |  6 ++++--
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 2c92c51624..8c5d4c417c 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -77,6 +77,10 @@ struct __rte_hash_rcu_dq_entry {
 	uint32_t ext_bkt_idx;
 };
 
+#define HASH_QSBR_PREFIX	"HT_RCU_"
+#define HASH_EXT_PREFIX		"HT_EXT_"
+#define HASH_RING_PREFIX	"HT_"
+
 RTE_EXPORT_SYMBOL(rte_hash_find_existing)
 struct rte_hash *
 rte_hash_find_existing(const char *name)
@@ -222,6 +226,12 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		return NULL;
 	}
 
+	if (strnlen(params->name, RTE_HASH_NAMESIZE) >= RTE_HASH_NAMESIZE) {
+		rte_errno = ENAMETOOLONG;
+		HASH_LOG(ERR, "%s(): name '%s' too long", __func__, params->name);
+		return NULL;
+	}
+
 	/* Validate correct usage of extra options */
 	if ((params->extra_flag & RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY) &&
 	    (params->extra_flag & RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF)) {
@@ -272,7 +282,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	else
 		num_key_slots = params->entries + 1;
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", params->name);
+	snprintf(ring_name, sizeof(ring_name), HASH_RING_PREFIX "%s", params->name);
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create_elem(ring_name, sizeof(uint32_t),
 			rte_align32pow2(num_key_slots), params->socket_id, 0);
@@ -286,8 +296,8 @@ rte_hash_create(const struct rte_hash_parameters *params)
 
 	/* Create ring for extendable buckets. */
 	if (ext_table_support) {
-		snprintf(ext_ring_name, sizeof(ext_ring_name), "HT_EXT_%s",
-								params->name);
+		snprintf(ext_ring_name, sizeof(ext_ring_name),
+			 HASH_EXT_PREFIX "%s", params->name);
 		r_ext = rte_ring_create_elem(ext_ring_name, sizeof(uint32_t),
 				rte_align32pow2(num_buckets + 1),
 				params->socket_id, 0);
@@ -299,7 +309,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		}
 	}
 
-	snprintf(hash_name, sizeof(hash_name), "HT_%s", params->name);
+	snprintf(hash_name, sizeof(hash_name), HASH_RING_PREFIX "%s", params->name);
 
 	rte_mcfg_tailq_write_lock();
 
@@ -1606,8 +1616,7 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_HASH_QSBR_MODE_DQ) {
 		/* Init QSBR defer queue. */
-		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
-					"HASH_RCU_%s", h->name);
+		snprintf(rcu_dq_name, sizeof(rcu_dq_name), HASH_QSBR_PREFIX "%s", h->name);
 		params.name = rcu_dq_name;
 		params.size = cfg->dq_size;
 		if (params.size == 0)
diff --git a/lib/hash/rte_hash.h b/lib/hash/rte_hash.h
index f692e0868d..7292610064 100644
--- a/lib/hash/rte_hash.h
+++ b/lib/hash/rte_hash.h
@@ -24,8 +24,10 @@ extern "C" {
 /** Maximum size of hash table that can be created. */
 #define RTE_HASH_ENTRIES_MAX			(1 << 30)
 
-/** Maximum number of characters in hash name.*/
-#define RTE_HASH_NAMESIZE			32
+/** Maximum number of characters in hash name.
+ * Limited by ring name (used internally) with prefix.
+ */
+#define RTE_HASH_NAMESIZE	(RTE_RING_NAMESIZE - sizeof("HT_EXT_") + 1)
 
 /** Maximum number of keys that can be searched for using rte_hash_lookup_bulk. */
 #define RTE_HASH_LOOKUP_BULK_MAX		64
-- 
2.51.0

