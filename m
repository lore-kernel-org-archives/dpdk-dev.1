Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F691D5E13D
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 18:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E505402AC;
	Tue, 16 Dec 2025 19:21:08 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 4FD184026D;
 Tue, 16 Dec 2025 19:21:06 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dW4x0464VzJ46CH;
 Wed, 17 Dec 2025 02:20:36 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id AE46140539;
 Wed, 17 Dec 2025 02:21:04 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Dec 2025 19:21:04 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <stephen@networkplumber.org>, <jerinjacobk@gmail.com>,
 <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 0/5] bpf: simple tests and fixes
Date: Tue, 16 Dec 2025 18:20:30 +0000
Message-ID: <20251216182036.77869-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110153046.63518-1-marat.khalili@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100005.china.huawei.com (7.182.19.229) To
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

v2:
* Moved new tests back into test_bpf.c
* Changed library macros RTE_SHIFT_VALxx to handle variable first
  arguments instead of introducing new macros.
* Added another test and fix, for conditional jump as first instruction.

Marat Khalili (5):
  eal: variable first arguments of RTE_SHIFT_VALxx
  bpf: fix signed shift overflows in ARM JIT
  bpf: disallow empty program
  bpf: make add/subtract one program validate
  bpf: fix BPF validation w/ conditional jump first

 app/test/test_bpf.c          | 254 +++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_jit_arm64.c      | 162 +++++++++++-----------
 lib/bpf/bpf_load.c           |   2 +-
 lib/bpf/bpf_validate.c       |  48 ++++---
 lib/eal/include/rte_bitops.h |   4 +-
 5 files changed, 364 insertions(+), 106 deletions(-)

-- 
2.43.0

