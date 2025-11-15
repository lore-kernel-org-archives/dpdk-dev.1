Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E6ECEBF83
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:43:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7DFF402A2;
	Sat, 15 Nov 2025 20:43:54 +0100 (CET)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 84EDE40288
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:43:53 +0100 (CET)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so2620388b3a.0
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235832;
 x=1763840632; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwBag23/4wWtNkwaWyj3FqVOma/o26WjR+25LmuHv4M=;
 b=zvyHY0tadCVynSBZIxC/Mqodz6JtVz57Yr2X464n3Mo16fthAbFQkpQSg2TynEc7Y5
 yMMxFZz/NGHtbH5Imjn2sazdF7vHpM0d6efJiCUq2FM0vgLey+bXPG1bZ4suP+wj79mx
 7fX6QGvqLXdOnRET5caQsULBXoh0lwJvAFZkw37H/p5zMSBRebOfMmnPuMGmQfMjsC/n
 JqBe4pHBbp62N+d/ShPR1DQ5/wVW/jKDzSSz79SOu/6Vv+TZurGU66Qt2uL72ANL9xnS
 DCOLKnitxxUELz1+kTzaGuC5/WZkT1a86R66uX/g54CRsiZm41WLpGTduZhxDJNxI1FP
 TS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235832; x=1763840632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kwBag23/4wWtNkwaWyj3FqVOma/o26WjR+25LmuHv4M=;
 b=Z3LwY5Z+GlG2xt3Uhdhcjx3/jyo7ynD2hyovjixasJq7SIA+9twL2hhjy/S3G3xJD4
 CLbBDRk0NfZQOdkwooM8wN7p032iEDx5t1weTBFGKxSpe09aEZIKkV39c4/cKcwTG/IB
 WiZVA/TJl2vWFHMk1ZKOAjnuihTAyRbZec+tSvDSQSwgtyElAL+BY028y24H+MxjPjR4
 fOcQks5psLY7xcItxnw4szuJuhx+3RU5pXacZGiUHrwLq+PzAmlQyI1qZ+NpCmrSYDta
 UdYE2x7MSWhPNPVHYxlUQFt4O486N9MQ0FxzOzi5CNU+mGWV0ogEow8gnsS5YdD7PWgv
 Boig==
X-Gm-Message-State: AOJu0Yxhm/XnKRqQKZVQX03GoUujqsQ+TwUf3HFfBvx2ZVMDSUKwIdG3
 ZsO5BlRKvoWt3F/WjoNcr2p80zvM8lwr3SZV4MxOUKa6s6DPl6RkI/8O6HWJmEVcCbgJwexSCAX
 QKYho
X-Gm-Gg: ASbGncuvBVaaBRmRz60u+xzn0v43lTuJhLL471PUQt8J2en1ux05NIklrPuFvTNaPji
 dHEF6mjNOUj+pZj3u7vvJAjmkPw/IJ2JtYRxp5vAPDYRm+TX6c/lTmkhXieIidM0WjuF+Y9tESC
 2Y1vjAThR188vatKMAFf7hW5jiLLsq9a/9NCO0wnuYeJA+Jyvl9A7ULd0dM1watiLONrv2g1uFa
 R77Lf63ditrSooSPZUa4xAWt6vNXBb3VGmMvX7oceTTkvgik5I5F6sLO2thTkX35pLW8r4k38Lt
 CgUxbw/hdn4PEO23ZygSFcKoATjYH4TJR/ZnZaD6dElXxdHSo34D2yW6xwC2SU93YavgZ/FDZQp
 v7rnoug2VMERQrsYZumjBCCx8IRXQ1v9f2fxfDPIL/OsCd5tnzYLGoYDwbDJOAb7m9mW0OyydaU
 y3L+4I32WiAIm9H+ecweaJNIq7WNl/xwfEyZTwYq+5rb8vsYMV1JTD0Cw=
X-Google-Smtp-Source: AGHT+IFeiVLm2yyYdFi2nQb4Bv6DhEh72Fmhihk89wyH7xWtd0hjEIJnKWhLtujAISVdqSwZ+XV4ew==
X-Received: by 2002:a05:7022:b91:b0:11b:ade6:45a7 with SMTP id
 a92af1059eb24-11bade64772mr834546c88.1.1763235832434; 
 Sat, 15 Nov 2025 11:43:52 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885c0sm29991648c88.3.2025.11.15.11.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:43:52 -0800 (PST)
Date: Sat, 15 Nov 2025 11:43:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/4] test: re-enable format-truncation warnings
Message-ID: <20251115114349.5f2050f2@phoenix>
In-Reply-To: <20251115193409.99740-2-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251115193409.99740-2-stephen@networkplumber.org>
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

On Sat, 15 Nov 2025 11:33:07 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Tests should be built with warnings.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/meson.build | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/app/test/meson.build b/app/test/meson.build
> index 8df8d3edd1..66cbabe9fe 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -260,7 +260,6 @@ cflags += no_wvla_cflag
>  extra_flags = [
>          # Strict-aliasing rules are violated by uint8_t[] to context size casts.
>          '-fno-strict-aliasing',
> -        '-Wno-format-truncation',
>  ]
>  
>  foreach arg: extra_flags

Need to reorder these commits? so the warning enabling is last.
