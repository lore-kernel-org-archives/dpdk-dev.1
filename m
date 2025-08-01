Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0526C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 22:55:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0C9D40A6E;
	Sat,  2 Aug 2025 00:55:56 +0200 (CEST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 by mails.dpdk.org (Postfix) with ESMTP id C1C7E4028F
 for <dev@dpdk.org>; Sat,  2 Aug 2025 00:55:54 +0200 (CEST)
Received: by mail-yb1-f182.google.com with SMTP id
 3f1490d57ef6-e8e19112e8fso873417276.1
 for <dev@dpdk.org>; Fri, 01 Aug 2025 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754088954;
 x=1754693754; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1+cvAz+BUAoVHy4NWc1s/YyDI+i5+RKkHsYxjgrwRI=;
 b=bMEjvgEmtWu9B6q10H7UYrCvVpw9gLNF5HL9unktFUQd1nOzS3JX+t9QlVjG6naadQ
 0m27/UkemaqGFAcNQBoa9mvvfr+/bNYKr5RSgu/IIeaxoxf/Pl6rA5s26pvx6+uUeTk+
 sVIbRujrU96Cy6E0F/N+47sNJqlFMepIJfFI/Pw/4QZF7fCHbCs9N2TK3Thf86Xwr986
 bis1Sv2xZLGdRBMKqZh7yqZyFJK/Z9U8mL5c3HnpljvCpXtmAE94ZFXwSNy+x6r/OlHa
 pVPNsZFYs8dUbOaE5z21wbD1vBOyAWT1/ohFZuG4TUm9nJYXJIqlVFArwVLqc28Fdsii
 v42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754088954; x=1754693754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1+cvAz+BUAoVHy4NWc1s/YyDI+i5+RKkHsYxjgrwRI=;
 b=tgnQZjemhssO6E3breGWh58J4xR6xxa1ES/t5cvyTIZuSGkxzxVbGt6J2XyptK3v/6
 A6E16tXPlGmsahIj0sawwqZam2hEbiFZEsJSgnmQvBiSefVI3aGiU6vTMq7oy6A1Go7F
 Cu2RKMbHlamiEglDhkupsD+SO4YdB5vfflukCfLHcu7JIccses8AidkIOdar74q43GXc
 PpyI/79H1luX7Uosbhxjx09ivGHpFbsfiiPOoVTufxOQ5mrFUG03UTiEtJ/q9bkOjwbp
 J0nij3LpFG0ZmIbiT8YDUyx8jeDnp9+x/innUGeGVn8ZF4f3VYzmoe3L3IuEAznnuMeB
 WPfg==
X-Gm-Message-State: AOJu0Yypdaobwy8BtROw31vgHeNGc+QSmKRN8tVJx7h7Bb9Zb9KjybtU
 MAfL/Kjy2rXam5x359UYsR6zaymUjNyYWAaUl3NRsQJZRV7gU24R838gYk2R58dzDa4=
X-Gm-Gg: ASbGnctluKcTY4Yt7L5fEhUcuIdes+Eox+tA2w6SvP0e2lJGutWp1bPZTXDymBeA0RL
 015djcr8ZQdGl3oGQXr+muoqAOm5tdPc/Ihm2SGXRH6rlS8WvMmaHsZhVq98apfk7NLq6xS7Mjh
 kWzmCoGvf5E1xakpYavOL/hkMnWIMfGNM6SQWHbpvI3eyaLWEQjrn3pwmPoHp3L2UsRkl5eV55u
 npMaWOqPfClKoQiZDDkg/MgvsgFnmBFnYSkXEkXSaZ5iuSijIEWGQX3dXWKT6lky87ribdJNhns
 dpANXRAMxmRI2fXGrn7L2VMwO/U6k4rixQTYCzCd14oZ1D0FChynYYCiLFUDXtNDxo14qJMd9Ah
 V9wVdwFLv1QTU58WFJWpNa+nZpsHbjMaVWBbcEPC5H7Iq+DMNjNk7Ks2UUIrwd6ANIDgBrDaZtG
 I=
X-Google-Smtp-Source: AGHT+IHfBy5bB0GWaxGY+0JUm31gpBcIulzS8uKz10lYpw3cwJqZ4SLtvO9gvDXV3PiBMEAFmXAvjA==
X-Received: by 2002:a05:6902:4106:b0:e8d:b3b5:cb83 with SMTP id
 3f1490d57ef6-e8fee1b5174mr1708213276.29.1754088954028; 
 Fri, 01 Aug 2025 15:55:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e8fd38c3ccdsm1829907276.45.2025.08.01.15.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 15:55:53 -0700 (PDT)
Date: Fri, 1 Aug 2025 15:55:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Ori Kam <orika@nvidia.com>, Aman Singh
 <aman.deep.singh@intel.com>, Gregory Etelson <getelson@nvidia.com>
Subject: Re: [PATCH] app/testpmd: fix mask in random flow item definition
Message-ID: <20250801155550.41558656@hermes.local>
In-Reply-To: <20250730113243.197386-1-mkashani@nvidia.com>
References: <20250730113243.197386-1-mkashani@nvidia.com>
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

On Wed, 30 Jul 2025 14:32:43 +0300
Maayan Kashani <mkashani@nvidia.com> wrote:

> A previous patch addressing an ASAN global-buffer-overflow issue
> inadvertently degraded the random mask value translation.
> Specifically, changing the mask from 0xffff to 0x0000ffff caused
> the value to be shifted left by 16 bits, since Testpmd
> defines arg::mask as a byte array.
> 
> Independent of the ASAN fix, the random item mask specification
> was invalid at the API level: random items require a 32-bit mask,
> but only a 16-bit mask was being used.
> 
> The correct mask for this use case is 0xffffffff.
> This fix restores the correct random value translation
> by applying the proper 32-bit mask and
> addresses the original ASAN issue.
> 
> Fixes: 9a18070e3fe4 ("app/testpmd: fix flow random item token")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  app/test-pmd/cmdline_flow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
> index 83d398f8eea..38e751f3f3c 100644
> --- a/app/test-pmd/cmdline_flow.c
> +++ b/app/test-pmd/cmdline_flow.c
> @@ -5591,7 +5591,7 @@ static const struct token token_list[] = {
>  		.next = NEXT(item_random, NEXT_ENTRY(COMMON_UNSIGNED),
>  			     item_param),
>  		.args = ARGS(ARGS_ENTRY_MASK(struct rte_flow_item_random,
> -					     value, "\x00\x00\xff\xff")),
> +					     value, "\xff\xff\xff\xff")),
>  	},
>  	[ITEM_GRE_KEY] = {
>  		.name = "gre_key",

Applied to next-net


Using initialized strings as proxy for a byte array has lead to overflow
bugs and warnings on some compilers. Perhaps this might cause problems later.
