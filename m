Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77097C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 15:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A89B040285;
	Tue, 11 Aug 2026 17:48:40 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id D05774027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 17:48:39 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-81f36179dd5so43265797b3.2
 for <dev@dpdk.org>; Tue, 11 Aug 2026 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786463319;
 x=1787068119; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rc5fhmcGTonYyJoF1OjIotjpNnscea8fiAWeT8fkYxk=;
 b=o+iQXA4Zo17c5kOrM2ssmLozfhspU2bw4x1UbldIbbnrsk6M2epys2IqF+xPIX7fSJ
 tBk3YJk/NOLDn83Q/CpmxPcbwD6M+Yt1u5Y95HDOv0/LQ8zKi8C44XHkEB1X+EYdijJk
 qsDiaADV1jnI4JzYAO6MTq+QFdLpjmYkTb7t6p0sBffgKMtrbroyx/hU09tVao5sB6qp
 CQK4c4/dOcRJFXD6LOPsNP6LS1loK+fQvuQeh/+yCLQCHxjVYeRHMCBAkiuJyBRmsQPQ
 iA10xRNXCgNB4RisoSP4JG4mmm3e3NByiwgcLtyOGMROQ5sv1zc1eHB17E2eZrI2jSr+
 353g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463319; x=1787068119;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rc5fhmcGTonYyJoF1OjIotjpNnscea8fiAWeT8fkYxk=;
 b=XJImoAcsmlAcJQ4FAQTmRVcwucoIBGvOZobWAhv+8AD/p+oI/s9xTtCSjaZB9MAh4Y
 yGep+OkJM+tZO7qPPAhvpKIrnPLtKgkvt1crky5oDhhh0RvXAEVTeoW84RNpljDO9RNb
 /qvpw5aq7PoSMaIFmW//mnduO5uBh1DH9juFZ2jdRj3OQKprg64asgBsOcfC0oc0JH7y
 MeUr2IeMt1Om/1JhnoWKrvAQkw3b0ZyAzxFAQk8MbFEdpHxr7x69oyOYzwHrSGVGiZOM
 vZvGwveZ/D84fkyyugVbzgpZ+Vpd+Lq+guBITmKIpLvvOy69+0R3pJjLwUnF3EIDiTnV
 tf1w==
X-Gm-Message-State: AOJu0Yw32E01FMlc7Uke0G0kS76aIix4TGkQXTaW09EVwFMpH0PJOGUo
 49/kZSgBH2IEOuFMW7unG9l/a4L0OB8rIAKBp2Mcy4ZFKPA8kYFPxOUuQMkP0OIAJvH4eAjbwap
 iA//f
X-Gm-Gg: AR+sD11ENBKsqxR9xwfR3VjzRE/apfT3z7Ck1/IncSS6GUJA1E2FxICG3QOGilbzjuv
 /aAF7R5qs78GL+5DYHq4m8CFSe0XvX36B2iBYLtPfgLrYMCOGHbpHtoM75zdfi/3qr6oja5bF4d
 JYHBAJLORxrfGvJwunul1cUpbpnmZBYoEzPad4BmRUxH95z27+t6ytD102R+19P2gXZT5b5Huto
 jY9YESJiWmQvor/xf5luTTZBeIMlAGG0xjgAT3fDv4IX0cTEP+BUwQcl2wBGTBi62YOWte+FLHD
 tqd9FWJkVsu9WvfLjQ82y4vwG4qO54m9Le0CnWTOgGLOPeIXbcDXlZgJCgw5xjWOD8Dk/3W2IJE
 BJrW/6bYSHcN22/N1vIuve9FnXQsDu7FF0aq5pjcaOWbgkEQ9PsdvA4Z/lEbV/6nUWPY5uivHu+
 y3m6K5ztPirP5rBME/fe53tEQ4/Km/rSJR2UqJDSGo4kT2g3XkJIGaDdrVruNJYxJFdWj9350Wj
 CgLHQG+U2A0s68/lTPeRO22iVKlow==
X-Received: by 2002:a05:690c:884:b0:81e:8577:d044 with SMTP id
 00721157ae682-82f2dc951e5mr28191727b3.35.1786463319034; 
 Tue, 11 Aug 2026 08:48:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-82ebdb7bad4sm11909307b3.12.2026.08.11.08.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:48:38 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:48:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] stack: improve source code readability
Message-ID: <20260811084835.7ca64d35@phoenix.local>
In-Reply-To: <20260811121727.1706225-1-mb@smartsharesystems.com>
References: <20260811121727.1706225-1-mb@smartsharesystems.com>
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

On Tue, 11 Aug 2026 12:17:27 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Fixed misleading local variable names in the standard stack,
> for improved source code readability.
> No functional change.
>=20
> Fixes: 05d3b5283cc1 ("stack: introduce stack library")
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

Makes sense, but drop Fixes since that implies it is a bug fix.
Cleanups don't need fixes.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
