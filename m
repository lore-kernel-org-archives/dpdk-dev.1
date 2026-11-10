Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B12606A338
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=doYat61c
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4733F40296;
	Tue, 10 Nov 2026 15:23:15 +0100 (CET)
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 887C840281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 15:23:13 +0100 (CET)
Received: from [192.168.0.40] (unknown [37.228.226.247])
 by smtp01-ext2.udag.de (Postfix) with ESMTPA id AFBE7E1065;
 Tue, 10 Nov 2026 15:23:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1794320592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZZnxww4lxL4zrvORTYRo6h5ZtMcpxz8yU3gAS7LjIQ=;
 b=doYat61cvsD6Rgt24bisvULw4nBNMSBXbKOIjY1dR525LnJ9XIw+DINF27EulDHJb0o1LH
 ROX4SXNfChO6AQcn1NhglTkuqqjQ1SaKwY0Ni4ea5VZQnbp6HbPGPVk7UmyUWnapkfmisS
 GsHD8z1rhYqOWQPD1aw27Ndzosd0yP0/6IycGJvMymHC29gg+ONz9pn1Q+V+gt9LIiqfTv
 7ByZzDGYEaoepy5kMDbR5LsTDpxVgfYPoIZKnQYhzsYD/09d9GKpE6BK+ulTNYoYpQMs5U
 rN2n/U0qM2QHI7kgV5PEGim+yDlN60u/rL5WdQ+NWuTCZV/I92cVE+Y9GdKp1Q==
Authentication-Results: smtp01-ext2.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
Message-ID: <1c32bca6-b310-4ac8-a9ec-3312a7b8f364@dressler.pro>
Date: Tue, 10 Nov 2026 14:23:11 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/af_packet: fix build with old kernel headers
To: Thomas Monjalon <thomas@monjalon.net>, Bing Zhao <bingz@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Kevin Traynor <ktraynor@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
References: <20261106142756.241131-1-bingz@nvidia.com>
 <O1P4UruZSlqFOdl0F9QGXA@monjalon.net>
 <be84046c-8071-4fee-aea0-234b772cc91a@dressler.pro>
 <zmh4QzPKQvWlZHerQoYLhg@monjalon.net>
Content-Language: en-US
From: Frank Dressler <frank@dressler.pro>
In-Reply-To: <zmh4QzPKQvWlZHerQoYLhg@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,PDS_PRO_TLD,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 13:56, Thomas Monjalon wrote:
> 10/11/2026 13:52, Frank Dressler:
>> On 11/10/26 10:39, Thomas Monjalon wrote:
>>> 09/11/2026 18:47, Stephen Hemminger:
>>>> On Mon, 9 Nov 2026 17:47:30 +0200
>>>> Bing Zhao <bingz@nvidia.com> wrote:
>>>>
>>>>> The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
>>>>> but it was only added to the uapi headers in Linux 4.20. The build
>>>>> fails on distributions shipping older kernel headers, like RHEL 8
>>>>> (kernel-headers 4.18.0):
>>>>>
>>>>>     rte_eth_af_packet.c:1057:41: error: 'PACKET_IGNORE_OUTGOING'
>>>>>       undeclared (first use in this function)
>>>>>
>>>>> DPDK requires Linux 5.4, so the driver does not need to support older
>>>>> kernels. Check for the symbol at configure time and skip the driver
>>>>> when the headers lack it, instead of failing the whole build.
>>>>>
>>>>> Fixes: 3db7aa7868b2 ("net/af_packet: use kernel to filter single-queue Rx")
>>>>>
>>>>> Signed-off-by: Bing Zhao <bingz@nvidia.com>
>>>>> ---
>>>>
>>>> No. DPDK should just fail build on older kernels.
>>>> Since current DPDK is not tested with those releases, anyone doing that is
>>>> working outside the tested environment and has to fix it themselves.
>>>
>>> We used to support some old RHEL versions.
>>> Remind that the RHEL kernel is full of backports,
>>> it is not exactly the same as an really old kernel.
>>> I think this solution disabling a driver is acceptable.
>>
>> But does RHEL itself actually have a problem? I could not find an
>> incompatible DPDK being shipped by them. DOCA ships unsupported DPDK.
>>
>> If it is RHEL, Redhat could add `-Ddisable_drivers=net/af_packet`. If it
>> is DOCA, NVIDIA could just add `-Ddisable_drivers=net/af_packet`. DOCA
>> already only ships a limited set of PMDs in their bundled DPDK.
> 
> I don't know why you insist on DOCA, it is not an upstream concern,
> and was not mentioned in this thread except by you.
> 

I was just wondering about the use case behind the change, because I did 
not find it in RHEL since they all seemed to ship with supported DPDK 
versions. So I thought it could have been DOCA.

> 
>> If RHEL 8 must be supported, the documented requirements would need to
>> change then to say that features of Kernel 5.4 may be used but the code
>> must still build without error on RHEL 8, or something like that.
> 
> Yes that's something we had in the past.
> This has been removed last year:
> 
> "Compatibility for recent distribution kernels will be kept, notably RHEL/CentOS 7."
> 

Thank you, I did not know that.

