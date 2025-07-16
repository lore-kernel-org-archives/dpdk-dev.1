Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D4C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 06:00:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82E19402D4;
	Wed, 16 Jul 2025 08:00:23 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 8804B4013F;
 Wed, 16 Jul 2025 08:00:22 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id DF4781A725;
 Wed, 16 Jul 2025 08:00:21 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id B26F11A676; Wed, 16 Jul 2025 08:00:21 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 8C82B1A78E;
 Wed, 16 Jul 2025 08:00:19 +0200 (CEST)
Message-ID: <c28e9b5a-1edf-43a5-b75d-dcd5f39ec643@lysator.liu.se>
Date: Wed, 16 Jul 2025 08:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: stable@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 John McNamara <john.mcnamara@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-9-david.marchand@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20250623135242.461965-9-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 2025-06-23 15:52, David Marchand wrote:
> Caught by UBSan:
> 
> ../lib/hash/rte_thash.c:421:8: runtime error: load of misaligned address
> 	0x0001816c2da3 for type 'uint32_t' (aka 'unsigned int'),
> 	which requires 4 byte alignment
> 
> Fixes: 28ebff11c2dc ("hash: add predictable RSS")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

> ---
>   lib/hash/rte_thash.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
> index 6c662bf14f..6d4dbea6d7 100644
> --- a/lib/hash/rte_thash.c
> +++ b/lib/hash/rte_thash.c
> @@ -415,10 +415,10 @@ generate_subkey(struct rte_thash_ctx *ctx, struct thash_lfsr *lfsr,
>   static inline uint32_t
>   get_subvalue(struct rte_thash_ctx *ctx, uint32_t offset)
>   {
> -	uint32_t *tmp, val;
> +	uint32_t tmp, val;
>   
> -	tmp = (uint32_t *)(&ctx->hash_key[offset >> 3]);
> -	val = rte_be_to_cpu_32(*tmp);
> +	memcpy(&tmp, &ctx->hash_key[offset >> 3], sizeof(tmp));
> +	val = rte_be_to_cpu_32(tmp);
>   	val >>= (TOEPLITZ_HASH_LEN - ((offset & (CHAR_BIT - 1)) +
>   		ctx->reta_sz_log));
>   

