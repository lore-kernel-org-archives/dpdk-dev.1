Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9751C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 17:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E8C40691;
	Thu, 10 Apr 2025 19:05:08 +0200 (CEST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com
 [209.85.219.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8A26F402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 19:05:06 +0200 (CEST)
Received: by mail-yb1-f178.google.com with SMTP id
 3f1490d57ef6-e7040987879so868026276.2
 for <dev@dpdk.org>; Thu, 10 Apr 2025 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744304706; x=1744909506; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+qhY5aVK3SUkUtNXROMc1SiRBWNLZ50N/+CQulkAMA=;
 b=i0n1gzuDr/EjSKDJrh+lhgBtaO31MSwxqpxKOaiUq63WKViOkCqak7uq/WDngC3/tT
 L0SAW+29gY/kAS/1TYntqAlCKhDWnziUY18OW8h+g/IRcERQMaVpRIfZORNoDcHSJaiT
 9HKqVETCsGrApGxA4Nd9uH88fWBxa5jta8FLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744304706; x=1744909506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+qhY5aVK3SUkUtNXROMc1SiRBWNLZ50N/+CQulkAMA=;
 b=HdQPxLZI1GVqJ0HzyIdO2mZ1zB935cc/jb8tmwADPUMtR8NxC5EqVTgQ6c9VuHnnjp
 TdURhlrPlWOzzsFG6FU81XPgmR2JBOmzIyjsawObv8URZ6Mx7mZG63cvwIborV24k06M
 Xz3Tqv6a8m7tJOVke7Ip3ILpv64KvBQsIan7Dj1glZDXjWUtkmqmw8h7aJymBIVhs+aA
 0XA9ft/WKL8QNVQrVVF5UaNjph3pSZybPEt9AG5z87seB4dmSsRQmNW7sLfbA8nk+cyf
 RaFUZXhz4xW6m6kt0tx9ZShlfHeWBDAWlngPIq0eOnopWUoC6N8+VVB8z9OfopHFUq98
 YbvQ==
X-Gm-Message-State: AOJu0YytgsEd9rEgQsiOvHo8vbsh2BHeIAB4maA2Ps5IXzouOqBRn4RT
 cz75RKnFzAN64mZ0TBW3NHLDygkXWuoUwHj+Lv9ndxJbt+sKy4EzCslCj+0vUKHQC4DGtIIORem
 DFRxiywYpFvyT56W81ypX8+7bJn9wVIVCDLgEBg==
X-Gm-Gg: ASbGnctvb0TWHYABvUo2ejG3lFSjaGPEVvMEEPUV/e4yAN4Dfyw8vw1WYy6KePQALpE
 UeEa8qdujDwhaogL45sLkTDxsZDXgC377oitIeqSzB9QkDcDRHXaAcwhWOd9VqUZ7iuOpzBWxQb
 i2kVoC2xhhQRHqRSREuKFdSKqEaacLalA4qHI3JcoBmkg064bPnAxrN9Fn
X-Google-Smtp-Source: AGHT+IFJ7lzcJtJkFuSpX2GqVMINsudotd496sBJ+AFVfSy56YQ/r35sigagieTrkilB/3ttwWgPYEsR+HhD5IAKu9A=
X-Received: by 2002:a05:6902:228d:b0:e6d:df6b:60f8 with SMTP id
 3f1490d57ef6-e703e1e7298mr6120041276.33.1744304705898; Thu, 10 Apr 2025
 10:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250331155800.449823-1-thomas.wilks@arm.com>
 <20250331155800.449823-2-thomas.wilks@arm.com>
In-Reply-To: <20250331155800.449823-2-thomas.wilks@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 10 Apr 2025 13:04:55 -0400
X-Gm-Features: ATxdqUFhEl11WaUgEuWVKuUoceu79PJhStXgJN4Dt2lVphiZC0Jq-7gNfMZDsPU
Message-ID: <CABD7UXOvafW16tvnz4oKX7u2LCCfyDebcPxZDcvYqoa2s5K=YQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: add packet capture test suite
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
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

On Mon, Mar 31, 2025 at 11:58=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com=
> wrote:
>
> Add a test suite that tests the packet capture framework
> through the use of dpdk-pdump.
>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
> Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  .../dts/tests.TestSuite_packet_capture.rst    |   8 +
>  dts/tests/TestSuite_packet_capture.py         | 358 ++++++++++++++++++
>  2 files changed, 366 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_packet_capture.rst
>  create mode 100644 dts/tests/TestSuite_packet_capture.py

<snip>

> +    device_id: str | None =3D None
> +    port: int | None =3D None
> +    queue: Union[int, Literal["*"]] =3D "*"
> +    tx_dev: PurePath | str | None =3D None
> +    rx_dev: PurePath | str | None =3D None
> +    ring_size: int | None =3D None
> +    mbuf_size: int | None =3D None
> +    total_num_mbufs: int | None =3D None

One small thing I noticed here is that you're using Union for the
queue and pipes for the rest of the declarations. queue: int |
Literal["*"] =3D "*" would be the same thing functionally, and it would
save you an import.

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
