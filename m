Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF9C021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 09:19:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7AD40A67;
	Thu, 27 Feb 2025 10:19:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9D14340290
 for <dev@dpdk.org>; Thu, 27 Feb 2025 10:19:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740647966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VJSo7kTOzQouG010r5kpWuxa716EsigIJ6PN2W+AEWU=;
 b=ExtV5ZMqjBwcvJMZp+lkpK7SDiiC87eqsPG8/8sNyjaVb1xUUMVNYvcCeHsg9S7qyY2ZtG
 qAR/3IydlIzKib9Dtw2zOwwhW5cO+yoq7B3tHxYiTDSCbPFzieeJH8s39hiuw4mIE05Nj/
 Nzq0XVpxvdHnHzk8x19QHwgg/S/r4Uk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-B4UrgWmDMkiaTfktXTxCkw-1; Thu,
 27 Feb 2025 04:19:18 -0500
X-MC-Unique: B4UrgWmDMkiaTfktXTxCkw-1
X-Mimecast-MFC-AGG-ID: B4UrgWmDMkiaTfktXTxCkw_1740647957
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 725E61800874; Thu, 27 Feb 2025 09:19:17 +0000 (UTC)
Received: from [10.45.242.8] (unknown [10.45.242.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FB611944F2C; Thu, 27 Feb 2025 09:19:14 +0000 (UTC)
Message-ID: <de649087-3686-4372-a1ac-d9a05961b6c0@redhat.com>
Date: Thu, 27 Feb 2025 10:19:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 1/5] vhost: skip crypto op fetch before vring init
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, dev@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Jay Zhou <jianjay.zhou@huawei.com>
Cc: anoobj@marvell.com, Akhil Goyal <gakhil@marvell.com>, stable@dpdk.org
References: <cover.1740594750.git.gmuthukrishn@marvell.com>
 <0784f44b63f6161ac8716644acfea979704eca39.1740594750.git.gmuthukrishn@marvell.com>
 <81fac570-cdd7-45f7-b209-ce999d5c3d0e@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <81fac570-cdd7-45f7-b209-ce999d5c3d0e@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HVDWWEYGR_cCaP_oGGyT97f26MnBbeRRQsF8Nv-Yt4k_1740647957
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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



On 2/27/25 10:15 AM, Maxime Coquelin wrote:
> Hi Gowri,
> 
> Thanks for the change, but I think there is an issue with the locking,
> more below:
> 
> On 2/26/25 7:43 PM, Gowrishankar Muthukrishnan wrote:
>> Until virtio avail ring is initialized (by VHOST_USER_SET_VRING_ADDR),
>> worker thread should not try to fetch crypto op, which would lead to
>> memory fault.
>>
>> Fixes: 939066d96563 ("vhost/crypto: add public function implementation")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
>> Acked-by: Akhil Goyal <gakhil@marvell.com>
>> ---
>> v6:
>>   - added lock checks.
>> ---
>>   lib/vhost/vhost_crypto.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
>> index 3dc41a3bd5..d3d13eff07 100644
>> --- a/lib/vhost/vhost_crypto.c
>> +++ b/lib/vhost/vhost_crypto.c
>> @@ -8,6 +8,7 @@
>>   #include <rte_mbuf.h>
>>   #include <rte_cryptodev.h>
>> +#include "iotlb.h"
>>   #include "rte_vhost_crypto.h"
>>   #include "vhost.h"
>>   #include "vhost_user.h"
>> @@ -1580,7 +1581,26 @@ rte_vhost_crypto_fetch_requests(int vid, 
>> uint32_t qid,
>>       vq = dev->virtqueue[qid];
>> +    if (unlikely(vq == NULL)) {
>> +        VC_LOG_ERR("Invalid virtqueue %u", qid);
>> +        return 0;
>> +    }
>> +
>> +    if (unlikely(rte_rwlock_read_trylock(&vq->access_lock) != 0))
>> +        return 0;
>> +
>> +    vhost_user_iotlb_rd_lock(vq);
>> +    if (unlikely(!vq->access_ok)) {
>> +        VC_LOG_DBG("Virtqueue %u vrings not yet initialized", qid);
>> +        vhost_user_iotlb_rd_unlock(vq);
>> +        rte_rwlock_read_unlock(&vq->access_lock);
>> +        return 0;
>> +    }
>> +
>>       avail_idx = *((volatile uint16_t *)&vq->avail->idx);
>> +    vhost_user_iotlb_rd_unlock(vq);
>> +    rte_rwlock_read_unlock(&vq->access_lock);
>> +
> 
> You should only unlock at the end of the function, otherwise there is 
> not much protection.

Ha, and also you should be able to remove: 
__rte_no_thread_safety_analysis /* FIXME: requires iotlb_lock? */
in vhost_crypto_process_one_req() once implemented.

Regards,
Maxime
> 
>>       start_idx = vq->last_used_idx;
>>       count = avail_idx - start_idx;
>>       count = RTE_MIN(count, VHOST_CRYPTO_MAX_BURST_SIZE);
> 

