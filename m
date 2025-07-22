Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B7EC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 04:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0513B402CC;
	Tue, 22 Jul 2025 06:04:47 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id DB9D2402CA
 for <dev@dpdk.org>; Tue, 22 Jul 2025 06:04:45 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4ab61ecc1e8so37993811cf.1
 for <dev@dpdk.org>; Mon, 21 Jul 2025 21:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753157085;
 x=1753761885; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpHvxqlX7OcnxJPCs0nCNowC+j6KarE8ktvVLZ7bWvM=;
 b=V8WavRbnyGLvRT1DpmDC3DgKjgO4jlCiMfnrjHm+A9OQf5H58M5PVxU42Q9ie50ev9
 GbdBaChsreSdNgt1s9QietmqI63CU+j8CZG8Nb3Us35uO1JWUkIMwPKKNM+BNd0wB1Bt
 yL2ThvIMb5siJ4R14d1Ssi5DMHwIU96up6ZlKS2i7XAp5lgBZHOrMNXC7Gxbfs6ZX7mP
 t3Xwxn+jjJ+GC9bFZXE9/faSAiYtYO0gfBVH/uTvxvV3VAsEO7bXj6q9ikM+Q+s20yTc
 vEr9KNsvD6oVQSx5yY/aWWO9bZ8gE6jGL/1UcB7/S30UsrJlHAuYmYpmNrpR+35mr0AM
 8nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753157085; x=1753761885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpHvxqlX7OcnxJPCs0nCNowC+j6KarE8ktvVLZ7bWvM=;
 b=qjHbfJcB1qPsfK4qJZkwOfaQMQ0txbJY8BmQUUyVPKbCU/KfDf43rDIYnNWycPLfIR
 5wWXxdQeW3gxBXTV2FR9vzYnT1z1y0/s5+0FMlI/ZrkBXm0EKXKFrGwdq8qXIaBYG7Vy
 pnSWH/oljli48h2aouPBFx0JuniDh55jNYaFb78rPgRt79dZ2UcKvyF4fMfQ3KERTX27
 FVoE2iRO1neEVd9w+JZ7K+f3k88HAWyzRhwlbz85wBdch9Y1TIfXQaxSNeav3ptgdqyv
 1J1rEXaelOmYrYP0Ov93YbSu97zn+rWoxSNQjZhPRMUwGdBpxs4A8X9Ub2mxxdAiqKoK
 kSzQ==
X-Gm-Message-State: AOJu0YylyQrHc1MzhVI6Op8UwhnjOj7qKufQpDFXJ/SLIlECI26aO95S
 HiU/jDm+0uORn4ViXFYge0dm5lzE5Fwx3W4pMWi5H9BZbtOTJ60RK3JxqzRd/8Mv4a8=
X-Gm-Gg: ASbGncu9UDoN+Q16L7Y1dUZK0/Sqq5ewuTrvj5vZL22mvZlBw7YK28kxI+bQascXrTP
 TpcMBHvska9cFSiYg58UtaJDO8rrvDlfxA1GrdONXXxt+xDPhW3XDvCJARsE0/VIBKqhZ3mVnci
 9n1EvTd+t8e1QhpR+KUbnkWX06wR/fSBtmEYPu+9O3cV4PWCca8QIXjcunpMO7Ywb23lVfHUYLC
 413NGS+3VolXGRjc48mRHfTSV8kXeybYdbj6rvaKKhTLzdf7Xg9q4Dmieao3aXnm1LJAVvmM895
 2WFKiWB0I2Ccl1FPiAii8PQLDsT2qrvC6j78spof9r680wtUJ0dtviZjohB4ouFQtQPvlMXN6vz
 hevKdUMJgXJ8eTTSTgIQqTnOl7yXXXwGmBKiR9AcwCrR2oM6wzIdHA2dadQJba0I6oBVQaUx3Si
 0=
X-Google-Smtp-Source: AGHT+IEJc/NkV+rfXETtW8Xj2i547PuBpXVwVfU5/SAxlsBgqeJtJbilADFZ+MmUG9sa5gj/Mt+W5A==
X-Received: by 2002:a05:622a:13d2:b0:4a7:2f49:37d6 with SMTP id
 d75a77b69052e-4ab93c509a8mr315033671cf.5.1753157085153; 
 Mon, 21 Jul 2025 21:04:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4b46b27sm50478321cf.64.2025.07.21.21.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 21:04:45 -0700 (PDT)
Date: Mon, 21 Jul 2025 21:00:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, Aman Singh
 <aman.deep.singh@intel.com>, Yuying Zhang <yuying.zhang@intel.com>
Subject: Re: [PATCH v9 1/1] app/testpmd: canonicalize short PCI name format
Message-ID: <20250721210018.3687d8ba@hermes.local>
In-Reply-To: <20250713063417.10998-2-shperetz@nvidia.com>
References: <20250708083740.128610-2-shperetz@nvidia.com>
 <20250713063417.10998-1-shperetz@nvidia.com>
 <20250713063417.10998-2-shperetz@nvidia.com>
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

On Sun, 13 Jul 2025 09:34:17 +0300
Shani Peretz <shperetz@nvidia.com> wrote:

> when providing short format PCI device names in devargs
> (e.g. "08:00:0") it is converted and stored as long format.
> however when attach_port is called from testpmd, the user might
> provide a short format, which will be passed to find_device with
> a comparison function that simply compare strings, which will
> cause find_device not to find any device.
> 
> This fix canonicalize the user provided string before it is being
> passed to find_device.
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---

Queued to next-net for 25.11
