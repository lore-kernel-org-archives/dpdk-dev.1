Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F660C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:50:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEDB84065C;
	Thu,  5 Jun 2025 13:50:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E52D140656
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749124257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9An2RWHJ4sczRireU3wYmzHSJ6JKdZOXV/nz9Yo6iU=;
 b=VTQRKuVAAonqhCklB405F0a4z1NK/NCBqMNRUrpQt0EDPyF8SWEdQ2NG0t8vSITDf5T6ot
 ti14n8He08D7oEx+hHXzE8rB7Lb/ScXNMf/zVSVzsEoE8+9XXQajNdcQQYN23gHjrZVaXO
 AvYCuGCcc6KrO1PW1zehI+XWdJYtw/A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-zXPBPrjMPQ6uXFcPpRJ24Q-1; Thu, 05 Jun 2025 07:50:54 -0400
X-MC-Unique: zXPBPrjMPQ6uXFcPpRJ24Q-1
X-Mimecast-MFC-AGG-ID: zXPBPrjMPQ6uXFcPpRJ24Q_1749124253
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5532f32cbdfso436640e87.3
 for <dev@dpdk.org>; Thu, 05 Jun 2025 04:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749124253; x=1749729053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9An2RWHJ4sczRireU3wYmzHSJ6JKdZOXV/nz9Yo6iU=;
 b=sfkv+8ksjD63TcBcFoZrUdty34Gls8HySDLI4K+6iF9mtielkC/9gI1c8bCu54gzz6
 Pag1CYaxMX+oYPaWTXdg9q7TFfXSK54ef+wKwdlWUPiTTeR+8AD69FrDgKQeYk08hLSn
 Aei9/g7UVIdNnSfqhXkat1VBcQwNdtXopP9VWmweHTSwBv3zxoM1m9svMQjuG9QG4G+v
 utJiwLMBRWbrdIf8RO19KDKqVnEV9FB1qKxTq5Xw+kgVsCQwnixLqH5lcOpGrCrBT4rl
 TCRuFkkLQ/D/AiTQ4Tx7tkcL8hP0x808x/MV+BiBXnPnsAtnKa8JIIxw5Ijg33acBDbg
 zKNA==
X-Gm-Message-State: AOJu0YyLFBil75SKOcccAXLWEDb7lhDQVbNJRv83QsDkEazj/txBA1Dz
 6684psHq+fd1MZl7QBqbnglp7kymXjeWFgKlkvOFA1B0FspBi/Hoor0wYFJSbgR3O7MWYj/ZZZH
 rmOowzNFTAoWYZeefeQxNE0DTDMSk7+c+zzCDJfJyXIEBNKgv+beeMZfLJjpC9/79g5blqEHIAl
 NKSE+/QrM7h1JTM+n2nIM=
X-Gm-Gg: ASbGncuTZoLc+wwREXgtfGLr4gkoP7fVdVF5DX08pDcSsUYqTisdavFLwhsGULK9dVj
 6njUCenWzNmiJ0nSi5fpll9jX9ACwmHzFop+JdDrcK5xc683rXxhIqC6MgplbdrXQOvnhItk=
X-Received: by 2002:a05:6512:3f0c:b0:553:2cc1:2bba with SMTP id
 2adb3069b0e04-55356bf60d8mr2194745e87.31.1749124252862; 
 Thu, 05 Jun 2025 04:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFaOYuIQUkS81gVZ77CX2/yKKpSxtWjwlES6iiNPRbaInxhFjyVoz7b1ASkzWcKMeY7SDM1oql0Id/tsvFRAs=
X-Received: by 2002:a05:6512:3f0c:b0:553:2cc1:2bba with SMTP id
 2adb3069b0e04-55356bf60d8mr2194737e87.31.1749124252447; Thu, 05 Jun 2025
 04:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250605113552.918120-1-eperezma@redhat.com>
In-Reply-To: <20250605113552.918120-1-eperezma@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Jun 2025 13:50:41 +0200
X-Gm-Features: AX0GCFtsXVQgPhBZuQyQVM1xvpbEChcZeW9AJxx5Z_rONeyAfXl10h7_KJoIxYY
Message-ID: <CAJFAV8ydHHbbtOYLq4dr+g9qPh52EnNEZU5kieNAY4_BPfsO2A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Search the split vq desc and avail in RO areas
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sDQwGUkjnLX1M_7q1B8XFv1zgQg7AthBY4XMwsH8n6Y_1749124253
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

On Thu, Jun 5, 2025 at 1:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> QEMU's shadow virtqueue and VDUSE exposes these areas as read-only. If
> we don't change it, vhost_iova_to_vva do not consider them as valid and
> returns that they're not found.
>
> Eugenio P=C3=A9rez (2):
>   vhost: search the split vq desc and avail in RO areas
>   vhost: search the packed vq driver area in RO areas
>
>  lib/vhost/vhost.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

At a quick glance, no need for two patches.

Sorry, the implication of this issue is not clear to me.
What is the impact from a user pov?


--=20
David Marchand

