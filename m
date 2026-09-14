Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E843BC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:56:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E693240DD7;
	Mon, 14 Sep 2026 16:56:20 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 15EE440A87
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:56:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=l7PkOTRp9e3PT1uDj/EoDTtul+z8gngxRPwcQYw4tE4=;
 b=iOwTuCZmOI0zMx8fQlr887Iw8+nqs6/+NSP7eh1rGuouMsAE4c4llUwEC88axV7i+hgi4AkEN
 7CqLUlh1eNJSXyo/KvuFNXuas4zRwzre2DTsh2bZTTMZxhVME7BBoNm9jQ+IfINMOQt1x3Yp4kN
 iWlo9WeoioXvn69Wb9/Npek=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hk7WX5XHwzHnH4V
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:56:08 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 7AC554058B
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:56:19 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 16:56:19 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>
Subject: [PATCH v2 0/7] validate-bpf: add standalone validation debug tool
Date: Mon, 14 Sep 2026 15:54:10 +0100
Message-ID: <20260914145418.37353-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911104006.34364-1-marat.khalili@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
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

This patchset introduces a new standalone tool for pre-validating eBPF
programs and debugging validation problems. Its should allow developers
to trace validator state changes per instruction and understand verifier
decisions, simplifying the debugging of rejected programs before loading
them into a real application context.

v2:
* for FreeBSD compatibility switched from Linux to DPDK network structs;
* addressed small AI comments:
  * clarified patch 1 commit message;
  * renamed `rte_validate_bpf_logtype` to `validate_bpf_logtype`;
  * corrected comment to an internal-use-only function to reflect that
    next-after-last value of the program counter is no longer allowed;

Marat Khalili (7):
  bpf/validate: fix finished status on restart
  bpf/validate: refactor internal step function
  bpf/validate: formalize call back requirements
  bpf/validate: add jump notification events
  bpf/validate: add get current event API
  app/test: add test for bpf validate debug events
  app/validate-bpf: add BPF validation application

 MAINTAINERS                            |    2 +
 app/meson.build                        |    1 +
 app/test/test_bpf_validate.c           |  341 +++++++-
 app/validate-bpf/alloc_list.c          |   53 ++
 app/validate-bpf/args.c                |  263 ++++++
 app/validate-bpf/debug.c               | 1099 ++++++++++++++++++++++++
 app/validate-bpf/debug_command.c       |  383 +++++++++
 app/validate-bpf/debug_command.h       |   65 ++
 app/validate-bpf/eal_init_args.c       |   57 ++
 app/validate-bpf/internal.h            |  151 ++++
 app/validate-bpf/main.c                |   77 ++
 app/validate-bpf/meson.build           |   13 +
 app/validate-bpf/parse_decl.c          |  611 +++++++++++++
 doc/guides/rel_notes/release_26_11.rst |    5 +
 doc/guides/tools/index.rst             |    1 +
 doc/guides/tools/validate_bpf.rst      |   97 +++
 lib/bpf/bpf_validate.c                 |   49 +-
 lib/bpf/bpf_validate_debug.c           |   92 +-
 lib/bpf/bpf_validate_debug.h           |   12 +-
 lib/bpf/rte_bpf_validate_debug.h       |   42 +-
 20 files changed, 3348 insertions(+), 66 deletions(-)
 create mode 100644 app/validate-bpf/alloc_list.c
 create mode 100644 app/validate-bpf/args.c
 create mode 100644 app/validate-bpf/debug.c
 create mode 100644 app/validate-bpf/debug_command.c
 create mode 100644 app/validate-bpf/debug_command.h
 create mode 100644 app/validate-bpf/eal_init_args.c
 create mode 100644 app/validate-bpf/internal.h
 create mode 100644 app/validate-bpf/main.c
 create mode 100644 app/validate-bpf/meson.build
 create mode 100644 app/validate-bpf/parse_decl.c
 create mode 100644 doc/guides/tools/validate_bpf.rst

-- 
2.43.0

