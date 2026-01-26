Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C115D1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 21:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82A25402A0;
	Mon, 26 Jan 2026 22:29:42 +0100 (CET)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by mails.dpdk.org (Postfix) with ESMTP id 78C6C40289
 for <dev@dpdk.org>; Mon, 26 Jan 2026 22:29:41 +0100 (CET)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-56638fca064so1201241e0c.3
 for <dev@dpdk.org>; Mon, 26 Jan 2026 13:29:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769462981; cv=none;
 d=google.com; s=arc-20240605;
 b=MFg+skyzpWtlbLIZlVyCkUcZWkbNH9f4+h/FGVhtMNSn2FxJ6TH5wnaLTjFA9UFuci
 gX90+eImDuFuc2W/5zZjv4qOek3Yf3gRgMxRtKdGB0rtrrF6EBo4EO7Kna6+zDW3AZbN
 OBfQFfZl2me3taJLPH6TQ1V49Fw1ilbnG1yvpwnvRdDliXr+MFxzSMhxt+ThIH9qwg2y
 1ffJ7gotxfFhiBSfW3MgHq+7R5rVoSS+xuPLhbe3pODZ0jlpF9l6H7rXILod4ZRi8Y9c
 zcw7VOO0iyO1jGBMgmTgMFlRO5GXJcDElDku9JQfWa3XLf3r0CUJfT/106taXpmDvhK5
 r+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n7emWZaVZHwFncFDTuCqserCakzy7Anr6LN6ohfvV/k=;
 fh=7hGAxMJ0ahU9WdmcbH8esh2qqgZqbutD5AFuMCFFoQY=;
 b=j28WzNCG8UfSW/UtTb4woxXDkhHm6XP6X/foN8l9JDWmz7wSScNVGpq2+MzlB3h+Z6
 GefaUq1Bi4VIx+KIO67lHaSYU5bALedtHQNLTgbWn/1NlmGPURIJf+whe/29Vkc5RCX3
 YaLErYaZLhbGlDvm+NH5igkZcwC6a85tQ6UF42EUc30lL+n0oHIhUpX7PBBwAtpq/mxy
 qr6ThREBwkiAXbHdOL9B7k7VB2TibXlUovMw64zjvv9MkozBzQDdnna7Xv6QKtlDPkvz
 Rj6tYXSZGeQSScC9DC2Pftbb1XlBVsz6WG8zIIqqa6pAzh32ZC/IncYyHJgrS1z8Z4Oc
 N5Sg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769462981; x=1770067781; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n7emWZaVZHwFncFDTuCqserCakzy7Anr6LN6ohfvV/k=;
 b=VxpPXLvzaDviv7aCPLzO3PVthREUcUdPRXhMLY9AIEi8JHw3mdRXN6agKjBjYRdLqx
 fSk9R1AAXtXQ1R8Bmqzmu6ShBrL3KQai6kUXqO5stPUJTbYy/lVzEyalnKn5h5AjOAL0
 KAQESHMpOuY8z6jR5JXUylHs6lYNstMqynwCkRcPEpp2Bu22znlchCxGItZudfsDPOh1
 HmMZrDFYekrtWyaGu9ccL4RHJi0pSs/tItZscvh97k4FoKi/xJUj4/RMsGOFmvN5vAWX
 zrhIMegFy+eGmqj0Eekr3ziYTMFxhNmiboz6tp6VFQIlZdFFz8lASIv6+Roe06vnIqEx
 ++Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769462981; x=1770067781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7emWZaVZHwFncFDTuCqserCakzy7Anr6LN6ohfvV/k=;
 b=ewzS7jF0t2NOnc6eFBO5gt1ZmCuIQF0BVlk1+voQ41j0Fug7X2GkQ/WSmJchDZBOCz
 nBRk322nOHVtZ4phQ9oWS8knyILqzjVC/Ej2PlNIIIZIBcrmBeZHWxerZ8qbiGvW1kiy
 TvA/luOhpNXwMkBBL0MUI0uevYTL3PSiL85lPPsGKR98xa0jchIqbQlSr/aLobC2f1xr
 n3/cec4l/H9I5WrLvrw/EU3VPEt0gBkJ0dJXlzmK407tetCnWB908hCOnHHTrvk5VvTC
 qNaQXVSBy5JkIxn0BJ6Q/S58HWYJCHwtcKPufjIG8Lo4xFWZ3+urTBAlb25TpNuWwrpY
 8QWg==
X-Gm-Message-State: AOJu0YwLRgN6ikqdFRFQBgTwUnI00cbbeh4HrBZBAS+5QoP1IwVmh7DV
 UBzxr1bOMNVoLbPypZtwRZsMqi5RJVLsuTkLX/POO9EJvOHFFcIvHrB4gH0UkTVS0r7JbF2ATSE
 PSxB+gYh9nV4zfNIrEc4hKVWjn2PmL4I=
X-Gm-Gg: AZuq6aLen75vIQDw1WXgd7rdam56Ytsj8qpK3Mt1H1862eiO/CG9wnKLUQlVTsSeUNS
 kgho6zftQkA7yZebHLfIXc5TiZFRhrtK4pojVPO2mu3fS4lyaKdYKU48KD0eaQXJ+IULsngjJzX
 rkaqObJGvs8rK6x41TsaruiZy6eHzy16FIVqktCbrxCW2kCYF+CiO7Edj+i58dxU66z/WLyL8sJ
 eWE4NU4nqnwmbSP4iiBhAH3NG9YI8er5TfMEH3ZudBqqJyZ7HQAtSqhOZVfSzcDyrDMeXA=
X-Received: by 2002:a05:6102:390e:b0:5f1:c4d3:5b37 with SMTP id
 ada2fe7eead31-5f72365c140mr163355137.16.1769462980582; Mon, 26 Jan 2026
 13:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20260125223015.69190-1-scott.k.mitch1@gmail.com>
 <20260126080328.11567-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656B9@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656B9@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Mon, 26 Jan 2026 13:29:29 -0800
X-Gm-Features: AZwV_QhH56U4IPkqMkxgZ1UfqlweJ9Qnw_1iLfOgnH8p10rdM9uBbv-9H15D8zM
Message-ID: <CAFn2buAgv+cFBwDbZDZ2xJ+hGVxd0PTeH_qxRv9gJfk_QO9-7w@mail.gmail.com>
Subject: Re: [PATCH v14] eal: RTE_PTR_ADD/SUB API improvements
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, bruce.richardson@intel.com
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

> First of all, I think it's a huge improvement of the RTE_PTR_ADD/SUB macros to not discard qualifiers anymore.
> Silently discarding qualifiers will cause bugs (discarding volatile) and potentially degrade performance (discarding const).

Yay! It's been an iterative process but I agree it is converging to a
better result.

> And I agree with your approach of generally fixing instances where this qualifier-discarding property is abused across existing code.
> Qualifiers should only be explicitly discarded.
>
> Unfortunately, fixing the macros changes their behavior, which may be considered API breakage.
> Personally, I consider the qualifier-discarding property of the current macros a bug, which makes your patch a bug fix.
> I would like the opinion of other community members on this!
> It seems a patch can be both a bug fix and an API break. ;-)

I agree this is a breaking change for these APIs. Just to clarify that
is OK for inclusion in main (for next LTS) and just debating how/if we
backport, correct? If so, another option is to deprecate the existing
APIs, stop using them in DPDK, and introduce implementations in this
patch as a new API (e.g. RTE_PTR_ADD_TYPED) that is used instead.

> Second, I think RTE_INT_PTR_ADD/SUB macros are superfluous.
> Just use standard + and - operations when operating on integers, including "integers as pointers".
>
> I guess existing instances of RTE_PTR_ADD/SUB operating on "integers as pointers" can be fixed across existing code to either use standard +/- operators or - probably more correct - use actual pointer types instead of integer types.

Good topic. The current RTE_INT_PTR_ADD macros are doing 2 things:
1. Offsetting by an amount
2. Safely converting to void* to prevent bugs where compilers assume
aligned memory, which isn't guaranteed generally, and may crash at
runtime (which I did in my first attempt which preserved pointer
return type).

For (1), agreed for strict integer operation: use native operators
(e.g. + or -). I tried to take that approach in this PR for
clear-cut-cases.

For (2) I think there is still merit in having a macro to convert
between domains safley (e.g. int -> pointer). This macro
implementation would be the same as RTE_PTR_UNQUAL, but I think it's
worth adding an explicit macro bcz the semantics/motivation may be
different (and maybe we find a better way to do the conversion in the
future). I can add RTE_PTR_FROM_INT(..) or similar to see what people
think.
