Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC3C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 17:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1DFD410FB;
	Thu, 12 Jun 2025 19:40:40 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id C1990400D6
 for <dev@dpdk.org>; Thu, 12 Jun 2025 19:40:38 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4a6f6d52af7so14236761cf.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749750038;
 x=1750354838; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wA8mL6fs+vt4O6I0nMkawxKwvhvqzgLhPmRkv7ekQcE=;
 b=x/D2NRoQwjwc148wziofL7anZ5vDXsbgfVH9MPAQ6S3XtpjJ03R9ro9oyQDv00OYrY
 im9t9pH/8aIAyJ+OnSmzIWPZyw/dYCxFG+6ro3AQn/pAykBZfZwQvWN6uzoud69QKpT5
 n6Ew9/F9NcWOoaYzOlWY4cS+7fMHuYxs3m/da9oiVjMK0ByOUxeTVrX6M/HRZE3F9Dwx
 yLBumqvW/k4pgbuhFksOIk4gWqkRyDht+3VbzwN9A6AIuPYkRM8kRPlNSBf4ST6o2nSm
 HzRULb9NEnAiF8rnliC0dPwl5zBrJGrKnHbuf5MEWfcZcwIAmUxZ28mitkGwEatwO+ZH
 lG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749750038; x=1750354838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wA8mL6fs+vt4O6I0nMkawxKwvhvqzgLhPmRkv7ekQcE=;
 b=CFBe9AGPPtO/fJDoDW9ReFdIcXllHaL/bINB2XT+ctL7aiPS5BBteJAf0SLRjo+vEh
 tcCOgPx9/xXBv3CyFGKup/Cyj/pg+XHtYWrI0slIx0MExjru3unIMhjKKSeTijcDEzvu
 LtIt9T40MzMWOGQYxIAfQAdtPEPzVCfb+EgMqJdVkMpow0a3OhGpYYooqciaBQCqY7uC
 KoOJY/gpVfcSk/tGpU5Fw5DWPxYo+uRYzV45/wqCqHIdTsPPkOmUxSzbxoEcvBIn5un4
 CQBZ0c/KO48KqEnJeZWce4tuXGzsBmQ6644jgXW40/G0EU8zz4BluDGunOqmqmhrBogK
 j2fw==
X-Gm-Message-State: AOJu0YxcOuG4P7leD2/U5DUu7d2hbQVk0C3ZDgPGyd1uzVLRX7ahMpvW
 jEOyFd7lfYrAi5craY+Ql1jdrP40TV7afPU1BoaKPbOVh6rdvQzBNHlkYXoqXxwxl3w=
X-Gm-Gg: ASbGncuWISyfhpcbf3V29g3oq36jYXXS0MHNHq/H27/M6IequQC4DdG2dJr/05ghyN4
 wgY+KmuXb8SD9zIUaNypJ2urF8MgzWIVuVjXhbBxEyJRLozIaqAi225Kmbuk4L7ChcRSdywP5Um
 gQJ/IRSneld0SngAKUxNjHaY8bmnbtwsdtui6KRnoPrkCKRfsZ0VOR0DHvN/6dclROK4Zd02zK7
 XqBCs9KAGYDNWG6j4iUuQt8llCpiLRj7h6znXpo1/jTaldOBMy9lFxcSyOME+O85B9wkGDJvoic
 7u8ju28eV8BHI+c/cmo6Z1bnNu1NiE1T0dIWNU3eIhK2ZQpAs0r6Dt118LOIwa/oGzkdoX085Lr
 XcdVjZHWyHZbJjm5X/LOJj4Y6oOZ9nsdIWKGsuJE=
X-Google-Smtp-Source: AGHT+IEdsP6pi75i3H9aZZ8RLRpcYv7jicE4onlnnTN/KifFrF38GXusk7YWOjhH3NTJEZEednAPIQ==
X-Received: by 2002:a05:622a:1e09:b0:4a6:c5ee:6ced with SMTP id
 d75a77b69052e-4a72fe5b358mr1366311cf.4.1749750037873; 
 Thu, 12 Jun 2025 10:40:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a4b1620sm6572241cf.43.2025.06.12.10.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:40:37 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:40:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>
Subject: Re: [PATCH v1 10/17] net/nbl:  bus/pci: introduce get_iova_mode for
 pci dev
Message-ID: <20250612104034.5d5abac9@hermes.local>
In-Reply-To: <20250612085840.729830-11-kyo.liu@nebula-matrix.com>
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
 <20250612085840.729830-11-kyo.liu@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 12 Jun 2025 08:58:31 +0000
Kyo Liu <kyo.liu@nebula-matrix.com> wrote:

> I propose this patch for DPDK to enable coexistence between
> DPDK and kernel drivers for regular NICs.This solution requires
> adding a new pci_ops in rte_pci_driver, through which DPDK will
> retrieve the required IOVA mode from the vendor driver.
> This mechanism is necessary to handle different IOMMU
> configurations and operating modes. Below is a detailed
> analysis of various scenarios:
>=20
> 1. When IOMMU is enabled:
> 1.1 With PT (Pass-Through) enabled:
> In this case, the domain type is IOMMU_DOMAIN_IDENTITY,
> which prevents vendor drivers from setting IOVA->PA mapping tables.
> Therefore, DPDK must use PA mode. To achieve this:
> The vendor kernel driver will register a character device (cdev) to
> communicate with DPDK. This cdev handles device operations
> (open, mmap, etc.) and ultimately
> programs the hardware registers.
>=20
> 1.2 With PT disabled:
> Here, the vendor driver doesn't enforce specific IOVA mode requirements.
> Our implementation will:
> Integrate a mediated device (mdev) in the vendor driver.
> This mdev interacts with DPDK and manages IOVA->PA mapping configurations.
>=20
> 2. When IOMMU is disabled:
> The vendor driver mandates PA mode (consistent with DPDK's PA mode
> requirement in this scenario).
> A character device (cdev) will similarly be registered for DPDK
> communication.
>=20
> Summary:
> The solution leverages multiple technologies:
> mdev for IOVA management when IOMMU is partially enabled.
> VFIO for device passthrough operations.
> cdev for register programming coordination.
> A new pci_ops interface in DPDK to dynamically determine IOVA modes.
> This architecture enables clean coexistence by establishing standardized
> communication channels between DPDK and vendor drivers across different
> IOMMU configurations.
>=20
> Motivation for the Patch:
> This patch is introduced to prepare for the upcoming open-source
> contribution of our NebulaMatrix SNIC driver to DPDK. We aim to
> ensure that our SNIC can seamlessly coexist with kernel drivers
> using this mechanism. By adopting the proposed
> architecture=E2=80=94leveraging dynamic IOVA mode negotiation via pci_ops,
> mediated devices (mdev), and character device (cdev)
> interactions=E2=80=94we enable our SNIC to operate in hybrid environments
> here both DPDK and kernel drivers may manage the same hardware.
> This design aligns with DPDK=E2=80=99s scalability goals and ensures
> compatibility across diverse IOMMU configurations, which is critical
> for real-world deployment scenarios.
>=20
> Signed-off-by: Kyo Liu <kyo.liu@nebula-matrix.com>

This needs more review, there are alternatives.
Will not be part of this 25.07 release, maybe for 25.11 but want input
from other community members since potential impact for all drivers.
