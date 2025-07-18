Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DEBC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 12:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B524014F;
	Fri, 18 Jul 2025 14:13:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A43624013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 14:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752840795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGg7wm3exFwYCbjmkcZYoL9fKfxqtPFHs2ZeYMfId/c=;
 b=Dn5ICeuImNVtbSsweaNAaK0P9Ffu/PBuidybAQB6PvETkiD3GoXIcIqgBjuFxTGAp+oG3L
 QeRtCSvU2r55Z8VQ8iCplDYRymFSTqtPy3KYvBJq2Fut6q3NGbxDXeu2oYnnReBV4t7OjZ
 BzPdEOFFYdMejXaCfHlj8JvdQG6YvOE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-Mhh4B_l-OPyNH3-FWXRk9w-1; Fri, 18 Jul 2025 08:13:13 -0400
X-MC-Unique: Mhh4B_l-OPyNH3-FWXRk9w-1
X-Mimecast-MFC-AGG-ID: Mhh4B_l-OPyNH3-FWXRk9w_1752840792
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-555024588e2so1323502e87.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 05:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752840792; x=1753445592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGg7wm3exFwYCbjmkcZYoL9fKfxqtPFHs2ZeYMfId/c=;
 b=G6pxQFdZ2aqMo13sqK34Tg4hH/XhNq/iXiPRl9h95NE8Pet4NAsS9LUPAjbr8mSs1N
 KIML0cefKQkGCqiivcz+Hj0CrGHne3II3ZjPmwi7X86as5xhCR0uvdURGo1v49/+Yzfv
 c4NDhee9sI34JnF3wX5qZa4hDy6gCPMR7feCKNEz0rcziMXlg/UBTunxuYwR/goUlaj5
 NhqpZ/BGmR5HDlhBDngkEJrCNXchjV69QTGfcQyrf4nA/33JF2tdAd6IZyz9YOXxHrY+
 TwNhPng6+kLzYUkVqvjs/rLCrIeYlIWeO8zJJymOsdrFFnj2Xe8WhRK6p25R9ejAN4WX
 I+bg==
X-Gm-Message-State: AOJu0YzvKO+hCJX03k+kP8lVkq7Rw+qMvOX7/nEASG6dd1KHVUNV6N1L
 UFmeCDbGYx+wutqO/D3FuDujtLvHSx+YoD+AU9H93Tm3QTDBzVdHXOuseSd8YDLF/b8tK2954Bg
 4JyizRKKOO4iEgxWuV39YfktAF7hZ9QAiBNYOm/Rlpy1fSIIw6r8rUErhZr+rH2RgX5YHAs8WEL
 Z+eIMzfJtZhbh7agzQFls=
X-Gm-Gg: ASbGncuXEezXBO/znoGoQqKNxoe1EgOju+8EmVwYNxcSEKb2ig4YIMTxOSr7GcU6GMf
 oV5T8esrGqZ93CmIt4NIyvt04e1h185vya18bG8MNLqzReonmHKM0blvDiL1X9gGvfO0BPCHMY2
 B1OghXbfYFJ2K/IfPVyT43EBk=
X-Received: by 2002:a05:6512:31cb:b0:553:2c93:6140 with SMTP id
 2adb3069b0e04-55a2330114dmr3621078e87.9.1752840792167; 
 Fri, 18 Jul 2025 05:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG06C6krY9qgl/S0I2atNU6m5T6Nt1EuyC+sNb8EXJvYtV6czT/VNb738byV61gobDSprGAzYzENGDwg2OzR1o=
X-Received: by 2002:a05:6512:31cb:b0:553:2c93:6140 with SMTP id
 2adb3069b0e04-55a2330114dmr3621066e87.9.1752840791670; Fri, 18 Jul 2025
 05:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250717061604.3288049-1-hailinx.xu@intel.com>
 <20250717061604.3288049-3-hailinx.xu@intel.com>
In-Reply-To: <20250717061604.3288049-3-hailinx.xu@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 18 Jul 2025 14:13:00 +0200
X-Gm-Features: Ac12FXxrAlCTHvMYQNpWXKHsZkiZsr3Zp6xI8fX38FbdCnOYyRIzlSRMD2ZkKHA
Message-ID: <CAJFAV8wW8r5tqBPKrGUrutv+s8x6uyS1L-oCxQ-vEfkawFaB1Q@mail.gmail.com>
Subject: Re: [PATCH v1] net/ixgbe: add nic and updated recommended matching
 list
To: hailinx <hailinx.xu@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com, 
 john.mcnamara@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YywL8jHhYs7STvGAejmRNu5eO2fvlhj3MV7_HurYVBQ_1752840792
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

On Thu, Jul 17, 2025 at 8:55=E2=80=AFAM hailinx <hailinx.xu@intel.com> wrot=
e:
>
> Signed-off-by: hailinx <hailinx.xu@intel.com>
> ---
>  doc/guides/nics/ixgbe.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> index a03ec7a7e8..6380e18feb 100644
> --- a/doc/guides/nics/ixgbe.rst
> +++ b/doc/guides/nics/ixgbe.rst
> @@ -36,6 +36,8 @@ Supported Chipsets and NICs
>  - Intel Ethernet Converged Network Adapter X540-T2
>  - Intel Ethernet Converged Network Adapter X550-T1
>  - Intel Ethernet Converged Network Adapter X550-T2
> +- Intel Ethernet Network Adapter E610-XT2
> +- Intel Ethernet Network Adapter E610-XT4
>
>  Vector PMD for IXGBE
>  --------------------
> @@ -93,6 +95,25 @@ Windows Prerequisites and Pre-conditions
>  - Loading of private Dynamic Device Personalization (DDP) package
>    is not supported on Windows.
>
> +Kernel driver and Firmware Matching List
> +----------------------------------------
> +
> +It is highly recommended to upgrade the ixgbe kernel driver and firmware
> +to avoid the compatibility issues with ixgbe PMD.

We never recommended such things so far for ixgbe.
I think this is a wrong thing to advertise.
The same applies to other Intel nics, btw.

You may insist that you validated with such a setup, but most users
rely on in-tree drivers.


--=20
David Marchand

