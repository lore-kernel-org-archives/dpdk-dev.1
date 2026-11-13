Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF3606B2D0
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AL4S1JnK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4D57427DF;
	Fri, 13 Nov 2026 17:05:54 +0100 (CET)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A6D9402A4
 for <dev@dpdk.org>; Fri, 13 Nov 2026 15:26:57 +0100 (CET)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3ab3b29a1d4so13970611fa.1
 for <dev@dpdk.org>; Fri, 13 Nov 2026 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794580016; x=1795184816; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ovvEUqD7JsLGS6mWFqIsMHQMcvb2HTjpbIGguknghtw=;
 b=AL4S1JnKqPsZR/hrVzL5seD/FWUHwEJFHaHteeSS28PgmRbo5QiqZHPON6A/wZVa4g
 gnxEjFWZhvlxVZ9b8GWVVTySvLyApftu6UpKr5Fm1UXnLPAaorJbFchhPBZhyFCH3BO+
 uG905IlOsDSCd5po45hsZASDHwjcn+Zc7wTWmXTjGviT5xds+Q6SyNhWbjeFsc6XZuJk
 0D5RNO0yKILFi5F0UD6zZsGPBSloNm0/QhFsKPTUmavGzacq4ZOpcNBbKKDYspRyDLZ+
 vd4vsroBQscHz4RjnyfKB27HU2Hm3hnrmFWfD2+hXVDj6CZQlfS2dqzWyeVJfHYtXKHQ
 MusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794580016; x=1795184816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ovvEUqD7JsLGS6mWFqIsMHQMcvb2HTjpbIGguknghtw=;
 b=TMPpfk1bPtYjyC0az2opv3MB8CQX92bmF6SK2r/d6Mcr7g89SYS0OFqghvIdwDzHmN
 tAHFG+hIXc06W3++1LxKlrtIToz0bHLznufE7n2foLH82vrBrAOARFf3mW7T9hzznhhM
 qinAUkSMGBbmlUQC0kXVk2M6wRMJEZL6Ssvun8gWw0nGlNL+JXiTrGiROv9LaLTqvCwU
 oxu3WuFFloKMNjMXXj9qLcKqm+C1eUFHQvRTta4bVDTmbCIQm+ZDxsb2L/s1VkBD5q48
 bvi3+sI2rYYf5Ixz5w+1VPJBYCurANge/TtG4RCpSzJggxN41/KxTbiM3MTw7VPe0YRc
 dWYA==
X-Gm-Message-State: APuU4Z/AR2sEt+v1UiFxbsoQLIwX3Ki6FT7MGyh2BmSVQtJLiB8y7vIV
 DKL92Wcr92ZJWFMxULOYKU+rWxY1MEcWkoV3B+RVhTevzKQ2UIAG2WKC
X-Gm-Gg: AYBFou3iyqMoT8Z9Zg/pF+EjDmWz7atcfsnDT2yBr+jHHzrMrxvpfSMxvST2TbYMZ2D
 B1t7Ij3kgQdhuabmnqIxnI1qcTje3g2SC1qWQl5K/2R3M++XuIm5wsSH1gQqFIKF6mFIJeDi40q
 1Kl3O8yQke591opeqs7+TBjQPjAjmIbKxHBHpziF2pqcMqWtSYICgHNK7iECpQdxT7u+SgGhqpB
 GFTTS4EROm3dSBufp2bFKVNT4+jNM9QBj9vrgYV9NwAsI5Wn/UAWOOyBy0ufUpFh17W07wuZE6x
 IzqeZbAPfq6MbyrVFXt8/1ZIs1jbz3X+Weo7lidcjcfCohQwjHh2rbKfKvAcnSO7RsBP6syobfo
 G6UYf4dTzYQMUeyWcftPKdoiaUAVkCRjxlKLvMXNHR9clY40BEbrduxSrps54l3XSERkzN5gcQ2
 li+fTfnRjZMFszDdbj7FHDEYMZ19XkgHH7u6ifbRy1m5DQpuUhaBy50SAmjGbZToAt7rSfO7Qcp
 saymEsWXUcFEkWvULZJTvUY9/06xdVZyTactBr0+RhBMMMmmkpeQTal2mgEiYKFFcomgfBMBqf2
 S1iJNCTBAcIvqY6q2PSTyx5TZppKPLlPT6fEXKBodNAUMCYVqw==
X-Received: by 2002:a05:6512:3f21:b0:5bf:d60a:9802 with SMTP id
 2adb3069b0e04-5c17075c416mr1162533e87.18.1794580016141; 
 Fri, 13 Nov 2026 06:26:56 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1712d9f7esm832237e87.12.2026.11.13.06.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 06:26:55 -0800 (PST)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Alexey Simakov <bigalex934@gmail.com>,
 Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH] table: fix overflow in rte_swx_table_selector_create
Date: Fri, 13 Nov 2026 17:25:59 +0300
Message-Id: <20261113142559.5730-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:05:48 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

table_create_check() checks the bounds of params->n_groups_max and
group_size individually. However, this does not guarantee that their
product will not cause an overflow.

Fix this by using type casting.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f7598a62d1 ("table: support selector table")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 lib/table/rte_swx_table_selector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/table/rte_swx_table_selector.c b/lib/table/rte_swx_table_selector.c
index d42f67f157..d976904b7d 100644
--- a/lib/table/rte_swx_table_selector.c
+++ b/lib/table/rte_swx_table_selector.c
@@ -289,7 +289,7 @@ rte_swx_table_selector_create(struct rte_swx_table_selector_params *params,
 
 	/* Group. */
 	group_size = params->n_members_per_group_max * sizeof(uint32_t);
-	t->group_table_size = params->n_groups_max * group_size;
+	t->group_table_size = (uint64_t)params->n_groups_max * group_size;
 
 	t->group_table = env_calloc(t->group_table_size, RTE_CACHE_LINE_SIZE, numa_node);
 	if (!t->group_table)
-- 
2.39.5

