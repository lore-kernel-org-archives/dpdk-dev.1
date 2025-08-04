Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FDC87FCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 15:42:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C75D4025D;
	Mon,  4 Aug 2025 17:42:00 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 45FA5400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 17:41:59 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso3977394f8f.3
 for <dev@dpdk.org>; Mon, 04 Aug 2025 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754322119;
 x=1754926919; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQJR8ZuyGRIltipB6+8S603hhzgeFZS++5aCG0XDqaQ=;
 b=ZADVH4eJmtrrstuqTh/rcqv6P8qWAWiatEP4igPqmTXgYDrA2t3u03BV2BqN/Txc2e
 jFuqDwWdyLgYP9LV8xEUPCGkPimo033F1DWJK3RYXBYg303xMKaB+cfoLePPlwd5JDq+
 V4au6x4demui4NTLXvf1Fe/WL72ILo1a1/V5VJkhj/VCjl4pu9jv3siLkNpFcDuroIat
 WRCWu8sIgWAbYqvRo27j2tb7fcLQrdIPZeAxBrty+2yeTAD73D7jbeJwRc8MotdXGbVj
 57GhpW1F4rTBJmr9b8rVxlvm85Ai9AXr7i4QXrhyi2OROo1GYyIlnRKZ/cgRp8lLxD87
 rBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754322119; x=1754926919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQJR8ZuyGRIltipB6+8S603hhzgeFZS++5aCG0XDqaQ=;
 b=nu8s+9w9b7B952OiWX43r7n8Ds254+QziPtwctYFEAaYUQOC2w5uUopl79u1EJQkVL
 sRw1hKgMH6Wqn2TODvaVreqUmq0oVJxDOL5QZAlGNZVcbjUq0E2iDY+3djMKuPLu3MnU
 K8C91gP5ftl95zOQKjNYuTo9bTNdCuPajshs9wfhwA4QhHmHvtMO3KZHoyPmkj/cwNjR
 hJAgJrF4lRklhnmQCYya9lOFW/1bbXoJRnP+2Bp1KRngwheQbM5gyYRyo1v0ehs7htt9
 DMT2N0u/SwjuqO33HfVSHyD7O6hM0I9h3apPR4j8yb9pFi+6S3XDGYvwcVf+vB8ttGEX
 2qhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgTKJnFRfvUNIQPzSsjQD+mbkzvc3UODgJoa18d+A0zUNU9R71TIYfzRF6kMWdUo7FJVA=@dpdk.org
X-Gm-Message-State: AOJu0Yw+xD4dfU67LZcqmE1jCyiF/IDJVLbBpHJgoJNj8m2xke+uwF2i
 6C2DklxoueuOPTEcBN7EMVO4En6NRuM4geunZ399somjOaZw8i6gdKfyv72LCYjLdKE=
X-Gm-Gg: ASbGncuvRjP4ifBG7TA8E5E0MSSJE/i4tkWyNZUbzIhNImvMcswr4mfJ8o7Nn1IZ5Ph
 FAE0r4cSVXvn71IU1ynNT5D7o6l1Tj3/R5sKBRd3p5lcWCrbVGeaN0snpibqaatWJZAGfZp1XQv
 AjKZMzyB+oGBzCTNHZ3l9lmBxAIbYUQhxuXghoY+VSgcSiMWUSYAMQ8FZzXCTEb7zeqnNC61Gu2
 zplSs3ggDY+sudUCTG9GhflevMI6oMco0BUoRbqJ8xCe80eXOC1hk8AeF6vZIQbSivMx17OkGGb
 hRN+/1A3TynPzwAoCgG66aPPGsK6rD8qKa9PaZNLrW0L8NJ3h8+vFy09es0qJapC1/fr3adwDxB
 pxz8XjfHfhpcsC7gAuQfrQghDuIhm2WHL7OqIE92N+QwxEfl4UFAs6LRtXiU+Ug8G7hqM5wWrOL
 c=
X-Google-Smtp-Source: AGHT+IHgPywckzLWFzzcntPhMVxiSTql7KkTa0ftISFicZoVfhG4DuO4MDS6qN6EwJ8u8RW3vumZMg==
X-Received: by 2002:a05:6000:2584:b0:3b7:61e5:a8a5 with SMTP id
 ffacd0b85a97d-3b8d94c48eemr7299824f8f.47.1754322118706; 
 Mon, 04 Aug 2025 08:41:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0b2d2fasm5803117f8f.50.2025.08.04.08.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:41:58 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:41:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>, Ed Czeck
 <ed.czeck@atomicrules.com>, John Miller <john.miller@atomicrules.com>,
 "Igor Russkikh" <irusskikh@marvell.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Satha Rao <skoteshwar@marvell.com>, "Harman
 Kalra" <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>, John Daley <johndale@cisco.com>,
 "Hyong Youb Kim" <hyonkim@cisco.com>, Dengdui Huang
 <huangdengdui@huawei.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Chaoyong He
 <chaoyong.he@corigine.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, "Andrew Rybchenko"
 <andrew.rybchenko@oktetlabs.ru>, Jerin Jacob <jerinj@marvell.com>, Maciej
 Czekaj <mczekaj@marvell.com>, Jian Wang <jianwang@trustnetic.com>, Maxime
 Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>, "Thomas Monjalon"
 <thomas@monjalon.net>, <dev@dpdk.org>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v3 1/2] ethdev: remove unnecessary type conversion
Message-ID: <20250804084148.182b56c1@hermes.local>
In-Reply-To: <20250804074733.55145-1-skori@marvell.com>
References: <20250512150732.65743-1-skori@marvell.com>
 <20250804074733.55145-1-skori@marvell.com>
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

On Mon, 4 Aug 2025 13:16:23 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
>=20
> As rte_eth_rx_queue_count() returns signed value to represent
> the error cases but internally invoked callback is returning
> unsigned value. Hence unnecessary type conversion is done.
>=20
> To avoid this typecasting from signed to unsigned, fixed
> return type of callback functions.
>=20
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Reviewed-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> ---

Queued to next-net for 25.11
