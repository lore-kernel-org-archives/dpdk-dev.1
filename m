Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A639C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 641D942794;
	Wed, 19 Feb 2025 17:48:12 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0264D42790
 for <dev@dpdk.org>; Wed, 19 Feb 2025 17:48:10 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2211cd4463cso75802945ad.2
 for <dev@dpdk.org>; Wed, 19 Feb 2025 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739983690;
 x=1740588490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71CWn3+7yzdV2nuPl4ZQU8yIv0d+NDwXV0UutKgvr1o=;
 b=Dc/wwhqtCHR2sefiiAvwLO52d/HBqUKJkXm4HXOezjoWc0keCYiTPe/7WhQVCM9F7Q
 dFkkdC/Y5kqHcKwXPrk4A/n+VTOyme0CM+T/1eixkskpIz3ystofdiArDlV67ogAzmwk
 zBZU9tldj/8Kh2RlUbklUhPa+FhzRgBb0PCeQCJPOSzoBSB4K2YxBA9gxJjiVphSm+2h
 AXpbHEzW5wD7lqK6LyHV0sOL5rZWEIjuSANXCvQSguOsOVcA2c1aIJE5APyM0QRfG8fv
 LwuWDu69yPtMXKYTy/7KZPuzPG7/E40FMKs8QsWVApdJzH+QJYA+8rxFUCnGYZIDc/w9
 Xo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739983690; x=1740588490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71CWn3+7yzdV2nuPl4ZQU8yIv0d+NDwXV0UutKgvr1o=;
 b=nzOlOi6IIfIuce+rcUFumGWdh6AEOcvAREN27aDDklW+beQlKksfZPw3LRL7eSgHYi
 uOCLV+u1uQ8iaOkozAruEqYU+8vAAXVHXi7tga4BmCesa41QjdSLlbKCTrAIkLEsM2V5
 YNgn+OvrbyMREdwV2IUckai7QaF6u035+gbsQ2v1n8CRFd286uD2tFFdMhVjKT4eTV3B
 UReGuEMnkjS602utlRgmErdRileKQ4w8FKx+xKuIjoQKXMdoXvAd4v786Z2K4lvcDjOP
 ZJOG9xPvxK4f/MF05uQ74dwNkXQ45CHbXh8CQNP1T9ji5t6nPFb3l3U3Tj5RX6Fg9/+x
 i2Zg==
X-Gm-Message-State: AOJu0YznbME0vVlPamIupZKUwCwE1VngpL5SVYGhSNTmT2OuVIkrtd+R
 u7T/tArhLrPb+zZhFtScNd1o7T6Q5IxP6fDxV0bPIQ4ug0/ga8RdjvY5Piq3tjs=
X-Gm-Gg: ASbGnctFlCHNXS8PWXkeNOjiNx7cyMIuIeGSSXc6coFg2olYrkGvO2XAODlXnQHctVJ
 OXqydGisz9BYXv/xrHQ7xrQT559lwBcVKgKlreFUIOM5lIcHVqSnqoel/AmTOCxXWypquNUqosS
 oBg8wpbDVSHZYp7tyDHdxR1ZI9c4KPt4bU9g1exG3I3O756CHGL1aVJ0EQ/dVHcZPONJHb+TGTE
 DN8wEwYyGhsBfuCENn8dOXKSF1cjolksOtUvjhaEi2+RXpwAWWv29es4V5C8HYLvVltjKq5D36e
 VqFEdqwi8bmJlwUPKmPqCiaA6BioY8wW+MbVsrptZaUN3J2MiRfAHKvkckK556jpSzKn
X-Google-Smtp-Source: AGHT+IFyDE+ioHKx67jwRWJOicp6gHBQ9QHGPnckX1qekhWwR8ZRCymA8Zv7TNpzQdGogWGFtqT4Iw==
X-Received: by 2002:a05:6a00:810:b0:732:5a8f:f51a with SMTP id
 d2e1a72fcca58-732617b62eemr30339054b3a.8.1739983690167; 
 Wed, 19 Feb 2025 08:48:10 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732752034e0sm7023700b3a.138.2025.02.19.08.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 08:48:09 -0800 (PST)
Date: Wed, 19 Feb 2025 08:48:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Gaetan Rivet <grive@u256.net>
Subject: Re: [PATCH v7 1/4] bus/pci: fix registration of PCI device
Message-ID: <20250219084808.3d0a312a@hermes.local>
In-Reply-To: <20250212163836.178976-1-shperetz@nvidia.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
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

On Wed, 12 Feb 2025 18:38:32 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> When registering a new PCI device, the device->name field stored
> the user-provided string from devargs (e.g., "08:00.0" or "0000:08:00.0").
> This approach led to inconsistencies when registering new devices.
> 
> This patch fix this issue by saving the parsed PCI in device->name,
> so when a new PCI device is registering the name displayed in the device
> list will be the parsed version.
> 
> Fixes: 23eaa9059ec2 ("bus/pci: use given name as generic name")
> 
> Cc: stable@dpdk.org
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
