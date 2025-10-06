Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E2CCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 13:01:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13665402D1;
	Mon,  6 Oct 2025 15:01:36 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 1C6C3402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 15:01:34 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso2862040f8f.0
 for <dev@dpdk.org>; Mon, 06 Oct 2025 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1759755693; x=1760360493; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qrpa/N3fIdS2ilbZ7UAkHKskhUoS5m2yU85eVPGOB8c=;
 b=eJHnfOam+RrG4NehZbZwPz6iAZXumCdaTqKCE3Qp/RylIAOz/hvbBMT87muClsPOGM
 XvDzyf9nIbCT15ew18AW7aPWatTlqlyBpV6Hjd4VrKG90JdXZzPhA/MyqL+TPblXY4iW
 fH0oZlG3dQAILmgiX7zS2+Wro8Zg/fWSm3r10W/G+gAjcxOhJ7y56lbXMAbe1Uy/xpb5
 KPK+7szVwvW9eJ5UsjlwK/dxL+mQ5P2QDRKNS/m/haFAQo+Lyb7uhnOpAZWMu7g+EXoe
 b0OFZSreo4IG4qsTh6XgJLTK95esKdSD/G6SqE96o+U+XgZaAPe0FKKe6UZK0WAqwhA2
 5Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759755693; x=1760360493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrpa/N3fIdS2ilbZ7UAkHKskhUoS5m2yU85eVPGOB8c=;
 b=Fwxv4yk9hWCFxpk5YPCfnJO6pTpOfl1hs3Dvn950WbOzCYzsQ8ORvu9btyCogJwMj6
 S637hFI0MF+h3T1lnUn78VNHjymjO7fU+pSfIUo7tQmWTYFSKNkNudZEyYUrIVPVBhuV
 CWc8l/pPLynaueUUCi2x+Ctn4X9ekL2eUxNo8Y6J26efChqCO12slnRUDQ0pWQBh1Rbk
 Lb5gBvuQ2syvvGGp/BjENI2pfTMVcbPlpINL83z0ElcgEf5YGvdR+iCe71F1KCbsF4SY
 COHOnrxfkG/5hUQGIwC53fLObB/yGxQinUq9azoCH8QAS47eTkcs5CIWnNcoEncn2wJp
 lJag==
X-Gm-Message-State: AOJu0YwA+FCvF86coZueiXfOaJH2xx4SuMzTDPoI1Kul9lzshTtjXrVc
 8D2d2F2SavrKWI5lNr4yrge2r3s8BmlZfPL605+XCNjFoQ5o9snKb+V/rphxV+DOAA==
X-Gm-Gg: ASbGncttow0mWElABw2nc9h4XxwQU0cuvUjwgJOt8PzJpk/BGpmuXhlnlVonm9a65X1
 wFbqslheKRqhphrx76AwlcYv2NWiTUvgMJM3QX8IO86p+JCSDt7c4MgkBXxs/J/T7Hks4n6pnuF
 to+lki6619nk8JoYpz51aOmWgpLZ827r7B/P1k4c7salt4Q5ZKdKUskTEd/GRYs/l62QrTIyN/M
 /H8tIAAnvOmb+SDNssxymI9D+Tyjh6w+6suh6il2OH0Tc/DprtPf3bYl0ibLo8MYi22ykRjayNI
 pFHB2EeImPcOr5FIFeZyzqPdEERfPfia206ezaxNM5mP5TS77sC9URlqu126vSeMSCZRncL5rAF
 qmpV+nyUqLGhNLcenHmS3hr4hSM6DHpUI6/XavZM7w6gA+nYef1D1nsyeNgzWvw==
X-Google-Smtp-Source: AGHT+IGz3KWfC9bOxvrxjzi/E5/DRxgOoj18Etz9ZD1FSIxgcYhJG5X3bynJVWCWH/j5oY/wZsJoIw==
X-Received: by 2002:a05:6000:2082:b0:3ec:a019:3944 with SMTP id
 ffacd0b85a97d-425671ac313mr8006247f8f.43.1759755692025; 
 Mon, 06 Oct 2025 06:01:32 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a8542sm20783554f8f.9.2025.10.06.06.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 06:01:31 -0700 (PDT)
Message-ID: <8f14ef89-8f1a-42e7-8cf3-e609de32a98d@6wind.com>
Date: Mon, 6 Oct 2025 15:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/intel/e1000: reduce the optimization level for gcc >
 11
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Olivier Matz <olivier.matz@6wind.com>
References: <20251006124506.388456-1-thierry.herbelot@6wind.com>
 <CAJFAV8zvhYiOy=PuUctg8N7EyM6asQdDNpnx_Xc+WusCz02L+A@mail.gmail.com>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <CAJFAV8zvhYiOy=PuUctg8N7EyM6asQdDNpnx_Xc+WusCz02L+A@mail.gmail.com>
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

On 10/6/25 14:55, David Marchand wrote:
> On Mon, 6 Oct 2025 at 14:45, Thierry Herbelot
> <thierry.herbelot@6wind.com> wrote:
>>
>> The e1000 PMD stopped working under Ubuntu-24.04 (using gcc-13) when
>> compiled with -O3 (default level for all DPDK code). There is a crash
>> when starting testpmd:
>>
>> (gdb) bt
>> #0  rte_read32_relaxed (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:290
>> #1  rte_read32 (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:345
>> #2  e1000_read_addr (addr=0x1100800e00) at ../sources/drivers/net/intel/e1000/base/e1000_osdep.h:106
>> #3  e1000_id_led_init_generic (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/base/e1000_mac.c:1844
>> #4  0x000062aaf653c85f in e1000_init_hw_82540 (hw=0x1586788c0)
>>      at ../sources/drivers/net/intel/e1000/base/e1000_82540.c:308
>> #5  0x000062aaf6db8227 in em_hardware_init (hw=hw@entry=0x1586788c0)
>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:920
>> #6  0x000062aaf65340ff in em_hw_init (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/em_ethdev.c:445
>> #7  eth_em_dev_init (eth_dev=eth_dev@entry=0x62aaff346000 <rte_eth_devices>)
>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:314
>> #8  0x000062aaf6db8b71 in rte_eth_dev_pci_generic_probe (private_data_size=11240,
>>      dev_init=0x62aaf6db8310 <eth_em_dev_init>, pci_dev=0x62ab2853dd90) at ../sources/lib/ethdev/ethdev_pci.h:150
>> #9  eth_em_pci_probe (pci_drv=<optimized out>, pci_dev=0x62ab2853dd90)
>>      at ../sources/drivers/net/intel/e1000/em_ethdev.c:365
>> #10 0x000062aaf646adf5 in rte_pci_probe_one_driver (dr=dr@entry=0x62aaf82d8020 <rte_em_pmd>,
>>      dev=dev@entry=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:299
>> #11 0x000062aaf6a15f7d in pci_probe_all_drivers (dev=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:383
>> #12 pci_probe () at ../sources/drivers/bus/pci/pci_common.c:410
>> #13 0x000062aaf7a485f3 in rte_bus_probe () at ../sources/lib/eal/common/eal_common_bus.c:84
>> #14 0x000062aaf670585d in rte_eal_init (argc=argc@entry=146, argv=argv@entry=0x7fffca468898)
>>      at ../sources/lib/eal/linux/eal.c:1253
>>
>> The crash is linked to the use of gcc-13: uner Ubuntu-24.04 testpmd
>> compiled with gcc-11 from the same DPDK tree works as expected.
>>
>> The perfect solution would be for someone to investigate why the
>> PMD crashes. However, this depends on Maintainer availability.
>>
>> A less-perfect solution is to reduce the optimization level
>> (like another proposal for net/qede: see Link).
>>
>> Note: if more regressions are seen in less-frequently used PMDs,
>>        maybe we should switch the default optimization level to -O1,
>>        (tree-wide) and only rise the optimization level for actively
>>        maintained PMDs, which are proven to work as expected with
>>        higher optimization levels.
>>
>> Link: http://patches.dpdk.org/project/dpdk/patch/20250909054023.3263401-1-thierry.herbelot@6wind.com/
>> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> 
> NAK.
> Please RCA this rather than hiding such an issue.

Hello David,

As said in the commit log, this is clearly a Maintainer issue, who will 
have the hardware documentation. The PMD is broken, and this was not 
seen until a new gcc is used.

We can not expect a random developer to sprinkle memory barriers in the 
PMD until testpmd seems to be working.

	Best regards

	Thierry


-- 
Thierry Herbelot
