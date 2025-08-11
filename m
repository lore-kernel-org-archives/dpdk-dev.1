Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8AFCA0ECD
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 15:38:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF4B940E0F;
	Mon, 11 Aug 2025 17:38:44 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 05A98400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 17:38:43 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b78315ff04so3876360f8f.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754926722;
 x=1755531522; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ga6xTuqXvCCSQBlHvbVdy3tN/yR1ISwAAGU4uR3a7jo=;
 b=jqfGEnSyeqEcb6SzqBhyfuRExJKaGs8PaaocK2GS3fOLOQGY8srqCsWfJVoDtIut+C
 JM8jVGmPT3xFzwL0TRi2cGkP/s48IcapkBRCaWhi2Ddf1inIj2QdDDP0K4x55zg+uhtN
 FpdoMeW5Vbr5GvzswoadJe/WUYD73w3h3P/qUeU5CpbuoOJZ94eAomkIao1C1k1KQAfZ
 Ed2cbpAqKJEK2vYBOHDr6M6H4ntSkNzP3d6zcNNTD1GZyTUrY+PqO6OvpG+XENVjADK4
 NN7LKcqNPn5ez1lhnjLg2tjSFK2nIbK9se9OpA93leht42UFCDNdq7XmWXgYjKxkCTN+
 u5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754926722; x=1755531522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ga6xTuqXvCCSQBlHvbVdy3tN/yR1ISwAAGU4uR3a7jo=;
 b=XmsgtC1bxxxgtBrZ9NWjJPWmFnypw606oWzm8fiiFNJJuv36ymitcoR/sKib7t1gS2
 JaPUphJ4OB8jaxeUT/MiECGNtpXOOx4dRFV2yts1j7Qk2YweGwmmiLga1V2zjpqtTn3G
 x4Ms7vpGqD76YszV3kYXMOJiwzdNpz9rd60yX6ybUdFtRz+6qhnnPPXAp0gbwdqk79gp
 q+8ZyKmrYeTb9QGPCZ2IvUUWPHVS2sMXqkKoP8a0bucKCLAJho1Y485MkDInRAWTTHi+
 i+rPBS+ClYNKgV6GzS5DRvU0xWB9bga7Fb0/EWBTCQnSK6rTfmk6tRN+5+Gp63m0JTJV
 kKyA==
X-Gm-Message-State: AOJu0YyKPkN1/dMH6VYyZxYwdvjNbuIu9wLJ8GH8TkfO4MOFpi4cR1iZ
 gNFtxSdBTTbT6mlB1K6h9EDyzXzmO2G9Sbm6WZk468W19YAQIrB9oS7rrnTvkwn54DY=
X-Gm-Gg: ASbGncshhtoefIoSksmQlYWoGJ+VWAddrcyDjK/jTdzYCvuigCHVKnwf3vPpxXQ9NnY
 3sr35kmCishUzpfbhr3x5ubMbmrusf32WmBVJg17KLJUxtQm54KikPE3BGfEg0IEobnp6zoLose
 wJTv6Sy4yS28DJL1q22VlzKshTd2QAuZGtHKzIkrEvbI1sdo7qO1sBMTx4wthmNyxghP1FwuOt7
 /ownQJiS28cO5qmwmU+15MXMOby93o/gBtzKBg6qZVHxSNyLFOQE6e3G0qCu8UuNMRSxSqTGk1r
 KIcxHdzq0O1NapSYSC4qM2H4YK5KfV8RIojPxC59y+Zz4QOd0OIbMkBjluKPjDN7x9wW4fXNSSM
 QzLtvpnUCGcFd+g8eaCjr5nOdW53/YUEhsrUBRVhI+4HesOAk4JP1MZCQxVl8eODmxlGz84cQxS
 g=
X-Google-Smtp-Source: AGHT+IFCLroZ++BOBssOpa2XiWnSDVn/TsBFfrOhgGniKcAPTCTLaocBvHK1O2QJcYXUTmf0p26TNw==
X-Received: by 2002:a05:6000:4284:b0:3b8:d271:cdc5 with SMTP id
 ffacd0b85a97d-3b911004755mr174609f8f.34.1754926722589; 
 Mon, 11 Aug 2025 08:38:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm41502739f8f.66.2025.08.11.08.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:38:42 -0700 (PDT)
Date: Mon, 11 Aug 2025 08:38:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>, "Bruce
 Richardson" <bruce.richardson@intel.com>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>, "Ivan Malov" <ivan.malov@arknetworks.am>,
 "Chengwen Feng" <fengchengwen@huawei.com>, "Andrew Rybchenko"
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3] mbuf: de-inline sanity checking a reinitialized mbuf
Message-ID: <20250811083836.7d0e96a7@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE21@smartserver.smartshare.dk>
References: <20250719102315.435921-1-mb@smartsharesystems.com>
 <20250722093431.555214-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE21@smartserver.smartshare.dk>
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

On Mon, 11 Aug 2025 12:06:44 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> PING for review.
>=20
> I think it would be good to get this patch merged early on.
>=20
> We should also consider upgrading the status of the rte_mbuf_raw_alloc/fr=
ee_bulk() inline functions from experimental to stable, so they can be used=
 by ethdev drivers instead of rte_mempool_get/put_bulk().
>=20
> -Morten

Yes.
Actually almost all experimental API's should become stable in 25.11.
Experimental tag is not meant to be permanent.
