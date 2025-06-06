Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B86C61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 15:38:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5221240283;
	Fri,  6 Jun 2025 17:38:58 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id AEE8240263
 for <dev@dpdk.org>; Fri,  6 Jun 2025 17:38:56 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4a5a196f057so42998691cf.3
 for <dev@dpdk.org>; Fri, 06 Jun 2025 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749224336;
 x=1749829136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbSFb+ibbYz3Tgc19ZS483EjI7icxSTGhiFaiu+AWbw=;
 b=RnSRZZeSHh+HTR7jMpf9Ag7mySnXvuJpolXArSwi8e1Dnt2H9SdVM8Ybrhh26Y0o2f
 iUQCgEj0hHLxopCMWxA1Qcr4CldB3dDtBukhixzqy7Alforf5YQ0dr32Vg1HmUKJdu2m
 sRHRX1WWaQWms0c6B7rZ47ztHLhR26rKMy8VBViDYiAiAdPjDWRQ9kRCaVbyUyLFt5dw
 /D9HXDv8lXiaOe2CibJvz7n1leqdQuij5ado4PxuIWaFIvul6d7rFrNHFQVg7hHZ5L2D
 W575Bkm5msi1sW8JjWOeFj7eKE/85H+AsZw+oY8fw1bviQxuD6yUW8UG6ukM3uGnyso9
 28oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749224336; x=1749829136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbSFb+ibbYz3Tgc19ZS483EjI7icxSTGhiFaiu+AWbw=;
 b=k1mNUoGLBWYiEviOuxTlCSctvaG9/RM02MYtoJ3Wbx+WPYbpKAKh6RBQhQTzvaPozS
 SjbRvXS6weSU+dRSD0WlZUqNiJMR6IuX2fILF6wzQo0qcH8vEqSSH80po2mMZBgn2XV3
 aYR9wbTihrjIDwf0grcsUgChgVp1tKocGNGFxyM3VRCAiXaJstZiooUyWaCRSJFIXhI1
 VOb0nvzKEKatBMYUVmZFDQNqA5+Dvmkl4RtmgBd6Q8rM3wYly67e2i6mwNpSY4XrmNC6
 WqAXJuojpjY/nIenDEt/whV0VuPu1CQBi0URwqHCPY/oWC11ikyobKXOZX3bMwB2n4TZ
 5w8Q==
X-Gm-Message-State: AOJu0Yz/hjOkN7OSWMmpAxyEk3YbAeN2otIm/y9BHr5w82/jSTON50Md
 A8IivasOuRxNkatWIF8h/+Ns20S1Q49W27OTHW4UV0KOAEWxLq21yIWl6FNTHxmZwoflOWIUvKM
 N5jkt
X-Gm-Gg: ASbGncsk/O6r9QURr9Si9Ho8/5yHgC7BCLUE2hk5ox6esCrBZAouSdKDmGr2PLZqGRr
 mHssjD7vo+6hxEhyHz4Lmmy4fE2du3E017a57l3YBp0vojY0gxbLwjuYzytSw9tNKZYkSuJSvlT
 jATamDS1F1E/qMn+v/N312kyNpveqhV/Jwwh/72w1ibjoe25a2s3EmHHPKRJJ66xJOglokvUg2C
 J5iSAlAo3ty/jDzCzM8TPeE4H38Hq1VsPxkLTH21JR9mW5HVbApKpTfq+7V2OvTX1IKtJ2l0d4J
 ZDDm2GArAEnpOQU1qijG1G0EPWNq/tUaed/RKVwCjcHXUG93ZfvTChMpCT+oIBi9VmGxGoI/GtV
 ZNWVfwuYdARbRf5HZEzlMcNilxmAHg4SN2oKPFvA/T4R7Ws1rBg==
X-Google-Smtp-Source: AGHT+IGFQs62vmkllwelGMqTJw8TFaMeBmR8ooRALPdwNX7M9iGbxrT/WnHtKz9DBKmaWS3qdB4FfQ==
X-Received: by 2002:a05:622a:4c87:b0:4a5:a64e:598c with SMTP id
 d75a77b69052e-4a5b9dc1073mr65011161cf.49.1749224335998; 
 Fri, 06 Jun 2025 08:38:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a6198659a3sm14051711cf.64.2025.06.06.08.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:38:55 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:38:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 0/3] net/macb: updated net macb driver
Message-ID: <20250606083853.08d5462e@hermes.local>
In-Reply-To: <1749200714-53359-1-git-send-email-liwencheng@phytium.com.cn>
References: <1749020337-44001-1-git-send-email-liwencheng@phytium.com.cn>
 <1749200714-53359-1-git-send-email-liwencheng@phytium.com.cn>
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

On Fri,  6 Jun 2025 09:05:14 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

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
> - Describe the devargs used by the driver in the documentation.
> - Update macb.ini.
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
> *** BLURB HERE ***
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
>  doc/guides/rel_notes/release_25_07.rst |    4 +
>  drivers/net/macb/base/generic_phy.c    |  271 +++++
>  drivers/net/macb/base/generic_phy.h    |  202 ++++
>  drivers/net/macb/base/macb_common.c    |  670 ++++++++++++
>  drivers/net/macb/base/macb_common.h    |  253 +++++
>  drivers/net/macb/base/macb_errno.h     |   58 ++
>  drivers/net/macb/base/macb_hw.h        | 1138 ++++++++++++++++++++
>  drivers/net/macb/base/macb_type.h      |   23 +
>  drivers/net/macb/base/macb_uio.c       |  351 +++++++
>  drivers/net/macb/base/macb_uio.h       |   50 +
>  drivers/net/macb/base/meson.build      |   25 +
>  drivers/net/macb/macb_ethdev.c         | 1765 ++++++++++++++++++++++++++++++++
>  drivers/net/macb/macb_ethdev.h         |   75 ++
>  drivers/net/macb/macb_log.h            |   19 +
>  drivers/net/macb/macb_rxtx.c           | 1394 +++++++++++++++++++++++++
>  drivers/net/macb/macb_rxtx.h           |  325 ++++++
>  drivers/net/macb/macb_rxtx_vec_neon.c  |  675 ++++++++++++
>  drivers/net/macb/meson.build           |   22 +
>  drivers/net/meson.build                |    1 +
>  24 files changed, 7529 insertions(+)
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

Could you submit the macb_uio driver for review in dpdk-kmods repo?
