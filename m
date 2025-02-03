Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB030C02192
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 15:30:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C63B40265;
	Mon,  3 Feb 2025 16:30:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 16CF940264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 16:30:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738596647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRXE0cl76yGQYsFZK9ssu5zdS13jHxXN4bySKBTGziY=;
 b=FK9iEIeq6xm6xBe1JC+i5EWnepJNtp5W6ggqe7hs/THHBwO1sPSFNySO3eZs5BdioNFjQz
 uwVjKlHBrrYCRskfiljCgKTU0VYN/LfVs/WbBNfZ20nC/LqRn/epJ+uU24QIHbO5eSjtUK
 Xf5iR4DEQzO8Wbom/8GD8izo6zdI8uQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-r-AAbofKOWK5QHHhF-5_xw-1; Mon, 03 Feb 2025 10:30:43 -0500
X-MC-Unique: r-AAbofKOWK5QHHhF-5_xw-1
X-Mimecast-MFC-AGG-ID: r-AAbofKOWK5QHHhF-5_xw
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-53e39a081f9so2466448e87.0
 for <dev@dpdk.org>; Mon, 03 Feb 2025 07:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738596642; x=1739201442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRXE0cl76yGQYsFZK9ssu5zdS13jHxXN4bySKBTGziY=;
 b=WwHaeWh9FifV1BirTd1OltweGKfYgq5UXj0kkvDwGtMyVEuNVgJZlukF8xgiN2QffB
 BfJkGy8xff9d8rXVn1XJKuTDVUHSUF7AEVFJ0uxjZldruWzjE+ntLrr9RKShASqwtO2s
 43ZzSz/cwfKqRXxWpO39yIJJ84PwBvXB0XTESYeozI76Y/c9hck/2WKzA1WWR7c4g1Wr
 /0mGi/7DQgMSeISVEv1unJ9p4GAbGiQJYCtPuLXh6rEQtNoGu4DM+prauNI32gv37i3a
 gm+epuBXUKAjtbK0hiTeLycc7ptkfo/4/ijuwUxFypp61rzwQqby/xsTxOhmmLfU8Bgx
 T/hA==
X-Gm-Message-State: AOJu0YyDz+lkxFCaVn2Q/xMs49dVmkyfqVLbegmKr+ekfC7cAMeHSxz8
 a7FhYn1TTJtukzPV1yH/aQbVIe0lgkdPNqK77KIHzzAA5LbcjLlyRRINd7XI9MNrEIQUrsd/S5R
 tA22chgJeWbAr9TRCSZPk8kXLRUYY/ZiBimMzgB29eQjDMSk+zRbGWhVIxUD2K7Gw2Slu8D//65
 u3Pk3L+xqc0MCARJ4=
X-Gm-Gg: ASbGnctNRI3kDbIFmIi+RvczG349PhDBjTslaiiGnA1Z1PYlDzoV9YlWzrPaszWPBv4
 g/4l/dcgZdWrjFTO9nJqbaLlOxGHisyMxnrPi9ahkjOoYe9cqQrja7NQYKdY0i1rd
X-Received: by 2002:a05:6512:401e:b0:542:2a20:e699 with SMTP id
 2adb3069b0e04-543e4be02e9mr6343657e87.9.1738596641802; 
 Mon, 03 Feb 2025 07:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3+gh32bppxjY+88jDBsu6Xqtd9KiozbJPldzh2APHuLNjdag4Qu8Tyi++IgY02UhcCuuh8JI14dYee7raSu8=
X-Received: by 2002:a05:6512:401e:b0:542:2a20:e699 with SMTP id
 2adb3069b0e04-543e4be02e9mr6343646e87.9.1738596641429; Mon, 03 Feb 2025
 07:30:41 -0800 (PST)
MIME-Version: 1.0
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 3 Feb 2025 16:30:30 +0100
X-Gm-Features: AWEUYZmqCCXw-Fl_rgqBsRl4Hvg_48OnPJ7eS52if7W9ifpVM3ZengKXOP_g-aI
Message-ID: <CAJFAV8z+aLY+etV+0knb0ZJMyocDZMYWStSBLiVZyeW1ZAVFsw@mail.gmail.com>
Subject: Re: [PATCH v19 00/27] remove use of VLAs for Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, konstantin.ananyev@huawei.com, thomas@monjalon.net, 
 Patrick Robb <probb@iol.unh.edu>, ci@dpdk.org,
 Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l87qMep_712_tEYk-5huzyyb8-WsJUR6yCQUNH-3gPE_1738596642
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

On Mon, Feb 3, 2025 at 5:06=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> As per guidance technical board meeting 2024/04/17. This series
> removes the use of VLAs from code built for Windows for all 3
> toolchains. If there are additional opportunities to convert VLAs
> to regular C arrays please provide the details for incorporation
> into the series.
>
> MSVC does not support VLAs, replace VLAs with standard C arrays
> or alloca(). alloca() is available for all toolchain/platform
> combinations officially supported by DPDK.

Recheck-request: iol-testing


--=20
David Marchand

