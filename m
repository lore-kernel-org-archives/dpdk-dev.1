Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B69CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:04:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 136724042C;
	Wed, 15 Oct 2025 09:04:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 596DE402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760511889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gs2mj7vXhIhV8ZKAVZGhdl9+kG22zLGLF6FiG31GCNo=;
 b=KSk3gwsRdOUCvY9zPbnptQGCEy9s2V1GRk+2US0EjaecKKqM6D1DS7UyyvXz3pxDXGBamV
 jCvzZjQqabRA2YW85sVs5MLGwm28ZCUKje26ekHM+jupYTqWydcRd4qAiRL/VS0aL75rp5
 5/5lltmQA0riayeEzMMbbHHMrJ6XaMs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-0dj8WJt5OIy5KD76vCnV-g-1; Wed, 15 Oct 2025 03:04:48 -0400
X-MC-Unique: 0dj8WJt5OIy5KD76vCnV-g-1
X-Mimecast-MFC-AGG-ID: 0dj8WJt5OIy5KD76vCnV-g_1760511887
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57da66e0dc7so5130030e87.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 00:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760511887; x=1761116687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gs2mj7vXhIhV8ZKAVZGhdl9+kG22zLGLF6FiG31GCNo=;
 b=R3npYU4hWZIcU8DhhqiKhzb5Lb7W9r9LdwqBwYDaja7zfR/hNY1oqlPPl0pHnX3+xp
 nhgLrnwwYVjBkNybT8GxrJRISgCpiMQgE50m8bCLEG2zv8NIQFKMNBwqxxhL3MOgGMWI
 sETH8cFED/ZaLfljv3Czk2nuDrGu5WIjVdIoQYk9dJWxafXBrf6U3vRiNvgOaQLzxFrV
 tvnZKi1DZJ5Dvmp1AIW/Ug9MxVDE3T9sPlh7pfboE6WgNH3DpOHqc7gnTbipxopIylLC
 /MS3n69w/TyOQQUIHI5rocvV8ogsS2uWYPZpmtGurh+xNcwzO8wmOfvBM4fBfII1ZO/W
 2IeQ==
X-Gm-Message-State: AOJu0YxrP0G5a0hztpAcrdPEH/h03FIdlqHxqvOEKMsnzC93Z6UulNHq
 CyCq60kHsqlTczQ1MdUoegSYqmxjf9cANALJrATWW4p6ntDMZUAZhKK/vfjH2+DRwI1KEt9hTZA
 jbE9aXMQQEGc0X16rQIUmfdc342rOxBIqIl1NzFNCycN8BU71N3DAuu/4v3vY9dbibyDZyjFMn0
 54gQeM2EkP/jRKDcUvFh8=
X-Gm-Gg: ASbGncukC5GYj36aydA7D+rqBYMVb5KBruzrzUfC5CzAPr5WePnCJAHkF6p/KjN4Suw
 kcR31qhJeTFY+MrfPj0qOUrKnmlVwIfCx4DijhCVXabMsA0CcEVfoJDiYK8FP1eQS/fya6lqeJR
 Nq967Toyc3L5slmvC32dE=
X-Received: by 2002:a05:6512:3503:b0:564:2556:5bb8 with SMTP id
 2adb3069b0e04-5906dd53fd2mr7746492e87.37.1760511886928; 
 Wed, 15 Oct 2025 00:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSFBhVpd0PThrnBdqsOHEeCqmrG9k1u2QTNK/dc3SMg057bCDxXbZC32GmazQ5la9zn4TG74P6GXyMBDixCgc=
X-Received: by 2002:a05:6512:3503:b0:564:2556:5bb8 with SMTP id
 2adb3069b0e04-5906dd53fd2mr7746481e87.37.1760511886527; Wed, 15 Oct 2025
 00:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250619115445.257679-1-hengqi.chen@gmail.com>
In-Reply-To: <20250619115445.257679-1-hengqi.chen@gmail.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 09:04:35 +0200
X-Gm-Features: AS18NWD_e-nKOnIqGatCebP39rMgq5LFGB8kQAaS1d2WrI3CYbwdxTozl2yzzNg
Message-ID: <CAO55cszXsh8Y55s7wTwSUQpugRH_Nj=KObwKDkh=kPXzuz4QeA@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: Implement {rxq,txq}_info_get callbacks
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 81TRtBrBbQPUsRIXS3SOoyyENzyjJTfja07PW-RgpB0_1760511887
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

On Thu, Jun 19, 2025 at 1:55=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Currently, there are no ways to retrieve the queue size
> set by vhost backend. Implement the {rxq,txq}_info_get
> callbacks so that DPDK applications can use the queue
> size to setup mempool properly.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  drivers/net/virtio/virtio_ethdev.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

