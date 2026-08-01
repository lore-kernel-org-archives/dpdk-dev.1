Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8886C55172
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 14:59:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88D8A402BB;
	Sat,  1 Aug 2026 16:59:39 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8FD1E40299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 16:59:38 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ccf2360620so16732715ad.3
 for <dev@dpdk.org>; Sat, 01 Aug 2026 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785596377;
 x=1786201177; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aCcgGrToY5mMzGOZMcObCL4DEH4Y5iHFlgfMrZQqXIw=;
 b=gUdGWjakrzUUYGu0lF8IA9Vk55mQen/vrtsdA+SsdiQnv44NkDk74g/nnbM9knUz99
 5Ob1soyouRLw9vr49+5Rp0ZCr5n/9QP5zsw6DpczDKg20T5UciHo1X2w3Lm+3+9HkCZ0
 zSy38jIQsy9zjxb2qCwAXuwFN6ObRdMHffPDPGDfvhA6Gsw9+cWUNIpsAdO35TLYvjYm
 ecgRzBR2lxJwIqauNefrRpdKb4yU8kFZDy0jBKU4gawEfWm6+AUD/zl8FlEi+fj2Odg3
 SdxnhBkmyt55EsTHNnKoOaIfo1szRzdOWIvgAaGTLqiOfHXiX6uEi8lUye2bls72SNWO
 qXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785596377; x=1786201177;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aCcgGrToY5mMzGOZMcObCL4DEH4Y5iHFlgfMrZQqXIw=;
 b=c+HZq5MvkN+8tN1TtEcF0AB4YrqNA5lauH4pU1zYiIsHfJ6CwRa1+m5QrIT7HPx0oA
 bQR6k5/Aa1EjFhJFBp3J7fHKwuJi2GU0U3+fJfm922phAA8EjpqaAQP+0dnOURMoMVH7
 53hCCkIlbN+mkCgMzkqCIkv/6bIgwQbq8bzrNb3/QpXoZNN8xLRBezgilAO+lyUf9V9d
 Q0PHWHBet3PTtdqJuJz0QnhDWmg9mAae4eDan4uS7I+ZsDwRN9n6Sc/Wu/JgQCg+82sh
 vybHe9tUNGQ6bIzH/C6W8W/05XSG0HinD99q5bxGBKmt3up+zd23B1V4riTU0uA8nvCq
 J0QQ==
X-Gm-Message-State: AOJu0YzuRSUdfbVLjULFj/3pgThqrKmRbToE6noP1m8PmOXCWHQye9/c
 cODPH9ioDNAafCYDav7kzEUcF39fvY4PNT3/Prb24/VoWf1zPWTomlWjeIbgIF6P8sv3pkdGj0F
 1TkqnbLw=
X-Gm-Gg: AR+sD105MefbfBJTn4c8dfiTJsMBkAsE2CXfukAKVP6L5Se/7p/4Fn3mVVprw5Nztks
 VtbILq+ORBOQyrF7VPnEIhU3jXTnNpMpvBfefsKu++KlAXNGS47rBsr27LKP6dxcSn1IvsSaf9p
 CMmtPsv4XF1dWTeL83HRlJH4izAly186VqfY7sN1+sm/Z8F4lKdDJpPcSpab3nWaY2XQ8fg4T6o
 IIoCTBV1i7PmE0RgfR1BJua0zG7NbbuWQWB+g1xRYunaZBT1dOFZysiQMlSM2qbRkXe5kEGTLcO
 XOjV/oVsfG/NMXsxVUHkkVLiEzxbwIHiwOOzWzN9r/U1ZRm6Ea1d9PL6iwulEFyRDsD51jUrAn6
 MCbPJBGAfXpmBDq5uiciBH7D4/Ile1UV25Ut+8zfDJTAC9N6JXPrGg9uO8JMAr1HIsgAXKETWX+
 hFcChsBfYi1kwBZCxWXKUmaUyONYkNa6aN8T0YAfmo61P0Tx1+1rrYZX5zxo6YIWqxxh+TMNqjl
 NM+KMYLG4H3CuoAdIOG5kKUApeRPg==
X-Received: by 2002:a17:902:ea0c:b0:2cf:6f7f:55d8 with SMTP id
 d9443c01a7336-2d0523f76edmr37658625ad.37.1785596377249; 
 Sat, 01 Aug 2026 07:59:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e04491dsm25556227eec.16.2026.08.01.07.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 07:59:36 -0700 (PDT)
Date: Sat, 1 Aug 2026 07:59:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH] pile stack and mempool driver (resend)
Message-ID: <20260801075934.2f69d3a7@phoenix.local>
In-Reply-To: <20260801065358.981232-1-mb@smartsharesystems.com>
References: <20260801065358.981232-1-mb@smartsharesystems.com>
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

On Sat,  1 Aug 2026 06:53:58 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +__rte_diagnostic_push
> +#pragma GCC diagnostic ignored "-Warray-bounds"
> +#pragma GCC diagnostic ignored "-Wstringop-overread"

Ugh, no please don't fight the compiler.

> +	if (!(s->flags & RTE_STACK_F_PILE)) {
> +		ret =3D rte_stack_push(s, obj_table, 2 * STACK_SIZE);
> +		if (ret !=3D 0) {
> +			printf("[%s():%u] Excess objects push succeeded\n",
> +			       __func__, __LINE__);
> +			goto fail_test;
> +		}
>  	}
