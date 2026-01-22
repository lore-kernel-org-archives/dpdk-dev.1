Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6758EC44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2B88406FF;
	Thu, 22 Jan 2026 01:54:14 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id A87D3406B8
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:12 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso218771f8f.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043252;
 x=1769648052; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PM/R0tCpKEt639WdLPkn63XVlLvjYeA4NmY2u6hReZE=;
 b=1GA6P7KcKfOq+diTkhNgu92rLRdiDBnODdArtGh/4yefsVWXOvTt3DMMHNroTJiosE
 TmQwAp9hz10SHARTbunm22sGNRaLkAcU7AxHHwyxG0xj3lMhh4fYiQ/pZdr44OPLoJwt
 COunJRqXnv7nKMk3cx0M+75N4On0OeGrx1xhghs5qW7OStXoMz8Pg25sJjm6Hp9EuYl2
 y90q40+YymuUtr+55xqp56L0aeC+UwFbqaWPKm++d5uPOhknQyTom3P5/IG3SYU9QFBo
 xLKjMov1e+P+DVWW4rdo2P+Z1MU6vzmaFo1ecKRoBe/S76OA0at8BGxkYuhJwWJXqBRn
 DxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043252; x=1769648052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PM/R0tCpKEt639WdLPkn63XVlLvjYeA4NmY2u6hReZE=;
 b=STgWLgxpJRSQ6pO4WqJqIeYwastfFq8A5GDgN9oOZ57RLF6uYLoqqR0ILS7uMgsW/P
 UeQFNx2n/XqpzfnFhgzeGI/BQuLyXpKEyLGOqaWMGqX/6WveDFlmiVCde0XyhiqbnzrU
 2IOsRXBnZp6ulyE+PeRxm5+7Xdv2BO5k/ek37feiaoVa24uyf4mqaRUe8tm6Od5w+l1Q
 d+CQ4c8DeVf17Vp0onJtmZUgMtXH4qSv322Fuxsem0dW4TXvi09yUocLNxN8xHZGg3Ps
 HFceYD72yFML6EtCCM3Oije/n9wW7i8DaNPZws2fwAqGHu1ug5cET9JF4ZHs0y1Ra5UB
 OEMQ==
X-Gm-Message-State: AOJu0YztPVcKNTvam0SyRPLHeWzAlypxUMtKWln1pmHvL6RNGvenxB3v
 Uj8bYwfN55BwrCKzhwh0cDq5aRsAn1xGlIyXSJpylMtL2KdeR7VTLG+Z6tE5iBreCN2fKaj9Hab
 yR8d/
X-Gm-Gg: AZuq6aKC9HrCmWECAgMYnBXGfUNq4tURgbElKo+o1F/LvFImRNSvTAhaLRgyr9KeNmJ
 RUOIw1sStK8jNwVBIW1qq9+gLFmrLvYtHNCQrogCJcMBSSEwyj6YrFaPM00Vgud8M5G6j4B0MXT
 yM18a2+GtGqaujiFDs7O6YyFg81/1ibniHVnwzW8//JuCHJWnP1xCkc4HX1gf4pBZpxkagXVhuq
 WKUdRYDuxnCxwyqNscOBAG+TjybMTKq0gE9FfK4w0HXoqWS5t4kAep2Ah/xRjbXdaHlRldgA2EX
 C+t0zhAtKB91XS8x2RxXirbM+66e08SjbWr9HIykl1jQgt+SFCT7wPb0fswuVQ6eZz96YsOpvMo
 7fSgdQU4LgTCtRV4CBvnLg2kbR6iC0l9C1nNxjgFHxJcUDw6IUrioTi8vNH8j66pQNCT9H1Rur5
 CtKh8HNz0KiQv3c6fRxDSgVZ91u0AivLpgmoe2DGwMVtjYB29h0w==
X-Received: by 2002:a5d:56ca:0:b0:435:8d80:1b7e with SMTP id
 ffacd0b85a97d-4358d8023c6mr9869586f8f.60.1769043251720; 
 Wed, 21 Jan 2026 16:54:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Gage Eads <gage.eads@intel.com>, Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH v3 04/14] test/stack: scale test based on number of cores
Date: Wed, 21 Jan 2026 16:50:20 -0800
Message-ID: <20260122005356.1168221-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

This test uses loops to synchronize but has problems on systems
with high number of cores. Scale iterations to the number of
cores.

Fixes: 5e2e61b99e91 ("test/stack: check stack API")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_stack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/app/test/test_stack.c b/app/test/test_stack.c
index abc3114729..797c0a83ea 100644
--- a/app/test/test_stack.c
+++ b/app/test/test_stack.c
@@ -268,7 +268,8 @@ test_free_null(void)
 	return 0;
 }
 
-#define NUM_ITERS_PER_THREAD 100000
+#define NUM_ITERS_BASE  100000u
+#define NUM_ITERS_MIN   1000u
 
 struct test_args {
 	struct rte_stack *s;
@@ -280,9 +281,10 @@ static int
 stack_thread_push_pop(__rte_unused void *args)
 {
 	void *obj_table[MAX_BULK];
-	int i;
+	unsigned int i, num_iters;
 
-	for (i = 0; i < NUM_ITERS_PER_THREAD; i++) {
+	num_iters = test_scale_iterations(NUM_ITERS_BASE, NUM_ITERS_MIN);
+	for (i = 0; i < num_iters; i++) {
 		unsigned int num;
 
 		num = rte_rand() % MAX_BULK;
-- 
2.51.0

