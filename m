Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4694E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 07:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF155402E0;
	Wed, 18 Feb 2026 08:43:39 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 58B764014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:43:37 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso3233528f8f.0
 for <dev@dpdk.org>; Tue, 17 Feb 2026 23:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1771400617; x=1772005417; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kgYRlRw4nMn1v+RIo9QUiQ1mn3BNlMDnJPxfNiZm06M=;
 b=DeifM3q8bCPL1jHUgruchS6JqomJGzSp5oLCkqkEw8mhBexvLnuk0hr+cSGIWx+bRk
 ahq7cZKfTjTaO0OQU76otiza30b5bFe9/7Rt/b15Q0Vmy1HHpj8yHbmcpotQV4a11smW
 4Mx/ehx2hfYQA0GBTCCeT9tqss6dWKUjST4BGgvRgnAs5FBfXFuzMreF7gUPUoyp7WVP
 OIUb1e6ky+9elER5KYohP9u/waIDjWpISnXEFRFVe5UesTG2DwVYcmG8aAv2361U1SYs
 /l01V8/ZLZu7xq/FJbsXq+sIX2iYHKSFuXpV9JEqkd+HgMs3x8PvyMFtjbwiflFpX1nf
 /itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771400617; x=1772005417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgYRlRw4nMn1v+RIo9QUiQ1mn3BNlMDnJPxfNiZm06M=;
 b=icF0GMD8cwo2GdOrx1uHE0/EgeGhIl0XqTWAXtxNHivO5M3lMcbfMkUbWtbF5Ex/aW
 Zo63oBq+n6n3O48uMbzx7mDhTdPRZ54CNf8WCFZsoOhw9O2lOAR/n4T2Dh8+1wYug/n4
 gO2CTOEABlep4rmGNETzr4ZFA75Fi1NUdwTHfI8r/1ETKC6UGgyAv22odH7dB/galtZB
 qUBwZ2O/lJiKJotticWlegvW7FSr32PLAGgk/gqwToEa2+BxgjoD2IXKg80R8+Jjx4c2
 xP4XiUi3DPZTz8nrH9eaxX6yXAvqKTnhOpxqUQN6PcoTOgghmLz8TCjySDEA6kSAa7Tq
 gAjQ==
X-Gm-Message-State: AOJu0YxnJUxD6B8ZEXOARmjRc3uwZFDN3pEsd1ZLAB9lBTE6gB6phivj
 Til0K1lTe//OcWb5s770PMlKKKJF0csKTLvRaganNUAwq5qVceaL3u1qSNHxJ0zIKw==
X-Gm-Gg: AZuq6aLWkqDU0MGmErXUXiW4t9ytUrUyNhjq4JKcS4s30t+QxDhUq/swthRMR2dDYE7
 ODiO4ymHgfOz3Jf42Osbwl3WSnbzuGXoIQiliORgRMCBV5sGdtb6QcJnK5U8VNqzjDxCi5XFxUN
 +c7KJu9uqiVZcWyz2hukTNrc6/qPl9awxgO81FeMD3jePXs+bAN/yiz821mNFLjWomNRHU8OSLi
 Ljdmxr4J5C5jMrt07yGoZ00dnlLuu6Pz8E0NBwQskHkDZYYQDaolxzmDF8GcyyzSJHwVLoxDl6b
 SZBnDmwW5ijcAuE/JQREZLqGs81Ekk4u1JfmXjR+jO8WjSfmNWVspNjytDNIIEaLsr2rx7rKuhc
 Y6/VbG8SzHf6HJrWouQjBRIbmvxydzEtJFhjHBg7kSoGOSHdZ1v4uR/jbs+5XSZNvxbqi6gp6om
 4yRjZ61E7JUkVbIO9MSKjX0yE38nNQrwyBmci4bQ==
X-Received: by 2002:a05:6000:184f:b0:436:30b0:75a0 with SMTP id
 ffacd0b85a97d-43796aefe7dmr29087298f8f.37.1771400617003; 
 Tue, 17 Feb 2026 23:43:37 -0800 (PST)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad015bsm41128830f8f.38.2026.02.17.23.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 23:43:36 -0800 (PST)
Message-ID: <77498d19-80a8-457e-ba05-22047a5edf68@6wind.com>
Date: Wed, 18 Feb 2026 08:43:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usertools/pmdinfo: fix search for PMD info string
To: Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, stable@dpdk.org
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260217124844.1458644-1-bruce.richardson@intel.com>
 <CAJFAV8wcc_+6AY2029ZV8=ft9qYmbztStodF88tVXUS_UPPXMw@mail.gmail.com>
 <aZSsl2wcdM6RFDKL@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <aZSsl2wcdM6RFDKL@bricha3-mobl1.ger.corp.intel.com>
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

On 2/17/26 18:59, Bruce Richardson wrote:
> On Tue, Feb 17, 2026 at 06:53:20PM +0100, David Marchand wrote:
>> On Tue, 17 Feb 2026 at 13:49, Bruce Richardson
>> <bruce.richardson@intel.com> wrote:
>>>
>>> The PMD_INFO_STRING constant string is not guaranteed to appear in the
>>> output binary immediately after an unprintable character. Because of
>>> this, in some cases the information for a driver could be missed by the
>>> PMD info script as it only checks for the prefix at the start of strings
>>> that it finds. Change the script to use "s.find()" rather than
>>> "s.startswith()" to fix this issue.
>>>
>>> Fixes: 0ce3cf4afd04 ("usertools/pmdinfo: rewrite simpler script")
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>
>> Surprising we hit this issue only now.
> 
> Agreed. Two thoughts here:
> 1. are the compilers normally arranging the data in ways that nearly
> guarantee that the strings are not prefixed by other printable data?
> 2. if we were missing a couple of drivers from dpdk-pmdinfo, would it
> really be noticed? Even in the reported case, there were actually 3 missing
> driver listings, but only one was actually noticed.
> 
> I'd suspect #2 myself. :-)
> 
>> Acked-by: David Marchand <david.marchand@redhat.com>
>>
>> It would be good to hear back from the initial reporter.
>>
> Agreed. I'd like independent confirmation that this fixes the issue on RHEL
> 9 as reported.

Hello Bruce,

Sorry for the late response.
I confirm your patch does fix the original issue:

$ head -2 /etc/os-release
NAME="Red Hat Enterprise Linux"
VERSION="9.7 (Plow)"
$ meson setup build
$ ninja -C build
...
$ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
     "name": "net_ixgbe_vf",
     "name": "net_ixgbe",

Thanks !

	Best regards

	Thierry

> 
> /Bruce

-- 
Thierry Herbelot

