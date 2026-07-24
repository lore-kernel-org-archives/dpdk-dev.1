Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA37C531FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 07:58:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53BEA402A7;
	Fri, 24 Jul 2026 09:58:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0AB9E4029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 09:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784879935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8g8siQi688NLIBy1hg0vsoOtcnfVrxogS+oFrhAbTKc=;
 b=AVhyTf4KVEWL6lAiY4AWu8Xh5uC1gbW0QyjAO1I9APf3bG6u7qZE7QtEOCMtRWFrUge6he
 Hk+Zbb4Dsnu9GLpr6Vx743pE9RHl9VKdQPq/9cMrPbRfyqTVcjfPAAS35K1obaRNPzUzfZ
 daxYcSsc7Bu0d9tBV2SP25MiAy3m8vE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-fDY7vCfcOW6v1-GkO_cIZQ-1; Fri, 24 Jul 2026 03:58:53 -0400
X-MC-Unique: fDY7vCfcOW6v1-GkO_cIZQ-1
X-Mimecast-MFC-AGG-ID: fDY7vCfcOW6v1-GkO_cIZQ_1784879932
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39cbf7e02d4so995241fa.1
 for <dev@dpdk.org>; Fri, 24 Jul 2026 00:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784879932; x=1785484732;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8g8siQi688NLIBy1hg0vsoOtcnfVrxogS+oFrhAbTKc=;
 b=mQJ9VMIL1I0ArwyH0L1fN1kL6TuGkD572T7sEUEZg8nmXMSFvCOYOAjV0lXgEeJPGw
 RDCNz/n2rSOTFsWGK5vcPaYWVtaWXNXu+3YMBeEboftOzSQp9DOl/997Hvzqsvl43Xal
 +ZSoTVHOIung6+vDEBdDl/dz9NRWIrQjr2s+mncB0gtb3bZbyuAVY4TqKKf/FJMogZF9
 Xh6cqeAwPb62Pvpm5pwjQUJLDcIRC1zyvhxiF98bUlEiwV1lXMSqLizgMtDp0xsKS60M
 aWPdUys0HJgvdejZWj6PK8Kik4fOJbeiqTRCJb3y3Ucw5+tlW4v4d1bmmSdBSb3FKUnL
 Fa6A==
X-Gm-Message-State: AOJu0YyohCbgxp+6W+vERkh0GucXfT3sB2NQ4QqYOb1NpJeJbMgGtZyx
 /OP4Ui7Ro4wZOm5nQUNkdzOP/nUc7NX2yC3dJPXSH+E4aooCpHbQNdSAxPbI7Nl6MgdYtp3yaMp
 Wiaizp2LdojNCsBdR6O3RhEfrNRthCwBR9QVOZ0Fdkw3vMpE87+QYEhlnm2kDGiDDLEEJw/HVPl
 Zoxaj/ok8to+uWR1vhBCI=
X-Gm-Gg: AR+sD108JVIkl+gtvrjWO5Hu50mDkwFVMit4BRxNrlnEKhCHnfPAHF76SqWD89S1Xdz
 9nS8P3QY9ZzrELCVV2eyWci3Fq/SFJPXQO707IRuFm2fK+D6oTHJMcNO8mpZi3bQOrIVbE4BUeN
 UajwsXBPSPJA9qa9xAbIuRfuglqymiHS6zxry+gROcdXaA75qaHe9Ii1fHbdy8NwptSAZgyIp3q
 4sRGhDNY08yojdtpGN8Ft0ApF++bRg0NqPi/81pQLa9PiVB
X-Received: by 2002:a05:651c:1062:b0:39b:374a:afad with SMTP id
 38308e7fff4ca-39f07f10700mr10692741fa.29.1784879932039; 
 Fri, 24 Jul 2026 00:58:52 -0700 (PDT)
X-Received: by 2002:a05:651c:1062:b0:39b:374a:afad with SMTP id
 38308e7fff4ca-39f07f10700mr10692591fa.29.1784879931504; Fri, 24 Jul 2026
 00:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240821162516.610624-17-rjarry@redhat.com>
 <20241018140553.79789-1-rjarry@redhat.com>
 <CAJFAV8xoauhZtuZLbN3=0HSxWxWW4Ci-Ts8yzjxag3YHWCUBug@mail.gmail.com>
In-Reply-To: <CAJFAV8xoauhZtuZLbN3=0HSxWxWW4Ci-Ts8yzjxag3YHWCUBug@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 09:58:39 +0200
X-Gm-Features: AUfX_myDiHXIzd_IsDzDXWXYBx3KkMxkpDkkZkNnw5vw0p2n9Wk2Pl4QXmfUQ-I
Message-ID: <CAJFAV8w4v3CiKNU9vjb=FZQErNhuhOdZuo6p_Z5vje4nN7kutw@mail.gmail.com>
Subject: Re: [PATCH dpdk v5 00/17] IPv6 APIs overhaul
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: khEmv9jRjjHIMa61E74WsW2ZfoBVG2FAE_BD_Dx4rQI_1784879932
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 18 Oct 2024 at 18:06, David Marchand <david.marchand@redhat.com> wr=
ote:
> On Fri, Oct 18, 2024 at 4:06=E2=80=AFPM Robin Jarry <rjarry@redhat.com> w=
rote:
> >
> > Hi everyone,
> >
> > As discussed recently [1], here is a first draft of the IPv6 APIs rewor=
k. The
> > API change was announced before the 24.07 release [2]. This series is i=
ntended
> > for 24.11.
> >
> > [1] http://inbox.dpdk.org/dev/D2SR8T1H39CJ.JRQFI6JEH0OX@redhat.com/
> > [2] https://git.dpdk.org/dpdk/commit/?id=3D835d4c41e0ab58a115c2170c886b=
a6d3cc1b5764
> >
> > I tried to keep the patches as small as possible; unfortunately some of=
 them
> > are quite big and cannot be broken down if we want to preserve a bisect=
able
> > tree.
> >
> > Thanks!
> >
> > Cc: Bruce Richardson <bruce.richardson@intel.com>
> > Cc: Ferruh Yigit <ferruh.yigit@amd.com>
> > Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > Cc: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > Cc: Stephen Hemminger <stephen@networkplumber.org>
> > Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> >
> > Changelog:
> >
> > v5:
> >
> > - rebase on e214d58eb87b ("net: improve VLAN header type alignment")
> > - fix include ordering
> > - improve doxygen api
> > - fix RTE_IPV6_U16_SPLIT to make sparse happy about 0xffff literals bei=
ng truncated
> > - reformat macros with \ only separated with a space
> > - update changelog with deprecated symbols and their replacements, if a=
ny
> >
> > Robin Jarry (17):
> >   net: split raw checksum functions in separate header
> >   net: split IPv4 and IPv6 symbols in separate headers
> >   net: add IPv6 address structure and utils
> >   net: use IPv6 structure for packet headers
> >   lpm6: use IPv6 address structure and utils
> >   fib6: use IPv6 address structure and utils
> >   rib6: use IPv6 address structure and utils
> >   cmdline: use IPv6 address structure
> >   node: use IPv6 address structure and utils
> >   pipeline: use IPv6 structures
> >   ipsec: use IPv6 address structure
> >   security: use IPv6 address structure
> >   hash: use IPv6 address structure
> >   gro: use IPv6 address structure
> >   flow: use IPv6 address structure
> >   net: add utilities for well known IPv6 address types
> >   net: add function to check IPv6 version
> >
> >  MAINTAINERS                              |    1 +
> >  app/graph/ethdev.c                       |   44 +-
> >  app/graph/ethdev.h                       |    9 +-
> >  app/graph/ip6_route.c                    |   51 +-
> >  app/graph/meson.build                    |    2 +-
> >  app/graph/neigh.c                        |   21 +-
> >  app/graph/neigh_priv.h                   |    4 +-
> >  app/graph/route.h                        |    8 +-
> >  app/test-fib/main.c                      |   74 +-
> >  app/test-flow-perf/actions_gen.c         |    4 +-
> >  app/test-flow-perf/items_gen.c           |    4 +-
> >  app/test-pipeline/pipeline_hash.c        |    4 +-
> >  app/test-pipeline/pipeline_lpm_ipv6.c    |   11 +-
> >  app/test-pmd/cmdline.c                   |    4 +-
> >  app/test-pmd/cmdline_flow.c              |   14 +-
> >  app/test-pmd/testpmd.h                   |   16 +-
> >  app/test-sad/main.c                      |   24 +-
> >  app/test/meson.build                     |    1 +
> >  app/test/packet_burst_generator.c        |    4 +-
> >  app/test/test_cmdline_ipaddr.c           |   49 +-
> >  app/test/test_fib6.c                     |   92 +-
> >  app/test/test_fib6_perf.c                |    8 +-
> >  app/test/test_ipfrag.c                   |    4 +-
> >  app/test/test_ipsec_sad.c                |   46 +-
> >  app/test/test_lpm6.c                     |  490 +++---
> >  app/test/test_lpm6_data.h                | 2025 +++++++++++-----------
> >  app/test/test_lpm6_perf.c                |   10 +-
> >  app/test/test_net_ip6.c                  |  195 +++
> >  app/test/test_reassembly_perf.c          |   23 +-
> >  app/test/test_rib6.c                     |   55 +-
> >  app/test/test_table_combined.c           |    2 +-
> >  app/test/test_table_tables.c             |    8 +-
> >  app/test/test_thash.c                    |   46 +-
> >  doc/api/doxy-api-index.md                |    4 +-
> >  doc/guides/prog_guide/ipsec_lib.rst      |    4 +-
> >  doc/guides/rel_notes/deprecation.rst     |   42 -
> >  doc/guides/rel_notes/release_24_11.rst   |   61 +
> >  drivers/common/cnxk/cnxk_security.c      |   14 +-
> >  drivers/net/bnxt/bnxt_flow.c             |   12 +-
> >  drivers/net/bonding/rte_eth_bond_pmd.c   |    6 +-
> >  drivers/net/cxgbe/cxgbe_flow.c           |   18 +-
> >  drivers/net/dpaa2/dpaa2_flow.c           |   22 +-
> >  drivers/net/hinic/hinic_pmd_flow.c       |    6 +-
> >  drivers/net/hinic/hinic_pmd_tx.c         |    2 +-
> >  drivers/net/hns3/hns3_flow.c             |    8 +-
> >  drivers/net/i40e/i40e_flow.c             |   12 +-
> >  drivers/net/iavf/iavf_fdir.c             |    8 +-
> >  drivers/net/iavf/iavf_fsub.c             |    8 +-
> >  drivers/net/iavf/iavf_ipsec_crypto.c     |    9 +-
> >  drivers/net/ice/ice_fdir_filter.c        |   12 +-
> >  drivers/net/ice/ice_switch_filter.c      |   16 +-
> >  drivers/net/igc/igc_flow.c               |    4 +-
> >  drivers/net/ixgbe/ixgbe_flow.c           |   12 +-
> >  drivers/net/ixgbe/ixgbe_ipsec.c          |    4 +-
> >  drivers/net/mlx5/hws/mlx5dr_definer.c    |   36 +-
> >  drivers/net/mlx5/mlx5_flow.c             |    6 +-
> >  drivers/net/mlx5/mlx5_flow_dv.c          |   16 +-
> >  drivers/net/mlx5/mlx5_flow_hw.c          |   10 +-
> >  drivers/net/mlx5/mlx5_flow_verbs.c       |    8 +-
> >  drivers/net/mvpp2/mrvl_flow.c            |   16 +-
> >  drivers/net/nfp/flower/nfp_flower_flow.c |   34 +-
> >  drivers/net/nfp/nfp_ipsec.c              |    4 +-
> >  drivers/net/nfp/nfp_net_flow.c           |   38 +-
> >  drivers/net/qede/qede_filter.c           |    4 +-
> >  drivers/net/sfc/sfc_flow.c               |   22 +-
> >  drivers/net/tap/tap_flow.c               |   10 +-
> >  drivers/net/txgbe/txgbe_flow.c           |   12 +-
> >  drivers/net/txgbe/txgbe_ipsec.c          |    4 +-
> >  examples/cmdline/commands.c              |   30 +-
> >  examples/ip_fragmentation/main.c         |   23 +-
> >  examples/ip_pipeline/cli.c               |   61 +-
> >  examples/ip_pipeline/parser.c            |    2 +-
> >  examples/ip_pipeline/parser.h            |    3 +-
> >  examples/ip_pipeline/pipeline.c          |   16 +-
> >  examples/ip_pipeline/pipeline.h          |    6 +-
> >  examples/ip_pipeline/thread.c            |   15 +-
> >  examples/ip_reassembly/main.c            |   23 +-
> >  examples/ipsec-secgw/flow.c              |   45 +-
> >  examples/ipsec-secgw/ipsec.c             |   33 +-
> >  examples/ipsec-secgw/ipsec.h             |    5 +-
> >  examples/ipsec-secgw/ipsec_lpm_neon.h    |    7 +-
> >  examples/ipsec-secgw/ipsec_worker.c      |   11 +-
> >  examples/ipsec-secgw/ipsec_worker.h      |    4 +-
> >  examples/ipsec-secgw/parser.c            |    2 +-
> >  examples/ipsec-secgw/parser.h            |    4 +-
> >  examples/ipsec-secgw/rt.c                |   24 +-
> >  examples/ipsec-secgw/sa.c                |   37 +-
> >  examples/ipsec-secgw/sad.h               |   14 +-
> >  examples/ipsec-secgw/sp6.c               |  154 +-
> >  examples/l3fwd-graph/main.c              |   33 +-
> >  examples/l3fwd/l3fwd_fib.c               |   39 +-
> >  examples/l3fwd/l3fwd_lpm.c               |    8 +-
> >  examples/l3fwd/l3fwd_route.h             |    9 +-
> >  examples/l3fwd/lpm_route_parse.c         |    9 +-
> >  examples/l3fwd/main.c                    |   32 +-
> >  lib/cmdline/cmdline_parse_ipaddr.h       |    3 +-
> >  lib/ethdev/rte_flow.h                    |   22 +-
> >  lib/fib/meson.build                      |    3 +-
> >  lib/fib/rte_fib6.c                       |   19 +-
> >  lib/fib/rte_fib6.h                       |   16 +-
> >  lib/fib/trie.c                           |  117 +-
> >  lib/fib/trie.h                           |   19 +-
> >  lib/fib/trie_avx512.c                    |   38 +-
> >  lib/fib/trie_avx512.h                    |   10 +-
> >  lib/gro/gro_tcp6.c                       |    8 +-
> >  lib/gro/gro_tcp6.h                       |    6 +-
> >  lib/hash/rte_thash.h                     |   28 +-
> >  lib/ip_frag/rte_ipv6_reassembly.c        |    4 +-
> >  lib/ipsec/rte_ipsec_sad.h                |    5 +-
> >  lib/lpm/meson.build                      |    1 +
> >  lib/lpm/rte_lpm6.c                       |  148 +-
> >  lib/lpm/rte_lpm6.h                       |   19 +-
> >  lib/net/meson.build                      |    3 +
> >  lib/net/rte_cksum.h                      |  180 ++
> >  lib/net/rte_ip.h                         |  840 +--------
> >  lib/net/rte_ip4.h                        |  381 ++++
> >  lib/net/rte_ip6.h                        |  798 +++++++++
> >  lib/node/ip6_lookup.c                    |   21 +-
> >  lib/node/rte_node_ip6_api.h              |    3 +-
> >  lib/pipeline/rte_swx_ipsec.c             |   10 +-
> >  lib/pipeline/rte_swx_ipsec.h             |    5 +-
> >  lib/pipeline/rte_table_action.c          |   44 +-
> >  lib/pipeline/rte_table_action.h          |    7 +-
> >  lib/rib/meson.build                      |    2 +-
> >  lib/rib/rte_rib6.c                       |  112 +-
> >  lib/rib/rte_rib6.h                       |   27 +-
> >  lib/security/rte_security.h              |    5 +-
> >  lib/table/rte_table_lpm_ipv6.c           |   12 +-
> >  lib/table/rte_table_lpm_ipv6.h           |    7 +-
> >  129 files changed, 3928 insertions(+), 3501 deletions(-)
> >  create mode 100644 app/test/test_net_ip6.c
> >  create mode 100644 lib/net/rte_cksum.h
> >  create mode 100644 lib/net/rte_ip4.h
> >  create mode 100644 lib/net/rte_ip6.h

After almost two years, the next LTS release looks like a good time to
drop the deprecated stuff in the rib library.

$ git grep -i deprecated lib/rib/
lib/rib/rte_rib6.h:#define RTE_RIB6_IPV6_ADDR_SIZE
(RTE_DEPRECATED(RTE_RIB6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
lib/rib/rte_rib6.h:     __rte_deprecated_msg("use direct struct assignment"=
);
lib/rib/rte_rib6.h:     __rte_deprecated_msg("use rte_ipv6_addr_eq");
lib/rib/rte_rib6.h:static inline uint8_t get_msk_part(uint8_t depth,
int byte) __rte_deprecated;

Could you send a patch please?


--=20
David Marchand

