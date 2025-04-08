Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736DDC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 20:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81720402CB;
	Tue,  8 Apr 2025 22:53:15 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 784DC4026B
 for <dev@dpdk.org>; Tue,  8 Apr 2025 22:53:13 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C4D272113E92; Tue,  8 Apr 2025 13:53:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4D272113E92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744145592;
 bh=gT9QiZuO6/2E1UnXPKqn1/tlYlEHWBZOrrzYYXjhjjk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o8s8PUV/LunC4kJblmbke3nAoqUYIn8n1nYQo2MSAxbZDkZ0A7Ru01+ZgOQwPk491
 OCnee830QZiGmojPotI36yeTgstIeizN+uUP6bLVOIZp43xACpU3JZNsoVrE2qqc1k
 hxEQJjb1CilX5cxwN3EFNdg44i7MDO2HHyPrgono=
Date: Tue, 8 Apr 2025 13:53:12 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 6/6] mbuf: enable to be compiled with MSVC
Message-ID: <20250408205312.GA17604@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1740083508-6703-1-git-send-email-andremue@linux.microsoft.com>
 <1740083508-6703-7-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8yh1+fA=bimjWyHJFYA7rCQUV9U67gHCxtQYsssyVtqLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yh1+fA=bimjWyHJFYA7rCQUV9U67gHCxtQYsssyVtqLw@mail.gmail.com>
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

On Mon, Apr 07, 2025 at 03:53:06PM +0200, David Marchand wrote:
> Hello Andre,
> 
> On Thu, Feb 20, 2025 at 9:32 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > Now that the issues preventing this lib from be compiled with MSVC
> > are fixed it can be included in the compilation.
> >
> > The "net" library will automatically get compiled as well as it
> > has a dependency on "mbuf" which will now get fulfilled.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I just merged the symbol export / versioning rework series.
> Could you please resend this patch only, for the CI to have a go?
> 

That's great news!
I'll send out the updated patch, and also review the other patches to
see if they need changes.

> Thank you.
> 
> 
> -- 
> David Marchand
