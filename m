Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB461C87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 15:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDD6E4025D;
	Mon,  4 Aug 2025 17:39:25 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 2BCCE400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 17:39:24 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so18169335e9.1
 for <dev@dpdk.org>; Mon, 04 Aug 2025 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754321964;
 x=1754926764; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rz9/Aja7hrBUPBO3RjnqohwBehxzb1u3RIpu0aa583M=;
 b=TGWgSj559Vv3sTWBY2ZU6bhODZM7GGQtFuGClttDf2TjWikCpvenICZ8xguPZOQbx8
 alsW8l9Hae6K60Oc1KSb4IFEiTuwMEdujARUqw3YXMuTvwhvJoVWalCAqSATpRdqEI8q
 gjfqNv1X1Jr1d44khdoCu/GlXUIVyBEP8b6DDl1Wo8v+x9tJR89vRM7W61j/WnBSH2WZ
 jPZPbpTvC1U1+o1qTXi+FBFkEJEm8z9vE5CjWBtuM9ce0dyySZsv6upy6fW/arjv2YU9
 AayJGHl+fZsy4Is4hsQDjh1v0Sy8BnV+k/I9IWMt/3I6IBpA2O7xl/uoeddqPNzKJJln
 Poug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754321964; x=1754926764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rz9/Aja7hrBUPBO3RjnqohwBehxzb1u3RIpu0aa583M=;
 b=Eiw4p2PtXBXmoaNTZevv0w62z9eAjegF68pb767C/WtNN3l3CTx7TZZj9BEDFE3KeD
 ClQ7VtO9jXqvcpoudZerrhVJN3ux6Pnqbs3bYmEugw0stbEWCPcYzQEm8ckZRIe/g28H
 X/4v40KeOFqixt/P9swCAYhk8EPLf6HtKfq4TM5cZrJRmGszkbRsHkMlNrj3f0yEJTuu
 H8OCwqaZN1pOWtmJ6mnAaPcWLE2TSQ0ERitF0y5HzW7Gphj9dMK/tYfXaYxD2HHlHfE/
 KBFmYfccw3axThL612GxTmmyJQdHId52irQVzvR7UAsy7CO96VWYOsOFjQ75uTAiSUTq
 kCzg==
X-Gm-Message-State: AOJu0Yz0KlKPJPE7QWginVHuCciTTG37ROCao5Is5laOK5vsiY/a2Ad9
 HZkYYyVpWd2Q3YOKepMGWUNwTtMCYJD0x+Q3A/9WWu0acQk4QMvgfpAzNt1r0FlOWOU=
X-Gm-Gg: ASbGnctBtEkCdapK+Kx3fq9VvvHV2rJKygc5SunDCEHDJmm0KADITawgmJm1pGxF1uA
 48TiXs4v15G1IaHDpQzjUqU+57YYr9M5YDS5+nLWRie9gjFhgFE7sLJoTSd8sPqzNYH/NQ3EhKX
 Gt4GJ2YGxFDjbnTzZzhONYo2mspyaBL8PDvqEncC0CiGZrp0MMnIFtHvdDtFum+fYBHemrOO9eK
 yIvQoGakZj/qOu0F8XPLOgus1lcv0pnZDhn1uurI5KOy+MK/5MpFep4RTUra+sZq+DbRu3l7+3y
 fLObrctc+M5yGNg/j4rlKpqmHgdwopGPyfVCogTir0T3z4C6KhCLRpv3Mtvhs7owUxg/cTVHugm
 4WQ4BhQZ4snc6BcA1WdqRzfRiKHkKS+cc6znpaOVDHQTyqdI6HWKRBQ5C3Cq3nQb6B+y39KPvII
 8=
X-Google-Smtp-Source: AGHT+IERNw4yIGzwya0kJXZsenGg2aKHmTaJp/zu/H/AzeAPnjVhCAuza/SoM+Ms0NVlWIZfdanq/A==
X-Received: by 2002:a05:600c:1d07:b0:456:2b4d:d752 with SMTP id
 5b1f17b1804b1-458b6b312fdmr81224595e9.20.1754321964386; 
 Mon, 04 Aug 2025 08:39:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459db3048bdsm43116985e9.29.2025.08.04.08.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:39:24 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:39:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Tetsuya Mukawa <mtetsuyah@gmail.com>, Vipin Varghese
 <Vipin.Varghese@amd.com>, Thiyagarjan P <Thiyagarajan.P@amd.com>, Ivan
 Malov <ivan.malov@arknetworks.am>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v4] net/null: Add fast mbuf release TX offload
Message-ID: <20250804083919.73fc7361@hermes.local>
In-Reply-To: <20250730140451.622906-1-mb@smartsharesystems.com>
References: <20250624181416.167181-1-mb@smartsharesystems.com>
 <20250730140451.622906-1-mb@smartsharesystems.com>
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

On Wed, 30 Jul 2025 14:04:51 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Added fast mbuf release, re-using the existing mbuf pool pointer
> in the queue structure.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
> v4:
> * Force the generic function called by the separate tx_pkt_burst callbacks
>   to be inlined.
> v3:
> * Use separate tx_pkt_burst callbacks depending on per-device TX offload
>   configuration. (Ivan Malov, Konstantin Ananyev)
> * Check TX offload configuration for mutually exclusive MBUF_FAST_FREE and
>   MULTI_SEGS flags. (Ivan Malov, Konstantin Ananyev)
> * Also announce MULTI_SEGS TX offload as a per-queue capability.
> v2:
> * Also announce the MBUF_FAST_FREE TX offload as a per-queue capability.
> * Added missing test of per-device MBUF_FAST_FREE TX offload configuration
>   when configuring the queue.

Queued to next-net for v25.11
