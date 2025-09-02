Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9783CA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 20:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8295A4042C;
	Tue,  2 Sep 2025 22:53:44 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 01B6F402DC
 for <dev@dpdk.org>; Tue,  2 Sep 2025 22:53:42 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E495F211828B; Tue,  2 Sep 2025 13:53:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E495F211828B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1756846421;
 bh=7XTjnByxM3FgEtgtwnguqd7I24Z2fbKQE9lj7fMmqUU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pRT9MKrKdnmcfFxMlts4rm/LGpeFB1sX7MySOJwHRHaaPzc06C2+B+fOAM9H0ASEl
 1L6zuo/8cN+5sHws1jFDjRkqNYPP6qg7V+O19qS3HDwMQyHrfzxO7rXhj/ZpynmNIQ
 ho1mbqj2gtQklH29dlyHUmZm+wvuW02XRHLJk75o=
Date: Tue, 2 Sep 2025 13:53:41 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Wisam Jaddo <wisamm@nvidia.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] test-flow-perf: Enable to build on Windows
Message-ID: <20250902205341.GA16501@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754423992-24652-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8y5C3-TZ-m-xECRZi3=tMqUE1BUahpE=-UfTxPWaXWRdQ@mail.gmail.com>
 <20250830002333.GA6088@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAJFAV8yhjevtCqORT=baHT+sSX1sPALhzYoEB9DVo67WnZjx7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJFAV8yhjevtCqORT=baHT+sSX1sPALhzYoEB9DVo67WnZjx7Q@mail.gmail.com>
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

On Tue, Sep 02, 2025 at 10:11:05AM +0200, David Marchand wrote:
> Hello,
> 
> On Sat, 30 Aug 2025 at 02:23, Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > On Fri, Aug 29, 2025 at 03:04:10PM +0200, David Marchand wrote:
> > > Hello,
> > >
> > > On Tue, 5 Aug 2025 at 22:00, Andre Muezerie
> > > <andremue@linux.microsoft.com> wrote:
> > > >
> > > > This patch fixes some issues which were preventing this test to be
> > > > built on Windows:
> > > >
> > > > - Remove VLAs (not supported by msvc).
> > > > - Replace strsep() (which is not natively available on Windows)
> > > >   with strtok_r().
> > > > - Remove the "thousands" separator from printf() calls as it is
> > > >   not available on Windows.
> > >
> > > Can we use rte_size_to_str() instead?
> > >
> >
> > I considered doing that, but I thought that since the app is printing deltas it
> > could be better to print the exact numbers instead of some approximation like
> > "1.02 k" which could possibly make debugging harder.
> >
> > If you strongly believe that rte_size_to_str() should indeed be used here I can
> > make the change.
> >
> > What are your thoughts about this?
> 
> No strong opinion: just that we introduced this rte_size_to_str() for
> this "thousands" separator stuff.
> I don't mind merging as is, and I did not hear from Wisam, so I guess
> this is fine.
> 
> 
> -- 
> David Marchand

I don't have a strong opinion on this either, but I remember that
when rte_size_to_str() got introduced one of the reviewers mentioned
that while the new API would be nice for # of bytes or # of packets
transmitted, they would prefer to see the exact number of bytes for
the deltas. That's the reason I took this approach. I'm assuming
others are fine with this too if we don't hear back.

Andre Muezerie
