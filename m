Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CF0D2F000
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 11:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24D29402CE;
	Tue, 27 Jan 2026 12:50:22 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BAC17400D6
 for <dev@dpdk.org>; Tue, 27 Jan 2026 12:50:20 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0kGb4XBNzJ46Yf;
 Tue, 27 Jan 2026 19:49:43 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 807B540584;
 Tue, 27 Jan 2026 19:50:19 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Jan 2026 12:50:19 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <dev@dpdk.org>
CC: <jerinjacobk@gmail.com>, <konstantin.ananyev@huawei.com>,
 <mb@smartsharesystems.com>, <stephen@networkplumber.org>
Subject: [PATCH v4 0/6] bpf: simple tests and fixes
Date: Tue, 27 Jan 2026 11:49:36 +0000
Message-ID: <20260127114944.35993-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217180141.60227-1-marat.khalili@huawei.com>
References: <20251217180141.60227-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500005.china.huawei.com (7.182.19.99) To
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

v4:
* Add Fixes: and Cc: stable@dpdk.org tags to all patches except 3. Try
  to make sure stable@dpdk.org does not receive patch 3.
* Ensure no (possibly hallucinated) trailing whitespace after Acked-by.
* Improve subject line for the "conditional jump first" patch.
* Update REGISTER_FAST_TEST() calls in app/test/test_bpf.c to use new
  constants (NOHUGE_OK, ASAN_OK) instead of old boolean values.

v3:
* Fixed unfortunate typos in the last patch commit message.
* Marked all ARM opcodes with UINT32_C for clarity as suggested by
  Morten Brørup, in a separate commit.

v2:
* Moved new tests back into test_bpf.c
* Changed library macros RTE_SHIFT_VALxx to handle variable first
  arguments instead of introducing new macros.
* Added another test and fix, for conditional jump as first instruction.

Marat Khalili (6):
  eal: variable first arguments of RTE_SHIFT_VALxx
  bpf: fix signed shift overflows in ARM JIT
  bpf: mark ARM opcodes with UINT32_C
  bpf: disallow empty program
  bpf: make add/subtract one program validate
  bpf: fix validation when conditional jump is first instruction

 app/test/test_bpf.c          | 254 +++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_jit_arm64.c      | 184 ++++++++++++-------------
 lib/bpf/bpf_load.c           |   2 +-
 lib/bpf/bpf_validate.c       |  48 ++++---
 lib/eal/include/rte_bitops.h |   4 +-
 5 files changed, 375 insertions(+), 117 deletions(-)

-- 
2.34.1
