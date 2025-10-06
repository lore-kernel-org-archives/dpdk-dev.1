Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3574CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 09:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACF67402DD;
	Mon,  6 Oct 2025 11:37:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 74F9B402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 11:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759743465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4istMV6KOpZDxzQKOjjZdnRWx5we7+TybPMDzzFjt+Q=;
 b=GwEob/5swl0byPgU8DqUretkPnSnpywc869S1Jz/NbSzv5mbs+VHX8K3rqgwR0swEIzV9X
 w7qMFIny6JtI0JAzyY6pfiwjowYkWTeJlFMl7crFQ5j1yXV43OO9pv7fYfI4Ld/pfyor12
 6PEkYZbzuLOyK05rgBpwnd47NpVHqy0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-a8hTSjH3NiKHEXdVv9PXKw-1; Mon,
 06 Oct 2025 05:37:39 -0400
X-MC-Unique: a8hTSjH3NiKHEXdVv9PXKw-1
X-Mimecast-MFC-AGG-ID: a8hTSjH3NiKHEXdVv9PXKw_1759743458
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E68F619560B2; Mon,  6 Oct 2025 09:37:37 +0000 (UTC)
Received: from [10.44.22.30] (unknown [10.44.22.30])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 901C31956056; Mon,  6 Oct 2025 09:37:34 +0000 (UTC)
Message-ID: <467f9bea-3649-44bd-ac9c-29f9d969a5b7@redhat.com>
Date: Mon, 6 Oct 2025 11:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] vhost: fix a double fetch when dequeue offloading
To: "Wangyunjian(wangyunjian,TongTu)" <wangyunjian@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "chenbox@nvidia.com" <chenbox@nvidia.com>, 
 "Lilijun (Jerry)" <jerry.lilijun@huawei.com>,
 "xiawei (H)" <xiawei40@huawei.com>, wangzengyuan <wangzengyuan@huawei.com>,
 "stable@dpdk.org" <stable@dpdk.org>
References: <91dc12662805a3867413940f856ba9454b91c579.1734588243.git.wangyunjian@huawei.com>
 <09058cfb25d7583f67d74f09cd36673f1b10f5ec.1734661755.git.wangyunjian@huawei.com>
 <20241220091052.68bb13ee@hermes.local>
 <dd21d206b0384a2db02d33d1cee860f1@huawei.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <dd21d206b0384a2db02d33d1cee860f1@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IoXhvhdYdwcQePLXbobWm58TSo_qzfVYP26tu7_LxP0_1759743458
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

Hi Yunjian,

On 2/13/25 1:22 PM, Wangyunjian(wangyunjian,TongTu) wrote:
> 
>> -----Original Message-----
>> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
>> Sent: Saturday, December 21, 2024 1:11 AM
>> To: Wangyunjian(wangyunjian,TongTu) <wangyunjian@huawei.com>
>> Cc: dev@dpdk.org; maxime.coquelin@redhat.com; chenbox@nvidia.com;
>> Lilijun (Jerry) <jerry.lilijun@huawei.com>; xiawei (H) <xiawei40@huawei.com>;
>> wangzengyuan <wangzengyuan@huawei.com>; stable@dpdk.org
>> Subject: Re: [PATCH v2 1/1] vhost: fix a double fetch when dequeue offloading
>>
>> On Fri, 20 Dec 2024 11:49:55 +0800
>> Yunjian Wang <wangyunjian@huawei.com> wrote:
>>
>>> The hdr->csum_start does two successive reads from user space to read a
>>> variable length data structure. The result overflow if the data structure
>>> changes between the two reads.
>>>
>>> To fix this, we can prevent double fetch issue by copying virtio_hdr to
>>> the temporary variable.
>>>
>>> Fixes: 4dc4e33ffa10 ("net/virtio: fix Rx checksum calculation")
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
>>
>>
>> How about something like the following *untested*
> 
> I agree. Can you fix it?

As you were the initial poster, I suggest you implement it and test it
by yourself.

It is not too late for -rc2.

Thanks,
Maxime

> Thanks,
> Yunjian
> 
>>
>> diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
>> index 69901ab3b5..c65cb639b2 100644
>> --- a/lib/vhost/virtio_net.c
>> +++ b/lib/vhost/virtio_net.c
>> @@ -2861,25 +2861,28 @@ vhost_dequeue_offload(struct virtio_net *dev,
>> struct virtio_net_hdr *hdr,
>>   	}
>>   }
>>
>> -static __rte_noinline void
>> +static inline int
>>   copy_vnet_hdr_from_desc(struct virtio_net_hdr *hdr,
>> -		struct buf_vector *buf_vec)
>> +			const struct buf_vector *buf_vec,
>> +			uint16_t nr_vec)
>>   {
>> -	uint64_t len;
>> -	uint64_t remain = sizeof(struct virtio_net_hdr);
>> -	uint64_t src;
>> -	uint64_t dst = (uint64_t)(uintptr_t)hdr;
>> +	size_t remain = sizeof(struct virtio_net_hdr);
>> +	uint8_t *dst = (uint8_t *)hdr;
>>
>> -	while (remain) {
>> -		len = RTE_MIN(remain, buf_vec->buf_len);
>> -		src = buf_vec->buf_addr;
>> -		rte_memcpy((void *)(uintptr_t)dst,
>> -				(void *)(uintptr_t)src, len);
>> +	while (remain > 0) {
>> +		size_t len = RTE_MIN(remain, buf_vec->buf_len);
>> +		const void *src = (const void *)(uintptr_t)buf_vec->buf_addr;
>>
>> +		if (unlikely(nr_vec == 0))
>> +			return -1;
>> +
>> +		memcpy(dst, src, len);
>>   		remain -= len;
>>   		dst += len;
>>   		buf_vec++;
>> +		--nr_vec;
>>   	}
>> +	return 0;
>>   }
>>
>>   static __rte_always_inline int
>> @@ -2908,16 +2911,12 @@ desc_to_mbuf(struct virtio_net *dev, struct
>> vhost_virtqueue *vq,
>>   	 */
>>
>>   	if (virtio_net_with_host_offload(dev)) {
>> -		if (unlikely(buf_vec[0].buf_len < sizeof(struct virtio_net_hdr))) {
>> -			/*
>> -			 * No luck, the virtio-net header doesn't fit
>> -			 * in a contiguous virtual area.
>> -			 */
>> -			copy_vnet_hdr_from_desc(&tmp_hdr, buf_vec);
>> -			hdr = &tmp_hdr;
>> -		} else {
>> -			hdr = (struct virtio_net_hdr *)((uintptr_t)buf_vec[0].buf_addr);
>> -		}
>> +		if (unlikely(copy_vnet_hdr_from_desc(&tmp_hdr, buf_vec, nr_vec) !=
>> 0))
>> +		    return -1;
>> +
>> +		/* ensure that compiler does not delay copy */
>> +		rte_compiler_barrier();
>> +		hdr = &tmp_hdr;
>>   	}
>>
>>   	for (vec_idx = 0; vec_idx < nr_vec; vec_idx++) {
>> @@ -3363,7 +3362,6 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
>>   {
>>   	uint16_t avail_idx = vq->last_avail_idx;
>>   	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>> -	struct virtio_net_hdr *hdr;
>>   	uintptr_t desc_addrs[PACKED_BATCH_SIZE];
>>   	uint16_t ids[PACKED_BATCH_SIZE];
>>   	uint16_t i;
>> @@ -3382,8 +3380,12 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
>>
>>   	if (virtio_net_with_host_offload(dev)) {
>>   		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
>> -			hdr = (struct virtio_net_hdr *)(desc_addrs[i]);
>> -			vhost_dequeue_offload(dev, hdr, pkts[i], legacy_ol_flags);
>> +			struct virtio_net_hdr hdr;
>> +
>> +			memcpy(&hdr, (void *)desc_addrs[i], sizeof(struct
>> virtio_net_hdr));
>> +			rte_compiler_barrier();
>> +
>> +			vhost_dequeue_offload(dev, &hdr, pkts[i], legacy_ol_flags);
>>   		}
>>   	}
>>
> 

