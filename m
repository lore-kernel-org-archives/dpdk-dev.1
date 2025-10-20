Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B77CCD1A2
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 21:39:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B14C4060A;
	Mon, 20 Oct 2025 23:38:59 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id D579340151
 for <dev@dpdk.org>; Mon, 20 Oct 2025 23:38:57 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-33d463e79ddso3918363a91.0
 for <dev@dpdk.org>; Mon, 20 Oct 2025 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760996337;
 x=1761601137; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPQkvKFrkZF2g621XzYruyzHRgQV+QY/10JpdZMUrrw=;
 b=xQWiPJazo8jgpdUj23IKxqjZT2imsf3JNQcXn1ktd4HnIWa8AknNB8Xv8fFpn+r7RE
 CesUdMNtla64UNTsria9QjSgtgh7thsXc2zG8Z0/E9/2CPxkrmo0LcZ928TP6p/OZ97L
 j+sTJfVk+/q8p313ibvNBUh+HXochHi9mLWwlhglxI5FAixRSPnvrGMrVwqTt+ZuiW//
 rPdZ2Iz1HfoixbMCy67hg91WeDIVaAuj6j6oyKc4OLhJG7pRgmLIX4eYbgy4FydFaF1+
 jRIMG+zn7tbgM7pxbzWYMtqObB6gzX2Xalk9lqO5DawUzsE5WXpgZk79Hz/iCtcm4oAh
 nKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760996337; x=1761601137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPQkvKFrkZF2g621XzYruyzHRgQV+QY/10JpdZMUrrw=;
 b=PWJwoPXD3tAfZe2qXGk/w76euMelTsRyKXy9yXbS3slS7wcOBiOs7d8S0FANAVtu/3
 kN8xIjcKWwTYHzFk0HxEwYJ1UyIG1rqUXc5Bf6bgxS2F0MH+2HowtcU9EKZ6deazabyC
 BnE6VkecSzCGpBHNrIYg23vq7gjnYhyNhUZW7OF37OYMYKhWw2Slo0scwQF4htxT/id+
 q18CA7Kj2tXTEx0bPEm8YSaX+M3YuIUixep4ZECoVTDVMjP7JWXtmQHOpttPJx29irrf
 CM8i/UgDja+TyNBRlVXRpi8Phs5OMbg63+nOfe0SGoCu2Y5Dt6T1eg8xIRY2ZWak5nho
 ULsw==
X-Gm-Message-State: AOJu0YwO58pCA0PaGcWGdarrRJGTyWHAIoDe0rKmBcExfSovwD9pRqxO
 MbSzoUqtd094ub0L8pEx5aWqGlgOCUx2RakJjuD0GFRVmNGM3hIbJtwI9qXHj9cNSmE=
X-Gm-Gg: ASbGncvZRt3KPH5rLYG9P47JCYDpKqWJGmx/cjAidbgWaQfdt6E3fomtn2REI9Dt1fc
 6aRr7Jb8U7D9E3JpnApySJWH8JM7PwFFTW6NTPghX0RQXZc5KQvpGJHE642hTkbAeId7bsxjw5G
 5eIUED0ImX4DNvYSza2LJvXNQopQMgyMcFRNOYS1HcsHIHNyiTv6uCp+rXWGckKzSALgo/mFV9Z
 Vn4mdibcmDBQpMXb7PhPcrOMNaN7ccV35HnRF8r602LjsxUQnQWCFeaR2LPmPfEbx5IKVGUp/AK
 BKOrznehNVJSr1qxTrPYcuJMexPhpE9fGDbgsGWQRVnEIOXDAp+6fhun1aVlysCvNnt6imE5/Us
 DNNT7SKCGfHv0EC5P/Tm7y/QlgkQUOeIPA9DIuLx0b14as3tFdNCBB5QgXrsPf3tLaPpyP9Jlwg
 QfhxbYj0zVJC80JbK3FsALV1M3eaNobdVomF13Odo=
X-Google-Smtp-Source: AGHT+IHjZK6dhYswEXBjDo3PTtEb0JlHUPBESkLeGIzj6sw/sNg8cbq923iIhdojGaZIl+rULnSOuw==
X-Received: by 2002:a17:90b:3909:b0:330:a454:c31a with SMTP id
 98e67ed59e1d1-33bcf90ef04mr16119512a91.32.1760996336987; 
 Mon, 20 Oct 2025 14:38:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a7668fb57sm8455978a12.17.2025.10.20.14.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 14:38:56 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:38:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 00/20] Add NT400D11 support and new features
Message-ID: <20251020143854.0fa68821@phoenix.lan>
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
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

On Wed,  1 Oct 2025 17:09:42 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

>   net/ntnic: add handling exception path option
>   net/ntnic: add flow query with count action
>   net/ntnic: add flow pull
>   net/ntnic: extend flow dump with MBR configuration
>   net/ntnic: rename hwlock
>   net/ntnic: rename nt log types
> 
> Stephen Hemminger (1):
>   net/ntnic: make flow lock local
> 
>  doc/guides/nics/features/ntnic.ini            |    1 +
>  doc/guides/nics/ntnic.rst                     |   15 +
>  drivers/net/ntnic/adapter/nt4ga_adapter.c     |    3 +-
>  drivers/net/ntnic/include/create_elements.h   |    2 -
>  drivers/net/ntnic/include/flow_api_engine.h   |    2 +
>  .../ntnic/include/stream_binary_flow_api.h    |    2 +-
>  drivers/net/ntnic/meson.build                 |    2 +
>  .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |   41 +
>  .../core/nt400dxx/reset/nthw_fpga_rst9569.c   |  380 ++
>  drivers/net/ntnic/nthw/core/nthw_fpga.c       |    1 +
>  drivers/net/ntnic/nthw/flow_api/flow_api.c    |   15 +
>  .../flow_api/profile_inline/flm_evt_queue.c   |   14 +
>  .../flow_api/profile_inline/flm_evt_queue.h   |    1 +
>  .../profile_inline/flow_api_hw_db_inline.c    |   54 +-
>  .../profile_inline/flow_api_hw_db_inline.h    |    4 +-
>  .../profile_inline/flow_api_profile_inline.c  |   94 +-
>  .../profile_inline/flow_api_profile_inline.h  |    3 +
>  .../flow_api_profile_inline_config.h          |   48 +
>  drivers/net/ntnic/nthw/nthw_platform.c        |    3 +
>  drivers/net/ntnic/nthw/nthw_platform_drv.h    |    2 +
>  .../supported/nthw_fpga_9569_055_049_0000.c   | 3132 +++++++++++++++++
>  .../nthw/supported/nthw_fpga_instances.c      |    3 +-
>  .../nthw/supported/nthw_fpga_instances.h      |    1 +
>  .../ntnic/nthw/supported/nthw_fpga_mod_defs.h |    1 +
>  .../ntnic/nthw/supported/nthw_fpga_reg_defs.h |    1 +
>  .../supported/nthw_fpga_reg_defs_rst9569.h    |   35 +
>  drivers/net/ntnic/ntlog/ntlog.h               |   16 +-
>  drivers/net/ntnic/ntnic_ethdev.c              |   44 +-
>  drivers/net/ntnic/ntnic_filter/ntnic_filter.c |   85 +-
>  drivers/net/ntnic/ntnic_mod_reg.c             |   15 +
>  drivers/net/ntnic/ntnic_mod_reg.h             |   17 +
>  31 files changed, 3976 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_9569_055_049_0000.c
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h

Queued this version to next-net
