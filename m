Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19ABC44501
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9D1A40613;
	Mon, 29 Jun 2026 10:18:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C9F334021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 10:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782721105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MaYBWUGtMxpVerWLBug70I6aFV4dQ4RsKkEkGv70TJc=;
 b=R0g0vqoE8pxVlz+OOUSRramHsjN2YBuQedUO9PgIVyxWJbJ4JZE3WQp2VgbSV5u2P5cSzW
 2kJ5eiDo2UtWSadXLOB1mTOcl54jo0k++zJxKiWwx5x0ulHWxA2HwkAojkk+SR/CvXH0Y3
 xiqlVU13P13460NzFEu7zhK4cZsuxlk=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Xqhl392eMWa0hXVb6NnJVQ-1; Mon, 29 Jun 2026 04:18:22 -0400
X-MC-Unique: Xqhl392eMWa0hXVb6NnJVQ-1
X-Mimecast-MFC-AGG-ID: Xqhl392eMWa0hXVb6NnJVQ_1782721102
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139ca26403fso1140364c88.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 01:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782721102; x=1783325902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MaYBWUGtMxpVerWLBug70I6aFV4dQ4RsKkEkGv70TJc=;
 b=HWZOgM63HIjB/bdhJDsJnubrNznJLQRGlurOnsxuP5ANYNk4+xE2TR1ycO7xulfKcE
 yikywdajaG6m0tZb8d0Q9sRSTNAnSQuPab6Dp61EFP5+aaHHzcwOGXsQo6V65YfkptpB
 AtBw8XAvCqIvY4GKVnE9gySHnraJqAGmEfdeo3tt9lsH39YRNrtub7h9eGP5dEosrlI/
 w6FokKxtxKNs7kg6ANHQLM3aDB0+zyB3hR/R/5yaDno8iH2B4URCLh/MkTMmso+fiHnu
 AfhCifGMGLgcPGrtw03DTEqTD5tetmtDzePV028piHiTxK8YsSfnuSbwp+G7GH8cY61C
 JQpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NeA2/yy17aGW6f0dbuLIVrTWWFssg3I9QksXDj8ne+qOA9LrbQedLpbuNyXpqOX+je8w=@dpdk.org
X-Gm-Message-State: AOJu0YzXtkt2UNETmiGbx5xPBfnxsbIqxMtIPLtYovjfS+8WPyrUlk1a
 uzIVI9SRrX6twUgwMdjdom9FfEXnGWZWkVmJlIFkDqnLMYrTodyUjoWf4dftNiAi/7cPSIF7iEf
 fhGeTO6ah1mXESSvO81+6An8NPmjSXB0PHTV3fZaBph9VkCWqze5ZUfTYHXvxPnw8JsaoZd8VrH
 OKOzfWtBuuS8I2zCsLK7I=
X-Gm-Gg: AfdE7ckDh8uQ/EGfHmNqMbgSsZOwRLY7GgKoRMe4VIwEuWJ1OdumXtSdwcwz+9S4+WR
 qkXtdMKpWJTwY0cr5j/apwwQ4DhT0pwFPoWajFXkn5mawnCAYMdmoB6aHhX8PIC33jtEesABHpo
 NFjXi9SJ+SkvbMYwDWg8CTYbO70DaKOIbtfwp3GL53ylGLO7NNELg9TbQzWwnNCVQVKVrp2ifXA
 rIpEGPK2ePVDMrYe4rL+Zr+GbYolqDyh+cyh1KSV55n8mD3P7UCdqY=
X-Received: by 2002:a05:7022:69a0:b0:137:fe07:8a2c with SMTP id
 a92af1059eb24-139dbac2ef7mr14592396c88.22.1782721101531; 
 Mon, 29 Jun 2026 01:18:21 -0700 (PDT)
X-Received: by 2002:a05:7022:69a0:b0:137:fe07:8a2c with SMTP id
 a92af1059eb24-139dbac2ef7mr14592377c88.22.1782721101050; Mon, 29 Jun 2026
 01:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260624142023.1525497-1-radu.nicolau@intel.com>
 <CAJFAV8wCno0t-oLAtVCmWjvYOdcxGEGohcxOb2JP_W4W3cr7aA@mail.gmail.com>
 <c2920f91-4c4f-4e30-8626-12f2606a20f9@intel.com>
In-Reply-To: <c2920f91-4c4f-4e30-8626-12f2606a20f9@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 29 Jun 2026 10:18:09 +0200
X-Gm-Features: AVVi8CfCssYu4jvXTrCiRktFGa5loinp2c1b1I1G9_C0lX82OqZFQ5LLWzDDLiM
Message-ID: <CAO55csyCW5nms7=nCzLw9PA0kptGrGQgQARZ1HJEGBu_Ws4CFQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/crypto: fix segfault
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org, stable@dpdk.org, 
 Chenbo Xia <chenbox@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>, 
 Fan Zhang <fanzhang.oss@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1AKmX4BUVY0Jcd3tQe2xamm0KWB-rhG_Exf2oiygv4U_1782721102
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

On Fri, Jun 26, 2026 at 10:50=E2=80=AFAM Radu Nicolau <radu.nicolau@intel.c=
om> wrote:
>
>
> On 25-Jun-26 1:44 PM, David Marchand wrote:
> > On Wed, 24 Jun 2026 at 16:21, Radu Nicolau <radu.nicolau@intel.com> wro=
te:
> >> Fix potential call with dev->mem uninitialized, one common usecase
> >> example being running the autotest with more than one device.
> >>
> >> Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> >> ---
> >>   lib/vhost/vhost_crypto.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
> >> index 648e2d731b..3679eaca1e 100644
> >> --- a/lib/vhost/vhost_crypto.c
> >> +++ b/lib/vhost/vhost_crypto.c
> >> @@ -1512,6 +1512,10 @@ vhost_crypto_process_one_req(struct vhost_crypt=
o *vcrypto,
> >>                  VC_LOG_ERR("Invalid descriptor");
> >>                  return -1;
> >>          }
> >> +       if (unlikely((vc_req->dev->mem) =3D=3D NULL)) {
> > (Unneeded extra ())
> >
> > It sounds to me that some initialisation failed, or processing happens
> > without waiting initialisation finished.
>
> Indeed calling this function with dev->mem uninitialized is caused by
> some init/deinit state bug, but I still think we should keep this check
> in for added safety.
>
> I will follow up with a v2 to remove the redundant () and also I will
> look into fixing the root cause.

Or maybe this crypto backend is lacking proper protection between
control and data paths?
If dev->mem is reset to NULL asynchrously by the control path without
proper locking, then
the above fix is not enough. For example, the above check could pass
and dev->mem be
reset right after.

>
> >
> >
> >> +               VC_LOG_ERR("Uninitialized vhost device");
> >> +               return -1;
> >> +       }
> >>
> >>          dlen =3D head->len;
> >>          src_desc =3D IOVA_TO_VVA(struct vring_desc *, vc_req->dev, vq=
,
> >> --
> >> 2.52.0
> >>
> >
>

