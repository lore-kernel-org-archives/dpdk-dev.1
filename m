Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB799D65C53
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 17:20:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDF30402D9;
	Wed, 17 Dec 2025 18:20:56 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1E20A4025A
 for <dev@dpdk.org>; Wed, 17 Dec 2025 18:20:56 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWgY94f0kzHnGjW
 for <dev@dpdk.org>; Thu, 18 Dec 2025 01:20:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 4099B40570
 for <dev@dpdk.org>; Thu, 18 Dec 2025 01:20:55 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 18:20:55 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <dev@dpdk.org>
Subject: [PATCH 0/2] bpf: add xchg and fix rte_bpf_dump
Date: Wed, 17 Dec 2025 17:20:34 +0000
Message-ID: <20251217172037.59170-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
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

Two patches that are not exectly functionally related, but one depends
on the other code-wise.

Atomic exchange is particularly useful since it can be used not just for
exchange per se, but also as atomic store.

Incidentally it was discovered that rte_bpf_dump does not support not
just atomics but also some other instructions.

Marat Khalili (2):
  bpf: add atomic xchg support
  bpf: dump additional instructions

 app/test/test_bpf.c     | 458 ++++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_def.h       |   5 +
 lib/bpf/bpf_dump.c      |  69 ++++--
 lib/bpf/bpf_exec.c      |  35 ++-
 lib/bpf/bpf_jit_arm64.c |  59 ++++--
 lib/bpf/bpf_jit_x86.c   |  37 +++-
 lib/bpf/bpf_validate.c  |  22 +-
 7 files changed, 636 insertions(+), 49 deletions(-)

-- 
2.43.0

