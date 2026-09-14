Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216CC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:56:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B823540E4F;
	Mon, 14 Sep 2026 16:56:23 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9086A40DD7
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:56:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=rmYc5f1qLHU8avc23429k60UO4ZqlIuFBUPlmfDyUFc=;
 b=nCSj/UmQ3ReYLvcTav3CVtHG4WX2r4djU6JGRtyOUpV5dCUmOZmnqQeIUbQ4y5Ggpnoxlb0gh
 DaCXMUnkPCkJbJibKP85Y2sNmrfJDJqxPN/4oZLgMVuat+w7gk7EyrG/Fz6sYqym1PxObckUNfA
 9fSh8pqwIik5vk33mrQHtUg=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hk7Vm3qrbzJ46Y8
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:55:28 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id E30304058B
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:56:19 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 16:56:19 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 1/7] bpf/validate: fix finished status on restart
Date: Mon, 14 Sep 2026 15:54:11 +0100
Message-ID: <20260914145418.37353-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914145418.37353-1-marat.khalili@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
 <20260914145418.37353-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100006.china.huawei.com (7.182.19.111) To
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

If debug session is reused, requesting evaluation result while
evaluation is still in progress would successfully return result from
the previous evaluation instead of expected -EAGAIN error.

Make evaluation start clear the finished status.

Fixes: 6b0da0602cc7 ("bpf/validate: introduce debugging interface")

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate_debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index 5d18804a74bc..9a039766322c 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -568,6 +568,7 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
 	debug->last_point = NULL;
 	debug->pc = 0;
 	debug->evaluate_started = true;
+	debug->evaluate_finished = false;
 
 	const int rc = debug_send_event(debug,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START);
-- 
2.43.0

