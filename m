Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D261C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 00:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7151340A70;
	Wed, 21 May 2025 02:35:19 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9992D40A6F
 for <dev@dpdk.org>; Wed, 21 May 2025 02:35:18 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 8B54A20277EE; Tue, 20 May 2025 17:35:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B54A20277EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747787717;
 bh=O5vxBXULZDGEZk8jRsMwPEZWl/RbeA7Cb+yAsxuC5AE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UKt+snGeQiZ6XDzgoO0BAT/1VjdxSFt6gpD5hHIZT+mBxItt6bmL6NVBmOC0lPo1b
 KSzRj4eEHzv4xQGG7IEvp/Dm3rkLVM5mHQ1ZPfMcRL/2Q5j8BpgynT/00GF9+08Ct6
 2iLI7MfPbioLzJypqsv4rUdAj42iZD4tH28F0RjM=
Date: Tue, 20 May 2025 17:35:17 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Subject: Re: [PATCH] eal: add getline() function for Windows
Message-ID: <20250521003517.GA9927@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
 <20250520101433.3a264cb1@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520101433.3a264cb1@hermes.local>
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

On Tue, May 20, 2025 at 10:14:33AM -0700, Stephen Hemminger wrote:
> On Mon,  5 May 2025 13:40:07 -0700
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > Existing DPDK code uses getline(), which is a POSIX function and is
> > not available in the Windows APIs.
> > 
> > Instead of rewriting it or coming up with some other replacement, this
> > patch makes use of the implementation provided by NetBSD to make it
> > possible to compile code dependent on getline on Windows.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Not sure, are BSD-2 and BSD-3 compatible?
> Getting license exception approved requires going through the governing board
> which can take up to 6 months.

Hi Stephen, I would appreciate some guidance here.

My understanding is that in general, BSD-2 licensed code can be used in BSD-3
licensed projects, as long as the BSD-2 license is retained in the original
 (BSD-2) files.

I do see that BSD-2 was listed in the exception table (for getopt function). It's
not clear to me why it needed to be listed as an exception, but if that was
needed, it indicates that the same should be done for getline(). Is that not
the case?
