Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5102C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 18:22:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D000B40E96;
	Wed,  2 Jul 2025 20:22:48 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 65F884028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 20:22:47 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6fad4a1dc33so47796676d6.1
 for <dev@dpdk.org>; Wed, 02 Jul 2025 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751480566;
 x=1752085366; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsSbhAsuDTdqjI8mv7egnMVIZb4jjDcc41iiIHfUFgM=;
 b=iPh7qpcZY5TnTGc/Vk3zrnW9OPCcYTYO2kHUxWVlojK0R1yV/gZSCNQy10OR6HY8HN
 1yAkcyBnZfmBPIp5Y0F9rsSpJP0uS3n6vZpQO+KK5nsSPc7NY3BDentntQ2YS4c3tSOi
 /YT9P/dFtt+zX40tJtvx78/82jV2Q7jt7+ZZJV+GeW1jVP68Pti5NBOrKQfanJ+l9to6
 XX8bMMtbICeQzy8ULq6vl/SS7nIbqypsexd71LZBToLuifLwyblx/hD9dHZWvCaXCAs6
 1GDaEOQ5d96jRj+Zm2vuL2mL+NIEmwLoA9jnCjeI1WBwWiHO2T7heo5x9H2AqwXLoBK/
 qR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751480566; x=1752085366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EsSbhAsuDTdqjI8mv7egnMVIZb4jjDcc41iiIHfUFgM=;
 b=CJ/04o9n+6x18tomDnDWVec8DsU7IxjcW42yFeXJ3HdMkw+77nM/V75m6zaHLtf2WV
 ZFSAsM1gVkn6tl3/wDneLrMdcKL53XcViO3qsDvUzZWeZzF1J7Sa/SlDOUPKfzyPLAXN
 JyF75zXEvSBk9oeIgX7PrV+7To0JEEB/Oc5ETyqzt/yxjTpTwCh4Izf/6ELTkTSmt+sb
 5D6z13VsaZEOSSGihc8rDFDrTDYMQ0Be/Ju5ur4yO0ekyFJxbqJ504ac8YZnVOvvaOkb
 T6Mb+oWsBQ7BRvFQT3PFZNc8Iht/TjHhGo8cK+y0KDXx0q6Z0gZJIrLmcG5/8cGhAw+/
 9Teg==
X-Gm-Message-State: AOJu0YwwKk73lcMlpucmhJMw6L8l44cs3Qd1xa2fQurJqnGi/IkshTq9
 WYRbBLNAev1hZ6ZwYI5Pwwg03yqjJHopfOaDcOYBIVbUE8FB9skyLvLMpN4YWWMBDRk=
X-Gm-Gg: ASbGncvgJZex2UJ0dcYiDspQUklmsbj2idhhVXjTe8i/WNHfR7DEV9rnoexByDdvkmq
 +/2uLciBEmw5xgrN1NiViwoShRQsCXFtbj1DtmoJCHjAnXhwd8QOoR3opYWSTpZ+LFX9Te2N20x
 XyD8hrLdFQqI8i4ccy20nlhvNvXbCT30Q0tOjx5/GxN1F7Xx7DO+02A5PXlhebQp4FcwFZGQAEb
 qKfEfTM8M5vvs95HQhbKr5WWtcY5PzUpzQLH5y4207hlLTARhQvWLgofw/BPoMx6U0CtD8QNoWy
 QTI17PcU8TeF9w07YtLGsyW27Z1hcE9D9Zr4ltw2n6jd61vH9FHLisn7oKuLmgDf2Ptuf7Pxih3
 wPcPl9MzkUEkXdjntMiwjunc2L5sIjKGBvrVTJdw=
X-Google-Smtp-Source: AGHT+IGMIp2t3HmbJUuVJegMOArWyA76rs5GCoXUddmHKiPIiAVvjYa1WHldaldKiE8lxQRr46Rg0Q==
X-Received: by 2002:a05:6214:5a07:b0:6ff:664f:c4ca with SMTP id
 6a1803df08f44-702bc89da37mr4743656d6.12.1751480566511; 
 Wed, 02 Jul 2025 11:22:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772df642sm104286906d6.74.2025.07.02.11.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 11:22:46 -0700 (PDT)
Date: Wed, 2 Jul 2025 11:22:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin
 Varghese <vipin.varghese@amd.com>
Subject: Re: [PATCH v2] build/x86: fix support for older compilers
Message-ID: <20250702112242.7b93d978@hermes.local>
In-Reply-To: <20250702160138.3441279-1-bruce.richardson@intel.com>
References: <20250702155129.3440210-1-bruce.richardson@intel.com>
 <20250702160138.3441279-1-bruce.richardson@intel.com>
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

On Wed,  2 Jul 2025 17:00:45 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Some older compilers e.g. gcc 8.5, do not support overriding
> -march=native with another architecture, leading to build warnings such
> as reported in Bugzilla (link below). Add a check for that case, and
> explicitly add the avx512 flags if necessary.
> 
> Note: it appears that it is only the "native" flag that isn't
> overridden, which makes the issue hard to reproduce e.g. using
> godbolt.org, or on a modern machine. For example, testing with gcc 8.5
> on a haswell machine, using 'native' vs explicit 'haswell':
> 
> gcc -march=native -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
> 0
> 
> gcc -march=haswell -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
> 5
> 
> Bugzilla ID: 1736
> Fixes: e361ae3f59d3 ("build: reduce use of AVX compiler flags")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  config/x86/meson.build | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/config/x86/meson.build b/config/x86/meson.build
> index e2ccfb6d12..0dcc5ddee4 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -71,8 +71,13 @@ avx512_march_flag = '-march=x86-64-v4'
>  if not cc.has_argument(avx512_march_flag)
>      avx512_march_flag = '-march=skylake-avx512'
>  endif
> +# workaround for older compilers, e.g. gcc 8.5 on RHEL 8.
> +# if march flag overriding doesn't work, explicitly add flags for AVX512.
> +if cc.get_define('__AVX512F__', args: [machine_args, avx512_march_flag]) == ''
> +    avx512_march_flag = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl']
> +endif

RHEL 8.5 reached end of extended support cycle (EOL).
Why are we still supporting it?
