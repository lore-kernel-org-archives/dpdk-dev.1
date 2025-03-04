Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E1C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:52:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70885402E2;
	Tue,  4 Mar 2025 17:52:52 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3DE5B4029A
 for <dev@dpdk.org>; Tue,  4 Mar 2025 17:52:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 8AAC7210EAF0; Tue,  4 Mar 2025 08:52:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AAC7210EAF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741107170;
 bh=7+NIKFenU998IxfcnvyOleq37Zt19QGv44zC6yoFano=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mJHnYeaUXZDLXVcihPNR13Tb1I7bjNMt+/JLtfYMgcGAv+BxSom/0AKJr7NHnTclv
 IiX6tPixcbngiLcfu5zpxyBk83Viv6cn5e9Y9JkWqXQ4MFTX5dZCRqIcHPrFns0g9g
 MXQJiGcgD0HfjcGVFpsJ9tI0y6bHFAGk1oPTyLTg=
Date: Tue, 4 Mar 2025 08:52:50 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, vladimir.medvedkin@intel.com
Subject: Re: [PATCH v3] lib/fib: remove warning about implicit 64-bit
 conversion
Message-ID: <20250304165250.GB21599@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1741042492-6700-1-git-send-email-andremue@linux.microsoft.com>
 <Z8baQLYFo9Fev_HG@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8baQLYFo9Fev_HG@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, Mar 04, 2025 at 10:47:28AM +0000, Bruce Richardson wrote:
> On Mon, Mar 03, 2025 at 02:54:52PM -0800, Andre Muezerie wrote:
> > MSVC issues the warning below:
> > 
> > ../lib/fib/trie.c(341): warning C4334: '<<':
> > result of 32-bit shift implicitly converted to 64 bits
> > (was 64-bit shift intended?)
> > 
> > The fix is to cast the result explicitly to uintptr_t since it is used
> > in pointer arithmetic.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  lib/fib/trie.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/fib/trie.c b/lib/fib/trie.c
> > index 4893f6c636..bf9f63eaa2 100644
> > --- a/lib/fib/trie.c
> > +++ b/lib/fib/trie.c
> > @@ -338,7 +338,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
> >  		if (ret < 0)
> >  			return ret;
> >  		if (edge == LEDGE) {
> > -			write_to_dp((uint8_t *)p + (1 << dp->nh_sz),
> > +			write_to_dp((uint8_t *)p + (uintptr_t)(1 << dp->nh_sz),
> 
> Might be worth considering using the RTE_PTR_ADD macro too for this line.

Makes sense. I'm using RTE_PTR_ADD in v4.
Thanks for the suggestion.

> 
> /Bruce
