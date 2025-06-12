Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D2C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 14:46:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D4C042796;
	Thu, 12 Jun 2025 16:46:51 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DDF6842789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 16:46:49 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D0011201C776; Thu, 12 Jun 2025 07:46:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0011201C776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749739608;
 bh=5SW3O3mUhOimLKCNX9qCEjEyv2WvrwLZLZK5DcWwW4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=giGq2ExMDPEVhX2dblLNx7Q+drsdtmL7++q+DdoLgJsgLpM4Y3XaFpkjoWD2Oy4sQ
 KzHWOCKukh3unH77S51AOLc72T++WhXmg72zyFVdusyXm9OPVlZKi3hrQ/LdynvTfw
 sNoSLKkIlSrahf2DgLs72vSkPNMS/NwiAdFbmugY=
Date: Thu, 12 Jun 2025 07:46:48 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] eal: add asprintf() function for Windows
Message-ID: <20250612144648.GB3279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746495789-14101-1-git-send-email-andremue@linux.microsoft.com>
 <7942373.1B3tZ46Xf9@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7942373.1B3tZ46Xf9@thomas>
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

On Thu, Jun 12, 2025 at 02:41:05AM +0200, Thomas Monjalon wrote:
> 06/05/2025 03:43, Andre Muezerie:
> > The asprintf function is not part of the C standard library but is a
> > GNU extension commonly available in Unix-like systems. It dynamically
> > allocates memory to store the formatted output string, similar to
> > sprintf, but avoids buffer overflow issues by automatically sizing
> > the buffer.
> > 
> > Instead of rewriting it or coming up with some other replacement, this
> > patch makes use of the implementation provided by Neved4.
> 
> Why not using eal_asprintf()?
> 

There are many calls being made directly to asprintf() which made me
believe there wasn’t an equivalent available for Windows yet.

Thanks for pointing out that is not the case.

I’ll make the necessary changes to call eal_asprintf() instead.

