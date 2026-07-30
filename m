Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4605EC55162
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 16:23:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05C3C40276;
	Thu, 30 Jul 2026 18:23:16 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id A59D640274
 for <dev@dpdk.org>; Thu, 30 Jul 2026 18:23:14 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9e30214d8fso1802627a12.3
 for <dev@dpdk.org>; Thu, 30 Jul 2026 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785428593;
 x=1786033393; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VRZ0FPsY+G8d7bRMCuCmBNs+ZCnOH+nazDooMNlk4sQ=;
 b=HI4F5FPudk0wIHNKeZTHJnFiQnyofb104tISR/tylyHTq/YYXFyGZAbO9+Kc9cVs1E
 R6/nd5ZSgFIRxx2DOfM/kJq6Jy+8NSph76+91Cc8wgeIvl5V8GlKIB4r1nQOSREMjVGK
 gnBHH0baDyqmk3eyR83TT3tBZCgJgRFg+1XoCPeol7iEeC6OIunpkaP3EM3BELLNx6L6
 ubpMfQq6K2I0LRQdLsJ9SHHyaihPkAhD7Lkr+LLFPBp0t4k1S+i9edbTFsj/aJbt/kSD
 nWWfXklrnC246IAhyTvt09gaK1G8j9f4xChZvbMmhDK/gWcjspET4id1l6sLWC9Cp9xg
 OGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785428593; x=1786033393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VRZ0FPsY+G8d7bRMCuCmBNs+ZCnOH+nazDooMNlk4sQ=;
 b=nu6YvXXHp1rKnAv4MFkC9kLoVA8V2qfm+d8yGx9geW0ccPpVBndYsDY3pOLVkBCG0a
 Wqz3EgGfYR1CciAEFRHip0LAA8NIqMAbP8X8IYRmMka+bnhPSAyA9G7WCP/bjs8ERxNo
 F+ciKwlb2sLI74mXvkWk+dVb97zaZNqbTA1VPBsTfzuHRCKh9+ECJJtNWGsfmSUksCtE
 y71Ubl4h6Lh/7tqHEs4xZk/pdcQcxw++B2MmHl/GoS3t6DwQ2cIG5o3z44ZeUpMOiNYk
 yftcWzOdVuHaBwJQG9TzSRj7dz+jte3csSYB3EMqMVEVHnDiKVUgHecjzNTixNQPozu0
 V42A==
X-Gm-Message-State: AOJu0YxeSVvZLhMQLtJ0AGvezOTO1KJfUw1hrcHH4dIjBIQm92LoN1C5
 gErBmO+Lk6uH5m3zFpoZ9YraCzo5YWwQg2OCXAMNCycuMEdU9gAFWOKByYoTOug0B3f+k2ZlPkV
 YXd4a
X-Gm-Gg: AR+sD12vcBryHiOUGGlYmfCVuxA+kwcX+bS0j9XvnRS0yMdW99nvDxIpdOfBAhBf+XD
 iEcygDJeirL2Ffu6dCj4CO9fRjRk58BpXZSotd9IpDtmWeL/+MOCSXHKDfxrqidYtKoL2FSZjOn
 PIeSAk8RxGhDsLKMQb0tGzSNgF61Elfy9ZY8qoHKmRrOuWDnpg+UEE5qvEr0b2OED7qpZZzNq8A
 AdVaIlXg6LOAgVNtgYRaonKVCgDmenGRyn4rVQ1psXwdpwM3xCZ4orfqcktoZ1To0b7NEmL50rj
 nNRb/vMO04FNsWTfbyQWT/S2hcUlE72M6aP7q9MtWpsW7s2Ox7h7ZOXNDA/t/Z/sNcGp0wghvy6
 vfCEHnQRnHOV+k5N2DhW6vQ+T6y08nKGjBkM13/wlUSlxCwX5SWyFyQvKNe1FNM1sdZrHRaBtow
 0cEaxaN8aP626rKY3x69p7Wn6ksRW7zb2n3QHfZkWPsXd/FYcNrXQfHPMc1wH/NFAaX7wWTzepm
 u4IAeeD2MbivxBpFD8dpW+Dltw=
X-Received: by 2002:a05:6a21:600b:b0:3c0:b766:74f4 with SMTP id
 adf61e73a8af0-3c9007b4c82mr3351700637.31.1785428593511; 
 Thu, 30 Jul 2026 09:23:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm24576848eec.4.2026.07.30.09.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:23:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/6] remove deprecated packet framework
Date: Thu, 30 Jul 2026 09:22:28 -0700
Message-ID: <20260730162311.313350-1-stephen@networkplumber.org>
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

The legacy Packet Framework APIs were announced for removal in the
24.11 release but the removal never happened:

* pipeline: The pipeline library legacy API (functions rte_pipeline_*)
* table: The table library legacy API (functions rte_table_*)
* port: The port library legacy API (functions rte_port_*)

Do the removal now, in the 26.11 ABI window. The SWX API in the same
libraries (rte_swx_*) is unaffected and remains the Packet Framework
API. The softnic driver and the pipeline example already use only the
SWX API.

The applications built on the legacy API (test-pipeline, ip_pipeline)
and the unit tests are removed first, then the legacy half of each
library, pipeline before table before port to follow the dependency
chain. Library dependencies and the programmer's guide are trimmed
accordingly.

Follow-up candidates, kept out of this series: the stale comments in
lib/ethdev/ethdev_trace.h still refer to examples/ip_pipeline, and
struct rte_pipeline_acl_rule in the removed rte_table_acl.c was only
a local name.

Note: there are some figures leftover that will need maintainer
to manually remove with 'git rm' since patchwork mangled that.

v6 - rebase and cleanup some leftovers

Stephen Hemminger (6):
  app/test: remove packet framework tests
  app/test-pipeline: remove application
  examples/ip_pipeline: remove example
  pipeline: remove legacy API
  table: remove legacy API
  port: remove legacy API

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
 devtools/cocci/nullfree.cocci                 |   12 -
 doc/api/doxy-api-index.md                     |   17 -
 doc/guides/nics/softnic.rst                   |    3 +-
 doc/guides/prog_guide/packet_framework.rst    | 1146 +--
 doc/guides/rel_notes/deprecation.rst          |   15 -
 doc/guides/rel_notes/release_26_11.rst        |   17 +
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
 lib/table/rte_table_lpm_ipv6.h                |   92 -
 lib/table/rte_table_stub.c                    |   95 -
 lib/table/rte_table_stub.h                    |   30 -
 lib/table/table_log.c                         |    7 -
 lib/table/table_log.h                         |   11 -
 128 files changed, 27 insertions(+), 45481 deletions(-)
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
 delete mode 100644 lib/table/rte_table_lpm_ipv6.h
 delete mode 100644 lib/table/rte_table_stub.c
 delete mode 100644 lib/table/rte_table_stub.h
 delete mode 100644 lib/table/table_log.c
 delete mode 100644 lib/table/table_log.h

--
2.53.0
