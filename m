Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC41C531C9
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Jul 2026 07:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E7AE40280;
	Sat, 25 Jul 2026 09:55:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4EB6440276
 for <dev@dpdk.org>; Sat, 25 Jul 2026 09:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784966104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VC5GS42lLHSWUMkwMkzwF+lQwhMbLCxe5XJtblEAD7I=;
 b=CMOOLv/9HvhjGpsQS15WCc9sD229czN6p/7uQ0SjeLsOlt2AhlhKTDiPIy49uXbyPGLdDH
 2yt/oPegHtJrVCcIrlAnC50fqJ55QMPCIVYcYH+YtaRQMWAMPzBZh2FWMqdYb172DaVQMx
 pw7BfsFaKD9qw5kzHTynKUy0Tgg0Lk0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-PJBN1SqJNPKlsmOwRdP-3w-1; Sat, 25 Jul 2026 03:55:02 -0400
X-MC-Unique: PJBN1SqJNPKlsmOwRdP-3w-1
X-Mimecast-MFC-AGG-ID: PJBN1SqJNPKlsmOwRdP-3w_1784966101
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aeb49bb645so712229e87.0
 for <dev@dpdk.org>; Sat, 25 Jul 2026 00:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784966100; x=1785570900;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VC5GS42lLHSWUMkwMkzwF+lQwhMbLCxe5XJtblEAD7I=;
 b=b3ZFskskQkYcVmxgs80FlTa5k41lDKru+vLUHjF87uP1czBAWAXuzUZQNfPVrTGSg6
 aH/nMWiv6kYUVkgSZnsudfnu6he76GvgTORzdTViHFF9/qZchtubok16VKLe6QVCBABg
 iSSAeIfCN9nn3GWrEULqSFB0tgnh5RZNX7IUKabaB3x7hYyJ6mLyKeaFYg0OLU3DZ6NP
 9UrK2pO8GKquR33rwOohBjIy5hzx7rFWR3IiA6K6xkljzXnoz7JLDo9De1sGSPMBWIG+
 RbuEIrpcgM55Zi09B49EUxJm0SqE9vWWXrkRchD0T99fkNwpAgRpqpbXHNft/yJa9reO
 ntLg==
X-Gm-Message-State: AOJu0YxGhMGluIXLLQ+Qpo0NwPF18J19er5dCWa7DMkrg1ztH5Ng6okS
 vzT+Bn0dzwN7ccBuElFSq6O12+KeV8Fq1c3FnizMMHTpADFJ3QAMBurGHDHgU0/xoiSbyUA9TcG
 opkaLvmKegUVKKG4Pvkih7scO7CjTmtPsYtT1NEP2hsYrjdSGqgcom716RQA3BRAynn4gHUdoNu
 FwQZ1Tg9d+xcRsv3CNNxZXERWwZkQ=
X-Gm-Gg: AR+sD12W5yEGY6wadT8TQQLES0iC4dhsIZPKYGst3gSASb5GLTjbuU5s4Ml3dyBrYzF
 e9wyfPu8wdIEhoMM/lpNa0M+L3FzeW3n0RPzo8Ic6KFxahFneq5mdP6S+n+N03kmyk8WNH/vRJs
 z0L6qfkS1aDlDnn3oUWuook47DE52RifQ34gn1/mIhyKdn2NkWLlkOASwjGv9G+zKll0fsx41o7
 dslnyaRCcEVwaewHI7bMH7BoJaKnmK/bmQUIOZjwK2YokSA
X-Received: by 2002:a05:6512:b9c:b0:5b0:12a4:2262 with SMTP id
 2adb3069b0e04-5b2c1b5c0bamr222394e87.59.1784966100547; 
 Sat, 25 Jul 2026 00:55:00 -0700 (PDT)
X-Received: by 2002:a05:6512:b9c:b0:5b0:12a4:2262 with SMTP id
 2adb3069b0e04-5b2c1b5c0bamr222390e87.59.1784966099906; Sat, 25 Jul 2026
 00:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260724164520.192203-1-stephen@networkplumber.org>
In-Reply-To: <20260724164520.192203-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 25 Jul 2026 09:54:48 +0200
X-Gm-Features: AUfX_mw49JkTN70-NYgomdUDI2ScY2WXhIsHANUgK3hW4BiD_OdtwbM4IMW3JEg
Message-ID: <CAJFAV8yyME96KxO3soWoGgQzqzRHvcxyvkBFcbA6jGNfAxU0ag@mail.gmail.com>
Subject: Re: [PATCH 0/6] remove legacy Packet Framework API
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1zC1qI1FLrhc_-eDzHsvb_iZAY16trCb2McjXzbWvI0_1784966101
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 24 Jul 2026 at 18:45, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The legacy Packet Framework APIs were announced for removal in the
> 24.11 release but the removal never happened:
>
> * pipeline: The pipeline library legacy API (functions rte_pipeline_*)
> * table: The table library legacy API (functions rte_table_*)
> * port: The port library legacy API (functions rte_port_*)
>
> Do the removal now, in the 26.11 ABI window. The SWX API in the same
> libraries (rte_swx_*) is unaffected and remains the Packet Framework
> API. The softnic driver and the pipeline example already use only the
> SWX API.
>
> The applications built on the legacy API (test-pipeline, ip_pipeline)
> and the unit tests are removed first, then the legacy half of each
> library, pipeline before table before port to follow the dependency
> chain. Library dependencies and the programmer's guide are trimmed
> accordingly.
>
> Follow-up candidates, kept out of this series: the stale comments in
> lib/ethdev/ethdev_trace.h still refer to examples/ip_pipeline, and
> struct rte_pipeline_acl_rule in the removed rte_table_acl.c was only
> a local name.
>
>
> Stephen Hemminger (6):
>   app/test: remove packet framework tests
>   app/test-pipeline: remove application
>   examples/ip_pipeline: remove example
>   pipeline: remove legacy API
>   table: remove legacy API
>   port: remove legacy API
>
>  MAINTAINERS                                   |    5 -
>  app/meson.build                               |    1 -
>  app/test-pipeline/config.c                    |  230 -
>  app/test-pipeline/init.c                      |  273 -
>  app/test-pipeline/main.c                      |  188 -
>  app/test-pipeline/main.h                      |  132 -
>  app/test-pipeline/meson.build                 |   21 -
>  app/test-pipeline/pipeline_acl.c              |  251 -
>  app/test-pipeline/pipeline_hash.c             |  471 --
>  app/test-pipeline/pipeline_lpm.c              |  175 -
>  app/test-pipeline/pipeline_lpm_ipv6.c         |  168 -
>  app/test-pipeline/pipeline_stub.c             |  137 -
>  app/test-pipeline/runtime.c                   |  160 -
>  app/test/meson.build                          |    6 -
>  app/test/test_table.c                         |  209 -
>  app/test/test_table.h                         |  184 -
>  app/test/test_table_acl.c                     |  728 --
>  app/test/test_table_acl.h                     |    6 -
>  app/test/test_table_combined.c                |  846 --
>  app/test/test_table_combined.h                |   27 -
>  app/test/test_table_pipeline.c                |  575 --
>  app/test/test_table_pipeline.h                |    6 -
>  app/test/test_table_ports.c                   |  195 -
>  app/test/test_table_ports.h                   |   13 -
>  app/test/test_table_tables.c                  | 1058 ---
>  app/test/test_table_tables.h                  |   22 -
>  doc/api/doxy-api-index.md                     |   17 -
>  doc/guides/nics/softnic.rst                   |    3 +-
>  doc/guides/prog_guide/img/figure32.png        |  Bin 11603 -> 0 bytes
>  doc/guides/prog_guide/img/figure33.png        |  Bin 65216 -> 0 bytes
>  doc/guides/prog_guide/img/figure34.png        |  Bin 11581 -> 0 bytes
>  doc/guides/prog_guide/img/figure35.png        |  Bin 75012 -> 0 bytes
>  doc/guides/prog_guide/img/figure37.png        |  Bin 6934 -> 0 bytes
>  doc/guides/prog_guide/img/figure38.png        |  Bin 7372 -> 0 bytes
>  doc/guides/prog_guide/img/figure39.png        |  Bin 55986 -> 0 bytes
>  doc/guides/prog_guide/packet_framework.rst    | 1146 +--
>  doc/guides/rel_notes/deprecation.rst          |   15 -
>  doc/guides/rel_notes/release_26_11.rst        |   17 +
>  .../sample_app_ug/img/test_pipeline_app.png   |  Bin 67410 -> 0 bytes
>  doc/guides/sample_app_ug/index.rst            |    2 -
>  doc/guides/sample_app_ug/ip_pipeline.rst      |  531 --
>  doc/guides/sample_app_ug/test_pipeline.rst    |  237 -
>  examples/ip_pipeline/Makefile                 |   60 -
>  examples/ip_pipeline/action.c                 |  391 -
>  examples/ip_pipeline/action.h                 |   78 -
>  examples/ip_pipeline/cli.c                    | 6791 -----------------
>  examples/ip_pipeline/cli.h                    |   18 -
>  examples/ip_pipeline/common.h                 |   12 -
>  examples/ip_pipeline/conn.c                   |  330 -
>  examples/ip_pipeline/conn.h                   |   47 -
>  examples/ip_pipeline/cryptodev.c              |  160 -
>  examples/ip_pipeline/cryptodev.h              |   46 -
>  examples/ip_pipeline/examples/firewall.cli    |   59 -
>  examples/ip_pipeline/examples/flow.cli        |   60 -
>  examples/ip_pipeline/examples/flow_crypto.cli |   57 -
>  examples/ip_pipeline/examples/l2fwd.cli       |   51 -
>  examples/ip_pipeline/examples/route.cli       |   60 -
>  examples/ip_pipeline/examples/route_ecmp.cli  |   57 -
>  examples/ip_pipeline/examples/rss.cli         |  112 -
>  examples/ip_pipeline/examples/tap.cli         |   66 -
>  examples/ip_pipeline/link.c                   |  270 -
>  examples/ip_pipeline/link.h                   |   66 -
>  examples/ip_pipeline/main.c                   |  260 -
>  examples/ip_pipeline/mempool.c                |   82 -
>  examples/ip_pipeline/mempool.h                |   40 -
>  examples/ip_pipeline/meson.build              |   30 -
>  examples/ip_pipeline/parser.c                 |  506 --
>  examples/ip_pipeline/parser.h                 |   56 -
>  examples/ip_pipeline/pipeline.c               | 1078 ---
>  examples/ip_pipeline/pipeline.h               |  425 --
>  examples/ip_pipeline/swq.c                    |   76 -
>  examples/ip_pipeline/swq.h                    |   37 -
>  examples/ip_pipeline/tap.c                    |  102 -
>  examples/ip_pipeline/tap.h                    |   29 -
>  examples/ip_pipeline/thread.c                 | 3137 --------
>  examples/ip_pipeline/thread.h                 |   24 -
>  examples/ip_pipeline/tmgr.c                   |  248 -
>  examples/ip_pipeline/tmgr.h                   |   74 -
>  examples/meson.build                          |    1 -
>  lib/pipeline/meson.build                      |    8 +-
>  lib/pipeline/rte_pipeline.c                   | 1640 ----
>  lib/pipeline/rte_pipeline.h                   |  840 --
>  lib/pipeline/rte_port_in_action.c             |  539 --
>  lib/pipeline/rte_port_in_action.h             |  311 -
>  lib/pipeline/rte_table_action.c               | 3483 ---------
>  lib/pipeline/rte_table_action.h               | 1137 ---
>  lib/port/meson.build                          |   22 +-
>  lib/port/port_log.c                           |    7 -
>  lib/port/port_log.h                           |   11 -
>  lib/port/rte_port.h                           |  223 -
>  lib/port/rte_port_ethdev.c                    |  530 --
>  lib/port/rte_port_ethdev.h                    |   75 -
>  lib/port/rte_port_eventdev.c                  |  590 --
>  lib/port/rte_port_eventdev.h                  |   94 -
>  lib/port/rte_port_fd.c                        |  524 --
>  lib/port/rte_port_fd.h                        |   74 -
>  lib/port/rte_port_frag.c                      |  280 -
>  lib/port/rte_port_frag.h                      |   70 -
>  lib/port/rte_port_ras.c                       |  336 -
>  lib/port/rte_port_ras.h                       |   58 -
>  lib/port/rte_port_ring.c                      |  796 --
>  lib/port/rte_port_ring.h                      |   91 -
>  lib/port/rte_port_sched.c                     |  298 -
>  lib/port/rte_port_sched.h                     |   52 -
>  lib/port/rte_port_source_sink.c               |  616 --
>  lib/port/rte_port_source_sink.h               |   57 -
>  lib/port/rte_port_sym_crypto.c                |  558 --
>  lib/port/rte_port_sym_crypto.h                |   92 -
>  lib/table/meson.build                         |   30 +-
>  lib/table/rte_lru.h                           |   85 -
>  lib/table/rte_lru_arm64.h                     |   61 -
>  lib/table/rte_lru_x86.h                       |   96 -
>  lib/table/rte_table.h                         |  263 -
>  lib/table/rte_table_acl.c                     |  795 --
>  lib/table/rte_table_acl.h                     |   65 -
>  lib/table/rte_table_array.c                   |  210 -
>  lib/table/rte_table_array.h                   |   46 -
>  lib/table/rte_table_hash.h                    |  106 -
>  lib/table/rte_table_hash_cuckoo.c             |  327 -
>  lib/table/rte_table_hash_cuckoo.h             |   57 -
>  lib/table/rte_table_hash_ext.c                | 1011 ---
>  lib/table/rte_table_hash_func.h               |  263 -
>  lib/table/rte_table_hash_func_arm64.h         |   21 -
>  lib/table/rte_table_hash_key16.c              | 1190 ---
>  lib/table/rte_table_hash_key32.c              | 1223 ---
>  lib/table/rte_table_hash_key8.c               | 1157 ---
>  lib/table/rte_table_hash_lru.c                |  959 ---
>  lib/table/rte_table_lpm.c                     |  369 -
>  lib/table/rte_table_lpm.h                     |   94 -
>  lib/table/rte_table_lpm_ipv6.c                |  370 -
>  lib/table/rte_table_lpm_ipv6.h                |   95 -
>  lib/table/rte_table_stub.c                    |   95 -
>  lib/table/rte_table_stub.h                    |   30 -
>  lib/table/table_log.c                         |    7 -
>  lib/table/table_log.h                         |   11 -
>  135 files changed, 27 insertions(+), 45472 deletions(-)
>  delete mode 100644 app/test-pipeline/config.c
>  delete mode 100644 app/test-pipeline/init.c
>  delete mode 100644 app/test-pipeline/main.c
>  delete mode 100644 app/test-pipeline/main.h
>  delete mode 100644 app/test-pipeline/meson.build
>  delete mode 100644 app/test-pipeline/pipeline_acl.c
>  delete mode 100644 app/test-pipeline/pipeline_hash.c
>  delete mode 100644 app/test-pipeline/pipeline_lpm.c
>  delete mode 100644 app/test-pipeline/pipeline_lpm_ipv6.c
>  delete mode 100644 app/test-pipeline/pipeline_stub.c
>  delete mode 100644 app/test-pipeline/runtime.c
>  delete mode 100644 app/test/test_table.c
>  delete mode 100644 app/test/test_table.h
>  delete mode 100644 app/test/test_table_acl.c
>  delete mode 100644 app/test/test_table_acl.h
>  delete mode 100644 app/test/test_table_combined.c
>  delete mode 100644 app/test/test_table_combined.h
>  delete mode 100644 app/test/test_table_pipeline.c
>  delete mode 100644 app/test/test_table_pipeline.h
>  delete mode 100644 app/test/test_table_ports.c
>  delete mode 100644 app/test/test_table_ports.h
>  delete mode 100644 app/test/test_table_tables.c
>  delete mode 100644 app/test/test_table_tables.h
>  delete mode 100644 doc/guides/prog_guide/img/figure32.png
>  delete mode 100644 doc/guides/prog_guide/img/figure33.png
>  delete mode 100644 doc/guides/prog_guide/img/figure34.png
>  delete mode 100644 doc/guides/prog_guide/img/figure35.png
>  delete mode 100644 doc/guides/prog_guide/img/figure37.png
>  delete mode 100644 doc/guides/prog_guide/img/figure38.png
>  delete mode 100644 doc/guides/prog_guide/img/figure39.png
>  delete mode 100644 doc/guides/sample_app_ug/img/test_pipeline_app.png
>  delete mode 100644 doc/guides/sample_app_ug/ip_pipeline.rst
>  delete mode 100644 doc/guides/sample_app_ug/test_pipeline.rst
>  delete mode 100644 examples/ip_pipeline/Makefile
>  delete mode 100644 examples/ip_pipeline/action.c
>  delete mode 100644 examples/ip_pipeline/action.h
>  delete mode 100644 examples/ip_pipeline/cli.c
>  delete mode 100644 examples/ip_pipeline/cli.h
>  delete mode 100644 examples/ip_pipeline/common.h
>  delete mode 100644 examples/ip_pipeline/conn.c
>  delete mode 100644 examples/ip_pipeline/conn.h
>  delete mode 100644 examples/ip_pipeline/cryptodev.c
>  delete mode 100644 examples/ip_pipeline/cryptodev.h
>  delete mode 100644 examples/ip_pipeline/examples/firewall.cli
>  delete mode 100644 examples/ip_pipeline/examples/flow.cli
>  delete mode 100644 examples/ip_pipeline/examples/flow_crypto.cli
>  delete mode 100644 examples/ip_pipeline/examples/l2fwd.cli
>  delete mode 100644 examples/ip_pipeline/examples/route.cli
>  delete mode 100644 examples/ip_pipeline/examples/route_ecmp.cli
>  delete mode 100644 examples/ip_pipeline/examples/rss.cli
>  delete mode 100644 examples/ip_pipeline/examples/tap.cli
>  delete mode 100644 examples/ip_pipeline/link.c
>  delete mode 100644 examples/ip_pipeline/link.h
>  delete mode 100644 examples/ip_pipeline/main.c
>  delete mode 100644 examples/ip_pipeline/mempool.c
>  delete mode 100644 examples/ip_pipeline/mempool.h
>  delete mode 100644 examples/ip_pipeline/meson.build
>  delete mode 100644 examples/ip_pipeline/parser.c
>  delete mode 100644 examples/ip_pipeline/parser.h
>  delete mode 100644 examples/ip_pipeline/pipeline.c
>  delete mode 100644 examples/ip_pipeline/pipeline.h
>  delete mode 100644 examples/ip_pipeline/swq.c
>  delete mode 100644 examples/ip_pipeline/swq.h
>  delete mode 100644 examples/ip_pipeline/tap.c
>  delete mode 100644 examples/ip_pipeline/tap.h
>  delete mode 100644 examples/ip_pipeline/thread.c
>  delete mode 100644 examples/ip_pipeline/thread.h
>  delete mode 100644 examples/ip_pipeline/tmgr.c
>  delete mode 100644 examples/ip_pipeline/tmgr.h
>  delete mode 100644 lib/pipeline/rte_pipeline.c
>  delete mode 100644 lib/pipeline/rte_pipeline.h
>  delete mode 100644 lib/pipeline/rte_port_in_action.c
>  delete mode 100644 lib/pipeline/rte_port_in_action.h
>  delete mode 100644 lib/pipeline/rte_table_action.c
>  delete mode 100644 lib/pipeline/rte_table_action.h
>  delete mode 100644 lib/port/port_log.c
>  delete mode 100644 lib/port/port_log.h
>  delete mode 100644 lib/port/rte_port.h
>  delete mode 100644 lib/port/rte_port_ethdev.c
>  delete mode 100644 lib/port/rte_port_ethdev.h
>  delete mode 100644 lib/port/rte_port_eventdev.c
>  delete mode 100644 lib/port/rte_port_eventdev.h
>  delete mode 100644 lib/port/rte_port_fd.c
>  delete mode 100644 lib/port/rte_port_fd.h
>  delete mode 100644 lib/port/rte_port_frag.c
>  delete mode 100644 lib/port/rte_port_frag.h
>  delete mode 100644 lib/port/rte_port_ras.c
>  delete mode 100644 lib/port/rte_port_ras.h
>  delete mode 100644 lib/port/rte_port_ring.c
>  delete mode 100644 lib/port/rte_port_ring.h
>  delete mode 100644 lib/port/rte_port_sched.c
>  delete mode 100644 lib/port/rte_port_sched.h
>  delete mode 100644 lib/port/rte_port_source_sink.c
>  delete mode 100644 lib/port/rte_port_source_sink.h
>  delete mode 100644 lib/port/rte_port_sym_crypto.c
>  delete mode 100644 lib/port/rte_port_sym_crypto.h
>  delete mode 100644 lib/table/rte_lru.h
>  delete mode 100644 lib/table/rte_lru_arm64.h
>  delete mode 100644 lib/table/rte_lru_x86.h
>  delete mode 100644 lib/table/rte_table.h
>  delete mode 100644 lib/table/rte_table_acl.c
>  delete mode 100644 lib/table/rte_table_acl.h
>  delete mode 100644 lib/table/rte_table_array.c
>  delete mode 100644 lib/table/rte_table_array.h
>  delete mode 100644 lib/table/rte_table_hash.h
>  delete mode 100644 lib/table/rte_table_hash_cuckoo.c
>  delete mode 100644 lib/table/rte_table_hash_cuckoo.h
>  delete mode 100644 lib/table/rte_table_hash_ext.c
>  delete mode 100644 lib/table/rte_table_hash_func.h
>  delete mode 100644 lib/table/rte_table_hash_func_arm64.h
>  delete mode 100644 lib/table/rte_table_hash_key16.c
>  delete mode 100644 lib/table/rte_table_hash_key32.c
>  delete mode 100644 lib/table/rte_table_hash_key8.c
>  delete mode 100644 lib/table/rte_table_hash_lru.c
>  delete mode 100644 lib/table/rte_table_lpm.c
>  delete mode 100644 lib/table/rte_table_lpm.h
>  delete mode 100644 lib/table/rte_table_lpm_ipv6.c
>  delete mode 100644 lib/table/rte_table_lpm_ipv6.h
>  delete mode 100644 lib/table/rte_table_stub.c
>  delete mode 100644 lib/table/rte_table_stub.h
>  delete mode 100644 lib/table/table_log.c
>  delete mode 100644 lib/table/table_log.h

Sorry, it seems this series (and only this series iiuc) fell through
the cracks while patchwork and other dpdk.org services were under
heavy load...
Could you resend?


-- 
David Marchand

