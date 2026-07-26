Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E1C531F9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Jul 2026 17:56:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE1D4064C;
	Sun, 26 Jul 2026 19:56:28 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id BD35D402F1
 for <dev@dpdk.org>; Sun, 26 Jul 2026 19:56:26 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so1950919b3a.1
 for <dev@dpdk.org>; Sun, 26 Jul 2026 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785088586;
 x=1785693386; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C+w+KPJv9BWWLmj4wiG/ukzsgF61GgEldcahjrwsxUQ=;
 b=jXgFyxdhhKTMQOOD6FR8oTBFTQEZMM/6O6n0zI3NoVE4HxZPT2+waFvl4cD+EyRkcG
 qmNly+GRF8HAWAWk+s5QM1EtzQP4BkwaMTwzHyAp4jdJriK8HwvXGsoCHWc1LPYMnSkM
 vwXElGM0q55AjQVh+G+6pcKzRX1qUEXoHYDTsFyXvbfARx3Ctw05UOJNGdYCsHWFA51k
 dCBZ02o8BwgQQOdGwhJrjHXAFe5WxQePi4s9MYUP+v5sfrvxY6YyNKttNuNHBNZ11UDx
 ciXgVqOxP3CWNIDawuwfYeczRPeFXrBQYsKRtg7Q1GGnHxKTwhe9XnsxrmrayV7BpVxS
 GECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785088586; x=1785693386;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+w+KPJv9BWWLmj4wiG/ukzsgF61GgEldcahjrwsxUQ=;
 b=BE1WPakHi9joQCzHv392Emvu2PF/Ijp4cyZqBMb7YD7JiEH5ipyWqrgAptgM27Q7fq
 0mJRmb9bcSNBkiLYOBaiFLraiIz8hvrai4mToztgLUkQNooP8F/ULk9vgVhcv2/AwuSl
 yTdoPdrioT547La3QaCebKIjRVZpsQTxc5e97gNyOyh5Uk9x7IIw7kVuv9m8q8xe+Imt
 V157eNzzrY5eYS2loXm5fjEUqSoaMlQYhV86A5iPPQw4oaq1VjGb72aOGTFsJHCvICe+
 c0mps6cwQQ9zSkKaF/z+vHAoILpApFA0y3V4BVGFE9tnC1gMpEqetTRKM9wSlBAjaHkW
 /q3g==
X-Gm-Message-State: AOJu0Yxk1x6Es0elJyvxEY/Vu7XejycQ5uqo5nYCWKv9E64K0RCYvztr
 SsGl7iIy5USPMmJyPAm8SjUf0Ub+ydrABzbLUTvN5Qh645sPi3CykduqLsv2LqDciI4=
X-Gm-Gg: AR+sD129Q2iGacRu/F2p8hPUzhQ+2Atac69FpTILkj2XOz18mmCK61RVrpYAGVF3Bu3
 DKUQUVftv47jk5REWY/DGA2NpQKO5MVCZEn/jhCqEVY9OH/v75FvD2UVhVr0z8CvFILieO1a+JX
 C25UepRBfcLM1gseTmiwcepRLnI0hVs0HLtU+wljBv64PlDzt1q/mEcvYVrXTsijkkO584nliHl
 H+nCAyZiE6CIkSY0E61zEkweYQRYvXq75DbB2PPMTmf5qxFf0Yc89DnSOxvFTjJCFNVQXuzKD50
 nUkyQxH6xtnw9dDcrIw4yL3f2EV/4IbWf611RMes/A4MdCGfyWP6Z19Q58dR7GlDmoVdtxOi3Vp
 akACeYHAWEW2d4k3YdJ4pvPz/H1vvbXHt5hdmhxhbhKf2I5z0SZZWMXSmOC2iTl3BHRKUwmG8Pv
 fC7AlOkZA4/8Ekt4qS14y+d5V2sgYyhNGunZY49vEttk8=
X-Received: by 2002:a05:6a21:6906:b0:3c4:3672:ba2 with SMTP id
 adf61e73a8af0-3c67e0b26d1mr5397968637.71.1785088585872; 
 Sun, 26 Jul 2026 10:56:25 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc548f5dsm26720590eec.17.2026.07.26.10.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 10:56:25 -0700 (PDT)
Date: Sun, 26 Jul 2026 09:40:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, stable@dpdk.org, Artin
 Davari <artin.davari@broadcom.com>
Subject: Re: [PATCH v2] app/testpmd: fix segfault in flow rule parser
Message-ID: <20260726094055.08f4d0bc@phoenix.local>
In-Reply-To: <20260721190931.1321010-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260721174415.1317549-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260721190931.1321010-1-Mohammad-Shuab.Siddique@broadcom.com>
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

On Tue, 21 Jul 2026 13:09:31 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Artin Davari <artin.davari@broadcom.com>
> 
> Replace temporary stack arrays in the flow rule parser with static
> arrays in three parse functions - prefix spec, RSS type, and RSS
> queue handling - to prevent invalid pointer access during parsing
> of complex flow rules.
> 
> NEXT_ENTRY() expands to a compound literal, which has automatic
> storage duration when used inside a function body. The parser stores
> the resulting pointer in ctx->next[], which is dereferenced after the
> function returns, so the stack storage backing it is no longer valid
> by the time it is accessed. Declaring the arrays 'static const' gives
> them a lifetime that outlives the call, fixing the dangling pointer.
> 
> Fixes: c439a84f1a78 ("app/testpmd: fix build with MSVC on non-constant initializer")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Artin Davari <artin.davari@broadcom.com>
> ---

Applied to next-net
