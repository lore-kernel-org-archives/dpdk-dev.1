Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB512C282EC
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 21:26:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3399402DD;
	Wed,  5 Mar 2025 22:26:17 +0100 (CET)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 039E540279
 for <dev@dpdk.org>; Wed,  5 Mar 2025 22:26:17 +0100 (CET)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-6f47ed1f40dso55963287b3.1
 for <dev@dpdk.org>; Wed, 05 Mar 2025 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741209976; x=1741814776; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2ylWT43UKxLzgF7Y1oPjjKPaHVO5JPSq37Wjr4+0ig=;
 b=fZ4nFR78/7n5pzR2E7/hpVBitGEKmCLzYMKaiDSRxN5hGJzQrYqM5ddWI6foXujjxk
 B5oeLc7BsXgLlBrt4xRAyxFMLAxqVKOoOArdV0TOi5GVwbqTAemu3+vRnMTRXgghqbkE
 GEoGJjJkqYmk1RdySv7A2LTSiZrS9t9H+dr/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741209976; x=1741814776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2ylWT43UKxLzgF7Y1oPjjKPaHVO5JPSq37Wjr4+0ig=;
 b=JagNBw/WRZogJ1LQ2lxqI84QhjRFkKapHLNb4msfjVD0k4EBNq4E/M06gTKRCMQxzF
 57Wo9/XLWBPtoS4+/4V9ZIhIGeOb6ISeYVQXrPOUbaKZu3owZibRJXUc2ntVDN0XSFb8
 EOWEl0FlmoVNKobU0JJSuuzYldYH+ZYirZ1jEu3W0mYclm3FgfRkBhrxb+5QYOpo92Gp
 6cR34/5V5CKNV+9aAuryRL9Zo3zg/RUE9ZgJXmkJ+8wXt0ijR2Ey1bsJi+DXlJvzPy6G
 ATcSgt5tvY2bz9shQNhNXACtRGgXUN3UVkLHA204WXdb+Ue9bAs1oss1rr/Cu6pGYlO4
 dvDA==
X-Gm-Message-State: AOJu0Yz3mJmPr+MlKjvj+1mSJrWAVIH9Gjx15BIjhenV//jGakd7IrNx
 PmsKbPYcUyt1LVUG+Ceb5B+KL2tUUYjbt6nsFMqPS+J3nQvfW1cT86am/TCL+S+7cHqcFZZEQx4
 r/M1SCB8ee6a6j667rO0I8XGFnp49A11ZRMrObGP+CKgjc2vl
X-Gm-Gg: ASbGncsA2/H8aE/oSIz9ySNJ1E8u8YYf4Q34R7L69gXQ6fbFVQUluqPjZxvBcCxzlJT
 G99OXAbMRGQpQmiKjyG0e9zfqbgB0MYgx60dz0JjKQTgZdrtiDKcY7KccMKsmY31BqYnSw36K0y
 lnVbcmilgd6wx3n5cENBrBf2A08OW+QmtREacnp8ICwnXyJjNLtWFKVMyNPBYJ
X-Google-Smtp-Source: AGHT+IFIa1YrdwxIvSAmh6EA3Nl3ijKhgAUw6SBLcTl2TRmv3DEZI46qVqdXUSzfkLE+PjpP+REvlyNPvSIWnkAWZv4=
X-Received: by 2002:a05:690c:3583:b0:6f9:8916:3b66 with SMTP id
 00721157ae682-6fda2f30972mr64008727b3.12.1741209976390; Wed, 05 Mar 2025
 13:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-3-luca.vizzarro@arm.com>
In-Reply-To: <20250224132823.196509-3-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 5 Mar 2025 16:26:05 -0500
X-Gm-Features: AQ5f1JqPRw0UYpwVtAjqQifra8w3RH1GeB5-CrJaafWcxZDiaZ6eFhRaoxbJBMA
Message-ID: <CABD7UXNL5n0EKxh_XiM+N6jWjCmw_mdY5KH8_hupGsENt5P-dQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dts: use topology in smoke tests
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

On Mon, Feb 24, 2025 at 8:30=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> The smoke tests where wrongly using all the node's ports for the smoke
> tests. Ensure only the ports specified in the current topology are used.
<snip>

Should be were, not where

> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
