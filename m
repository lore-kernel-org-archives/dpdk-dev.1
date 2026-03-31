Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C646710F9304
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 21:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57C2440B9A;
	Tue, 31 Mar 2026 23:41:37 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id D904740B94
 for <dev@dpdk.org>; Tue, 31 Mar 2026 23:41:35 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so2364385e9.0
 for <dev@dpdk.org>; Tue, 31 Mar 2026 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774993295; x=1775598095; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nG028KKSKiuOLhbhfug3cMGWKDLf70FDEee1wvHKtg8=;
 b=c29gjd9b1KMndEK0+CDvRmRaAYLc96subj3Yxf3sysBY/v8qYpJrMBE5l5O4BGqiyr
 sBRxH8w0PX05YKRc1WmsTnXf+gluA0mER4D0xgz0GGj5hBZT9ySxl0QYDkp+0Z4Y7cpZ
 YRYdQsubt7g9uIy8v788k/idlAkDacHtS4vXw2RGBQS9HzrQujIYv+DXxv21fe6dnkZP
 a4LnoEEHy/DcC+lzzmQ5E8ZMqAcWt6WVmj5JboY4q3bhy/BR3HRRITfCCDCoTUm+Lclj
 420PiXLIq2kMM5ay+CYpS2zxFIgZMA0/2VUnEhmF6CJeyyYJu+MNd/C0p/4zuCH+fX5j
 vlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774993295; x=1775598095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nG028KKSKiuOLhbhfug3cMGWKDLf70FDEee1wvHKtg8=;
 b=SVv5pKxdw4aTpIUS5KZDzJHLp99BcuBqha5DH3Az9DF1PIYTD6v9NMt+lLkZqurnCT
 rJa5AvlkEJuW/5Oh6KS2nKhb6gVBc/eRVFlZxfSwo7lYiEjEDzvp5r2zUjV5npOiu7v9
 Vonbew0rs5inIhAiUr1CZovewcQw8FxyJRR7uQLPuFSsSa7P+zmqqFOOTZwtFe1Q1aoC
 7L8fWh6+gQOkx+j7lKxHp7M69+UusKbpzy7TNO2aXH4jcGAAy5DTEpbDH5Pc5QV8U76/
 Vgt9bniO4rn8BfFS75c/2qcF4i7grUcwOm6ty5DV20Ooua1hJqtd1uc8v5ocThXWw8GD
 qTeQ==
X-Gm-Message-State: AOJu0YxMh1S0sjh4+mpN31cDFjF9EdDrPNpCTPpLnx/wJ1vsDSAZHLTz
 DJPbLLZQGXf9D12FQ/yF18BrYa9o1pzGzyDckwecNBdGkX/i1j8LHhw4yfARDw==
X-Gm-Gg: ATEYQzz+plU/17ax2mSiXuAt60C7RO0ZpG9FyjfzNt39IHmiWwmoGhs0NFH7ZSr3g0R
 QjXLjp7iFJIZ4+bJcip6rzTIKvSsf3sxVldETzht+BevO4xTiMjlN2n45IR3MQYf/gDbQT0qKk9
 vT3eMYlqy+GHPySFVL74dg5mwlNXit/YBJ565rr6xCg5Wa3cf1Ks3ZLXclMDfe3qMpopXuF/XkC
 /omocCGFaJNPadW+SToSZ4ULhNRqh8nvHQEMFISQ8M4VS58AosbcTv4hw7fU45GnruMR1JjTJST
 lU85x8a86V9pZ+F8B4bNNdk/yRBC0A2vNPwalwwyOL71VwBCJbrngYThysbqSjKU1Uncek1O3WK
 h+IjBFAquG1PGkkpuSdJ76FufaNkPVnvsoMXJ6eX6XMYeq4A9tje1zJO7u8JPlp+GCeO2IbyDB9
 JZ2lQ4S+nGesRgePr3
X-Received: by 2002:a05:600c:47cf:b0:487:1ed:6bf4 with SMTP id
 5b1f17b1804b1-488781840f3mr65346315e9.3.1774993295232; 
 Tue, 31 Mar 2026 14:41:35 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:5eee:7f89:5053:515f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e2a7asm32981336f8f.7.2026.03.31.14.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 14:41:34 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, rjarry@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 1/5] test/fib6: zero-initialize config struct
Date: Tue, 31 Mar 2026 23:41:13 +0200
Message-ID: <20260331214117.142495-2-maxime@leroys.fr>
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

Initialize rte_fib6_conf with { 0 } to avoid using uninitialized
fields, aligned with how it is already done in test_fib.c.

This is needed because the struct will gain new optional fields
(tbl8_pool) that must default to NULL.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib6.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index fffb590dbf..9fbdde6b05 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -38,7 +38,7 @@ int32_t
 test_create_invalid(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 
 	config.max_routes = MAX_ROUTES;
 	config.rib_ext_sz = 0;
@@ -97,7 +97,7 @@ int32_t
 test_multiple_create(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	int32_t i;
 
 	config.rib_ext_sz = 0;
@@ -124,7 +124,7 @@ int32_t
 test_free_null(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 
 	config.max_routes = MAX_ROUTES;
 	config.rib_ext_sz = 0;
@@ -148,7 +148,7 @@ int32_t
 test_add_del_invalid(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	uint64_t nh = 100;
 	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
 	int ret;
@@ -342,7 +342,7 @@ int32_t
 test_lookup(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	uint64_t def_nh = 100;
 	int ret;
 
-- 
2.43.0

