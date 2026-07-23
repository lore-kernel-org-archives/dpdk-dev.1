Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FDBC531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:32:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A099140658;
	Thu, 23 Jul 2026 10:32:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B4A2D4027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784795541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gHlm0bHk+7Rc9FH8cMJsIqeehY4pBbS+UjBH0Xl8iE=;
 b=R4uwu+LLAHVB0o9lnb3jydOqinjD9b6/EtOAcRNAqxZGM0ZfpyXLECP47HJBOPn+Do1VcH
 fhMJc9VMTdeztSe+MyGwCI7bV/B6vfzLqAOXpJYY5p/viyFURutzeQ7aY3YnFgUGvjhkw3
 locdmQINS8P0bSgQblFM8RRbTyLWl28=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-MnufwUgPMn2-XKH3yNltKA-1; Thu, 23 Jul 2026 04:32:19 -0400
X-MC-Unique: MnufwUgPMn2-XKH3yNltKA-1
X-Mimecast-MFC-AGG-ID: MnufwUgPMn2-XKH3yNltKA_1784795538
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb55ce6adso283149e87.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 01:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795538; x=1785400338;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7gHlm0bHk+7Rc9FH8cMJsIqeehY4pBbS+UjBH0Xl8iE=;
 b=p6jDWUynLcJyYt5Q4wro+FVqkmgDJCYGMPJyCTRwvZjfZow01xab6P+ll1qeAQXMJa
 /7oMyoHX1oS+kDTWuMW1rfa1mPZXXTdM1Xc2DNboNjWowiUZjHpntwhT7xclK9Un2/0m
 6nFBxnkQDa0dOaX/3I3H9CdOuPAsAOhmafzElDQi3L6YKfYWUk2ESJNmv4f5pCeqvvES
 JyfkfOl09hdnNE4c8jgNknKxDmzwNCTciUm9vQlWqTLoq6B0zYv8u4Pct/Wavi24o1L/
 VeUm4WICcpQpWPtlVVZ9aLtIkmXviMcuq1YGvKLrw2cchTm8dQJYZQxg3HbF/bnYMKCw
 8/Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNJGIlsxF9gvWS89BnSh516KBslASnEgKZPpzyoChVt7I3dqkEiIUzGJ4HCMuuzXBAm80=@dpdk.org
X-Gm-Message-State: AOJu0Yzfl8usqIdLpoPdkc0XYnNY25OnLWNhHogfZenxR0TLWtOlfoxN
 N9dK0vBu6VTlqMtx1JeaBHHrxutamfnsE+H62J0ldOoT7XzrUrPjSDjgabFoRmHcL3z+SSBX33E
 BltUF9vDJYg21WiN7PNH2zF7qO3DGjqa87oR9NPmZndcBid51nzHel51V8tPzb7YPES02Lt5Asd
 3L7EVLQcj7Z1ERN34tAr4=
X-Gm-Gg: AR+sD121kD917T4mpfcKGEJ+iAoWAu3E1BuK5McZChiQBGKi8+MxXrkrZaDuU5374Vv
 zI++C7qhc1a6RldwwT3KlGL1b0KsHM9/XQjLAqdaGpNDNxMWSi6/4vXN9TsncBFmA5Q9sNNmzB4
 kJhqLkqTox+SR15J1rNooevcIv+fZLSCrLaYwpPo49+E7KbYN1RgAcu27HZlxWkuSneI63pmeTJ
 Lfxb2xowCqWIwxparxK+IK+TDM+b1Ge/GbZG8D3MdgNs0wi
X-Received: by 2002:a05:6512:334a:b0:5b0:1abe:6b21 with SMTP id
 2adb3069b0e04-5b2b2f55b29mr459169e87.28.1784795538177; 
 Thu, 23 Jul 2026 01:32:18 -0700 (PDT)
X-Received: by 2002:a05:6512:334a:b0:5b0:1abe:6b21 with SMTP id
 2adb3069b0e04-5b2b2f55b29mr459150e87.28.1784795537691; Thu, 23 Jul 2026
 01:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260713110101.24218-1-dsosnowski@nvidia.com>
In-Reply-To: <20260713110101.24218-1-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 10:32:05 +0200
X-Gm-Features: AUfX_mwIAVO2f7EhE6ddhDXgVJa1Ng8bqdPfVYjirQUMixVlUfC5DHOQIB7il0k
Message-ID: <CAJFAV8yZtx1kL8Jrfnwuyau4d6xrrZof=PrBadMMtM4p6aiGBA@mail.gmail.com>
Subject: Re: [PATCH 26.11] net/mlx5: remove versioned symbols aliases
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PK4DHHninptuTjrZH_NCgur2L3bp88AVwcuseaagcBU_1784795538
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 13 Jul 2026 at 13:01, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> Version symbols added in [1] for functions:
>
> - rte_pmd_mlx5_driver_event_cb_register
> - rte_pmd_mlx5_driver_event_cb_unregister
> - rte_pmd_mlx5_enable_steering
> - rte_pmd_mlx5_disable_steering
>
> are not needed after ABI version bump.
> This patch removes versioned symbols.
>
> [1]: 556b2a33727a ("net/mlx5: add aliases for some promoted symbols")
>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

