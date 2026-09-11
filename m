Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F21C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 10:41:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEB7242DD9;
	Fri, 11 Sep 2026 12:41:22 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 54B2640269
 for <dev@dpdk.org>; Fri, 11 Sep 2026 12:41:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=o5qD/4KGClQ1rWobvkGJGUY2t0OQOrQ6UkeUFwp31l4=;
 b=J1sqVsyqeICS4dVoCGXDNQnIYa3DS4XI1MqnxyeBbRm4wTjrCKCWailULI9Xw8hmO44YmjIz3
 ZZyHh5uDNCw1MXhRAyOCk0+kfWaVZskx+5KRJI/X/QZoY5AiUf428s5zOiyCsNx8U8suZ+/xUJR
 DpNVp9+IggvRubzykVMgfbA=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hhB0m0BYSzHnGkX
 for <dev@dpdk.org>; Fri, 11 Sep 2026 18:41:12 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 639DE40584
 for <dev@dpdk.org>; Fri, 11 Sep 2026 18:41:16 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 12:41:16 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>
Subject: [PATCH 0/7] validate-bpf: add standalone validation debug tool
Date: Fri, 11 Sep 2026 11:39:58 +0100
Message-ID: <20260911104006.34364-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patchset introduces a new standalone tool for pre-validating eBPF
programs and debugging validation problems. Its should allow developers
to trace validator state changes per instruction and understand verifier
decisions, simplifying the debugging of rejected programs before loading
them into a real application context.

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
 lib/bpf/bpf_validate_debug.h           |   10 +-
 lib/bpf/rte_bpf_validate_debug.h       |   42 +-
 20 files changed, 3347 insertions(+), 65 deletions(-)
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

