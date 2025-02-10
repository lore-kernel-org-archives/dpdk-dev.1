Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B13DC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 20:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E9D4402AB;
	Mon, 10 Feb 2025 21:32:19 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 427A2402A1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 21:32:18 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 862732107A91; Mon, 10 Feb 2025 12:32:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 862732107A91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739219537;
 bh=WNtfT4Hu+cq8qCRK3Iyq9/QNHU2TaVBPe4gMtOKv4q8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a4EJGcfhydU3CkY8cNSYNyw3iHWxBPmBVyNTBy0CD5SDVzBGligbypE9ryMgwDQI6
 FgnL1t8fK0dHybTrLcNJ7pJUUUsdSkdeg9559Auwt5mXmIPxIjCZBsJF4rUMfHhRsk
 6rczVsJDRKAnKO6Elb3h7GTo03yT9jNvwkNkU14I=
Date: Mon, 10 Feb 2025 12:32:17 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 anatoly.burakov@intel.com, dev@dpdk.org, ian.stokes@intel.com,
 jochen.behrens@broadcom.com, vladimir.medvedkin@intel.com
Subject: Re: [PATCH v5 0/1] use 64-bit shift, avoid signed/unsigned mismatch
Message-ID: <20250210203217.GA19575@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738950069-21059-1-git-send-email-andremue@linux.microsoft.com>
 <20250207110157.1283d121@hermes.local>
 <Z6nIWuulEuQ1H3HH@bricha3-mobl1.ger.corp.intel.com>
 <Z6okUp9VJphhw2pG@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6okUp9VJphhw2pG@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, Feb 10, 2025 at 04:07:46PM +0000, Bruce Richardson wrote:
> On Mon, Feb 10, 2025 at 09:35:22AM +0000, Bruce Richardson wrote:
> > On Fri, Feb 07, 2025 at 11:01:57AM -0800, Stephen Hemminger wrote:
> > > On Fri,  7 Feb 2025 09:41:08 -0800
> > > Andre Muezerie <andremue@linux.microsoft.com> wrote:
> > > 
> > > > This patch avoids warnings like the ones below emitted by MSVC:
> > > > 
> > > > 1)
> > > > ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
> > > >     result of 32-bit shift implicitly converted to 64 bits
> > > >     (was 64-bit shift intended?)
> > > > 
> > > > 2)
> > > > ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
> > > >     signed/unsigned mismatch
> > > > 
> > > > The fix for (1) is to use 64-bit shifting when appropriate
> > > > (according to what the result is used for).
> > > > 
> > > > The fix for (2) is to explicitly cast the variables used in the
> > > > comparison.
> > > > 
> > > > v5:
> > > >  * rebase
> > > >  * use uint32_t instead of uint32, to better conform to DPDK standards
> > > >  * rename variable rqID to rq_id to better conform to DPDK standards
> > > >    and avoid checkpatch warning
> > > >  * use 2U instead of (uint32)2, which is shorter
> > > >  * simplify expression in meson.build using compiler id "gcc"
> > > > 
> > > > Andre Muezerie (1):
> > > >   drivers/net: use 64-bit shift and avoid signed/unsigned mismatch
> > > > 
> > > >  drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
> > > >  drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
> > > >  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
> > > >  drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
> > > >  drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
> > > >  drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
> > > >  drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
> > > >  drivers/net/intel/ice/ice_rxtx.c       |  2 +-
> > > >  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
> > > >  9 files changed, 32 insertions(+), 25 deletions(-)
> > > 
> > > 
> > > Since all intel, this should get picked up by next-intel
> > 
> > V4 had some non-intel changes too. Did they get missed in v5?
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I've taken v5 into next-next-intel. Any missed bits can be submitted as a
> separate patch later.
> 
> However, since the patch really contains two separate fixes - one for
> bitshifting, another for typecasting - I've actually split it into two
> patches. This avoids having a really long commit title - the "and" in the
> middle is a bit of a giveaway that the patch should be split IMHO!
> Andre, Please review on next-net-intel tree
> [https://git.dpdk.org/next/dpdk-next-net-intel/log/]
> 
> Applied to dpdk-next-net-intel.
> 
> Thanks,
> /Bruce

I reviewed the split patches on next-net-intel and they look good.
Thanks,
Andre Muezerie
