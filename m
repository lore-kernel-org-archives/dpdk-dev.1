Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01756E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 06:56:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0584D402A2;
	Tue, 17 Feb 2026 07:56:54 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 59F694029D;
 Tue, 17 Feb 2026 07:56:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru D7BF138
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1771311411;
 bh=c+DaE7BBkIW4bs17C/M4msrb1+B0sfmB1QeZz8RWEIg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TkSgezA8sLBEO4L3gBul5PlsMUhaatH5CCMeo6kzq7LzrESpJLhrQygBYEx6Y2Awp
 0M4cfTCQ5B3z57Gk/8YA8tG/2pqggMMRq+EqKI2cjPfKOQ8ax+KnRgnhH1zd9dj+BL
 iYEWZPs9Z9Qdz5Pr11r1e/UHV9Fon44jmPFiMic4=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id D7BF138;
 Tue, 17 Feb 2026 09:56:51 +0300 (MSK)
Message-ID: <16223afb-38a9-4f7f-87f2-3619b518ad05@oktetlabs.ru>
Date: Tue, 17 Feb 2026 09:56:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethdev: fix mbuf fast release requirements description
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, techboard@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, stable@dpdk.org
References: <20260205092848.36435-1-mb@smartsharesystems.com>
 <20260205094109.07193182@phoenix.local>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260205094109.07193182@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/5/26 8:41 PM, Stephen Hemminger wrote:
> On Thu,  5 Feb 2026 09:28:48 +0000
> Morten Brørup <mb@smartsharesystems.com> wrote:
> 
>> It was unclear if mbuf fast release could support segmented packets, or if
>> mbuf fast release required non-segmented packets.
>> This has now been investigated in detail, and it was concluded that
>> segmented packets can be supported with mbuf fast release still achieving
>> the enhanced performance.
>> So the description of the mbuf fast release Tx offload flag was fixed.
>>
>> Furthermore, the general descriptions of the Rx and Tx offloads were
>> improved, to reflect that they are not only for device capability
>> reporting, but also for device and queue configuration purposes.
>>
>> NB: If a driver does not support segmented packets with mbuf fast release,
>> it can check the multi segment send flag when selecting transmit function.
>>
>> Fixes: 55624173bacb ("mbuf: add raw free and alloc bulk functions")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
>> ---
>> The other description improvements were taken from patch-155635 ("[v3,2/3]
>> ethdev: Improve descriptions of RX and TX offloads").
>> ---
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> I wonder if it would be good to point the AI documentation review
> tool at the docbook comments in ethdev. There are some grammar
> and clarity errors there.

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

