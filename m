Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B793ECCF2DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 08:27:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3EDA40430;
	Mon, 19 Oct 2026 10:27:42 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 4EFC140269;
 Mon, 19 Oct 2026 10:27:41 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=nCpIUni3FECjJh+m1S1JTYgXmQwBGrFyTSSgvRQqN70=;
 b=Q/CC3jS/zGRiAxvey6MbNWE2NQ8Lxli/T+bs/09+rs5vBp4Hq5IGH8oJiCke3xtjGrwc4gKRn
 0f8h7/+4eqP9Px+1KOCUrOUKgmitxhJunQJf96NeEgFyDpLWvG9J2CkRBp5acpv1q2KKj0ckF1d
 7Hlnz7VP59ItIDTlqzduf14=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4j7TF12kckz1K9Bd;
 Mon, 19 Oct 2026 16:27:33 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 1AC4040586;
 Mon, 19 Oct 2026 16:27:36 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 16:27:35 +0800
Message-ID: <a22ba926-ab45-4f57-b173-a5dd92b190b2@huawei.com>
Date: Mon, 19 Oct 2026 16:27:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: |WARNING| argparse: support range step for corelist parsing
To: <dpdklab@iol.unh.edu>, <test-report@dpdk.org>
References: <<20261016093001.9067-1-fengchengwen@huawei.com>
 <20261016100926.06D096051830@postal.iol.unh.edu>
Content-Language: en-US
CC: "dev@dpdk.org" <dev@dpdk.org>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261016100926.06D096051830@postal.iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 10/16/2026 6:09 PM, dpdklab@iol.unh.edu wrote:
> Test-Label: ai-code-review
> Test-Status: WARNING
> https://dpdk.org/patch/171477
> 
> _AI Code Review_
> 
> === Patch Review: series.patch (via Claude) ===
> Review date: 2026-10-16
> 
> # DPDK Patch Review
> 
> ## Patch: argparse: support range step for corelist parsing
> 
> This patch adds stride/step syntax (`start-end:step`) to the EAL corelist parser to help users skip sibling cores more easily (e.g., `-l 0-126:2` instead of `-l 0,2,4,6...126`).
> 
> ---
> 
> ## ERRORS
> 
> None identified.
> 
> ---
> 
> ## WARNINGS
> 
> ### 1. Missing release notes update
> 
> The patch adds new API functionality (range step syntax in corelist parsing) but does not update the release notes.
> 
> **Location:** No changes to `doc/guides/rel_notes/release_*.rst`
> 
> **Why it matters:** User-visible feature additions require release notes per DPDK guidelines.
> 
> **Suggested fix:** Add a feature note in the current release notes file under the appropriate section:
> 
> ```rst
> * **argparse: Added step syntax for corelist ranges.**
> 
>   The corelist parser now supports stride/step syntax for core ranges.
>   For example, ``-l 0-126:2`` selects cores 0, 2, 4, ..., 126.
>   This is useful for skipping sibling cores on systems with SMT/hyperthreading.

OK, will done in v2

> ```
> 
> ---
> 
> ### 2. Test coverage: missing zero-step test case
> 
> The patch adds validation that step must be positive (`if (idx == 0)`) but does not include a test case for step=0.
> 
> **Location:** `app/test/test_argparse.c` line 605-613 validates step > 0, but no test exercises `"1-5:0"`.
> 
> **Why it matters:** Untested error paths may hide bugs. The zero-step case is explicitly rejected in code but not verified in the test suite.
> 
> **Suggested fix:** Add a test case:
> 
> ```c
> char *corelist_invalid_range_step_zero = test_strdup("1-5:0");
> /* ... later in test ... */
> CPU_ZERO(&val_cpuset);
> ret = rte_argparse_parse_type(corelist_invalid_range_step_zero,
>         RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
> TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step zero) should have failed!");
> ```

OK, will done in v2

> 
> ---
> 
> ## INFO
> 
> ### 1. Code clarity: `max` variable initialization
> 
> The patch changes `max` from a local variable declared inside the loop (`int32_t max;`) to a variable declared at function scope and initialized to `-1`.
> 
> **Location:** `lib/argparse/rte_argparse.c:578` and line 590 (removed local declaration)
> 
> **Observation:** This is correct. The variable needs to persist across loop iterations for the new step logic. The change does not introduce a bug and improves correctness.
> 
> ---
> 
> ### 2. Documentation matches implementation
> 
> The documentation in `doc/guides/prog_guide/argparse_lib.rst` accurately describes the new step syntax with examples. Cross-checked against the implementation logic.
> 
> ---
> 
> ### 3. Test coverage is comprehensive
> 
> The test suite covers:
> - Valid step syntax: `1-5:2`, mixed with commas, reverse ranges with step
> - Invalid cases: incomplete step syntax, double colons, negative step, extra colons
> - Edge cases: step larger than range size (e.g., `12-16:3` correctly sets 12, 15)
> 
> The tests verify both that cores in range are set and cores outside range are not set, which is thorough.
> 
> ---
> 
> ### 4. Variable naming: `is_step` boolean
> 
> The patch introduces `bool is_step` at line 576. This follows DPDK guidelines for boolean variable naming (using `bool` from `<stdbool.h>`).

The original rte_argparse library already include <stdbool.h> in rte_argparse.h

> 
> ---
> 
> Review-Result: WARNING

