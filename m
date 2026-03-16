Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618ADF53D6E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 16:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0C364065C;
	Mon, 16 Mar 2026 17:06:12 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 9BCA3400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 17:06:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 14E5D38
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1773677169;
 bh=IHo/IZoUeqs2ZVfkZvOAeFPkuEK3bVo2g1K2eaqLA4k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uOG0jR+tS/xTgZ+YggCuMSJLyzK7Ew0vRytSi9Znz6SHH+SmsOcomwDa5aDd7quBx
 j2C5gG/iSqULdmIL28OMmSq8wEKYDczj112VQRJmGN6txZMzR33iv6obDWaLiTzmlE
 oDtZX8H+Lsd3MlbE3Voxs575XOccfgYgnMTj/DKk=
Received: from [192.168.1.42] (unknown [188.242.176.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 14E5D38;
 Mon, 16 Mar 2026 19:06:09 +0300 (MSK)
Message-ID: <59d5fd58-df5c-4316-b71c-2319ae3ef064@oktetlabs.ru>
Date: Mon, 16 Mar 2026 19:06:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fib: fix name of main TRIE instance memory region
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20260316130531.1671904-1-andrew.rybchenko@oktetlabs.ru>
 <20260316083039.4d2adef2@phoenix.local>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20260316083039.4d2adef2@phoenix.local>
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

On 3/16/26 6:30 PM, Stephen Hemminger wrote:
> On Mon, 16 Mar 2026 16:05:18 +0300
> Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru> wrote:
> 
>> mem_name was built, but not used when memory is allocated.
>>
>> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
>> Signed-off-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
>> ---
> 
> Ok but the name argument is only used for tracing.
> It can just be NULL

Yes, I know. IMHO the consistency is the main issue here.
It is simply wrong to prepare mem_name and do not use it.
Obviously the second option is use delete above snprintf(),
but I try to follow the author idea as I understand it.

