Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DEEFB44C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8374040667;
	Fri, 24 Apr 2026 09:05:53 +0200 (CEST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id 22AE9402A3
 for <dev@dpdk.org>; Fri, 17 Apr 2026 12:49:08 +0200 (CEST)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso244444966b.0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 03:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776422948; x=1777027748; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fx2nkFBOxDlVD1oxzMUbuJG3W0fbXg3wng5h2t6dh00=;
 b=reXDicKMDu+J9oG8WhnjrIuVjkhGjgDe3Tk07RrF+MywJI2mGueyb1/oLNtTdZvKee
 /EKxOr7oLnR4sVboHng+sV/Tni26u+PJXM729eB6pElWutEX6QLJ0kCMXOVOaXRouyh9
 YyzBDneQbA2zSotzKseP7Wlwr4iaBhFUOCSmdch+Xx3zfwDF3+1wEvVxJC5H5lbki4gA
 xtvrdDiO5CVbzCOI5slRI2HwNg4gBmV6BLGQ5OEQZ8UVWQ+lUwkNBuEROi8A2TAwOavB
 YIe7BV5LL3JwFKe3eX+Uz9819H41tlMm/23I4T6bw9QRj4Dwqz2fEcdWDlbalewr8nMP
 WmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776422948; x=1777027748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fx2nkFBOxDlVD1oxzMUbuJG3W0fbXg3wng5h2t6dh00=;
 b=Tk5f9Fnsw1oAZ24sAFU/7Gws6+8YMUNkxeOF4FQbrNOyxwPTNq4Ef2Cm82vheihhiE
 LIf9PDWca+k4PS89BaZmb0JX0eSOKu9yHolMg5iLa7UkKahLKsat1/yuA7ybDvWhVGCm
 NB4/i2rsELnYfLu2KhXVi9Wkl+/mrqEZfBkTMUJYnoAPpQRcBdcj8KenggZGJOyh073O
 CK0KpYJr0TgvfxWmBRcDKukw0+to7Bzw8UXdMrk+T+hxY0jH6qLzxVsd+r8T4e60VYLK
 viEX81OLrm2nKEa5M2o30dB7YmFFexmo+tH0sAzLZsoDajsIItz3Fc9gvBntL+MbQ3jb
 YNeQ==
X-Gm-Message-State: AOJu0Yx8xfqs2TtC9auotV93+iUhC+WoufcM7rmok5hCE+f9IFTkOpCz
 aOs9LUZoEBAdzcwe8AuDGL5EtFQKr7g/sTQH9DvvvsxartuihHs0/zo226WDe03mZU0=
X-Gm-Gg: AeBDieuH8/OHlXF9ag82AKksBeRgXkAserDkn3YO/rp9+WmiHkBFRBoVFjZYFJjDf6I
 DygECTQqg2GMl+ejU2QyQzytQrm2T/hfNlXj71KkN0OHXwOHQmyc97r1/lS6YLK7EyhUDYum4lX
 df2BPIMUr/I7dkiPEs5+qMaOOKqg5AhvFqKBWZdwzM4fsCnzbFtU1i+07dukot5KrWSfuN4ZMWG
 7SMYInjEPGjK/XI4Bo/6kvXRLcShRnBc549qhbZYws5IasQsHNA2Ywex69w3R6gCQ3BRrd1jhJN
 /sSiCskmqYEAfIxBxNHQTMcB3z/LEpT06o7mvM8yzdjif9QE3yyAXBXMcs7TOnKtyEwWg6GJCxW
 ZsC2rnPVAKzS6BGE6dWP72Q9y1tB912U4yctOgiW6SFkhbixezVvzz63SEVWH5tqzTfktO+WrmJ
 3/y4bSOiNdv9Ppe2N+Y5RAQ+OQKvvkBFxrmZvfw6u+GuREBySh05MKn8g7kHjSAhChbDkjiZFpx
 vk=
X-Received: by 2002:a17:906:c102:b0:b97:b88c:386b with SMTP id
 a640c23a62f3a-ba4229d7784mr108292566b.29.1776422947459; 
 Fri, 17 Apr 2026 03:49:07 -0700 (PDT)
Received: from work.cisco.com ([2603:5004:20a0:100c:fa09:d9cc:a4b8:91d6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba454d1b379sm41257166b.39.2026.04.17.03.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 03:49:07 -0700 (PDT)
From: Maxime Peim <maxime.peim@gmail.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: [PATCH] eal: fix core_index for non-EAL registered threads
Date: Fri, 17 Apr 2026 12:48:38 +0200
Message-ID: <20260417104838.342531-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 09:05:46 +0200
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

Threads registered via rte_thread_register() are assigned a valid
lcore_id by eal_lcore_non_eal_allocate(), but their core_index in
lcore_config is left at -1. This value was set during rte_eal_cpu_init()
for lcores with ROLE_OFF (undetected CPUs) and is never updated when the
lcore is later allocated to a non-EAL thread.

As a result, rte_lcore_index() returns -1 for registered non-EAL
threads. Libraries that use rte_lcore_index() to select per-lcore
caches fall back to a shared global path when it returns -1, causing
severe contention under concurrent access from multiple registered
threads.

A concrete example is the mlx5 indexed memory pool (mlx5_ipool), which
uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a per-core
cache slot. When core_index is -1, all registered threads are funneled
into a single shared slot protected by a spinlock. In testing with VPP
(which registers worker threads via rte_thread_register()), this caused
async flow rule insertion throughput to drop from ~6.4M rules/sec to
~1.2M rules/sec with 4 workers -- a 5x regression attributable entirely
to spinlock contention in the ipool allocator.

Fix by setting core_index to the next sequential index (cfg->lcore_count)
in eal_lcore_non_eal_allocate() before incrementing the count. Also reset
core_index back to -1 on the error rollback path and in
eal_lcore_non_eal_release() for correctness.

Fixes: 5c307ba2a5b1 ("eal: register non-EAL threads as lcores")
Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
---
 lib/eal/common/eal_common_lcore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 39411f9370..ae085d73e4 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -378,6 +378,7 @@ eal_lcore_non_eal_allocate(void)
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (cfg->lcore_role[lcore_id] != ROLE_OFF)
 			continue;
+		lcore_config[lcore_id].core_index = cfg->lcore_count;
 		cfg->lcore_role[lcore_id] = ROLE_NON_EAL;
 		cfg->lcore_count++;
 		break;
@@ -399,6 +400,7 @@ eal_lcore_non_eal_allocate(void)
 		}
 		EAL_LOG(DEBUG, "Initialization refused for lcore %u.",
 			lcore_id);
+		lcore_config[lcore_id].core_index = -1;
 		cfg->lcore_role[lcore_id] = ROLE_OFF;
 		cfg->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
@@ -420,6 +422,7 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
+	lcore_config[lcore_id].core_index = -1;
 	cfg->lcore_role[lcore_id] = ROLE_OFF;
 	cfg->lcore_count--;
 out:
-- 
2.43.0

