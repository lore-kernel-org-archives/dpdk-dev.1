Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D62FB44C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:06:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFBAA40679;
	Fri, 24 Apr 2026 09:05:56 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 570CD40144
 for <dev@dpdk.org>; Wed, 22 Apr 2026 09:54:20 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so3444921f8f.3
 for <dev@dpdk.org>; Wed, 22 Apr 2026 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776844460; x=1777449260; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fx2nkFBOxDlVD1oxzMUbuJG3W0fbXg3wng5h2t6dh00=;
 b=SCw9opvPLpBdM4vchm3+t5CuHPj9KX1DCgpj55YY/4B1qQ2IwizEJMGf01ShjZjlev
 LGyD/9Y2v/hMnsph4ZAYvFAW3ydy9VsoMRVbpRDZpu0LYBjQzHrV35Fovw5yUnWAmcMB
 T4WGlQnok9NAhtD+H21yu0T5p6Pp88bQCwXG7lN0BABqGroS569VmtCbKkZNY6+qRmL0
 46HDCnoFwTX9x9dLYQe+1dlzuC8MNtvEZqZFd3tmMNBPG+9iXTFmzRBWgZoorG++oUCg
 dvNJeN0Ey7iBKzOnwOu8gIS/0S9/P01mFJ/AptVCf+PyCTETOv39zNaA18scjBG4GRBL
 ZrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776844460; x=1777449260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fx2nkFBOxDlVD1oxzMUbuJG3W0fbXg3wng5h2t6dh00=;
 b=sVfR6bkrPnVoChcjWBSQmBPqSpH/ZTrgED3nbgd9gfUEgi1e29QdvrGpTo1GP5+V/i
 QDXTIAo51kAzvgiiCFxNki1dn+iUZ9QEalMe/kxUR/jt4VlMSKzDmjMeMa3tT/kXl3w5
 Ls69//pK0JoQPG9uaiZifAkznSAvdyc8/aUkodUuPj0Def11Wsjn/ShRvEvF2tyN1ery
 e37t9Jf0zKRz+urQAYA/szMd5usWGI9uNWzkATVdORhOTpvxDadYOEzYlCcKThjoxOk5
 X/jrtOkPv3HtK7K8pr2nbisPUng0TopzpQnTHQN08wc2LzMbYxwS0D4GUn9qUgUmXDmJ
 HkrA==
X-Gm-Message-State: AOJu0Yy57mIAQQ1DJwkCf31L8ja+HDQgLdO5lOugTDENpwnfcP/fSUAt
 0JH4/k0hbXsOh8uD9briGHHWK7jtTwnwD5vi188GYimqHr0yoFD5FLEjuvGlPf4pVtklGJG9
X-Gm-Gg: AeBDies8sZScfQP4rZWhJui/git3p/avFYOiEahH45qMTD1/3IFYtnmixCNhvBPvTS5
 DDTSd46njm+99ZRBU3SD9wUM3U8LwADvyIH0QCRl7gpK4ozBSkXHfV9hSda7J5MedpYKk05nNp0
 MRgre2Esx5XC4y5C+O1WyEzNlOWpC9LaPBaeXpInFXPqIoXSPYg4D0IKNaLgwXr1nhVxkQrjRbH
 wJKPu+MVRQ5B85OHHx0EdtHVSlfEMsw7u4tBMFTRoyLEOq8UwtkTQWIvNmCLHenSjm4uquFyN//
 z0FXsgEp2L8kjEhVbVrPR0iCneH80QI7r8DA3lk1RAozPyq+6rS0QQ5BvjIdvSsuSlNw0kNQQIY
 +QxV1iILkwflNYIawwUhLqByZgizxB+u6IOsnCy1f2wQTRgoXYfHFAlHnGP99/Q+xu37dHfZqWG
 McQHXGEf8rS7U5Eto/9TQA4mCa+Rk3+j0td/fl6ClcapRV7FeWT2JpCtZZLB1jAUw=
X-Received: by 2002:a5d:64e7:0:b0:43d:50c:6f18 with SMTP id
 ffacd0b85a97d-43fe3dc37e6mr32427033f8f.11.1776844459621; 
 Wed, 22 Apr 2026 00:54:19 -0700 (PDT)
Received: from work.lan ([2a01:e0a:906:9aa0:6b8:e420:7878:c86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm47654497f8f.30.2026.04.22.00.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 00:54:19 -0700 (PDT)
From: Maxime Peim <maxime.peim@gmail.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: [PATCH] eal: fix core_index for non-EAL registered threads
Date: Wed, 22 Apr 2026 09:54:14 +0200
Message-ID: <20260422075414.2528455-1-maxime.peim@gmail.com>
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

