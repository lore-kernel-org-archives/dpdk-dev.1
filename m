Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3CCFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 16:13:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95965402CB;
	Mon, 24 Nov 2025 17:13:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9594F402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 17:13:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764000781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYpiH7WGW9wnhZ4Qa5eLJhW4o8twlPxgcc8Qxxb0NTo=;
 b=SoeA+12Esao63Ohp4EGFy3ZGIhipj9LZbqX71kQ6S5va6EA8q6NHrRYfO/FJY1ew61DgCd
 V+aTFq9dxEalm7dovmsI/aLHmVgY+ti1YatCiYh7yfqn8x2gAkxudV9xH0lPln6zpUDafs
 /nCa72bJ9lK2apGiBqvg4g86ZCk7EmE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-z7hUvHtvOGaCwJWBlFzXWA-1; Mon, 24 Nov 2025 11:12:56 -0500
X-MC-Unique: z7hUvHtvOGaCwJWBlFzXWA-1
X-Mimecast-MFC-AGG-ID: z7hUvHtvOGaCwJWBlFzXWA_1764000775
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5957bd7530aso3950369e87.2
 for <dev@dpdk.org>; Mon, 24 Nov 2025 08:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764000775; x=1764605575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aYpiH7WGW9wnhZ4Qa5eLJhW4o8twlPxgcc8Qxxb0NTo=;
 b=oCRpgafLnB5B4COH9SJM86OoBnWe/BCkLq7QOK7n1ncX/qgkWLsQvlWdUtZR6YV4yJ
 pX+iQ4BgnkfoOOzGceOkdaNLYSFDXmjBI0qOw4QUaR61WaFp8i7jeOfN58JOk3bH6Of7
 Tggs6MT1pvV5gSJslOiiPLxUN+KH9O8CylvG1OwWRqJisliKqk6lvViRDMSQtMXcCoHp
 RUZ0l4+NmTlGAS2hf3u8lBBR+u0GtaWOA4b5Nba3c6a7//4WilG/WPF/7BuPSzbDj7Rx
 2k+IdXaAYwrQ5uuRYuux7JgILUDYrDoU82+/B21l4wfGQ95XAxOkUb8wHMhLZNOZBw7k
 3n0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3D0Kp8UH8USxQZuIOT++B7nUJGa2VpvtrmGuTLyOH2Xq/y8GYze9VOd9HoOgkfDu9/GU=@dpdk.org
X-Gm-Message-State: AOJu0Ywjqs56i6ESBnuLZgvs56delWJkMp0Vv+x+M9uOGq4s+HwBNZDJ
 /U4Xn7aj5KbU9xZ+ykZQ3GGS+ZwyEnxg1X6bAZcHeytt/vKFG/M1hzNZ2phbyRYtPvoEEEi0kEJ
 dgn44JvRs21BFrmfitgRuzfpZLqcInzaYuCW89mpJEOTgGpV623MCKw1TovE8KbuhZ4PRXWQJWF
 9MpCXP/W4yGtnH/myz0OI=
X-Gm-Gg: ASbGncvkJ1BHR0dpkahjEI7y8lFJEPi8Zm9cyHKOOyVUpw5Dt2bgE9b8yWBXHr6sCgk
 Fh9EeiKeFbxyHmw2zaE2oKPS3IxH6EeU/O7vEwXXj0hw6bIIaMqv7wxx5fMPtp2KZkO/CPMOjaC
 9/OGwhZBnWoGO4vRaaxMooetwTIYuI96nEeickACLGAcsaMw6cVO89lyC/VHE+8fM4WL8A
X-Received: by 2002:a05:6512:104a:b0:592:fc68:5b9d with SMTP id
 2adb3069b0e04-596a3e9eb5emr4279598e87.10.1764000774877; 
 Mon, 24 Nov 2025 08:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYDq7xobEIP1TwINMuoDbqjeuckq5VMm4NybH+wJEcfWBZYflu1qX/pIQw1gh1zytIyFiY+L+JyV8q93QTOXo=
X-Received: by 2002:a05:6512:104a:b0:592:fc68:5b9d with SMTP id
 2adb3069b0e04-596a3e9eb5emr4279579e87.10.1764000774356; Mon, 24 Nov 2025
 08:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
 <20251106141631.179443-1-sivaprasad.tummala@amd.com>
In-Reply-To: <20251106141631.179443-1-sivaprasad.tummala@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Nov 2025 17:12:42 +0100
X-Gm-Features: AWmQ_bmLMd9F9WtggRjCzL8TjIiiprPzVplI4C905T3qGVfxRF5ZnfW3jyhP2LE
Message-ID: <CAJFAV8yBJhQkUoTxpWX+L8XGWN1MdzPZ6hjFmYYVxsoaTiOu9g@mail.gmail.com>
Subject: Re: [PATCH v3] examples/l3fwd: add Tx burst size configuration option
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Huisong Li <lihuisong@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Jie Hai <haijie1@huawei.com>, dev@dpdk.org, stable@dpdk.org, 
 Venkat Kumar Ande <venkatkumar.ande@amd.com>,
 Dengdui Huang <huangdengdui@huawei.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rR16IJJVzwwjYB8ip_NbBQEwUXnbUZiLmpk5yHhaJfQ_1764000775
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

On Thu, 6 Nov 2025 at 15:17, Sivaprasad Tummala
<sivaprasad.tummala@amd.com> wrote:
>
> Previously, the TX burst size in l3fwd was fixed at 256, which could
> lead to suboptimal performance in certain scenarios.
>
> This patch introduces separate --rx-burst and --tx-burst options to
> explicitly configure RX and TX burst sizes. By default, the TX burst
> size now matches the RX burst size for better efficiency and pipeline
> balance.
>
> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
>
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> Tested-by: Venkat Kumar Ande <venkatkumar.ande@amd.com>
> Tested-by: Dengdui Huang <huangdengdui@huawei.com>
> Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> v3:
>  - Added --tx-burst option to allow independent TX burst configuration
>  - Renamed --burst to --rx-burst for clarity
>  - Renamed variables for clarity:
>      - nb_pkt_per_burst =E2=86=92 rx_burst_size
>      - max_tx_burst     =E2=86=92 tx_burst_size
>  - Modified parsing packet burst logic for RX and TX
>  - Default TX burst size now equals RX burst size
>  - Added logging of selected RX and TX burst sizes
>  - Updated documentation for --rx-burst and --tx-burst options

Please don't put changelog in the commitlog itself.
Fixed when applying...

I also fixed [RT]X occurences as [RT]x.

Applied, thanks.


--=20
David Marchand

