Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18544C531C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Jul 2026 17:56:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AAD740269;
	Sun, 26 Jul 2026 19:56:26 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id C94C040150
 for <dev@dpdk.org>; Sun, 26 Jul 2026 19:56:23 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cace91f112so20859735ad.0
 for <dev@dpdk.org>; Sun, 26 Jul 2026 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785088583;
 x=1785693383; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aVyaXX9PbZRyf/EqqndTVv+BoSU3Sar/x3+oc20mtOc=;
 b=kRpC98GtNrk9B9SS0cBd57TB3Oz6MQr+9zV6k4PAl5hQnb2TauVEr2SLzAI21pzajX
 broE0Ik7bJHIyCUNbL48HTk68V7QO6ExIlOdc0bC6wd/A+aOgBavxjyGTFbDAUk7zP0w
 /AxTqUQ6sv9MtDwdm3CVj9HALJ749/ezsMUYamg1ieZzd9EMGdIDMiB2GEGlip2oU38L
 WLnmSIZX1GiLIYX25oCTRpGRTxnUwOEiONi6SON+wQf91Zs4fqI4AlKAkXbK3tHm1mej
 IXdVWBj+ZfPXrp96AVpW4DtmwBJ50MujIKvf9A8yEelCLjACDV9r3LAUU/v5ny5krmjl
 8Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785088583; x=1785693383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aVyaXX9PbZRyf/EqqndTVv+BoSU3Sar/x3+oc20mtOc=;
 b=glIXNQz7DcuwJqYB9WOwijReJTLd/ID5na4zVIAZB+woJYDEGTdARV+wMqx8x5PByl
 Rj+xCsKS4QAxWxSWx8YRJDB5oE7BlPU78yNMXFf/hcuMkQb3Bt1f3E4KRA2dQv+2qELN
 x6jBhHnG1EqIdFUBBrozg+UoKTDiTfEq+KX6QYSyfx7rUklBwMgCH+4IPSLsJ3F2KFrR
 Rw6Hq39dd1CGhB7Mmq7kQHFHmeOp0hBESWeIxk8128tb+5qLpIE5cbLnXYjNyATuo63x
 IzcU73zzPoQf88PPfD7X1KHkI70A86RltI+PUIgBNGj34vQRk8JYhSaPja8PjDudGimr
 52vw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7FDSqzFtcWjuAurcFe2oF9mj9XjcmyHcomg34nUNocjdLcTyvfczQ1TTTS6fVl++CK8A=@dpdk.org
X-Gm-Message-State: AOJu0YwL5yEBhVCH3YgUrYvOlFgiHSfQHtdwuXIF8BTra4Bj4q09j1GS
 LT1mtzbrWsq4MvI7CMKlI9mt3GjgXDseXuM3ea+e5eCSAEMssSFem1D1osHTBwr0k+c=
X-Gm-Gg: AR+sD12ybwmozQ45IeALJueZsi22JH+uXyQwxdV2JGXutbuX0qzi424Kspv7dq6H32U
 IHG9j99vy3thpmo3u37OEH8StVjV7T6nE1HDiFKGZTWlejWrSAKNviQZuhk4dofcWaCna5uzkES
 lP3BABaAQUZxjTWrt/M6c2aUaVab66h5/x46+UIioEb61Z5XkxssukMyVAxmSaBEb1vTFu2g7+F
 b7Aa42nYjH+Ruzzahk9qNz7IfF7TLomg3PICHCeNxMw8a9g4ZccI4jpN4sG0mTZcTHdNyLMfchE
 S/haWh+WSAfMvos7eU96eAuvMq8uOQASVJnyNV0ecDJY7bXaXZgDzMs0vW58CpJgOE6Fzn1H3kw
 9eHonjnT8YbFGtKMXEQp4C978zsHYE9hbQu1Zx2sBjAZE07QqjP/adwFwD1f+/ZjM4jG3aiYEVT
 3OxKeRh8BBWgMp5WX9mtUzBtcaS7KBYBeWVgWQKDobS7q4T9VSGkqmmw==
X-Received: by 2002:a17:903:11cd:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2cfde78f2d4mr51240115ad.8.1785088582831; 
 Sun, 26 Jul 2026 10:56:22 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc548f5dsm26720590eec.17.2026.07.26.10.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 10:56:22 -0700 (PDT)
Date: Sun, 26 Jul 2026 09:41:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: add 4x folding loop for aarch64 NEON
 implementation
Message-ID: <20260726094121.51db3928@phoenix.local>
In-Reply-To: <20260706092537.1252921-1-16567adigashreesh@gmail.com>
References: <20260703073118.788f4324@phoenix.local>
 <20260706092537.1252921-1-16567adigashreesh@gmail.com>
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

On Mon,  6 Jul 2026 14:54:14 +0530
Shreesh Adiga <16567adigashreesh@gmail.com> wrote:

> Add a 64-byte loop that maintains 4 fold registers and processes
> 64 bytes at a time. The 4x fold registers is then reduced to 16 byte
> single fold, similar to x86 SSE implementation. This technique is
> described in the paper by Intel:
> "Fast CRC Computation for Generic Polynomials Using PCLMULQDQ Instruction"
> 
> This results in roughly 2x performance improvement due to better ILP
> for large input sizes like 1024 observed on Cortex-X925.
> 
> Also removed the special handling of len 16 to 31 similar to x86 SSE
> implementation.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---

Applied to next-net
