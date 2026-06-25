Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0DDCDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 12:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB3D54066F;
	Thu, 25 Jun 2026 14:44:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DA08440430
 for <dev@dpdk.org>; Thu, 25 Jun 2026 14:44:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782391488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7uNFMxxgC9JFxH01Z5ZepZoMwsdJB8AU5n1Xggi1J4=;
 b=TwhBsQiM1mIxAG6/nNo7sM27aGUklhvZEwvOYO0eUeog4svmkekml5IDryeKmoG3Ly7O2o
 w191jCCT3vLt53jHeejoO7MSzvE4YYefVbggn83o2U8aMgMG87pdhgUtUXHZ3eYyQupvh1
 ba97ikooA3YF9kzQxzkr+TAd1TkoxN8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-z5r0BAYPP36yB8fIA-Brjw-1; Thu, 25 Jun 2026 08:44:44 -0400
X-MC-Unique: z5r0BAYPP36yB8fIA-Brjw-1
X-Mimecast-MFC-AGG-ID: z5r0BAYPP36yB8fIA-Brjw_1782391483
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39971dce27aso11600491fa.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 05:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782391483; x=1782996283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7uNFMxxgC9JFxH01Z5ZepZoMwsdJB8AU5n1Xggi1J4=;
 b=SB75h4iWs8vV4BD3UioasOUMlgyD196nCpqVcPUNleVAnXHMAgLTg2TF7ANVvq9I58
 jbJzzwi3JzlAD6aX5+byBvTbeQNKp8DFqpcFsHqAl/f9Stid/HSgZgOcQ6+byUGex6hV
 gCyEiT8mC9H3TnQySg6NLUNMcVnfS0NboAmNSFR9yGZQndX5GWQbArpJpjVkP0sHvxlf
 f95+IEbuOmQRK9VBZ62xVEFfi2tYbUM5GpQZV1uFZqlF0NXcnspojdSFNskWN2e5sOm9
 BiD+h0iZp5pyh0EHJ96thVrQLe8IYyenKPe0MyYWC+olljaBQjIHi7CrrITKTnxVw3Tg
 lirQ==
X-Gm-Message-State: AOJu0Yx7nSDw9I8G3GLOY7lH8cN/VhoMMAdelWqfPryMwiPt6cRylb/T
 aWHgf3v0JmgDzmJwDG1u/abVoGxcmloia0uu9KtMmqDrbwKWhorNa4WUg/Pc8C+OmwkR3XlYgLS
 Ys2W69cvIYxXjlTZXRcsc8uKSZTy9dm1y75g3PnjkPOGr8QS6xkDYde6cRB5j63FejnkoOT7W31
 a3Uy7nXLXxaHBE4tlMU8k=
X-Gm-Gg: AfdE7clSVmqLHWaz2mlwMzqS3aIZXC9KNvRPHoBLUQoeWRV71OfTltmieXHBfrsfZUK
 bFJ32wc+qP0DjP7hcGqiCNii96NB7We9w7jscrXOs9Li50XQDwKgYw1C+q8qukqA5OanRso4Vuz
 ik7ffFB/ahr/QerJTGWM3X3xgHOsqSSSWUqnrrJYSQ8h0A22k/57dkHcBghcgOcm58b3ned0+AG
 uy7RGY/afi1ZdstZQBRw8AtZMGIZGr80745NcooUIFVmQY4Zmao76xfF/Q=
X-Received: by 2002:a2e:a813:0:b0:393:cb61:17e9 with SMTP id
 38308e7fff4ca-39acb7f91b6mr5937781fa.17.1782391483299; 
 Thu, 25 Jun 2026 05:44:43 -0700 (PDT)
X-Received: by 2002:a2e:a813:0:b0:393:cb61:17e9 with SMTP id
 38308e7fff4ca-39acb7f91b6mr5937681fa.17.1782391482777; Thu, 25 Jun 2026
 05:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260624142023.1525497-1-radu.nicolau@intel.com>
In-Reply-To: <20260624142023.1525497-1-radu.nicolau@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 14:44:30 +0200
X-Gm-Features: AVVi8CePINYI7JSPpcwulMW64LGNFM898X5EN_G2tCL0cmP5jWNQo3G78FbHP_c
Message-ID: <CAJFAV8wCno0t-oLAtVCmWjvYOdcxGEGohcxOb2JP_W4W3cr7aA@mail.gmail.com>
Subject: Re: [PATCH] vhost/crypto: fix segfault
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Jay Zhou <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p3Ka35cL-SUSkTkaFb2pmdkCE3eXl_5VISvT6Fowyc0_1782391483
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

On Wed, 24 Jun 2026 at 16:21, Radu Nicolau <radu.nicolau@intel.com> wrote:
>
> Fix potential call with dev->mem uninitialized, one common usecase
> example being running the autotest with more than one device.
>
> Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")
> Cc: stable@dpdk.org
>
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
>  lib/vhost/vhost_crypto.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
> index 648e2d731b..3679eaca1e 100644
> --- a/lib/vhost/vhost_crypto.c
> +++ b/lib/vhost/vhost_crypto.c
> @@ -1512,6 +1512,10 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
>                 VC_LOG_ERR("Invalid descriptor");
>                 return -1;
>         }
> +       if (unlikely((vc_req->dev->mem) == NULL)) {

(Unneeded extra ())

It sounds to me that some initialisation failed, or processing happens
without waiting initialisation finished.


> +               VC_LOG_ERR("Uninitialized vhost device");
> +               return -1;
> +       }
>
>         dlen = head->len;
>         src_desc = IOVA_TO_VVA(struct vring_desc *, vc_req->dev, vq,
> --
> 2.52.0
>


-- 
David Marchand

