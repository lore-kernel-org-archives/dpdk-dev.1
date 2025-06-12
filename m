Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE0C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 14:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 725E042796;
	Thu, 12 Jun 2025 16:43:01 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0BEAE42789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 16:43:00 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 02B82201C750; Thu, 12 Jun 2025 07:42:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02B82201C750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749739379;
 bh=LrcqISqkaJ/8cC6DSqzDacQyFT7jdyWk/aUQmy222YM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K26cAr/jJmEmyaSQOijshANilLZfU0VblhE2n8fx9mGr072E+Rh5uYlhFdoraJug4
 gk77JK3ani917jRWBQMIMVh+9TC8LG9maySVsGp+M3Xag8UIppqDUS+iM0JsZqBgy0
 6XQy5sUo3oHGlIl+/4fR82IwFZrQhwC1Do+O0l9o=
Date: Thu, 12 Jun 2025 07:42:58 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] eal: add getline() function for Windows
Message-ID: <20250612144258.GA3279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
 <4381337.bcXerOTE6V@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4381337.bcXerOTE6V@thomas>
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

On Thu, Jun 12, 2025 at 03:01:03AM +0200, Thomas Monjalon wrote:
> 05/05/2025 22:40, Andre Muezerie:
> > Existing DPDK code uses getline(), which is a POSIX function and is
> > not available in the Windows APIs.
> > 
> > Instead of rewriting it or coming up with some other replacement, this
> > patch makes use of the implementation provided by NetBSD to make it
> > possible to compile code dependent on getline on Windows.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> It has been approved by the techboard on May 28,
> and the govboard on May 30,
> so the patch is applied, thanks.
> 

That's great news! Thanks.
