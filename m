Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44196D44C51
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:37:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C657B40DFD;
	Thu, 15 Jan 2026 15:37:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BC5154003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:37:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768487824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rT/ySO8dFjPdCWq2VA7ZdTMy0NtJcTD7U50frG/lqc=;
 b=MP9TMPq+llulcfp7cPWLdQLkDsoSEJbZnYBM8M5IvYmJmI2CZDusNA3Eg8GbfAJGLtkMpu
 Bn1b99h10kRxN2UvhiHfrZlwG3R8eQ5i1xMraIyakM0oF+0MWq2HdmWwIfUyM+Isp8UK3s
 oIfMHwv0UR7AsaaQNEKfQUzOeFZA6RU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-vLil1_dbNsa7K2aY_Bf08Q-1; Thu, 15 Jan 2026 09:37:03 -0500
X-MC-Unique: vLil1_dbNsa7K2aY_Bf08Q-1
X-Mimecast-MFC-AGG-ID: vLil1_dbNsa7K2aY_Bf08Q_1768487821
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-382f49594c5so4855711fa.0
 for <dev@dpdk.org>; Thu, 15 Jan 2026 06:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487821; x=1769092621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2rT/ySO8dFjPdCWq2VA7ZdTMy0NtJcTD7U50frG/lqc=;
 b=njcYKQltgpOsUR/nK/icpvB9VKcQVb95cGlSvNGHut+j6CGWXJGVGdjXxu9F52YtEv
 T1gJZwmYirIygNDcP+3BD5BbbhjdaD0yO+430bcuFjuH/VeIp1/VVShSyDoAK/9iCeK/
 U/V7q4eqjCpsr3EOO/AHFyV5rN3QPhRbTjX1Z/knRrAEeYKjkwwBM5IyPk9wuLlxPzOJ
 70dQE7YPAvpon8hOUsq0NpDqyPIRy2g2caFuKPM2ON7mtaaS8QTzfxNInM9Gb2GzTDIW
 Oj5G4VjV2pyAI3JU9aVTknR1sGGUML3HWLrd7cvq4LQtr3u3WttqJ3UR36gdrY01okup
 LVbA==
X-Gm-Message-State: AOJu0Yx+7dPDCGrfP/3W/qtHaZdQEsAgoEtBrVqcitGzIHEbzFi+nZuR
 3BAMvk5NqF49xo8RSG4oSdfOwqKCbeLVBatjPNNr29iSqEdQj27BHNIcOIZaN9UcezcL20edczV
 KXCLRcLAfYLanD7F/XaoWXwdeb5de2MX0oDWvNkeDswbb8UfgI/z5pioVmyjuOkPkOJ2S/qkiIk
 KMY90VeiBtNV7nC5yTch0=
X-Gm-Gg: AY/fxX6PlEOye6ABCjNwqDvLM1tPBPBvYM9BAyaVxuzKqq2M8/yEXmvTuBtqL04g1ht
 G7tvctA2YE6IAVgiFQWDbiNvHZSyHJTgBiANSmtdAepsLm/rozappErcs/d49tHvNll0bOagMYu
 eilsujBOQuQD4AitWvaUuTYlnVdoSAKgw3nkhoCmglaXwcpWkvxNqUk5MHPSpuJD7bhAsCQD33h
 bhCTuVwqQQAp+yBfXYoYUzYRDwUd2UU/ztK5bTZT+6zoQwGTf/Idg==
X-Received: by 2002:a2e:ad12:0:b0:383:27d9:79f1 with SMTP id
 38308e7fff4ca-383630c9543mr17458691fa.37.1768487821369; 
 Thu, 15 Jan 2026 06:37:01 -0800 (PST)
X-Received: by 2002:a2e:ad12:0:b0:383:27d9:79f1 with SMTP id
 38308e7fff4ca-383630c9543mr17458611fa.37.1768487820915; Thu, 15 Jan 2026
 06:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20251222004446.62076-1-stephen@networkplumber.org>
In-Reply-To: <20251222004446.62076-1-stephen@networkplumber.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 15 Jan 2026 15:36:48 +0100
X-Gm-Features: AZwV_Qjn3q9GnlXJY5O_ae38OwzjchcdyCc00P5q4yospHK-t0iCNus-juCdYKw
Message-ID: <CAO55cswNQTC5szG-aiX+4UL2RzzBWX2oWfOmVcAwgWbjL9r4tw@mail.gmail.com>
Subject: Re: [RFC] net/virtio: avoid global variable name conflicts
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pSD2T2FVYd9tuOzN65RZ_ieaHjPFHUxcLobNn3pUGVk_1768487821
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

On Mon, Dec 22, 2025 at 1:45=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> If PMD is statically linked, all global variables are visible and
> can clash with application or other drivers and therefore should
> have a consistent prefix.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/virtio/virtio_pci.c                   |  8 ++++----
>  drivers/net/virtio/virtio_pci.h                   |  4 ++--
>  drivers/net/virtio/virtio_pci_ethdev.c            |  4 ++--
>  drivers/net/virtio/virtio_user/vhost_kernel.c     | 14 +++++++-------
>  drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 10 +++++-----
>  drivers/net/virtio/virtio_user/vhost_kernel_tap.h | 10 +++++-----
>  6 files changed, 25 insertions(+), 25 deletions(-)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

