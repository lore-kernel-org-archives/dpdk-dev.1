Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F03C44500
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 09:19:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6A4F402C3;
	Mon,  6 Jul 2026 11:18:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6CFF74027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 11:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783329537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMcL5zyfmdy/WwXZpIIcVqZ17inW+eLyt4Nxd2mHK0Q=;
 b=XSkNr7ZbXX0/prpMhwSJcosoek33Nhs3cFzzobuV7ol1MioPjJrAVDOGv/iCLriTZ7M6t/
 XbJS7loLFUy3RYsVUZExNX9MSnR9puGwOXYwA/3cyEPUiVinZPyD7vY3XjEFVnMuemigz4
 MESsdaZdhob9p7BEDr9vVGepFNZWgvI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-MJV74Gy7NQ21pIqt_xTz5g-1; Mon, 06 Jul 2026 05:18:56 -0400
X-MC-Unique: MJV74Gy7NQ21pIqt_xTz5g-1
X-Mimecast-MFC-AGG-ID: MJV74Gy7NQ21pIqt_xTz5g_1783329535
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39b24bbce44so14062471fa.0
 for <dev@dpdk.org>; Mon, 06 Jul 2026 02:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783329535; x=1783934335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMcL5zyfmdy/WwXZpIIcVqZ17inW+eLyt4Nxd2mHK0Q=;
 b=BwD/G7WZ8KFX5YPrqgFKS6Au3z+Q0cNMqox9LvEdVnDFpt7CHv5Tpcgi0QEnnbpzsp
 8gyZDTnxFKJIK171NBSH1jA/4S0mlVU/sCs4WFz/KO8+y5xQb5QxktydHHYIvdK6TALG
 9D0J00/+Yo3UVK+Zn09rEuh03VObhe+xSt1S+E8EkyBFwf6MemxldUbZ2e4zyvLp6+zm
 4GGi8ixF8ap1idzZju9DocGLkTUMZwNKwCVsn6L64aaGfjgj7Qlfni9G1SR+6sbTh76F
 U4TKsHbcgAJdY9i+OrJ9aDlGtxSv/h8Fyyc2RI3ZuLC3lkCSCjkkM4IrgeJ8aCApmdvA
 5q0A==
X-Gm-Message-State: AOJu0YwQ0gMFIncWRpRTJgeAX8nomIJlSJOr2u12P7qAqtRLIPcXKXOV
 yrifw30hKo7T7w+v7fmTryBgLW21BsgLWnhJyuLh1p+Q3bvSNHsPRYf0ovs+6saw0S45Fx1+TRf
 mvgFHSOV7GaZ5HiWA0G/oX4ryjdIa9ydw4tDz/dz9J3im+SXYnjjz2q/fEFILp7IIp/7V/Xy5BN
 aH1bEY7kk6rdBJwdGPgVU=
X-Gm-Gg: AfdE7clRbkBpGm2W4SU/x0J4LnVsXj0LKdt2cBSuInnSw7AF7XfGW2Pm1vX+OXnOndm
 e9rMlYB7fL4kT8LzGYeTDQP8I7u2RBNQLUdF4bB7BdZx0NhETSVCrwfzcdkUz7Boc13LSAowP6p
 rLXj7ymkqPCF+jcF8lLJCczzWtfZYH8yyk5xJ/uBXMvnbL8tqFvF18ouK5Gw+e4umLMilu+TXNQ
 JvFSRGyPJ4ghTTVklzUl/ADEVcGi0kKz3y/C5ujCT6OvFarIm7w2iZomdg=
X-Received: by 2002:a2e:bc25:0:b0:39b:1776:6577 with SMTP id
 38308e7fff4ca-39b53cda464mr15602731fa.40.1783329534847; 
 Mon, 06 Jul 2026 02:18:54 -0700 (PDT)
X-Received: by 2002:a2e:bc25:0:b0:39b:1776:6577 with SMTP id
 38308e7fff4ca-39b53cda464mr15602651fa.40.1783329534346; Mon, 06 Jul 2026
 02:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260703144931.2541180-1-radu.nicolau@intel.com>
In-Reply-To: <20260703144931.2541180-1-radu.nicolau@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 6 Jul 2026 11:18:42 +0200
X-Gm-Features: AVVi8CcjYiGYPp1YQ0d91j8MHmOAR8ZA0b5Rp5WZIIJKDqtjiihNIpPCvKmeEcU
Message-ID: <CAJFAV8xL1e7VDTEjKnK62CgJyqfHSwt2t6R+tELTcm2uxNfHCg@mail.gmail.com>
Subject: Re: [PATCH] crypto/virtio: cookies are allocated from mempool
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, jianjay.zhou@huawei.com, 
 Fan Zhang <fanzhang.oss@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YM_0qVj8jciCxJsZg_4F3cCc_QRtq9U7sRlHwKKm3oE_1783329535
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 3 Jul 2026 at 16:50, Radu Nicolau <radu.nicolau@intel.com> wrote:
>
> The Rx/Tx functions allocate cookies as needed, no need to
> allocate and free from heap.
>
> Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
> Cc: jianjay.zhou@huawei.com
>
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>

LGTM, except one nit below.

[snip]

>
> -cookie_alloc_err:
> -       rte_mempool_free(vq->mpool);
> -       if (i != 0) {
> -               for (j = 0; j < i; j++)
> -                       rte_free(vq->vq_descx[j].cookie);
> -       }
>  mpool_create_err:
> +       rte_mempool_free(vq->mpool);

vq->mpool == NULL if reaching this label.

Calling rte_mempool_free() with NULL is harmless/noop.
Still, there is no need (and I find it confusing) to add
rte_mempool_free under the mpool_create_err label.


>         rte_free(vq);
>         return -ENOMEM;
>  }
> --
> 2.52.0
>


-- 
David Marchand

