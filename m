Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA16C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 15:45:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0400406B6;
	Thu,  6 Mar 2025 16:45:45 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C4DE34069F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 16:45:43 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1DCD4210EAFF; Thu,  6 Mar 2025 07:45:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1DCD4210EAFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741275943;
 bh=HlnDXl5LTLFENSIlfKNex1gkXxt4PDhVJyvWbKV7b6U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OOw1WyCoH4OWbSzt7BEz7RQyyEZbOoaggsfp8pKEjJhswKWJKTrn+YdmhfH7glm7j
 pUJtoNC1XdW0Ia4DFP3RwVy3SnqD1CagB+CZRpzc4AXD+G5miZTRi+Gqh7tndQ8oR8
 Uu25GJR8wPWft+la8Z5wpmkPAJ0Y8CvR+Hr8tiDA=
Date: Thu, 6 Mar 2025 07:45:43 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: Re: [RFC v2 1/2] eal: add new function versioning macros
Message-ID: <20250306154543.GB28298@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250306125021.2231121-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306125021.2231121-1-david.marchand@redhat.com>
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

On Thu, Mar 06, 2025 at 01:50:20PM +0100, David Marchand wrote:
> For versioning symbols:
> - MSVC uses pragmas on the symbol,
> - GNU linker uses special asm directives,
> 
> To accommodate both GNU linker and MSVC linker, introduce new macros for
> exporting and versioning symbols that will surround the whole function.
> 
> This has the advantage of hiding all the ugly details in the macros.
> Now versioning a symbol is just a call to a single macro:
> - RTE_VERSION_SYMBOL (resp. RTE_VERSION_EXPERIMENTAL_SYMBOL), for
>   keeping an old implementation code under a versioned function (resp.
>   experimental function),
> - RTE_DEFAULT_SYMBOL, for declaring the new default versioned function,
>   and handling the static link special case, instead of
>   BIND_DEFAULT_SYMBOL + MAP_STATIC_SYMBOL,
> 
> Documentation has been updated though it needs some polishing.
> The experimental macro has not been tested.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since RFC v1:
> - renamed and prefixed macros,
> - reindented in prevision of second patch,
> 
> ---
>  doc/guides/contributing/abi_versioning.rst | 130 ++++-----------------
>  lib/eal/include/rte_function_versioning.h  |  27 +++++
>  lib/net/rte_net_crc.c                      |  30 ++---
>  3 files changed, 57 insertions(+), 130 deletions(-)
> 

I like the proposal. Having a single macro able to handle different linkers
is clearly a good step forward.

Acked-by: Andre Muezerie <andremue@linux.microsoft.com>
