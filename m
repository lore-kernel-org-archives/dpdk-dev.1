Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71460CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 093E74066E;
	Thu, 28 Aug 2025 01:15:48 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id ED50E40674
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:46 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45b5d49ae47so1790055e9.0
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336546;
 x=1756941346; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CieqiAUYYljZp6Qqz6PP9dzuyub9IhGJDiK1UsKVcpo=;
 b=Wsm1e62vRiKz3sCJGhs13oPoQpRefsxEqczHkQ3coCgsRaCNQM8j47A4sivzbg+7/O
 gh3iUHHf8+6o9cr9C0tV/pn9JXNV+3mhwR9XmLDwEl/7JVfoXsxdRiu7hWRQdFjyUO9t
 /m1DlBJIHf6rhrZHW4IaegzrxY6ifp0GeFtGym4DiXJ8+fan/U5mQYUxp4AdFcEwfYny
 KKdTtIzRB4nfJvtWFo5PEcK8epTpeVdnMrv05mVXOkb6suyIgNOsSW/N/4XowuVxSc2a
 tKx3KCq/qnOWUPbE3BQErrBQYi0ToBBEpx6hR1BckETgDdRFZ0kVMnkUYsG1OgyMGqj0
 mS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336546; x=1756941346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CieqiAUYYljZp6Qqz6PP9dzuyub9IhGJDiK1UsKVcpo=;
 b=EMNzY8eCFbNVXSHwjjTT52DbC+/rK7g6I120aJQm/K0QW0D5vP8//E4J2Y5kKUypG7
 r8P8smia+Ps5bsOk4N3M2pDOPS3D5fBIPeuDXUgRaCruhTU0rhGMweyvZJQPQKJzTGv1
 DWpnOUA9pvyYD7JBEg9/SuBRqpllRV4gPNoz5yN+q29bmWyCg2nROQTAGCb+9jojrTh5
 gmGmCLSZvBY8kjKFf/jcjA8h06IOZfIRhZe4gB+2jAMG3iBaSjAP7TdvyfXQizXb3Q9i
 /fNRKlKdvLSU9SXGYWuQr+Q2DEJz9PDWzMwDMnbDD0DU9Q5zjg/OxGuXmnJJB5wKT90R
 VxPw==
X-Gm-Message-State: AOJu0Yw9SnvxOv5FSNQoOr9TFJHGzRTg8rLM9YdidA5Gy7jy/hYwvvfB
 zvtMjsafpB4cCgVobOVFDgCoTZaEJw5SjkknswjFg+Z/52y1+aRBqMaFdMs9zeZh2dlwMDbDd92
 LfaL4
X-Gm-Gg: ASbGncv5CFc0XHVBovJqPRIvaUEzl+zABRb9nWMBF9N8+S2asRUvL9KlbpRD8C/kBw1
 Q63acxajkMRAjxpL3J9Ad3BWQJykq42YPyoZBzXKJkhLqSIXT5rkiNobXZ2MlZqI9jOvmLP+BYo
 nRfFsRb0BtpCz6pvpdJz7DZ6ABRp0KyftoWAfordcv8W3ja1nXejZzkSGyBirr9SDxCj6y3QDzB
 +aVbiOedTL9/CxEbwSzMbxZKjuVXJzkYhXgmlwH0BT+oaN3klAS9JcU7mhiRE3xs2cgbJMRV6mi
 dVXvFVoQUlVwPXiWvcJtwirAGmUYX43HQVNotcj/qprCUWTgs2otCxOzA2rpLUjGorF1BzDNHTk
 esDgl6dBx0SfQcLn5hwB/ziOpS/my22qiJQPqiRfj1eEb2SXOK+ldyz+GP7nzA7at8+G3CwCk
X-Google-Smtp-Source: AGHT+IEPqcFzydP4c2xWbJepNbvIh6MQ8Wco6vvH0AvVc0atIGGVNNsWq88VgZyv96pK2gD5gCTDOQ==
X-Received: by 2002:a05:6000:2204:b0:3cc:3d4b:7fab with SMTP id
 ffacd0b85a97d-3cc3d4b8185mr4119198f8f.37.1756336546524; 
 Wed, 27 Aug 2025 16:15:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC 5/8] eal: avoid shadowed variables in trace code
Date: Wed, 27 Aug 2025 16:14:08 -0700
Message-ID: <20250827231528.236172-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827231528.236172-1-stephen@networkplumber.org>
References: <20250827231528.236172-1-stephen@networkplumber.org>
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

The trace code had a global variable and local variable with
same name. Rename the globals to get rid of warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_trace.c | 42 +++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index be1f78a68d..d3cacfb47c 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -24,12 +24,12 @@ RTE_DEFINE_PER_LCORE(void *, trace_mem);
 static RTE_DEFINE_PER_LCORE(char *, ctf_field);
 
 static struct trace_point_head tp_list = STAILQ_HEAD_INITIALIZER(tp_list);
-static struct trace trace = { .args = STAILQ_HEAD_INITIALIZER(trace.args), };
+static struct trace tr_obj = { .args = STAILQ_HEAD_INITIALIZER(tr_obj.args), };
 
 struct trace *
 trace_obj_get(void)
 {
-	return &trace;
+	return &tr_obj;
 }
 
 struct trace_point_head *
@@ -47,12 +47,12 @@ eal_trace_init(void)
 	RTE_BUILD_BUG_ON((offsetof(struct __rte_trace_header, mem) % 8) != 0);
 
 	/* One of the trace point registration failed */
-	if (trace.register_errno) {
-		rte_errno = trace.register_errno;
+	if (tr_obj.register_errno) {
+		rte_errno = tr_obj.register_errno;
 		goto fail;
 	}
 
-	rte_spinlock_init(&trace.lock);
+	rte_spinlock_init(&tr_obj.lock);
 
 	/* Is duplicate trace name registered */
 	if (trace_has_duplicate_entry())
@@ -75,10 +75,10 @@ eal_trace_init(void)
 		goto free_meta;
 
 	/* Apply global configurations */
-	STAILQ_FOREACH(arg, &trace.args, next)
+	STAILQ_FOREACH(arg, &tr_obj.args, next)
 		trace_args_apply(arg->val);
 
-	rte_trace_mode_set(trace.mode);
+	rte_trace_mode_set(tr_obj.mode);
 
 	return 0;
 
@@ -101,7 +101,7 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_is_enabled, 20.05)
 bool
 rte_trace_is_enabled(void)
 {
-	return rte_atomic_load_explicit(&trace.status, rte_memory_order_acquire) != 0;
+	return rte_atomic_load_explicit(&tr_obj.status, rte_memory_order_acquire) != 0;
 }
 
 static void
@@ -124,20 +124,20 @@ rte_trace_mode_set(enum rte_trace_mode mode)
 	STAILQ_FOREACH(tp, &tp_list, next)
 		trace_mode_set(tp->handle, mode);
 
-	trace.mode = mode;
+	tr_obj.mode = mode;
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_mode_get, 20.05)
 enum
 rte_trace_mode rte_trace_mode_get(void)
 {
-	return trace.mode;
+	return tr_obj.mode;
 }
 
 static bool
 trace_point_is_invalid(rte_trace_point_t *t)
 {
-	return (t == NULL) || (trace_id_get(t) >= trace.nb_trace_points);
+	return (t == NULL) || (trace_id_get(t) >= tr_obj.nb_trace_points);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_is_enabled, 20.05)
@@ -165,7 +165,7 @@ rte_trace_point_enable(rte_trace_point_t *t)
 	prev = rte_atomic_fetch_or_explicit(t, __RTE_TRACE_FIELD_ENABLE_MASK,
 		rte_memory_order_release);
 	if ((prev & __RTE_TRACE_FIELD_ENABLE_MASK) == 0)
-		rte_atomic_fetch_add_explicit(&trace.status, 1, rte_memory_order_release);
+		rte_atomic_fetch_add_explicit(&tr_obj.status, 1, rte_memory_order_release);
 	return 0;
 }
 
@@ -181,7 +181,7 @@ rte_trace_point_disable(rte_trace_point_t *t)
 	prev = rte_atomic_fetch_and_explicit(t, ~__RTE_TRACE_FIELD_ENABLE_MASK,
 		rte_memory_order_release);
 	if ((prev & __RTE_TRACE_FIELD_ENABLE_MASK) != 0)
-		rte_atomic_fetch_sub_explicit(&trace.status, 1, rte_memory_order_release);
+		rte_atomic_fetch_sub_explicit(&tr_obj.status, 1, rte_memory_order_release);
 	return 0;
 }
 
@@ -295,7 +295,7 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_dump, 20.05)
 void
 rte_trace_dump(FILE *f)
 {
-	struct trace_point_head *tp_list = trace_list_head_get();
+	struct trace_point_head *tp_head = trace_list_head_get();
 	struct trace *trace = trace_obj_get();
 	struct trace_point *tp;
 
@@ -310,7 +310,7 @@ rte_trace_dump(FILE *f)
 
 	trace_lcore_mem_dump(f);
 	fprintf(f, "\nTrace point info\n----------------\n");
-	STAILQ_FOREACH(tp, tp_list, next)
+	STAILQ_FOREACH(tp, tp_head, next)
 		trace_point_dump(f, tp);
 }
 
@@ -508,7 +508,7 @@ __rte_trace_point_register(rte_trace_point_t *handle, const char *name,
 	}
 
 	/* Are we running out of space to store trace points? */
-	if (trace.nb_trace_points > UINT16_MAX) {
+	if (tr_obj.nb_trace_points > UINT16_MAX) {
 		trace_err("trace point exceeds the max count");
 		rte_errno = ENOSPC;
 		goto fail;
@@ -534,10 +534,10 @@ __rte_trace_point_register(rte_trace_point_t *handle, const char *name,
 
 	/* Form the trace handle */
 	*handle = sz;
-	*handle |= trace.nb_trace_points << __RTE_TRACE_FIELD_ID_SHIFT;
-	trace_mode_set(handle, trace.mode);
+	*handle |= tr_obj.nb_trace_points << __RTE_TRACE_FIELD_ID_SHIFT;
+	trace_mode_set(handle, tr_obj.mode);
 
-	trace.nb_trace_points++;
+	tr_obj.nb_trace_points++;
 	tp->handle = handle;
 
 	/* Add the trace point at tail */
@@ -548,8 +548,8 @@ __rte_trace_point_register(rte_trace_point_t *handle, const char *name,
 	return 0;
 
 fail:
-	if (trace.register_errno == 0)
-		trace.register_errno = rte_errno;
+	if (tr_obj.register_errno == 0)
+		tr_obj.register_errno = rte_errno;
 
 	return -rte_errno;
 }
-- 
2.47.2

