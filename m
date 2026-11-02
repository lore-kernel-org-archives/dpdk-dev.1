Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7434606A326
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GjQicSTT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4167940264;
	Mon,  2 Nov 2026 09:07:49 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 9E89F4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:07:47 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso1927443f8f.1
 for <dev@dpdk.org>; Mon, 02 Nov 2026 00:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793606867;
 x=1794211667; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5ZIoAV9H5ZM9eJmpCD7cDDwsCYAwyZSId7zf7+tREZo=;
 b=GjQicSTTG6+d1e7rFiAKCHxcFe2UZ9TaS469C7Zhas1Y5hM0trSRstuNmZZ28v31xL
 XLEXz868fDP3iDFGJHiKGod5K/Lhf5Tj9XDQBs4TG5M7Iz19QywpzMW7vXNYca2JWsTt
 02+Djos1ZuuqNTwcw9tNkzcYNQlaYbZX17QAxJ1X8XRXwClyBxi6RuhOHwg5fNKAllYE
 okdLESemOVcK9fcPn9KRVmz4M3eLMQ5vt9J5KYvEFl6pxeNRdpJqnQJ/NJxddFDhC99a
 sf9lgIIgPZ5XmGJPIBVeCaX7k7UXKxhUPftF8ds8qaIw9+hNyFUXt2UCIZhFmq51um9f
 yEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793606867; x=1794211667;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ZIoAV9H5ZM9eJmpCD7cDDwsCYAwyZSId7zf7+tREZo=;
 b=ILqLBEa8kkXZh9I9tS+CzSU6WBj3qlPNCu7ikoIUXlpis0BY+cC9B0LrmuI+qDFuJ2
 8Ocf6pLB09bdX6SEH2D86vicqoKt3daMiVfT4BzK+Zv63+WOkkedNJppyuv7WqLd9GXa
 PF08L/RfaKYN0sHVW7Sj3tVQYg0ar2UzRCM7kev8YwjaMLv6ovbEEpfbmup9pPHN/76L
 HoJcyOzbridZLcRGMv8B2GDGwb+LsW4LQyZBBSydL3e3Kcpr4STypxnO0gvNMquyp15O
 GirpU/9pSmEeMasHieRTiNeApo/N0uO3tG0XZPhfOp8RgiEFkD49taYjLOi1gM9DmApj
 z5JA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRri6xDxXpkhyXjaLVZw375uHosYvAaopHFwe60uNOLArtO5Gs2QkDRqxMVh+TW5RVF6M=@dpdk.org
X-Gm-Message-State: APuU4Z8VEY67X93aGXSExpX50bCeBGKlJ+jy1XoZoHD9sDCznnPecdUM
 JwL1h885VMOSAn+Y68/eDnH7ihtZYS3OOJJ3Q4XUouIaf8V9ICpz1WrZTP0+V30K0jw=
X-Gm-Gg: AYBFou2uNekZAtlQDOmIzJLdWdW8vaHiqhKuKLPJksrnIMMyzhffLhJ8AYiCny3EYZY
 BYYtEkdIbP1itM7HV9DlQ0415soaxQzZalaJcl7nQMMWB6Sr2QOaiQ+nPplmPZUkrsKdpS1jyMB
 z4nYXXrLxDlLIEB7Atlc/6QmGuYWNvHCVQxgY5UC+LhVMhjxc7fjjpXxieYcCVugur80biNxYmE
 GdWdirr6gKt1CUo7VmcGm5xAH0hzhHPOJYg+yq03iTx1heQGL1K9zCyGxv8OiUojnhydKvu1evg
 iM9oq1WraxIaWx9aud6TuIJeX7AUR+Y4KN1N2/HjJUSD31X4e+FOAQDx0N7CkkwI9HVoH18wzVc
 ds4H7l71IGSOxpJs13cHGMyjomYYybgwPc17HpYSdBC+FTAo/j404UH1CFpeYNHBr/s0rIKZstF
 rkT8xlPBm/Y1k6YOnrT+tSYA8ipj0qFem3sjLYI31qDCjzK1aNsp8Rn0L11wWJYgkYQyB/b8OYP
 BbpJszoRHy1WpZFmql/3ObNijiDAjFoDwS+JKnbtTcMey4M8P+a36rkef0gZ4IOVJqdz9HIIlz/
 V/C8gR/TFTU8Rd6KhoQOxGjJJkIwkznej/+e+XRaYwJfHFUzIb0NMM0vr9VNBgWZWC6Amk0Nhpx
 p6duMp4783x4kU/A=
X-Received: by 2002:a5d:584a:0:b0:48e:7833:2e7b with SMTP id
 ffacd0b85a97d-48e7833329bmr15146914f8f.1.1793606867148; 
 Mon, 02 Nov 2026 00:07:47 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm19746678f8f.32.2026.11.02.00.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:07:46 -0800 (PST)
Date: Mon, 2 Nov 2026 09:07:44 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/2] net/mlx5: improvements to link status handling
Message-ID: <20261102090744.06c8be14@stephen-xps.local>
In-Reply-To: <20261030172843.2304296-1-dsosnowski@nvidia.com>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
 <20261030172843.2304296-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 18:28:41 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> This series is a result of splitting patch:
> https://patches.dpdk.org/project/dpdk/patch/20261026160400.1290443-1-dsosnowski@nvidia.com/
> 
> Patch 1 - Fix for mlx5 link update function to query current link carrier status,
> bypassing the delay introduced by linkwatch in Linux kernel.
> 
> Patch 2 - Move to link status polling, in place of relying on netlink events
> which can be delayed by linkwatch for up to 1s.

Instead of polling is there a way to get the lsc directly from devx or ibv
on mlx5? That would work around the issue and avoid the overhead.

Long term, it would be good if kernel had sysctl to set linkwatch per interface
but it doesn't
