Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E0ACD8CA8
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 10:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22F46434C8;
	Fri, 12 Jun 2026 12:48:09 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 61825434C6
 for <dev@dpdk.org>; Fri, 12 Jun 2026 12:48:08 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gcGSb419hzHnGhl
 for <dev@dpdk.org>; Fri, 12 Jun 2026 18:47:59 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id CA1A040569
 for <dev@dpdk.org>; Fri, 12 Jun 2026 18:48:07 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 12:48:07 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3 01/25] bpf: format and dump jlt, jle, jslt, and jsle
Date: Fri, 12 Jun 2026 11:47:15 +0100
Message-ID: <20260612104743.6465-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612104743.6465-1-marat.khalili@huawei.com>
References: <20260519093131.52022-1-marat.khalili@huawei.com>
 <20260612104743.6465-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100001.china.huawei.com (7.182.19.23) To
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

Signed and unsigned less and less-then conditional jumps were not
supported by the eBPF format and dump functions, add these instructions.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38434 ("bpf: introduce extensible load API")
 lib/bpf/bpf_dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bpf/bpf_dump.c b/lib/bpf/bpf_dump.c
index 91bc7c0a7af1..0abaeef8ae98 100644
--- a/lib/bpf/bpf_dump.c
+++ b/lib/bpf/bpf_dump.c
@@ -42,6 +42,8 @@ static const char *const jump_tbl[16] = {
 	[BPF_JSET >> 4] = "jset",  [EBPF_JNE >> 4] = "jne",
 	[EBPF_JSGT >> 4] = "jsgt", [EBPF_JSGE >> 4] = "jsge",
 	[EBPF_CALL >> 4] = "call", [EBPF_EXIT >> 4] = "exit",
+	[EBPF_JLT >> 4] = "jlt",   [EBPF_JLE >> 4] = "jle",
+	[EBPF_JSLT >> 4] = "jslt", [EBPF_JSLE >> 4] = "jsle",
 };
 
 static inline const char *
-- 
2.43.0

