Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440B9CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 22:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A99240267;
	Tue, 19 Aug 2025 00:41:49 +0200 (CEST)
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99]) by mails.dpdk.org (Postfix) with ESMTP id AD9DC40262
 for <dev@dpdk.org>; Tue, 19 Aug 2025 00:41:47 +0200 (CEST)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-70ba7aa13dcso26615866d6.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 15:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755556907; x=1756161707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mzob6CmG9loTUxhQK1fVhtEvW068soaczXjPHluaiok=;
 b=brHz66o4Kj2Id1b1vbFT4dLvT8N2LyJaZwCCESvfUE7XWiEbQ1BFWZ+lUIcqhkbJb4
 EGgxt/VX2Qc6SEET/SMCz2Wj88ci/YlzsEF28gDKAyL3dBhyTIWmb7zCsuf00xGQcicZ
 2wbiigu2eQB8q03TJZdpIiBZryrYJp14deTpR8/Ux7W2GdK1nodHWjINZLjtfvIagsTT
 qyDl8PAruU66m937A/4ANuxQCEkWZcjD9Grs9O5+o5c4jH0hSR8oGCYnS3q3kjEdtdjg
 b2c74WGdS2e8wB96L7ZXGn1bzv/dmspqMOTRkmmw3By3ENi9pMt+4GHbwVpr5WtYE5L1
 WaqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKQmYGeXXrS8FBRATZvjyftz6c4mKD0yzge8VcsACgr4j1RSQJ4twhQryzROQMGxljSbI=@dpdk.org
X-Gm-Message-State: AOJu0YwfVEr7amRuXzdLMkXAbywmCVJww/Yaa/1Sz+yLyQ6rSrwAj4Vk
 pyEe+KabR0XhaWcpDqWirGl4lihej4NBK4Zbd9hI/QXXFUsjULIy6yhtIYpGuhq874NOdJ5y2nH
 f4Mbli2n01OeR4osAVwciuVyJnhw0JhF3CrA03GSmxf/tlbNcYVNTpuckgLQVTvXlkvORY0I4lW
 FstmKHP+48+ocuAPeIt6+FwfWArKoU6iB5N5P7yMBJAadm6ssbPRI5X2xY+c+l3rqs/G3VScpj
X-Gm-Gg: ASbGncuQg8QU8eIBGLg7WhIIDnbvixlxq0irfuex9sJsIZvApjABZNONFH5alZnRNvV
 ZSI7TjN7BOJYyypHaFRusnuyAP0iaI3F2csidvbW6iFTreNI7lHIczbV3U41ZmVmm/JVT1JfcvK
 vKgFiQ607lBQduKvc1EI4noe4x1vnxh+kvdN02M35Czr3DK/uUHmFY9/A432pgyG8i3tNlB+k/Q
 ntq/IA9BCJn8qC+SVjYKlkRXal/978kmF9kL4IqZe1dxaIJoORdc67IOVklbqOlUWUSUse40Wd7
 fb9V/w4iqw4J7XQYcIbzltRNT9jyj2D75CLDk8511eEE/Xjp+DR+8CrvxSmyU41+XeKC9Lc3Ha/
 S0RFBHGDbWYeQgLmOJzxyR54labjsvgEtheFYY5H9PePReq97EexlSzOmYd5SjhhyJ7WpHrSq1y
 2pi6XY
X-Google-Smtp-Source: AGHT+IEQBCjmSmePBFgjAxlbPkG6GMWDF1MHSWr0GQuQfLxrH4ftFr1lVoTfqbehdiiXs8g3NGsGkVZLvHMc
X-Received: by 2002:a05:6214:130d:b0:709:66b9:cbbc with SMTP id
 6a1803df08f44-70c35d006b8mr3805816d6.33.1755556906559; 
 Mon, 18 Aug 2025 15:41:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-70ba921d6dfsm5708686d6.30.2025.08.18.15.41.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Aug 2025 15:41:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b109affec8so135579441cf.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1755556905; x=1756161705; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mzob6CmG9loTUxhQK1fVhtEvW068soaczXjPHluaiok=;
 b=XWu+rmuSGlzkEiu7oB5XPIqDnyFGSlSVBxYF/pnNBpxtQP7cOdX8WFG4XAlxiw7fuF
 jCYjiJdVkY79yKx5nv+ohy6541ezlV8aOj2yWUXsmfPjzQSgR6ksrv/Rr7OfFqkIWToa
 bEfxyB25htWpH9yQkXqUdcF7e2URb7VXXBvs8=
X-Forwarded-Encrypted: i=1;
 AJvYcCUNs7VPiivUbj765+b2mHNCrO1cZmxHMpuOzv1wYgV3FJWNFsq3vNvTgldL0ho/cNBXYHo=@dpdk.org
X-Received: by 2002:a05:622a:6187:b0:4b0:77a5:3789 with SMTP id
 d75a77b69052e-4b286e530ccmr4932401cf.43.1755556904829; 
 Mon, 18 Aug 2025 15:41:44 -0700 (PDT)
X-Received: by 2002:a05:622a:6187:b0:4b0:77a5:3789 with SMTP id
 d75a77b69052e-4b286e530ccmr4931951cf.43.1755556904190; 
 Mon, 18 Aug 2025 15:41:44 -0700 (PDT)
Received: from [10.211.4.130] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e192267sm670750585a.40.2025.08.18.15.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 15:41:43 -0700 (PDT)
Message-ID: <5041e328-46d2-4b56-8ec8-c766e7355c14@broadcom.com>
Date: Mon, 18 Aug 2025 15:41:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/1] ethdev: add support to provide link
 type
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Ronak Doshi <ronak.doshi@broadcom.com>
References: <20250813084508.1446318-1-skori@marvell.com>
 <20250814081215.1904078-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE35@smartserver.smartshare.dk>
 <20250814091556.6db159d0@hermes.local>
 <CO6PR18MB3860FCC393EF51C8664B364BB431A@CO6PR18MB3860.namprd18.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE41@smartserver.smartshare.dk>
Content-Language: en-US
From: Jochen Behrens <jochen.behrens@broadcom.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE41@smartserver.smartshare.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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



On 8/18/25 00:24, Morten Brørup wrote:
>> From: Sunil Kumar Kori [mailto:skori@marvell.com]
>> Sent: Monday, 18 August 2025 08.22
>>
>>> On Thu, 14 Aug 2025 11:04:18 +0200
>>> Morten Brørup <mb@smartsharesystems.com> wrote:
>>>
>>>>> From: skori@marvell.com [mailto:skori@marvell.com]
>>>>> Sent: Thursday, 14 August 2025 10.10
>>>>>
>>>>> Adding link type parameter to provide the type of port like twisted
>>>>> pair, fibre etc.
>>>>>
>>>>> Also added an API to convert the RTE_ETH_LINK_TYPE_XXX to a readable
>>>>> string.
>>>>
>>>> Please consider if "connector" is a better name than "link type", if this
>> is related
>>> to physical interfaces only.
>>>> E.g. is there an "LACP" link type for link aggregates (bonded links)?
>>>>
>>>> Also, should a "virtual" link type (or connector) be added for
>>> TAP/Virtio/VMXNET3/ring and similar non-physical interfaces?
>>>>
>>>> More comments inline below.
>>>
>>> My preference is that a new feature like this follow what other commands and
>>> standards do.
>>> There is Linux ethtool as the most common example.
>>> Also, there is probably something IEEE standard but that is behind stupid
>>> paywall.
>>>
>>> Ethtool on real NIC.
>>> # ethtool enp87s0
>>> Settings for enp87s0:
>>> 	Supported ports: [ TP ]
>>> 	Supported link modes:   10baseT/Half 10baseT/Full
>>> 	                        100baseT/Half 100baseT/Full
>>> 	                        1000baseT/Full
>>> 	                        2500baseT/Full
>>> 	Supported pause frame use: Symmetric
>>> 	Supports auto-negotiation: Yes
>>> 	Supported FEC modes: Not reported
>>> 	Advertised link modes:  10baseT/Half 10baseT/Full
>>> 	                        100baseT/Half 100baseT/Full
>>> 	                        1000baseT/Full
>>> 	                        2500baseT/Full
>>> 	Advertised pause frame use: Symmetric
>>> 	Advertised auto-negotiation: Yes
>>> 	Advertised FEC modes: Not reported
>>> 	Speed: 2500Mb/s
>>> 	Duplex: Full
>>> 	Auto-negotiation: on
>>> 	Port: Twisted Pair
>>> 	PHYAD: 0
>>> 	Transceiver: internal
>>> 	MDI-X: off (auto)
>>> 	Supports Wake-on: pumbg
>>> 	Wake-on: g
>>>          Current message level: 0x00000007 (7)
>>>                                 drv probe link
>>> 	Link detected: yes
>>>
>>> And on virtio
>>> # ethtool enp1s0
>>> Settings for enp1s0:
>>> 	Supported ports: [  ]
>>> 	Supported link modes:   Not reported
>>> 	Supported pause frame use: No
>>> 	Supports auto-negotiation: No
>>> 	Supported FEC modes: Not reported
>>> 	Advertised link modes:  Not reported
>>> 	Advertised pause frame use: No
>>> 	Advertised auto-negotiation: No
>>> 	Advertised FEC modes: Not reported
>>> 	Speed: Unknown!
>>> 	Duplex: Unknown! (255)
>>> 	Auto-negotiation: off
>>> 	Port: Other
>>> 	PHYAD: 0
>>> 	Transceiver: internal
>>> 	Link detected: yes
>>
>> Agreed, hence adding one more type RTE_ETH_LINK_TYPE_OTHER to align.
> 
> Ethtool has both NONE and OTHER:
> https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/tree/uapi/linux/ethtool.h#n2242
> 
> Ethtool doesn't have a 3rd value UNKNOWN, and I think having a 3rd value complicates things too much.
> 
> I still think we should consider OTHER==UNKNOWN, and that NONE (having no connector) cannot happen and thus should be omitted.
> Having more than one of these adds complexity, and I fail to see the benefit.
> 
> "Because Ethtool also has NONE" is not a good argument. Linux has plenty of obsolete stuff, which we don't need to copy to DPDK.
> However, referring to the reason why Ethtool also has NONE (in addition to OTHER) might reveal a valid argument for having it in DPDK too.
> 
> Anyway, if we have more than one value (in addition to the actual physical connector values), they need good descriptions, so it is crystal clear what the difference is between NONE and OTHER (and UNKNOWN, if we proceed with this 3rd value).
> 

All that being said, vmxnet3 does mimic a physical device (with a PCI 
address).

Ethtool output in Linux shows this:

# ethtool eth0
Settings for eth0:
	Supported ports: [ TP ]
	Supported link modes:   1000baseT/Full
	                        10000baseT/Full
	Supported pause frame use: No
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  Not reported
	Advertised pause frame use: No
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: 10000Mb/s
	Duplex: Full
	Auto-negotiation: off
	Port: Twisted Pair
	PHYAD: 0
	Transceiver: internal
	MDI-X: Unknown
	Supports Wake-on: uag
	Wake-on: d
	Link detected: yes


The link speed may change in a future version.

