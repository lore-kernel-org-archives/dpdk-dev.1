Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC343112584F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:32:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54E0C410D0;
	Wed, 11 Mar 2026 17:32:24 +0100 (CET)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48]) by mails.dpdk.org (Postfix) with ESMTP id C068F410D0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:32:22 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7d744d9acbeso54843a34.1
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773246742;
 x=1773851542; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIE9597VF+Ph/ZBynvLg/7nnsx02dCXelrJYEJ/iQyY=;
 b=ie3nRWnd+PfzKorbG7U+kJC2SffeHEE0eP1hiF/JN0aNkggKgBuCgvX21xHJUMcQkK
 3qEZTbdHqXqoGvYM7t8vPuXNsmocoHybv5K3LtXlzKznHkIH8RjdrdjVccj1jI/zkRAS
 Zh+Y4WJ6ZqFjZ8K9qFkw57nhbqr9ExiM+J3/dyaLa9D3h1ODGddHw2AiQKjmKoYaVBu/
 3ZQfk0lCEXtq6tis9EydEx+2mxKXJ0Qi6hjjGyZpJSKtpKmtr2qTTTfihA7jmrIA5FKI
 sV0W2lOEj5h1QI3F6ZVJhBm+oAYAbLHaOv7+koZ9q9TQ4Wh50bJ3bhSWjJr+Y+XuXbV2
 dKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246742; x=1773851542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qIE9597VF+Ph/ZBynvLg/7nnsx02dCXelrJYEJ/iQyY=;
 b=jZvUCrPFER3B7QzJD3Ex/lBofHFZhDRab3h4SmpaHI/kOrpJeo9z58se/H/CNOQQ4+
 mPCGcBsSKp9kYSBjl7G5p8qSBz/DlviK+wYg+0Hb4ouGG/Px+u2NRIV8NdNAXsEpQXIY
 wMRfnCvECvrbslArku4A7jXUApElkM/ADqYId9tjr+1KaDKRHa4GShBLrzkQw46Sv+RP
 vFbIsNaxBJKHSVMUHieS/Jq2SV2UsDmJ4J9I/VN4yxkqv98L9XnbKP3O8RBS+2cMN52C
 JOHBQDTF/Jo0EqB4lSK7C2pE8WnVQZEdbnvKCMRZT42ZkgcaHAWkouOJdnTKDBVj4un3
 wHGQ==
X-Gm-Message-State: AOJu0Yz+FTJfaQi+cR2Xh2YtHCZFEj9xgk0rqsZfs0VI0M8Vuulk9doT
 sIMskkBnVrIggyafQ3Lo1IE+TIfNLsE5KmoioZpE/nMv+KoKQ8bho4qArV7oq2etfV4=
X-Gm-Gg: ATEYQzxeG1+JEab81PlBj4XKs06GrqGMzyyVDrmXYYO5KaAZx9Mc73FV6oMsk+cSTUM
 WgpCfB6UekPPmOUalqsGzHYKaUA0bxEce8753xxWrvpVBkuYT59cNBki2F7ajWJfhI4J0W8kQ6F
 l/wcm1IjR84rsqO+hQ3qzYBXg3G9sOaOeHExCnLdN4BGZu32HHW4KXKR1Mo/PPfwsJxdkrK4Y0a
 4FSVNQn02PX5Y2Rhwehz3wHK2jiotJvZkiKOwJugPgHqs9fYfkMn3dS+acyp+QuSpl1j8+7Gy7+
 JKsncJsZl2bGqRWe6ojn1rptnTuAd8ZEOYSgW3hIIGPkboc6LnwsqSIvbU/fGdZ3tELPPAUoB3q
 auTq9W293VBQ2wy1KCM5/NTRmZ4gqLnWgwVa0qqqnNKUhcyEpd2A+q/r8+/i2MiLt/139pnDMTy
 RuKPrjkPVBBVEobrW6zTYxBmD2VaOTHlD84uo=
X-Received: by 2002:a05:6820:1744:b0:67a:405:7ffc with SMTP id
 006d021491bc7-67bc8878418mr1832010eaf.5.1773246741856; 
 Wed, 11 Mar 2026 09:32:21 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc93061f2sm1686372eaf.10.2026.03.11.09.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:32:21 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:31:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 07/10] net/mlx5: add testpmd command to query
 per-queue rate limit
Message-ID: <20260311093115.091da01e@phoenix.local>
In-Reply-To: <20260310232653.2935764-8-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-8-vjardin@free.fr>
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

On Wed, 11 Mar 2026 00:26:50 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> Add a new testpmd command to display the per-queue packet pacing
> rate limit state, including the PP index from both driver state
> and FW SQ context readback:
>=20
>   testpmd> mlx5 port <port_id> txq <queue_id> rate show =20
>=20
> This helps verify that the FW actually applied the PP index to
> the SQ after setting a per-queue rate limit.
>=20
> Expose a new PMD API rte_pmd_mlx5_txq_rate_limit_query() that
> queries txq_ctrl->rl for driver state and mlx5_devx_cmd_query_sq()
> for the FW packet_pacing_rate_limit_index field.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

This was obvious to me, but not AI...


The testpmd query command is implemented as an mlx5-specific=20
 mlx5 port <id> txq <id> rate show=20
command, but per-queue rate limiting is an
ethdev-level feature (rte_eth_set_queue_rate_limit exists for any PMD).
The query side should also be generic =E2=80=94 add a testpmd command like
  show port <id> txq <id> rate
that calls the new
rte_eth_get_queue_rate_limit().=20


Once again, AI sees the trees not the forest!
