Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F243BE7BD84
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 10:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D84440289;
	Mon, 16 Feb 2026 11:03:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E367740269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 11:02:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771236179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVaSO7zz+kgD+WchyyhjH0+b9HAKss4FEa0R45+AQF4=;
 b=JDvlqBRjBIATs8YueR9eegjvYtjkRCF5cHiwYC5ssk3Esyv2Q2K87RH5NQWq5hMQW8/wiD
 ZR+W7WdPJaLUcOIPKuyY3sLM5yXzfvFD1ydz5ooBXv6IgMKydjf5//VcgHw+UBJ6XwPR1r
 kWtc9aZHalHoevxfuKDQ5dcMiM/veLg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-qNC4zPPNNWusULJeG3NfmA-1; Mon, 16 Feb 2026 05:02:58 -0500
X-MC-Unique: qNC4zPPNNWusULJeG3NfmA-1
X-Mimecast-MFC-AGG-ID: qNC4zPPNNWusULJeG3NfmA_1771236177
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59e592b15a2so1760256e87.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 02:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771236177; x=1771840977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVaSO7zz+kgD+WchyyhjH0+b9HAKss4FEa0R45+AQF4=;
 b=WwToHe2DwJ/ztMEkmWyKvocTgUMyK1rK0KaDXA2zbtujAryQbfccf8P/oYxk8dav06
 WOJt3lp3ItF1mEA4ImgKcQTsetfvUEHiHnEsIc5b9iRb/Glaox89SMiLRsUO74oJar+c
 F0xXfj1vmrsVSZqTiXkpop4JJw+bHe2yn+Zq0B6LAeAFsgruw/b0WV8siBZeJDa6Oe8d
 XBq1qt/C4YMQwtwDVeEgVFqo/ypWxqiGBogly69KzaJEBK7tInb1BvS2nzrNcZfEbhEZ
 kUOP0LZDjQUKl3MA3Zv9zZkAc1ITQ6By7FVxAZjiaJjS4SGBva+zClyvpGx3qSN9P46O
 POrw==
X-Gm-Message-State: AOJu0Yxc2T1m6zZEBCsuZzXFkx2EUaYywlKFrW5Y5pca4IH5I7+ix5Lp
 B+gsZPouu8WR/T4HwEzG7UIZkvPyAUARjykjBc1VzbLIctvlV3wCb9xGXGiJjjzN35fP1fRxxew
 R+sQXKoNnA0/1JYwS3CSHmIkenjQbddpZB/0TsRL2ZjUyKyrl1hSSRFZs97rPKG3OiknXSTWiMu
 B6vQGe9JtslIpxsKPZtK8=
X-Gm-Gg: AZuq6aJl83kw049ZBiZTMUL9IAvONevCpJNaIHp6LMEEysJ94/XWiElM02fCeTSbEnC
 qI3YDdgTFJ1o8X6aP1+dghL2dJC8DOZETx3eIJ6ae3sOcA66EEXI6GeV6RayXIFunw1K91c9YjO
 QgJTq7tpQsLVFiXVOwOhFIwnvL3AHtDamb2MpevLO//8j3s3COQLyms+eyQ1EJ0nm9Zt9YxEeDz
 87fklEeTTKWUm0k2yqwtztCyX1gq2LCDv5nULAoua4acfHoe2e/ZigGW8SZBrxcOxySAg==
X-Received: by 2002:a05:6512:415c:b0:59f:70ea:29d9 with SMTP id
 2adb3069b0e04-59f70ea2a76mr1103388e87.47.1771236176319; 
 Mon, 16 Feb 2026 02:02:56 -0800 (PST)
X-Received: by 2002:a05:6512:415c:b0:59f:70ea:29d9 with SMTP id
 2adb3069b0e04-59f70ea2a76mr1103366e87.47.1771236175634; Mon, 16 Feb 2026
 02:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
 <20260213170333.40089-7-stephen@networkplumber.org>
In-Reply-To: <20260213170333.40089-7-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 11:02:44 +0100
X-Gm-Features: AaiRm50Zq_A6JSooprQt4eyXc_WKoL1Mfq6_zyezweaxaQtwh-Fn_j7ZapWrDJo
Message-ID: <CAJFAV8wV6QfX2BhGUK2cz_V1_CYE8XektVg3VCL=H8T=mcdWgw@mail.gmail.com>
Subject: Re: [PATCH v15 06/18] net/pcap: rework transmit burst handling
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Ferruh Yigit <ferruh.yigit@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9OyBZIx4Xe9YvWAlor5xT1eVVWJ0TpYTz3BwTNIMmHE_1771236177
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

On Fri, 13 Feb 2026 at 18:03, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Replace the 64K stack-allocated bounce buffer with a per-queue
> buffer allocated from hugepages via rte_malloc at queue setup.
> This is necessary because the buffer may be used in a secondary
> process transmit path where the primary process allocated it.
>
> Fix error accounting: backpressure from pcap_sendpacket() (kernel
> socket buffer full) was incorrectly counted as errors. Malformed
> multi-segment mbufs where pkt_len exceeds actual data were silently
> accepted; they are now detected via rte_pktmbuf_read() failure
> and counted as errors.
>
> Add datapath debug logging macros (PMD_RX_LOG, PMD_TX_LOG) gated
> on RTE_ETHDEV_DEBUG_RX/TX. Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS
> in device capabilities since the driver has always supported
> multi-segment transmit. Add tx_queue_release to free the bounce
> buffer.
>
> Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

It seems this commit does a lot more than fixing one issue.
Please split.



-- 
David Marchand

