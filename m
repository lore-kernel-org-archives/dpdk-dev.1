Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC58C021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 01:59:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED1024014F;
	Thu, 20 Feb 2025 02:59:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6E1D140041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 02:59:20 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9CCB22043DEE; Wed, 19 Feb 2025 17:59:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CCB22043DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740016759;
 bh=DlxB8kOcn2G2oMNcvRv9S7JB0upc56sbIlQDFSmtSks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=luIdReImRIlfEmoAP0HfkXeEEVNrnxA8UszgcbMlcLmH/ZB/EPWyhceciYELav5mH
 CQYAL8UgWXlcLbTHqqe8O/2ElcuuBJmr6SRUdSIxOcgGO/OMaN6cWNL4BsbborFmi5
 1eM8GAXlJV1tC9Tx3R+bkqC0CZ2bO1/oG+5e5QOc=
Date: Wed, 19 Feb 2025 17:59:19 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 01/10] eal: add workaround for __builtin_constant_p
Message-ID: <20250220015919.GA922@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-2-git-send-email-andremue@linux.microsoft.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA4C@smartserver.smartshare.dk>
 <20250219165002.GA6472@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250219091011.2c49f342@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219091011.2c49f342@hermes.local>
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

On Wed, Feb 19, 2025 at 09:10:11AM -0800, Stephen Hemminger wrote:
> On Wed, 19 Feb 2025 08:50:02 -0800
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > On Tue, Feb 18, 2025 at 06:12:04PM +0100, Morten Brørup wrote:
> > > > From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> > > > Sent: Tuesday, 18 February 2025 17.32
> > > > 
> > > > There's no MSVC equivalent for compiler extension __builtin_constant_p.
> > > > EAL already had __rte_constant which was used as a first attempt to
> > > > workaround __builtin_constant_p when using MSVC. However, there are
> > > > pieces of code that would benefit from being able to provide a default
> > > > value to be used instead of it being always 0 like how it was done by
> > > > __rte_constant.
> > > > 
> > > > A new macro is added here allowing such default to be provided by the
> > > > caller.  
> > > 
> > > NAK to the new macro.
> > > 
> > > Please use the sizeof() hack suggested by Stephen to provide an implementation of __rte_constant(e) for MSVC.
> > > Here's a link to an example of the hack:
> > > https://news.ycombinator.com/item?id=16720172  
> > 
> > Thanks for the link. I tried to use the hack as suggested but turns out it does
> > not work with msvc. It results in error C2100: "you cannot dereference an
> > operand of type 'void'".
> > 
> > I'm open to further suggestions.
> 
> Maybe contact the MSVC team? there really ought to be way to do this.
> The compiler knows what is constant and what is not since it needs this for static assertions.

I reached out to the MSVC team and they suggested a similar hack using _Generic, which works with
msvc. I'll send out an updated series.
