Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B07ACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:16:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00F154064C;
	Wed,  5 Nov 2025 08:16:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F3B304060B
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762326992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKrcHunJQ/DXRB+/mMQvR3otuYV0WV8nzqtkdpRciog=;
 b=dnWxg0acdKqqPg/2n8HK76J0PKQsX2PDwAPuBqYXGsq0Ygws+cBfN6dmbppUsfXyHb7slp
 K6phH5nlZIEA31LafqDuh+IGnqtQIfuRDiPTYaEjdOiP9eedwcCIp0IDfAONbhlCjiLLiB
 g208/M5rZTZ/Hn47ONgdIuTl37H8k/s=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-jQ003QDZM6CAX5enLzg3Gg-1; Wed, 05 Nov 2025 02:16:31 -0500
X-MC-Unique: jQ003QDZM6CAX5enLzg3Gg-1
X-Mimecast-MFC-AGG-ID: jQ003QDZM6CAX5enLzg3Gg_1762326990
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-36d99707249so32514511fa.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 23:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762326990; x=1762931790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKrcHunJQ/DXRB+/mMQvR3otuYV0WV8nzqtkdpRciog=;
 b=XvxECpKpmy/Hlm8oFHqgpTtbYhF0TH4HEW7EKqmo4MCkFZlJstiU97ihVGlxlRWCY0
 r8JPbzFYiWgq2biOHBd5uL8CozkhjiNWxUdq3lf5y6jg+g9BK9QsfiP9h6fyHbPrQH/I
 Dk6TO70NOFWViAF9zZnr/iXanGB7D0Oja3P2gdgLozkK6TnZ3Y0V1ivSB2rI2txCLyYR
 sd3KBUtuo6YFqvdBPF1HuIycu0JbsD9JHRXKdffIhetGcdibtWAJ3Jm8wLF6X8JmtFlG
 k0FwjyIRkASZ7VCeS8tW4SzcjB9YJLN1dC+k7eJxqKweoe4ZVZEQJPX3VVyjItIlPZ40
 ci2Q==
X-Gm-Message-State: AOJu0YzjANa8Z2z8oNTiZQJ0BN5pcWsoegPDcfwjxCr5niLBovUVuxKS
 YLHXQRhWmRmAu18/w0AASBproHwPQw+WcdzXwtE5ngl5E56DYYlZizrs/2Jghhd2hyXcv/2s8ye
 Fur3mX8SZ10SZBJibdp6or+CjL26aJ9k1av8v2wCF7F0pjIesZwhvSI5Ku+Kwh0olOCkTAMQPri
 ndQWukKP/zNdAkVpYzdpc=
X-Gm-Gg: ASbGnct+JiOpmDJss0LKSTz4REAhyx+hTQYNLn68hNWZ4wBor491mIGxl0zYHdGe+pQ
 KC4Py3YbNYv+dIUBFU1NnuToIusYYBIv7mjyP8QE98NCiVd/5sYrpj7qVoc/xWUGes0Vb71AQX7
 yeMpGJQpNMgtCJ6iNGv4k7H6xyQZAV7DtZDWykv28OqnQ+hYM6hmj3AcAHvg==
X-Received: by 2002:a05:6512:3ca2:b0:594:2f72:2f9b with SMTP id
 2adb3069b0e04-5943d55d6camr619550e87.2.1762326989661; 
 Tue, 04 Nov 2025 23:16:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEUaCGUXrn0zGUltuBVdaYedGaVXYa5XyWdkgvQp+9Kzp8CxT1rpUQt0DFC6rahxbhkjFCwK8FJmvEi0uWVvE=
X-Received: by 2002:a05:6512:3ca2:b0:594:2f72:2f9b with SMTP id
 2adb3069b0e04-5943d55d6camr619540e87.2.1762326989217; Tue, 04 Nov 2025
 23:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20251104130820.2692144-1-david.marchand@redhat.com>
In-Reply-To: <20251104130820.2692144-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Nov 2025 08:16:17 +0100
X-Gm-Features: AWmQ_blhhltLbTYnD8BVlTMuBr3xor9gV0k0vfupWMEc5kXh10mAfwzEW-xx_uk
Message-ID: <CAJFAV8xYP2oibRu-fpQQgHFY-MpgWmQGWs+szxkBtEyatPiyFg@mail.gmail.com>
Subject: Re: [PATCH] eventdev: fix build with clang 21
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, 
 Akhil Goyal <gakhil@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>, 
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QcbjXrppakyhoSMBkarBFRlt6NtifJJ1FIE4mtE_Vyk_1762326990
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

On Tue, 4 Nov 2025 at 14:08, David Marchand <david.marchand@redhat.com> wrote:
>
> Fix 16-bits formatting issues reported by clang 21 on Fedora 43:
>
> ../lib/eventdev/rte_event_crypto_adapter.c:1461:4: error:
>         format specifies type 'unsigned char' but the argument has type
>         'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
>  1459 |     RTE_EDEV_LOG_ERR("Failed to get adapter caps dev %" PRIu8
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1460 |             " cdev %" PRIu8, adapter->eventdev_id,
>       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1461 |             adapter->next_cdev_id);
>       |             ^~~~~~~~~~~~~~~~~~~~~~
>
> ../lib/eventdev/rte_event_crypto_adapter.c:1592:46: error:
>         format specifies type 'unsigned char' but the argument has type
>         'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
>  1592 |     RTE_EDEV_LOG_ERR("Invalid dev_id=%" PRIu8, cdev_id);
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>
> ../lib/eventdev/rte_event_crypto_adapter.c:1613:45: error:
>         format specifies type 'unsigned char' but the argument has type
>         'uint16_t' (aka 'unsigned short') [-Werror,-Wformat]
>  1612 |     RTE_EDEV_LOG_ERR("Event vectorization is not supported,"
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1613 |                      "dev %" PRIu8 " cdev %" PRIu8, dev_id, cdev_id);
>       |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>
> Fixes: c1749bc5ee10 ("eventdev: introduce event cryptodev vector type")
> Fixes: 04ed18cd41f1 ("eventdev/crypto: support runtime set/get parameters")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

