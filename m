Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF66CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 09:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8991D402DD;
	Mon,  6 Oct 2025 11:45:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 697BF402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 11:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759743907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0+727SGRUDCMVKJEz7XkO+oCwCvXdaA1EqE6QXDUWe8=;
 b=QozusisIm39H2P5b3cMaf+Xv8hB40Z0ptdS3diDPqXSinkDdpo66vYnPsEGgKbXOik/lN1
 6VslDa6Yr+6NMbVXGk9PrWhP3sjTQFd+0eIlw4S5GEenFPH4kkA+Izk8GehadfvtuVoE1w
 pn+ewm/E/nITimCAtgb/wVeoMqR1nUQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-QczmkyMsNL6ZA1gcC-j7Ng-1; Mon,
 06 Oct 2025 05:45:03 -0400
X-MC-Unique: QczmkyMsNL6ZA1gcC-j7Ng-1
X-Mimecast-MFC-AGG-ID: QczmkyMsNL6ZA1gcC-j7Ng_1759743902
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC0A1195608C; Mon,  6 Oct 2025 09:45:02 +0000 (UTC)
Received: from [10.44.22.30] (unknown [10.44.22.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FA2D180141C; Mon,  6 Oct 2025 09:45:00 +0000 (UTC)
Message-ID: <34a49225-5664-451d-a215-daf0ec81feb6@redhat.com>
Date: Mon, 6 Oct 2025 11:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio_user exception path with external memory
To: Pekka Riikonen <priikone@iki.fi>, dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>
References: <0e15cd8e9def8c16b15c028206a6d308@silc.fi>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <0e15cd8e9def8c16b15c028206a6d308@silc.fi>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Us-FDBoIAOLOxGvZtTW1FLd45tg0fULJRyR7OkaiOE8_1759743902
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

Hi Pekka,

On 8/6/25 9:56 AM, Pekka Riikonen wrote:
> 
> It seems that currently it's not possible to use packet pools allocated 
> with external memory with the virtio_user exception path use case, 
> because it ignores extmem in virtio_user_mem_event_cb() (and also in the 
> kernel backend in add_memseg_list()).  This is easy to test with testpmd 
> with the --mp-alloc=xmemhuge or --mp-alloc=anon option (https:// 
> doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html).
> 
> The original commit that added the check (5282bb1c3 mem: allow memseg 
> lists to be marked as external) talks about needing file descriptors in 
> virtio that aren't available with extmem, but at least the kernel 
> backend doesn't seem to need any.  The patch below fixes the issue for 
> me with with the exception path.
> 
> So I'm wondering whether ignoring the extmem is actually needed, in this 
> use case?

It might not be needed, but we would need to take care of not breaking 
backends that does not support extmem.

Could you prepare a formal patch?

Thanks,
Maxime

> 
> ---
> diff --git a/drivers/net/virtio/virtio_user/vhost_kernel.c b/drivers/ 
> net/virtio/virtio_user/vhost_kernel.c
> index e42bb35935..cd5b975675 100644
> --- a/drivers/net/virtio/virtio_user/vhost_kernel.c
> +++ b/drivers/net/virtio/virtio_user/vhost_kernel.c
> @@ -189,9 +189,6 @@ add_memseg_list(const struct rte_memseg_list *msl, 
> void *arg)
>       void *start_addr;
>       uint64_t len;
> 
> -    if (msl->external)
> -        return 0;
> -
>       if (vm->nregions >= max_regions)
>           return -1;
> 
> diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/ 
> net/virtio/virtio_user/virtio_user_dev.c
> index 187f81b066..d5204a64a7 100644
> --- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> @@ -539,20 +539,14 @@ virtio_user_fill_intr_handle(struct 
> virtio_user_dev *dev)
> 
>   static void
>   virtio_user_mem_event_cb(enum rte_mem_event type __rte_unused,
> -             const void *addr,
> +             const void *addr __rte_unused,
>                size_t len __rte_unused,
>                void *arg)
>   {
>       struct virtio_user_dev *dev = arg;
> -    struct rte_memseg_list *msl;
>       uint16_t i;
>       int ret = 0;
> 
> -    /* ignore externally allocated memory */
> -    msl = rte_mem_virt2memseg_list(addr);
> -    if (msl->external)
> -        return;
> -
>       pthread_mutex_lock(&dev->mutex);
> 
>       if (dev->started == false)
> ---
> 
> Pekka
> 

