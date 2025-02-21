Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E34C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 19:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79C7F410E8;
	Fri, 21 Feb 2025 20:47:18 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BF8D1410E6
 for <dev@dpdk.org>; Fri, 21 Feb 2025 20:47:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D5416204E5BC; Fri, 21 Feb 2025 11:47:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5416204E5BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740167235;
 bh=WeDEa6VK7bjtq+KML0d3aUiSZjKPaYsFNNSW5OW+GoY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R2KiKX4wg6w/WxFpZHVJ0erkt0DZymAtC66fp0AvLuXbSq/iz6245aRa9O76pX9Oc
 oJxVcctk5/Uv5StQlwaIeldm3nVnD3a7s4OVxBM7sYPyT2iKLFW9auxq7tmQhHb9rm
 k9MoDWZk5S6RKB5BhAmUbDXSiqwWpeQGuCvLyFp0=
Date: Fri, 21 Feb 2025 11:47:15 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v4 08/10] test-pmd: declare lcore_count atomic
Message-ID: <20250221194715.GA10610@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-9-git-send-email-andremue@linux.microsoft.com>
 <b6eaefbdba2c46228c1330d2afb81d3f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6eaefbdba2c46228c1330d2afb81d3f@huawei.com>
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

On Fri, Feb 21, 2025 at 08:40:17AM +0000, Konstantin Ananyev wrote:
> 
> 
> > Compiling with MSVC results in the error below:
> > 
> > app/test/test_ring_perf.c(197): error C7712: address argument to atomic
> >     operation must be a pointer to an atomic integer,
> >     'volatile unsigned int *' is not valid
> > 
> > The fix is to mark lcore_count as atomic.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > ---
> >  app/test/test_ring_perf.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
> > index 57cd04a124..366e256323 100644
> > --- a/app/test/test_ring_perf.c
> > +++ b/app/test/test_ring_perf.c
> > @@ -34,7 +34,7 @@ struct lcore_pair {
> >  	unsigned c1, c2;
> >  };
> > 
> > -static volatile unsigned lcore_count = 0;
> > +static RTE_ATOMIC(unsigned int) lcore_count;
> 
> But for not-MSVC builds RTE_ATOMIC() by default means nothing.
> If you are removing volatile, then I think, you need to fix the code to ensure
> that all reads/writes to this var are done with atomic ops.
> Or have both -  volatile and RTE_ATOMIC()

Good point.
I'll use both volatile and RTE_ATOMIC() in the next series.

> 
> 
> >  static void
> >  test_ring_print_test_string(unsigned int api_type, int esize,
> > @@ -193,11 +193,7 @@ enqueue_dequeue_bulk_helper(const unsigned int flag, struct thread_params *p)
> >  	unsigned int n_remaining;
> >  	const unsigned int bulk_n = bulk_sizes[p->ring_params->bulk_sizes_i];
> > 
> > -#ifdef RTE_USE_C11_MEM_MODEL
> >  	if (rte_atomic_fetch_add_explicit(&lcore_count, 1, rte_memory_order_relaxed) + 1 != 2)
> > -#else
> > -	if (__sync_add_and_fetch(&lcore_count, 1) != 2)
> > -#endif
> >  		while(lcore_count != 2)
> >  			rte_pause();
> > 
> > --
> > 2.48.1.vfs.0.0
> > 
