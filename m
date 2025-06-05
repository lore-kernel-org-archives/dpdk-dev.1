Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F5C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 14:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E03E40270;
	Thu,  5 Jun 2025 16:55:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D402A40150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 16:55:00 +0200 (CEST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-wLXyuRm_MrikuNJAQ5K8sQ-1; Thu, 05 Jun 2025 10:54:59 -0400
X-MC-Unique: wLXyuRm_MrikuNJAQ5K8sQ-1
X-Mimecast-MFC-AGG-ID: wLXyuRm_MrikuNJAQ5K8sQ_1749135298
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-73c09e99069so1241901b3a.0
 for <dev@dpdk.org>; Thu, 05 Jun 2025 07:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749135298; x=1749740098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnKk+602EL50lQjqHpnfoZ8yry54dC+bNkUq0YnNtpE=;
 b=dkPgsxIVGcRD28e5FDoNNS6rtkayYUSa5oXHDfRKy0tMekH+Ixa6oZ7pWeI9lPzjgf
 fQCQtmWncBDU28p7V/Wr1qoe+W7ReiGsSjJewVsoJ/o8td0fLwzEydlZTshK/CvgIv9M
 DVJkGYX7GObmcRFGkAxEPKZwI03BoVz31UHgqyilKdT87Pm10JQ/y30L1z/AsjCK/gSR
 t3dFhPLkVJiZrHM2RYbYhzyAa5wJGZyqVuzF/P1gSqjbKveYonV8S3sm4pNZpAMzhiGS
 Qld3Axv5gWALuJGxVoD2vRD26wteK2PcjPzlnzWOWGWJETZzbq3iEWRhKJqXCcmZHkk9
 zxBA==
X-Gm-Message-State: AOJu0YzhQ0wmDYvXpvCj2XI2SD2hUz40MvG4VYIWorwY2/HCSzfYflV5
 anpZ92YmXS8mEIeqn1nxyzHsbnZh0o8HOIMqhA4OJcjYXkmOlhbAyL44xtjaebQf7auAmpPqi2A
 520IH7OuDaL4sN8fblRmmuS7AIA3CZ+1c51p5rtyRPo6ElTTykx4ZenJ224ogufg9UijWbw16gi
 LvywAb0ajwq7tcAF7zWGM=
X-Gm-Gg: ASbGncv25/dCO8Bnnrk/OEXlN6w5KH5bjTdq0gHkOmLQRaAm0wv8CtComVAhqLWLFuT
 3XJIzwxyOiI41JmXcjyBprNurTa+/wHw9miqoSDtsUz/Io8hF+mopg/falXK6oNxYgvo=
X-Received: by 2002:a05:6a00:1142:b0:740:5927:bb8b with SMTP id
 d2e1a72fcca58-74827cfb07fmr130619b3a.0.1749135298077; 
 Thu, 05 Jun 2025 07:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM2w40h/NXnUyD/ngvR+9YD8kHafwawxiGzIPIa5GDxsqeiK/qfqgn76nOy+2Bl371N+3Rx501FQ2yVC5K68k=
X-Received: by 2002:a05:6a00:1142:b0:740:5927:bb8b with SMTP id
 d2e1a72fcca58-74827cfb07fmr130583b3a.0.1749135297647; Thu, 05 Jun 2025
 07:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250605113552.918120-1-eperezma@redhat.com>
 <CAJFAV8ydHHbbtOYLq4dr+g9qPh52EnNEZU5kieNAY4_BPfsO2A@mail.gmail.com>
In-Reply-To: <CAJFAV8ydHHbbtOYLq4dr+g9qPh52EnNEZU5kieNAY4_BPfsO2A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 5 Jun 2025 16:54:21 +0200
X-Gm-Features: AX0GCFusnYAWYO-kPlLVmu_2WsDyrb5r8xIzl_5Tbo6ugyBZmbzEwc7IZqgkOss
Message-ID: <CAJaqyWf1DMkdf-UNVOpbeqDA0CvMjnWoZ-CDcvFzEeO-1re7Ow@mail.gmail.com>
Subject: Re: [PATCH 0/2] Search the split vq desc and avail in RO areas
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z1fTJazDBW1-WnaeMV98vmy0RUuHF-tPc-u5WMJ-kso_1749135298
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

On Thu, Jun 5, 2025 at 1:50=E2=80=AFPM David Marchand <david.marchand@redha=
t.com> wrote:
>
> On Thu, Jun 5, 2025 at 1:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > QEMU's shadow virtqueue and VDUSE exposes these areas as read-only. If
> > we don't change it, vhost_iova_to_vva do not consider them as valid and
> > returns that they're not found.
> >
> > Eugenio P=C3=A9rez (2):
> >   vhost: search the split vq desc and avail in RO areas
> >   vhost: search the packed vq driver area in RO areas
> >
> >  lib/vhost/vhost.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> At a quick glance, no need for two patches.
>

Sure I can respin with both squashed.

> Sorry, the implication of this issue is not clear to me.
> What is the impact from a user pov?
>

QEMU maps the CVQ descriptors and avail vring through as read only
maps in the case of vDPA. But DPDK is looking for them with RW
permissions, so the vhost_iova_to_vva function never selects the right
one as valid.

Looking for them with RO still picks the map if it is mapped as RW,
but the reverse is not true.

Let me know if you want me to respin the series with this comment too!

>
> --
> David Marchand
>

