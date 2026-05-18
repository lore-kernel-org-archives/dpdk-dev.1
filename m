Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C9FCD4F49
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 16:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36056402EF;
	Mon, 18 May 2026 18:35:06 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 10334402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 18:35:04 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12c19d23b19so3386528c88.0
 for <dev@dpdk.org>; Mon, 18 May 2026 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779122103;
 x=1779726903; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=reh3U8jF0ijCQzZtItM8KBHeDMCQiCJRq5X0VlCf/Rk=;
 b=hR3kRkHBZpzclIPsACf8z5pcmHmanR5Gc+tywcOG9BQZUmvSrK7io4p2fn02BCcjoY
 4bR7jKLXhCRSUsrJ8qeotpAvMyQVweRAYa+b2zlCCTYftxMji1Iul3/AWUFu34Ivx1Yr
 ChDOI/WMM2EWAdaRg0YV9AiRSCTlKtqU6VrKByQ4aXT/Wzae8U4irjCBIGk+Zb0EYd3v
 ffejGKZWQpXpptpZwd+C3Y1K+FsdIMHzz0Lf5T2QD19tJLgCXDrx0E2JxGzZ9fSK/b/m
 R1KYYWWE3RrXL2J1jp+pzVBk1oHdrUESKXfaMN7DuzghwekYbyIpBNoHkbEhwcE6DSUZ
 7wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122103; x=1779726903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reh3U8jF0ijCQzZtItM8KBHeDMCQiCJRq5X0VlCf/Rk=;
 b=USKJKd6AY9rVny72gc5fDQyMQuH8mqgYMBuI1H71PeZZ9CG8ziOy7AuAuZAePxchvS
 ZbrUga+DILqntIbwVyifoL5mYxIA0dJh74CFgDYO6XzAsPUHHr0GGH1HS5Q3mwHMYC+f
 vaP/OEZKm1LEX91QfITzDz5HLJPMNdiKrs+Hld4jjSM7qlD78vpyZBx6585B4N4U3yRu
 g19+yiSSFzQPQwdiP+YcJPkHCYMMkmx890sfs31CbgL1fYdVmxKy9kmw/HvWiUch2dCU
 BFi3+U2ssbQRwnlwBhWpoTwSbJXPVo0UiEB0LqSHtcuySt8mx+sklZNxq5+Mq6K8oT0M
 hjAw==
X-Gm-Message-State: AOJu0YxPHUUbqfcos0BEU3ZlRgfJbiyDZqmzKlyqompN/cO8eFcnXiBS
 lsn6xhjxOrKeg6BieNRhFFCcX59jwy18BM9mCfMrJ6mOcNbv7O9aroLP5BPqvTzvr36crX/IKI0
 JkNVk
X-Gm-Gg: Acq92OEJu9Rd3Zl3O6yNqg/HRJL1a78WmJhmANDgc9fbYDxL5nO36EgaprmS577AK3E
 tRVHeoKfIPQ3k3eI8kp6g7zkJQtVfuCH9+VZiZ6F/KhbuAIxk8HSpF581dGTaLY7pN8m1OHUvOP
 Xq9ft34Fts55Q6j49YRlhYUJ2koYqL2frxjrP+nmlRFrtFrepniKE7+m6Eh72eWSBoWJYwOStz4
 orBq+wT2sHKsv4FCVWB5QX2TcrWYYClwNBEXNo1mJ0IpobaLLZkVfEO7b0ZIknHniyIJ+1bYsvq
 C+QB7PnXg2Q/PIID+tZ0HX24j+1NuHFxdDbNyxzAxth8Ar3wHC9NOZg4Fy1LQZGbdfT5nXXbnhx
 y/N95lbGENUsK/To53YWhmnzJbQABDbob5j/L6Its4gFcIO+hSWKXWegPoGsKqOiIv9edoDSRFd
 Eye9TKH3FxQnLmmvTudgz+pzklO7rOlkfD
X-Received: by 2002:a05:7022:2586:b0:12c:856:ddcc with SMTP id
 a92af1059eb24-1350474133dmr7194286c88.27.1779122102837; 
 Mon, 18 May 2026 09:35:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ef5sm19892132c88.2.2026.05.18.09.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:35:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] eal: enable thread safety analysis for recursive lock
Date: Mon, 18 May 2026 09:34:26 -0700
Message-ID: <20260518163500.583397-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The recursive spinlock API was annotated with
__rte_no_thread_safety_analysis on each definition, with no capability
annotations on any declaration. As a result, callers received no
static checking: fields marked __rte_guarded_by() on a recursive
spinlock were not verified, and rte_spinlock_recursive_t was not
recognized as a capability at all.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/generic/rte_spinlock.h | 28 +++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index 5d810b682a..e489f846f6 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -195,7 +195,7 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
 /**
  * The rte_spinlock_recursive_t type.
  */
-typedef struct {
+typedef struct __rte_capability("recursive_spinlock") {
 	rte_spinlock_t sl; /**< the actual spinlock */
 	RTE_ATOMIC(int) user; /**< core id using lock, -1 for unused */
 	int count; /**< count of time this lock has been called */
@@ -219,6 +219,32 @@ static inline void rte_spinlock_recursive_init(rte_spinlock_recursive_t *slr)
 	slr->count = 0;
 }
 
+/*
+ * TSA models the recursive spinlock as a single capability: callers
+ * get the same __rte_guarded_by() checking as the non-recursive API.
+ * Nested acquires by the owner are invisible to the analyzer — TSA
+ * has no model for re-entrance, so mismatched recursive lock/unlock
+ * counts remain a runtime concern.
+ *
+ * The definitions use __rte_no_thread_safety_analysis because the
+ * inner rte_spinlock_lock() is conditional on the owner check, which
+ * TSA cannot reason about. Annotations on the declarations are what
+ * callers see.
+ */
+
+static inline void
+rte_spinlock_recursive_lock(rte_spinlock_recursive_t *slr)
+	__rte_acquire_capability(slr);
+
+static inline void
+rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
+	__rte_release_capability(slr);
+
+__rte_warn_unused_result
+static inline int
+rte_spinlock_recursive_trylock(rte_spinlock_recursive_t *slr)
+	__rte_try_acquire_capability(true, slr);
+
 /**
  * Take the recursive spinlock.
  *
-- 
2.53.0

