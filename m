Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8698C0219B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 18:08:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ACF942ED5;
	Fri,  7 Feb 2025 19:08:05 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1040342E90
 for <dev@dpdk.org>; Fri,  7 Feb 2025 19:08:04 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-21f5a224544so10167965ad.0
 for <dev@dpdk.org>; Fri, 07 Feb 2025 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738951683;
 x=1739556483; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qG0Zy4Ra0vdhsjcBYTEiAkGb4owglaMKQK9+oRJMPcM=;
 b=bZEthUpfMUESFeC9bZFEXMfGUSKqCjy8sP1o3TccEU7Av28XXpCuiWZpIOAKItZqX1
 dHZ4Xp1xMHoKIy6t/B/PN9FuPWA69iG4T0wSNJvkQ+xA/l7p3jEOE6r7vvrZPFiaByTQ
 cE51sx/6sAYB+wrpqxhqzVaM2CTzRp5FuWAfDAuL1TA1oNDABLrp6kmqmieBicN0K15A
 WHBd1xqHpuyPyHF9Z37PiwDHQXebe8WkJ4tmTB/W+ZPHZiGXVs5OEjMP61CdDQYLWZH3
 CO5sUoczKU6n4QaRVKXTVmfM5bnV5K1eEOlrspLChO58nxZsHVT6guj2yRU3739tiqei
 Vtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738951683; x=1739556483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qG0Zy4Ra0vdhsjcBYTEiAkGb4owglaMKQK9+oRJMPcM=;
 b=RfcxNxfIDGbekyrkbmzwhcwqVCu0kqf2UWMsXplHc+k+jdinSAICUG4U4kHnlszG+F
 XituuFMAIyL03OkuADiUYm7EhM+r4UuaI2sJmd/6IdgEijF6nm6PeGCpNJruyn5aHZHw
 B/wRPS54rOgLpgJKW6I+yChsWEBdi1S6ArW4IpXZzCYJbT9NFyr2xfBpivTlYwNLuKF0
 k1KjJOawFgNjZjqQdnpmflGZgWfpZPkSPIcDeqw/U5Qh4AXrh6JpshFl7D7pNxiuN0K6
 +tTnZEPNY5BwdWarHodaZxx5u0qAV+wwlpy8+76u6LzCbD8pZasS8VkvQNJ/RBjQC9eY
 K1/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUJmgWP1YyND0ACwqB+qw4qxIif2BSAH5j73cPOAaPpNQ6f5TtbyIpFxdx8kIFh6YUPt0=@dpdk.org
X-Gm-Message-State: AOJu0YzG2DtN/yxwKkygnw8i6ai900gpGe0qG8NgBlsSggbEOfB8/K6t
 i9ioV5oGEkxPhd9TyCGanagwPD8w26XZm3oajf3Mgcvjb98X4hX42Og2gOO4O10=
X-Gm-Gg: ASbGncu8HfYWwxt4olSahYDm9dru/dn3eqpMXJIJ8LMyIS0fwQGG6n4KLMU7OAMcQsv
 3U4SsAi+91jC5pP7nR8Uv4aItM49pRFE7iYnBnUnZ6pLQ6yH50uu53gHSDK0H8r9q4O4yY0Z+NW
 a1q6Ks/EcdttGww8rbjBNnlY86GJ5wcQuNccHrSnWcRdD6OVUOz/DQT0cMuV2fx+9vYfDAmEVjy
 5f5ywsb7KA0N17sM8Ah1+yCDll9lveeQEwTSrtiTeJay5VJdULl+GS3p0LKgaAxHfOPasniJL1q
 WyhGGwasc+9GarQAzd5n36qJVafKz1SpiPBGwMo4R1TIQ6AqZZAuExPJAYVbUR1sGybJ
X-Google-Smtp-Source: AGHT+IE3bszoyer6d6umTVL3+tl5ebExFRO3OdYKjh+0IwRa5LO9Vzs+gN9rjiAeD4U2ta1P4qFgjQ==
X-Received: by 2002:a17:903:186:b0:21f:75f:295 with SMTP id
 d9443c01a7336-21f4e716a17mr63554115ad.31.1738951683072; 
 Fri, 07 Feb 2025 10:08:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c7b6sm33634155ad.196.2025.02.07.10.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:08:02 -0800 (PST)
Date: Fri, 7 Feb 2025 10:08:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: anatoly.burakov@intel.com, dev@dpdk.org
Subject: Re: [PATCH] net/sxe: add base driver directory and doc
Message-ID: <20250207100800.220bdb29@hermes.local>
In-Reply-To: <20250103082909.8720-1-liujie5@linkdatatechnology.com>
References: <20250103082909.8720-1-liujie5@linkdatatechnology.com>
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

On Fri,  3 Jan 2025 00:29:09 -0800
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
>  MAINTAINERS                         |  6 +++++
>  doc/guides/nics/features/sxe.ini    | 10 +++++++
>  doc/guides/nics/features/sxe_vf.ini | 10 +++++++
>  doc/guides/nics/index.rst           |  1 +
>  doc/guides/nics/sxe.rst             | 41 +++++++++++++++++++++++++++++
>  drivers/net/sxe/meson.build         |  9 +++++++
>  drivers/net/sxe/pf/sxe_ethdev.c     |  3 +++
>  drivers/net/sxe/pf/sxe_ethdev.h     |  3 +++
>  8 files changed, 83 insertions(+)
>  create mode 100644 doc/guides/nics/features/sxe.ini
>  create mode 100644 doc/guides/nics/features/sxe_vf.ini
>  create mode 100644 doc/guides/nics/sxe.rst
>  create mode 100644 drivers/net/sxe/meson.build
>  create mode 100644 drivers/net/sxe/pf/sxe_ethdev.c
>  create mode 100644 drivers/net/sxe/pf/sxe_ethdev.h

Thank you for starting work on a new driver.
We only accept drivers that have enough implemented to be useful.
No templates or base only code.

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60bdcce543..0af5b437db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2039,3 +2039,9 @@ F: examples/vmdq/
>  F: doc/guides/sample_app_ug/vmdq_forwarding.rst
>  F: examples/vmdq_dcb/
>  F: doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
> +
> +Linkdata sxe
> +M: Jie Li <lijie@linkdatatechnology.com>
> +F: drivers/net/sxe/
> +F: doc/guides/nics/sxe.rst
> +F: doc/guides/nics/features/sxe*.ini

The maintainers file has sections. There is one for Ethernet drivers.
You should add your new entry there and in alphabetical order.
That would put 'Linkdata sxe' after the last Intel driver 'Intel ip3nke'


> diff --git a/doc/guides/nics/sxe.rst b/doc/guides/nics/sxe.rst
> new file mode 100644
> index 0000000000..0efb220595
> --- /dev/null
> +++ b/doc/guides/nics/sxe.rst
> @@ -0,0 +1,41 @@
> +..  SPDX-License-Identifier: BSD-3-Clause
> +    Copyright (C), 2022, Linkdata Technology Co., Ltd.
> +
> +SXE Poll Mode Driver
> +======================
> +
> +The SXE PMD (librte_pmd_sxe) provides poll mode driver support
> +for Linkdata 1160-2X 10GE Ethernet Adapter.
> +
> +
> +Configuration
> +-------------
> +
> +Dynamic Logging Parameters
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +One may leverage EAL option "--log-level" to change default levels
> +for the log types supported by the driver. The option is used with
> +an argument typically consisting of two parts separated by a colon.

This is awkward sentence don't use passive voice.
Look at the recent NTNIC PMD (ntnic.rst) for better wording.


> +
> +SXE PMD provides the following log types available for control:
> +
> +- ``pmd.net.sxe.drv`` (default level is **DEBUG**)
> +
> +  Affects driver-wide messages unrelated to any particular devices.
> +
> +- ``pmd.net.sxe.init`` (default level is **DEBUG**)
> +
> +  Extra logging of the messages during PMD initialization.
> +
> +- ``pmd.net.sxe.rx`` (default level is **DEBUG**)
> +
> +  Affects rx-wide messages.
> +- ``pmd.net.sxe.tx`` (default level is **DEBUG**)

The default in the release should not be DEBUG.
That implies to me the driver is not tested and ready.


> +Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
> +for details.

That part is not necessary.


Please resubmit when more is ready.
See https://doc.dpdk.org/guides/contributing/new_driver.html

