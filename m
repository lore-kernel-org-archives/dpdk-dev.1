Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1527EC021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 20:11:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AA2342792;
	Fri, 21 Feb 2025 21:11:18 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 70652410E8
 for <dev@dpdk.org>; Fri, 21 Feb 2025 21:11:17 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22104c4de96so45401455ad.3
 for <dev@dpdk.org>; Fri, 21 Feb 2025 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740168676;
 x=1740773476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlCkzQIMneRNf1wz916WOKUgA2TMipNE30tOA7buMtQ=;
 b=ox2Q6wiNpibLzJ/r3XaK/+XOs30D9C8BDJ/6X3lzcLW4F6es0ml0hRoep67yBqSvWe
 o160AKs0+GkA2pSGVVlTUfIfx8X7I/j0C3AWISD83v9MCDkg9A25xs59Kgs0x1aaouZo
 FJ5P/JZB2EnLfgXR3WikGt00NcvrEec4Kpsm2eElITxYTy43m00ErRAExH4QFaJb0I9X
 eTe3ivv4G4CKJuS0pFyq//6MiOUbscODzOC853owrhjLA0Nqd4zCL3671ozUNro5GEmH
 /o1zjmucby9pC8zNbIH8UbHMqfe4k3+Yf8taXgfLs8AgtZvdv7fn11993CgyOLvAZki+
 rSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740168676; x=1740773476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlCkzQIMneRNf1wz916WOKUgA2TMipNE30tOA7buMtQ=;
 b=D7T6P/J6bIk7KpzCr6kJsxxEuxMqBXi0jOCIG3FJ9IQsybByD+cG6yF5xTfnutKud1
 Bzn4qvSUg4u04UMe87pygNdKoB0PCuUFXtM0in9Nlf90sSVoi/WSyUNvtdcnmlo7VFB1
 YAyIRqiOvQsUcE5DOoz/8PycSVLZzYt/ZDIfVKC4E7jfcuVEwq86pne3SFuQ0A6bNx9w
 bHI0hokAS7t4A8BtkI3+3hGC89ALmNjnoq5UsVMMSbA7CC9Sa6qqQEK4AeI30B0R8TtM
 JWyga7tR4pZOlftrvFBKqz1QqX7kMgeQ0F2USqK84je62glyz9Tr5T1uYQEQ+Y9MtRnu
 9yJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaZhvcOy85+v0IoxwuyY69GGrrRMwKXx18ba/tSxLbnOdOJX4we8snPtzf1xBeD20zNjw=@dpdk.org
X-Gm-Message-State: AOJu0YyxAUBmQXLG1tqMG2XTJj4et4AClpzoXjFEVrj+xojJRRm3NKKd
 1/WAex2u3F2J/mBEvWPyc6swRGR1Bj2Oh06RsD0yvcr5ZUIMUgGTeb80BxiLZWM=
X-Gm-Gg: ASbGncuJgkWw+ZXC4pThksdShQhwNYTYEeRwG3AfgHFTIKCWRR6MfBatbAKO5AqkOIy
 Z5StAM0Y8pTRiRyqNsKA6Wl4J/XOtByYYhxQPHOw5S84fcf1MqLxXF5OCRfCwTi5aPcG4wZYUHW
 IuzGwXr+Y6ND2sZDPdnsMs9PWCaivwzFhfWsqZQQyLtmV0SoTYdHGsLYI6YHaIbZsZkDEjRzsss
 9pNDE/93OoU4Vo4ss9ajXuK1UyDf6Wsg0ZmjwRBhGOehPnAWW5+asS5F22WZE9Jxfcwpd7oJAgm
 U0evGKFrDysZ3I9y194EJ8z3DJY0ZpVQ2L3KvhntOAubAi6w6E5Q9sMBetkh6GtvR9CjFc6pMJ8
 LqNo=
X-Google-Smtp-Source: AGHT+IHgvchXqWrBsx9DNVqnK69mOx2j8n5alSSGtAAuSmRCLaMf8fLXwhYFkWG74qO0UQ/dX3zE+w==
X-Received: by 2002:a05:6a21:6e91:b0:1ee:d0f4:d14c with SMTP id
 adf61e73a8af0-1eef3c894e4mr9164532637.15.1740168676567; 
 Fri, 21 Feb 2025 12:11:16 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324273e388sm15773609b3a.89.2025.02.21.12.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:11:16 -0800 (PST)
Date: Fri, 21 Feb 2025 12:11:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v3] net/mana: use mana_local_data for tracking usage
 data for primary process
Message-ID: <20250221121114.41e3e8d8@hermes.local>
In-Reply-To: <1740094322-10919-1-git-send-email-longli@linuxonhyperv.com>
References: <1740094322-10919-1-git-send-email-longli@linuxonhyperv.com>
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

On Thu, 20 Feb 2025 15:32:02 -0800
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> The driver uses mana_shared_data for tracking usage count for primary
> process. This is not correct as the mana_shared_data is allocated
> by the primary and is meant to track usage of secondary process by the
> primary process. And it creates a race condition when the device is
> removed because the counter is no longer available if this shared
> memory is freed.
> 
> Move the usage count tracking to mana_local_data and fix the race
> condition in mana_pci_remove().
> 
> Fixes: 517ed6e2d590 ("net/mana: add basic driver with build environment")
> Signed-off-by: Long Li <longli@microsoft.com>

Ok, mind if I break the long lines when merging?
