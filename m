Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E1C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 19:15:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C9AC40156;
	Wed, 23 Apr 2025 21:15:08 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 39330400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 21:15:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 4456241
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1745435705;
 bh=MK8y754jkzPOx3OnjGqzxlpD2EZ9C1PKycyFAYUPgdY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CFxyg8KkN7V9WbIG8WusKK70wgA12ajC7UURQC4AB357pQKsKTQqmZy9vlojurTmR
 nG+sdFEtDOIwKZiVCCv4zV9EOAEjIHkIQUDp9BdAJgwUQ8OhwmoDwMBMrQsWaMhgdc
 mauehUr723DN9IuXaUnOrExov3zKHMEupl14YmJM=
Received: from [192.168.1.41] (unknown [188.242.176.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 4456241;
 Wed, 23 Apr 2025 22:15:05 +0300 (MSK)
Message-ID: <b21dd3d8-5377-4716-8fb4-ac3ae63d6599@oktetlabs.ru>
Date: Wed, 23 Apr 2025 22:15:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 45/45] doc: advertise support for AMD Solarflare X45xx
 adapters
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-46-ivan.malov@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250423160002.35706-46-ivan.malov@arknetworks.am>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/23/25 19:00, Ivan Malov wrote:
> The two NICs, X4522 and X4542, are based on EF10 architecture.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> ---
>   doc/guides/nics/sfc_efx.rst            | 9 ++++++++-
>   doc/guides/rel_notes/release_25_07.rst | 4 ++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/sfc_efx.rst b/doc/guides/nics/sfc_efx.rst
> index eafb88191a..4bd9f8c441 100644
> --- a/doc/guides/nics/sfc_efx.rst
> +++ b/doc/guides/nics/sfc_efx.rst
> @@ -10,7 +10,8 @@ Solarflare libefx-based Poll Mode Driver
>   
>   The SFC EFX PMD (**librte_net_sfc_efx**) provides poll mode driver support
>   for **Solarflare SFN7xxx and SFN8xxx** family of 10/40 Gbps adapters,
> -**Solarflare XtremeScale X2xxx** family of 10/25/40/50/100 Gbps adapters and
> +**Solarflare XtremeScale X2xxx** family of 10/25/40/50/100 Gbps adapters,
> +**Solarflare X45xx** family of 10/25/40/50/100 Gbps adapters and

Shouldn't 200 be added above?

>   **Alveo SN1000 SmartNICs** family of 10/25/40/50/100 Gbps adapters.
>   SFC EFX PMD has support for the latest Linux and FreeBSD operating systems.
>   
> @@ -21,6 +22,12 @@ More information can be found at `Solarflare Communications website
>   Supported NICs
>   --------------
>   
> +- AMD Solarflare Adapters:
> +
> +   - AMD Solarflare X4522 Dual Port SFP56 Adapter
> +
> +   - AMD Solarflare X4542 Dual Port QSFP56 Adapter
> +
>   - Xilinx Adapters:
>   
>      - Alveo SN1022 SmartNIC
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index b8b56510f8..467536fe05 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -60,6 +60,10 @@ New Features
>     Added a new network PMD which supports Mucse 10 Gigabit Ethernet NICs.
>     See the :doc:`../nics/rnp` for more details.
>   
> +* **Updated Solarflare network PMD.**
> +
> +  Added support for AMD Solarflare X45xx adapters.
> +
>   
>   Removed Items
>   -------------

