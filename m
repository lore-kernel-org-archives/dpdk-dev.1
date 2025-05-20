Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DBCC3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 17:12:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00F9540BA6;
	Tue, 20 May 2025 19:12:28 +0200 (CEST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id AFD294029C
 for <dev@dpdk.org>; Tue, 20 May 2025 19:12:26 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-601dbd75b74so4062773a12.1
 for <dev@dpdk.org>; Tue, 20 May 2025 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747761146;
 x=1748365946; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QJIfaSeAD6QLG0ORgSyKNt8raiK5JfL1ruHMmN2hJ4=;
 b=xS37T+/Po0WSb5yHZr1CpbxjBl1T521lS5swih2JClpIkV4gLBGTliWngUTnLNvDfC
 GkafXPtgBXhq1/6sF3yB5+Q8hW4pbhPiF8fU3Gh5an40mgL0R74+/RfSzJhgWBvzsBLL
 NAkdhzrqM/3lXICwXJ9sYCPd7g8QnxwiM04NGoDCgsYC/bv8aVrXsGPi4UAZdh1ai7Ne
 pccgXOu06HQjxQyloTOXT9v02swfvGoB/Fb3fBWrgs40sy27Fzs/mZJiXvzfAPtlI5dI
 x/hrNRSJeOzrMFFMoRK1I1xe350lyp0cx4UP8RkofVl0/6t6//3zMeuRa+JiLnWon8++
 i+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747761146; x=1748365946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QJIfaSeAD6QLG0ORgSyKNt8raiK5JfL1ruHMmN2hJ4=;
 b=PuZdn0tledLfAlQBqdAVVOZJpjj3KjE0zBfBTfrOAvsSosSp4op9qoMYrZvmSa6A1A
 xyhasbf6gxOc5iVBG2qKUY3DFEkWosh+bbEfiahIIrOq07dY5lzu3tszM6BbCU60Zdgq
 JlGdnj797B7x1/P4E33Je8007gnUPa03+Gb30eeV2R3vsgZ8EggH0q+3WjdIoifznCk4
 oKw3i56c5eOjwz8m6suwr4HuXNbwBxeIV/7c5MMymXK7tIm6x+QWREPCxzY2lYcXtAzu
 cVdpeUXxbL2B3Iw+GcFmNNfHXvNgWApM70+zTghADQOQkWmZlEjnagBUeVcozh3PINfG
 JfNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1QG8SwqJTHXBf2DbvgTRVdIpIsYT4XstPdKVZ+sXxPU3Ie7m1mX44AMo6a2kxP6U8RvU=@dpdk.org
X-Gm-Message-State: AOJu0YzgH61xnzcQuhzu0OEr2PqY0dN7BemMuph9WafuysFXYwdzJklL
 rCTR1O55wFfpjax4jOPJKaxipZzsVkfhalakoNINcw4CDEofxmQ+5X3EOZ3XIRdntQA7Si3J45B
 Y0GSFCuc=
X-Gm-Gg: ASbGncv0EJjd70sxS3AiTLK0lE4tvWNHyihZByZlWX8iS3hwfGZmiEl8KEiCaBv3aCy
 SPu7iRIi8t7xIm5BkgbuKFMwXrUpfEwhQgvJqBA6zmIO+zVaXgb1QklMV1I2u6NBJcbeItcs6pI
 D1TlW28oR7OTGS9peX+7BQNK3t5W4mrK5GBJtdEUlTi3QEzGFQ6huezK/3ZkLY4P+3KHd/7pRNI
 +xQZidSKNRwoRyWPaZUepOdOjoB+/rBhbSyY2UBjukU07T/p+eANs/uiv678gL0bXLPvedFVRbu
 KZOBcPyK1r4N+Vuy6NHGF4iw1z3gBmSQW0QeykxVtR/6XOiYVTNE+HWXg9MXP7itwDct9w8W6A9
 2FOZk/e1zsnEnNlJWG5h6osecvy5O
X-Google-Smtp-Source: AGHT+IHQ74khkBJytLS2hqnnWrUksRxlvZOokoRhFkxn40dOCvMzPvcP7z9Sd8bVxdn1TXcRhUiaWA==
X-Received: by 2002:a17:907:97ca:b0:ace:cc7f:8abe with SMTP id
 a640c23a62f3a-ad536c22d77mr1472325066b.31.1747761145991; 
 Tue, 20 May 2025 10:12:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4382e2sm763412066b.107.2025.05.20.10.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:12:25 -0700 (PDT)
Date: Tue, 20 May 2025 10:12:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: alvin.wang@nebula-matrix.com, dev@dpdk.org
Subject: Re: [PATCH] bus/pci: introduce get_iova_mode for pci dev
Message-ID: <20250520101213.588fd16d@hermes.local>
In-Reply-To: <20250424123409.1741-1-kyo.liu@nebula-matrix.com>
References: <20250424123409.1741-1-kyo.liu@nebula-matrix.com>
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

On Thu, 24 Apr 2025 12:34:09 +0000
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

Please put this in the set of patches when you contribute the driver.
We like to review the full driver, not just one change like this.
