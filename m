Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36841607CAA9
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AnwDe5jj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BBD540E34;
	Mon,  2 Nov 2026 15:41:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 8AABF40274
 for <dev@dpdk.org>; Mon,  2 Nov 2026 15:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7A2HWF+AcG9nHopsUGHZJiokmTly+OUVLOE4WUiqpk=;
 b=AnwDe5jjtehFn8LjXXkR4rT079u9oZvbwHgMi60Jfmg0nHaIOTjA7Tz+bwCxAu1nTfOLSV
 2VgQxv4Z+EgvTV5YGTY21Fj9rwTgc3Y9GKE9yfUtNc2CvaWIaFNBdvehXeDAEpChuIoMNv
 aUiTxjjMhGCtS3HPZqgBh/YUorbf71E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647--bAvAcGHPEW92dIfdLEmyQ-1; Mon, 02 Nov 2026 09:41:10 -0500
X-MC-Unique: -bAvAcGHPEW92dIfdLEmyQ-1
X-Mimecast-MFC-AGG-ID: -bAvAcGHPEW92dIfdLEmyQ_1793630469
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5bcf39533ebso1990949e87.0
 for <dev@dpdk.org>; Mon, 02 Nov 2026 06:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630469; x=1794235269;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S7A2HWF+AcG9nHopsUGHZJiokmTly+OUVLOE4WUiqpk=;
 b=ADnaXRXdC3tFIV5GNb8cH0hhSK4XNGUd5HaWs0Tl/H3D6s7V6/w3J26h0S5svN9F/G
 x1yYtqbCQrOIcGEtVmxv9t4KYZR89R/VbI/qXKFB37RXcAADBm6EpYLrG4hNrScBhKzg
 XBgkDWr4MbP36b8cD3qlT+Is+jb8xWrvmgEtl2eZ5oWTe+hLmr8V3I2iY0qTDKlj/uMN
 gSvznbz6uBeJX1CtJwl6DXbt/HUywN4m+VUqYkUVlU0URm/Sb273w9mT8I7J5Re8e0pD
 M+f+BvyeaqdIzQ16GMRzM57o1clRvuTUGcBmlvv7Tpw5FThdN1QjV/tbxLUzxrmvP0rt
 9ydw==
X-Gm-Message-State: APuU4Z86Y3j83bEW33vC5qLctT70d8K4jjplrr0uKeO4D5M1E6esIAbW
 L555nSYUUpGEFgzTS8jacxiW44zxFZVoUPbGYGhfnLPddCPT97ORyd2r2ykn2WDRTiNo3P01LU2
 8LoAOtKWkpBXi0ApQQ5pglXFSwUlql89euJKulBjdGffEkZaAwbiwAv4AzW6yDOgQHBT2I8z1Ke
 PFo1kqPkmKHnLjzW1J64o=
X-Gm-Gg: AYBFou18MHnRvTIVitfmiUFIjPwnexn8HlXH2hPHNPex6aHlK9PDacNJA/A8HP3vth2
 F9J9Za5PuTsKam/Xapjy0DNxX16K9l3WFallTy9nzDuEBRBDuO/qk1EMhU2ta1tHE/fDxAf2lMI
 y5xoOlrH3lbClvGARJwbwDXOz8yx3zoPRxM9ECJilZjwHKcA15qCS/vvQdvFQ8sXtgcm0qRZW2I
 hMwkyw2ydHKGJTOTHLNZwX9PzrLIPR1s6AfToIFa/Jy7ATC
X-Received: by 2002:a05:6512:b95:b0:5ba:3b01:36ac with SMTP id
 2adb3069b0e04-5bfd957fbd5mr3671122e87.56.1793630469281; 
 Mon, 02 Nov 2026 06:41:09 -0800 (PST)
X-Received: by 2002:a05:6512:b95:b0:5ba:3b01:36ac with SMTP id
 2adb3069b0e04-5bfd957fbd5mr3671111e87.56.1793630468839; Mon, 02 Nov 2026
 06:41:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029144727.119072-1-stephen@networkplumber.org>
 <20261029165729.1081754-1-stephen@networkplumber.org>
In-Reply-To: <20261029165729.1081754-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 2 Nov 2026 15:40:57 +0100
X-Gm-Features: AclHuK_yJm62LJ4RCQUFrWGkNBe9XSluiR9deJSJyZ1K1gU6P4CSbXMNX5s0E9U
Message-ID: <CAJFAV8yy0Gn6Wur402zA63G_g=FXYWwwn1bQfZXtLA8KAgZ8JQ@mail.gmail.com>
Subject: Re: [PATCH v2] examples/vhost: fix hang on exit
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Yu Jiang <yux.jiang@intel.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HfuXpMk_BlsLMbR1PquPW9FJzOLO2-QWHDuBlRCRIzo_1793630469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 17:57, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> destroy_device() waits for the worker lcore to ack device removal.
> Since the signal handler rework, the workers exit before the vhost
> drivers are unregistered, so the destroy callback spins forever.
>
> Maing thread now blocks SIGINT and SIGTERM and uses sigwait
> to wait for one of these signals. Then unregisters and tells
> worker threads to stop.
>
> Bugzilla ID: 2071
> Fixes: 5ffa8fafcbd3 ("examples/vhost: make signal handler safe")
> Cc: stable@dpdk.org
>
> Reported-by: Yu Jiang <yux.jiang@intel.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Tested-by: Yu Jiang <yux.jiang@intel.com>

Applied, thanks.


-- 
David Marchand

