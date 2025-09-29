Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56ACAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 16:33:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A5134064E;
	Mon, 29 Sep 2025 18:33:31 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id A6831402EB
 for <dev@dpdk.org>; Mon, 29 Sep 2025 18:33:29 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8571a0947d1so560493185a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759163609;
 x=1759768409; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vm9e2QWqyJ4SORGBvFJdxgVeiOkv05+fAqiGOMrxEiA=;
 b=VWAAsrl4MDD4+lSb9YyJWAe3sU+dVhnEcFeBzxHOsdRP37bUpuAHC/piEpZNKLuQd5
 nAWy37PH4hDWXXcq/Dq8VaFkGKJJE40DR/kOgkp6bojpW1Ao4yuKj8Mwx/KZHrrzewSz
 kyHIKunX2V0IM6fWgfn7c9v0R5wVARkOlt6Ak8GH+G+gPPieuiaHO7SODg90/AbtTVQh
 kvz15BirjaPuaLHMkb8HnIGeaALvo7lbqoeUgY4bwV2qWTnQ5D0nD2ZwoJf7RpAfOJnW
 n0/2YO+BNLRhJttYQJmN0X6kTLU2NZf2pfiSRaw3gmzqsdWTLY2oNOBSW6xo9c/Jun+V
 MWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759163609; x=1759768409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vm9e2QWqyJ4SORGBvFJdxgVeiOkv05+fAqiGOMrxEiA=;
 b=i6jky5oygmi+PKtk4QBQUsQGEQ5e9LXGqX0BqAa3isomF4QdgBT5M5DGFzqpJcxZK0
 O+2dvISDMKdcPvpYm5U3vki4tMKu7WIe0KP6H12cJllJm7fLsH5sRII6L7DYIrj95o5V
 Mfy16+BlT1H/10SBC0U+bpvUF9kALC5K5e1bhoNF8ayESrtuHJvRxTiF78GL4suAysEb
 uDmvdDA5Upt9PYYgQDT9Y3FJaOm0elx1jSjlABMisc/xLLMAPKG9ojz+H2HlV+rMA6yd
 FGNB7SwmIF7D8Mr30uajC+8bOrS5sGAvK1zYBasf7aXkC1efz2XuMRgmHKyqCTMS2Vpg
 NB+g==
X-Gm-Message-State: AOJu0YyX3o+tuNkjexDeVjJa1wfBTMW91ptZ02Q63qUYnn+ZKzT6mD8U
 aV3PMMe4dE3wbY59KSEfNW0irWoyWWexHLfApCoyHqCodQJRezF+fvHke14sz7UPS3jXJareJW+
 2UNOwzgM=
X-Gm-Gg: ASbGncuxJ+g0vlMpk787M0aEHNXxYC7qUqupoiabfNQubRjszw8M6FzezBVOkx6tx1w
 EOoycIAcQbdE4PosNOzeHpMGa7Ovwf6rj0gLpxwj/OIKXSaY+M7dAGbvd7ag3aY0h7wzAzvCdCC
 gcyIRMCnUe6vgFtVc2nM+9nHITdnT7nt3Di+Pqcuj9a1C5JxENYrSy6ypyR9Cjm4wUYvtKLbRbs
 QZAI+GQq5I8Fx6BAA5d/iiusKHnOD0wpg4RZyVxntT/gRWxmWOZLM3JioMe703S4OA+Wv8JMvk3
 7sglSQazUc7CHkKfSz4Y8cOq9hWLPbVafG+3CrpBSe2dbsLwy4Px3oRv/xohC8xoFJAWfIuXtSe
 sfVrZqfWANIN/3GaO+6G0LXR8pPxnnoa5uSkOHLfHyiDFSQYpdntT6z/lH/nVdn/OMIMKPr68E7
 G/S1AW9gGhuQ==
X-Google-Smtp-Source: AGHT+IEFg21Vd7+3YZVC3Ef+apNp+DyGzCW/ZqulU28kvh6B8g2etuaqA+h4CeXXYDM0ly1RD4zHcA==
X-Received: by 2002:a05:620a:9575:b0:855:9556:8ec8 with SMTP id
 af79cd13be357-86ee0f482d5mr143645185a.26.1759163608658; 
 Mon, 29 Sep 2025 09:33:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c27099635sm894604885a.2.2025.09.29.09.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:33:27 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:33:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC 0/3] net/ntnic: prefix global symbols
Message-ID: <20250929093323.67dc12f6@hermes.local>
In-Reply-To: <VE1P190MB08308308E532B306FCBCAE3C801BA@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <20250926162534.401577-1-stephen@networkplumber.org>
 <VE1P190MB08308308E532B306FCBCAE3C801BA@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
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

On Mon, 29 Sep 2025 15:59:36 +0000
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> Hi!
> 
> The patch series looks good.
> Only one thought from my side is about consistency between prefixes for global symbols for variables and functions.
> 
> For functions, we use the prefix "nthw_*"; however, the patch series uses the prefix "ntnic_" for global variables.
> Will it be better to keep the same prefix for functions and variables?
> If there is no strict rule, we may keep "ntnic_".
> 
> On 26.09.2025, 19:25, "Stephen Hemminger" <stephen@networkplumber.org> wrote:
> 
> The ntnic driver in next-net is not consitent in prefixing
> all global symbols.
> 
> Stephen Hemminger (3):
>   net/ntnic: rename nt_log_ types
>   net/ntnic: rename hwlock
>   net/ntnic: make flow_lock local
> 
>  drivers/net/ntnic/include/create_elements.h   |  2 --
>  .../ntnic/include/stream_binary_flow_api.h    |  2 +-
>  drivers/net/ntnic/ntlog/ntlog.h               | 16 +++++++-------
>  drivers/net/ntnic/ntnic_ethdev.c              | 22 +++++++++----------
>  drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 10 ++++-----
>  5 files changed, 25 insertions(+), 27 deletions(-)
> 
> --
> 2.47.3

Sure ntnic_ and nthw_ are both ok, you choose where needed.
