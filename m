Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4D8C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A45742DC1;
	Fri,  7 Feb 2025 15:37:52 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0947F410E3
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:37:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 43AF32109CE9; Fri,  7 Feb 2025 06:37:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43AF32109CE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738939070;
 bh=VSCHH2Kv/SImnD/G3CWHxutUkHr2HmYYxMQ+do5Sjw8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FaneE50diC9vdSbiYgvqtgYJhD51dBELZFr2uEbcU466oJTkdVBZMoqmoYYa6WZeU
 L+cD8kP33+a7pXup6oGaQ4wa+E82pGec7rYdtHBH2blMRGOv4mSc8UrrYex92zaklH
 xRcTk3t5ykBcaEivCRuL4Ngqoz1vosxM1bsS+aB4=
Date: Fri, 7 Feb 2025 06:37:50 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 0/5] use portable macro for weak linking
Message-ID: <20250207143750.GA8577@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1735009552-31906-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8z6enOtK6kU+EOEELjWS1N_dk8odHn67B1mrA=2BPxfyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8z6enOtK6kU+EOEELjWS1N_dk8odHn67B1mrA=2BPxfyQ@mail.gmail.com>
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

On Fri, Feb 07, 2025 at 09:47:19AM +0100, David Marchand wrote:
> On Tue, Dec 24, 2024 at 4:06 AM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > MSVC uses pragmas to indicate weak linking, so the old __rte_weak
> > attribute needs to made into a macro so that the same syntax can
> > be used for MSVC and other compilers like gcc.
> >
> > Andre Muezerie (5):
> >   lib/eal: add portable macro for weak linking
> >   app/test-compress-perf: use portable macro for weak linking
> >   drivers/bus: use portable macro for weak linking
> >   drivers/common: use portable macro for weak linking
> >   drivers/net: use portable macro for weak linking
> 
> I am not a fan of the weak linking stuff in the first place.
> Reading the code with __rte_weak, I always wonder which symbol is used when...
> I prefer explicit linking and no duplicate symbols end up in the binaries.
> 
> I posted a RFC, can you have a look?
> https://inbox.dpdk.org/dev/20250207083252.3131588-1-david.marchand@redhat.com/
> 
> 
> -- 
> David Marchand

I also had the same questions about which symbols were being used the first time I looked at the code.
Therefore, I think your proposal makes the code easier to understand and is a better approach.
--
Andre Muezerie

