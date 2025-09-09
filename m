Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0E9CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 20:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 845BE40285;
	Tue,  9 Sep 2025 22:02:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E655340281
 for <dev@dpdk.org>; Tue,  9 Sep 2025 22:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757448166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQVG65TJhRwGGPdlto7843w4+qjVeJB3RZqmzGwipZQ=;
 b=KXFcezBqFsCDDrKIghQaFP4oIt431IpkXj1OQq5EDPrM9gsySQWK3daSn76qJvFlPpx+9A
 DHrgluZH/hYvnYCDinCb+eXyEK2U5v8hLGUob4tvARNCZFinqokSBqzYVcmxFqwxvpkKZ7
 n6GVge8+qz+WzYsFfJ+20Ar95fhVJRo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-539cJ-2_MVOjD5hPKETiXw-1; Tue, 09 Sep 2025 16:02:44 -0400
X-MC-Unique: 539cJ-2_MVOjD5hPKETiXw-1
X-Mimecast-MFC-AGG-ID: 539cJ-2_MVOjD5hPKETiXw_1757448163
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55f70a5c9fbso3574034e87.2
 for <dev@dpdk.org>; Tue, 09 Sep 2025 13:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757448163; x=1758052963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQVG65TJhRwGGPdlto7843w4+qjVeJB3RZqmzGwipZQ=;
 b=tepHXRzoZMb6Q4qBFo74AZQT4hmS3/mv17MR2Idp7a3bnzlVAV93Jt0oHtiwxE/MTn
 UXQVdmq5tddtimnc/3ygazK2ArP7RcPRHH5T0cLjI/F2Eaa5/MfAFhE+xOJ9g/rjjZ49
 /34QsGJOsQKfOhlU6xtVrVwiGc7NOL47cvZDVliZPY6LAOBDwXuvAN6vvRn9LzC8177B
 VTkMx3F2PfcbVhEX4OIyDZE9pmEooRSMkRFX/KfW2NnBVzFELVzqI1qyTYQB51P5/f3+
 15dd1Lh+3HgcckVPYxasWbgPpWgLNVPMBGvxMOpe4effkW0ETOfeIbsEzl0dvxA3xgHS
 03QQ==
X-Gm-Message-State: AOJu0YwoyCxGsl1wcJm3dHLmgC8Qt9wVqkLIemBqq3Y3UgJRIWV+PuD6
 X8Nm0yPQK5/KTM6sxCUjoGnbcBoViqlQ2qEy/kfGWOettum3YAA0USVsmXMusctIQvWerTzz6t+
 WROVxIqJE5G6iF+SrD1Hek8VaQiA3sNzrK+m/rArPB68SqSGlJS5bK9zE5hpE/mfJKDC4igast/
 f67s86+wglcIbYn2eBxSg=
X-Gm-Gg: ASbGncsnJss3c9hlzR3lRTKMQTIqAADSQNS5vu7l28MdC7sBqNKf9a0OfkKV315p9OH
 tIL4rrE4/kkqGFtzlo+NPlgauhCRR6wk5TwdOMWygGk/8X0cvZRM0ks5VuyQrAaQaEOCYo3m5SZ
 iroJ1RnMgluXMjKotfLyE0e/M=
X-Received: by 2002:a05:6512:1544:10b0:567:b11e:1d95 with SMTP id
 2adb3069b0e04-567b11e1fc2mr1370333e87.41.1757448162996; 
 Tue, 09 Sep 2025 13:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxpinKtw0lKFgr9J9drMe7tota6lM26uoH5MmUeg1QmhSbvMXAc7PNpwpUeKR1RclSe6A6bOF9ScMDaTtv0T8=
X-Received: by 2002:a05:6512:1544:10b0:567:b11e:1d95 with SMTP id
 2adb3069b0e04-567b11e1fc2mr1370315e87.41.1757448162509; Tue, 09 Sep 2025
 13:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1757433048-18537-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1757433048-18537-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Sep 2025 22:02:30 +0200
X-Gm-Features: Ac12FXwyTpR2p_VzOI_ltLYNT9qk-Z__dsR5z__d9a2y4JrSJmOuDj3u8NttSp4
Message-ID: <CAJFAV8xSDBK2h-7xD2X6pS5MjSMhFE_f_1zWkRMjv4t4aWo6+Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] enable drivers to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hqbh6AAblODgTN3l1Ypvm93_FDbHxY_2grMXoGJCSR4_1757448163
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 9 Sept 2025 at 17:51, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This patchset solves the last issues preventing drivers from being
> compiled with MSVC and enables drivers to be built with it.
>
> -v6:
> - Remove temporary workaround for bug
> (https://bugs.dpdk.org/show_bug.cgi?id=1758)
> introduced in an earlier iteration.
>
> v5:
> - Remove unnecessary parentheses from macros
>
> v4:
> - Add explicit casts to avoid warnings in mlx5 driver
> (https://bugs.dpdk.org/show_bug.cgi?id=1758).
> - Add cast to drivers\net\mlx5\mlx5_rx.c to avoid warnings
> about signed/unsigned comparison.
>
> v3:
> - Add a patch to enable drivers to be compiled with MSVC.
>
> v2:
> - Rebase on top of latest main.
>
> Andre Muezerie (3):
>   app/test: remove use of non-standard array range initialization
>   drivers/net: make code compatible with MSVC
>   drivers: enable drivers to be compiled with MSVC
>
>  app/test/test_cryptodev_zuc_test_vectors.h | 156 ++++++++++++++++++++-
>  drivers/common/mlx5/mlx5_malloc.h          |   4 +-
>  drivers/meson.build                        |   4 -
>  drivers/net/mlx5/mlx5_rx.c                 |   4 +-
>  drivers/net/mlx5/mlx5_utils.c              |   4 +-
>  drivers/net/octeon_ep/otx_ep_mbox.c        |  24 +++-
>  6 files changed, 179 insertions(+), 17 deletions(-)

Series applied.
Thanks Andre.



-- 
David Marchand

