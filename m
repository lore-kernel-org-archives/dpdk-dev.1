Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211EC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:37:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED2F40E1E;
	Wed, 16 Apr 2025 16:37:20 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 64D7C40655
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:37:20 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-22928d629faso68331135ad.3
 for <dev@dpdk.org>; Wed, 16 Apr 2025 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744814239;
 x=1745419039; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ClDc7FPmhf4y2VY4HXhvzDCvDnEuiL56nEehf260WHQ=;
 b=kLsV1WkIIsuxv3nYlWNlLmC9HUxF4+mFjgIV9jUDuOiqaD6/I4SgYstOY5kL2Bq95l
 uIJ7OZRsgbAMOsZ6zn69ELKfDZZ5cFEWoAzyIhGztU3k0CECGskFhOOz3N4R5q6ILu83
 jdaOctTu86oiSVOprU3fOjPhGJw3XPJSN697PYEHMQQBbBab2rz41xNYeX4mIt+PTMW2
 1gPj2efcvmmHgUy6yA7JWbZEmRXbPd8+0EZgQOqUwrJcNgXKhEgqbNsPwRJJqe1B0ueA
 rb1Y+DzvZAm3+jP/y26bAt8vlL2ulCr15YMQ2fv1TgBQWAukkalwNT6uNzCAvIMzyddD
 49rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744814239; x=1745419039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClDc7FPmhf4y2VY4HXhvzDCvDnEuiL56nEehf260WHQ=;
 b=ciYLmZS12znM3nhUphGHu9JXYoF61JaQtGFnQIKshpLJQsyapAlnmuShli0wTAw6S7
 Yd2Ik+Q2iIZOAeFh1jab3jlNFWu27jrETGJKUEZEdos5F6Y6ardJ8V/jqi8SzqXzn9BP
 FKm8lI1udIBYmQTgLS5Dmjr0exmKGNZ/MbSKkJAMQ/+ypRbtMHRGqfHLyTryHDBQHs2t
 RPGzuVXy1SCL2tdVq0yNi5zFUYPoqhNv3sYE4KJ/y2IKDkgmVUUL/ZCcebUvKLkEsuXa
 6crnffzhXVJw+JeNT1bpwS1kOfpUuesw1717VGHnqt2RjzKmmUcvq0b60Nd1Z+LIKexH
 NXaQ==
X-Gm-Message-State: AOJu0Yz/rBiWPjmJDUrRBKY5zDThP9LUO7DvaIzL0IZ5RV+8rNwRSB5y
 z0o+29yLm9on4stz9GS1lB95y1CURRrO2h7iOhPQFao5vFxk846qgWPki0JdMWw=
X-Gm-Gg: ASbGncsO2+krzjcrTEum/atfpg7DSsZZYwdh1EbYDf5UDGtgaH0YQKHeWo2ZEIm4Kgr
 7vivb61y5/pEIbyNcwKCji5AlJ08zdn7IPVKL3jVjTsUt7Rb6LesN7yeB3/TRF3Jl37y+f0wOsf
 09UbCVWJhZn+xQHV/AC7kLY5UO6TDNiItqkl9RvDTObHsF+PQX0ugbNvrbSzKFaRJkoKnKwsD12
 22PJIs8TA7gnz6ruG0VIHMSpXpkkMByaT2pReS3RiXIdwX0GWbDVudW0iNTI6EEj64G3gMcLOg5
 ldVeVEdtkFgDm9Kkr2lRsSksiORj/JcEMrDGzyF82+EQQ0YQeIulQ3xZYGhJFPUqcZJGMyu/XrU
 mj60YmOXXf610KsY4
X-Google-Smtp-Source: AGHT+IHEyCVMM4Jh0o/0PsfHj45puOnyiBSmUTvA8aklH/ByXBsqC1sO+foRfb2hXeOy1WFZLje8Qg==
X-Received: by 2002:a17:903:2406:b0:223:5525:6239 with SMTP id
 d9443c01a7336-22c3595bc5fmr39439375ad.38.1744814239312; 
 Wed, 16 Apr 2025 07:37:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fa5ce3sm14725675ad.134.2025.04.16.07.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:37:18 -0700 (PDT)
Date: Wed, 16 Apr 2025 07:37:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, joshwash@google.com, Chengwen Feng
 <fengchengwen@huawei.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Jie Hai <haijie1@huawei.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Gaetan Rivet
 <grive@u256.net>
Subject: Re: [PATCH] pci: define more standard register offsets
Message-ID: <20250416073716.0a4e3b4a@hermes.local>
In-Reply-To: <20250416061034.649607-1-david.marchand@redhat.com>
References: <20250416061034.649607-1-david.marchand@redhat.com>
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

On Wed, 16 Apr 2025 08:10:34 +0200
David Marchand <david.marchand@redhat.com> wrote:

> The PCI standard defines registers for:
> - subsystem id,
> - revision id,
> - status of the device,
> - vital product data,
> 
> Add them to rte_pci.h and use in existing drivers.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Makes sense and aligns with <linux/pci_regs.h>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
