Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B6CD98F0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 05:13:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C1BA4014F;
	Tue, 23 Jun 2026 07:13:49 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id D88914003C
 for <dev@dpdk.org>; Tue, 23 Jun 2026 07:13:47 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-9225cc6fbb8so232685485a.2
 for <dev@dpdk.org>; Mon, 22 Jun 2026 22:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782191627; cv=none;
 d=google.com; s=arc-20240605;
 b=CuCMl7s1q6zqlIhMoRp8c6fxNZfO0FH2h2imqNAyekNZeAbCBrYrqKf+SEzEyCksr9
 WltT3djWmaCqgkCv317lEl5/HtthTAWnIMZwOIUj4VKkEMCrq0MN6z4C2/N6I0OhJ8GQ
 9HUY+mhfshX8jRT9WrP9l942bKifcRaIOQ5V0ON7BPvnwzeDmSZJp80T5uWVsSj1tu+5
 IbhGVL0cVwsXm90cjlssgmHvp58Z4ynCjCim3KHaRU9iYhY2ej91SyvH6mWnJd0kEuHy
 8Z0TnW4so1NWgsOgS7a92C6oSQ1VtG92wzSEa4NmCaasZ/WjzdDNYADXrlTyfVnSuLZt
 hyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WRHwW33cKf7GfW57fkWhbET3dqQJO4A4rUrK0BrSgJU=;
 fh=JUruITkHmm9WOEqXVGAxfUeC/dKwGe9fpiGCN0yWOn8=;
 b=W8eh9AL7w4PtQzf5ifzV98MRGHL055SnGcQNAYJx4Ge45roIhxFao8QtG9xqqlVlp7
 3zWSsdB+zz9IkhzvhnYInteKIytsHdK6PU+5USBv6ICM2t/wxat6MvuY1uVSEnDjK+f6
 7BbL0e924zvx/dJCTzGttg3cp3vHXrXa7znanEojLgBBlGbwBejI2cZ4lDaMquR8sqik
 ob2eO5B4oVVyYpcK3q7qQswMLwabHKRjjoabUyNTMZM8RH82lPjGImohF3yfmSNJLzqC
 R+Y5/Q3EQq7aQkpo08auDU72yxmciHkathlI4gwe+pH/iw6gEw1hZw3cd2AAzmxdOuHR
 AOoQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782191627; x=1782796427; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRHwW33cKf7GfW57fkWhbET3dqQJO4A4rUrK0BrSgJU=;
 b=Ud6lyRUwtT3l7I8QTHdrtY4R7S8SAjcZAs465iCkX4mHv5a7my5Lsso6tcFZ3tgl9W
 dg7QedjqtBS46sn/5+8sdWrPtknFMzLzxNTsliNvInQqxBURc8teJjvr/Fe3XMEY4PCP
 L4Km2N4sJ+/3kxa/gk6W1IS7gleIhBCEu68UgxQUw/oYuQpHDCnvd7ixVTSI5xKQlcyM
 yfFCGIZE6AhHE7Ca4ZNNjvx1JXrKLA50rNBzVun+1KPx412o8U/nlIdagC8z2aO9VjXx
 2tyHmBjmpumSr6ygKMLTf41AgU/a8FNgHgGtDJd1G6ZtRO2hJiiXON59cGd61FDv2un4
 WMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782191627; x=1782796427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WRHwW33cKf7GfW57fkWhbET3dqQJO4A4rUrK0BrSgJU=;
 b=IeJVMPLWiEfJLEsLKpd5r2EIPLZjZlJKrT4CgYiFRaydWzkL/tLi2KkHZ1ypMVTcal
 MyFbF5nnjRw1VrH+YuzeU68Some6jnDmB+XwR2lwridO/hVQJeDwPbGcjD/5CraWR5y3
 ihWFEbyCXafoPLrSmTvh/jnj901v6o8b5ng0TyH2Cus+0oC+Y7CMa99JZg7W3ktC6QXW
 3qUS3QEfEZM4BjFzhe3zP1I1GfYieEdhHV6yDjT88LKFLQbGWMYafWjsDAMT01y26GDn
 CzHkIBjE69jE79jXGWdYAuddGxrars8btkrfwx9XGcsndzJttwKSvdbUbWH0AtJOzlob
 1xjQ==
X-Gm-Message-State: AOJu0YzmuZLjAzT8WdjzwImP6DvSksfN3vlEuKQMh05rx3rj+betoR4b
 Z1KHuRncogycaM+G5EoH4XthgJSKH2YWdu0mkhBAbBeF4M4u/6IWBFc1laL2bDvUBFYJyp0CrdK
 G4vUHfYVisvz0Hen45JYNTzXJrsOW88Y=
X-Gm-Gg: AfdE7clbhYzxsXqDwO/Fg1iuVX2HHZXPiZMVejSpQcTL4276tNJsosgCWMMTx+ovZGr
 CNYMmwSIsle/UjSmpWLhu6bunSejnMdYrwsL7nlqPTP2q8TOxPJVgrz3ZDu/JUCEw0a21ACfJOr
 aYpEdWjlpStQtgkFSopq5RSJCOYTWNTpvL+lsH+QSRbcoIaxM5IK9snHMHKrO4niZ+u7YQiKrZq
 UyyiyXgTuZwWvh0p6g2KSIrCBrVvyMWqwQcM79rUhGDE+XsElew3XNJnO5Z/6Zi9ep+
X-Received: by 2002:a05:620a:2812:b0:915:9273:9239 with SMTP id
 af79cd13be357-921d0f48d41mr2297161085a.13.1782191626933; Mon, 22 Jun 2026
 22:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260621184140.2878132-1-mb@smartsharesystems.com>
In-Reply-To: <20260621184140.2878132-1-mb@smartsharesystems.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 23 Jun 2026 10:43:19 +0530
X-Gm-Features: AVVi8CcX5rx6Ky9BkKGweDSKdSQRbqP7mcEzWREyqMMHR3hwCXj2f7nD1q-LjRo
Message-ID: <CALBAE1OCbZ9GB1oGYgR5hRtzjRmev2ZFOaSNndf02AZptihOcw@mail.gmail.com>
Subject: Re: [PATCH v5] graph: add optional profiling stats
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
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

On Mon, Jun 22, 2026 at 12:11=E2=80=AFAM Morten Br=C3=B8rup <mb@smartshares=
ystems.com> wrote:
>
> Added graph node profiling stats, build time configurable by enabling
> RTE_GRAPH_PROFILE in rte_config.h.
>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
> v5:
> * Added stats for a half burst and a full burst.
> v4:
> * Added documentation. (AI)
> * Added more comments. (AI)
> * Improved dump. (AI)
> * Debug shows both cycles/call and cycles/obj.
> v3:
> * Debug shows cycles/obj instead of cycles/call.
> * Fixed missing --in-reply-to.
> v2:
> * Fixed indentation.
> ---
>  config/rte_config.h                 |  1 +
>  doc/guides/prog_guide/graph_lib.rst |  1 +
>  lib/graph/graph_debug.c             | 57 ++++++++++++++++++++++++++++-
>  lib/graph/node.c                    |  2 +
>  lib/graph/rte_graph_worker_common.h | 33 +++++++++++++++--

Please update app/test/test_graph.c to validate this featue.

>  5 files changed, 90 insertions(+), 4 deletions(-)
>
> diff --git a/config/rte_config.h b/config/rte_config.h
> index 0447cdf2ad..1942c1b1ec 100644
> --- a/config/rte_config.h
> +++ b/config/rte_config.h
> @@ -106,6 +106,7 @@
>  /* rte_graph defines */
>  #define RTE_GRAPH_BURST_SIZE 256
>  #define RTE_LIBRTE_GRAPH_STATS 1
> +/* RTE_GRAPH_PROFILE is not set */
>
>  /****** driver defines ********/
>
> diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/=
graph_lib.rst
> index 8dd49c19d2..bc36042296 100644
> --- a/doc/guides/prog_guide/graph_lib.rst
> +++ b/doc/guides/prog_guide/graph_lib.rst
> @@ -49,6 +49,7 @@ Performance tuning parameters
>    RTE_GRAPH_BURST_SIZE config option.
>    The testing shows, on x86 and arm64 servers, The sweet spot is 256 bur=
st
>    size. While on arm64 embedded SoCs, it is either 64 or 128.
> +- Enable the ``RTE_GRAPH_PROFILE`` config option for more profiling deta=
ils.
>  - Disable node statistics (using ``RTE_LIBRTE_GRAPH_STATS`` config optio=
n)
>    if not needed.
>
> diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
> index e3b8cccdc1..7c97e23748 100644
> --- a/lib/graph/graph_debug.c
> +++ b/lib/graph/graph_debug.c
> @@ -92,7 +92,62 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool =
all)
>                         fprintf(f, "       total_sched_fail=3D%" PRId64 "=
\n",
>                                 n->dispatch.total_sched_fail);
>                 }
> -               fprintf(f, "       total_calls=3D%" PRId64 "\n", n->total=
_calls);
> +               fprintf(f, "       total_calls=3D%" PRIu64 "\n", n->total=
_calls);
> +               if (rte_graph_has_stats_feature()) {
> +                       fprintf(f, "       total_cycles=3D%" PRIu64 ", av=
g cycles/call=3D%.1f\n",
> +                                       n->total_cycles,
> +                                       n->total_calls =3D=3D 0 ? (double=
)0 :
> +                                       (double)n->total_cycles / (double=
)n->total_calls);
> +               }
> +#ifdef RTE_GRAPH_PROFILE


Please introduce rte_graph_has_profile_featue() similar to
rte_graph_has_stats_feature() to reduce if def clutter as possible.

> +               uint64_t calls =3D n->usage_stats[0].calls;
> +               fprintf(f, "       objs[0]\n");
> +               fprintf(f, "         calls=3D%" PRIu64 ", cycles=3D%" PRI=
u64 ", avg cycles/call=3D%.1f\n",
> +                               calls,

>
> diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_wo=
rker_common.h
> index 4ab53a533e..0d8039575d 100644
> --- a/lib/graph/rte_graph_worker_common.h
> +++ b/lib/graph/rte_graph_worker_common.h
> @@ -144,12 +144,26 @@ struct __rte_cache_aligned rte_node {
>                         rte_node_process_t process; /**< Process function=
. */
>                         uint64_t process_u64;
>                 };
> +               /** Fast path area cache line 3. */
> +#ifdef RTE_GRAPH_PROFILE
> +               struct {
> +                       uint64_t calls;     /**< Calls processing resp. 0=
 or 1 objects. */
> +                       uint64_t cycles;    /**< Cycles spent processing =
resp. 0 or 1 objects. */
> +               } usage_stats[2];       /**< Usage when this node process=
ed 0 or 1 objects. */
> +               uint64_t full_burst_calls;  /**< Calls processing a full =
burst of objects. */
> +               uint64_t full_burst_cycles; /**< Cycles spent processing =
a full burst of objects. */
> +               uint64_t half_burst_calls;  /**< Calls processing a half =
burst of objects. */
> +               uint64_t half_burst_cycles; /**< Cycles spent processing =
a half burst of objects. */
> +               /** Fast path area cache line 4. */
> +#endif

Is it an ABI breakage?

>                 alignas(RTE_CACHE_LINE_MIN_SIZE) struct rte_node *nodes[]=
; /**< Next nodes. */
>         };
>  };
>
