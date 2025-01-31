Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1847C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 15:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24CA940695;
	Fri, 31 Jan 2025 16:24:15 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9DB93402EE
 for <dev@dpdk.org>; Fri, 31 Jan 2025 16:24:13 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id BB10B210C320; Fri, 31 Jan 2025 07:24:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB10B210C320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738337052;
 bh=MMdvvpQ0TwVHe9abqV1i3JYwQBwAh+oao0AclvXQUbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jvODBTfzEm9mZrEni7bKCNFR57XHKwO6LvKJq05UhN6b22JzRRvxfWnPKB2OP2K5Y
 xgv7LlNxvITWYDTxH3s0HcF2bezzxgV9uvxnx9ixkOdiWBxBGOjum7KydTFYCNfxrV
 yzGGK9ya7QIKUwQi78C54Xi1GkSAcZ/wtLLwh3MY=
Date: Fri, 31 Jan 2025 07:24:12 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, konstantin.ananyev@huawei.com,
 thomas@monjalon.net, david.marchand@redhat.com
Subject: Re: [PATCH v18 00/26] remove use of VLAs for Windows
Message-ID: <20250131152412.GA6944@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA0C@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA0C@smartserver.smartshare.dk>
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

On Fri, Jan 31, 2025 at 08:54:24AM +0100, Morten Brørup wrote:
> > From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> > Sent: Thursday, 30 January 2025 22.55
> > 
> > As per guidance technical board meeting 2024/04/17. This series
> > removes the use of VLAs from code built for Windows for all 3
> > toolchains. If there are additional opportunities to convert VLAs
> > to regular C arrays please provide the details for incorporation
> > into the series.
> > 
> > MSVC does not support VLAs, replace VLAs with standard C arrays
> > or alloca(). alloca() is available for all toolchain/platform
> > combinations officially supported by DPDK.
> > 
> > v18:
> >  * add no_vla_cflag to examples directories that are not VLA-free
> >  * add no_vla_cflag to drivers directories that are not VLA-free and
> >    were missed in v17 due to missing libs
> > 
> > v17:
> >  * define no_vla_cflag in a top directory (config)
> >  * add no_vla_cflag to directories that are not VLA-free
> >  * add -Wvla project-wide (VLAs not allowed by default, except for
> >    directories using no_vla_cflag)
> 
> nit:
> The name no_vla_cflag is inverted. It should be e.g. no_wvla_cflag or allow_vla_cflag. Although the latter lacks indication that it is an exception, it could be mentioned in a comment where it is defined. Maybe no_wvla_cflag is better.
> 

Good points. I'll use no_wvla_cflag then.
