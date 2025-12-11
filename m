Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF13D41C35
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 13:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE6CF406FF;
	Thu, 11 Dec 2025 14:04:35 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id EB6DF40151
 for <dev@dpdk.org>; Thu, 11 Dec 2025 14:04:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765458270;
 bh=rM/2cILOAhq4OGZHHh0mPFY+5Ndio7Hhaf7M9FKTiLU=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=ltfpM4FGOoCiDZ53PZIR9penc35HlQqiEtMjDc3bI7NFUn5hX9IxAvTF5VxvLq61W
 DtRk0vcTs26SaoQ1g/Luz6ImJIVNM/birdGDJo5Dm38fLnpBRGwronQ6h7IeStcmO5
 7hCMfCklNr33eEQzPLyPEIvcFtvq0gmuIrzV7kDs=
X-QQ-mid: zesmtpsz3t1765458267t0eb8b839
X-QQ-Originating-IP: 5rzcEFYNru+vSZBX5KpZkWHOuBy9vxw6MkdTgh1r0Xo=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 11 Dec 2025 21:04:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5336944357238581088
Message-ID: <60D6DC43A0D9D2FB+55ec6052-7294-4833-8824-b7751454971e@tencent.com>
Date: Thu, 11 Dec 2025 21:04:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v3] acl: support custom memory allocator
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <20251211104625.39632870@stephen-xps.local>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <20251211104625.39632870@stephen-xps.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MsL7hwqo9bYs5Y46UmiCvzJ4PulroUq2BefKFIhB4uiBTxVJBwvCv1hw
 fGlUqiJBLdaSU+/IE0HQGGANznR9/TaLoEjDg1N8e/Km7poDVCPSw+c+79DysxPN6tkg7iO
 GWXwxFIaeNVZnXdDXuRJDSI9R+EohJX8VThv4ktGvv9zIGyKGANu5TLthPQlSySrZJ/Lij2
 Q9faeTyiJCFR5pWwYl1Bw8ToKfZ2K6/QgCZAb1jTB61pE2cKiwV5p57yTqIrrkqfAhbW47h
 vQ8czaJgfTK3QS+BqPYXX3CCiZ5XI5TwUvNovKjKN4V7QKTt94RJITLqR4k7tOIQu6KIkB4
 pDlw3wU8uQ0RMPZw/ounaqQSuKDOwfFkZqicrHXhSzqtnMUh1O9lys8Gbk2oLWJFkvADKZU
 byOzt40JnXOsali04dzFr4l56N8DO8X5NsrmQzY3+SkNhFJ0fcoIrgCawYQ8kh6lFUdqLLD
 5fycbWPYUPd6jAzQWBGItj0ZQvsLU42fJ5D5kIKumJd/H6rgoGAs0JDDF6PQ1SSfFuuRO74
 rsVamu9b73eQwNx+xcsl4uqBg4UCkurT3tCcuC0mOsScZdYsXnDbrS0sM+rxHKjxmhGCyMY
 BcRJucZAQkTWjI8mIGniQX10U/tKKRMKxnZRvkeHosBH5iYOMbpRCW46u78vdDuEhkAJfoT
 lM1Be869kHinm5bYhIa1MKMMwZlNLbzjvjQ1lRCx3sPE3KnojWLyuFzKyAg8OTkqjyCHZj0
 I5vD/wWJRrTTw3rPRHTzEvCjrck0RC0C8Da98pWmUqhzlCGF7VqLcYshi6Sco465rxUjV5T
 o3T8Tw1yXswD8Qgyd3v7T1oKcpUZHlRg4DwyUvdQ/PVgTa0kNgdenYOe/kVEVB16mDN8Ft5
 oW9bDjRUG1xxn/HltAbtD7TERPySTmXR3MUtWwwvREPTta5Wl4BRIwUAQmKiFZFnEd9w9DC
 6EI2rnvKf1AMuTgvr7KIHgUP/1+2XkKBNtvotdhL6MweA5G0cculEMWggerVtGN8j6VYOTW
 CJkCNKUw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
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

Please forgive me for repeating myself, because I am worried that I did 
not express it clearly:

ACL does not need a memory manager, because for each build it only 
allocates one block of memory, and before the next build (during reset) 
the memory is freed. The temporary memory is slightly more complicated 
since it is allocated multiple times, but it is still freed all at once. 
Therefore, for ACL, we do need to allocate memory, but we do not need a 
memory manager.

However, the memory used in the current build process is indeed 
dynamically allocated, which will cause fragmentation in the 
corresponding memory manager when multiple builds are performed.

Based on the above situation, I think the most reasonable approach is to 
bind a pre-allocated static memory block to the ACL context.

On 12/11/2025 9:46 AM, Stephen Hemminger wrote:
> On Tue, 25 Nov 2025 12:14:46 +0000
> "mannywang(王永峰)" <mannywang@tencent.com> wrote:
> 
>> Reduce memory fragmentation caused by dynamic memory allocations
>> by allowing users to provide custom memory allocator.
>>
>> Add new members to struct rte_acl_config to allow passing custom
>> allocator callbacks to rte_acl_build:
>>
>> - running_alloc: allocator callback for run-time internal memory
>> - running_free: free callback for run-time internal memory
>> - running_ctx: user-defined context passed to running_alloc/free
>>
>> - temp_alloc: allocator callback for temporary memory during ACL build
>> - temp_reset: reset callback for temporary allocator
>> - temp_ctx: user-defined context passed to temp_alloc/reset
>>
>> These callbacks allow users to provide their own memory pools or
>> allocators for both persistent runtime structures and temporary
>> build-time data.
>>
>> A typical approach is to pre-allocate a static memory region
>> for rte_acl_ctx, and to provide a global temporary memory manager
>> that supports multipleallocations and a single reset during ACL build.
>>
>> Since tb_mem_pool handles allocation failures using siglongjmp,
>> temp_alloc follows the same approach for failure handling.
>>
>> Signed-off-by: YongFeng Wang <mannywang@tencent.com>
>> ---
> 
> Rather than custom allocators, I did a couple of quick AI queries about
> alternatives. It looks like there are some big global gains possible
> here:
> 
> Summary of Recommendations
> Improvement	Benefit	Complexity	Priority
> ACL Object Pooling	Eliminates ACL-specific fragmentation	Medium	High
> Size-Class Segregation	Reduces general fragmentation	High	High
> Slab Allocator for Build	Better hugepage utilization	Medium	Medium
> Deferred Coalescing	Reduces fragmentation from churn	Medium	Medium
> Thread-Local Caching	Reduces contention, improves locality	Medium	Medium
> 
> Also adding some malloc_trim() would help.
> 
> https://claude.ai/share/75fcf73c-17e3-4f41-8590-f2ab640f9512
> 
> 


