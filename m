Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F12CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 00:23:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C83D240280;
	Sat, 30 Aug 2025 02:23:35 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 738DC4027D
 for <dev@dpdk.org>; Sat, 30 Aug 2025 02:23:34 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 85D812116281; Fri, 29 Aug 2025 17:23:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85D812116281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1756513413;
 bh=X0PF9qr7qj5kZQBKlHnNvzifpK4eU6AJ/O6PcbcFyWc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bzMJLYfFskN0iw4G96rnwtwf+rYDFWGL1kiznSIm/UtfGnQnW7HcrHq+SPfRKfdR5
 i0ywlY2oEryrSORjsttf/jxXor796Uj4G50vgEP3GB2iVPSQR9clLeU+WEWEOXvWQI
 KOKIScoRhupMhzp5G23Xi4J6JjSVfNnb3foURMXY=
Date: Fri, 29 Aug 2025 17:23:33 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Wisam Jaddo <wisamm@nvidia.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] test-flow-perf: Enable to build on Windows
Message-ID: <20250830002333.GA6088@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754423992-24652-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8y5C3-TZ-m-xECRZi3=tMqUE1BUahpE=-UfTxPWaXWRdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJFAV8y5C3-TZ-m-xECRZi3=tMqUE1BUahpE=-UfTxPWaXWRdQ@mail.gmail.com>
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

On Fri, Aug 29, 2025 at 03:04:10PM +0200, David Marchand wrote:
> Hello,
> 
> On Tue, 5 Aug 2025 at 22:00, Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > This patch fixes some issues which were preventing this test to be
> > built on Windows:
> >
> > - Remove VLAs (not supported by msvc).
> > - Replace strsep() (which is not natively available on Windows)
> >   with strtok_r().
> > - Remove the "thousands" separator from printf() calls as it is
> >   not available on Windows.
> 
> Can we use rte_size_to_str() instead?
> 

I considered doing that, but I thought that since the app is printing deltas it
could be better to print the exact numbers instead of some approximation like
"1.02 k" which could possibly make debugging harder.

If you strongly believe that rte_size_to_str() should indeed be used here I can
make the change.

What are your thoughts about this?

Andre Muezerie

> > - Include the test in the Windows build.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Otherwise it lgtm.
> 
> 
> -- 
> David Marchand
