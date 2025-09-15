Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B4CAC598
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 17:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAAD7402CB;
	Mon, 15 Sep 2025 19:48:52 +0200 (CEST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id 7E476402C2
 for <dev@dpdk.org>; Mon, 15 Sep 2025 19:48:51 +0200 (CEST)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b04ba58a84fso600284066b.2
 for <dev@dpdk.org>; Mon, 15 Sep 2025 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757958531;
 x=1758563331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLGQOF6SUlIHcZi+l/ra7rsz4O6YXQE0DK/ON9C0/9o=;
 b=nxvfyKfhIieIshNu0CaKuESQRIAf3EAJ999aVwb35rq/MCDh47TZctWiRTdpXG5vUY
 l7LBnCeChngdSDJDQhK66CK9JI8eAxsCced5Tj+hOdxBsmNIucteuh9ZCrqw33fv/Fph
 KlkfvXfbDoNSp/XZ4wf/6ZW7XpiWXaadaWmS+ElrY0wfEiGZov6iP7Qm61gkmWXZGbhz
 CEnSXDGAlHrz8WCD9yAm2+ZH3Bj+TPyCH8iB83ZniA2uiXGhTMiOkEMNxCzTL8nl+edA
 r8M/TE+O1ErTkvREcUa3/6HaCLQKjv0TeSXPJwRYKjgo7AAwZOEZHqyTwL7E9UQqvzdg
 1M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757958531; x=1758563331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLGQOF6SUlIHcZi+l/ra7rsz4O6YXQE0DK/ON9C0/9o=;
 b=MJ159xZTflG+ngklEGnJzhMLIx7Mnv0781q6tWmF5DDm3cLn7hOaBpU8M8MKPFqk8X
 GqqI3HWZGnMHs3kNl/xrjuPsSqQLquaew2sK1RSjXWLG8uuS1tfhCoyub+1fGbeV/gYC
 xZquDSTzsWU5xW/aUK4mzkQKNiYA/7qpp7bjFw4i0nV3+7Bfv8JvVhQ/sixfe7qlnpY8
 U2rlDPGvb9DTF9SELQ3ttWNGZx/ITNpAayWbnukQF+oMwzEUqm9uq6KnYpHdv5zIuWAe
 SXHweoKnxn0s1dRUcwOM1Hv0kD9oDgC1x8YSEv8KFiaFb+miqsXMKumdeZ9q9XO913a7
 0KNA==
X-Gm-Message-State: AOJu0YzQHwKN4FZax99n/6+FFYvXSvm6NlM9bJ8+YhN/odD9lYln+puE
 +1SG8tOUG5yBuO46TzMtTTOnBXrGh3h8IHcIC+g0gJfcECcQMb84shBbZCM+DOjTXVU=
X-Gm-Gg: ASbGncvT97gQRZgyo4CL9/ovCqZo0V50ez85tZQ9Usw5SUb2xwl7FTtxibLpwHm1qyS
 OjUMTpApRQK8CqDc53t3MyZXX25BM9/PUKsiJeRzHT30xGV66vusQUO61eqa4WjVU/FImtrFaBD
 oUS5nRdNzmb9wEkY9d7kbn988sC1K+HAedpX1PTphiZes5q7eGv+aN73hLyNvJpPHc7LXWdHC+n
 dsr4aqf8rDfx+i1f7SNQdoEEMqsjxh9Cle/gBx2eFO5fkBzqVCLhwJIFAAPztK9LWonDHALxF/0
 jzP7QE7JzcBYSaiea1gDIQMRZs5HFkkQXAi0FeSRuZQ1XLbL8LruHx+4tQ9DFqy2AeVI8viOZZV
 RrZ3CRma7dOHZ+jpLu+TSJNpm97AmZNeg8lsrfE1d0VCt2F68uG14KVgpPsgUDGvR60AMaZVCPI
 4=
X-Google-Smtp-Source: AGHT+IE7F3/2ZpiiFBlgkjyst0uWSyEqXw3P4+/DWEpht0H2MGgna+ajpgSjlVqKxsmRvFsCnNUpYw==
X-Received: by 2002:a17:907:3c84:b0:afe:7909:f42a with SMTP id
 a640c23a62f3a-b07c383f22bmr1323408866b.51.1757958530776; 
 Mon, 15 Sep 2025 10:48:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b33478e4sm976076666b.96.2025.09.15.10.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 10:48:50 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:48:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 2/3] ethdev: Improve descriptions of RX and TX offloads
Message-ID: <20250915104843.2adf2ee5@hermes.local>
In-Reply-To: <20250803194218.683318-2-mb@smartsharesystems.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
 <20250803194218.683318-2-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sun,  3 Aug 2025 19:42:17 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> The descriptions of the RX and TX offloads have been improved, to
> reflect that they are not only for device capability reporting, but
> also for device and queue configuration purposes.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
> v3:
> * Add notes about conflicts between fast mbuf release and
>   multi segment send. (Stephen Hemminger)
> ---
>  lib/ethdev/rte_ethdev.h | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>=20
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index f9fb6ae549..724b2b149c 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -1550,7 +1550,7 @@ struct rte_eth_conf {
>  };
> =20
>  /**
> - * Rx offload capabilities of a device.
> + * Rx offload capabilities/configuration of a device or queue.
>   */
>  #define RTE_ETH_RX_OFFLOAD_VLAN_STRIP       RTE_BIT64(0)
>  #define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
> @@ -1585,12 +1585,12 @@ struct rte_eth_conf {
>  			     RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
> =20
>  /*
> - * If new Rx offload capabilities are defined, they also must be
> + * If new Rx offloads are defined, they also must be
>   * mentioned in rte_rx_offload_names in rte_ethdev.c file.
>   */
> =20
>  /**
> - * Tx offload capabilities of a device.
> + * Tx offload capabilities/configuration of a device or queue.
>   */
>  #define RTE_ETH_TX_OFFLOAD_VLAN_INSERT      RTE_BIT64(0)
>  #define RTE_ETH_TX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
> @@ -1611,39 +1611,53 @@ struct rte_eth_conf {
>   * Tx queue without SW lock.
>   */
>  #define RTE_ETH_TX_OFFLOAD_MT_LOCKFREE      RTE_BIT64(14)
> -/** Device supports multi segment send. */
> +/**
> + * Multi segment send.
> + *
> + * Note: If a port is configured for fast release of mbufs, the driver i=
s expected to use an
> + * optimized Tx burst function relying on the preconditions for fast rel=
ease of mbufs, which
> + * prohibits segmented packets, and thus multi segment send is unavailab=
le.
> + * Note: If configuring a port for multi segment send, support for confi=
guring a Tx queue for
> + * fast release of mbufs depends on the driver.
> + */

Wording is still a bit awkward. But many of the offload comments are a prob=
lem.

All the comments for offloads probably need rewording to be consistent.
Editors always like when all items in a list use same tense and subject/obj=
ect wording.

I am lazy, sounds like a good job for AI to do.

Chatgpt says:
Here=E2=80=99s a clearer and more concise version:

Note: When a port is configured for fast mbuf release, the driver must use =
an optimized Tx burst function. This requires fast mbuf release preconditio=
ns, which prevent segmented packets and disable multi-segment send.

Note: When enabling multi-segment send, Tx queue configuration for fast mbu=
f release depends on the driver support.

Should also be careful to use RFC style keywords (see RFC 2119) related
to MUST, SHOULD, MAY. For example, driver should use optimized release func=
tion.



