Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11332CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 11:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0168F402A0;
	Wed,  8 Oct 2025 13:25:41 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 56EA740297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 13:25:38 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso673532f8f.1
 for <dev@dpdk.org>; Wed, 08 Oct 2025 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1759922738; x=1760527538; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zEMRVZoozWfqW9Mrz5ROZ+bAImM0MrkVHOnZEN/nO68=;
 b=XFS8QmEAdaYJt4yxdiElABBD4/25m9EFLQiaWV4T2rQpNRM8ZezEWWw4aMqcOU18mb
 FHurazfhz07BQlLD7a7vlRbSsauCQ01d06YRXPqLsa+vvGeUvERb/PxiBy1FMTAxT5RQ
 5c7NCZ8lx3Vw/8ItauzsaHRxAkN6flE7Hqh1+OXZRoVlgqyIcjR59LPDszy0ih+ZdpF3
 451r4hIzEK73MDJvGXyagNisg0c2cXkDNepJ1bSHrfDVZdjR6V99I+WT/4CDNMxaT+Nm
 lSVUcagrYEGtwYMboxrkkSuN5/b2T10Dk4WaDdvHp5ELpvDRzS5HDtvprjUJbr/mhGhK
 klIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759922738; x=1760527538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zEMRVZoozWfqW9Mrz5ROZ+bAImM0MrkVHOnZEN/nO68=;
 b=IhuKPwExt0Z97/Yg2AVBSg+VUoKih7OXS1lshIrU30PMFYO8fue89mdHq4YKIqj1ZE
 lKyjU4Lrr1vw4Kx91/P+QHCAvNgw8NplW97EI3n4Vhm8FMbB493WzdI1aB4ERZR45/Hw
 Ui0BrkvMqn18unxVPf299KizJDXIV0cO+/COnou++sSJnDTG2ZUlCnmlwssADw3pOc2b
 y9X7G1mZ9hBiNN/+W4hbIkHKuHYZTD1GGfTrunnm7tI1mEk4x5+DlHCetEDjgzeZ2Fqr
 urJtAE3GiRbKoCeHdAlZ7XGmtW8kxf5HKHaxlMyos5ca554tex94xiyT7oi7D1eITszm
 TELQ==
X-Gm-Message-State: AOJu0YyNdZnNWXtxoNwsxFdyYvb2KN2o1cNaqqUHDVw9NOuLRJ3B/L0W
 ANF92kenaQZ3TOwIEmNV2l4uSbZZrDcKge3xQl/AJw6sVdtRk5EqjqStsdXnkD4kUw==
X-Gm-Gg: ASbGncvHvu/4TH7Kn2pI1WoFtVT/5xKP6P+oK3qrmWl1QGx5MwvPXmz4VYX8vuJFeyu
 glKtxb+3NzfiDaTpgKRo8H0AFSJfRRCKJk+2g8dH3XTtxVBD0T4hNkO8WyF67MAdNRUoTRKwQKY
 FzDmxBVIi2NPyUX7DyLm3BqMPdpCk94wjB0TnIu1KRaQiACbLl308o7r8IKeXAED7QGZoikPa5c
 V7kfmcDlbto22zz4Ecyce576xkGhmK1CDQWQiw9Sjd84xyDTXzdfK46nvSqNGDH4dBiWRTxvpiW
 pndxlOfxj9njWBaKE5swkbJwUllAnTkSL7RqRsOHpCCLVUHp3FqiQonJfSiE6JBaeKRjft78nyi
 Quruet5rqQEZB1GM+D+i1wveO5qNMoalgbMkkQfTPejxCAcpziuqUTbq4Ph2H8g==
X-Google-Smtp-Source: AGHT+IFFBqKzyc/9Ylw8JWzyzFekl/2urcEbjy6zmtR1mrPgLfFeoa8+sTtt0E+vKXEnVkmQ2T792w==
X-Received: by 2002:a05:6000:240b:b0:3eb:ad27:9802 with SMTP id
 ffacd0b85a97d-425829a5a91mr5108198f8f.2.1759922737752; 
 Wed, 08 Oct 2025 04:25:37 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab524f92sm11943625e9.7.2025.10.08.04.25.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 04:25:37 -0700 (PDT)
Message-ID: <796afc4b-4d8a-4f4a-9f6e-9752dcaaa250@6wind.com>
Date: Wed, 8 Oct 2025 13:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] net/intel/e1000: reduce the optimization level for gcc > 11
To: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Olivier Matz <olivier.matz@6wind.com>
References: <20251006124506.388456-1-thierry.herbelot@6wind.com>
 <20251006130257.391200-1-thierry.herbelot@6wind.com>
 <aOYi82c71qlZiazJ@bricha3-mobl1.ger.corp.intel.com>
 <4021689.xgJ6IN8ObU@thomas>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <4021689.xgJ6IN8ObU@thomas>
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

On 10/8/25 12:10, Thomas Monjalon wrote:
> 08/10/2025 10:38, Bruce Richardson:
>> On Mon, Oct 06, 2025 at 03:02:57PM +0200, Thierry Herbelot wrote:
>>> The e1000 PMD stopped working under Ubuntu-24.04 (using gcc-13) when
>>> compiled with -O3 (default level for all DPDK code). There is a crash
>>> when starting testpmd:
>>>
>>>> (gdb) bt
>>>> #0  rte_read32_relaxed (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:290
>>>> #1  rte_read32 (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:345
>>>> #2  e1000_read_addr (addr=0x1100800e00) at ../sources/drivers/net/intel/e1000/base/e1000_osdep.h:106
>>>> #3  e1000_id_led_init_generic (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/base/e1000_mac.c:1844
>>>> #4  0x000062aaf653c85f in e1000_init_hw_82540 (hw=0x1586788c0)
>>>>      at ../sources/drivers/net/intel/e1000/base/e1000_82540.c:308
>>>> #5  0x000062aaf6db8227 in em_hardware_init (hw=hw@entry=0x1586788c0)
>>>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:920
>>>> #6  0x000062aaf65340ff in em_hw_init (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/em_ethdev.c:445
>>>> #7  eth_em_dev_init (eth_dev=eth_dev@entry=0x62aaff346000 <rte_eth_devices>)
>>>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:314
>>>> #8  0x000062aaf6db8b71 in rte_eth_dev_pci_generic_probe (private_data_size=11240,
>>>>      dev_init=0x62aaf6db8310 <eth_em_dev_init>, pci_dev=0x62ab2853dd90) at ../sources/lib/ethdev/ethdev_pci.h:150
>>>> #9  eth_em_pci_probe (pci_drv=<optimized out>, pci_dev=0x62ab2853dd90)
>>>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:365
>>>> #10 0x000062aaf646adf5 in rte_pci_probe_one_driver (dr=dr@entry=0x62aaf82d8020 <rte_em_pmd>,
>>>>      dev=dev@entry=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:299
>>>> #11 0x000062aaf6a15f7d in pci_probe_all_drivers (dev=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:383
>>>> #12 pci_probe () at ../sources/drivers/bus/pci/pci_common.c:410
>>>> #13 0x000062aaf7a485f3 in rte_bus_probe () at ../sources/lib/eal/common/eal_common_bus.c:84
>>>> #14 0x000062aaf670585d in rte_eal_init (argc=argc@entry=146, argv=argv@entry=0x7fffca468898)
>>>>      at ../sources/lib/eal/linux/eal.c:1253
>>>
>>> The crash is linked to the use of gcc-13: under Ubuntu-24.04 testpmd
>>> compiled with gcc-11 from the same DPDK tree works as expected.
>>>
>>> The perfect solution would be for someone to investigate why the
>>> PMD crashes. However, this depends on Maintainer availability.
>>>
>>> A less-perfect solution is to reduce the optimization level
>>> (like another proposal for net/qede: see Link).
>>>
>> Thanks for reporting the issue. I'd like to spend a little time trying to
>> really root cause the issue before applying this workaround patch. Can you
>> provide a bit more info about the setup you used when you hit this issue. I
>> expect a lot of use of e1000 driver is in virtualized setups, but can you
>> confirm if that was the case here, or were you using real hardware?

Hello Bruce, Thomas

Sorry for the missing info: the issue was indeed seen in qemu (in more 
than one version).

I'm not sure we have a real NIC lying around, for this PMD.

>>
>> If we do have to apply this workaround fix of reducing optimization level,
>> I see you reduce optimization for both the base code and the DPDK-specific
>> driver code. Is it necessary to reduce optimization on both, or can we get
>> away with just reducing it on the DPDK part alone?

As for net/qede, I did not take time to investigate which piece of code 
was concerned. I just checked that testpmd really works in an 
Ubuntu-24.04 VM, when DPDK is compiled with gcc-11 rather than the 
default gcc-13.

Then the crude workaround is to drop the optimization level for all of 
the PMD. As for net/qede, '-O1' is a compromise as the PMD seems to be 
working fine, and still the performance is acceptable.

> 
> We are not sure the workaround will work with every compilers to come.
> Of course it is better to fix the root cause.

Agreed !

Would it be possible to have a list of the PMDs which are known to be 
currently being tested (for example e810, i40e for Intel) ? (and then 
the list of PMDs which are "under lighter monitoring")

	Best regards

	Thierry

> If we cannot fix it in time, we can add this workaround in the release notes.
> But please, let's not apply it in the codebase.
> 
> 

-- 
Thierry Herbelot
