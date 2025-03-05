Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C235C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 14:45:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C55A4402A4;
	Wed,  5 Mar 2025 15:45:33 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0268740275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 15:45:31 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2B1CC210EAFB; Wed,  5 Mar 2025 06:45:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B1CC210EAFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741185931;
 bh=8SSg9HKILlaEzTBhYt3D4hNdvQYXMljRMkFwZcSwqKk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bj2VqSmS4VnWmRi4L3qCWgfJCEM20zbrCnrgROaj4/nA9+kdYmhRdfdIwhyeOaVUJ
 dSMpNwCB5k07RvNOTBLVhG5lVi5f8IiK8t/zBNrh3+tKZoJx3KsOF3xYbkEjjCgCff
 660z6WX4PLapTgxm6AV1LGF8bPO8KUEL258bSS/Y=
Date: Wed, 5 Mar 2025 06:45:31 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, vladimir.medvedkin@intel.com
Subject: Re: [PATCH v3] app/test: fix stack overflow in lpm6_perf_autotest
Message-ID: <20250305144531.GA32194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1734057571-20367-1-git-send-email-andremue@linux.microsoft.com>
 <1734535286-27267-1-git-send-email-andremue@linux.microsoft.com>
 <Z8giob2jGIcDvltC@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8giob2jGIcDvltC@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, Mar 05, 2025 at 10:08:33AM +0000, Bruce Richardson wrote:
> On Wed, Dec 18, 2024 at 07:21:26AM -0800, Andre Muezerie wrote:
> > Test lpm6_perf_autotest was hitting a stack overflow on Windows
> > with both MSVC and Clang.
> > 
> > The fix is to move some of the data from the stack to the heap.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  app/test/test_lpm6_perf.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/app/test/test_lpm6_perf.c b/app/test/test_lpm6_perf.c
> > index 1860a99ed6..59df0a958a 100644
> > --- a/app/test/test_lpm6_perf.c
> > +++ b/app/test/test_lpm6_perf.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include <rte_cycles.h>
> >  #include <rte_random.h>
> > +#include <rte_malloc.h>
> >  #include <rte_memory.h>
> >  #include <rte_lpm6.h>
> >  
> > @@ -117,8 +118,13 @@ test_lpm6_perf(void)
> >  	total_time = 0;
> >  	count = 0;
> >  
> > -	struct rte_ipv6_addr ip_batch[NUM_IPS_ENTRIES];
> > -	int32_t next_hops[NUM_IPS_ENTRIES];
> > +	struct rte_ipv6_addr *ip_batch = rte_calloc("ip_batch",
> > +			NUM_IPS_ENTRIES, sizeof(struct rte_ipv6_addr), 0);
> > +	TEST_LPM_ASSERT(ip_batch != NULL);
> > +
> > +	int32_t *next_hops = rte_calloc("next_hops",
> > +			NUM_IPS_ENTRIES, sizeof(int32_t), 0);
> > +	TEST_LPM_ASSERT(next_hops != NULL);
> >  
> 
> While I don't think we need to use the "rte_" versions of allocation, this
> is still an ok fix - and I see that in v1 regular malloc was used.

The reviewers had different opinions on which allocator function
should be used, that's why it was changed. Thanks for being flexible on this.

> 
> With either calloc or rte_calloc used.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> 
> >  	for (i = 0; i < NUM_IPS_ENTRIES; i++)
> >  		ip_batch[i] = large_ips_table[i].ip;
> > @@ -153,6 +159,9 @@ test_lpm6_perf(void)
> >  	printf("Average LPM Delete: %g cycles\n",
> >  			(double)total_time / NUM_ROUTE_ENTRIES);
> >  
> > +	rte_free(next_hops);
> > +	rte_free(ip_batch);
> > +
> >  	rte_lpm6_delete_all(lpm);
> >  	rte_lpm6_free(lpm);
> >  
> > -- 
> > 2.47.0.vfs.0.3
> > 
