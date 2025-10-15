Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75ABCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 11:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1089540A82;
	Wed, 15 Oct 2025 13:46:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9D7C840276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 13:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760528784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHPyASfnvDXwQzVrI9fV8nyZFG1yulab4JSfeUJmDZs=;
 b=gpYYi1/hhW+mwZy17xIH0pq3hY1HoKRFMq0MXC1YHYhZF0VVCIaeAFbLPye8GFWW4b2atV
 PL+RKjYYxvLDYjBo6EgBy9pBC0riA2gcjnr3iuckSPyUcLRSiNlcHGrnvjz/FMCYD8sgjG
 CmU61TXrxNjICSaZzEa96iV9w50MJI0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-HjusmUvGOYCLZtaCnoM89w-1; Wed, 15 Oct 2025 07:46:22 -0400
X-MC-Unique: HjusmUvGOYCLZtaCnoM89w-1
X-Mimecast-MFC-AGG-ID: HjusmUvGOYCLZtaCnoM89w_1760528781
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57a8a75cb30so3440986e87.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 04:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760528781; x=1761133581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHPyASfnvDXwQzVrI9fV8nyZFG1yulab4JSfeUJmDZs=;
 b=XoMN6cDetogvbaELXdsxcbYnH2JHVXL1AoF4FvY1EwKHF7I+9JcxiFirWyA+tt8opk
 /UlWQKllV8e2CCB6HbBhJ07NN2bq1UsptFu0+hl0c6KhKAH8/pPstdr+EYKTU3IMnqrp
 VLjbyka/bbwsfEmwinPbN/amdXEfKUTN3wfaPLtPf/wZ1FXaWpZZMhQS1l4uexEWjpRE
 PNpVZ3jiFAcGXbZrl7H9Nsj2AyWMCvL7eb0Tr18AzjIQUR/qnsfBCpmaYMc43p86FS0V
 CK2e980ihtx99W/gnG1NwOX/EL8XsVjS3qoUvuOQ/e9wi2talOvlpn9spodfXjoTGSXT
 n4vA==
X-Gm-Message-State: AOJu0Yxs5uzDGPuCcKWxWXCRIVMvQVdcsrh2dq/97QBU0O6eJy/cw6rx
 jFJ360Kv/8XUpoq0eN6ii2CB232YhO3NYHjf8LBMqREwnxzLp/TFMoTCcF5L5q7oFUvS9Op006m
 8NwRhzJOHlizaSRVuq4PCIUN0OmK4SHQ1FOfokpvECmnbHxQPQipBwwVY6nzHVbIlCzBmB6ps8G
 YZPTnKSh0tqr/qRwVdXzg=
X-Gm-Gg: ASbGncsJUctjuSVbTjkVyE3+Z3o1zX95E7DgUcK7l0F34XX8qXgkRPuGN5lK+6sgXFm
 1R5/h1/JSR2eItXx1OJ19f9hDYVRY+2QAHHMmzcWnQgdgiiuseytbyUIfGvsyxKnCZUVnc8IFAD
 3RVxDyo4ZgjPh8EUaKg8M=
X-Received: by 2002:a05:6512:33d3:b0:57b:8315:7e13 with SMTP id
 2adb3069b0e04-5906de9b684mr8566463e87.57.1760528781050; 
 Wed, 15 Oct 2025 04:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBzbFZeN+sMrJUAW2zhlR/AK+oFQhC8RAEHbxcHGVZ66/iBR6B4Q7lT6IPcx42SRNYXGzS2ziDcsRcdZy8AU4=
X-Received: by 2002:a05:6512:33d3:b0:57b:8315:7e13 with SMTP id
 2adb3069b0e04-5906de9b684mr8566453e87.57.1760528780654; Wed, 15 Oct 2025
 04:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250619121209.329493-1-hengqi.chen@gmail.com>
In-Reply-To: <20250619121209.329493-1-hengqi.chen@gmail.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 13:46:09 +0200
X-Gm-Features: AS18NWBo2rKfJoEllkCzyBxsIsialmhjgMBezydCBeDU3DAHRgoLn3u4zGBTAZo
Message-ID: <CAO55csxdrgRcEVotDCHg69yHRFj_yOL1JDZp0z=TymQpZ6+4-w@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: Drop unused VTNET_SQ_CQ_QUEUE_IDX
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Lcr-36O9td2h1W13F7RDv_JiTGJ254KDoIrsPAJ8gc_1760528781
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
Applied to next-virtio/for-next-net.

Thanks,
Maxime

