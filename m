Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3739CC5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 09:30:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DB0E40275;
	Mon, 17 Aug 2026 11:30:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0015E4021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 11:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786959000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IL2s/OGzi0A8EvjfMXVTFOlE8J9mJnNQyyq/M97fS1Y=;
 b=R+q9bCD1N0jyVnGRf4JSgZV8uzerTc3peiJoXhUgWT7NRJGPL7M2rc5vMc+mrwACo4buNv
 lP6uK+fcrg1fOI+CCDWfPw/8wUSwK1w50uWjyUzCfol9DxB+xywGtLNyFjq/+zQwC7JeAb
 g4QAgOauuwrdCGBwccSPDJM5DOvV5e8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-jUbNYYSlMC2daRNBWktKxA-1; Mon, 17 Aug 2026 05:29:58 -0400
X-MC-Unique: jUbNYYSlMC2daRNBWktKxA-1
X-Mimecast-MFC-AGG-ID: jUbNYYSlMC2daRNBWktKxA_1786958998
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so2769332a12.0
 for <dev@dpdk.org>; Mon, 17 Aug 2026 02:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786958998; x=1787563798;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IL2s/OGzi0A8EvjfMXVTFOlE8J9mJnNQyyq/M97fS1Y=;
 b=ZQox6xo9uPgvIZYl+JimZ57e+OBIHATUKuukwcnZXE9Ba3ZU9fCbrRY6f9QWz00vUS
 7xTKXN4pU9t8V/EaLD52PbWtu0PN+zei5jbnrs6Zb66DF7gSI3scj6gZcAieva2j0ZmM
 eXdiOSqO69VGK28wvLoa6IW5ySB2UTV1/p9xBvIahQwbW62oNWsxnxZjb5NxooImFrel
 7XIM1HYrICOnsRhou/35UZXHGqnOLt8V6qqjuHMsv+rZSeM4wEXQ/cTnjIPRWrLMxtoR
 9Fr7aMfYpd7FO+JEDR3Id188i0QCYJksucQoSEyjzwlYzNLGESTan1I38/ouvW7u428y
 KlvA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr07BC8QPQ7p2tuoHGUAB4z2GxRGWt4CUkvk9nlH0+jKYT+wioImF102Rb+w9uGY9ozW4s=@dpdk.org
X-Gm-Message-State: AOJu0YxiwZ7LPOYEtZKhsDHO3BRjJdSBH8YktHqAmi5shwtL+uuVmboL
 Wy6/7GDhJvmQdXWt2Kg5SpcH+0Yx0ADxOCx9fjNtYSJDa9F0PyeWptQm3tiG4P/huNgRVqzYC8I
 XvPrzODMKGV3/qk18bKJOuTu60Ql2Fz9zeXC3rpW5rjfj/Xv5g1ShBKwFw++cVLaG5QJnMBPtFL
 iMk2GRq8cTOwZu8LHuRJI=
X-Gm-Gg: AR+sD12i0GLgTkLPcBwk/Z9mLA0NKgLOkM0dCKLMuUS+egpNwt3QHgUBkPw+85kO2cz
 Hu02H6u+m7vf/ECM1i0ltpYkEF8Wrf2qVL5XyI7534SyVp8ny5hr4nxkVVd24/2/1vH+iIcdrXv
 WrcXuddxxmFxUQs6M8J2R+H3mS5JSgNBswQK4Zs61wiLUiAlSRNxdxlsHeAaCUd7heiYvtIDYZY
 TLH/or9/PHMZUj5ymWSk5Wu9RXRXTHPdSfiz5naUvEuLNBN++ZjWUlXTM1hZg4bWfgGtEsthYs2
 XHDcK3Kn1DP0sOn+EoXE7g8qmPeAeodkLWAZJ/HarMw=
X-Received: by 2002:a05:6a21:1f88:b0:3bb:2883:a723 with SMTP id
 adf61e73a8af0-3cc720a1c87mr25520105637.35.1786958997661; 
 Mon, 17 Aug 2026 02:29:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f88:b0:3bb:2883:a723 with SMTP id
 adf61e73a8af0-3cc720a1c87mr25520052637.35.1786958997232; Mon, 17 Aug 2026
 02:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260701061412.154739-1-wangliangxing@hygon.cn>
In-Reply-To: <20260701061412.154739-1-wangliangxing@hygon.cn>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 17 Aug 2026 11:29:46 +0200
X-Gm-Features: AcwNN1VleiuXlwxsgDkhjgIX7f0Ztez1nBi3ySy6GOojv1JDFy4DNeFtIyxgMrU
Message-ID: <CAO55cswmUXDz0VwghMQBBdiiK=5CLO2u8o3s33d3sdL+A1PsYQ@mail.gmail.com>
Subject: Re: [PATCH] net/vhost: support queue info query
To: Liangxing Wang <wangliangxing@hygon.cn>
Cc: chenbox@nvidia.com, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VJaWgSGNvgN3QxcWufx-S46Co2TEiiuVosyrO_5H-So_1786958998
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

On Wed, Jul 1, 2026 at 8:36=E2=80=AFAM Liangxing Wang <wangliangxing@hygon.=
cn> wrote:
>
> Add Rx and Tx queue info callbacks to report the vhost-user vring
> size as the queue descriptor number.
>
> The vhost-user PMD does not use the descriptor count passed by
> rte_eth_rx_queue_setup() and rte_eth_tx_queue_setup(). The actual queue
> depth is negotiated with the virtio frontend and maintained by the
> vhost library. Query the vhost vring and report its size through
> rxq_info_get and txq_info_get.
>
> With this change, testpmd using vhost-user PMD can display the correct
> Rx and Tx queue descriptor number in the port start log.
>
> Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
> ---
>  drivers/net/vhost/rte_eth_vhost.c | 38 +++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

