Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0DFC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 19:05:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84AB240283;
	Tue, 22 Jul 2025 21:05:15 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id A6B164003C;
 Tue, 22 Jul 2025 21:05:14 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 88987E0710;
 Tue, 22 Jul 2025 23:05:13 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 88987E0710
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753211114;
 bh=+iVHYhxv2PdGMjffXZDxqcDyGo83/s++Xj5OXKKbtpU=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=kJj82BlgQFOsXx9XxMiSaIXA3hB7L/WVWQJTNwipZO+bCxKKbb1eN0VkzB5aVDxjH
 S7bq0Q6IfGQJQ+SEUafBpZdDmQ9l9N1UtNo5ae5JKKhcQVXzwJ22Z2lyuJdEAhBgTP
 agy4RsaLWaiaYWSyup6TYd+QAro8oOnnjaR+SaeQaJ+Sj116MK6ihZRH/o4OtrYIVW
 HG2SsOA8b4OF5X/fGyck5jFfEiVARXsFJ7sAtJAF690mmfix/Z2Ky9Oj/frpu/KCeG
 icHmxxjhXEKUi2GasGUYTkapxE/b01TM2FiltkxYNLFgmGI1F4rKDl/mM2I0bvcX4E
 8oe97k+SYZf9g==
Date: Tue, 22 Jul 2025 23:05:06 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
In-Reply-To: <20250722112154.78349c82@hermes.local>
Message-ID: <55209b79-6845-5c25-bb8c-e2ecb3f0e290@arknetworks.am>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
 <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
 <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x4+3QE+EOCdUcX8go27Z0tqrb4Br1MADQEiu=q3GgRpPA@mail.gmail.com>
 <20250722103824.7c9db0a0@hermes.local>
 <CA++2-x69b=_+7wYaK57fv8j0F4VOsSVJ-S-yyi76Lgoy=E-dpg@mail.gmail.com>
 <20250722112154.78349c82@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

There is a difference between control path and data path. Always has been. Yes,
on data path, DPDK has historically sought better performance, but on the slow
path, checks have typically been implemented, even in the flow API, with the
only exception being "asynchronous flow" APIs, which are meant to be fast-path.

Yes, the idea to have a "secondary process reference counter" in 'rte_device'
to be either guarded with its own lock or accessed atomically by 'rte_dev_probe'
and 'rte_dev_remove' (to increment and decrement/check respectively) as well as
by 'rte_eth_dev_close' and 'rte_eth_dev_reset' (to decrement/check) may not be
a hill to die on, to be honest, and might be wrong, so I have no strong opinion.

What scares me most in this idea is that, one may still end up with certain
entry points overlooked, rendering the whole effort worthless.

Thank you.

On Tue, 22 Jul 2025, Stephen Hemminger wrote:

> On Tue, 22 Jul 2025 22:53:08 +0500
> Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>
>> Right, but performance and reliability are both important. While DPDK
>> rightly prioritizes performance, some level of reliability should still be
>> ensured, especially to catch known issues that could lead to instability.
>>
>> On Tue, Jul 22, 2025, 22:38 Stephen Hemminger <stephen@networkplumber.org>
>> wrote:
>>
>>> On Tue, 22 Jul 2025 22:04:32 +0500
>>> Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>>>
>>>> Agree, but I think it's also a good practice to guard against known cases
>>>> that are prone to crashes.
>>>
>>>
>>> Right but DPDK chooses performance over API safety.
>>> For example rx/tx burst doesn't check args.
>>>
>>> The point is that as a library, if application is doing something wrong
>>> returning error doesn't always help.
>>>
>
> The problem is that all those values dev->data and private are shared
> between processes without any locking. If the API's are going to MP safe
> then they would require locking. The DPDK has made an explicit decision
> to not use locking in ethdev control or data path.
>
> You can get away with checking for dev->data being NULL on x86 where
> there is data consistency. But on weakly ordered platforms that is not going
> to work.
>
