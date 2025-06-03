Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436EEC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 01:05:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D9DE4028E;
	Tue,  3 Jun 2025 03:05:40 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A78684025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 03:05:38 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id A3A0A2068330; Mon,  2 Jun 2025 18:05:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3A0A2068330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748912737;
 bh=5M8neKnzeMfsH8hZTZAEoyBWdXCyQYTsZ8QR2RjlakI=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=ERPuxhZHtoDi23vNP6iCHB7fjpA5MSTz8f832okuY7QJAMjfyQSFr8rNZxXB+Toys
 T/2Ch1T3Q5tjaRNpIljzJc7x/DgFNL6HzFe4rQbTc1ETel3oPLMBEuE8FrIwR7Xu3G
 fv/cIYcsmzoD1F9oBhS0VOA3Jo+zmRBHegvPZK2w=
Date: Mon, 2 Jun 2025 18:05:37 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Subject: Re: [PATCH 0/1] unresolved symbol mlx5_geneve_tlv_parser_create
Message-ID: <20250603010537.GB30135@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746456337-6278-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746456337-6278-1-git-send-email-andremue@linux.microsoft.com>
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

On Mon, May 05, 2025 at 07:45:36AM -0700, Andre Muezerie wrote:
> When compiling DPDK with mlx5 using clang on Windows with
> "debug" buildtype the error below is hit:
> 
> net_mlx5_mlx5_flow_dv.c.obj : error LNK2019: unresolved external symbol
>     mlx5_geneve_tlv_parser_create referenced in function
>     flow_dv_discover_priorities
> drivers\rte_net_mlx5-25.dll : fatal error LNK1120: 1 unresolved externals
> 
> With a "release" buildtype the error is not seen, which explains why this
> issue was not reported earlier.
> 
> The same problem will show up with MSVC, but patches which are still under
> review are needed for this to be hit with MSVC.
> 
> The cause of this problem seems to be that mlx5_flow_geneve.c is only
> compiled on Linux. This patch fixes the issue by compiling the file on all
> operating systems. It also sorts the file names in meson.build in
> alphabetical order.
> 
> 
> REPRO STEPS (On Windows)
> 
> set DEVX_INC_PATH=V:\soft\MLNX_WinOF2_DevX_SDK\inc
> set DEVX_LIB_PATH=V:\soft\MLNX_WinOF2_DevX_SDK\lib
> set CFLAGS=-I"%DEVX_INC_PATH%"
> set LDFLAGS=-Wl,-LIBPATH:"%DEVX_LIB_PATH%"
> set CC=clang
> meson setup -Dexamples=helloworld build --buildtype debug
> ninja -C build
> 
> 
> Andre Muezerie (1):
>   net/mlx5: unresolved symbol mlx5_geneve_tlv_parser_create
> 
>  drivers/net/mlx5/meson.build | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> --
> 2.49.0.vfs.0.0

Would someone be able to review this patchset?
Thanks,

Andre Muezerie
