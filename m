Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4F610F9304
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 21:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ADDB40DF6;
	Tue, 31 Mar 2026 23:41:48 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 5195E40DD0
 for <dev@dpdk.org>; Tue, 31 Mar 2026 23:41:47 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso55384135e9.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774993307; x=1775598107; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fFEYyzm9PXEEHrB4PiPQ26ikDzZ5uQ2h2nwDML0ujM=;
 b=CNWTsNtHhXkicq+eXOFPqrUvBxPKNLYpYxD2Oh0YLGjIWIMAn+dK/NnTQObhMliAAW
 0NOsph6jetAZ2KJm+c2MB13SpjPDCnncDNiMer9LkH/+JQMaabfern0KVNPbzb/uC6b4
 75DRWbhksPsYi+zDiqB50k7vn4M8Dy1Vz/xWRk92k+TNcktUKl8TCbnFCMOW6qb7QHwu
 N373Oip+/Rq812gNKJG3vZNDtdyy+Yhe2p2y4KoOyQ88rL67ptiOQSYj7bSuJczXGEh4
 /JjcNCYiFDqdAsqj/tt5fXTZj1kkPGd8pgUY8gsMuaJjNdGiITfZaAjXXdtTBobjOAOo
 XruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774993307; x=1775598107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4fFEYyzm9PXEEHrB4PiPQ26ikDzZ5uQ2h2nwDML0ujM=;
 b=hwnk3usn6vlZAkkmZlV+hSe5Kt1WpIMYTQJFV8WTgtrTfOzi5nZcx9bM6Nwqr4DLqv
 Nn9aNoZ3MaeqKc/AHAq+KnrVYPMFTNkMTwIETiVWdkv85mfAeRjhvHW9KunP9PdNSEyj
 RIP1wM3EbfHmKwDT+o01oZY7t7nj5tHhaQC9bL6KCG+ii6ZO4qHII5Jp7YDUW3+o/LmN
 tm0nsVLyAF0xlbmKa1zjpn1qoEEvc+BdWH31fr7FKOjQiC9mhtl/wGDozZLQKURYwaWz
 ZPj2FLRlJZyktuKoYqp82Diy7yGA8Tcnbh82xSqaxutlRp9MGkC7mi+t1Fd5h/iSHgXn
 tHog==
X-Gm-Message-State: AOJu0YweZPd38L1Rx7O+1tZeVpvQQaOlo6m2XY4rReV9TTdBJBREX5kE
 lBnd07JfjpcyAyME35wfJlNVE2hJfEKT/nZSt7jxVey5hXvyQtMN2Mi41NoJeQ==
X-Gm-Gg: ATEYQzyovYMQjORh2SkagCDvzlUmeHK4FDXrDNPXUNW7SGnbmQhkyo1XQk793+F7pFP
 coen+vsJzYEEAuixrufYadEO6Mro/KCP/g8Wj2/ZK8EKyCrhG6rOPfDsRbRXuPvLqkbP4G+08pT
 UailZge4fVg0Mz5rpPxezRmv3KrmsFyO7yiOO8oJtLZ3seZjQL4fr1VE5IWAEYGiOmQ+/JU1bIJ
 aasNEhdAp5dCu0BHG3jfj5Zx8QVXYIYpQ+mZDBwgmc3b3uThuxIKh/AZpc6+VjIINyhT/5YBzHw
 gxVTr8BsOi+tUZyi6tsQY8DWvzUUXmunb/k4WqEKnHH8l55mOEQKGIaiBH8nVKygA2HmPFj9C0x
 Fgb/82mdR+EsaFpGgytp8m6xmYW1YFbLE8PKQvWKkF8CzAXQyccEZdcZvQz94ZymPuGedUKRdqO
 duNrTf7niBBc7uChI6
X-Received: by 2002:a05:600c:8488:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-48883568434mr18027915e9.6.1774993306533; 
 Tue, 31 Mar 2026 14:41:46 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:5eee:7f89:5053:515f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e265fsm31742307f8f.1.2026.03.31.14.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 14:41:46 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, rjarry@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 5/5] fib: add tbl8 pool stats API
Date: Tue, 31 Mar 2026 23:41:17 +0200
Message-ID: <20260331214117.142495-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331214117.142495-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
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

Add rte_fib_tbl8_pool_get_stats() to retrieve the number of used and
total tbl8 groups from a pool handle directly, without going through
a FIB instance.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/fib_tbl8_pool.c     | 17 +++++++++++++++++
 lib/fib/rte_fib_tbl8_pool.h | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/lib/fib/fib_tbl8_pool.c b/lib/fib/fib_tbl8_pool.c
index 10e0c57ba7..d47fccd987 100644
--- a/lib/fib/fib_tbl8_pool.c
+++ b/lib/fib/fib_tbl8_pool.c
@@ -318,3 +318,20 @@ rte_fib_tbl8_pool_rcu_qsbr_add(struct rte_fib_tbl8_pool *pool,
 	pool->v = cfg->v;
 	return 0;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_pool_get_stats, 26.07)
+int
+rte_fib_tbl8_pool_get_stats(struct rte_fib_tbl8_pool *pool,
+			    uint32_t *used, uint32_t *total, uint32_t *max)
+{
+	if (pool == NULL)
+		return -EINVAL;
+
+	if (used != NULL)
+		*used = pool->cur_tbl8s;
+	if (total != NULL)
+		*total = pool->num_tbl8s;
+	if (max != NULL)
+		*max = pool->max_tbl8s;
+	return 0;
+}
diff --git a/lib/fib/rte_fib_tbl8_pool.h b/lib/fib/rte_fib_tbl8_pool.h
index d37ddedff3..49a2589a5b 100644
--- a/lib/fib/rte_fib_tbl8_pool.h
+++ b/lib/fib/rte_fib_tbl8_pool.h
@@ -123,6 +123,25 @@ int
 rte_fib_tbl8_pool_resize(struct rte_fib_tbl8_pool *pool,
 			 uint32_t new_num_tbl8);
 
+/**
+ * Retrieve tbl8 pool statistics.
+ *
+ * @param pool
+ *   Pool handle
+ * @param used
+ *   Number of tbl8 groups currently in use (can be NULL)
+ * @param total
+ *   Total number of tbl8 groups (current capacity, can be NULL)
+ * @param max
+ *   Maximum number of tbl8 groups (0 = fixed, can be NULL)
+ * @return
+ *   0 on success, -EINVAL if pool is NULL
+ */
+__rte_experimental
+int
+rte_fib_tbl8_pool_get_stats(struct rte_fib_tbl8_pool *pool,
+			    uint32_t *used, uint32_t *total, uint32_t *max);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.43.0

