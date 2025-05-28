Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2980DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 12:12:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BB5640669;
	Wed, 28 May 2025 14:12:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5D1AA4028D
 for <dev@dpdk.org>; Wed, 28 May 2025 14:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748434372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srobE0mnR+F8E9TPe7J3R1RM9gkJvM7e19kCOzgdYNM=;
 b=Kh+Cd/TwsJDyNcB6OGpJhNVj5wFG99/8ZXTWh0CpJJ5qrv91aqS0tzLPOvzzF4O26xxhWD
 pJUCwuqnOo2HU1TaNSBQJVS/6cs9RubIPs/Yz9wiFHrX7QHd1Ii4U1x+dwxxK+12moLT7e
 8s4Y82+Mw01YQ27GOIw3/NrUuSHAtuI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-W3ig8p_OMwm0vMRIa65uDA-1; Wed, 28 May 2025 08:12:51 -0400
X-MC-Unique: W3ig8p_OMwm0vMRIa65uDA-1
X-Mimecast-MFC-AGG-ID: W3ig8p_OMwm0vMRIa65uDA_1748434370
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55321c19944so1645278e87.3
 for <dev@dpdk.org>; Wed, 28 May 2025 05:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748434369; x=1749039169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srobE0mnR+F8E9TPe7J3R1RM9gkJvM7e19kCOzgdYNM=;
 b=ayF/AKwh60uhyLuttoSZX0KHTCIZiKI52AKfIR984tjHWIf1hFvKp/pPLhqY07tTXf
 UZuHji8QFZfIPLyAVbtNPLhIkq9y94ral9z/sY7iSR30qDrb5X+yRplXhF2f6VaTUkS2
 6TUi+wBq2FFO6LnHZFi3hZ+aI78kCk7XJ/zzLwQW0JQsEujFXRCSto3p0+/eEPcOlqoq
 GtYctzKEPRJI8qEHW4P9pYIg0Qqns8ZQG5fjqYIehzrBsgh+cf1ZlR82T0VwG6mMfnCv
 XQhbhU+OddXXLD4jBamsnzwGyMb7RhqR0wIifTKG3bJ+5twKJ/GioC4VY3R9PexSo/OL
 TY6A==
X-Gm-Message-State: AOJu0YyhqRISxj8WMqEZ+5yMzJJaLPnlh0J2hzl+tIurYtR8eS1a9VZu
 tIJgDR1ACfcR+5378ZvclSvfg3ZwE4pNAgnfc7+XVfTM5OxdUulpTD8zsP27V/sZktouEloVXtP
 /8EYKwQn8eOabD5m5e9pCYY7coRkRtgxObvDnA09vd9tN0xXKOPOKNu/DZ7US/iLPonGnTZPIQ4
 4OTEDvrBUp1j3mh0Dv0e0=
X-Gm-Gg: ASbGncv8OAZwd8mStxUFD7ivvH0xPDvRzEg0Tw4ZS/QF2WmqnFb7H/QD6MFQOW+MbzO
 eE+eghMT3z+nPDiQ/QRGUGgW387J2ymO+SF9//RZhui8EpSipRu5sVhntrtpdIelmfvJedfr0jJ
 hnyHZiog==
X-Received: by 2002:a05:6512:33c9:b0:553:2f47:ed21 with SMTP id
 2adb3069b0e04-5532f47ee2amr709097e87.41.1748434369479; 
 Wed, 28 May 2025 05:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEOgTW2hcPTwdW4qLD+LlEqPYiVDDDrVBBCCFkWUMq2TaBFHU8pAm1B5TBV1V/PzVzcgSfjHsd5K20mlj9Xp4=
X-Received: by 2002:a05:6512:33c9:b0:553:2f47:ed21 with SMTP id
 2adb3069b0e04-5532f47ee2amr709088e87.41.1748434369085; Wed, 28 May 2025
 05:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
In-Reply-To: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 28 May 2025 14:12:37 +0200
X-Gm-Features: AX0GCFu7jEDQ_CtFaMvXgnEsjDaFUT1PwGuuIKtKq37FXBOG4F8XpEvIozEzvCQ
Message-ID: <CAJFAV8zDs2nVvX2ZC=sXX3pwYY4t+-ZrOcKqZpnSbjO4MqZ7DQ@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: avoid setting kernel MTU if not needed
To: Maxime Coquelin <maxime.coquelin@redhat.com>, dsosnowski@nvidia.com
Cc: dev@dpdk.org, viacheslavo@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xHIgiVXjjN-5m6cmAEzhmwbTGcOeuTFN4DeWahYMqvE_1748434370
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

Hello,

On Wed, May 28, 2025 at 11:36=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch checks whether the Kernel MTU has the same value
> as the requested one at port configuration time, and skip
> setting it if it is the same.
>
> Doing this, we can avoid the application to require
> NET_ADMIN capability, as in v23.11.
>
> Fixes: 10859ecf09c4 ("net/mlx5: fix MTU configuration")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>
> Hi Dariuz,
>
> I set priv->mtu as it is done after the mlx5_set_mtu() call,
> but I'm not sure it is necessary, as is the existing call to
> mlx5_get_mtu() because it seems done in mlx5_dev_spawn().

It seems there were some back and forth on this priv->mtu topic
between Nelio and other devs in the past.

Atm, I don't see the need for keeping such a cached mtu value in priv.
There is only one user of the value, and it is for configuration
operation that can do a query to the kernel.


--=20
David Marchand

