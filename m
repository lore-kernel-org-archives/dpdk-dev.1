Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB8FCCA476
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 09:40:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1785402B6;
	Tue,  7 Oct 2025 11:40:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E1CF040648
 for <dev@dpdk.org>; Tue,  7 Oct 2025 11:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759830037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZzAGaVmepIRxM0DpcilJZmGZ44e2mE+QbOspJzeL+98=;
 b=OngdHrSTrwDCCZJwNrXvzkU909zoIATvsovSPB22zLDmBG2MjhzkDFtY1sZw6JOQzUXFsR
 6PRagSh5WWadTm/SbNEUI3Vfki73k+qo9cce/btkaOusbLQ6hGsM/2gZv9IgHGqxUqWYmt
 6GTDIM8G2bGMXNG8wYmufw/aaLlNul4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-kHoh6VobOJ-0GNiw3d6clw-1; Tue,
 07 Oct 2025 05:40:34 -0400
X-MC-Unique: kHoh6VobOJ-0GNiw3d6clw-1
X-Mimecast-MFC-AGG-ID: kHoh6VobOJ-0GNiw3d6clw_1759830032
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DAD0180045C; Tue,  7 Oct 2025 09:40:32 +0000 (UTC)
Received: from [10.45.242.31] (unknown [10.45.242.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F175F1956056; Tue,  7 Oct 2025 09:40:29 +0000 (UTC)
Message-ID: <86b467b3-a8d6-4c84-9376-e1eaf785db57@redhat.com>
Date: Tue, 7 Oct 2025 11:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/virtio-user: fix used ring address calculation
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, amorenoz@redhat.com, chenbox@nvidia.com,
 schalla@marvell.com, stable@dpdk.org
References: <20250805083657.1227817-1-maxime.coquelin@redhat.com>
 <CAJFAV8xpLpaFUyHMpF4jxpJ335YJw=TuCDWzT9oXy1+PXG4BkA@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 xsFNBFOEQQIBEADjNLYZZqghYuWv1nlLisptPJp+TSxE/KuP7x47e1Gr5/oMDJ1OKNG8rlNg
 kLgBQUki3voWhUbMb69ybqdMUHOl21DGCj0BTU3lXwapYXOAnsh8q6RRM+deUpasyT+Jvf3a
 gU35dgZcomRh5HPmKMU4KfeA38cVUebsFec1HuJAWzOb/UdtQkYyZR4rbzw8SbsOemtMtwOx
 YdXodneQD7KuRU9IhJKiEfipwqk2pufm2VSGl570l5ANyWMA/XADNhcEXhpkZ1Iwj3TWO7XR
 uH4xfvPl8nBsLo/EbEI7fbuUULcAnHfowQslPUm6/yaGv6cT5160SPXT1t8U9QDO6aTSo59N
 jH519JS8oeKZB1n1eLDslCfBpIpWkW8ZElGkOGWAN0vmpLfdyiqBNNyS3eGAfMkJ6b1A24un
 /TKc6j2QxM0QK4yZGfAxDxtvDv9LFXec8ENJYsbiR6WHRHq7wXl/n8guyh5AuBNQ3LIK44x0
 KjGXP1FJkUhUuruGyZsMrDLBRHYi+hhDAgRjqHgoXi5XGETA1PAiNBNnQwMf5aubt+mE2Q5r
 qLNTgwSo2dpTU3+mJ3y3KlsIfoaxYI7XNsPRXGnZi4hbxmeb2NSXgdCXhX3nELUNYm4ArKBP
 LugOIT/zRwk0H0+RVwL2zHdMO1Tht1UOFGfOZpvuBF60jhMzbQARAQABzSxNYXhpbWUgQ29x
 dWVsaW4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPsLBeAQTAQIAIgUCV3u/5QIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQyjiNKEaHD4ma2g/+P+Hg9WkONPaY1J4AR7Uf
 kBneosS4NO3CRy0x4WYmUSLYMLx1I3VH6SVjqZ6uBoYy6Fs6TbF6SHNc7QbB6Qjo3neqnQR1
 71Ua1MFvIob8vUEl3jAR/+oaE1UJKrxjWztpppQTukIk4oJOmXbL0nj3d8dA2QgHdTyttZ1H
 xzZJWWz6vqxCrUqHU7RSH9iWg9R2iuTzii4/vk1oi4Qz7y/q8ONOq6ffOy/t5xSZOMtZCspu
 Mll2Szzpc/trFO0pLH4LZZfz/nXh2uuUbk8qRIJBIjZH3ZQfACffgfNefLe2PxMqJZ8mFJXc
 RQO0ONZvwoOoHL6CcnFZp2i0P5ddduzwPdGsPq1bnIXnZqJSl3dUfh3xG5ArkliZ/++zGF1O
 wvpGvpIuOgLqjyCNNRoR7cP7y8F24gWE/HqJBXs1qzdj/5Hr68NVPV1Tu/l2D1KMOcL5sOrz
 2jLXauqDWn1Okk9hkXAP7+0Cmi6QwAPuBT3i6t2e8UdtMtCE4sLesWS/XohnSFFscZR6Vaf3
 gKdWiJ/fW64L6b9gjkWtHd4jAJBAIAx1JM6xcA1xMbAFsD8gA2oDBWogHGYcScY/4riDNKXi
 lw92d6IEHnSf6y7KJCKq8F+Jrj2BwRJiFKTJ6ChbOpyyR6nGTckzsLgday2KxBIyuh4w+hMq
 TGDSp2rmWGJjASrOwU0EVPSbkwEQAMkaNc084Qvql+XW+wcUIY+Dn9A2D1gMr2BVwdSfVDN7
 0ZYxo9PvSkzh6eQmnZNQtl8WSHl3VG3IEDQzsMQ2ftZn2sxjcCadexrQQv3Lu60Tgj7YVYRM
 H+fLYt9W5YuWduJ+FPLbjIKynBf6JCRMWr75QAOhhhaI0tsie3eDsKQBA0w7WCuPiZiheJaL
 4MDe9hcH4rM3ybnRW7K2dLszWNhHVoYSFlZGYh+MGpuODeQKDS035+4H2rEWgg+iaOwqD7bg
 CQXwTZ1kSrm8NxIRVD3MBtzp9SZdUHLfmBl/tLVwDSZvHZhhvJHC6Lj6VL4jPXF5K2+Nn/Su
 CQmEBisOmwnXZhhu8ulAZ7S2tcl94DCo60ReheDoPBU8PR2TLg8rS5f9w6mLYarvQWL7cDtT
 d2eX3Z6TggfNINr/RTFrrAd7NHl5h3OnlXj7PQ1f0kfufduOeCQddJN4gsQfxo/qvWVB7PaE
 1WTIggPmWS+Xxijk7xG6x9McTdmGhYaPZBpAxewK8ypl5+yubVsE9yOOhKMVo9DoVCjh5To5
 aph7CQWfQsV7cd9PfSJjI2lXI0dhEXhQ7lRCFpf3V3mD6CyrhpcJpV6XVGjxJvGUale7+IOp
 sQIbPKUHpB2F+ZUPWds9yyVxGwDxD8WLqKKy0WLIjkkSsOb9UBNzgRyzrEC9lgQ/ABEBAAHC
 wV8EGAECAAkFAlT0m5MCGwwACgkQyjiNKEaHD4nU8hAAtt0xFJAy0sOWqSmyxTc7FUcX+pbD
 KVyPlpl6urKKMk1XtVMUPuae/+UwvIt0urk1mXi6DnrAN50TmQqvdjcPTQ6uoZ8zjgGeASZg
 jj0/bJGhgUr9U7oG7Hh2F8vzpOqZrdd65MRkxmc7bWj1k81tOU2woR/Gy8xLzi0k0KUa8ueB
 iYOcZcIGTcs9CssVwQjYaXRoeT65LJnTxYZif2pfNxfINFzCGw42s3EtZFteczClKcVSJ1+L
 +QUY/J24x0/ocQX/M1PwtZbB4c/2Pg/t5FS+s6UB1Ce08xsJDcwyOPIH6O3tccZuriHgvqKP
 yKz/Ble76+NFlTK1mpUlfM7PVhD5XzrDUEHWRTeTJSvJ8TIPL4uyfzhjHhlkCU0mw7Pscyxn
 DE8G0UYMEaNgaZap8dcGMYH/96EfE5s/nTX0M6MXV0yots7U2BDb4soLCxLOJz4tAFDtNFtA
 wLBhXRSvWhdBJZiig/9CG3dXmKfi2H+wdUCSvEFHRpgo7GK8/Kh3vGhgKmnnxhl8ACBaGy9n
 fxjSxjSO6rj4/MeenmlJw1yebzkX8ZmaSi8BHe+n6jTGEFNrbiOdWpJgc5yHIZZnwXaW54QT
 UhhSjDL1rV2B4F28w30jYmlRmm2RdN7iCZfbyP3dvFQTzQ4ySquuPkIGcOOHrvZzxbRjzMx1
 Mwqu3GQ=
In-Reply-To: <CAJFAV8xpLpaFUyHMpF4jxpJ335YJw=TuCDWzT9oXy1+PXG4BkA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2udM0cqQFIFC8MAqhf9II4i1-Is1cz3fbOXRyu3JBNo_1759830032
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



On 8/18/25 2:56 PM, David Marchand wrote:
> On Tue, Aug 5, 2025 at 10:37 AM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
>>
>> This patch fixes the used ring address calculation, to
>> avoid Vhost-vDPA backends (such as VDUSE) to fail while
>> trying to translate it.
> 
> Maybe update the patch title to reflect that this issue affects
> vhost-vdpa backend?
> 
> 
>>
>> Fixes: 666ef294ddf7 ("net/virtio-user: share descriptor IOVA to backend")
>> Cc: stable@dpdk.org
>>
>> Reported-by: Adrian Moreno <amorenoz@redhat.com>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>   drivers/net/virtio/virtio_user/virtio_user_dev.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
>> index 187f81b066..7789f337f6 100644
>> --- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
>> +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
>> @@ -149,7 +149,8 @@ virtio_user_kick_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
>>          } else {
>>                  desc_addr = vring->desc_iova;
>>                  avail_addr = desc_addr + vring->num * sizeof(struct vring_desc);
>> -               used_addr = RTE_ALIGN_CEIL((uintptr_t)(&vring->avail->ring[vring->num]),
>> +               used_addr = RTE_ALIGN_CEIL(avail_addr + offsetof(struct vring_avail,
>> +                                               ring[vring->num]),
>>                                             VIRTIO_VRING_ALIGN);
> 
> The fix looks good to me, but I would go one step further (as a
> followup maybe?).
> 
> I see no good reason for computing again the addresses in the kick
> helper, while those addresses should be set once and for all at
> "setup" time.
> Only an offset needs to be applied to account for iova stuff.
> 
> What do you think of something like:
> 
> diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> index 187f81b066..dcb702ace3 100644
> --- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> @@ -118,7 +118,7 @@ virtio_user_kick_queue(struct virtio_user_dev
> *dev, uint32_t queue_sel)
>          struct vhost_vring_state state;
>          struct vring *vring = &dev->vrings.split[queue_sel];
>          struct vring_packed *pq_vring = &dev->vrings.packed[queue_sel];
> -       uint64_t desc_addr, avail_addr, used_addr;
> +       uint64_t desc_addr, desc_iova_addr, avail_addr, used_addr;
>          struct vhost_vring_addr addr = {
>                  .index = queue_sel,
>                  .log_guest_addr = 0,
> @@ -138,25 +138,22 @@ virtio_user_kick_queue(struct virtio_user_dev
> *dev, uint32_t queue_sel)
>          }
> 
>          if (dev->features & (1ULL << VIRTIO_F_RING_PACKED)) {
> -               desc_addr = pq_vring->desc_iova;
> -               avail_addr = desc_addr + pq_vring->num * sizeof(struct
> vring_packed_desc);
> -               used_addr =  RTE_ALIGN_CEIL(avail_addr + sizeof(struct
> vring_packed_desc_event),
> -                                           VIRTIO_VRING_ALIGN);
> -
> -               addr.desc_user_addr = desc_addr;
> -               addr.avail_user_addr = avail_addr;
> -               addr.used_user_addr = used_addr;
> +               desc_iova_addr = pq_vring->desc_iova;
> +               desc_addr = (uint64_t)(uintptr_t)pq_vring->desc;
> +               avail_addr = (uint64_t)(uintptr_t)pq_vring->driver;
> +               used_addr = (uint64_t)(uintptr_t)pq_vring->device;
> +
>          } else {
> -               desc_addr = vring->desc_iova;
> -               avail_addr = desc_addr + vring->num * sizeof(struct vring_desc);
> -               used_addr =
> RTE_ALIGN_CEIL((uintptr_t)(&vring->avail->ring[vring->num]),
> -                                          VIRTIO_VRING_ALIGN);
> -
> -               addr.desc_user_addr = desc_addr;
> -               addr.avail_user_addr = avail_addr;
> -               addr.used_user_addr = used_addr;
> +               desc_iova_addr = vring->desc_iova;
> +               desc_addr = (uint64_t)(uintptr_t)vring->desc;
> +               avail_addr = (uint64_t)(uintptr_t)vring->avail;
> +               used_addr = (uint64_t)(uintptr_t)vring->used;
>          }
> 
> +       addr.desc_user_addr = desc_iova_addr;
> +       addr.avail_user_addr = (desc_iova_addr - desc_addr) + avail_addr;
> +       addr.used_user_addr = (desc_iova_addr - desc_addr) + used_addr;
> +
>          state.index = queue_sel;
>          state.num = vring->num;
>          ret = dev->ops->set_vring_num(dev, &state);
> 
> 
> 
> 

I agree with your suggestion, I will ost a v2 soon.

Thanks,
Maxime

