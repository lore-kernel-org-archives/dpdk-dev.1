Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB0BC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 14:03:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0AE740278;
	Sun, 28 Jun 2026 16:03:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 365A3400D7
 for <dev@dpdk.org>; Sun, 28 Jun 2026 16:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782655384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ge5oTA9KsMx58+38MPHS1nNuFhpwnSdRORKQSodRn3o=;
 b=EN3cNYxevO/m3dzhDqCo3wDfUIz2HD1bZgMY+3gUr18uw53NC8EdFogLxlTe/iXm0SMMA+
 FwHK64khpfpG8a5eLoU5uXZVjB4Izoq60irHu69Gv62vKfPOa3u6Uct3vNzxAnPzTQgYxS
 ZQ8x+P3tiVo30U2LRYzVRULyNoMMUEA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-ARQxM7prNP2HZQUXlV_daA-1; Sun, 28 Jun 2026 10:03:03 -0400
X-MC-Unique: ARQxM7prNP2HZQUXlV_daA-1
X-Mimecast-MFC-AGG-ID: ARQxM7prNP2HZQUXlV_daA_1782655381
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-399c5ee9eeeso13071351fa.3
 for <dev@dpdk.org>; Sun, 28 Jun 2026 07:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782655381; x=1783260181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ge5oTA9KsMx58+38MPHS1nNuFhpwnSdRORKQSodRn3o=;
 b=Tw64WDoq3N0eh73VOH5uvL1k56L9Hd6EaiOfIiphQA5077/nnka7h0hGTh4onfA3bR
 orjeH8RqW8mtKIyCY2lGPs5delo2tDL6EAbX/VU5/lEmEm8taI55xNe4EZPWE0NLK503
 WfbxEWyEQLBIAX602S12gEkHa1Gmpn1GUZSPqLiKlaOhCTZ9LEDy6q3i3ZMPKdf1t/89
 S1xsb7+YhL/aP7Qkh4Ol+1YRVx8NoweKH/bBHFDNNzgfYi9Ql3h/lMKX1etIFhdZ8jxB
 X6AbtLgFco3DmvsPJp6DIY1gQ/sh1LGvn/DfU97H/KUHjovuWszB83AHFHqopy5u0CPS
 SmzQ==
X-Gm-Message-State: AOJu0YzoHH+zz4zyt4gJeNyaZ/MBtU3KIDlpsn8HsAx1GJiEUjwgV8aH
 FIQM70aD1qgE+3vaA6giEeXRaBhlZT7yXEHp2dJ3oSZ5QhhgxN3RjJn5Cq46IK1+adR13EJW//Z
 ryXiDLURLRTIFC6bm8BDRV5Drb53qVJCNL8VfkLmj09OI4Xb31PAT2Qp+ifs7a8P6vGJSkN12JR
 +kknWxE5U6L+9lFg6WhyvoAvu+RqU=
X-Gm-Gg: AfdE7cmWaA/GL6SFH7/Fcx5ElgroY4YE+SXw6OdJ3NpRLQcqBxDQ+Cv0XJ1Gd76Srtq
 jOZ/h9Wctl67JHi3qWaBIqdFWEVKznUenB3jqIhKvtwRyEjTbO0XTTvbE2mNAufUZbaj8ut17OU
 KNQczxNqzAFhhiiMctz2hOlYD6sulMVXYg0t69LqT95KHtSHFwT/kDLVAOl8e4jZoDDMw8YBwjN
 TURXOts8Isk5JdPZlkGMNpP3Bs3WHh0w6hIy4+hUrW+psepQvq4L/iHVS0=
X-Received: by 2002:a05:651c:169c:b0:394:1236:ccb9 with SMTP id
 38308e7fff4ca-39ae13de99emr9440311fa.5.1782655381370; 
 Sun, 28 Jun 2026 07:03:01 -0700 (PDT)
X-Received: by 2002:a05:651c:169c:b0:394:1236:ccb9 with SMTP id
 38308e7fff4ca-39ae13de99emr9440251fa.5.1782655380595; Sun, 28 Jun 2026
 07:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260625072254.4190227-1-david.marchand@redhat.com>
 <SA1PR21MB66832482A8C80E279EAAAB7DCEEB2@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB66832482A8C80E279EAAAB7DCEEB2@SA1PR21MB6683.namprd21.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sun, 28 Jun 2026 16:02:48 +0200
X-Gm-Features: AVVi8Ccr6Qt-K97QfvX2DnTHL1a_HReK8WI8J9G8f-i9ANOVTW2SP9gZlJtrXXg
Message-ID: <CAJFAV8w7YNf0O6ueb8vp6mntZ20+arzLtoJM3GYJj+8RRjt_Cw@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] dev: skip multi-process in hotplug
To: Long Li <longli@microsoft.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RvjNTlJGX1XDR4Nvb-_f0Qa_ZSPm-g01IMQUzKfwLfM_1782655381
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

On Fri, 26 Jun 2026 at 20:10, Long Li <longli@microsoft.com> wrote:
> > @@ -418,6 +434,9 @@ rte_dev_remove(struct rte_device *dev)
> >       if (ret != 0)
> >               return ret;
> >
> > +     if (!do_mp)
> > +             goto skip_mp_req;
> > +
>
> Need to call free(devargs) as it no longer used.

Yes good catch, but I'd rather not build this devargs at all.
I will send a v2.


>
>
> >       memset(&req, 0, sizeof(req));
> >       req.t = EAL_DEV_REQ_TYPE_DETACH;
> >       strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);


-- 
David Marchand

