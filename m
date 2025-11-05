Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F7CCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4B574060B;
	Wed,  5 Nov 2025 08:36:40 +0100 (CET)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53]) by mails.dpdk.org (Postfix) with ESMTP id ACD4C402ED
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:36:39 +0100 (CET)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-594270ec7f9so3582253e87.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 23:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762328199; x=1762932999; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u9g7iNs1SqP42lD2icAonetB7hMjRL5pssirU0tx/Ew=;
 b=k2cAc1iLLUyYb94HiBUQpmujewN8VfAx7EQTSiZeXS8p2kNMRDNOf9f4rxh/D7d4zq
 EpEzb6YXJlSbkbITFa3fUB2AwhJaXzDM0IrvQLu2CraXSXTxdbW2EitCCJxSHdkSnO2d
 C71INHQI+fHPWpAh0mROydEAf3Dzpxs9LMlFBLr3SCcOhLZvI8h8KdTpO//ejY5xweZl
 XBOIiXRaPKdg7jPbK2KuC1nezx/wf8ImaRtqdfKaEG1eOSnq2cyFv2hILe77Yf4Xe/l2
 qpeaTRVzlxHlQfg+i36hwrFaHY8rSQAR6RWmtm93V4XI/keT6OYKUVG5hUJvVag3Yr0B
 H4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762328199; x=1762932999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u9g7iNs1SqP42lD2icAonetB7hMjRL5pssirU0tx/Ew=;
 b=TZlcxyPC1CdBaAxif6VB4HXgJmWmgqAfNwy/MASBjlLdXSryDhZJLO86kHweMcXwgB
 WNxtEbh8rEesVb1XqwaM+gJ4zBk2NxhGE/UE6WdUCcG6VAPFIrSOBOPzBi3564UW/9W6
 pmcO2pdpqHIRnljiVNQ6ZkbJIq1zHcBu7LvU/lZbTwvX7ydzj5uDtyIrYqhascvEOM3t
 4/4LKpD24KQsM0DW6Q06+nQ72f+pKdM8bB/ElcsLH5A2/j3Kc7zKgSh9Z2rEGZf/sJVI
 xWLq+bOT9sK0m19dc/ueqDR5kwdeKbTjBI80Oo2pphHhxdm+CXjLnd0OMrLaDCajDQSI
 x3QA==
X-Gm-Message-State: AOJu0YzyBFNvS6ji9731SBe0aqb81ZZuo8CNEjyfxFwYitB0ztVsQSYK
 kV79soHRGQwNxLGBbqoyO7Vflzy0nvXr5DrUR0v14bWOmeA1PWPd69mI
X-Gm-Gg: ASbGncuIDKkNwvIxJbJ4VJ61cPhweKyt3wqmZJMHmwI5C1GLJtff19+5oBg1tAmnYWE
 ELzs0fNjdp0Tlsss4edQX85Uz3FD1FFidEfqi+w8XkBi/XGRSCNmtE1p2LUomvAaj+oqC2smIxs
 Lzw86nPLaehY+cQaM1oHEnqYEW25IGPykrhn6K0UYk9Azg6ZoqucOKdsghUPrLOL9dMh5qd4VJx
 rB3GFl6nBuyXVKrSLZamUJICXsY4qkaw5Jtb5U7/rdNLdxaUpxy6DO7XBs6Js6oLCp9c2KyvrBJ
 LwCaqeui0wvwoYxkdJdMleIP7DWXMt+NCp9A+Jglh2NiozK1GG4q8duOq7S8jakG81s9Zwa0YRM
 wdNZP/J0bYbG2jWiTKz0SyqmQbIwISCGg0OQtF4IV9enZIHCU/xDyGz1G32DfmApkEo6HE1n2xV
 Fw2tKUkT5rHzR/I1/H+t7uQA3Msf6sIyoyP2p2T689fnzoroI+rFrAi8PHRiZl8cOV8eGxEhqkg
 aCm
X-Google-Smtp-Source: AGHT+IGcZ8xNmIJwgiCarYaJlsBgRF2FVpyvTCdzppTZCJZObhByXOAKDW/Prd0WVzvab+MlH97T1A==
X-Received: by 2002:a05:6512:3d08:b0:594:3340:1b77 with SMTP id
 2adb3069b0e04-5943d55cac2mr567258e87.1.1762328198679; 
 Tue, 04 Nov 2025 23:36:38 -0800 (PST)
Received: from [192.168.88.232] (broadband-188-32-202-29.ip.moscow.rt.ru.
 [188.32.202.29]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-594342db7absm1509483e87.0.2025.11.04.23.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 23:36:37 -0800 (PST)
Message-ID: <85f9def5-7f88-47d1-9dc8-524b060c54e5@gmail.com>
Date: Wed, 5 Nov 2025 10:36:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Assistance with DPDK on Windows
To: Thenveer Poolakkanni <thenveer.poolakkanni@iwave-global.com>,
 "andremue@linux.microsoft.com" <andremue@linux.microsoft.com>
Cc: dev <dev@dpdk.org>, Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>,
 Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
References: <PN3P287MB0273982789E89005206DA9B0B7C4A@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <PN3P287MB0273982789E89005206DA9B0B7C4A@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
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

Hi Thenveer,


On 11/5/25 10:18, Thenveer Poolakkanni wrote:
> 1. Is it possible to execute or use dpdk-devbind.py on Windows to 
> verify the device binding status?

No. Please use Device Manager for now.

> 2. On Windows, the build generates .dll files (e.g., 
> rte_net_driver.dll) instead of .so files (e.g., librte_net_driver.so 
> in Linux). How can we use or execute these .dll files in the same way 
> we use .so files when running DPDK applications?
>
The application must link the needed libraries and PMDs when building. 
These files must be in PATH or in the working directory when running the 
application. Loading additional PMDs with "-d" EAL option is not yet 
implemented. If you have a custom PMD you have to build it as a part of 
DPDK and link to your application.


P. S. Questions like these belong to users@dpdk.org. Keeping in dev@ to 
avoid breaking threads.

