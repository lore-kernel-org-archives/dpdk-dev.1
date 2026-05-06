Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C58CD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:41:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B40A40E72;
	Wed,  6 May 2026 19:39:44 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6957240A6E;
 Wed,  6 May 2026 19:39:24 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jL263r3zJ46ZC;
 Thu,  7 May 2026 01:39:06 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 4D87440569;
 Thu,  7 May 2026 01:39:24 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:23 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 23/25] bpf/validate: prevent overflow when building graph
Date: Wed, 6 May 2026 18:38:41 +0100
Message-ID: <20260506173846.64914-24-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506173846.64914-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500008.china.huawei.com (7.182.19.65) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Function `evst_pool_init` for malicious or corrupt BPF program with
number of conditional jumps exceeding a third of UINT32_MAX could cause
arithmetic and buffer overflows when working with the program graph.

Fix the issue by limiting maximum number of conditional jumps supported
by UINT32_MAX / 4, or more than 1 billion.

Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 35b7d4ad83f6..23311a36d14e 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2662,6 +2662,10 @@ evst_pool_init(struct bpf_verifier *bvf)
 {
 	uint32_t k, n;
 
+	if (bvf->nb_jcc_nodes > UINT32_MAX / 4)
+		/* Calculations that follow may overflow. */
+		return -E2BIG;
+
 	/*
 	 * We need nb_jcc_nodes + 1 for save_cur/restore_cur
 	 * remaining ones will be used for state tracking/pruning.
-- 
2.43.0

