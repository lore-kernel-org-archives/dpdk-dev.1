Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC44C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 18:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC71440E15;
	Mon,  7 Apr 2025 20:24:11 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 93CFE40E0A
 for <dev@dpdk.org>; Mon,  7 Apr 2025 20:24:10 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so491146285a.0
 for <dev@dpdk.org>; Mon, 07 Apr 2025 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744050250;
 x=1744655050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xhktvBDNwurPd6s6sRdUTPoZ37cBrnYgUDY05/9o/Q=;
 b=aJ8tH8d4HpDbdkAc3pKTituLJ09Qox/ldMWlcj2lwxmu8CYNKW3M6KQD635mpRNm2m
 DOgD1sPTsNDzuwvQbuK9jPZjyM81KIY75vk8IhWZzI+ey1lIpilrClNTt6fi44YqUBO4
 MY9lt/N3YREJt30FkUniVZoMJq3yjD4bq0RTFlHiqBJGoYhubu8yVo0I4xFkUETzd3g7
 YN6MGd0PyJ2jerZO78RnWonFRkDl9AeX377UcM6/1IJiwS83sC39Ka/gO+BZ5VIj10RW
 HRqBPIAdGbikPUqSQvq0TCnjrwczoJ04FypgHRSAVoqPwuvw78nhqwtQB3wfo4WDj8qI
 cq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744050250; x=1744655050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xhktvBDNwurPd6s6sRdUTPoZ37cBrnYgUDY05/9o/Q=;
 b=KedrWAcXqsF/0arEOucBj2QrLIDJXkMoQeiL6qSKeUeyzUu4NEbc+AYUHK07bpd3AU
 obosurli1OaIEstmaxIuoNEupxlv7WPVnOglmIlJG+slqFX3TVPAj02JIYwM4r1R9i7u
 7+7tJOYN0zRyZZ1JZNT3NsvaEGHR1icWG9PLzKmWlnOo1+pMnWevZ+xc8L92lD4T9d/l
 WzVIWnOd+F/0X8gnMMK07w90HaEmwjSG7vnwVktSLb57YJ3fAesMUUPrmZqHZ6rSp0nS
 02eTai4THNJEdauB6+gdWayvY/cX+qBuOixnd4qaxq6ST8a4PcviOzDSR4ojNWHJCsDI
 hGxA==
X-Gm-Message-State: AOJu0Yx14+7BdRMn08ZWfdI4oNcJtvXjH4QjHkkD2YUVNIkCEamt/i4y
 +rmwmLWR0WL8hCVAlmG7lAfMfcZAwF4FPKQx/+EIocyzswcJ92AiHBGmgSY6E3u6CDdhN4QiqBC
 F5/A=
X-Gm-Gg: ASbGncv7jk2cFRkzm4Ut37J8Is4AyMPOr+kjsp+2p2dob/YR/uJQ+4ruJe5SIqFCGWs
 ogV6Vgpes+J0Cdg+mU1TlCjhW/UksLjGC8SpFlYkVcTwr1bJtJpcyEfUbcSUgxHe0zITNH78qa4
 use2msTrxd35CNWqpt0E8PoJEdYvAqnm+k/p/PB3Xzd9wQRZIiwRUgeVRc2KmLUx0s/8Nq+DeWB
 U3YGhOxoaan+ZLz7EC4hfxls/GYzV90EMk2LpCwAr8rVUTWvrSzoMhMWr2YtJidWu8X1wbOg0lT
 0JxdEy0KmOX2CMp7bL/ClVQxHIzNgq0qCSZgE7+BjzGHLyF+Qb4HJbyVjpE5oJA43c2aB17B2PS
 OnVIdtpsUE1RoQY4Sn/D+
X-Google-Smtp-Source: AGHT+IHQH+2ak/06f6fn8GK6DgfSQGWUEkh84HvE7OaEn0x/lWkyH/6xHBwy7W7rq+laNHbh+PJcQA==
X-Received: by 2002:a05:620a:2942:b0:7c5:e35f:61c with SMTP id
 af79cd13be357-7c775a3028fmr2073634385a.28.1744050249826; 
 Mon, 07 Apr 2025 11:24:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4791b088428sm63192571cf.38.2025.04.07.11.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 11:24:09 -0700 (PDT)
Date: Mon, 7 Apr 2025 11:22:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/4]
Message-ID: <20250407112251.03371608@hermes.local>
In-Reply-To: <1744007812-4708-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577112-119739-1-git-send-email-liwencheng@phytium.com.cn>
 <1744007812-4708-1-git-send-email-liwencheng@phytium.com.cn>
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

On Mon,  7 Apr 2025 06:36:52 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

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
> Wencheng Li (4):
>   usertools/dpdk-devbind: add platform devices support
>   net/macb: add new poll mode driver
>   net/macb: add NEON vectorized Rx/Tx
>   net/macb: add necessary docs and update related files
> 
>  .mailmap                               |    1 +
>  MAINTAINERS                            |    6 +
>  doc/guides/nics/features/macb.ini      |   27 +
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/nics/macb.rst               |   26 +
>  doc/guides/rel_notes/release_25_07.rst |    4 +
>  drivers/net/macb/base/generic_phy.c    |  271 +++++
>  drivers/net/macb/base/generic_phy.h    |  202 ++++
>  drivers/net/macb/base/macb_common.c    |  670 ++++++++++++
>  drivers/net/macb/base/macb_common.h    |  253 +++++
>  drivers/net/macb/base/macb_errno.h     |   58 +
>  drivers/net/macb/base/macb_hw.h        | 1138 +++++++++++++++++++
>  drivers/net/macb/base/macb_type.h      |   23 +
>  drivers/net/macb/base/macb_uio.c       |  351 ++++++
>  drivers/net/macb/base/macb_uio.h       |   50 +
>  drivers/net/macb/base/meson.build      |   29 +
>  drivers/net/macb/macb_ethdev.c         | 1861 ++++++++++++++++++++++++++++++++
>  drivers/net/macb/macb_ethdev.h         |   91 ++
>  drivers/net/macb/macb_log.h            |   19 +
>  drivers/net/macb/macb_rxtx.c           | 1394 ++++++++++++++++++++++++
>  drivers/net/macb/macb_rxtx.h           |  325 ++++++
>  drivers/net/macb/macb_rxtx_vec_neon.c  |  675 ++++++++++++
>  drivers/net/macb/meson.build           |   23 +
>  drivers/net/meson.build                |    1 +
>  usertools/dpdk-devbind.py              |  131 ++-
>  25 files changed, 7613 insertions(+), 17 deletions(-)
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

Please put a subject on your cover letter, without it patchwork gets confused.
