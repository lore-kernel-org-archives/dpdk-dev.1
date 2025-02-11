Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A8C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 02:19:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31866402AB;
	Tue, 11 Feb 2025 03:19:19 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0807640150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 03:19:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 17F1D2107A96; Mon, 10 Feb 2025 18:19:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17F1D2107A96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739240356;
 bh=r+YVK2q6hMKDHS6YeQPX/LEYaWW96gGBwwuOYW8hb3g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CWzYR1CfllsgepEoR+ojeq6LFO21qCqC7jItVrm836DbexZdB4xzKBSG8RGrhO4f/
 THEfEv4neRmkQPrH28MCV3OOIwisIByi462jIHPNPvo+G1dc+VaiuwHvbvdIAavC9l
 lRSiTN4xfuYirUgkxsa6YMLPuLVcRnCRp5OPFM0Q=
Date: Mon, 10 Feb 2025 18:19:16 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] mbuf: enable to be compiled with MSVC
Message-ID: <20250211021916.GA5671@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <20250210143429.5ec26d17@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210143429.5ec26d17@hermes.local>
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

On Mon, Feb 10, 2025 at 02:34:29PM -0800, Stephen Hemminger wrote:
> On Mon, 10 Feb 2025 13:51:05 -0800
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > Now that the issues preventing this lib from be compiled with MSVC
> > are fixed it can be included in the compilation.
> > 
> > The "net" library will automatically get compiled as well as it
> > has a dependency on "mbuf" which will now get fulfilled.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> 
> Getting close to building test-pmd on Windows?
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

We are getting closer, yes :-)
