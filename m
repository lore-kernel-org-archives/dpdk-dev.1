Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DF8C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 08:09:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4C2F400D6;
	Thu, 17 Apr 2025 10:09:33 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id D77E2400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 10:09:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru C79714C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1744877371;
 bh=9osDYG/SxHBSoL48QNUTbnJI8TvitHz4X4MHrfLVzVo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cFR03zVjkKCJO34EeY7Y5iRITBwU1dEXE0ZTfdWhpA1jSbn5F0foLWHiIUYyCCvsl
 w6YC1+BhnuZmS/ojHeEMH2kgnYQdFr9FqSIuvHFRkE9fnxK7kKQPJxV+y7/MZ6lkyq
 xFhV6fQOg5oRG4/iofkhxpkNY4n8yMiS5AuPsPKM=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id C79714C;
 Thu, 17 Apr 2025 11:09:31 +0300 (MSK)
Message-ID: <7564f2c9-a013-4fc1-b8d8-d2f43340ea44@oktetlabs.ru>
Date: Thu, 17 Apr 2025 11:09:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] Support AMD Solarflare X45xx adaptors
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

On 4/16/25 16:59, Ivan Malov wrote:
> New X4522 (dual port SFP56) and X4542 (dual port QSFP56) adaptors are
> Medford4 (X4) chips that are based on EF10 architecture. An X4 NIC
> supports multiple network engine types. This series provides support
> only for the Medford2-alike, 'full-feature' (FF) network engine. This
> shall not be confused with the concept of 'datapath FW variants': the
> FF network engine supports both 'full-feature' and 'ultra-low-latency'
> datapath FW variants, with corresponding Medford2-alike feature sets.
> 
> The first part of the series provides general support for the adaptors,
> whilst the second one adds support for the new management controller
> interface for configuration of network port features (netport MCDI).
> 
> For now, only support for physical functions (PFs) is concerned. There
> is a small number of TODO and FIXME markings in the code. Those are
> normal at this development stage and will be removed by future patches
> when VF support has fleshed out.

In fact number of TODO and FIXME is frightening. But it is up to you.

Other than that, there are few nits in patches.
Overall looks good.

> Andy Moreton (3):
>    common/sfc_efx/base: update X4 BAR layout and PCI IDs
>    net/sfc: add Medford4 with only full feature datapath engine
>    common/sfc_efx/base: add port mode for 8 port hardware
> 
> Denis Pryazhennikov (15):
>    common/sfc_efx/base: add Medford4 PCI IDs to common code
>    common/sfc_efx/base: add efsys option for Medford4
>    common/sfc_efx/base: add Medford4 support to NIC module
>    common/sfc_efx/base: add Medford4 support to EV module
>    common/sfc_efx/base: add Medford4 support to FILTER module
>    common/sfc_efx/base: add Medford4 support to INTR module
>    common/sfc_efx/base: add Medford4 support to MAC module
>    common/sfc_efx/base: add Medford4 support to PHY module
>    common/sfc_efx/base: add Medford4 support to TUNNEL module
>    common/sfc_efx/base: add Medford4 support to MCDI module
>    common/sfc_efx/base: add Medford4 support to Rx module
>    common/sfc_efx/base: add Medford4 support to Tx module
>    drivers: enable support for AMD Solarflare X4 adapter family
>    common/sfc_efx/base: add new X4 port mode
>    common/sfc_efx/base: extend list of supported X4 port modes
> 
> Ivan Malov (28):
>    common/sfc_efx/base: update MCDI headers

Hm, bug here. End column is not aligned :)

>    common/sfc_efx/base: provide a stub for basic netport attach
>    common/sfc_efx/base: provide defaults on netport attach path
>    common/sfc_efx/base: obtain assigned netport handle from NIC
>    common/sfc_efx/base: allow for const in MCDI struct accessor
>    common/sfc_efx/base: get netport fixed capabilities on probe
>    common/sfc_efx/base: decode netport link state on probe path
>    common/sfc_efx/base: fill in loopback modes on netport probe
>    common/sfc_efx/base: introduce Medford4 stub for PHY methods
>    common/sfc_efx/base: refactor EF10 link mode decoding helper
>    common/sfc_efx/base: provide PHY link get method on Medford4
>    common/sfc_efx/base: implement PHY link control for Medford4
>    common/sfc_efx/base: introduce Medford4 stub for MAC methods
>    common/sfc_efx/base: add MAC reconfigure method for Medford4
>    common/sfc_efx/base: fill in software LUT for MAC statistics
>    common/sfc_efx/base: fill in MAC statistics mask on Medford4
>    common/sfc_efx/base: support MAC statistics on Medford4 NICs
>    common/sfc_efx/base: implement MAC PDU controls for Medford4
>    common/sfc_efx/base: correct MAC PDU calculation on Medford4
>    net/sfc: make use of generic EFX MAC PDU calculation helpers
>    common/sfc_efx/base: ignore legacy link events on new boards
>    common/sfc_efx/base: add link event processing on new boards
>    net/sfc: query link status on link change events on new NICs
>    common/sfc_efx/base: subscribe to netport link change events
>    net/sfc: offer support for 200G link ability on new adaptors
>    common/sfc_efx/base: support controls for netport lane count
>    net/sfc: add support for control of physical port lane count
>    doc: advertise support for AMD Solarflare X45xx adapters

Same here

