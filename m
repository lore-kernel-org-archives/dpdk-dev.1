Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256CCD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:27:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8F5D40664;
	Tue,  9 Jun 2026 16:27:06 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 5F2174025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 16:27:05 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-137dd3af345so5110504c88.0
 for <dev@dpdk.org>; Tue, 09 Jun 2026 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781015224;
 x=1781620024; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vohj8NtpDH+9iqxddvlAf42MZcqP2adzsmU9qW5i6mM=;
 b=TNho7uS1nC96nId/T0Pn3dOZuG0ySVTZejgwQOcFaBsD9XCoX0gRUs3rYg7BnpRo+m
 HuwOXKs6XEEQjvSGw0USOxhigjgD3aWQ6s4kinNVTL0hccyxU7lBkumelJ24YjN2qKtc
 H1dq8CP7lWjGfbkQwfplXOHpNHFZprfvlYK9ymY2o7pLD/ZAmgzfF42w22AW0AeBKhbU
 IY/cvpSETEsBEIAjcbJ8nLIQrVokcz/QfTS83Hip+oh8KWvuEZTGz32VKfJNYBuhN9ay
 fecUDvVvp5WItUTAK6unV5Q6xYpKNhVLiutoMStmetRVHAbncW95abP07MreRiFFKtwT
 jYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015224; x=1781620024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vohj8NtpDH+9iqxddvlAf42MZcqP2adzsmU9qW5i6mM=;
 b=r2YmUPxZHHZPvU8TvhZ4f0Y3ODp6EeUgbso+uvOZkB70rXBefHUHwCniuWPashAtFE
 j9q7sYUDNYu3j5idsQ8/u3H1MKzPhYKUtQSjvRKBcrSQCh3aT0dH2KhKw2QVlzYkXmKg
 OpQhcm7m3myL8VF9vfZ9S9l/Pm6WoMq3sWLvF62pWU5Ktw50eXrCUMglu2rQQi5avDhD
 DGYcenfpU+wZ+L5DVe4DUozN3cQPDgZCa/f5aINIe07V3ggHxgMzuKWw7cO/nL1zt5Ar
 UHSlmdCqFZ5hk4VLiYM/ROGu8wAm7VafRydbGUgEz5MZprXzvXESXKbx2GRDIe8xdO6m
 12aA==
X-Gm-Message-State: AOJu0Yzd0dOWp658XFptYVuxIWcaOG0ES7T37XFltrHgNrgGJMu/o5dL
 537uQb82m7zkTMvpo4CqEYUgkEVF6/n1gPPGVhN4ql/GeB2U2PwS2nfJ5Owg2oOyxTEb9ox+HVs
 W8yvG
X-Gm-Gg: Acq92OFYvB5Ll+fmnyv+2WzHpg+qZvnqiFO29xvea3ksSwpUrKSkNijmb9AzIl7fX/7
 uQjtYeVZRqKabbSmcVb82srt61XCxSkVkNRQSPAlcXwzJtZ0sdJv9rI9KtpfZyJsy1nMaOin0t3
 AijDBr9vOPfZoTkQ676naknpe2Lw2WA0FAFifPwHGGzG9iWTvHhNQthkfYc9pJ3JPTPqGWCAP+t
 +9Wqa3CobfLoEon3QPIwPgx5ekjJnXLhPA1PT5oUKkFRZdRnhfek7hcIl9OMmVc1pjleEkW1F2u
 I3uyVEh+iE2cOgkzdQkN6Yua6xIzYniuvcXKxutjR6Txnuykm5rWuikEPLkUoWtqBhHBFD37NzF
 q2bADmAsqonTmVHkRsHYXJM/VMeHqCTJp2bkTz4GubkRGM66OKGaSnztnL3Rek8MxOwYzJJbkfE
 u6OwakhK4kf+WT7ueG3oYXobJ//KnbqTBJsYuTeG+fnCu7S9Oiu5i6m8okN7y2NilQkNQJ9YGd
X-Received: by 2002:a05:7022:1a83:b0:137:977e:6289 with SMTP id
 a92af1059eb24-138066fcf31mr10613874c88.24.1781015224146; 
 Tue, 09 Jun 2026 07:27:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm15369303c88.6.2026.06.09.07.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:27:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Neil Horman <nhorman@tuxdriver.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v2] eal: add destructor to unregister tailq on unload
Date: Tue,  9 Jun 2026 07:26:42 -0700
Message-ID: <20260609142701.163908-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260607150418.30885-1-stephen@networkplumber.org>
References: <20260607150418.30885-1-stephen@networkplumber.org>
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

EAL_REGISTER_TAILQ registers a static rte_tailq_elem from a
constructor but provides no destructor. If a library using the
macro is loaded with dlopen() and later unloaded with dlclose(),
the process-local list keeps a dangling pointer to the unmapped
elem, and the next dlopen() crashes in rte_eal_tailq_local_register()
while walking the list.

Add a new RTE_FINI destructor that is paired with the constructor
in the macro. rte_eal_tailq_unregister() drops the local entry on
unload. The shared mcfg->tailq_head[] slot is left reserved since
it is keyed by name and shared between processes;
rte_eal_tailq_update() now reattaches to that slot on re-register
instead of failing.

Bugzilla ID: 1081
Fixes: 873a61c7526b ("tailq: introduce dynamic register system")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2 - cover the case where name still is reserved

 lib/eal/common/eal_common_tailqs.c | 13 +++++++++++++
 lib/eal/include/rte_tailq.h        | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index c581f43b6f..9355c108f2 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -113,6 +113,11 @@ rte_eal_tailq_update(struct rte_tailq_elem *t)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		/* primary process is the only one that creates */
 		t->head = rte_eal_tailq_create(t->name);
+
+		if (t->head == NULL) {
+			/* slot reserved by an earlier load -- reuse it */
+			t->head = rte_eal_tailq_lookup(t->name);
+		}
 	} else {
 		t->head = rte_eal_tailq_lookup(t->name);
 	}
@@ -148,6 +153,14 @@ rte_eal_tailq_register(struct rte_tailq_elem *t)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_tailq_unregister)
+void
+rte_eal_tailq_unregister(struct rte_tailq_elem *t)
+{
+	TAILQ_REMOVE(&rte_tailq_elem_head, t, next);
+	t->head = NULL;
+}
+
 int
 rte_eal_tailqs_init(void)
 {
diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
index e7caed6812..d4d8bfd6d4 100644
--- a/lib/eal/include/rte_tailq.h
+++ b/lib/eal/include/rte_tailq.h
@@ -117,11 +117,27 @@ struct rte_tailq_head *rte_eal_tailq_lookup(const char *name);
  */
 int rte_eal_tailq_register(struct rte_tailq_elem *t);
 
+/**
+ * Remove a tail queue element from the local list.
+ * This function is mainly used for EAL_REGISTER_TAILQ macro which pairs
+ * an RTE_FINI destructor with the existing RTE_INIT constructor.
+ * The destructor calls this function during dlclose() to prevent
+ * dangling pointers to unmapped library data.
+ *
+ * @param t
+ *   The tailq element to remove from the EAL tailq list.
+ */
+void rte_eal_tailq_unregister(struct rte_tailq_elem *t);
+
 #define EAL_REGISTER_TAILQ(t) \
 RTE_INIT(tailqinitfn_ ##t) \
 { \
 	if (rte_eal_tailq_register(&t) < 0) \
 		rte_panic("Cannot initialize tailq: %s\n", t.name); \
+} \
+RTE_FINI(tailqfinifn_ ##t) \
+{ \
+	rte_eal_tailq_unregister(&t); \
 }
 
 /* This macro permits both remove and free var within the loop safely.*/
-- 
2.53.0

