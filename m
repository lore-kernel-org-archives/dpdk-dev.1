Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E336CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:39:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F1A44067B;
	Wed,  6 May 2026 19:39:19 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 28B66402B9
 for <dev@dpdk.org>; Wed,  6 May 2026 19:39:16 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jK46pNrzHnGjS
 for <dev@dpdk.org>; Thu,  7 May 2026 01:38:16 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 1297840569
 for <dev@dpdk.org>; Thu,  7 May 2026 01:39:15 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:14 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>
Subject: [PATCH 00/25] bpf: test and fix issues in verifier
Date: Wed, 6 May 2026 18:38:18 +0100
Message-ID: <20260506173846.64914-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
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

This patchset addresses numerous bugs in the BPF verifier's abstract
interpretation logic and introduces a new validation debugger API to
enable precise, robust testing of the verifier itself.

While the existing DPDK eBPF verifier is capable of checking basic
execution graph loops and dead code, the mathematical tracking of
register bounds (both signed and unsigned) contained flaws resulting in
false positives and false negatives, undefined behavior, and hardware
exceptions such as SIGFPE during validation.

To resolve these issues and ensure they do not regress, this patchset
first introduces the "Validation Debugger API"
(`rte_bpf_validate_debug_*`). This gdb-like interface allows setting
breakpoints and catchpoints during the validation process to inspect the
verifier's internal state.

Using this new API, a comprehensive test harness
(`app/test/test_bpf_validate.c`) was created to formally check the
abstract domains of instructions across all their valid branches. The
remainder of the patchset incrementally fixes the math and bounds logic
for individual eBPF instructions, using the new tests to prove the
correctness of the fixes.

This debugger API also lays the foundation for an interactive eBPF
validation debugger to be introduced in the future.

Depends-on: series-38068 ("bpf: introduce extensible load API")

Marat Khalili (25):
  bpf: format and dump jlt, jle, jslt, and jsle
  bpf: add format instruction function
  bpf/validate: break on error in evaluate
  bpf/validate: expand comments in evaluate cycle
  bpf/validate: introduce debugging interface
  bpf/validate: fix BPF_ADD of pointer to a scalar
  bpf/validate: fix BPF_LDX | EBPF_DW signed range
  test/bpf_validate: add setup and basic tests
  test/bpf_validate: add harness for pointer tests
  bpf/validate: fix EBPF_JSLT | BPF_X evaluation
  bpf/validate: fix BPF_NEG of INT64_MIN and 0
  bpf/validate: fix BPF_DIV and BPF_MOD signed part
  bpf/validate: fix BPF_MUL ranges minimum typo
  bpf/validate: fix BPF_MUL signed overflow UB
  bpf/validate: fix BPF_JGT/EBPF_JSGT no-jump max
  bpf/validate: fix BPF_JMP source range calculation
  bpf/validate: fix BPF_JMP empty range handling
  bpf/validate: fix BPF_AND min calculations
  bpf/validate: fix BPF_LSH shift-out-of-bounds UB
  bpf/validate: fix BPF_OR min calculations
  bpf/validate: fix BPF_SUB signed max zero case
  bpf/validate: fix BPF_XOR signed min calculation
  bpf/validate: prevent overflow when building graph
  doc: add release notes for BPF validation fixes
  doc: add BPF validate debug to programmer's guide

 app/test/meson.build                   |    1 +
 app/test/test_bpf.c                    |   99 ++
 app/test/test_bpf_validate.c           | 2271 ++++++++++++++++++++++++
 doc/guides/prog_guide/bpf_lib.rst      |   31 +
 doc/guides/rel_notes/release_26_07.rst |   16 +
 lib/bpf/bpf_dump.c                     |  292 +--
 lib/bpf/bpf_validate.c                 |  730 +++++++-
 lib/bpf/bpf_validate.h                 |   54 +
 lib/bpf/bpf_validate_debug.c           |  663 +++++++
 lib/bpf/bpf_validate_debug.h           |   86 +
 lib/bpf/bpf_value_set.c                |  403 +++++
 lib/bpf/bpf_value_set.h                |  126 ++
 lib/bpf/meson.build                    |    9 +-
 lib/bpf/rte_bpf.h                      |   55 +
 lib/bpf/rte_bpf_validate_debug.h       |  377 ++++
 15 files changed, 5016 insertions(+), 197 deletions(-)
 create mode 100644 app/test/test_bpf_validate.c
 create mode 100644 lib/bpf/bpf_validate.h
 create mode 100644 lib/bpf/bpf_validate_debug.c
 create mode 100644 lib/bpf/bpf_validate_debug.h
 create mode 100644 lib/bpf/bpf_value_set.c
 create mode 100644 lib/bpf/bpf_value_set.h
 create mode 100644 lib/bpf/rte_bpf_validate_debug.h

-- 
2.43.0

