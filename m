Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941DECAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 16:32:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B110640261;
	Mon, 15 Sep 2025 18:32:14 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 8C2964025D
 for <dev@dpdk.org>; Mon, 15 Sep 2025 18:32:13 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-80e3612e1a7so765728485a.0
 for <dev@dpdk.org>; Mon, 15 Sep 2025 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757953933;
 x=1758558733; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5Eu6cTYGaM68GXp1Vlq++QtfFF9C7vhajin8RFYxRU=;
 b=YqoeB/mGTL05PKW2ApKxZ4JK8yzgM5Zmu2mShNzswZo5+RHlHWnKGlMlFEHPSbq3D9
 X2g6GOpC5ob4X6E9ZHGJs7kVPRcwvFsapis8BQoM64PbejPI1q8aUM08Mb9xrs97QXib
 g3z5cc/toodxFKRyA0FcfNS4cjXHsTlGzhiHNwMWb960dUb+bwtMTVnSYt4MCvEWWMSg
 FfFCu7zOfDrUIhkZ/wyyASy7HslGjterTREMKNjAAijC7b7/Uhx0S7ITlm7HZFMTP5HO
 XY375Pzmpjm0LLjMkfa9xudi1E3UiZ1dJchpxgJqcUFiyJfwdT/4iAHUhSjujEsM3Sf/
 q03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757953933; x=1758558733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5Eu6cTYGaM68GXp1Vlq++QtfFF9C7vhajin8RFYxRU=;
 b=MUJUeC1bai4cQXzrfL5mhX47ifBww9hp+6ev6m7FywAtruCpIqlD585sfVEoermMHU
 yEBJIhGV5OpIxpYXTsVO55ZSlqixeM5xiifGw45ijIRlB/3VVqa/hJtlv30mudtsQaqm
 z9dfDUIF3ROd9Rp8n6PkHuiMnyMZQCxVp842flqnt87J+ID5ns+ei1kj22PPjY/71d5v
 cHbcrpxkH8hryhJ1cYmsBYIhVVQbTX1Of9a7a7HCjSBftsGVRygunjbgVI/Toz3Br/s7
 wmCBxYdGxTqGgm0o9L9La8HMG2U3aA22tp7Lbp/Fyubnmj6Wknv0fMCS/KO3hs1oAHcU
 sB7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPzKImWyxUmO0XQ8DgoaOlIMLM/3LMrcTj37qtVpO10zsww9yo8zgLMZUToaJTOjZbiMo=@dpdk.org
X-Gm-Message-State: AOJu0Yz6Xju21RqDlBIWSgJTKfShcMlzmuJ8M6wj56uC2VXOIAzDEg35
 /w/7uZgbIhnifaM8JWscYzXMXKBx7Pp66nAq9wG6HLE3ECjFyqzjtRLXIWlhc4TOpOE=
X-Gm-Gg: ASbGncvlxWB5WIo6pRy51sCappfOym8JwrhtQYiT+wF23t6X5j617tfn5jlMV+3RWns
 W6B9fXGXfWItO44e46pgKpsCe2D0GzZSN9jMdKAZ+v7gqD490OApB6nBsQyjwxZG2UTs1nWgoLZ
 5n34kSu6e8E1h7MBAkch/iqGvsnZ35811KCWa0DqfrfYMLgLHzdsl87NGlyylAY3aot4xMpAxMn
 RElgm5jDJqSmR6i6sabBFYJraFSkUbonfJ9Xz5L858Iwv0jlyCn+qQNw+5CUXUIRecG/DNYOgeC
 dC8WrOHcjNQ8fSGTvEOMszqDoV8wGuWq/z5ypW49KKIqWfTIVGd/VEaNCyma1foxUx+wQi7ZaB4
 K0uoVlKgp/rFLRRUF0Zai9mSGeFH9tpwGZbuMa/isZjnv31SePZOApZJQ2mAObxZJ5oWInnViMJ
 aAGs502AyQNQ==
X-Google-Smtp-Source: AGHT+IHbQJlHWXpwbXWyngUnA+CRadmKJNphOL4S1N2c5hWfmfKljUYt2ji0HIXzh/1CEegk90RLww==
X-Received: by 2002:a05:620a:a090:b0:811:ae92:e64 with SMTP id
 af79cd13be357-8240084e9d8mr1278336485a.60.1757953932402; 
 Mon, 15 Sep 2025 09:32:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c9846379sm814008785a.18.2025.09.15.09.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:32:12 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:32:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v12 1/1] ethdev: add link connector type
Message-ID: <20250915093208.6fccea5f@hermes.local>
In-Reply-To: <20250911103610.2405666-1-skori@marvell.com>
References: <20250911084943.2383151-1-skori@marvell.com>
 <20250911103610.2405666-1-skori@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 11 Sep 2025 16:04:57 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> Adding link connector parameter to provide the type
> of connection for a port like twisted pair, fiber etc.
> 
> Also added an API to convert the RTE_ETH_LINK_CONNECTOR_XXX
> to a readable string.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
> v11..v12:
>  - Increase size of link_connector field.
> v10..v11
>  - Fix review comments on documentation.
>  - Rebase on top of next-net:main branch.
> v9..v10:
>  - Rebase on top of next-net:main branch.
> 
>  app/test/test_ethdev_link.c            | 18 +++++----
>  doc/guides/rel_notes/release_25_11.rst | 25 ++++++++++++
>  lib/ethdev/rte_ethdev.c                | 45 ++++++++++++++++++++-
>  lib/ethdev/rte_ethdev.h                | 54 ++++++++++++++++++++++++++
>  4 files changed, 133 insertions(+), 9 deletions(-)


Queued this version to next-net
