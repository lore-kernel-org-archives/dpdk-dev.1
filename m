Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7ACC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 15:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53ACA40292;
	Tue,  8 Jul 2025 17:08:58 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4BDC44025E
 for <dev@dpdk.org>; Tue,  8 Jul 2025 17:08:57 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7975B2114246; Tue,  8 Jul 2025 08:08:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7975B2114246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751987336;
 bh=81VZZYWTnffXWHrrMrtnDhLo+Iu71UwiI5aFXlcHgXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KqV2SWBKDjBeZnWaG/tD8SLaSChjR834IdP5YQ11Q262kkXzz2mdFGguFB5eQlp2P
 /JoMNxSA7CxKjTqYy4VCC/ZYfBLmjslhhz3z4w2XuZsx36U4fFpeT6etuhoBGeF6vA
 yXF92UxNLHk5dSy8tvEOtrWtnjSizf3pqmEEWGdI=
Date: Tue, 8 Jul 2025 08:08:56 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: bingz@nvidia.com, dev@dpdk.org, matan@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, viacheslavo@nvidia.com, mkashani@nvidia.com
Subject: Re: [PATCH v2] net/mlx5: declare size of rte_v128u32_t
Message-ID: <20250708150856.GA29009@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
 <1748650917-31700-1-git-send-email-andremue@linux.microsoft.com>
 <20250604152857.fnsui4nwbr5tyjqn@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604152857.fnsui4nwbr5tyjqn@ds-vm-debian.local>
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

On Wed, Jun 04, 2025 at 05:28:57PM +0200, Dariusz Sosnowski wrote:
> Hi,
> 
> On Fri, May 30, 2025 at 05:21:57PM -0700, Andre Muezerie wrote:
> > When compiling with MSVC the error below is hit:
> > 
> > drivers\net\mlx5\mlx5_tx.h(1148): error C2065: 'rte_v128u32_t':
> >     undeclared identifier
> > 
> > Turns out that with MSVC the data type rte_v128u32_t is not used, but
> > its size needs to be known. This patch defines a macro to store that
> > size and replaces instances of sizeof(rte_v128u32_t) with that macro.
> > 
> > A static assert is added to ensure the new macro never diverges from
> > sizeof(rte_v128u32_t).
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  drivers/net/mlx5/mlx5_defs.h |  2 ++
> >  drivers/net/mlx5/mlx5_rxtx.c | 11 ++++++++---
> >  drivers/net/mlx5/mlx5_tx.h   |  2 +-
> >  3 files changed, 11 insertions(+), 4 deletions(-)
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
> > index 9c075f6a56..3f4942e225 100644
> > --- a/drivers/net/mlx5/mlx5_rxtx.c
> > +++ b/drivers/net/mlx5/mlx5_rxtx.c
> > @@ -28,11 +28,16 @@
> >  #include "mlx5_tx.h"
> >  
> >  /* static asserts */
> > +#ifndef RTE_TOOLCHAIN_MSVC
> > +static_assert(sizeof(rte_v128u32_t) == MLX5_SIZEOF_V128U32_T,
> > +		"MLX5_SIZEOF_V128U32_T must hold sizeof(rte_v128u32_t)");
> > +#endif
> 
> Thank you for the patch.
> This proposal is ok, but I think it can be slightly improved.
> 
> The reference to rte_v128u32_t (in code and in names) can be removed, because
> the code which relies on MLX5_ESEG_MIN_INLINE_SIZE does not really use
> rte_v128u32_t type. The relevant code e.g., in mlx5_tx_eseg_dmin(),
> always copies first 2 bytes of the packet (through uint16_t pointer,
> these would be first 2 bytes of destination MAC address)
> and then does one of the two:
> 
> 1. Copies following 16 bytes using rte_mov16().
>    (Corresponds to first static_assert for MLX5_ESEG_MIN_INLINE_SIZE).
> 2. If there is a VLAN defined in mbuf, then:
>    - the rest of destination MAC address is copied,
>    - source MAC address is copied,
>    - VLAN is inserted,
>    - 2 bytes appearing after VLAN header are copied.
>    (Corresponds to 2nd static_assert for MLX5_ESEG_MIN_INLINE_SIZE).
> 
> Amount of data copied is inferred from HW arch and packet descriptor
> layout, not rte_v128u32_t.
> 
> Since rte_mov16() is used in real code and rte_v128u32_t is only used to
> carry over the length of the copy, I would propose to:
> 
> - Replace instances of sizeof(rte_v128u32_t) with a macro named MLX5_SIZE_MOV16
>   to better reflect the real usage in mlx5 PMD.
> - Remove static_assert for
>   "sizeof(rte_v128u32_t) == MLX5_SIZEOF_V128U32_T".
> 
> Would you be able to apply these changes?

Yes, I'll send a new patch with the changes suggested.

Thanks,

Andre Muezerie

> 
> > +
> >  static_assert(MLX5_CQE_STATUS_HW_OWN < 0, "Must be negative value");
> >  static_assert(MLX5_CQE_STATUS_SW_OWN < 0, "Must be negative value");
> >  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >  		(sizeof(uint16_t) +
> > -		 sizeof(rte_v128u32_t)),
> > +		MLX5_SIZEOF_V128U32_T),
> >  		"invalid Ethernet Segment data size");
> >  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >  		(sizeof(uint16_t) +
> > @@ -41,7 +46,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >  		"invalid Ethernet Segment data size");
> >  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >  		(sizeof(uint16_t) +
> > -		 sizeof(rte_v128u32_t)),
> > +		MLX5_SIZEOF_V128U32_T),
> >  		"invalid Ethernet Segment data size");
> >  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >  		(sizeof(uint16_t) +
> > @@ -50,7 +55,7 @@ static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >  		"invalid Ethernet Segment data size");
> >  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >  		(sizeof(uint16_t) +
> > -		 sizeof(rte_v128u32_t)),
> > +		MLX5_SIZEOF_V128U32_T),
> >  		"invalid Ethernet Segment data size");
> >  static_assert(MLX5_ESEG_MIN_INLINE_SIZE ==
> >  		(sizeof(uint16_t) +
> > diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
> > index 55568c41b1..5647f6a37d 100644
> > --- a/drivers/net/mlx5/mlx5_tx.h
> > +++ b/drivers/net/mlx5/mlx5_tx.h
> > @@ -1145,7 +1145,7 @@ mlx5_tx_eseg_data(struct mlx5_txq_data *__rte_restrict txq,
> >  	} else {
> >  		/* Fill the gap in the title WQEBB with inline data. */
> >  		rte_mov16(pdst, psrc);
> > -		psrc += sizeof(rte_v128u32_t);
> > +		psrc += MLX5_SIZEOF_V128U32_T;
> >  	}
> >  	pdst = (uint8_t *)(es + 2);
> >  	MLX5_ASSERT(inlen >= MLX5_ESEG_MIN_INLINE_SIZE);
> > -- 
> > 2.49.0.vfs.0.3
> > 
> 
> Best regards,
> Dariusz Sosnowski
