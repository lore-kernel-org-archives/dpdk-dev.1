Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC39CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:07:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AB3D40431;
	Wed, 15 Oct 2025 09:07:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EFFE0402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760512028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWuyV8zaUsghFSLz4JuTatxhO5QVgOFge+6LA3Tmj28=;
 b=Cqj4HL7/FD6gpjzdwnc5YPEzJ2Vty46jWcz5DDO8xhqlQPK0J/XL66F+etePO/Ca1Dj+QQ
 yObBT60XNenhDC5z+egBa2nYOKWoYB1hBevbVGGnEtnKPSfK4qCaHf0IKQU8BCOmSh/EOv
 AXKoXxElm61tDsvcRL18qCqItZmZ6Fk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-_pLMnY_FNpOzDgJd05W9xQ-1; Wed, 15 Oct 2025 03:07:04 -0400
X-MC-Unique: _pLMnY_FNpOzDgJd05W9xQ-1
X-Mimecast-MFC-AGG-ID: _pLMnY_FNpOzDgJd05W9xQ_1760512023
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5906653da4cso4206238e87.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 00:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760512023; x=1761116823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWuyV8zaUsghFSLz4JuTatxhO5QVgOFge+6LA3Tmj28=;
 b=Mj9gtq79fvwEa0rrGI9PVN3mkTfHD0Fk0hetA8AIjESjywHkC6wYYoCreRZmGyr2mS
 PlzJFV8mnQAw7CzN7Sr0QIBrvWoxG0ZKmDzf6LTcpZGyEJTHuItQrhCwuOZNV8c6hDhw
 mgHryYN/OopZG7SFxOzJvgmXxyvDAM7afEpLntSEhii6R5qFmmpzcds9gdk6hU2iTQ8A
 wIfCntUXiyHzWVgTP83J2a754sWf+p+i8avJFito5Z5EOajx+q52jj9k4AImUW0VWtRh
 bcF+bnYhcuUFR0ijGqtlsi15lTPIFiiKqxv/KYWK6F40wFb2UcMa96aHTkt98c0Ras5X
 32Iw==
X-Gm-Message-State: AOJu0Yxe8kw81b+LltKwgTRRAntCf/bjMBzLqcZlvQXSw3GOykeAGeVv
 LWW2Cj3bScg8EQwrLbZKYhaXpK2SJpWrATLbOzRsaxKSUAL0JtKV3aTw+ZeQ0OZ3CJ3DnuMI7pZ
 kAaEoKBSs7qDGH3cfifYLm/gjk92JeFHpiHRuT/r0sGXOURe5ar6h+M4qO7Z1RNjdjjBXmaP6du
 ZoGNZVAlXtoHbxlmWT0Mo=
X-Gm-Gg: ASbGncvVNwW6tNc/lWMybR8Gtid0CNWNXYx5xkcczztYPvqCtTU5Rc0PpNBdixj8tRZ
 v9pxlM9v8cAoXNdMjmp2OsrjNzSfwjiImnxJH2qW6XW1H63C6uxQSYNKHS9Cb+EexIT68OvNsea
 WyPK0MvhGmrhO7QiU+mqA=
X-Received: by 2002:a05:6512:114a:b0:57a:640a:11b4 with SMTP id
 2adb3069b0e04-5906dae5760mr7993540e87.39.1760512023269; 
 Wed, 15 Oct 2025 00:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTes4uJEgGK5vMTiStcAqYCiVfxKO1CIIKDvCNiT5LXKyy+ctWLJkRqxCl3JodKF2YZap3g07luqGnwHpXK+M=
X-Received: by 2002:a05:6512:114a:b0:57a:640a:11b4 with SMTP id
 2adb3069b0e04-5906dae5760mr7993532e87.39.1760512022868; Wed, 15 Oct 2025
 00:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250619121209.329493-1-hengqi.chen@gmail.com>
In-Reply-To: <20250619121209.329493-1-hengqi.chen@gmail.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 09:06:51 +0200
X-Gm-Features: AS18NWD78PsGNh6A2xNgsU7KXQ-b3sRUkM9-lyY6-oKlaauvlEqeTYbSGSmBXb8
Message-ID: <CAO55cszPQhjJt5=tGoF21zd54uJ-kxxevQpYbQJ=8SjbPtwxeg@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: Drop unused VTNET_SQ_CQ_QUEUE_IDX
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H87yD1a1l8OAvifs6wocBiyGFDhTqAnr-_lwGGFmHkw_1760512023
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 19, 2025 at 2:12=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> The VTNET_SQ_CQ_QUEUE_IDX is orphaned, drop it.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  drivers/net/virtio/virtqueue.h | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

