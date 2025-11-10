Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E61CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 15:31:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A627140280;
	Mon, 10 Nov 2025 16:31:27 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A4DC14026D
 for <dev@dpdk.org>; Mon, 10 Nov 2025 16:31:25 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4tt43TBvzHnH74;
 Mon, 10 Nov 2025 23:31:08 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id D8BAF140257;
 Mon, 10 Nov 2025 23:31:23 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 16:31:23 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: [PATCH 0/3] bpf: simple tests and fixes
Date: Mon, 10 Nov 2025 15:30:43 +0000
Message-ID: <20251110153046.63518-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500002.china.huawei.com (7.182.19.148) To
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

Add simple unit-style tests for rte_bpf_load, and fix some minor
discovered bugs.

Create new source file for new tests since app/test/test_bpf.c was
growing rather large, and tests there look more like functional rather
than unit ones.

Marat Khalili (3):
  bpf: fix signed shift overflows in ARM JIT
  bpf: disallow empty program
  bpf: make add/subtract one program validate

 app/test/meson.build       |   1 +
 app/test/test_bpf_simple.c | 189 +++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_jit_arm64.c    | 188 ++++++++++++++++++++----------------
 lib/bpf/bpf_load.c         |   2 +-
 lib/bpf/bpf_validate.c     |  28 ++++--
 5 files changed, 318 insertions(+), 90 deletions(-)
 create mode 100644 app/test/test_bpf_simple.c

-- 
2.43.0

