Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57217CE9D74
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:08:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 836504069F;
	Tue,  6 Jan 2026 17:08:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 30B8E402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:08:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767715715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Du+qQxvSregRJa1PXWY3C6IH5P0C2pRUdXJAUEVx7bM=;
 b=RDP6WkJ+dmqnaGgQWWnh9KNBk0wZHYxfus0+u/6ZzCV5fD3iUEF2t8v19hv2bD6y7kepSR
 /b0nzNBcDyy7DtDWzOtxPP4wq330Y+BN0cUxtkGtYvBN7ArPg560AawfHgposrYde2epVc
 x302uV9dbsjiDzDYk1IqQYsAI+0uz/o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-IWQH6SgVM36A9sDCbFcJRA-1; Tue,
 06 Jan 2026 11:08:31 -0500
X-MC-Unique: IWQH6SgVM36A9sDCbFcJRA-1
X-Mimecast-MFC-AGG-ID: IWQH6SgVM36A9sDCbFcJRA_1767715710
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CD5D195DE61; Tue,  6 Jan 2026 16:08:30 +0000 (UTC)
Received: from [10.45.242.22] (unknown [10.45.242.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD43A19560AB; Tue,  6 Jan 2026 16:08:28 +0000 (UTC)
Message-ID: <7de5dd70-45c2-4a76-954d-19beef994e5a@redhat.com>
Date: Tue, 6 Jan 2026 17:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] vhost_user: header defines for add/rem mem region
To: Pravin M Bathija <pravin.bathija@dell.com>, dev@dpdk.org
Cc: pravin.m.bathija.dev@gmail.com
References: <20251113124425.2913881-1-pravin.bathija@dell.com>
 <20251113124425.2913881-3-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20251113124425.2913881-3-pravin.bathija@dell.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FHjzA0xkF-PcLRNs2luqOmQ9NB-pL4GDfyUZBkqmFuI_1767715710
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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



On 11/13/25 1:44 PM, Pravin M Bathija wrote:
> The changes in this file cover the enum message requests for
> supporting add/remove memory regions. The front-end vhost-user
> client sends messages like get max memory slots, add memory region
> and remove memory region which are covered in these changes which
> are on the vhost-user back-end. The changes also include data structure
> definition of memory region to be added/removed. The data structure
> VhostUserMsg has been changed to include the memory region.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>   lib/vhost/vhost_user.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
> index ef486545ba..5a0e747b58 100644
> --- a/lib/vhost/vhost_user.h
> +++ b/lib/vhost/vhost_user.h
> @@ -32,6 +32,7 @@
>   					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
>   					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
>   					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
> +					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \

It should be enabled only once the feature is actually implemented,
otherwise bisection may fail.

>   					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
>   
>   typedef enum VhostUserRequest {
> @@ -67,6 +68,9 @@ typedef enum VhostUserRequest {
>   	VHOST_USER_POSTCOPY_END = 30,
>   	VHOST_USER_GET_INFLIGHT_FD = 31,
>   	VHOST_USER_SET_INFLIGHT_FD = 32,
> +	VHOST_USER_GET_MAX_MEM_SLOTS = 36,
> +	VHOST_USER_ADD_MEM_REG = 37,
> +	VHOST_USER_REM_MEM_REG = 38,
>   	VHOST_USER_SET_STATUS = 39,
>   	VHOST_USER_GET_STATUS = 40,
>   } VhostUserRequest;
> @@ -91,6 +95,11 @@ typedef struct VhostUserMemory {
>   	VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>   } VhostUserMemory;
>   
> +typedef struct VhostUserSingleMemReg {
> +	uint64_t padding;
> +	VhostUserMemoryRegion region;
> +} VhostUserSingleMemReg;
> +
>   typedef struct VhostUserLog {
>   	uint64_t mmap_size;
>   	uint64_t mmap_offset;
> @@ -186,6 +195,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
>   		struct vhost_vring_state state;
>   		struct vhost_vring_addr addr;
>   		VhostUserMemory memory;
> +		VhostUserSingleMemReg memory_single;
>   		VhostUserLog    log;
>   		struct vhost_iotlb_msg iotlb;
>   		VhostUserCryptoSessionParam crypto_session;

