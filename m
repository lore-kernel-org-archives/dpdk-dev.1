Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D886C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 11:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CADE40144;
	Fri, 16 May 2025 13:32:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6FD38400EF
 for <dev@dpdk.org>; Fri, 16 May 2025 13:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747395147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDqEFRTnPof6ipHh2a0adLkbcurlA3qUw6KcyhQZsbs=;
 b=i2bVtxYbq5mshjPCj/QK8KdZwlqcSRUSnuMuYJTgVL00/xFae1D5DcRbxZbngbd17k5eA8
 0tsSGKYxmY5t5fm7trxrZYTdVbOzhmk7TQNe0r++G5RI5S/nAdL/HNV6ucmc98CQUyth+9
 ZG5UIZopSJKAYTsDsHMJVVRJpUn9t1E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-mWqy0DidNS-t6We2i3RJMQ-1; Fri, 16 May 2025 07:32:26 -0400
X-MC-Unique: mWqy0DidNS-t6We2i3RJMQ-1
X-Mimecast-MFC-AGG-ID: mWqy0DidNS-t6We2i3RJMQ_1747395145
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-550ea022c07so314710e87.3
 for <dev@dpdk.org>; Fri, 16 May 2025 04:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747395145; x=1747999945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDqEFRTnPof6ipHh2a0adLkbcurlA3qUw6KcyhQZsbs=;
 b=YQPCCSLHiSlOtfVrIEl2dt4w4zVvxRCPA9749M5TyeVYxKRr+TVon0P8/pAM40gSF1
 4laMBTLbocKIS3sGtGulIFgtG6WsMz8FzNRpfHYuhDVTwPBz66Zk4h0IKfQuT3InpNXX
 QaQm4e7Im2ujTMsGXx4ahlsgMGbm0YoqfOtajvvuzuWpQ2Ia5xjVDyoY5yeXzw2or9S7
 GPF2mzcwvqhlN94fVYocH8VzBQK196GSq8hPvz8A598HgVj4BQh4+M0hDTkSTSOI5vvG
 VYh0cVlriGX9A8dAs4cf38Hy/kwT9ol/7c0lLLkrvj1YsPfH8byo0CEkyBFPN7XditlW
 2B7A==
X-Gm-Message-State: AOJu0Yw5as7pMju4H5yhiSs03X13w21AhpWN6MmZ1PHuCSRQDTaC/+7p
 OcvPjRm/ql+TSXcfWqWJL/t1Kr2MD9NtBulY0AmXV6MxO4XxMbhZxWLmtpX6ncy7GbD1gKX2D6+
 LR/BnvZdtEcBj8ubu6VJcqY2dgyfAd+g8FyHj2xxC0nyBr/W2hEClZGkll1Ixl3A2Q+inkwk9vN
 7/IErgszgEdesPYsgbj6U=
X-Gm-Gg: ASbGncvPppWvRRVjhy5umZccqGUcGct7XeL4PBiEQIOhaQdUXljjtnik0huPpit2oKS
 5zxWtOGsshMgh7Ib4zvZxCKiFjwYSeQoXF4ps1n1cjYuzIi+QykxEQ9iZwKgqIqdG1/ATbeg=
X-Received: by 2002:a05:6512:6288:b0:54f:c221:c218 with SMTP id
 2adb3069b0e04-550e971af19mr521951e87.2.1747395145216; 
 Fri, 16 May 2025 04:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxFdXo9reVS+HFnjydT4ICs3lDGQ37UWGn9nztGftiElMDLegKmVmGGh31eZM5MXPXKHN6upYq/c2BaS3MJU8=
X-Received: by 2002:a05:6512:6288:b0:54f:c221:c218 with SMTP id
 2adb3069b0e04-550e971af19mr521945e87.2.1747395144798; Fri, 16 May 2025
 04:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
In-Reply-To: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 13:32:13 +0200
X-Gm-Features: AX0GCFvAdVI8_Vji0pcBumBEaI4va_lsRqKOMsIMZFI1eSvF2W_BlD7UEoQ_rew
Message-ID: <CAJFAV8yDJd+_OArqT_T2PRcjnx3pCRboAb1hub4LwRCjZjocbg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Linux Kernel uAPI headers import
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ugh-GRHsJwZb6yE9ozsb8webF-mj7XSWNDqurf-hoPI_1747395145
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

On Wed, Apr 16, 2025 at 2:34=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This series documents the license exception granted by both
> the technical and governing boards to import uAPI header
> files.
>
> It also imports VDUSE uAPI header file from Kernel v6.14.
>
> David Marchand (1):
>   ci: check licenses
>
> Maxime Coquelin (3):
>   license: add exception for Linux Kernel uAPI headers
>   uapi: import VDUSE header from v6.14 kernel
>   vhost: use imported VDUSE uAPI header
>
>  .github/workflows/build.yml     |   1 +
>  devtools/check-spdx-tag.sh      |   2 +-
>  kernel/linux/uapi/linux/vduse.h | 353 ++++++++++++++++++++++++++++++++
>  kernel/linux/uapi/version       |   2 +-
>  lib/vhost/meson.build           |   5 +-
>  lib/vhost/vduse.c               |   2 +-
>  lib/vhost/vduse.h               |  22 --
>  license/Linux-syscall-note      |  25 +++
>  license/exceptions.txt          |  17 +-
>  9 files changed, 392 insertions(+), 37 deletions(-)
>  create mode 100644 kernel/linux/uapi/linux/vduse.h
>  create mode 100644 license/Linux-syscall-note

For the series,
Reviewed-by: David Marchand <david.marchand@redhat.com>

Series applied, thanks.


--=20
David Marchand

