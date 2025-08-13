Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA3CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 02:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 178CB4025D;
	Wed, 13 Aug 2025 04:05:48 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 2AA9A400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 04:05:46 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c1sBf510ZztT3Q;
 Wed, 13 Aug 2025 10:04:42 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id EA015140411;
 Wed, 13 Aug 2025 10:05:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 10:05:42 +0800
Message-ID: <b187ed2e-ad02-4894-a690-574d40015191@huawei.com>
Date: Wed, 13 Aug 2025 10:05:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/22] ipc: fix mp message alignment for malloc
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Tyler Retzlaff <roretzla@linux.microsoft.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-13-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250723133157.159825-13-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 7/23/2025 9:31 PM, David Marchand wrote:
> Content (param[]) of received multiprocess messages are aligned with
> a 4 bytes constraint.
> 
> Before patch:
> struct mp_msg_internal {
>  int type;                                                     /*   0     4 */
>  struct rte_mp_msg {
>   char name[64];                                               /*   4    64 */
>   /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
>   int len_param;                                               /*  68     4 */
>   int num_fds;                                                 /*  72     4 */
>   /* typedef uint8_t -> __uint8_t */ unsigned char param[256]; /*  76   256 */
>   /* --- cacheline 5 boundary (320 bytes) was 12 bytes ago --- */
>   int fds[253];                                                /* 332  1012 */
>  } msg;                                                        /*   4  1340 */
> 
>  /* size: 1344, cachelines: 21, members: 2 */
> };
> 
> This results in many unaligned accesses for multiprocess malloc requests.
> 
> Examples:
> ../lib/eal/common/malloc_mp.c:308:32: runtime error:
> 	member access within misaligned address 0x7f7b35df4684 for type
> 	'const struct malloc_mp_req', which requires 8 byte alignment
> 
> ../lib/eal/common/malloc_mp.c:158:9: runtime error:
> 	member access within misaligned address 0x7f36a535bb5c for type
> 	'const struct malloc_mp_req', which requires 8 byte alignment
> 
> ../lib/eal/common/malloc_mp.c:171:8: runtime error:
> 	member access within misaligned address 0x7f4ba65f296c for type
> 	'struct malloc_mp_req', which requires 8 byte alignment
> 
> Align param[] to 64 bits to avoid unaligned accesses on structures
> passed through this array in mp messages.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

