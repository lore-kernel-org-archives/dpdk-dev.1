Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE7EC54F4D
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 16:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7202E40269;
	Tue, 28 Jul 2026 18:37:22 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 24CA24014F
 for <dev@dpdk.org>; Tue, 28 Jul 2026 18:37:21 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so1202223b3a.1
 for <dev@dpdk.org>; Tue, 28 Jul 2026 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785256640;
 x=1785861440; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WkJQ+EkyDpU+6s+G9ZHbepjZJgBUorsPX2m8WGuwGp8=;
 b=c1q9wl3VfNzMPkJIXn65aYwvcg81h/14n/+HtJSy+2bugqF/ljNKrEPYMJbbLWQqUb
 vAtih1zxGOvWF1g5bZbl2f4mtlM47+YltBNR7em2KoLyttIU/NMRbrytGqW5RMUpTC2p
 RxclPMP2doeLqpjQDzbkdL6xcDtQ3HpXt9UvGS/UoMNEDDwQ7NtxlG2p6pMqf5tXTePD
 Lej/PAxnOTPXjcpA44zA14EwXDt73ItSKjtMWVKkQfJIBqhpttA7HnvISQO8t9wPg175
 ks1BaMKK4gDYc9vYO+lOFagBAUEHsJWmtAB62lEyQLfY5EZXwBEFxPiEGVU5ICuIyuP4
 jPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785256640; x=1785861440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WkJQ+EkyDpU+6s+G9ZHbepjZJgBUorsPX2m8WGuwGp8=;
 b=E4YF6vlEq6v6UDhZTG4nmngzNvoMsDDwg7nmbwdsbsC7NvVGpxwLRpIX/LLYFUFWLD
 vqlTbci1PuYjkQqpHcK/Zglt2zP1HhBuP6oN6ksrQlhpL5QQAq3qro5+CqUAS33Eshz3
 3t81GvxvsIO0pCNZJ5a489x8fWOZQ8B3HGXnjqPTtxsK8P/RgrkJ18g8iZvpW0Zp4wPm
 g7YAMU/SrMo52QcpndfMkHamKz6RpB1ltiEfMQl5/bK9dp+uZI0fjVtgABi4MjpXC+HB
 RdbGQvIBfwrycsTM61ejfJVR5BVWrmcFSmoROWeTmwx0Oh237w+Ib37nyPQPYUmqQSk1
 CRnA==
X-Gm-Message-State: AOJu0Yz8nr239Z6LIdyz9b5SjUb7Zy32SWn8D82sZSLy0LFQqkMswyVA
 kslDa/Av83hddehz0T2n/y9OC6lLI7GWW4/NH4B/Gryo2h3ZTuP1QuR3X499cDAJTKSwVR05m+2
 ZwJE2
X-Gm-Gg: AR+sD10ehcr8obVxoTP3NyZ7cT3bHFKYfRukkRghu5kcyOufkJOO84oPye9GS7cbAo9
 gW2IhCLQMoCw8yldzrRJPg+laoMgW55G6qPEGwgVGY+pFDQRPe417xcT7qpCtMoP7pc/+bW0Df0
 OEZrmvugq84b2X8Us+GsPx+Kvybq0saDWOP461BJLXXv31QuEJ8twMsnin6sVYfw9nf9Rq0IWuR
 bowkvNJe46K4jsM1PWIadVDxdbPLqJ43fvkXR1WZdWQAnDSsuIDvXiIVV7BUVHcAEfGK48I6fUS
 9ZKt0NDyJXaIvPqlPEkWABz1ZCabw/6Lzpdwgv0RnrqvzfFGDjbBzFVEke3rtjhY3ZC1/TMpKtf
 0JPlUcXAZVUrCub+ZegJM4pb1o57t3PrDzGlrDeq8pCoUZcEYzlJJNIQqlqIqWMV1S0oWWftF8x
 qMeIcfI4uhWQMcYC5UhRmUXZy97xfRjSevk6YBP13H
X-Received: by 2002:a05:6a21:a0a:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3c8ba474e28mr4140430637.13.1785256639721; 
 Tue, 28 Jul 2026 09:37:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504cc63f3sm334754eec.16.2026.07.28.09.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 09:37:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/7] remove deprecated packet framework
Date: Tue, 28 Jul 2026 09:35:08 -0700
Message-ID: <20260728163713.364168-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724164520.192203-1-stephen@networkplumber.org>
References: <20260724164520.192203-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The packet framework was marked as deprecated in 24.11.
This patch series completes the removal of the libraries, documentation,
and tests.

Stephen Hemminger (7):
  app/test: remove packet framework tests
  app/test-pipeline: remove application
  examples/ip_pipeline: remove example
  pipeline: remove legacy API
  table: remove legacy API
  port: remove legacy API
  doc: remove packet framework images

 MAINTAINERS                                   |    5 -
 app/meson.build                               |    1 -
 app/test-pipeline/config.c                    |  230 -
 app/test-pipeline/init.c                      |  273 -
 app/test-pipeline/main.c                      |  188 -
 app/test-pipeline/main.h                      |  132 -
 app/test-pipeline/meson.build                 |   21 -
 app/test-pipeline/pipeline_acl.c              |  251 -
 app/test-pipeline/pipeline_hash.c             |  471 --
 app/test-pipeline/pipeline_lpm.c              |  175 -
 app/test-pipeline/pipeline_lpm_ipv6.c         |  168 -
 app/test-pipeline/pipeline_stub.c             |  137 -
 app/test-pipeline/runtime.c                   |  160 -
 app/test/meson.build                          |    6 -
 app/test/test_table.c                         |  209 -
 app/test/test_table.h                         |  184 -
 app/test/test_table_acl.c                     |  728 --
 app/test/test_table_acl.h                     |    6 -
 app/test/test_table_combined.c                |  846 --
 app/test/test_table_combined.h                |   27 -
 app/test/test_table_pipeline.c                |  575 --
 app/test/test_table_pipeline.h                |    6 -
 app/test/test_table_ports.c                   |  195 -
 app/test/test_table_ports.h                   |   13 -
 app/test/test_table_tables.c                  | 1058 ---
 app/test/test_table_tables.h                  |   22 -
 doc/api/doxy-api-index.md                     |   17 -
 doc/guides/nics/softnic.rst                   |    3 +-
 doc/guides/prog_guide/img/figure32.png        |  Bin 11603 -> 0 bytes
 doc/guides/prog_guide/img/figure33.png        |  Bin 65216 -> 0 bytes
 doc/guides/prog_guide/img/figure34.png        |  Bin 11581 -> 0 bytes
 doc/guides/prog_guide/img/figure35.png        |  Bin 75012 -> 0 bytes
 doc/guides/prog_guide/img/figure37.png        |  Bin 6934 -> 0 bytes
 doc/guides/prog_guide/img/figure38.png        |  Bin 7372 -> 0 bytes
 doc/guides/prog_guide/img/figure39.png        |  Bin 55986 -> 0 bytes
 doc/guides/prog_guide/packet_framework.rst    | 1146 +--
 doc/guides/rel_notes/deprecation.rst          |   15 -
 doc/guides/rel_notes/release_26_11.rst        |   17 +
 .../sample_app_ug/img/test_pipeline_app.png   |  Bin 67410 -> 0 bytes
 doc/guides/sample_app_ug/index.rst            |    2 -
 doc/guides/sample_app_ug/ip_pipeline.rst      |  531 --
 doc/guides/sample_app_ug/test_pipeline.rst    |  237 -
 examples/ip_pipeline/Makefile                 |   60 -
 examples/ip_pipeline/action.c                 |  391 -
 examples/ip_pipeline/action.h                 |   78 -
 examples/ip_pipeline/cli.c                    | 6791 -----------------
 examples/ip_pipeline/cli.h                    |   18 -
 examples/ip_pipeline/common.h                 |   12 -
 examples/ip_pipeline/conn.c                   |  330 -
 examples/ip_pipeline/conn.h                   |   47 -
 examples/ip_pipeline/cryptodev.c              |  160 -
 examples/ip_pipeline/cryptodev.h              |   46 -
 examples/ip_pipeline/examples/firewall.cli    |   59 -
 examples/ip_pipeline/examples/flow.cli        |   60 -
 examples/ip_pipeline/examples/flow_crypto.cli |   57 -
 examples/ip_pipeline/examples/l2fwd.cli       |   51 -
 examples/ip_pipeline/examples/route.cli       |   60 -
 examples/ip_pipeline/examples/route_ecmp.cli  |   57 -
 examples/ip_pipeline/examples/rss.cli         |  112 -
 examples/ip_pipeline/examples/tap.cli         |   66 -
 examples/ip_pipeline/link.c                   |  270 -
 examples/ip_pipeline/link.h                   |   66 -
 examples/ip_pipeline/main.c                   |  260 -
 examples/ip_pipeline/mempool.c                |   82 -
 examples/ip_pipeline/mempool.h                |   40 -
 examples/ip_pipeline/meson.build              |   30 -
 examples/ip_pipeline/parser.c                 |  506 --
 examples/ip_pipeline/parser.h                 |   56 -
 examples/ip_pipeline/pipeline.c               | 1078 ---
 examples/ip_pipeline/pipeline.h               |  425 --
 examples/ip_pipeline/swq.c                    |   76 -
 examples/ip_pipeline/swq.h                    |   37 -
 examples/ip_pipeline/tap.c                    |  102 -
 examples/ip_pipeline/tap.h                    |   29 -
 examples/ip_pipeline/thread.c                 | 3137 --------
 examples/ip_pipeline/thread.h                 |   24 -
 examples/ip_pipeline/tmgr.c                   |  248 -
 examples/ip_pipeline/tmgr.h                   |   74 -
 examples/meson.build                          |    1 -
 lib/pipeline/meson.build                      |    8 +-
 lib/pipeline/rte_pipeline.c                   | 1640 ----
 lib/pipeline/rte_pipeline.h                   |  840 --
 lib/pipeline/rte_port_in_action.c             |  539 --
 lib/pipeline/rte_port_in_action.h             |  311 -
 lib/pipeline/rte_table_action.c               | 3483 ---------
 lib/pipeline/rte_table_action.h               | 1137 ---
 lib/port/meson.build                          |   22 +-
 lib/port/port_log.c                           |    7 -
 lib/port/port_log.h                           |   11 -
 lib/port/rte_port.h                           |  223 -
 lib/port/rte_port_ethdev.c                    |  530 --
 lib/port/rte_port_ethdev.h                    |   75 -
 lib/port/rte_port_eventdev.c                  |  590 --
 lib/port/rte_port_eventdev.h                  |   94 -
 lib/port/rte_port_fd.c                        |  524 --
 lib/port/rte_port_fd.h                        |   74 -
 lib/port/rte_port_frag.c                      |  280 -
 lib/port/rte_port_frag.h                      |   70 -
 lib/port/rte_port_ras.c                       |  336 -
 lib/port/rte_port_ras.h                       |   58 -
 lib/port/rte_port_ring.c                      |  796 --
 lib/port/rte_port_ring.h                      |   91 -
 lib/port/rte_port_sched.c                     |  298 -
 lib/port/rte_port_sched.h                     |   52 -
 lib/port/rte_port_source_sink.c               |  616 --
 lib/port/rte_port_source_sink.h               |   57 -
 lib/port/rte_port_sym_crypto.c                |  558 --
 lib/port/rte_port_sym_crypto.h                |   92 -
 lib/table/meson.build                         |   30 +-
 lib/table/rte_lru.h                           |   85 -
 lib/table/rte_lru_arm64.h                     |   61 -
 lib/table/rte_lru_x86.h                       |   96 -
 lib/table/rte_table.h                         |  263 -
 lib/table/rte_table_acl.c                     |  795 --
 lib/table/rte_table_acl.h                     |   65 -
 lib/table/rte_table_array.c                   |  210 -
 lib/table/rte_table_array.h                   |   46 -
 lib/table/rte_table_hash.h                    |  106 -
 lib/table/rte_table_hash_cuckoo.c             |  327 -
 lib/table/rte_table_hash_cuckoo.h             |   57 -
 lib/table/rte_table_hash_ext.c                | 1011 ---
 lib/table/rte_table_hash_func.h               |  263 -
 lib/table/rte_table_hash_func_arm64.h         |   21 -
 lib/table/rte_table_hash_key16.c              | 1190 ---
 lib/table/rte_table_hash_key32.c              | 1223 ---
 lib/table/rte_table_hash_key8.c               | 1157 ---
 lib/table/rte_table_hash_lru.c                |  959 ---
 lib/table/rte_table_lpm.c                     |  369 -
 lib/table/rte_table_lpm.h                     |   94 -
 lib/table/rte_table_lpm_ipv6.c                |  370 -
 lib/table/rte_table_stub.c                    |   95 -
 lib/table/rte_table_stub.h                    |   30 -
 lib/table/table_log.c                         |    7 -
 lib/table/table_log.h                         |   11 -
 134 files changed, 27 insertions(+), 45377 deletions(-)
 delete mode 100644 app/test-pipeline/config.c
 delete mode 100644 app/test-pipeline/init.c
 delete mode 100644 app/test-pipeline/main.c
 delete mode 100644 app/test-pipeline/main.h
 delete mode 100644 app/test-pipeline/meson.build
 delete mode 100644 app/test-pipeline/pipeline_acl.c
 delete mode 100644 app/test-pipeline/pipeline_hash.c
 delete mode 100644 app/test-pipeline/pipeline_lpm.c
 delete mode 100644 app/test-pipeline/pipeline_lpm_ipv6.c
 delete mode 100644 app/test-pipeline/pipeline_stub.c
 delete mode 100644 app/test-pipeline/runtime.c
 delete mode 100644 app/test/test_table.c
 delete mode 100644 app/test/test_table.h
 delete mode 100644 app/test/test_table_acl.c
 delete mode 100644 app/test/test_table_acl.h
 delete mode 100644 app/test/test_table_combined.c
 delete mode 100644 app/test/test_table_combined.h
 delete mode 100644 app/test/test_table_pipeline.c
 delete mode 100644 app/test/test_table_pipeline.h
 delete mode 100644 app/test/test_table_ports.c
 delete mode 100644 app/test/test_table_ports.h
 delete mode 100644 app/test/test_table_tables.c
 delete mode 100644 app/test/test_table_tables.h
 delete mode 100644 doc/guides/prog_guide/img/figure32.png
 delete mode 100644 doc/guides/prog_guide/img/figure33.png
 delete mode 100644 doc/guides/prog_guide/img/figure34.png
 delete mode 100644 doc/guides/prog_guide/img/figure35.png
 delete mode 100644 doc/guides/prog_guide/img/figure37.png
 delete mode 100644 doc/guides/prog_guide/img/figure38.png
 delete mode 100644 doc/guides/prog_guide/img/figure39.png
 delete mode 100644 doc/guides/sample_app_ug/img/test_pipeline_app.png
 delete mode 100644 doc/guides/sample_app_ug/ip_pipeline.rst
 delete mode 100644 doc/guides/sample_app_ug/test_pipeline.rst
 delete mode 100644 examples/ip_pipeline/Makefile
 delete mode 100644 examples/ip_pipeline/action.c
 delete mode 100644 examples/ip_pipeline/action.h
 delete mode 100644 examples/ip_pipeline/cli.c
 delete mode 100644 examples/ip_pipeline/cli.h
 delete mode 100644 examples/ip_pipeline/common.h
 delete mode 100644 examples/ip_pipeline/conn.c
 delete mode 100644 examples/ip_pipeline/conn.h
 delete mode 100644 examples/ip_pipeline/cryptodev.c
 delete mode 100644 examples/ip_pipeline/cryptodev.h
 delete mode 100644 examples/ip_pipeline/examples/firewall.cli
 delete mode 100644 examples/ip_pipeline/examples/flow.cli
 delete mode 100644 examples/ip_pipeline/examples/flow_crypto.cli
 delete mode 100644 examples/ip_pipeline/examples/l2fwd.cli
 delete mode 100644 examples/ip_pipeline/examples/route.cli
 delete mode 100644 examples/ip_pipeline/examples/route_ecmp.cli
 delete mode 100644 examples/ip_pipeline/examples/rss.cli
 delete mode 100644 examples/ip_pipeline/examples/tap.cli
 delete mode 100644 examples/ip_pipeline/link.c
 delete mode 100644 examples/ip_pipeline/link.h
 delete mode 100644 examples/ip_pipeline/main.c
 delete mode 100644 examples/ip_pipeline/mempool.c
 delete mode 100644 examples/ip_pipeline/mempool.h
 delete mode 100644 examples/ip_pipeline/meson.build
 delete mode 100644 examples/ip_pipeline/parser.c
 delete mode 100644 examples/ip_pipeline/parser.h
 delete mode 100644 examples/ip_pipeline/pipeline.c
 delete mode 100644 examples/ip_pipeline/pipeline.h
 delete mode 100644 examples/ip_pipeline/swq.c
 delete mode 100644 examples/ip_pipeline/swq.h
 delete mode 100644 examples/ip_pipeline/tap.c
 delete mode 100644 examples/ip_pipeline/tap.h
 delete mode 100644 examples/ip_pipeline/thread.c
 delete mode 100644 examples/ip_pipeline/thread.h
 delete mode 100644 examples/ip_pipeline/tmgr.c
 delete mode 100644 examples/ip_pipeline/tmgr.h
 delete mode 100644 lib/pipeline/rte_pipeline.c
 delete mode 100644 lib/pipeline/rte_pipeline.h
 delete mode 100644 lib/pipeline/rte_port_in_action.c
 delete mode 100644 lib/pipeline/rte_port_in_action.h
 delete mode 100644 lib/pipeline/rte_table_action.c
 delete mode 100644 lib/pipeline/rte_table_action.h
 delete mode 100644 lib/port/port_log.c
 delete mode 100644 lib/port/port_log.h
 delete mode 100644 lib/port/rte_port.h
 delete mode 100644 lib/port/rte_port_ethdev.c
 delete mode 100644 lib/port/rte_port_ethdev.h
 delete mode 100644 lib/port/rte_port_eventdev.c
 delete mode 100644 lib/port/rte_port_eventdev.h
 delete mode 100644 lib/port/rte_port_fd.c
 delete mode 100644 lib/port/rte_port_fd.h
 delete mode 100644 lib/port/rte_port_frag.c
 delete mode 100644 lib/port/rte_port_frag.h
 delete mode 100644 lib/port/rte_port_ras.c
 delete mode 100644 lib/port/rte_port_ras.h
 delete mode 100644 lib/port/rte_port_ring.c
 delete mode 100644 lib/port/rte_port_ring.h
 delete mode 100644 lib/port/rte_port_sched.c
 delete mode 100644 lib/port/rte_port_sched.h
 delete mode 100644 lib/port/rte_port_source_sink.c
 delete mode 100644 lib/port/rte_port_source_sink.h
 delete mode 100644 lib/port/rte_port_sym_crypto.c
 delete mode 100644 lib/port/rte_port_sym_crypto.h
 delete mode 100644 lib/table/rte_lru.h
 delete mode 100644 lib/table/rte_lru_arm64.h
 delete mode 100644 lib/table/rte_lru_x86.h
 delete mode 100644 lib/table/rte_table.h
 delete mode 100644 lib/table/rte_table_acl.c
 delete mode 100644 lib/table/rte_table_acl.h
 delete mode 100644 lib/table/rte_table_array.c
 delete mode 100644 lib/table/rte_table_array.h
 delete mode 100644 lib/table/rte_table_hash.h
 delete mode 100644 lib/table/rte_table_hash_cuckoo.c
 delete mode 100644 lib/table/rte_table_hash_cuckoo.h
 delete mode 100644 lib/table/rte_table_hash_ext.c
 delete mode 100644 lib/table/rte_table_hash_func.h
 delete mode 100644 lib/table/rte_table_hash_func_arm64.h
 delete mode 100644 lib/table/rte_table_hash_key16.c
 delete mode 100644 lib/table/rte_table_hash_key32.c
 delete mode 100644 lib/table/rte_table_hash_key8.c
 delete mode 100644 lib/table/rte_table_hash_lru.c
 delete mode 100644 lib/table/rte_table_lpm.c
 delete mode 100644 lib/table/rte_table_lpm.h
 delete mode 100644 lib/table/rte_table_lpm_ipv6.c
 delete mode 100644 lib/table/rte_table_stub.c
 delete mode 100644 lib/table/rte_table_stub.h
 delete mode 100644 lib/table/table_log.c
 delete mode 100644 lib/table/table_log.h

--
2.53.0
