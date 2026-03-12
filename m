Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB7106ACCB
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:33:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D3CD402C9;
	Thu, 12 Mar 2026 17:33:31 +0100 (CET)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3A3E2402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:33:29 +0100 (CET)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4648447e29bso503397b6e.0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773333208;
 x=1773938008; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DO6ZXL3v5SlEA8q99IScZBlfecTgr4ZFHrrAvfQBNZ4=;
 b=QdnCHtHEYS+GEao1cq8w1g9LZKnQowLLKyLb3duw3fmymVpP9sf8FJwWcbTaJfXX95
 1UWC7L+jwySSZpWNcMCZ8y7R7I+qzk2p2cGiBw2owtn7e0amdz7R348n4d0TNPISEgHg
 wyktc2RrDX67Q6OmfpBoXozNJ/cNu6eih619ewN5JtXxG5852o08o74F8zqgBM3ZGz6V
 bf3mwei/zEIjt38UwjgVnR2JOveytOZcsSGktQusgu8aAOK4/GynrvQBuas9X3qD4yQm
 pSI7hD4wsV/k2blVXKwqEEvIf+kCRK3X/vRU6qTjikA5b4ihj0zjRVw0nNm9MKR/F13Q
 q3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773333208; x=1773938008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DO6ZXL3v5SlEA8q99IScZBlfecTgr4ZFHrrAvfQBNZ4=;
 b=PxuPZMWCqOAAuugvETl6Z2CVJHhMGTb88SjYhfwTMylQ8NFLHSatQ+gyxSmFnbhtTR
 NIGsal7fCF+6Xpi8sVZUqGC3+7qpkQqNwtrfN4MWJ5LKbeXgdkvlEsDRtfhgqPCfUM4C
 z6w+CmLsk4Q2VVBC0NfuWlkVXBTz6wHuTgcRIgS2bJYoQdKHrOlUPkl9g/lvrReoyEcB
 E3rDQpg7mITav0oIKxHq2D2CsarqRZ5qQH793ThTQ5S+Ozjc3R0EU+RgbJJ7eDhWwIrg
 VRVbj7f0MR0RI/WM9MmBiCxlnKozu2P5UrfFMEMkLuSu7S9AR5qgpM3xvsGY5kEt92xP
 A6Aw==
X-Gm-Message-State: AOJu0YynBIeNDG5tfJS/JNqCSS+dMttvUA9v0b2hImFdeVDKdn581XsC
 nryhNXv+e2BuVfScqFZ6Ak4+qny6Ja97f0X6z9mU1qeK/7rS98vhuX2mJZMPKsX3TqE=
X-Gm-Gg: ATEYQzyF6KOwNLplUqOF1PB0EJVyOGl4cb8DuPzN4nSW+MpcYTmEWJ5vyzR+DZI7fDm
 slj+wF24cdHUyl2xbuNSKxzWVhwYIVGzqhKJMG44RnQmMZHF6fUXiYdMoxxn4fugk5KjER1bH7c
 3ZePdTIyX80jUeFfKX5RFL82JWJXorg0MZY9iSNdReZZn9k+LfTyXbNRBbBM1qOW4A/Cl2mFGFp
 hyfaFIAlWvaNeN/N/6gEtbJf+tdUUE0Krav26wBBzkJgAM1gaeaAdJBFJ/0+jg/54xen4BlyPrl
 vMO0Se2kSlCdnR2+u2Blo+5EkpYulW4qLB43tbGioPZhM89i3aSjZ0Z9yyPdNwumIOKIaJHRuRi
 CMSty9u7mDIeBLouZ4LAplCxv+J254tRgS8XBhpgwzt0ef3Ne9EJFrp2ievIUYOe7sPkAezs2Ed
 OZ3ZLzahU6hIq7I6RRy3QXhZkbqhVlfUkFmvc=
X-Received: by 2002:a05:6808:8911:10b0:467:42ab:2f69 with SMTP id
 5614622812f47-46742ab443bmr1790719b6e.34.1773333208377; 
 Thu, 12 Mar 2026 09:33:28 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41791432d87sm4575579fac.1.2026.03.12.09.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:33:28 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:33:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH] raw/ifpga: fix comma warnings
Message-ID: <20260312093325.3603220b@phoenix.local>
In-Reply-To: <abLpp8jbldpWY8Bf@bricha3-mobl1.ger.corp.intel.com>
References: <20260312002337.867771-1-stephen@networkplumber.org>
 <abKELl_UQ8uLhSTY@bricha3-mobl1.ger.corp.intel.com>
 <20260312090303.359d871a@phoenix.local>
 <abLpp8jbldpWY8Bf@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, 12 Mar 2026 16:28:23 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Yes, it's disabled for the drivers, but if we enable it for raw/ifpga
> driver, how come this macro doesn't give the warning when it uses the exa=
ct
> same structure as the original code?

Short answer, clang treats macros as special case for comma operator.

As always AI has longer answer...


Great question =E2=80=94 this is a well-known Clang behavior that trips peo=
ple up.

Clang's `-Wcomma` warning fires when it sees a comma operator where the lef=
t-hand side result is discarded, since that's often a bug (someone meant `&=
&` or `;` instead of `,`). The expression `(tmp =3D TAILQ_NEXT(dfl, node), =
1)` is a textbook trigger: the assignment result is discarded and only the =
`1` is used.

However, Clang deliberately suppresses most warnings =E2=80=94 including `-=
Wcomma` =E2=80=94 for code that originates from macro expansions. The ratio=
nale is that macro-expanded code is an established idiom the user didn't wr=
ite directly at that call site, so warning on it would generate noise that =
the caller can't reasonably fix. The warning logic checks whether the expre=
ssion's source location traces back to a macro expansion and, if so, skips =
the diagnostic.

So the two cases are semantically identical after preprocessing, but Clang'=
s diagnostic engine distinguishes them by source location:

**Inline version** =E2=80=94 the comma operator appears directly in your so=
urce code =E2=86=92 Clang assumes you wrote it intentionally and warns you =
in case you didn't.

**Macro version** =E2=80=94 the comma operator is inside `TAILQ_FOREACH_SAF=
E`'s expansion =E2=86=92 Clang sees the macro origin, treats it as an inten=
tional idiom, and suppresses the warning.

If you want to silence it in the inline case without rewriting the loop, yo=
u have a few options: cast the left side to `void` explicitly =E2=80=94 `((=
void)(tmp =3D TAILQ_NEXT(dfl, node)), 1)` =E2=80=94 which signals to Clang =
that the discard is intentional, or use a pragma to locally disable `-Wcomm=
a`, or just use the macro (which is the idiomatic approach for TAILQ iterat=
ion anyway).
