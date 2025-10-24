Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DA5CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 16:00:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE8CF4021E;
	Fri, 24 Oct 2025 18:00:51 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 89BE840151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:00:50 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b608df6d2a0so1964369a12.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761321649;
 x=1761926449; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Sh+lLq2NVuoIobPDsqZE7lzrYdQBS6AyvzyZlCKQIU=;
 b=A+g34sfSPSPQ3UsKMMtYDkAOAX3Kl7a2IdEhBGqhmRg4K60bS8k9+HxsWQeyGMGlzt
 KqnGFQbXMcgiKxh7tDTxov0G6EYWbMT2jHBuJT2bBnfGfKoaz/rJOT4sBgKcyHbRdJsd
 ZtvtyDADvqjmm42Z5njHwFQhFHfhQe2NC22V2KWFTfOsVR3zi+Zvfi0uvYASk38pRaat
 MAkYEmzfqlyD1MS+N/HJavPNuzYpd1se7P5wvI6cZwbMfI4eViQ3lPE8TAaaCFLeEUwr
 SBKI9A9VnUsmeHo+945VqBw9Dqpcj3EGPxnTkcrRID87gHkGOhmWivnWTVlS9fXXWU/1
 gA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761321649; x=1761926449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Sh+lLq2NVuoIobPDsqZE7lzrYdQBS6AyvzyZlCKQIU=;
 b=oKb9iB83He1Qj/qOMSxuBShm+QfpJGCNBt/eUfaz/ODpfYMeblOt1SMs36bNZsZtib
 ky6L77/UNVgNOYJxxyrBItKWROxZaMlDqyx/pk10abkjGST1t16jOPTfaW4GeF0T/8QD
 iGVXDF8PlT+x6sodmZr8OFUkIW05fB5PG0IZ7sg+fYwQVANWMkKHtxNxIX7HP60w885L
 j2HMqhoGQRvcnES35LcaLM32r//qJjEjgjXkzfvc94eq8smi7YRNTP0U3744VGJpbQS5
 mUMdhITHUSRJInk35h/w9c5Vts1wCIr2ReziM95FYiDrAAE1G9vYbRYnOCkEnxCGMmUZ
 XIQA==
X-Gm-Message-State: AOJu0YxXgI8xZhKTX3Qp+zBEf8mQ5dI39T7FeBtu+5fIelcIGdJT5n2E
 JfW6g/23x0AeUcMOhpDGkXBlAkrt8JqIyKFTPbC/P0qpQrc7ho8544FoLa9RmgfxGqAi+dEqpPi
 S788J
X-Gm-Gg: ASbGnculetbMUyupIJqYBhErkB6pYxa8bRworNeA7AO4o/MfZLni6wE8X0EdLp//VRq
 d0yjLI8H1p4dxmCltC7nrdsxdZOahK8Gl3vAXEjBuoRF6N+RC8ry2ie65YYRVAxqR8o+HPvMzLb
 huYAeCa1XkwFM5jAQVZ9/qFlYGdnnmm6Rn6oFYJYlBs0n3d4At1THui6Rml8ozLYZfJ5dHA1zih
 g+yN5AascDb04yjDgC+p5rHshA8awhddgzAErw4Uevr9sjep3BRxDh3Tn3ARBubPGIeK5EKP/HS
 aAWlyR/6up1rCIo8Rlxlcn+iGaAtcx9aD6pjk8MXSFCPO1Ppk7Y6Rx89ax3sb+/G9tyxowQIUQJ
 zsuCsc3EdVvFNZBrw4e6gJkV/mnP98LsR2ZAUzDMZzoGKfVAa+FNpdOBqSfmT0iO+4Yhx/FiKDe
 zhCw9a7l4Llnk4/wUkabji5nOOE53LCTAAYw==
X-Google-Smtp-Source: AGHT+IEHSixcg4sYkaBvdWsObmfqrf6kjnIaMlftkb1n781KWHKwejQiTDcTWqZ5O5BR39VcfRKOgg==
X-Received: by 2002:a17:903:1251:b0:28e:cb51:1232 with SMTP id
 d9443c01a7336-2948b95c6c2mr35953915ad.3.1761321647673; 
 Fri, 24 Oct 2025 09:00:47 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dded613sm59589355ad.37.2025.10.24.09.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:00:47 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:00:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 0/3] net/macb: updated net macb driver
Message-ID: <20251024090045.78e0598d@phoenix>
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

The driver can be merged as is. But it would prefer that drivers
do not have gratuitous inclusion of linux headers. The base code has
stuff referring to ioctl's, sockets, and ethtool which is irrelevant
in DPDK. It limits the portability of the driver.

Disabling unused warnings in base code is allowed, but consider it
sloppy practice and there could be bugs.

