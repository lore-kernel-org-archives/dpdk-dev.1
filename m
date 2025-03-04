Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A8C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:51:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3192E402E2;
	Tue,  4 Mar 2025 17:51:09 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4D8D44029A
 for <dev@dpdk.org>; Tue,  4 Mar 2025 17:51:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 815EE210EAEF; Tue,  4 Mar 2025 08:51:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 815EE210EAEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741107067;
 bh=XneBDvq/R/IXx4LDwfVKl2QIRNMdz6ex/ihnnhmmawo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VnLemwyhbtOp8R1icnFpoJ2GzpvrWZop6/zk5kyh25vUPdyAo0U0+QAp1gX+pRMvy
 VcQ/thmbSUmnxc7z3mcX+KtAe9OF/1DMhCZIXFB8pGz5cfGQ1W/EgkOvCtUqSLZi/l
 fcbAle37ucGIfawGb9NsmCtdHnJfV5PsPEZ2IwXI=
Date: Tue, 4 Mar 2025 08:51:07 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>,
	"Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3] lib/fib: remove warning about implicit 64-bit
 conversion
Message-ID: <20250304165107.GA21599@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1741042492-6700-1-git-send-email-andremue@linux.microsoft.com>
 <CAOaVG16pRvfJKhE-55BKWLs_fFNDD9nfY2ff+K4SYgc-8yTUOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOaVG16pRvfJKhE-55BKWLs_fFNDD9nfY2ff+K4SYgc-8yTUOQ@mail.gmail.com>
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

On Mon, Mar 03, 2025 at 10:49:52PM -0800, Stephen Hemminger wrote:
> Better to cast the constant (1) to avoid warning,
> .
> That is what other code does like RTE_BIT macros

Alright, I made that change in v4.

> 
> On Mon, Mar 3, 2025, 23:55 Andre Muezerie <andremue@linux.microsoft.com>
> wrote:
> 
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
> > @@ -338,7 +338,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t
> > *ip_part, uint64_t next_hop,
> >                 if (ret < 0)
> >                         return ret;
> >                 if (edge == LEDGE) {
> > -                       write_to_dp((uint8_t *)p + (1 << dp->nh_sz),
> > +                       write_to_dp((uint8_t *)p + (uintptr_t)(1 <<
> > dp->nh_sz),
> >                                 next_hop << 1, dp->nh_sz, UINT8_MAX -
> > *ip_part);
> >                 } else {
> >                         write_to_dp(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
> > --
> > 2.48.1.vfs.0.0
> >
> >
