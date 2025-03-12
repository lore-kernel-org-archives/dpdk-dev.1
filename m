Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA28C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 16:22:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B5940B9D;
	Wed, 12 Mar 2025 17:22:19 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 020ED40663
 for <dev@dpdk.org>; Wed, 12 Mar 2025 17:22:18 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-223fd89d036so799815ad.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741796538;
 x=1742401338; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCarUWHj6DhxPjdIYs/8XgRV1Ob/5Y+K5uv3D5imDMs=;
 b=3FxwPlLfYRz7N95VH/VxTBgwgLxFrZBfoIATTdBUZCX7JRB5R2vWVHcrjrJK9ZzRla
 YOkm6SubFA2BL4V4+3AZWYB2pi4ND1KmkTVpY6vZ+npO+GezmNMK0Rsa/eGtFNRcNZPV
 bSORjVeas+il4CR9LjgFq4MsGhYVWUQKOGvZWx0baF5stCB82+DbUBILIkw/QIO2bqca
 k/Cm4Fai33/HbnA/JCQcmVetESVUIbcU7Sc2PyUGrIq70adPYqEUbu5m6CQNTcp+rWYG
 gVu3r8FQTtE4hgRGKGGIyM4GdODVct/T2XIB4PS7xw3vEno2b4DngMYjQTHRXzAWaBLN
 /XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796538; x=1742401338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCarUWHj6DhxPjdIYs/8XgRV1Ob/5Y+K5uv3D5imDMs=;
 b=hEQuztUGtxXjNc9Hsj1AoRk+z2yYJ2ABRb4Oyt9di4HzxcSu4DDOp5r9Z7oiMdL8ti
 1YZLrg/EyZK5NyP25tUcljTYINjm/emKdmadoM7VoXrfvLLnWaz+Vcvt4RWAJZSefhWv
 QMK8FrKs6cPU8/sxQKKC2fXSSI3i6fGYasQbB1vgwGfdyDnxoFhxfGJZgAYYNCJLBOub
 JoqexVqqj3w8/myAsNm99fkt0eKQ5d5HCaxWt2WjfaIDM0XoqJ6AoyJURV97NVHscKxK
 Lf6mIvejK9lB5kmi9/7tLJMSFX/ovGq/HyhnbO66YZNuyZj4N/6baTlVMq7o8EvYLVU9
 Ei6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoQ4kIp7fwmExx0WKFVPXDKwzhaaKV6HTnv2XN4hRhR5KMwTWdulH5QRMCdSdpzMQfFWk=@dpdk.org
X-Gm-Message-State: AOJu0YwEBREi/nXYnydocAKqOLd6QaHL2sU3cJ2JCPuggspsTTndg476
 1fL4UyweA+vjWKadsL+c5fHmCC0XfnzPySry6qv2+NiXteWeYrGBQp8ciNOQl4c=
X-Gm-Gg: ASbGncuYRubE7pEodxXLb/ife4ksBZyCYfe50G+ZflinfFkuNXLd22vBYkyp0NuZWQl
 GqycPPOgf6Ly3PvSbA27GgJWjimNbqAgR2OxxDsDgK6p3wiWj0QtjSkYZXnMHaKSEoUahjGALnO
 eu+lOlG9VWMmZdGGO1e0nZ8SmOeEyI+dfvx/70U9xiBqgt4/vZrGQnKpcu6nmicE6DxjDBRI6aZ
 wgWvPubIfIqeLHuYvTcnSlycunn3uaTLzNE//nYUWaO31G1FOudN/bKKr5N6x3HCBd/p5lDPukd
 ClAnNDZPqd3BEbybyh85eqMl6D9CcCsLihtGO9ZmEg8YOagUOrrA/l/iSUtUiFjKWEmjjReE1f0
 OKYluDEryeeCLeCtEBLq+cYNMH4EFM0Uo
X-Google-Smtp-Source: AGHT+IFUsDuRb0nc6GdsfMtp65BjK6UuNE3/5pU5heGWjw3Rb6SxxwBu9mr/rXeC0jJNJ2OiYCM8CQ==
X-Received: by 2002:aa7:88cd:0:b0:736:621d:fd32 with SMTP id
 d2e1a72fcca58-736aaae44efmr29438616b3a.22.1741796538047; 
 Wed, 12 Mar 2025 09:22:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736be7845c8sm9244598b3a.109.2025.03.12.09.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 09:22:17 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:22:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] eal/linux: enhance ASLR verification
Message-ID: <20250312092216.2c3ddb6f@hermes.local>
In-Reply-To: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
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

On Fri, 28 Feb 2025 17:44:04 +0800
Yang Ming <ming.1.yang@nokia-sbell.com> wrote:

> @@ -26,7 +27,6 @@
>  #include <numa.h>
>  #include <numaif.h>
>  #endif
> -
>  #include <rte_errno.h>
>  #include <rte_log.h>
>  #include <rte_memory.h>

Best to keep blank line there
