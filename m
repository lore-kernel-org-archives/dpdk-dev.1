Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4653CC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:42:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEBFE402DF;
	Thu, 15 Oct 2026 19:42:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 086F84027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:42:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792086133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1cLwJdu9KApxu+hw66TCK7Jk/O4CfMCiQfFusgmAVI=;
 b=EsXZedsccp+Kft6RY1o4vLlu9Pn4qn/ORc1trcZYJJKmh2MqnFGBx9ZvOtTsmf8Xv9iPGM
 QZl8k80jlbaiRQbYT4G/ue+VPPsemMTnsi0MpXLDpmorF29hfypRScXmyRZUD0pLrhJbYb
 9Hk4WB9jpZOxJF2sdgbIzaPbIYiN9cA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-WUUYAguIO6mRR1mIXhyl9A-1; Thu, 15 Oct 2026 17:42:06 +0000
X-MC-Unique: WUUYAguIO6mRR1mIXhyl9A-1
X-Mimecast-MFC-AGG-ID: WUUYAguIO6mRR1mIXhyl9A_1792086125
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a58fef21b3so12690941fa.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086125; x=1792690925;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M1cLwJdu9KApxu+hw66TCK7Jk/O4CfMCiQfFusgmAVI=;
 b=gW3cTG6BoMI2oBApEcVnn8WZQ4AcOdOrIuwhfnI44Mb68PhPVrCOgO+r0UPAfL3Svb
 nabolHf17qywyPYn04wdOeS0n1QXZf6W3b8MS/gPUku7Wnn2Z29XJBkA94IIEjx/e0Z9
 fjbEnYfbr1G6+HzFPBPuhQV2ut6d6tcw0MAVvq4CwFiYEXzTqCXrSI2JEP69tG1x5dua
 RUuj5RCtEQlj3JH6aQvxqmdvhpK7D51QVVU4dbxwJCqc/QobucM1T8fgiGYghTIBhdrs
 UtrisPFLbnsuzWUiVhm5x/GSxgFOjzcxH1nNDPyaZnwF29bavmXP7BSIB9AIWoAIWfGs
 vwIQ==
X-Gm-Message-State: AFq9FYIeAyDDIcdNf+zMiPdB9MlZIdaZNz/6GqbcuovK+JZn2A8mwTCI
 G5p5ZOHpvl1MZJCiz+I5V2WrtvO0HWjtUgfr8XlIXZeoZ71Q/CyBRETMoBBG8IYz+x7zeFcMBtW
 BRLUjc4dJx3gGdA2HMUGaijMhkv7FGXXEOolkgESB+Hf+b+2ZsAzY67yPZM8+qbuzVnUhXefeDS
 WxNSSRNhWzh0hZVQXqwHs=
X-Gm-Gg: AYBFou31itMrNumlj2zXtRbdkg0/RTxPNoJwsFIIppt0mjRqWNsYXcGJ9KPvShiAEnN
 5ZJecffz1CSmtj9RwO3fyYwyejGndDeMxsNmCMLCSsYLuOoa42fIfTSkrmxcTQ/UlXlHDqzneKB
 +RuZDlq5uB4CR7jYZQLLARjtPtuPPVZWab0jFHdfCLeojAxbelzTJ2b5Pf+gacMGVlw14Od76kt
 8UoNtxkE/eUxrfjI9fWwfCUytHKbVy2qnS1FUU+EeCbxq89
X-Received: by 2002:a2e:bc1b:0:b0:3a6:6d05:7375 with SMTP id
 38308e7fff4ca-3a9c515ce0dmr45512451fa.8.1792086124624; 
 Thu, 15 Oct 2026 10:42:04 -0700 (PDT)
X-Received: by 2002:a2e:bc1b:0:b0:3a6:6d05:7375 with SMTP id
 38308e7fff4ca-3a9c515ce0dmr45512341fa.8.1792086124128; Thu, 15 Oct 2026
 10:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260717090326.1860634-1-rjarry@redhat.com>
 <20261015143122.3197430-5-rjarry@redhat.com>
In-Reply-To: <20261015143122.3197430-5-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 19:41:52 +0200
X-Gm-Features: AclHuK_EPsJ7wpMw6pIe4tWMtY7zFKd3BM1drT4fXQKmL-1WB9a--fEw3HQtaJw
Message-ID: <CAJFAV8z+zv=og5mT4GRd2uR4XPJ2vBKDLSGYeU8a+P+GMC9bdA@mail.gmail.com>
Subject: Re: [PATCH dpdk/26.11 v4 0/2] graph: topological bitmap scheduling
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Christophe Fontaine <cfontain@redhat.com>,
 Jerin Jacob <jerinj@marvell.com>, 
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Maxime Leroy <maxime@leroys.fr>, 
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0bdzqu-67Cv065ZvrGs7yuKPGU7PO1zbFsx37IFL7cU_1792086125
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

On Thu, 15 Oct 2026 at 16:32, Robin Jarry <rjarry@redhat.com> wrote:
>
> Replace the FIFO circular buffer in rte_graph with a bitmap and a
> topologically-sorted schedule table. The old circular buffer appended
> nodes in enqueue order, effectively a partial DFS driven by per-node
> process functions. This caused convergence nodes to be visited before
> all upstream branches had run, resulting in redundant visits with
> smaller batches.
>
> Nodes are now sorted by (topo_order, node_id) using BFS depth from
> source nodes, ensuring upstream nodes are always visited before
> downstream ones. The diamond perf test shows a ~10% throughput
> improvement (converge visited once at 256 objs/call instead of twice
> at 128).
>
> Changes v3 -> v4:
>  - fixed check_includes error after RTE_PTR_ADD() changes
>  - s/__rte_always_inline/inline/ to fix checkpatch warnings
>  - removed entry from deprecation notice
>  - added release notes entries
>
> Changes v2 -> v3:
>  - dropped explicit priority field (int16_t) from rte_node_register
>    and struct node; topological ordering from BFS is sufficient
>  - removed hiprio worker node type from diamond test; topo_order
>    alone provides correct ordering without user intervention
>  - updated documentation and SVG diagram accordingly
>
> Changes v1 -> v2:
>  - split diamond perf test into separate preparatory patch
>  - added topological depth (topo_order) as secondary sort key to
>    preserve upstream-before-downstream ordering, preventing a
>    regression in the reverse tree test
>  - restored idx == 0 guard on bitmap set in the enqueue path to
>    avoid a ~15% throughput regression caused by touching the pending
>    bitmap cache line on every enqueue call
>  - added performance numbers measured before and after
>
> Cc: Christophe Fontaine <cfontain@redhat.com>
> Cc: David Marchand <david.marchand@redhat.com>
> Cc: Jerin Jacob <jerinj@marvell.com>
> Cc: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
> Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Cc: Maxime Leroy <maxime@leroys.fr>
> Cc: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
> Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> Cc: Zhirun Yan <yanzhirun_163@163.com>
>
> Robin Jarry (2):
>   graph: add diamond topology performance test
>   graph: replace circular buffer with topological bitmap
>
>  app/test/test_graph_perf.c                    |  130 +-
>  doc/guides/prog_guide/graph_lib.rst           |   29 +-
>  .../prog_guide/img/graph_mem_layout.svg       | 1823 +++++++----------
>  doc/guides/rel_notes/deprecation.rst          |    8 -
>  doc/guides/rel_notes/release_26_11.rst        |   11 +
>  lib/graph/graph.c                             |   27 +-
>  lib/graph/graph_debug.c                       |   12 +-
>  lib/graph/graph_ops.c                         |   46 +
>  lib/graph/graph_populate.c                    |  107 +-
>  lib/graph/graph_private.h                     |   41 +-
>  lib/graph/rte_graph_model_mcore_dispatch.h    |   34 +-
>  lib/graph/rte_graph_model_rtc.h               |   63 +-
>  lib/graph/rte_graph_worker.h                  |    2 +-
>  lib/graph/rte_graph_worker_common.h           |   80 +-
>  14 files changed, 1170 insertions(+), 1243 deletions(-)

Series applied, thanks.


-- 
David Marchand

