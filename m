Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B12ECC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9BCB40647;
	Fri, 16 Oct 2026 17:39:57 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id C17CD40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 17:39:54 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so56833a12.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792165194;
 x=1792769994; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6BIDqLYP8xUDQLMvFG00cdsE9ti8SR0I9ILjwAH/lrw=;
 b=hiHQDxx6/wQyJfxK74nVkCC4sNtbAO7yH4AlkSqk7TSH1+cRIJHk3KqBJ0mpDF7Ix7
 N4CTd16A0Jpu0GWZ+ztc45WIhRMuLkawNiItHdSATRofJm6cLfsEQTqIsIfEtKvnZX9e
 C7qx5V3EAVu+hjzRmtidxqvtl+GuupkhggY/fdiyuUw0cWibdrt5GtCdlmvTpAPm80BX
 vpI7KC1eGQr28c2EABHrNjB8CarN33gY2imCcNLHhZEYqdU3YOWaIXo2nmu2AVyyMyok
 21U2efxfjcyRNA6uJ9OIcyO/n9mg4fp1QkXcb53THmc+7qfapcoEtwxuJoneL5TfRFQG
 4vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792165194; x=1792769994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6BIDqLYP8xUDQLMvFG00cdsE9ti8SR0I9ILjwAH/lrw=;
 b=DYnQAOk+iL7e8nJZNEvZGZY5qD0acj4qqSxKDfiyaHGQsyYRIcz/xScYmPiLCjRV5l
 wyrVdtJj79wpci45IlruPHvz9wxFHAkN2Hbhk+JE7teSAXSXwjyaP6ZrOJRGtNDdJGnK
 CybUdOyPpEJ99U62+c/5E34roi3/kriwLZJ508zLDUjNXr5jfiobKIuO1vmAqqr1Cf43
 4JX1XiMeTiIQ8R8OjWoj6OLCrCFLXPzTwcBNVh8a6o4qJn4m6xN7C82oxNuE6d+2uG6N
 nFJrjxdXntEmotQO5KXgMACDAUqd3whaRJ8iLu4lOlpnQez0Tvi14+UukrmrQ1NVbrzm
 EdMg==
X-Gm-Message-State: AFq9FYLlFUIg7ofhUp21lH2fH93TWQVqGIxlkG9YPUK/BTCHKCgAW/LV
 E/MxdYqSEr/o3bUW9jjgUsHakEBUCnCBjh0K3aBYHYGxAJcdrChaLd4Ee7eyLDrpDNmmNB7NgyS
 hWIdXMZk=
X-Gm-Gg: AYBFou2nEGdj18p0Gw4C67U4oFnCwoM1hGWSWBqzFzOysCK5rPztXrTLzA20t/rOXFh
 kjcJ2gAaNmvaoo8sH/GFKkJCIM8S8ZsMr4K8s/IBp+dk7LhOrPjh2ru7zWuphzzx2aVKo7NY+gj
 0HaD57OGhHlj4wS8/r4pedzLEn31jrzOU0hv9EvnYbSDPM0IlM83dgoR9N9evsl4gZylahptv8I
 /Sa4EswLXMj9FHGt+Klz4ma6ksLxUoEwpaDZJKPbuFadBgrsW943B85anclDUIIj4H4pW84QfLF
 Xc6cEjWqrlrnieDe6ZmKz8ZQBKM918k4C8riwEM3CO7YLJ0gkXCu+S7spqbIZPr1PnaZ7d0Ijhy
 4vnbJSenfA9G4eXTzOWa2g9onxmS58xvV8JeMo5wBGrluYCcq1Vo6hKiv6XMDZIpAWXWsgm+cP9
 HKm4sgjaiSGnpHN3Dyw2Jaa0yCQWd+id1jG0uMMq3Jqf+AK04qT2axku55CmBYLN9Ux/gdCKV/f
 QKgFIm+RHSFoTa+91rd4dm5Eg4EwEQY3kw2dw==
X-Received: by 2002:a17:902:ebc6:b0:2dd:c053:82f1 with SMTP id
 d9443c01a7336-2e9a69f292amr2906055ad.40.1792165193770; 
 Fri, 16 Oct 2026 08:39:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e804cf3sm12214445ad.25.2026.10.16.08.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 08:39:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 1/3] app/crypto-perf: fix asymmetric op pool name size
Date: Fri, 16 Oct 2026 08:38:43 -0700
Message-ID: <20261016153949.2965592-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016153949.2965592-1-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20261016153949.2965592-1-stephen@networkplumber.org>
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

The asymmetric op pool name buffer is 32 bytes but snprintf is given
RTE_MEMPOOL_NAMESIZE as the size. This is harmless only as long as
RTE_MEMPOOL_NAMESIZE is not larger than 32.

Size the buffer with RTE_MEMPOOL_NAMESIZE and use sizeof() for the
snprintf limit, as the symmetric path already does.

Fixes: ba588ce3f933 ("test/crypto-perf: test asymmetric crypto throughput")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-crypto-perf/cperf_test_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-crypto-perf/cperf_test_common.c b/app/test-crypto-perf/cperf_test_common.c
index 0bcaa6dfd8..b2eabf470e 100644
--- a/app/test-crypto-perf/cperf_test_common.c
+++ b/app/test-crypto-perf/cperf_test_common.c
@@ -145,7 +145,7 @@ cperf_alloc_common_memory(const struct cperf_options *options,
 			struct rte_mempool **pool)
 {
 	const char *mp_ops_name;
-	char pool_name[32] = "";
+	char pool_name[RTE_MEMPOOL_NAMESIZE] = "";
 	int ret;
 
 	/* Calculate the object size */
@@ -154,7 +154,7 @@ cperf_alloc_common_memory(const struct cperf_options *options,
 
 	if (cperf_is_asym_test(options)) {
 		crypto_op_size += sizeof(struct rte_crypto_asym_op);
-		snprintf(pool_name, RTE_MEMPOOL_NAMESIZE, "perf_asym_op_pool%u",
+		snprintf(pool_name, sizeof(pool_name), "perf_asym_op_pool%u",
 			 rte_socket_id());
 		*pool = rte_crypto_op_pool_create(
 			pool_name, RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
-- 
2.53.0

