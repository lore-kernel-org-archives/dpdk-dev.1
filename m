Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F50AC5AD49
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 May 2025 00:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD5244025E;
	Sat, 31 May 2025 02:20:31 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DE31C4025A
 for <dev@dpdk.org>; Sat, 31 May 2025 02:20:30 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CA89A210B179; Fri, 30 May 2025 17:20:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA89A210B179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748650829;
 bh=OA5X5FPIT+K+6xEb0R5LftCnfdXC1ruWNT/vrYdRs4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lr1BNTN6n3xv/V2NpI9id7q63ZJwcK7QLPgnWES1IJT3iziY3sXGMaJ5BPldcuOv6
 piH2nrd8/XssLd3Bcb/HyRSn3SM/BD6D3sz0HQxRS74c0ytBa5604ua+2nnC2gt3Ui
 +9ssCSjPQZsQKKZk3cZ6jMgmjybtJDcimew/EImY=
Date: Fri, 30 May 2025 17:20:29 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: declare size of rte_v128u32_t
Message-ID: <20250531002029.GA30537@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
 <PH7PR12MB7018AF2B11C04F5B177B3568B29AA@PH7PR12MB7018.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR12MB7018AF2B11C04F5B177B3568B29AA@PH7PR12MB7018.namprd12.prod.outlook.com>
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

On Sun, May 25, 2025 at 08:47:31AM +0000, Maayan Kashani wrote:
> Hi, Andre,
> Thanks for your contribution and patches,
> This fix should be handled diff and not by const, 
> as the typedef might change in future and the const value will stay and cause a bug.
> 
Hi Maayan,

I agree that in general it's better to not hardcode the size of a
structure because as you said, structures can change over time.

This specific structure is defined as

typedef uint32_t rte_v128u32_t __attribute__((vector_size(16), aligned(16)));
	
which uses non-standard __attribute__, which MSVC does not implement.
We could create a MSVC-specific definition, but then we would have the
same problem again: when updating the old definition, this new one
could be missed.

That makes me think that a good approach would be to have a static assert
that ensures that MLX5_SIZEOF_V128U32_T holds the correct value. This would
avoid the need to create the MSVC-specific definition, which has no other
use for now. This should address the concern you raised.

It should also be noted that rte_v128u32_t has a rigid size - its name
implies that it is 128 bits long. If that size ever changed, the name of the
structure would likely be changed as well.

I'll send out the updated patch adding the assert. Let me know what you think
about it.

Regards,
Andre

> Regards,
> Maayan Kashani
> 
> > -----Original Message-----
> > From: Andre Muezerie <andremue@linux.microsoft.com>
> > Sent: Monday, 5 May 2025 18:10
> > To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> > <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> > <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan
> > Azrad <matan@nvidia.com>
> > Cc: dev@dpdk.org; Andre Muezerie <andremue@linux.microsoft.com>
> > Subject: [PATCH] net/mlx5: declare size of rte_v128u32_t
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > When compiling with MSVC the error below is hit:
> > 
> > drivers\net\mlx5\mlx5_tx.h(1148): error C2065: 'rte_v128u32_t':
> >     undeclared identifier
> > 
> > Turns out that with MSVC the data type rte_v128u32_t is not used, but its
> > size needs to be known. This patch defines a macro to store that size and
> > replaces instances of sizeof(rte_v128u32_t) with that macro.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  drivers/net/mlx5/mlx5_defs.h | 2 ++
> >  drivers/net/mlx5/mlx5_rxtx.c | 6 +++---
> >  drivers/net/mlx5/mlx5_tx.h   | 2 +-
> >  3 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/mlx5/mlx5_defs.h b/drivers/net/mlx5/mlx5_defs.h
> > index 9c454983be..c5e2c59309 100644
> > --- a/drivers/net/mlx5/mlx5_defs.h
> > +++ b/drivers/net/mlx5/mlx5_defs.h
> > @@ -196,4 +196,6 @@
> > 
> >  #define MLX5_CNT_SVC_CYCLE_TIME_DEFAULT 500
> > 
> > +#define MLX5_SIZEOF_V128U32_T 16
> > +
> >  #endif /* RTE_PMD_MLX5_DEFS_H_ */
> > diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
> > index 9c075f6a56..b30d620f54 100644
> > --- a/drivers/net/mlx5/mlx5_rxtx.c
> > +++ b/drivers/net/mlx5/mlx5_rxtx.c
> > @@ -32,7 +32,7 @@ static_assert(MLX5_CQE_STATUS_HW_OWN < 0, "Must
> > be negative value");  static_assert(MLX5_CQE_STATUS_SW_OWN < 0, "Must
> > be negative value");  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >                 (sizeof(uint16_t) +
> > -                sizeof(rte_v128u32_t)),
> > +               MLX5_SIZEOF_V128U32_T),
> >                 "invalid Ethernet Segment data size");
> > static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >                 (sizeof(uint16_t) +
> > @@ -41,7 +41,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >                 "invalid Ethernet Segment data size");
> > static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >                 (sizeof(uint16_t) +
> > -                sizeof(rte_v128u32_t)),
> > +               MLX5_SIZEOF_V128U32_T),
> >                 "invalid Ethernet Segment data size");
> > static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >                 (sizeof(uint16_t) +
> > @@ -50,7 +50,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >                 "invalid Ethernet Segment data size");
> > static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >                 (sizeof(uint16_t) +
> > -                sizeof(rte_v128u32_t)),
> > +               MLX5_SIZEOF_V128U32_T),
> >                 "invalid Ethernet Segment data size");
> > static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >                 (sizeof(uint16_t) +
> > diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h index
> > 55568c41b1..5647f6a37d 100644
> > --- a/drivers/net/mlx5/mlx5_tx.h
> > +++ b/drivers/net/mlx5/mlx5_tx.h
> > @@ -1145,7 +1145,7 @@ mlx5_tx_eseg_data(struct mlx5_txq_data
> > *__rte_restrict txq,
> >         } else {
> >                 /* Fill the gap in the title WQEBB with inline data. */
> >                 rte_mov16(pdst, psrc);
> > -               psrc += sizeof(rte_v128u32_t);
> > +               psrc += MLX5_SIZEOF_V128U32_T;
> >         }
> >         pdst = (uint8_t *)(es + 2);
> >         MLX5_ASSERT(inlen >= MLX5_ESEG_MIN_INLINE_SIZE);
> > --
> > 2.49.0.vfs.0.0
> 
