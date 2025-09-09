Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F9CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 21:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ACCD402D4;
	Tue,  9 Sep 2025 23:34:17 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id CBC724014F
 for <dev@dpdk.org>; Tue,  9 Sep 2025 23:34:15 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3e46fac8421so3191348f8f.2
 for <dev@dpdk.org>; Tue, 09 Sep 2025 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757453655;
 x=1758058455; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70kRq5iF3MZBY+Tut71Bu5zintQrULAYI1TCDoa3Uqg=;
 b=n0d38zuYnyhnNrEO+2RmVeeFStOdSLFwQjP33SqGl/puKEieymQXtJgM50L/P4cL4m
 DlEn+mLeh1wj584lmcB/UhrcG3BaLkOUJ3g4Sa5tLn/x0jV4oZjvAnxyL4ddRUiRkrTT
 +jUqOc6VLpLyi7ML9nmudyHPOk7wHaogHTuwI+/gjCqN45ieVvvq6DpSEHdnZW8YvZAG
 nDFj1Tl8D3exzx2PWHgJS6NB5bVTezgOwwU1tYtlmSrrTKr0o3ddK9IoCQrFRUFMrG4f
 7wJIPmvhZ58oZj3nfppMhQuBw4A37v5xmIbw3Z5RpVIsnW1rifm2txEk4j+Y7SxjM9GL
 jNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757453655; x=1758058455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70kRq5iF3MZBY+Tut71Bu5zintQrULAYI1TCDoa3Uqg=;
 b=O/N33jmJl5MgVg4BKVfCPhkJpGmCejgTX6hashAlkhTF1825iOgTDsMMXqd3YxR/0a
 sbu9zW7CEsOJRjLMNh9QHHVv9Nc+9J3+PRSZupQkLSMbQN/HtzsnioA5aMAGcE0To65f
 vobB6VuduwJ2EYQNK4FRI5HcojXJG3hpj+OCwuhT4gjsRj3+7nQDo6l89k9vxUqQX+07
 4hnv+HZLgglGfh4TpiqS/1JSZt540G3kF+SpiP49D2V2z+XRqS33wyjDiYxC0DrR0joU
 cD14qqX146oyIKmzWpj46IavWCVQxVNH8nBoPprhjHleqVhkIafxhP1yuTAICkYE1BSb
 G1vw==
X-Gm-Message-State: AOJu0Yz2vfy1fQB+mpNkJKhS/rmMVIROkGcyZLzHtRYXevGTcmN/rLr9
 DfNljvCgSvyDDH0lk1+2vAiWxaWzxoD+3/ugRXPIMgrEe9fFyHRb0dgUwg+9bp28nJ5TsJwPlqS
 Ej/my
X-Gm-Gg: ASbGnctnJtU3qjj/vFNykGk3Zyp5i4pZz893F1mtlBiEo+jOoJ0L6z0wRxycrGzPSBA
 xVbNVMowgD2t2dCdJhje8VcdsYN6USAUyyJdOPzznUTMmXgmoJIXqrhxkF0OaTpzv926iPUXVWQ
 FM062Y1EIw460/LkvQ8Pz6/ydP/JkMQiDnfCMeXwI2WPOC+CPHDj1Ijh/oMHTE7KbmtuLUbNdIE
 PhkaCvtGKeL239+EVLSyzNk7n1RQ9XRUuxFA9lXpFFGZNtd65gtomR5qqzOkR9jaQkJ/MgeC8nW
 LA4KXyD6XUs7WG2NMUJiLXjDqtXXwijrGd398xuey1dYizzxZA6lm1we979Etk2K1DY5wdc95VU
 iJZCAaMdC0aNWpwiBuphqrMIFzQqW0f0VSDqwUc5UFOy8So2lBgIV7ZFpH9+jso+iyKbU+Osbi4
 U=
X-Google-Smtp-Source: AGHT+IFnvIrdMpTREB+/kRlxVmXae5PcmHabfB18wQQHPCuQAQf8BitodQbcODw0JVA55i3pUedz6w==
X-Received: by 2002:a05:6000:2411:b0:3e2:e851:7f8b with SMTP id
 ffacd0b85a97d-3e641d4647bmr10436470f8f.6.1757453654895; 
 Tue, 09 Sep 2025 14:34:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7521bf85esm4227055f8f.1.2025.09.09.14.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 14:34:14 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:34:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 00/17] NBL PMD for Nebulamatrix NICs
Message-ID: <20250909143408.0a5cbff6@hermes.local>
In-Reply-To: <20250829032805.2955351-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250829032805.2955351-1-dimon.zhao@nebula-matrix.com>
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

On Thu, 28 Aug 2025 20:27:48 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Features:
> ---------
> - MTU update
> - promisc mode set
> - xstats
> - Basic stats 
> 
> Support NICs:
> -------------
> - S1205CQ-A00CHT
> - S1105AS-A00CHT
> - S1055AS-A00CHT
> - S1052AS-A00CHT
> - S1051AS-A00CHT
> - S1045XS-A00CHT
> - S1205CQ-A00CSP
> - S1055AS-A00CSP
> - S1052AS-A00CSP
> 
> Dimon Zhao (17):
>   net/nbl: add doc and minimum nbl build framework
>   net/nbl: add simple probe/remove and log module
>   net/nbl: add HW layer definitions and implementation
>   net/nbl: add Channel layer definitions and implementation
>   net/nbl: add Resource layer definitions and implementation
>   net/nbl: add Dispatch layer definitions and implementation
>   net/nbl: add Dev layer definitions and implementation
>   net/nbl: add complete device init and uninit functionality
>   net/nbl: add UIO and VFIO mode for nbl
>   net/nbl: add nbl coexistence mode for nbl
>   net/nbl: add nbl ethdev configuration
>   net/nbl: add nbl device rxtx queue setup and release ops
>   net/nbl: add nbl device start and stop ops
>   net/nbl: add nbl device Tx and Rx burst
>   net/nbl: add nbl ethdev infos get
>   net/nbl: add nbl device xstats and stats
>   net/nbl: nbl device support set MTU and promisc
> 
>  .mailmap                                      |    4 +
>  MAINTAINERS                                   |    9 +
>  doc/guides/nics/features/nbl.ini              |   31 +
>  doc/guides/nics/index.rst                     |    1 +
>  doc/guides/nics/nbl.rst                       |   87 ++
>  doc/guides/rel_notes/release_25_11.rst        |    4 +
>  drivers/net/meson.build                       |    1 +
>  drivers/net/nbl/meson.build                   |   26 +
>  drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
>  drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
>  drivers/net/nbl/nbl_common/nbl_userdev.c      |  761 ++++++++++
>  drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
>  drivers/net/nbl/nbl_core.c                    |  105 ++
>  drivers/net/nbl/nbl_core.h                    |   98 ++
>  drivers/net/nbl/nbl_dev/nbl_dev.c             | 1041 +++++++++++++
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |   89 ++
>  drivers/net/nbl/nbl_dispatch.c                | 1326 +++++++++++++++++
>  drivers/net/nbl/nbl_dispatch.h                |   31 +
>  drivers/net/nbl/nbl_ethdev.c                  |  141 ++
>  drivers/net/nbl/nbl_ethdev.h                  |   32 +
>  drivers/net/nbl/nbl_hw/nbl_channel.c          |  980 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_channel.h          |  131 ++
>  drivers/net/nbl/nbl_hw/nbl_hw.h               |   28 +
>  .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c |  228 +++
>  .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h |   53 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
>  drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |  249 ++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             |  904 +++++++++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.h             |   40 +
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  458 ++++++
>  drivers/net/nbl/nbl_include/nbl_def_common.h  |  120 ++
>  drivers/net/nbl/nbl_include/nbl_def_dev.h     |   26 +
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |   99 ++
>  drivers/net/nbl/nbl_include/nbl_def_hw.h      |   35 +
>  .../net/nbl/nbl_include/nbl_def_resource.h    |   91 ++
>  drivers/net/nbl/nbl_include/nbl_include.h     |  201 +++
>  drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
>  .../net/nbl/nbl_include/nbl_product_base.h    |   31 +
>  41 files changed, 7923 insertions(+)
>  create mode 100644 doc/guides/nics/features/nbl.ini
>  create mode 100644 doc/guides/nics/nbl.rst
>  create mode 100644 drivers/net/nbl/meson.build
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.h
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.h
>  create mode 100644 drivers/net/nbl/nbl_core.c
>  create mode 100644 drivers/net/nbl/nbl_core.h
>  create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.c
>  create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.h
>  create mode 100644 drivers/net/nbl/nbl_dispatch.c
>  create mode 100644 drivers/net/nbl/nbl_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_ethdev.c
>  create mode 100644 drivers/net/nbl/nbl_ethdev.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/
> 		    nbl_hw_leonis_snic.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/
> 		    nbl_hw_leonis_snic.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_channel.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_common.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dev.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_hw.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_resource.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_include.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_logs.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h
> 

Overall the driver looks good but needs to be updated.

Please address the following:
   1. release notes changes in main branch so patch doesn't apply cleanly
 
   2. don't use rte_memcpy(). The places you are using it memcpy() would
      be as fast and the compiler has more bounds checking with memcpy().

   3. probe function should not log at INFO level, keep it to DEBUG only.
      Same for nbl_mdev_map_device().
      A driver should print no messages on normal successful startup and
      when device is not present.

   4. The driver is mostly namespace clean, symbols are prefixed by nbl_.
      There is a global symbol dev_ops, which could conflict when linked
      statically with other code. Looks unused??

struct nbl_dev_ops dev_ops = {
};



   
