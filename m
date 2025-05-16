Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3110C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 21:13:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F76C402E4;
	Fri, 16 May 2025 23:13:15 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CA492402E1
 for <dev@dpdk.org>; Fri, 16 May 2025 23:13:14 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id BD3AF201DB2A; Fri, 16 May 2025 14:13:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD3AF201DB2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747429993;
 bh=5RVMDnEo8L489b2U8wVUn0eu1vS0OQg/SBmfarjqLu0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pFoyNzoXMsFp8KEijVg1XrVPetlVuSW0+TyS1HNeYWxO74PbtETr5ZIr5SsWjtFbz
 K9yhGxctcjA59OanL3/nz4W6s6UYZJz64H4HiGnd4UiL6bJhfI1+A3hhCRGkdoYpI0
 ozROgk16imwhpD36ILBGCqT8XlN+dxtHF7SKtFmw=
Date: Fri, 16 May 2025 14:13:13 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, dev@dpdk.org
Subject: Re: [PATCH] rcu: remove VLAs
Message-ID: <20250516211313.GA9646@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8z-FM5Jaw1tcVu0KQGoaPa7gbpvH3GjcVDEdqSF0Zn47A@mail.gmail.com>
 <20250516130918.GB29027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAJFAV8ykrMTkgmEpv6Pp1C9tULAaWMcgsmf6mL47hD14_1DH9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8ykrMTkgmEpv6Pp1C9tULAaWMcgsmf6mL47hD14_1DH9g@mail.gmail.com>
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

On Fri, May 16, 2025 at 03:30:23PM +0200, David Marchand wrote:
> On Fri, May 16, 2025 at 3:09 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > On Fri, May 16, 2025 at 11:22:05AM +0200, David Marchand wrote:
> > > Andre,
> > >
> > > On Fri, Mar 7, 2025 at 2:40 AM Andre Muezerie
> > > <andremue@linux.microsoft.com> wrote:
> > > >
> > > > There are two lines that were using VLAs, which are not supported by
> > > > MSVC.
> > > >
> > > > 1)
> > > > ../lib/rcu/rte_rcu_qsbr.c:326:12: warning: variable length array used [-Wvla]
> > > >   326 |         char data[dq->esize];
> > > >       |                   ^~~~~~~~~
> > > > 2)
> > > > ../lib/rcu/rte_rcu_qsbr.c:389:12: warning: variable length array used [-Wvla]
> > > >   389 |         char data[dq->esize];
> > > >       |                   ^~~~~~~~~
> > > >
> > > > The short-term fix is to use alloca, to allow progress with the msvc
> > > > compatibility work.
> > > > The long-term plan involves API changes and therefore can only be applied
> > > > with a new release. This long-term plan consists of introducing some
> > > > reasonable limitation on RCU DQ element size.
> > > >
> > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > >
> > > Afaiu, enabling RCU with MSVC depends on this current patch and a fix
> > > in test/ipfrag:
> > > https://patchwork.dpdk.org/project/dpdk/patch/1741313581-14300-1-git-send-email-andremue@linux.microsoft.com/.
> > > Is there anything else missing?
> > >
> > > If not, then I would be for doing this enabling as part of this
> > > current patch (I can do this when applying).
> > > WDYT?
> > >
> >
> > You're correct. When enabling RCU lib, test_ipfrag is build and fails if the mentioned
> > patch is not applied yet. If you apply that patch first, it would be great if you
> > could enable RCU on Windows as part of this patch. Nothing else should be missing.
> >
> > I had not enabled it before to not break the CI build.
> 
> Ok, I did my checks and it looks fine, so I squashed the mention
> change as part of this patch.
> 
> I see patches on lpm and fib library for which I have similar questions.
> I must stop merging for today but could you double check those
> libraries can be enabled too?
> 
> This way it will be easier for me next week.
> 

I updated both patches to also enable the build when using MSVC since there's
nothing blocking that anymore.

> 
> Thanks.
> 
> -- 
> David Marchand
