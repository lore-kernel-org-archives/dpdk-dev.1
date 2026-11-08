Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F4606A321
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=ionWXQpk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8005040265;
	Sun,  8 Nov 2026 19:51:39 +0100 (CET)
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 7FA1240265
 for <dev@dpdk.org>; Sun,  8 Nov 2026 19:51:38 +0100 (CET)
Received: from [192.168.0.40] (unknown [37.228.226.247])
 by smtp04-ext3.udag.de (Postfix) with ESMTPA id 5AA64E0432;
 Sun,  8 Nov 2026 19:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1794163897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ao/xXcN+UyGivxzFimO1x7tdU5O6KfsHwSyyuMq08d4=;
 b=ionWXQpkVgNNMBLm0hjy31KHr8LMxm733WP9f+2a/0VtVGEwW2A6Mt08yzC1X21sQv1MX8
 7XwWSI+MxdCsf+MM2vGquLj9oAhglUvL8Ioqq/12OfRZinUwq7PiAdw/zarOY7/NwgJCt+
 hC/Q0NfhEJ6VQ0rT4YhgyRcX/AMdNC4ALbF2AYYwBmsfbILsMNpfbtWVCGs1Hk2qC/41Uz
 elTva8B5f1gx0Ed7WHzz7pBRIxI6DmhP+DVUjd+p92+JpOcJuk2Fxowyaz/pm7w6Mi2LBl
 8UsxgJPsOF1DFmOO4mTmKbaJMlFfywcs2Y26+hRKAvDp7QKU8UPv2LZau0JWkQ==
Authentication-Results: smtp04-ext3.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
Message-ID: <dab30cb4-025c-4a75-892d-3519dcc67053@dressler.pro>
Date: Sun, 8 Nov 2026 18:51:35 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/af_packet: fix build with old kernel headers
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 ktraynor@redhat.com, Bing Zhao <bingz@nvidia.com>
References: <20261106142756.241131-1-bingz@nvidia.com>
 <dd205eb8-4741-452e-8490-16d157e1bb1e@dressler.pro>
 <0374e022-3c41-4a6b-9464-7f879ef02ce1@dressler.pro>
 <20261108082211.1f190f4b@phoenix.local>
Content-Language: en-US
From: Frank Dressler <frank@dressler.pro>
In-Reply-To: <20261108082211.1f190f4b@phoenix.local>
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_PRO_TLD,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 16:22, Stephen Hemminger wrote:
> On Sat, 7 Nov 2026 11:11:54 +0000
> Frank Dressler <frank@dressler.pro> wrote:
> 
>> On 11/6/26 14:27, Bing Zhao wrote:
>>
>>   > The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
>>   > but it was only added to the uapi headers in Linux 4.20. The build
>>   > fails on distributions shipping older kernel headers, like RHEL 8
>>   > (kernel-headers-4.18.0-193.el8, gcc 8.5.0):
>>
>> On 11/6/26 16:06, Frank Dressler wrote:
>>   > If RHEL 8 uses Linux 4.18, [...]
>>   > If DPDK needs to stay compatible with RHEL 8, [...]
>>
>> Short version: RHEL itself does't seem to ship any DPDK that is too
>> new for its kernel. The RHEL 8 compatibility requirement may instead
>> come from NVIDIA's DOCA, which ships DPDK 26.03 on RHEL 8. If so, the
>> question is whether upstream DPDK should support that combination, or
>> whether it is better handled on the DOCA side. Details below.
>>
>> Bing Zhao, is that the use case behind the patch?
>>
>> Details:
>> I read too much into Bing Zhao's statement that the new code does not
>> build with the RHEL 8 kernel. That statement is true.I incorrectly
>> assumed RHEL itself ships a DPDK version that is too new for its
>> kernel, which is not the case.
> 
> The important parts that were missed here.
>   - flag should not be accepted if underlying kernel does not support it.
>   - failure should be at compile time not runtime.
> 
> Either remove this part:
>
...>
> Or add a bunch of #ifdef like this.
> 

But should these changes go into DPDK or NVIDIA's DOCA?

DPDK's current code requires no patch since the code works with the 
kernel versions required by DPDK, i.e. Linux >= v5.4.

NVIDIA's DOCA, however, ships current DPDK to RHEL 8 which comes with 
kernel v4.18 that is unsupported since DPDK v24.07. The latest release 
is DOCA 3.5.0 which ships DPDK v26.03 to RHEL 8 which is not supported 
by DPDK.

I think that NVIDIA should add a patch to DOCA's DPDK version or drop 
support for RHEL 8 instead of requiring DPDK to be compatible with Linux 
v4.18.
  Because if DPDK was required to support all the distributions NVIDIA 
ships DOCA for, developers would need to check what kernels all those 
distributions ship with to find the oldest one. DPDK's kernel 
requirement would then need to be changed from "Kernel version >= 5.4" 
to "Kernel version min(5.4, whatever NVIDIA needs) >=".
