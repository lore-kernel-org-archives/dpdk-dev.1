Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33124C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 14:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 317A542E46;
	Wed,  4 Jun 2025 16:17:49 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4E30A42E46
 for <dev@dpdk.org>; Wed,  4 Jun 2025 16:17:47 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 6D654201FF53; Wed,  4 Jun 2025 07:17:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D654201FF53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749046666;
 bh=D5An2Hw7/jQFKIa61FSdHGaL9idKVXQK6szaig/I6Og=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c9pXg2JiV1dqZSx6s7mOsWrAmJ80KSWrMS+NgN9iP9thVttvLX6PO756q/nEndDoB
 w9kHE0sPK/WmqRYfRn2emN4t2wdmyYoYyrmAM1FY2u73PA8mIwA3XD12bP4TQYChsg
 WAJrml7rrHIzuv8+Xrj1+ILEIfEP0vB1p+g0GiOA=
Date: Wed, 4 Jun 2025 07:17:46 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org
Subject: Re: [PATCH] common/mlx5: use intrinsics instead of inline assembly
Message-ID: <20250604141746.GA9366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746457062-8502-1-git-send-email-andremue@linux.microsoft.com>
 <20250603151253.jjctszshwamnepdy@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603151253.jjctszshwamnepdy@ds-vm-debian.local>
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

On Tue, Jun 03, 2025 at 05:13:14PM +0200, Dariusz Sosnowski wrote:
> Hi,
> 
> On Mon, May 05, 2025 at 07:57:42AM -0700, Andre Muezerie wrote:
> > When compiling with MSVC the errors below are hit because msvc does not
> > support inline assembly:
> > 
> > 1)
> > ../drivers/common/mlx5/mlx5_common.c(86): warning C4013: '__asm__'
> >     undefined; assuming extern returning int
> > ../drivers/common/mlx5/mlx5_common.c(87): error C2143: syntax error:
> >      missing ')' before ':'
> > 
> > 2)
> > ../drivers/net/mlx5/mlx5_txpp.c(510): error C2065: '__asm__':
> >     undeclared identifier
> > ../drivers/net/mlx5/mlx5_txpp.c(510): error C2143: syntax error:
> >     missing ';' before 'volatile'
> > 
> > The fix for (1) is to use compiler intrinsic __cpuid and for (2)
> > intrinsic _InterlockedCompareExchange128 can be used.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> *snip*
> 
> > diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
> > index e6d3ad83e9..5bbaf668e6 100644
> > --- a/drivers/net/mlx5/mlx5_txpp.c
> > +++ b/drivers/net/mlx5/mlx5_txpp.c
> > @@ -486,6 +486,20 @@ mlx5_txpp_cq_arm(struct mlx5_dev_ctx_shared *sh)
> >  }
> >  
> >  #if defined(RTE_ARCH_X86_64)
> > +#ifdef RTE_TOOLCHAIN_MSVC
> > +static inline int
> > +mlx5_atomic128_compare_exchange(rte_int128_t *dst,
> > +				rte_int128_t *exp,
> > +				const rte_int128_t *src)
> > +{
> > +	return (int)_InterlockedCompareExchange128(
> > +		(int64_t volatile *)dst,
> > +		src->val[1], /* exchange high */
> > +		src->val[0], /* exchange low */
> > +		(int64_t *)exp /* comparand result */
> > +	);
> 
> There is one checkpatch warning to fix here:
> 
> 	CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
> 	#117: FILE: drivers/net/mlx5/mlx5_txpp.c:495:
> 	+	return (int)_InterlockedCompareExchange128(
> 
> Also, I don't think that comments for arguments are needed here.
> 
> Could you please organize the code as follows:
> 
> 	return (int)_InterlockedCompareExchange128((int64_t volatile *)dst,
> 		src->val[1], src->val[0], (int64_t *)exp);
> 

Sure. I sent out a v2 of this patch with the suggested change.

> > +}
> > +#else
> >  static inline int
> >  mlx5_atomic128_compare_exchange(rte_int128_t *dst,
> >  				rte_int128_t *exp,
> > @@ -510,6 +524,7 @@ mlx5_atomic128_compare_exchange(rte_int128_t *dst,
> >  	return res;
> >  }
> >  #endif
> > +#endif
> >  
> >  static inline void
> >  mlx5_atomic_read_cqe(rte_int128_t *from, rte_int128_t *ts)
> 
> Best regards,
> Dariusz Sosnowski
