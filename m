Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFE0CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 01:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B9994026C;
	Wed, 20 Aug 2025 03:10:27 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 026A340151
 for <dev@dpdk.org>; Wed, 20 Aug 2025 03:10:26 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5005D211335B; Tue, 19 Aug 2025 18:10:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5005D211335B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1755652225;
 bh=WeJCWioVSq++fWuPJLEQBXVRb5+VLYtSKFuNEtE11mQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sJYK5dbsL+7ALzc2M6vOQniIXM5ksL0AWwQ2f6v3+ZzOKmVXUm/dtfBt4pN2b3PYK
 5WEJsc/pQecYd1FiGoMMpdYxZUVn99ATFpBS8g1C2+khB23FSWMdae9VftKCY+rRVT
 M2hnWt8J05ltIH7nI6CVBUCuRD+IOC7WPYKrvnQA=
Date: Tue, 19 Aug 2025 18:10:25 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, howard_wang <howard_wang@realsil.com.cn>,
 Thomas Monjalon <thomas@monjalon.net>,
 Raslan Darawsheh <rasland@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>
Subject: Re: [PATCH v4 2/3] drivers/net: remove use of non-standard array
 range initialization
Message-ID: <20250820011025.GA13199@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1753111484-27021-1-git-send-email-andremue@linux.microsoft.com>
 <1753111484-27021-3-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8xqSq3toYR2tUErhab=5aWnTRSL-+wrp8aHJMdzKiMnNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xqSq3toYR2tUErhab=5aWnTRSL-+wrp8aHJMdzKiMnNg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Tue, Aug 19, 2025 at 10:45:26AM +0200, David Marchand wrote:
> Hello Andre,
> 
> On Mon, Jul 21, 2025 at 5:25 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > Array range initialization is non-standard and is not provided by
> > all compilers. MSVC does not implement it and ends up emitting
> > errors like the one below:
> >
> > drivers/net/r8169/r8169_phy.c(380):
> >     error C2143: syntax error: missing ':' before '...'
> > case CFG_METHOD_48 ... CFG_METHOD_57:
> 
> The commitlog (and title) is not aligned anymore with the patch
> content: there is more than the array range init now, and the realtek
> driver build error is not relevant anymore.
> Please reword.
> 
> This comment also applies to the first patch of the series.
> 

Indeed. I forgot to review the messages after resolving the merge conflict.
Updated both.

> 
> >
> > The fix is to explicitly initialize each element in the range.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > Acked-by: Howard Wang <howard_wang@realsil.com.cn>
> 
> Howard acked on the realtek driver update (in a previous revision).
> Now that this was reworked in a separate change (if I am not wrong,
> commit d9ee71b5f1bc ("net/r8169: support RTL8168 series")), I don't
> think this ack should be kept.

You're right. I removed his ack.

> 
> 
> > ---
> >  drivers/common/mlx5/mlx5_malloc.h   |  4 ++--
> >  drivers/net/mlx5/mlx5_flow_dv.c     |  5 ++++-
> >  drivers/net/mlx5/mlx5_rx.c          |  4 ++--
> >  drivers/net/mlx5/mlx5_utils.c       |  4 ++--
> >  drivers/net/octeon_ep/otx_ep_mbox.c | 24 ++++++++++++++++++++----
> >  5 files changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/common/mlx5/mlx5_malloc.h b/drivers/common/mlx5/mlx5_malloc.h
> > index 6e5cc3d851..27d3e5bdf2 100644
> > --- a/drivers/common/mlx5/mlx5_malloc.h
> > +++ b/drivers/common/mlx5/mlx5_malloc.h
> > @@ -118,8 +118,8 @@ void mlx5_free(void *addr);
> >                 mem; \
> >         }))
> >  #else
> > -#define mlx5_malloc_numa_tolerant(flags, size, align, socket)
> > -       (mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket)));
> > +#define mlx5_malloc_numa_tolerant(flags, size, align, socket) \
> > +       (mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket)))
> 
> The "outer" () are unneeded.

Removed.

> 
> 
> >  #endif
> >  #ifdef __cplusplus
> >  }
> > diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
> > index 7b9e5018b8..54e1d0490a 100644
> > --- a/drivers/net/mlx5/mlx5_flow_dv.c
> > +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> > @@ -19652,7 +19652,10 @@ mlx5_flow_dv_discover_counter_offset_support(struct rte_eth_dev *dev)
> >                 .size = sizeof(value.buf),
> >         };
> >         struct mlx5dv_flow_matcher_attr dv_attr = {
> > -               .type = IBV_FLOW_ATTR_NORMAL | IBV_FLOW_ATTR_FLAGS_EGRESS,
> > +               /* Cast below is needed to avoid warning until bug
> > +                * (https://bugs.dpdk.org/show_bug.cgi?id=1758) is fixed.
> > +                */
> > +               .type = IBV_FLOW_ATTR_NORMAL | (enum ibv_flow_attr_type)IBV_FLOW_ATTR_FLAGS_EGRESS,
> 
> I assigned the bug to Raslan, I hope mlx5 guys can have a look soon.

Awesome. It would be great to have that fixed. It's really confusing as it is now.

> 
> 
> >                 .priority = 0,
> >                 .match_criteria_enable = 0,
> >                 .match_mask = (void *)&mask,
> > diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
> > index 5e8c312d00..1385b23d94 100644
> > --- a/drivers/net/mlx5/mlx5_rx.c
> > +++ b/drivers/net/mlx5/mlx5_rx.c
> > @@ -1093,7 +1093,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
> >                                 break;
> >                         }
> >                         pkt = seg;
> > -                       MLX5_ASSERT(len >= (rxq->crc_present << 2));
> > +                       MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
> >                         pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
> >                         if (rxq->cqe_comp_layout && mcqe)
> >                                 cqe = &rxq->title_cqe;
> > @@ -1273,7 +1273,7 @@ mlx5_rx_burst_out_of_order(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts
> >                 }
> >                 if (!pkt) {
> >                         pkt = seg;
> > -                       MLX5_ASSERT(len >= (rxq->crc_present << 2));
> > +                       MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
> >                         pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
> >                         if (rxq->cqe_comp_layout && mcqe)
> >                                 cqe = &rxq->title_cqe;
> > diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
> > index f31b1652bc..c95e69b40f 100644
> > --- a/drivers/net/mlx5/mlx5_utils.c
> > +++ b/drivers/net/mlx5/mlx5_utils.c
> > @@ -29,8 +29,8 @@
> >         mem; \
> >  }))
> >  #else
> > -#define pool_malloc(pool, flags, size, align, socket)
> > -       (pool)->cfg.malloc((uint32_t)(flags) | NUMA_TOLERANT, (size), (align), (socket));
> > +#define pool_malloc(pool, flags, size, align, socket) \
> > +       (((pool)->cfg.malloc(((uint32_t)(flags) | MLX5_NUMA_TOLERANT), (size), (align), (socket))))
> >  #endif
> 
> Ugh, there is a regression in there, from ce2cf3403f2a ("net/mlx5:
> support NUMA node fallback") iiuc.
> I am surprised this was not caught by the CI with clang.
> 
> Do we really need all those (()) ?
> 

This macro is not used with gcc and clang, and when using msvc the code that makes use of this
macro was not enabled yet, so it was not expected that the CI would catch this for now.

Most parentesis in this macro definition are not strictly necessary, but they add safety when
complex expressions are used. I did remove one of the outer parentesis which was not needed, but left
one otherwise the validation script complains:

ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parentheses
#89: FILE: drivers/net/mlx5/mlx5_utils.c:32:
+#define pool_malloc(pool, flags, size, align, socket) \
+	(pool)->cfg.malloc((uint32_t)(flags) | MLX5_NUMA_TOLERANT, (size), (align), (socket))

Thanks for the review and the comments.

Andre Muezerie

> 
> -- 
> David Marchand
