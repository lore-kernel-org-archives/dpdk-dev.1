Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593ACCAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 05:52:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C593402EB;
	Mon, 22 Sep 2025 07:52:29 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 6F78B402EB
 for <dev@dpdk.org>; Mon, 22 Sep 2025 07:52:27 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4b7a967a990so46056841cf.2
 for <dev@dpdk.org>; Sun, 21 Sep 2025 22:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758520347; x=1759125147; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isNh3WTdlXO7kakiuJAA/4SAYdcaPxXt32KN7kRD+vw=;
 b=Cj/+Py93Yu2kDGU5SZ1uuc0znp+oHz88I2KYm2MLD5vcXRAbstqJVJiSCzsH855xBg
 ZKDXhLgBzmlQNjLGjtLCOLM/BgHnT+EkpCilCChyJeBpUxlMh/uHfIPMyRRdTI2SE9dY
 d0R41ws9paxlXtdY2VBQJPKYgptH0kC3sXTwwm1mObP667og6l9bcCuxBBMsnf8bXK6X
 F6fq8tvK9rTfFk0KJ1YhuItCo15e5c9sNU+SL3xIWr2HegJCju1h2eP6fs+JPItgmqov
 3VebbeSBeJ4Nj2ioSUfEjvCwkhUY3PYfQ/lQ9KI1xytUHH7SsBb01COfDpWMQVoT1yyk
 KLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758520347; x=1759125147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isNh3WTdlXO7kakiuJAA/4SAYdcaPxXt32KN7kRD+vw=;
 b=gzwbeO49sJW/1SWuUbzUpOq+jbX1W9kdtvxo4LmZqBcFRFmDPhda9ZtwBhQGnLEtCb
 hFh8+og98ZTqgcwfnvpei0sFpxe51q2LM8VF2jx6T/q1ZZfQzv3M373wi1k9tbDa9T86
 NQ1whv4nKbwRGOl9NKnngZWR5CpaSExTeZocEiRKftSSog+O47tFJOjk/Mbqf2U3OHe6
 cXnEkuBaTXeA6WwoOIbrRBxen8C8ChG5RB8JhYT3H5zbnlY6ARpVdF04EUw4RrdrjI+b
 Vos/y8bfKB6tWk0HVzgsNcW06CN4Ki6bOcGbxU3X/HSe8IOJoNyfY+UChX7W1TfPth6q
 wSrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtzQvLNQZzMEbIb+DQwLnEl3ZSHjZFRknXI41zFP0VHQtbVbPhkN57N04UJGAInMYg4Lw=@dpdk.org
X-Gm-Message-State: AOJu0Ywm4QKtj6cGuVTt23ps8utJbFtq79BRQ2pdGA0vGeVZkSHAncdk
 Ts/XWuyZb+S41EGDsGb8mB9nfUBhVoXvx/3yuRZGnGNWKaWbLYfYg+b7NUjPGDd9n0QTGKy2buz
 vBArRmqxO2sefILk4PvJR2c7QR8PMt/0=
X-Gm-Gg: ASbGncuAkI5xRwTT1xiAn0Qk2g8bEJn1ZqUhJCG6aDpqqhGEes8cLbXXwoOsj9ldRnX
 ePBQPQP/IvMkjcv35GrVfd6s/Upu6/Kc/Snnhir3zPlUisRJym2Rgal6FwBGRXd0Ro1ccdoXUx4
 GMrLyM8fW/8kQBU74HW+uJASgmSYB+6F4RibNz2dM63STzVZTX6fqhw9nX21swneGqcwHLn0PcJ
 kRz3jI=
X-Google-Smtp-Source: AGHT+IGT9geF8XIyiJvLRfj2VvZh05emxjxWb+xOiryvh9rK2sLSE7VLD7xssHh2peXbjnYMoSRNbVEUhvz649Xn5Ls=
X-Received: by 2002:a05:622a:410a:b0:4b5:1bee:f550 with SMTP id
 d75a77b69052e-4c072e280c6mr148879951cf.59.1758520346615; Sun, 21 Sep 2025
 22:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
In-Reply-To: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Mon, 22 Sep 2025 11:22:14 +0530
X-Gm-Features: AS18NWB3x0pn-QlB9h4IZ-Tf3EtBpofp1TJtHDNVVVievDYNdIJ7D29saewNDfI
Message-ID: <CAMuDWKRZDdnrzjJGFpRTmfjcw-z+w+3wObc5bvUANA3JXStgkQ@mail.gmail.com>
Subject: Re: [PATCH] examples/l3fwd-graph: remove redundant Tx queue limit
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: jerinj@marvell.com, kirankumark@marvell.com, ndabilpuram@marvell.com, 
 yanzhirun_163@163.com, david.marchand@redhat.com, ktraynor@redhat.com, 
 thomas@monjalon.net, konstantin.ananyev@huawei.com, 
 konstantin.v.ananyev@yandex.ru, bruce.richardson@intel.com, 
 maxime.coquelin@redhat.com, aconole@redhat.com, dev@dpdk.org, stable@dpdk.org
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

Acked-by: Nithin Dabilpuram <ndabilpuram@marvell.com>

On Mon, Sep 1, 2025 at 11:39=E2=80=AFPM Sivaprasad Tummala
<sivaprasad.tummala@amd.com> wrote:
>
> In `l3fwd-graph` application, Tx queues are configured per lcore
> to enable a lockless design and achieve optimal performance.
>
> The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
> introduced an artificial constraint on the number of Tx queues
> and limited core-scaling performance.
>
> This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
> redundant Tx queue check, allowing Tx queues to scale directly
> with the no. of lcores.
>
> Fixes: 08bd1a174461 ("examples/l3fwd-graph: add graph-based l3fwd skeleto=
n")
> Cc: ndabilpuram@marvell.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> ---
>  examples/l3fwd-graph/main.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
> index 92cdaa1ebe..12908acbba 100644
> --- a/examples/l3fwd-graph/main.c
> +++ b/examples/l3fwd-graph/main.c
> @@ -49,7 +49,6 @@
>  #define RX_DESC_DEFAULT 1024
>  #define TX_DESC_DEFAULT 1024
>
> -#define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
>  #define MAX_RX_QUEUE_PER_PORT 128
>
>  #define MAX_RX_QUEUE_PER_LCORE 16
> @@ -1076,8 +1075,6 @@ main(int argc, char **argv)
>
>                 nb_rx_queue =3D get_port_n_rx_queues(portid);
>                 n_tx_queue =3D nb_lcores;
> -               if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
> -                       n_tx_queue =3D MAX_TX_QUEUE_PER_PORT;
>                 printf("Creating queues: nb_rxq=3D%d nb_txq=3D%u... ",
>                        nb_rx_queue, n_tx_queue);
>
> --
> 2.43.0
>
