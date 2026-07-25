Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D4EC531C9
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Jul 2026 13:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 093D54029B;
	Sat, 25 Jul 2026 15:36:33 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 6399E4028C
 for <dev@dpdk.org>; Sat, 25 Jul 2026 15:36:31 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so984020a91.2
 for <dev@dpdk.org>; Sat, 25 Jul 2026 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784986590;
 x=1785591390; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vDQE9b8BYiT+BGWU1jhdseKCc9vo6g0ZxkraqePwAfo=;
 b=iNjXLvZEMfns+UYIXfSNiaDh/aiYq6I/4o0nf83Jd05vg2Tg0CphhOu4RuIQvR/x09
 MjVHIWV8CU831ugP4uR6gqSybr/ygJbArut8GRNP4CkkHYasReL49JdntcJnv6ba0dY/
 uu47r9ygt6tPZm9KxBu26mfSrYh7vi49iYD6qnS86VSdpcEFQkRPBX2daJsJdjG20Pvs
 OWhECG3dH6iRtraJ+SU0Bf2DATtzDLQ04lvD3kTbKLPTK0Lr2G68HE7A9wft93ELFhn1
 CB5I5+/gM6IhCGBX8ZjC/IBCE0noI2j3JdDMa2Q0thOP0l8Dcz1YQsl/x236E3ZBQuMO
 pYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784986590; x=1785591390;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vDQE9b8BYiT+BGWU1jhdseKCc9vo6g0ZxkraqePwAfo=;
 b=hmQDg6Kl+hAgsB9neqQrdZGo8sgLFaOYpxcXkL6LLvEv8qhc8mjyr78392iN3eEFAB
 ftcR5ODPUw9q6B99DVMrHJ19AYRrpvE0e/QPaEKNWKCa5DUopvAdzkw5JwLkXwbCZ8kB
 cf2c1Fe9cd3mbr4p86nJglN9ZxiR/QgYbp3VnfKx0A5dtgVtxS11GBXiRSKqwU55/+7M
 wtO4lNBr/6Q/5v8vVqo/57P1aZIoz3zB/QpXuD3Fk5cxB4JxuXw/2szxFnQ2yBEj8E4K
 ++81VLpRGK9tlcIb/4VVSEgbpiKndXhcd8K/I+/QaxdkXgHfhfsFWBsT+LsgmQs/z4SZ
 IcVA==
X-Gm-Message-State: AOJu0YygR5RsK+yy064LiIWwTH/yyf+hxSglsPZOaYKsb40Z3CBn931T
 w61FpqQO9HD60vJtkzTdgQKdesg3TI0qFeovalqWbSMcu+xY/6x7YvJOwTm2FY8GgPyFZgI5w1l
 PDrPW
X-Gm-Gg: AR+sD12DHKtVMHQWVkbkBuevUCeu07uSRtNzuCv5wzizXOoOgiZ8SnHkNOZUgjFYBpF
 hFiUoKHowfd33IYzuvCI1LXrfpUNGQiY6fMNOTlDauuVf0BZv2O3xTq9epf+qzUjHkxpGet93VW
 FxsAyA3GA26irEgZZ9K7WrkEGRDL9voxlKOUYtzFGrv7C3tuNnyIr33P1XMxKp1g9wqYgvRdtsS
 MxZakj86SDksBB9ARcZrlExwuk+mlbO+G8kqeGtnyIXuuO+n5sOq7eNgQSyMqZdDtOletdliT2j
 IUitvByzMWCwlbTTEVjJLq2syHFEQJ6wJqztu8oBdAuqEV+4O1m7xVAIakCu/ZM9GoEV2yQGGF1
 WcVw/WSFwSs8Vg6gjkKpw2VL5gENtbQL8qJVtLDiICcatUt60tbZzbcs6hK+L825Vy2OUGontZo
 Dv8jfPqJdF6G3p9RF66VPSw2uAQdXXQYk2Vl0xQ5nSvL0APOaSMQGoxQ==
X-Received: by 2002:a17:90b:1347:b0:38e:6dd:a9ad with SMTP id
 98e67ed59e1d1-38f292653camr2474364a91.0.1784986589744; 
 Sat, 25 Jul 2026 06:36:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130f55c6sm58789308c88.15.2026.07.25.06.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 06:36:29 -0700 (PDT)
Date: Sat, 25 Jul 2026 06:36:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] remove legacy Packet Framework API
Message-ID: <20260725063626.25e124f1@phoenix.local>
In-Reply-To: <CAJFAV8yyME96KxO3soWoGgQzqzRHvcxyvkBFcbA6jGNfAxU0ag@mail.gmail.com>
References: <20260724164520.192203-1-stephen@networkplumber.org>
 <CAJFAV8yyME96KxO3soWoGgQzqzRHvcxyvkBFcbA6jGNfAxU0ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 25 Jul 2026 09:54:48 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Fri, 24 Jul 2026 at 18:45, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > The legacy Packet Framework APIs were announced for removal in the
> > 24.11 release but the removal never happened:
> >
> > * pipeline: The pipeline library legacy API (functions rte_pipeline_*)
> > * table: The table library legacy API (functions rte_table_*)
> > * port: The port library legacy API (functions rte_port_*)
> >
> > Do the removal now, in the 26.11 ABI window. The SWX API in the same
> > libraries (rte_swx_*) is unaffected and remains the Packet Framework
> > API. The softnic driver and the pipeline example already use only the
> > SWX API.
> >
> > The applications built on the legacy API (test-pipeline, ip_pipeline)
> > and the unit tests are removed first, then the legacy half of each
> > library, pipeline before table before port to follow the dependency
> > chain. Library dependencies and the programmer's guide are trimmed
> > accordingly.
> >
> > Follow-up candidates, kept out of this series: the stale comments in
> > lib/ethdev/ethdev_trace.h still refer to examples/ip_pipeline, and
> > struct rte_pipeline_acl_rule in the removed rte_table_acl.c was only
> > a local name.
> >
> >
> > Stephen Hemminger (6):
> >   app/test: remove packet framework tests
> >   app/test-pipeline: remove application
> >   examples/ip_pipeline: remove example
> >   pipeline: remove legacy API
> >   table: remove legacy API
> >   port: remove legacy API
> >
> >  MAINTAINERS                                   |    5 -
> >  app/meson.build                               |    1 -
> >  app/test-pipeline/config.c                    |  230 -
> >  app/test-pipeline/init.c                      |  273 -
> >  app/test-pipeline/main.c                      |  188 -
> >  app/test-pipeline/main.h                      |  132 -
> >  app/test-pipeline/meson.build                 |   21 -
> >  app/test-pipeline/pipeline_acl.c              |  251 -
> >  app/test-pipeline/pipeline_hash.c             |  471 --
> >  app/test-pipeline/pipeline_lpm.c              |  175 -
> >  app/test-pipeline/pipeline_lpm_ipv6.c         |  168 -
> >  app/test-pipeline/pipeline_stub.c             |  137 -
> >  app/test-pipeline/runtime.c                   |  160 -
> >  app/test/meson.build                          |    6 -
> >  app/test/test_table.c                         |  209 -
> >  app/test/test_table.h                         |  184 -
> >  app/test/test_table_acl.c                     |  728 --
> >  app/test/test_table_acl.h                     |    6 -
> >  app/test/test_table_combined.c                |  846 --
> >  app/test/test_table_combined.h                |   27 -
> >  app/test/test_table_pipeline.c                |  575 --
> >  app/test/test_table_pipeline.h                |    6 -
> >  app/test/test_table_ports.c                   |  195 -
> >  app/test/test_table_ports.h                   |   13 -
> >  app/test/test_table_tables.c                  | 1058 ---
> >  app/test/test_table_tables.h                  |   22 -
> >  doc/api/doxy-api-index.md                     |   17 -
> >  doc/guides/nics/softnic.rst                   |    3 +-
> >  doc/guides/prog_guide/img/figure32.png        |  Bin 11603 -> 0 bytes
> >  doc/guides/prog_guide/img/figure33.png        |  Bin 65216 -> 0 bytes
> >  doc/guides/prog_guide/img/figure34.png        |  Bin 11581 -> 0 bytes
> >  doc/guides/prog_guide/img/figure35.png        |  Bin 75012 -> 0 bytes
> >  doc/guides/prog_guide/img/figure37.png        |  Bin 6934 -> 0 bytes
> >  doc/guides/prog_guide/img/figure38.png        |  Bin 7372 -> 0 bytes
> >  doc/guides/prog_guide/img/figure39.png        |  Bin 55986 -> 0 bytes
> >  doc/guides/prog_guide/packet_framework.rst    | 1146 +--
> >  doc/guides/rel_notes/deprecation.rst          |   15 -
> >  doc/guides/rel_notes/release_26_11.rst        |   17 +
> >  .../sample_app_ug/img/test_pipeline_app.png   |  Bin 67410 -> 0 bytes
> >  doc/guides/sample_app_ug/index.rst            |    2 -
> >  doc/guides/sample_app_ug/ip_pipeline.rst      |  531 --
> >  doc/guides/sample_app_ug/test_pipeline.rst    |  237 -
> >  examples/ip_pipeline/Makefile                 |   60 -
> >  examples/ip_pipeline/action.c                 |  391 -
> >  examples/ip_pipeline/action.h                 |   78 -
> >  examples/ip_pipeline/cli.c                    | 6791 -----------------
> >  examples/ip_pipeline/cli.h                    |   18 -
> >  examples/ip_pipeline/common.h                 |   12 -
> >  examples/ip_pipeline/conn.c                   |  330 -
> >  examples/ip_pipeline/conn.h                   |   47 -
> >  examples/ip_pipeline/cryptodev.c              |  160 -
> >  examples/ip_pipeline/cryptodev.h              |   46 -
> >  examples/ip_pipeline/examples/firewall.cli    |   59 -
> >  examples/ip_pipeline/examples/flow.cli        |   60 -
> >  examples/ip_pipeline/examples/flow_crypto.cli |   57 -
> >  examples/ip_pipeline/examples/l2fwd.cli       |   51 -
> >  examples/ip_pipeline/examples/route.cli       |   60 -
> >  examples/ip_pipeline/examples/route_ecmp.cli  |   57 -
> >  examples/ip_pipeline/examples/rss.cli         |  112 -
> >  examples/ip_pipeline/examples/tap.cli         |   66 -
> >  examples/ip_pipeline/link.c                   |  270 -
> >  examples/ip_pipeline/link.h                   |   66 -
> >  examples/ip_pipeline/main.c                   |  260 -
> >  examples/ip_pipeline/mempool.c                |   82 -
> >  examples/ip_pipeline/mempool.h                |   40 -
> >  examples/ip_pipeline/meson.build              |   30 -
> >  examples/ip_pipeline/parser.c                 |  506 --
> >  examples/ip_pipeline/parser.h                 |   56 -
> >  examples/ip_pipeline/pipeline.c               | 1078 ---
> >  examples/ip_pipeline/pipeline.h               |  425 --
> >  examples/ip_pipeline/swq.c                    |   76 -
> >  examples/ip_pipeline/swq.h                    |   37 -
> >  examples/ip_pipeline/tap.c                    |  102 -
> >  examples/ip_pipeline/tap.h                    |   29 -
> >  examples/ip_pipeline/thread.c                 | 3137 --------
> >  examples/ip_pipeline/thread.h                 |   24 -
> >  examples/ip_pipeline/tmgr.c                   |  248 -
> >  examples/ip_pipeline/tmgr.h                   |   74 -
> >  examples/meson.build                          |    1 -
> >  lib/pipeline/meson.build                      |    8 +-
> >  lib/pipeline/rte_pipeline.c                   | 1640 ----
> >  lib/pipeline/rte_pipeline.h                   |  840 --
> >  lib/pipeline/rte_port_in_action.c             |  539 --
> >  lib/pipeline/rte_port_in_action.h             |  311 -
> >  lib/pipeline/rte_table_action.c               | 3483 ---------
> >  lib/pipeline/rte_table_action.h               | 1137 ---
> >  lib/port/meson.build                          |   22 +-
> >  lib/port/port_log.c                           |    7 -
> >  lib/port/port_log.h                           |   11 -
> >  lib/port/rte_port.h                           |  223 -
> >  lib/port/rte_port_ethdev.c                    |  530 --
> >  lib/port/rte_port_ethdev.h                    |   75 -
> >  lib/port/rte_port_eventdev.c                  |  590 --
> >  lib/port/rte_port_eventdev.h                  |   94 -
> >  lib/port/rte_port_fd.c                        |  524 --
> >  lib/port/rte_port_fd.h                        |   74 -
> >  lib/port/rte_port_frag.c                      |  280 -
> >  lib/port/rte_port_frag.h                      |   70 -
> >  lib/port/rte_port_ras.c                       |  336 -
> >  lib/port/rte_port_ras.h                       |   58 -
> >  lib/port/rte_port_ring.c                      |  796 --
> >  lib/port/rte_port_ring.h                      |   91 -
> >  lib/port/rte_port_sched.c                     |  298 -
> >  lib/port/rte_port_sched.h                     |   52 -
> >  lib/port/rte_port_source_sink.c               |  616 --
> >  lib/port/rte_port_source_sink.h               |   57 -
> >  lib/port/rte_port_sym_crypto.c                |  558 --
> >  lib/port/rte_port_sym_crypto.h                |   92 -
> >  lib/table/meson.build                         |   30 +-
> >  lib/table/rte_lru.h                           |   85 -
> >  lib/table/rte_lru_arm64.h                     |   61 -
> >  lib/table/rte_lru_x86.h                       |   96 -
> >  lib/table/rte_table.h                         |  263 -
> >  lib/table/rte_table_acl.c                     |  795 --
> >  lib/table/rte_table_acl.h                     |   65 -
> >  lib/table/rte_table_array.c                   |  210 -
> >  lib/table/rte_table_array.h                   |   46 -
> >  lib/table/rte_table_hash.h                    |  106 -
> >  lib/table/rte_table_hash_cuckoo.c             |  327 -
> >  lib/table/rte_table_hash_cuckoo.h             |   57 -
> >  lib/table/rte_table_hash_ext.c                | 1011 ---
> >  lib/table/rte_table_hash_func.h               |  263 -
> >  lib/table/rte_table_hash_func_arm64.h         |   21 -
> >  lib/table/rte_table_hash_key16.c              | 1190 ---
> >  lib/table/rte_table_hash_key32.c              | 1223 ---
> >  lib/table/rte_table_hash_key8.c               | 1157 ---
> >  lib/table/rte_table_hash_lru.c                |  959 ---
> >  lib/table/rte_table_lpm.c                     |  369 -
> >  lib/table/rte_table_lpm.h                     |   94 -
> >  lib/table/rte_table_lpm_ipv6.c                |  370 -
> >  lib/table/rte_table_lpm_ipv6.h                |   95 -
> >  lib/table/rte_table_stub.c                    |   95 -
> >  lib/table/rte_table_stub.h                    |   30 -
> >  lib/table/table_log.c                         |    7 -
> >  lib/table/table_log.h                         |   11 -
> >  135 files changed, 27 insertions(+), 45472 deletions(-)
> >  delete mode 100644 app/test-pipeline/config.c
> >  delete mode 100644 app/test-pipeline/init.c
> >  delete mode 100644 app/test-pipeline/main.c
> >  delete mode 100644 app/test-pipeline/main.h
> >  delete mode 100644 app/test-pipeline/meson.build
> >  delete mode 100644 app/test-pipeline/pipeline_acl.c
> >  delete mode 100644 app/test-pipeline/pipeline_hash.c
> >  delete mode 100644 app/test-pipeline/pipeline_lpm.c
> >  delete mode 100644 app/test-pipeline/pipeline_lpm_ipv6.c
> >  delete mode 100644 app/test-pipeline/pipeline_stub.c
> >  delete mode 100644 app/test-pipeline/runtime.c
> >  delete mode 100644 app/test/test_table.c
> >  delete mode 100644 app/test/test_table.h
> >  delete mode 100644 app/test/test_table_acl.c
> >  delete mode 100644 app/test/test_table_acl.h
> >  delete mode 100644 app/test/test_table_combined.c
> >  delete mode 100644 app/test/test_table_combined.h
> >  delete mode 100644 app/test/test_table_pipeline.c
> >  delete mode 100644 app/test/test_table_pipeline.h
> >  delete mode 100644 app/test/test_table_ports.c
> >  delete mode 100644 app/test/test_table_ports.h
> >  delete mode 100644 app/test/test_table_tables.c
> >  delete mode 100644 app/test/test_table_tables.h
> >  delete mode 100644 doc/guides/prog_guide/img/figure32.png
> >  delete mode 100644 doc/guides/prog_guide/img/figure33.png
> >  delete mode 100644 doc/guides/prog_guide/img/figure34.png
> >  delete mode 100644 doc/guides/prog_guide/img/figure35.png
> >  delete mode 100644 doc/guides/prog_guide/img/figure37.png
> >  delete mode 100644 doc/guides/prog_guide/img/figure38.png
> >  delete mode 100644 doc/guides/prog_guide/img/figure39.png
> >  delete mode 100644 doc/guides/sample_app_ug/img/test_pipeline_app.png
> >  delete mode 100644 doc/guides/sample_app_ug/ip_pipeline.rst
> >  delete mode 100644 doc/guides/sample_app_ug/test_pipeline.rst
> >  delete mode 100644 examples/ip_pipeline/Makefile
> >  delete mode 100644 examples/ip_pipeline/action.c
> >  delete mode 100644 examples/ip_pipeline/action.h
> >  delete mode 100644 examples/ip_pipeline/cli.c
> >  delete mode 100644 examples/ip_pipeline/cli.h
> >  delete mode 100644 examples/ip_pipeline/common.h
> >  delete mode 100644 examples/ip_pipeline/conn.c
> >  delete mode 100644 examples/ip_pipeline/conn.h
> >  delete mode 100644 examples/ip_pipeline/cryptodev.c
> >  delete mode 100644 examples/ip_pipeline/cryptodev.h
> >  delete mode 100644 examples/ip_pipeline/examples/firewall.cli
> >  delete mode 100644 examples/ip_pipeline/examples/flow.cli
> >  delete mode 100644 examples/ip_pipeline/examples/flow_crypto.cli
> >  delete mode 100644 examples/ip_pipeline/examples/l2fwd.cli
> >  delete mode 100644 examples/ip_pipeline/examples/route.cli
> >  delete mode 100644 examples/ip_pipeline/examples/route_ecmp.cli
> >  delete mode 100644 examples/ip_pipeline/examples/rss.cli
> >  delete mode 100644 examples/ip_pipeline/examples/tap.cli
> >  delete mode 100644 examples/ip_pipeline/link.c
> >  delete mode 100644 examples/ip_pipeline/link.h
> >  delete mode 100644 examples/ip_pipeline/main.c
> >  delete mode 100644 examples/ip_pipeline/mempool.c
> >  delete mode 100644 examples/ip_pipeline/mempool.h
> >  delete mode 100644 examples/ip_pipeline/meson.build
> >  delete mode 100644 examples/ip_pipeline/parser.c
> >  delete mode 100644 examples/ip_pipeline/parser.h
> >  delete mode 100644 examples/ip_pipeline/pipeline.c
> >  delete mode 100644 examples/ip_pipeline/pipeline.h
> >  delete mode 100644 examples/ip_pipeline/swq.c
> >  delete mode 100644 examples/ip_pipeline/swq.h
> >  delete mode 100644 examples/ip_pipeline/tap.c
> >  delete mode 100644 examples/ip_pipeline/tap.h
> >  delete mode 100644 examples/ip_pipeline/thread.c
> >  delete mode 100644 examples/ip_pipeline/thread.h
> >  delete mode 100644 examples/ip_pipeline/tmgr.c
> >  delete mode 100644 examples/ip_pipeline/tmgr.h
> >  delete mode 100644 lib/pipeline/rte_pipeline.c
> >  delete mode 100644 lib/pipeline/rte_pipeline.h
> >  delete mode 100644 lib/pipeline/rte_port_in_action.c
> >  delete mode 100644 lib/pipeline/rte_port_in_action.h
> >  delete mode 100644 lib/pipeline/rte_table_action.c
> >  delete mode 100644 lib/pipeline/rte_table_action.h
> >  delete mode 100644 lib/port/port_log.c
> >  delete mode 100644 lib/port/port_log.h
> >  delete mode 100644 lib/port/rte_port.h
> >  delete mode 100644 lib/port/rte_port_ethdev.c
> >  delete mode 100644 lib/port/rte_port_ethdev.h
> >  delete mode 100644 lib/port/rte_port_eventdev.c
> >  delete mode 100644 lib/port/rte_port_eventdev.h
> >  delete mode 100644 lib/port/rte_port_fd.c
> >  delete mode 100644 lib/port/rte_port_fd.h
> >  delete mode 100644 lib/port/rte_port_frag.c
> >  delete mode 100644 lib/port/rte_port_frag.h
> >  delete mode 100644 lib/port/rte_port_ras.c
> >  delete mode 100644 lib/port/rte_port_ras.h
> >  delete mode 100644 lib/port/rte_port_ring.c
> >  delete mode 100644 lib/port/rte_port_ring.h
> >  delete mode 100644 lib/port/rte_port_sched.c
> >  delete mode 100644 lib/port/rte_port_sched.h
> >  delete mode 100644 lib/port/rte_port_source_sink.c
> >  delete mode 100644 lib/port/rte_port_source_sink.h
> >  delete mode 100644 lib/port/rte_port_sym_crypto.c
> >  delete mode 100644 lib/port/rte_port_sym_crypto.h
> >  delete mode 100644 lib/table/rte_lru.h
> >  delete mode 100644 lib/table/rte_lru_arm64.h
> >  delete mode 100644 lib/table/rte_lru_x86.h
> >  delete mode 100644 lib/table/rte_table.h
> >  delete mode 100644 lib/table/rte_table_acl.c
> >  delete mode 100644 lib/table/rte_table_acl.h
> >  delete mode 100644 lib/table/rte_table_array.c
> >  delete mode 100644 lib/table/rte_table_array.h
> >  delete mode 100644 lib/table/rte_table_hash.h
> >  delete mode 100644 lib/table/rte_table_hash_cuckoo.c
> >  delete mode 100644 lib/table/rte_table_hash_cuckoo.h
> >  delete mode 100644 lib/table/rte_table_hash_ext.c
> >  delete mode 100644 lib/table/rte_table_hash_func.h
> >  delete mode 100644 lib/table/rte_table_hash_func_arm64.h
> >  delete mode 100644 lib/table/rte_table_hash_key16.c
> >  delete mode 100644 lib/table/rte_table_hash_key32.c
> >  delete mode 100644 lib/table/rte_table_hash_key8.c
> >  delete mode 100644 lib/table/rte_table_hash_lru.c
> >  delete mode 100644 lib/table/rte_table_lpm.c
> >  delete mode 100644 lib/table/rte_table_lpm.h
> >  delete mode 100644 lib/table/rte_table_lpm_ipv6.c
> >  delete mode 100644 lib/table/rte_table_lpm_ipv6.h
> >  delete mode 100644 lib/table/rte_table_stub.c
> >  delete mode 100644 lib/table/rte_table_stub.h
> >  delete mode 100644 lib/table/table_log.c
> >  delete mode 100644 lib/table/table_log.h  
> 
> Sorry, it seems this series (and only this series iiuc) fell through
> the cracks while patchwork and other dpdk.org services were under
> heavy load...
> Could you resend?
> 
> 

I suspect there maybe feedbacks, will send again on Monday.
