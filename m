Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5DCCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 17:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAE7F4067B;
	Wed, 15 Oct 2025 19:29:52 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 760AE40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 19:29:51 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7930132f59aso9162624b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760549390;
 x=1761154190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWxsX1VSKGlY9AXKMK6lOBZ3vawtESYkHDy8BdjV3SY=;
 b=2UPQDq2WgD+BtLCGudNGJEg6AywhXl001ZKA9JprQXkWCUL6ZO3/Uba+edaTHHq7Pi
 NouH7DsUsh009HbUjZVcyFmTL4nwxwsQ3ed78mjCRs5MX7Ts+g+180JXrZCIF9H4fmC4
 nYuuKzcknaCc/pwAj62eJ5Nvuii8onpPnMIXUnVkK5dxBF8j6YOialywyOX9xnZX42w/
 f4vHTmbeklWwc3QY7IiDQq1SN87mJAjxmU10yPj58SEOQ58p5ME+P8A/WuI2CUOpVuZ1
 SM1zQry7EHI8UaatK8GN8aDd/wr2Dal4vNEcT4WLbKj6A29xlbDno5vGEKugdFfwOdbV
 0v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760549390; x=1761154190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWxsX1VSKGlY9AXKMK6lOBZ3vawtESYkHDy8BdjV3SY=;
 b=OoTd48B+ab+aatsyRS0JVY+r/D8BcaXPWAfHRINIeJ6HnhsHj1VgvwjAKH2xWULK/v
 UpSZZayKqMSExI1ip57XblofJjumDd/+K2zOyF/ywIKJM2w/NV/mjdwLTZ9Jj2kDqcgo
 xLkpLfHumnzdUNtIghhD0OnQ+VzT/vgqg2bswJps6STt+RNgpJd66K8neHzyZTdefBSJ
 R5kWIvkK6XLq9yzSvVewDnT9KsKlwihuxRhKrCAGdLvfh+947KgA25yRAtbCRDAbmHBu
 S1Yv/yDWDbpf5ececiDiyLyQT2hKYNQROUc77GcCNyAWYKItfnitCfDvBPb1RZKTMC76
 784w==
X-Gm-Message-State: AOJu0YyzrvFTbZrxcFOSGilPqvRPHQVVKN6jMWq3yLBx6WXQXLqT774f
 pD9KZpZzSkw/OjA17hW988DtGcDEW7T5W9cx89AdbpTGDynLKr1Dw/UfoN7xWLWWmsjWK0pRBlS
 hGI0aSvs=
X-Gm-Gg: ASbGncsQmJdOVQW8rMUTWxMESItQ9/It0kUu78NuelS5n53Gu4+zoO7HtTI6Vrni4my
 txyJw5u268ucO4DEoajpsUjtrbmoClTaq4eWNDDRLIz4s0EXslLP/0kdrwu+VKZRcOfSNGeT5DI
 vWJPf+sPzMH3cOlhCbAWs761FPg0qNLTM2cowv/eurTeXEksDErOlWihEDiWv23xcfZ/8iJFWtF
 CiYP996z5all/LL/tso0XZsHDNneElwaeFGnE8uUgNhP/U/WHGyDGoSRZT8Hm79ghRkB8Gvv2kV
 W2LU+499/6FiIfCHd8qd5zzIyt+0NMzrrlwHHXMIEazy0KOl/vIw4NEOhnwsyaMhPqwSGPxU3j3
 Wb7mHESqKXmWY6agcTMcHVVY2Tm/Ts0EoUYNmOVQBPvMqEFIwUlB94MDYL0PpcCIVoytKPR7Oo+
 /enFpHO2fOgK2ARjTPARMYzInq3ZlW
X-Google-Smtp-Source: AGHT+IEMbTMfCDsQ8vQ33yO65b9DWeu1fvI3A4ruDG20juBsZa97+1A75UmmcRMvzJp6RRhyYIQ/Jg==
X-Received: by 2002:a05:6a20:9154:b0:246:3a6:3e5e with SMTP id
 adf61e73a8af0-32da84edd28mr42171643637.54.1760549390401; 
 Wed, 15 Oct 2025 10:29:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a22b9c315sm183763a12.29.2025.10.15.10.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 10:29:50 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:29:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eimear Morrissey <eimear.morrissey@huawei.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] lib/net: Add ICMP support to rte_net_get_ptype()
Message-ID: <20251015102947.4614244f@hermes.local>
In-Reply-To: <20251009152740.10437-1-eimear.morrissey@huawei.com>
References: <20251009152740.10437-1-eimear.morrissey@huawei.com>
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

On Thu, 9 Oct 2025 16:27:40 +0100
Eimear Morrissey <eimear.morrissey@huawei.com> wrote:

> Set RTE_PTYPE_L4_ICMP for ICMP packets.
> 
> Signed-off-by: Eimear Morrissey <eimear.morrissey@huawei.com>

Would be good to do ICMP6 as well.
