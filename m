Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2916C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 20:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01DC042E37;
	Wed, 21 May 2025 22:23:13 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9778B402CD
 for <dev@dpdk.org>; Wed, 21 May 2025 22:23:11 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B06BD2068347; Wed, 21 May 2025 13:23:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B06BD2068347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747858990;
 bh=7sUXIODcMzB3O7Rd0vhmVV5uTlQBZ5cY+Kv5xt/dpb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aFUh/GimiY3cyqFGySbTNspjoTi1dAwKtdwc7vaWPCzog0pbaFjWaQqXgBdzkOMyL
 CpRaUEK3Eq0kK+3CBSCvI2PBLrA0cI5U71/3NvfKgrr0TovW/8KHT+vXU7FBsL2FeW
 8wvGVLiI3MlPVv39A8/r6gEwqUcV4M8MyGQSxyqk=
Date: Wed, 21 May 2025 13:23:10 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] eal: add getline() function for Windows
Message-ID: <20250521202310.GA16276@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
 <20250520101433.3a264cb1@hermes.local>
 <20250521003517.GA9927@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2358541.72vocr9iq0@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2358541.72vocr9iq0@thomas>
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

On Wed, May 21, 2025 at 09:00:48AM +0200, Thomas Monjalon wrote:
> 21/05/2025 02:35, Andre Muezerie:
> > On Tue, May 20, 2025 at 10:14:33AM -0700, Stephen Hemminger wrote:
> > > On Mon,  5 May 2025 13:40:07 -0700
> > > Andre Muezerie <andremue@linux.microsoft.com> wrote:
> > > 
> > > > Existing DPDK code uses getline(), which is a POSIX function and is
> > > > not available in the Windows APIs.
> > > > 
> > > > Instead of rewriting it or coming up with some other replacement, this
> > > > patch makes use of the implementation provided by NetBSD to make it
> > > > possible to compile code dependent on getline on Windows.
> > > > 
> > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > 
> > > Not sure, are BSD-2 and BSD-3 compatible?
> > > Getting license exception approved requires going through the governing board
> > > which can take up to 6 months.
> > 
> > Hi Stephen, I would appreciate some guidance here.
> > 
> > My understanding is that in general, BSD-2 licensed code can be used in BSD-3
> > licensed projects, as long as the BSD-2 license is retained in the original
> >  (BSD-2) files.
> > 
> > I do see that BSD-2 was listed in the exception table (for getopt function). It's
> > not clear to me why it needed to be listed as an exception, but if that was
> > needed, it indicates that the same should be done for getline(). Is that not
> > the case?
> 
> No matter the compatibility agreed or not in courts,
> if the licence is different we note it as an exception,
> so it is crystal clear for users of DPDK.
> We don't want to have any surprise and we avoid exceptions,
> that's why the Governing Board has to accept it.
> 
Thanks for clarifying, Thomas.
I sent an email to the Governing Board requesting the exception.

