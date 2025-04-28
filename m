Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D01CC3ABA4
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:50:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9607040678;
	Mon, 28 Apr 2025 17:50:36 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 3D90B4021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 17:50:35 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3031354f134so4148538a91.3
 for <dev@dpdk.org>; Mon, 28 Apr 2025 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745855434;
 x=1746460234; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dXUxHf+Z7AlQ8LTj90EQdeNoM01ZPS19NE61kD3rSc=;
 b=SDCEjDskp6yIFuRnenKt1/YxfIQ6o8SFCFXtsqHzsEJ/RtaJCb7avoBT9DA/i6pcgj
 c9+jDEZ0Z/WNYC4Q2aHbjkvJH/G9DPoQBfdPgwpcuLf9Db9vBbmQUHIESGUiqpaBi8cB
 ILy3lkgxJbotgmiHLr2U1zOmwxNDocNljFnX+iNrakOxmRXBoe3HkOKMixXBeS7Uxtim
 7wHPzpgSPqUUkUtIKJpiCdIpsXvwM2Ik++qC94kcGgnRWWhxybfkkjfkQDzlxaWCJ1yz
 SAdmjLEuK1gMk2tmqol2iTkq71UIhsFZe4qzxZUFeXTNL4gbmQnCmfIdlEtOhZafFdow
 nDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745855434; x=1746460234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dXUxHf+Z7AlQ8LTj90EQdeNoM01ZPS19NE61kD3rSc=;
 b=ElFxkmDmABw3UFEgB4jE8dpGW2Ft9M6RvIIoaIzTsPZsbQWkArSX7+hg75iebgCyhK
 C9SO6qxab1zcAFs0eC/KwLAlq+j/szI31q0MH5vAK+K9OEb0I5D9XAZeCgdPIpYB9G5a
 CQwTjT6EbNj83rJc3WnofW1kp0iuxYBN64C89hTzXzYObhUX9XdM63WsM9sPPigm9Mn5
 1YAkzwDYr+9EtdU/foDhZ6OBdHqUnkew/zu3iHSubLGCm/YCo9LN2ioQNTUTl2jEsl3B
 QQ34jaL7Jx+qan+so+Aj/wZzorr5bvM11ZzTI/N5/np7oL2Zeu5xLVn9dXK+kkvMC6W3
 0IIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYFC2cVPF5vQ8J5fbaFAXeegukPm/OjVU3kJxTGEdo5FMHK2EnQ/DnnGPwNzpnmKHSg5I=@dpdk.org
X-Gm-Message-State: AOJu0YyOJfjzXXdlZAQyZ7WKE+PVG/1UeG4exWXsLju3ZBU4v/yhvDSV
 IFn4GHufMuT/2pZwEkHephC+bIPuHRiEJHx+h2WZKF1xxcNedGJuvL/Ldpk2/U4=
X-Gm-Gg: ASbGnctcrjizi8R1xi9UhrTEQHiLMPd10WnjfSlwLQtcHhkESFu2g8XZqy59axTF/u7
 u3ivuspDk0U9A8RUsgxaTv6FHD8VRhP7ude0Yz4fv7gTUFnFkTmWnHF4N6UtoWy6WhbeZx6mhMi
 1iJM4z+8mA+jojA/kR4N889YRWgdqk6pkW2agDwi9SlGGuxBuv/voVUKej0tJ+2cgVsJxqAc8ki
 Kf2Y+yzrc6dLNa1pqWMeKL8DQKnJFLD5XF+PZ6KF/aWFie2xxPcXJBz/MVqX4Nyuqhe+n6IRXX8
 qHfARrp2d/9zsbBFmOYRYc7nExYL9FhTNl6OMefC/tiv+WRaFYCiXofu6LoC92Tkuoq2TSy8L9l
 9VX391nzYN9E45htF
X-Google-Smtp-Source: AGHT+IH6dCjXZ9qptda7RtSmNlHOHssGdIhKlwg2y3P1tFtFXYaXjefxqfsY6KugE9AT6t1WegPrag==
X-Received: by 2002:a17:90b:5704:b0:309:fe2b:306f with SMTP id
 98e67ed59e1d1-30a2158ed1bmr338530a91.26.1745855434337; 
 Mon, 28 Apr 2025 08:50:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7763edbsm7353191a91.22.2025.04.28.08.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 08:50:34 -0700 (PDT)
Date: Mon, 28 Apr 2025 08:50:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, dev@dpdk.org
Subject: Re: [PATCH v3 1/1] bus/pci: introduce get_iova_mode for pci dev
Message-ID: <20250428085032.0c48239a@hermes.local>
In-Reply-To: <20250427022734.151043-1-kyo.liu@nebula-matrix.com>
References: <20250427013611.150888-1-kyo.liu>
 <20250427022734.151043-1-kyo.liu@nebula-matrix.com>
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

On Sun, 27 Apr 2025 02:27:34 +0000
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

Looks like this might also end up being ABI change so may have
to wait for 25.11
