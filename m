Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9E2CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 11:47:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EDCE40A8A;
	Wed, 15 Oct 2025 13:46:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1519240276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 13:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760528818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8N5lfQsSf0Bc0UrUWJxdBQMFUii35Hxhk2A65RclRw4=;
 b=Q94VkGZAMGRh4bqLTpPT5XEAo5KDRimOUG62cyz9WhyyYlCsZygvq9C9XVIy41GW959b+j
 WX3MPdpDoayijzV7//XmXIE5HfiQgO8QdjQ0rDIFVl9K1Db2h/dye9Z76cQohSuvcAndoJ
 NvQEz/p5GZz95enYSCNOfpCmu7ybR38=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-JR_cRGCrNAGnatiEoQ4PTg-1; Wed, 15 Oct 2025 07:46:57 -0400
X-MC-Unique: JR_cRGCrNAGnatiEoQ4PTg-1
X-Mimecast-MFC-AGG-ID: JR_cRGCrNAGnatiEoQ4PTg_1760528816
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57cd230eb72so3929786e87.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 04:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760528816; x=1761133616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8N5lfQsSf0Bc0UrUWJxdBQMFUii35Hxhk2A65RclRw4=;
 b=hDL3muyjZtQ+PKYcYRjSVCKqc8IVjZxdDQNTzaVv7Xwq1Aop41cZMDbuKwNkJoXmH8
 uap6atCf/BfQxdoE0iD2oTxtUShECBWiL0N/D77ml23d16NFb83CurHxxTTPRSH/xZgk
 G/D0Zrfdtw1G6QdSrZvwdebKfj+tAFVcyAtEcF1lP1BF+vqrE959INVtWz0oRxKdam0G
 yyEvKCGeX6q6H0JYxoNogFhQFyX3CLh/V8cJ27PbKSvBoFbgH56Hpw7Sgo6VvX1qO7nC
 H/z1URa/J5rRlf4WdsuGnbnjmMfE+W2IvtgurtP1IqdasJJJsUnaLN5El2FffqZaB5so
 9Dgw==
X-Gm-Message-State: AOJu0YynJULNsT7Zf2dhh/jF9KE2yML9UW26yhPxTd9jJqVpLOkm2KRW
 xPm6EThPUO24DLYMvsc2KOBmeadkae69QSAFWHIi6Y69hPm2JnhG7YPLHki+O+pzb04rK+0bck0
 Y2E/RWT9zUmQODkXeXt2WW5ySk/lerUAxHCdfO893zwugLfc2aNcKJ73teIyoy+w61Cwvt8enny
 Cs3Ox+vPPIcWuOY12/+CY=
X-Gm-Gg: ASbGncvzx0TwQIPBT95TRrJJeh4ExZeXApmPDjFwut0HKhdIKIuGMIMBW7z8zmpPsmL
 /SdJ/eqETm2IvcQMvcNY6EoLYyfJQtVVDW1iw4/fT1HVuA6+OYmSuzrB6Tg1kYW4U4dLVmBJhpj
 Fw+tk4N8bkK8WB5CQTxJs=
X-Received: by 2002:a05:6512:3ca2:b0:57e:54ab:56a9 with SMTP id
 2adb3069b0e04-5906d88b0c1mr8182095e87.20.1760528815974; 
 Wed, 15 Oct 2025 04:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9LRhBd6Vx4dAy+h6qO5fjiZpLcvX/CxTlz09x7RBE6Ya0EhhYSwdpmAYJtZ1UWCQSqcYzCeR8ST2nIk4nE+8=
X-Received: by 2002:a05:6512:3ca2:b0:57e:54ab:56a9 with SMTP id
 2adb3069b0e04-5906d88b0c1mr8182080e87.20.1760528815547; Wed, 15 Oct 2025
 04:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251007144754.1690606-1-maxime.coquelin@redhat.com>
In-Reply-To: <20251007144754.1690606-1-maxime.coquelin@redhat.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 13:46:43 +0200
X-Gm-Features: AS18NWDLlcXvIphllimEOM5Efv3SQYuP55NGhq_o2NcfbSBsmXxfGY3SbLtETo8
Message-ID: <CAO55cszACiU0MvP2dz1wF=WZkMsidpnejHvkzfK35LLFRD4SsQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/virtio-user: fix used ring address calculation
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, amorenoz@redhat.com, david.marchand@redhat.com, 
 chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G-7Q_JvYXRm0-f2Y3kg_HnjTQSMUIBDCwg7WSVYl-p4_1760528816
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

On Tue, Oct 7, 2025 at 4:48=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch fixes the used ring address calculation, to
> avoid Vhost-vDPA backends (such as VDUSE) to fail while
> trying to translate it.
>
> Fixes: 666ef294ddf7 ("net/virtio-user: share descriptor IOVA to backend")
> Cc: stable@dpdk.org
>
> Reported-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>
> Changes in v2:
> - Refactor addresses calculation (David)
>
> ---
>
>
>  .../net/virtio/virtio_user/virtio_user_dev.c  | 30 ++++++++-----------
>  1 file changed, 13 insertions(+), 17 deletions(-)
Applied to next-virtio/for-next-net.

Thanks,
Maxime

