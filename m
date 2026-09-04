Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16247C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 12:13:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1717A42FC3;
	Fri,  4 Sep 2026 14:13:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7957D42FBB
 for <dev@dpdk.org>; Fri,  4 Sep 2026 14:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788523999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=diU5OTOS3aQtZB/vwUjLTKy91Ea37u259uCZRmmkCd0=;
 b=ArpFYlUNvUGm1ePIPjSritMBqQcrkvFqBFkLIgEH+I/iNVcZIe4rRid+u0R+QdVECPmwxz
 3mblhsODpw1C0OGopbkekV2vUybRlkPd/6XBOrGA/YVITewbCk6viZzJZ4QMlRy07ZV4Ct
 JafxNXQOOvIkUp7XCZrsS8AYJ0OMeN0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-LWBsC-ZdMvycQVv-pdJQqw-1; Fri, 04 Sep 2026 08:13:17 -0400
X-MC-Unique: LWBsC-ZdMvycQVv-pdJQqw-1
X-Mimecast-MFC-AGG-ID: LWBsC-ZdMvycQVv-pdJQqw_1788523996
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b2a24ae6deso571854e87.0
 for <dev@dpdk.org>; Fri, 04 Sep 2026 05:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523996; x=1789128796;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=diU5OTOS3aQtZB/vwUjLTKy91Ea37u259uCZRmmkCd0=;
 b=fI9tx+rGg+HbCDRekJ+N1O0ifQd3C4GBR5dWAUogILF45exX7AuBE+xhjez5nDLeb6
 sV4gJKwPfV6sdiQOvoWz0ZPOBgVVqPmqRAAmSCVniNSeaL9gLqq/Kvb4XNZoqff/lFKg
 YlNAUq8GaJtNLgQnOZlVaS76R2axqo7dmymRDf3HlDLfcdJlk5oUMTjskP9Si8isU8Ym
 WnXLYmx17jrIYhdJJ9vHdhkL6Pi4ZE6ZHYtPpSQyg1n+kwOrr04yyReIylJ7Vjhqw6PA
 y69uTs7a2qrXqKYKeiV1kAIKX3Ga/mn/8IH0+UN2zEegdJRwKRmJC2OpB7zLbr4o22W/
 mNeA==
X-Gm-Message-State: AFuF++mhpin4VybiESKkjCOjXB/4EM70Xhg2CitQyC+fMXRh5ClRfDOy
 On9zeL+EdwdPoGqFD+evgF19raOo8+UYvcu1WHWwMdB4Jutq7UfNRfzKAMwaeI+L4XDmqRonqq/
 1z72X+ndC7EoYEvkV5pfNMM4ujKb/PqrBoguLYzkev5kQtrcqQRXiWKOM9tUYZsNug+Cbefe8M1
 fm4HlVsR4WlxkTecfaQDI=
X-Gm-Gg: AYBFou0fsexN6KAEslsSjqEn9i7V2OiIJ5QMaVOoA/7ipK5KWUVJtQe8vwaJjl1/+tJ
 t/0hhNibQap4MpZvlD4dsbmxeotaGQtb4bfJR+nYWVnp/XBeX28PUaPgy1Mf+M3xaq+6w1UX8E3
 XE9bw0XDF1USAxkHpXsDpvMCxKWlVxGg/J8qFIK4verTFBH0xepKSV0ZJyFbqmNc+5N7g+81nL1
 MEIm1ApRAkJ0RQ7QwIIKdXjOGwuIf9SSI1cuNKnWgOYZATi
X-Received: by 2002:ac2:51cb:0:b0:5b6:184c:7da2 with SMTP id
 2adb3069b0e04-5b6184c7e6emr551764e87.43.1788523995541; 
 Fri, 04 Sep 2026 05:13:15 -0700 (PDT)
X-Received: by 2002:ac2:51cb:0:b0:5b6:184c:7da2 with SMTP id
 2adb3069b0e04-5b6184c7e6emr551754e87.43.1788523994866; Fri, 04 Sep 2026
 05:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260724164520.192203-1-stephen@networkplumber.org>
 <20260730162311.313350-1-stephen@networkplumber.org>
In-Reply-To: <20260730162311.313350-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 4 Sep 2026 14:13:02 +0200
X-Gm-Features: AcwNN1VotdzSs5GrP4dMbS0s4aRUI9Qhvu7NIgdotzBCY7Qu4Po3B913u-7Jlc4
Message-ID: <CAJFAV8wEJAcFKH3svazPaGCnW3HX7T1Bd9OYKQPou0RS9j0cKg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] remove deprecated packet framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qAfnAh88p1tlF9YetPvJk6CLApCeDT6TURHJgICx_VA_1788523996
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

On Thu, 30 Jul 2026 at 18:23, Stephen Hemminger
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
> Note: there are some figures leftover that will need maintainer
> to manually remove with 'git rm' since patchwork mangled that.
>
> v6 - rebase and cleanup some leftovers
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
>  devtools/cocci/nullfree.cocci                 |   12 -
>  doc/api/doxy-api-index.md                     |   17 -
>  doc/guides/nics/softnic.rst                   |    3 +-
>  doc/guides/prog_guide/packet_framework.rst    | 1146 +--
>  doc/guides/rel_notes/deprecation.rst          |   15 -
>  doc/guides/rel_notes/release_26_11.rst        |   17 +
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
>  lib/table/rte_table_lpm_ipv6.h                |   92 -
>  lib/table/rte_table_stub.c                    |   95 -
>  lib/table/rte_table_stub.h                    |   30 -
>  lib/table/table_log.c                         |    7 -
>  lib/table/table_log.h                         |   11 -
>  128 files changed, 27 insertions(+), 45481 deletions(-)
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

I did not see much activity on this series on the ml, but I see it is
applied to next-net already.
I see some images were left behind.
Worth fixing before this gets pulled in main.

doc/guides/prog_guide/img/figure32.png
c561e0deda - port: remove legacy API (11 days ago) <Stephen Hemminger>

doc/guides/prog_guide/img/figure33.png
cd71a03348 - table: remove legacy API (11 days ago) <Stephen Hemminger>

doc/guides/prog_guide/img/figure34.png
cd71a03348 - table: remove legacy API (11 days ago) <Stephen Hemminger>

doc/guides/prog_guide/img/figure35.png
cd71a03348 - table: remove legacy API (11 days ago) <Stephen Hemminger>

doc/guides/prog_guide/img/figure37.png
cd71a03348 - table: remove legacy API (11 days ago) <Stephen Hemminger>

doc/guides/prog_guide/img/figure38.png
cd71a03348 - table: remove legacy API (11 days ago) <Stephen Hemminger>

doc/guides/prog_guide/img/figure39.png
cd71a03348 - table: remove legacy API (11 days ago) <Stephen Hemminger>

doc/guides/sample_app_ug/img/test_pipeline_app.png
5234c2b166 - app/test-pipeline: remove application (11 days ago)
<Stephen Hemminger>


-- 
David Marchand

