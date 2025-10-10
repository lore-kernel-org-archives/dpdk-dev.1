Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F06CCD185
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 13:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6D740672;
	Fri, 10 Oct 2025 15:23:51 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id DB58040672
 for <dev@dpdk.org>; Fri, 10 Oct 2025 15:23:49 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso11570785e9.2
 for <dev@dpdk.org>; Fri, 10 Oct 2025 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1760102629; x=1760707429; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jbO97MW2T9IbimW+rewgEVdECk9nlwGV5axgwXC1u+g=;
 b=MTapforfTnvbOK0AYdOshNxTTjX1vRQAS8oxr3KblZU8wV8teTTeXJc/18D39Kk9n1
 3bediblcUmPbQHf+el/kf+wU2Ecm8p5ZD4b/eBVU4y3iGVazw2cedelA0GTwGA7y2D6G
 pFC79yYwLY0VlCtxc+3AA6CO+ckVoNBfdUOVwNuvtm3g3449WP/fyJy+dPwvqvAc6z6u
 6ofh7rTrwteJzk6Iydr8ZDB7qik9vqai1EFvl0nAJbuFcifZO9xooFVdieKxZCWAVhPj
 +/naB3Pf05TL9FUaDppuzdbHRwJGEz9YZUgRqgp6BxDPQf3C0zxG6jOUFIPE9mnHlYvZ
 LW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760102629; x=1760707429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbO97MW2T9IbimW+rewgEVdECk9nlwGV5axgwXC1u+g=;
 b=FpIahCnMzSZ+E6/ZmcK0OZAiRpw1sPBzDvqQwbc/zMRAsgl7kiEr49wcKjtiTUHvxz
 XYknvvO5fcbRK+ebxZCMxftXT7lzPQt9/Iq6187awKXdTWtddLzCS97RpQCpTYyL4UU7
 Jduj7yJooDpQRQRE5iXHuZdO/dxIJmSohl13iWIyUflOwslnnoRW4NW3VG4xUAbi2Yar
 7YdfYJFBCEzDEcCezqsGHqK9d3iBerBr+lE9r6HkQJr9FyX1o9HzqJWOpr4jh3gx9KWJ
 zg6V65ooP48/ndEjVR6kR3BZ+xuj9skAh+BWkNuIcspTl/1M8hQ0vFFOroBL0QjpnaYE
 545Q==
X-Gm-Message-State: AOJu0YydTEoEc6KzUQ62QPrD0GsUcfNB1bKBTeNE1aqznZquaD18dJ5l
 3VdaNVZAD4fEP5jJ8wELD00efE2O8fmG5mfYcY9Ngl9SC9QquvB0XA/L6hcJ0H9f4w==
X-Gm-Gg: ASbGncvEAHf1b7qFzN7RdMeGt69hixCZ2efP//5jcE77sYNnnufcoKoBcZ/eObIFvnd
 ZhQHXBKzbOKWVOlJnSYYpz/PnVnLiz9RvG5M8itN5WY+mIm+6FVauLAsnc8ollj8YLK5FDKIyeS
 LJAda85rmlgyct6S+D9uaNeBhhLMJrJ0Uflhw26IZ51Pbkh8oxFwB77PR6krRaLJprhIupluoDG
 TYwWiHlAMduEcl1wJV7rJeKSaDvmTxypul/K8wdAu4kWrpV/BFzsek4lSDaaFzMelFShIc2XsHc
 XRTrYTc0vFrJ765CKthughDLB3vi3Rxuxapn42SkG7yhBA84bR6Bu1pgvRs0tZgGvEa55CgnqRD
 cOD0zdsJ1UdkqKI8WJhMI5nofyercToaRqkWhWR6o4FF73Gr+axOQo32S
X-Google-Smtp-Source: AGHT+IH+tjFzgQ5/r23d78SAUUaPtRkCynJNG8VIhU5z4Ovp8CJhBhtrNP0I3Kr+lSKTBE4VDVEsnw==
X-Received: by 2002:a05:600c:1f84:b0:46e:4cd3:7d54 with SMTP id
 5b1f17b1804b1-46fa9aef45fmr80314105e9.18.1760102629462; 
 Fri, 10 Oct 2025 06:23:49 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49be017sm45620505e9.13.2025.10.10.06.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 06:23:46 -0700 (PDT)
Message-ID: <795fdbeb-918c-4b35-9811-746b5df719c5@6wind.com>
Date: Fri, 10 Oct 2025 15:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] net/intel/e1000: reduce the optimization level for gcc > 11
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Olivier Matz <olivier.matz@6wind.com>
References: <20251006124506.388456-1-thierry.herbelot@6wind.com>
 <20251006130257.391200-1-thierry.herbelot@6wind.com>
 <aOkIFu1EtAcgId22@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <aOkIFu1EtAcgId22@bricha3-mobl1.ger.corp.intel.com>
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

On 10/10/25 15:20, Bruce Richardson wrote:
> On Mon, Oct 06, 2025 at 03:02:57PM +0200, Thierry Herbelot wrote:
>> The e1000 PMD stopped working under Ubuntu-24.04 (using gcc-13) when
>> compiled with -O3 (default level for all DPDK code). There is a crash
>> when starting testpmd:
>>
>>> (gdb) bt
>>> #0  rte_read32_relaxed (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:290
>>> #1  rte_read32 (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:345
>>> #2  e1000_read_addr (addr=0x1100800e00) at ../sources/drivers/net/intel/e1000/base/e1000_osdep.h:106
>>> #3  e1000_id_led_init_generic (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/base/e1000_mac.c:1844
>>> #4  0x000062aaf653c85f in e1000_init_hw_82540 (hw=0x1586788c0)
>>>      at ../sources/drivers/net/intel/e1000/base/e1000_82540.c:308
>>> #5  0x000062aaf6db8227 in em_hardware_init (hw=hw@entry=0x1586788c0)
>>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:920
>>> #6  0x000062aaf65340ff in em_hw_init (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/em_ethdev.c:445
>>> #7  eth_em_dev_init (eth_dev=eth_dev@entry=0x62aaff346000 <rte_eth_devices>)
>>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:314
>>> #8  0x000062aaf6db8b71 in rte_eth_dev_pci_generic_probe (private_data_size=11240,
>>>      dev_init=0x62aaf6db8310 <eth_em_dev_init>, pci_dev=0x62ab2853dd90) at ../sources/lib/ethdev/ethdev_pci.h:150
>>> #9  eth_em_pci_probe (pci_drv=<optimized out>, pci_dev=0x62ab2853dd90)
>>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:365
>>> #10 0x000062aaf646adf5 in rte_pci_probe_one_driver (dr=dr@entry=0x62aaf82d8020 <rte_em_pmd>,
>>>      dev=dev@entry=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:299
>>> #11 0x000062aaf6a15f7d in pci_probe_all_drivers (dev=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:383
>>> #12 pci_probe () at ../sources/drivers/bus/pci/pci_common.c:410
>>> #13 0x000062aaf7a485f3 in rte_bus_probe () at ../sources/lib/eal/common/eal_common_bus.c:84
>>> #14 0x000062aaf670585d in rte_eal_init (argc=argc@entry=146, argv=argv@entry=0x7fffca468898)
>>>      at ../sources/lib/eal/linux/eal.c:1253
>>
>> The crash is linked to the use of gcc-13: under Ubuntu-24.04 testpmd
>> compiled with gcc-11 from the same DPDK tree works as expected.
>>
>> The perfect solution would be for someone to investigate why the
>> PMD crashes. However, this depends on Maintainer availability.
>>
> Hi,
> 
> can you test with [1]. It's still a workaround while we investigate more,
> but a less severe one!

Hello,

Thanks for the quick turnaround.
The compilation is ongoing. I will post ASAP, when the test has run.

	Thierry>
> /Bruce
> 
> [1] https://patches.dpdk.org/project/dpdk/patch/20251010125848.965340-1-ciara.loftus@intel.com/

-- 
Thierry Herbelot

