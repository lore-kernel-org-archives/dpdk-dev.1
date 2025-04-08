Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA51C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 07:58:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C052440A89;
	Tue,  8 Apr 2025 09:58:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A5F824027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 09:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744099090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDv4LvZeeYMrAaPzhKwBg03pg0YD9GHtrT8G1+FaPOo=;
 b=SJqqe6GdT6uL0LqurGRNGjgD6wsEt2ATTQmWvS4oQ4mw1Ub+oNjIng8mz0UyZMq6PxxJEl
 pQguuxpDdG3mcc8uBYS6SSsSJNHNtbR0FeKW1f2YAVQeQKvkhl6wAPaXmGs2wnvtgzVdEx
 j0m/iTw6mNxzhvobYNLuAkaxv6spaA0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-p1bVjGKwO56t9aHQW41dgQ-1; Tue, 08 Apr 2025 03:58:08 -0400
X-MC-Unique: p1bVjGKwO56t9aHQW41dgQ-1
X-Mimecast-MFC-AGG-ID: p1bVjGKwO56t9aHQW41dgQ_1744099086
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30bfd03cdf6so25555701fa.1
 for <dev@dpdk.org>; Tue, 08 Apr 2025 00:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744099086; x=1744703886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDv4LvZeeYMrAaPzhKwBg03pg0YD9GHtrT8G1+FaPOo=;
 b=SwUOXGldgKYziNLKFSaOfeOsiFMSRKs2t9feje1XzCQuri3HiNoypq7RlRWGjzb7jo
 6UnHmZgmSm+nqmLFNJ6T8dyafKVs3aRmATSEWwk7ZRdh+2zIDufarWwG7+3qpyDy0/Iz
 xKwe3Vg7MSGkrTUXSQKGBuOKk8NaMZnSZwLu8L75KYPI7xFI0xzl8bMp+266g3oOYbbC
 EI0DcC/U0vJJwCOGTq1IMqj1fr36Fg5y19oVQvx4/E4P/8ALzBbEEwne6Qd189TDHhNK
 vhmoBba3Ogi0zh4K33x57XmVyKNRmli2hLS9xtbXG77/P6EFYr7YfyIQ5OrG+XaiChoY
 spvQ==
X-Gm-Message-State: AOJu0Yz9BynUjMSTefPTxsqLZWpbzK2rQkGCh2uNvF508t4gz/e54aOX
 Ea2acg7ZrCFjKpgFwYIL3grUCiakZw/wSrwC/FxuSr3Ey952my0/OReUc/YEVMRKJVu4DRePCTI
 1x0FTOdYt/9XZy2mII/dooVOWcBbcWL8CIsRMfQDDdYzJjwLwaC3fwCcF8zbDmaLlhdUyVLVZOY
 F1iCkJxXuHLfd0TFY=
X-Gm-Gg: ASbGncu1vQqN2hs6SoK0amICU9yxy6gESsQxAbxjjHeB887sSNgdnkAn6DqEri2TAT5
 Umhf/vN21chfkv6xfUNV5Ea+KLQ8+Yehs9YFC3/88tNPgStqqvvBIHRpONwQGam1rVGsSA9TWTi
 o=
X-Received: by 2002:a05:6512:1328:b0:545:2eca:863 with SMTP id
 2adb3069b0e04-54c29836e84mr3432484e87.42.1744099086405; 
 Tue, 08 Apr 2025 00:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTATnhS3F3QdRDqMQTGXMPyWONXBYhkiF5iq/ktRi4gzJvTiaeLCVjtU/bvnNKW0snQ8SpiQfr8/GhBxFoG6M=
X-Received: by 2002:a05:6512:1328:b0:545:2eca:863 with SMTP id
 2adb3069b0e04-54c29836e84mr3432479e87.42.1744099086099; Tue, 08 Apr 2025
 00:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250408074718.1322823-1-thomas@monjalon.net>
In-Reply-To: <20250408074718.1322823-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 8 Apr 2025 09:57:53 +0200
X-Gm-Features: ATxdqUE6g2Chkr3QMks4RKcMlPKXYpocgv75YR_HwIa8LlxJM-_SUkw17Alixgw
Message-ID: <CAJFAV8z0dMFK0Vh8A=xxvQZnSJoJLz8e75bnsemwNwQoQUh9ZQ@mail.gmail.com>
Subject: Re: [PATCH] common/mlx5: fix build on Linux in dlopen link mode
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Ali Alnubani <alialnu@nvidia.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A8epr-u0nivNRJ_SBCD_2Ms7hpMr-jYVT4ldr_TiW6k_1744099086
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

On Tue, Apr 8, 2025 at 9:47=E2=80=AFAM Thomas Monjalon <thomas@monjalon.net=
> wrote:
>
> When using the Meson option "ibverbs_link=3Ddlopen",
> a glue library is built.
>
> After the recent change requiring eal_export.h,
> the build stopped because the internal EAL include directory
> was unknown to this glue library:
>
>         drivers/common/mlx5/linux/mlx5_glue.c:19:10: fatal error:
>         eal_export.h: No such file or directory
>
> Fixes: c7020bb20fc7 ("build: mark exported symbols")
>
> Reported-by: Ali Alnubani <alialnu@nvidia.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

lgtm.
Acked-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

