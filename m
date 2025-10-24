Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9ADCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 16:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B96E4021E;
	Fri, 24 Oct 2025 18:09:11 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id AC60840151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:09:09 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso1488957b3a.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761322149;
 x=1761926949; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MPreUnnwvTDc/NiwC7kvlMwTCeUZbL8ui1iIAdEt3E=;
 b=gkV0nsm2P6uNeIMwoKAFHtCCN889lpM8R3rOBf9pk9cIpT5YYq5SqfM03KI4zbzDor
 VmaXOtE7TWQ+ySzgOifIO2NP5ZWswrltODbgyRSYEHD3lLunAqqx9pmKAAQ87h7TnJqY
 a9fwrKkNDOtn+U9AfOQDuYQR0UTqeg/dqqdkZiJWY8w9HNbjQUYs+VIFiWGNRzQleRI0
 41yLDQT6+dEvLvsDalBw3QlYJ4l88vhQ8QvLnnHWmUPj2NRSCOEwx2nsm19Xtgv4SYBm
 yx7gTszJpvterUutikjkkB84rxCLqtmIOra4+jNtaQEu8azEvOJckEr3j9G3Vy+8W7V5
 n28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761322149; x=1761926949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MPreUnnwvTDc/NiwC7kvlMwTCeUZbL8ui1iIAdEt3E=;
 b=p7OFaO6r7y9tNvq7Hf3sld+W3Mp66wdAfGle9kUZLVSYFSSngaYwIsHyE+hew9yje2
 UVOHbv1CX1qTIcqZdIUwFrIfLHKJ4zANb27oaRyXohBlQoJvvKWnDkkErvNWh7HIS505
 LkH9KGqDZjzjpSJxAPB3mUf59yaCqCXZkJqxyU8j8ZyvaTkHnyY1egItIYSHUQKN2Kvj
 IUeRl2DHPfu/NtbZ6BjqO2N1KkC1lnwrKTT5mOSMA2o5wBn8YIGnOBw1ST+sjTbbGoUJ
 m4VuKwryoxLpkOtwcAnUAlINu6/f/fJnAP/yggg5TUIm4l1EkUoQwhbfPiPt4ovb9w5O
 SmRw==
X-Gm-Message-State: AOJu0YzGNn1Gowe9w/FmiMlodcvXQEKiLsqk3vuD8ETMVef+apkqmJif
 irWKlC8OWhQ9g6F9EUm4LFYRt1tNdDz+BlPYqsAkD1+TDXwZj6xd87p7H8DccA5owXU=
X-Gm-Gg: ASbGncvIsiea7i+LBzmgOsW3Wh3jqO81gdDXUBpINGpzoSYvDqpnluSmlGY70F6KaY9
 wGZrkbbd2eLTfn0KpuBEUrauvVoje8KIlpOkEe0x24ch5mEVgHG/PIqgU6x8cRi1PaaX/gDvQO0
 p8RLe51JyY4odFAb766NlbccHKNF8KIL8HKnP/1oFW1NizdcrwbB8PCGjPlIOpD+87rjzWs5sJY
 LpaupN328abjde3UVf9UjUnXRzhADUfaAYwplnDVNyd3bO/2r8YzOfEDPgQlyEXNuVBScNgIz1D
 u/9uQuvCdk4vQeSTcTsnayiSx08U1Fi/eacW9+E3iXsO2N7qGFdPHVYRn0naNYt3wdCRXUL5ALH
 iWSNX4AI6+NHOCEdxtnVf30i09X6ZF1x/+TCJhr11PZ/cCBtZiHg4jCLLXHMdMy0erePQ39xOS8
 jkztys2v6cJk6TWxUAb4peSXORl3Jkd38kDGWnXCfwvzrCRd3Z4HkXLFw=
X-Google-Smtp-Source: AGHT+IHW83tv0FEIzLSLpXDui2wIzzi1iotRuzYoaOwpE9Rlz0Ddq2PaUnoKuSfGrIPfccM9JIU4+w==
X-Received: by 2002:a05:6a21:48a:b0:334:89c6:cdeb with SMTP id
 adf61e73a8af0-33c626aec66mr8998003637.56.1761322148698; 
 Fri, 24 Oct 2025 09:09:08 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274bb2174sm6291638b3a.55.2025.10.24.09.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:09:08 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:09:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 0/3] net/macb: updated net macb driver
Message-ID: <20251024090905.5ffaad89@phoenix>
In-Reply-To: <1755664327-9362-1-git-send-email-liwencheng@phytium.com.cn>
References: <1749200714-53359-1-git-send-email-liwencheng@phytium.com.cn>
 <1755664327-9362-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed, 20 Aug 2025 04:32:07 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> v10:
> - Removed unused spinlock from base/macb_common.h.
> - Renamed symbols to avoid name conflicts.
> - Remove unnecessary pragmas
> - Fixed some code style issues.
> 
> v9:
> - Added RTE_PMD_REGISTER_KMOD_DEP macro to
>  declare dependency on macb_uio kernel module.
> - The source link for the macb_uio module
>  can be found in macb.rst.
> 
> v8:
> - Delete log level reset code.
> - Delete code that links to external phy library.
> - Update document macb.rst.
> - Add usage instructions for the macb_uio module.
> - Update the explanation of testpmd parameters.
> 
> v7:
> - Use a legal name instead of an email alias.
> - Do not use additional __rte_cold.
> - Replace unsigned long with standard uint64_t.
> 
> * Describe the devargs used by the driver in the documentation.
> * Update macb.ini.
> 
> v6:
> - Fixed build failures across different OS.
> 
> v5:
> - Putting __rte_unused after the declaration.
> - Correct RX-bytes and TX-bytes statistics.
> - Initialize the mbuf_initializer.
> - Add driver based on 25.07.
> - Fixed some code style issues.
> 
> v4:
> - Fix tab errors in meson.build file.
> - Use RTE_LOG_LINE instead of rte_log.
> - Replace %l with %PRI*64.
> - Replace rte_smp_[r/w]mb with rte_[r/w]mb.
> - Do not use variadic arguments in macros.
> - Do not use variable-length array pkts[nb_bufs].
> - Use __rte_cache_aligned only for struct or union types alignment.
> - Support hardware Rx/Tx checksum offload.
> - Fixed some code style issues.
> v3:
> - Changed functions that always return 0 and whose return value
> is unused to void type, improving code simplicity and readability.
> - Fixed the implicit conversion issues in the
> macb_usxgmii_pcs_check_for_link and
> macb_usxgmii_pcs_check_for_link functions.
> - Added the missing SPDX license tags.
> - Added the missing mailmap entry.
> - Updated the MAINTAINERS file to include the missing information.
> 
> v2:
> - Split the driver into three logically independent patches,
> rather than one large patch.
> - Added conditional compilation to address the issue of
> macb_rxtx_vec_neon.c failing to compile in certain modes.
> - Fixed some code style issues.
> 
> v1:
> - updated net macb driver.
> 
> Wencheng Li (3):
>   net/macb: add new poll mode driver
>   net/macb: add NEON vectorized Rx/Tx
>   net/macb: add necessary docs and update related files
> 
>  .mailmap                               |    1 +
>  MAINTAINERS                            |    6 +
>  doc/guides/nics/features/macb.ini      |   19 +
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/nics/macb.rst               |  181 ++++
>  doc/guides/rel_notes/release_25_11.rst |   32 +-
>  drivers/net/macb/base/generic_phy.c    |  271 +++++
>  drivers/net/macb/base/generic_phy.h    |  195 ++++
>  drivers/net/macb/base/macb_common.c    |  650 ++++++++++++
>  drivers/net/macb/base/macb_common.h    |  250 +++++
>  drivers/net/macb/base/macb_errno.h     |   58 ++
>  drivers/net/macb/base/macb_hw.h        | 1138 +++++++++++++++++++++
>  drivers/net/macb/base/macb_type.h      |   23 +
>  drivers/net/macb/base/macb_uio.c       |  351 +++++++
>  drivers/net/macb/base/macb_uio.h       |   50 +
>  drivers/net/macb/base/meson.build      |   25 +
>  drivers/net/macb/macb_ethdev.c         | 1755 ++++++++++++++++++++++++++++++++
>  drivers/net/macb/macb_ethdev.h         |   75 ++
>  drivers/net/macb/macb_log.h            |   19 +
>  drivers/net/macb/macb_rxtx.c           | 1394 +++++++++++++++++++++++++
>  drivers/net/macb/macb_rxtx.h           |  325 ++++++
>  drivers/net/macb/macb_rxtx_vec_neon.c  |  673 ++++++++++++
>  drivers/net/macb/meson.build           |   22 +
>  drivers/net/meson.build                |    1 +
>  24 files changed, 7486 insertions(+), 29 deletions(-)
>  create mode 100644 doc/guides/nics/features/macb.ini
>  create mode 100644 doc/guides/nics/macb.rst
>  create mode 100644 drivers/net/macb/base/generic_phy.c
>  create mode 100644 drivers/net/macb/base/generic_phy.h
>  create mode 100644 drivers/net/macb/base/macb_common.c
>  create mode 100644 drivers/net/macb/base/macb_common.h
>  create mode 100644 drivers/net/macb/base/macb_errno.h
>  create mode 100644 drivers/net/macb/base/macb_hw.h
>  create mode 100644 drivers/net/macb/base/macb_type.h
>  create mode 100644 drivers/net/macb/base/macb_uio.c
>  create mode 100644 drivers/net/macb/base/macb_uio.h
>  create mode 100644 drivers/net/macb/base/meson.build
>  create mode 100644 drivers/net/macb/macb_ethdev.c
>  create mode 100644 drivers/net/macb/macb_ethdev.h
>  create mode 100644 drivers/net/macb/macb_log.h
>  create mode 100644 drivers/net/macb/macb_rxtx.c
>  create mode 100644 drivers/net/macb/macb_rxtx.h
>  create mode 100644 drivers/net/macb/macb_rxtx_vec_neon.c
>  create mode 100644 drivers/net/macb/meson.build
> 

Queued to next-net

