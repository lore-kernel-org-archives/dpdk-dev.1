Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A99C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B8D540697;
	Tue,  8 Jul 2025 14:41:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 11621402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751978469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdu4MchnpADyx82wsfqv8rKX3VRh66VIPYPeuJfJpAA=;
 b=VLETc4AdJ1eCXophfUnZIzwG3Px5P6SiLhRgF8SbZGLanWJVpDZ2I7KYHcVM+z0Lr3Ftkb
 E6mEwt21abem5AQgfuk/Fx9e7fJbl9paufyW23ypV3LKv6iBzRdIE/8tty3Hdco1qOj27q
 uA+pYRjqDCFQ7KuBj6NUoC7HQe/teCk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-AUbt5dg7Oo2yDUfrUQ-RmA-1; Tue, 08 Jul 2025 08:41:08 -0400
X-MC-Unique: AUbt5dg7Oo2yDUfrUQ-RmA-1
X-Mimecast-MFC-AGG-ID: AUbt5dg7Oo2yDUfrUQ-RmA_1751978467
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553decb7e3cso2687536e87.1
 for <dev@dpdk.org>; Tue, 08 Jul 2025 05:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751978467; x=1752583267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdu4MchnpADyx82wsfqv8rKX3VRh66VIPYPeuJfJpAA=;
 b=XFk1Wzhp5Puw7/F5AZRG6pR7b/8Ikyik9Lo8Q74KIjTHAk0+LBsZ/VdymQ9zIKgNu7
 FfgttpjgaGSyFou7Ovc4+yh0/Sb+kmkodHcoSbTGezl3tAeNIAVfhJ9tKqJPWxPY0FBD
 G2uouZjgDvKyRtsuCnH6yinjo2T/Ech4HYX4uaB2au/bvtF+jAf5wBWMKMYgYX/HfAou
 lfsGCGX3gi4oF804weTLLliTsv3zQnCJ2y/Xge22zN54NMwvqp0Dp34ezKCPnvA7P5bw
 rxZJhmE0PJV4AqhUswFLIwbBpJBIoWijGcKg4bnO8ZiuJ497o0W3cX04cqfLyg8JR/fT
 Rn6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV5J1VmD+o3pBUNR3Y15EEMIN7VTgqtaeKDgh76bLFgkxrzhpiBvqQPJviIA4a9HVPU6o=@dpdk.org
X-Gm-Message-State: AOJu0Yxy3XmbeodlmZafS19m3NijDpaDT2tu9/zGa+SuwyKPX4VLwHwL
 H4HVEguMM8kx+ZB9hv5nrAzQanmbxwHpWSOz2DKw1dtab61r0uMGZNFNwyDXoQaRiAyTyGmbIai
 ODWvBb5Bnjnsa7VxV3Mo+eU39xyyWF/GIlZoaFML+dCD8BSNt8B50RQ7qdvbXj8Ni+sWlMoR4og
 3vrISZb4xWIklMtnW/kPQ=
X-Gm-Gg: ASbGnctQrnFx6kwPg3XeTBqF8MZQkWHbK0NRHYyFHSqTXE6qvs+lBneBkY1q7HN8jJa
 OgGVVxScmONdondiTLrKXs4TNBOBBE2+TnyehL2KI/v8xh/dtmjggdrKD0lQhGpkbmzp4dK/B8f
 a1wPk/WQ==
X-Received: by 2002:a05:6512:10d1:b0:553:adf2:38bb with SMTP id
 2adb3069b0e04-557f837b97bmr898759e87.46.1751978466818; 
 Tue, 08 Jul 2025 05:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6FArQpWe2h4vFkBdaiNJRXDX74nJnp5MlASQI/0E0pDT0ppinnFLK+MsDzhGXdhngRnMopxBZ6WHvW6cGKA8=
X-Received: by 2002:a05:6512:10d1:b0:553:adf2:38bb with SMTP id
 2adb3069b0e04-557f837b97bmr898746e87.46.1751978466369; Tue, 08 Jul 2025
 05:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250625092722.70938-1-marat.khalili@huawei.com>
In-Reply-To: <20250625092722.70938-1-marat.khalili@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 8 Jul 2025 14:40:50 +0200
X-Gm-Features: Ac12FXzMlLO78vCs5uLWMbEfTl5XUofjKVbh0Sy2jI2NjbP4ak-_mTWUuNrkVnE
Message-ID: <CAJFAV8wbS3QPy7Qd=CtqUPPr83w2TmWDQFcbs4NGkO-nd80b3Q@mail.gmail.com>
Subject: Re: [PATCH v3] lib/graph: lib/graph: fix memset with NULL
To: Marat Khalili <marat.khalili@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>,
 dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nSO2otCso6K1gcMxrBFag3J2rlWv-bA_-uKgw1hSvs8_1751978467
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

On Wed, Jun 25, 2025 at 11:29=E2=80=AFAM Marat Khalili <marat.khalili@huawe=
i.com> wrote:
>
> This was flagged by undefined behaviour sanitizer: memset should not be
> called with NULL first argument. (memset requires first argument to be
> pointer to a memory object, so passing NULL may result in an undefined
> behaviour including among other things optimizer potentially removing
> code paths depending on stat->xstat_count being NULL.)
>
> Sanitizer message:
>
>     lib/graph/graph_stats.c:473:2: runtime error: null pointer passed as
>     argument 1, which is declared to never be null
>
> Add a check that stat->xstat_cntrs is not zero before the call, since
> stat->xstat_count can only be NULL when stat->xstat_cntrs is zero.
>
> Fixes: 070db97e017 ("graph: support node xstats")
>
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>

Just a fyi, I added your patch as part of my series, since running
with UBSan in GHA required this fix.

We may still take your fix as is, so I'll leave it in patchwork.


--=20
David Marchand

