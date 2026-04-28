Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F98EFF8868
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 09:23:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5820640395;
	Tue, 28 Apr 2026 11:23:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7295A402A3
 for <dev@dpdk.org>; Tue, 28 Apr 2026 11:23:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777368223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTtNoij8x3SmgcQfRcR8szUvJgRWsdj89puunf0RFTw=;
 b=bdiCOlequ5HsJM2g4+bTV76SzOy8ed+LE9YtKw5a2YvP+pqYWC8cSyhvfgoo/RlLPMYJmd
 ucJxSJO7JbjRO4ZbGbMTI7ETwxDE+zOszQWpikev7BQ4hDlYxfDFuYIUs8TFx/Ufwa7YUT
 eyPzDabn2CJWhN7FSvD7p4SuFdxF4mM=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Xq6-7ukLMCKYUfuAc27J_A-1; Tue, 28 Apr 2026 05:23:41 -0400
X-MC-Unique: Xq6-7ukLMCKYUfuAc27J_A-1
X-Mimecast-MFC-AGG-ID: Xq6-7ukLMCKYUfuAc27J_A_1777368220
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12dd33dc337so1392940c88.0
 for <dev@dpdk.org>; Tue, 28 Apr 2026 02:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368220; x=1777973020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTtNoij8x3SmgcQfRcR8szUvJgRWsdj89puunf0RFTw=;
 b=aUVi+6rI+obtJvyGVhqxMdNLeNGjIHrWOD32SqY6CDJzx1dkG56jaX+5chgQAVF7Jb
 HZYPvDKWPw6L4kPqsh1s926XoGrTxi0aFIp05SFRfa0IKyNRtj+6HOgHxCR13WFJF5dk
 5pLSmal+FPd4m67SxnuS3EbcsCfOHEUj4x4GvFW2ihix9T3dM9n3qjzRqdBuz4AFiPmz
 XzYMGuFXK7JPIs++PTl2GtgPPOxx8aEfyuMQ3+6JePp53SVq00/khpnVhtwqvAlNC42m
 4U+h1LTkw+M8IUR4XY63/U9AyDLQ5VB6toM6RYAWSUqTAc9ls1HwypolTKEh+kSigk7Z
 XLaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7YKuWmCXYCcbDjcMQGM3au7iGhjHiQLgsXR9nWIb7bYm9zIwSJITwffIgvrGgQxS8bjs=@dpdk.org
X-Gm-Message-State: AOJu0YyeiQWxhvJDzpm4vvrP+ldwqVFKqaYZyOOkIPm/cw1ReCobr6Jp
 wtToZ8sOT/KIsxgIYIexfWbfjU/Lgs51PZzRsvWEdZPCGPgwfP8AFimTDLggQIexYoFnW5IgXW4
 46f9IXBGiE90LyH2Zok3sTwiWOIUEuS5e5ne6/xxvQdGBllDamMd3rPp06vR0NZvfwsTne/M48p
 P/OGo3nTisjzAYj2Ycc9M=
X-Gm-Gg: AeBDieuzerhHUOM+kqk8ROeMjGeJKB0xrCNz8m7oQXgAZrcGB4F62vh5cKZelOINDkN
 He9vk3yOx+eAxMT2Cp0eLHdg7IYmIMNo2LS6SmxaNMVYD1CeJBkRkrmVhjodHoj1AYPg+M9/aOJ
 7AdyhG7nac9LjDvBx3zKmwFFBWzEwKOYlupIhSAUngaw3Ko6O7p1ifLmd62IAJwREOEl5GpH39l
 Qb5bqPCZdVJlhgcoE+2qfF/ksskfCHkDMoxZh/AxvatteB80mUKho31hPdgJvjMamH6A11cj7vx
X-Received: by 2002:a05:7022:2391:b0:12c:8eb:80b9 with SMTP id
 a92af1059eb24-12ddda63cb2mr960117c88.6.1777368219942; 
 Tue, 28 Apr 2026 02:23:39 -0700 (PDT)
X-Received: by 2002:a05:7022:2391:b0:12c:8eb:80b9 with SMTP id
 a92af1059eb24-12ddda63cb2mr960106c88.6.1777368219465; Tue, 28 Apr 2026
 02:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251030065715.47304-1-fengchengwen@huawei.com>
In-Reply-To: <20251030065715.47304-1-fengchengwen@huawei.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 28 Apr 2026 11:23:28 +0200
X-Gm-Features: AVHnY4K2gVL8zMaBbWfAwAh9B9vJ2GuafHl1NNG9R6SLVGz43pTweuxhyQOWC7Y
Message-ID: <CAO55cszyJmM-iGYPXOh7UC7Gh831kQA9QCzHi1niyyKmB+=Pwg@mail.gmail.com>
Subject: Re: [PATCH] examples/vdpa: support show protocol features
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, stephen@networkplumber.org, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mriPZYt-aXRGCTvAXYJkVUM8AMupYqduRedyjyO_xs0_1777368220
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000005b4eb6065081c933"
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

--0000000000005b4eb6065081c933
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:57=E2=80=AFAM Chengwen Feng <fengchengwen@huawei.=
com>
wrote:

> This commit adds show device's protocol features in list command.
>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  doc/guides/sample_app_ug/vdpa.rst |  8 ++++----
>  examples/vdpa/main.c              | 13 ++++++++++---
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
>
>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

--0000000000005b4eb6065081c933
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30,=
 2025 at 7:57=E2=80=AFAM Chengwen Feng &lt;<a href=3D"mailto:fengchengwen@h=
uawei.com">fengchengwen@huawei.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">This commit adds show device&#39;s protoc=
ol features in list command.<br>
<br>
Signed-off-by: Chengwen Feng &lt;<a href=3D"mailto:fengchengwen@huawei.com"=
 target=3D"_blank">fengchengwen@huawei.com</a>&gt;<br>
---<br>
=C2=A0doc/guides/sample_app_ug/vdpa.rst |=C2=A0 8 ++++----<br>
=C2=A0examples/vdpa/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 13 ++++++++++---<br>
=C2=A02 files changed, 14 insertions(+), 7 deletions(-)<br>
<br><br></blockquote><div><br></div><div>Reviewed-by: Maxime Coquelin &lt;<=
a href=3D"mailto:maxime.coquelin@redhat.com">maxime.coquelin@redhat.com</a>=
&gt;</div><div><br></div><div>Thanks,</div><div>Maxime=C2=A0</div></div></d=
iv>

--0000000000005b4eb6065081c933--

