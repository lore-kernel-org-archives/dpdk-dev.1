Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD78BC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 17:22:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82E3F402BB;
	Fri, 18 Apr 2025 19:22:34 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id D66C6402A1
 for <dev@dpdk.org>; Fri, 18 Apr 2025 19:22:33 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-306b78ae2d1so1680777a91.3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744996953;
 x=1745601753; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4CqHrCKOGvohwOHtkLGAsMMuNjadmDyAV6tYET8Qrg=;
 b=E7jLMhn1j3IczRN+U5kWKlDiSTdYBl5O+k0DWmktI7pMvuRHuTgglkj6Fq4l195I0g
 hLqbMC013KepJea21LbVKzO4hLx40whCY2sPwS1qNLB/96lvt4nURmxwYxE1PWp4EIAy
 AB10Lel9Neo0cvqyqNIZCUJP3mmypgVroHYOxhxMyNWqmo0RAnlGggMNmr2HLYc0TePm
 S/QKegEmiXDEqGOPf75xSoS0MmFUeJdAPHKNvsI09b27rYO+M0BX9S6FjpgX4CjlG9ES
 U+aLlDB9uN6TmXXXL4fk2hiYKB+rVyMgL10j9KZZ8301Ar7zNaX4u1Vzvr/AojN/jiKm
 ZKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996953; x=1745601753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4CqHrCKOGvohwOHtkLGAsMMuNjadmDyAV6tYET8Qrg=;
 b=YeQhXTPJhIfilTScV1MTI4Fm6LC6HgvXJkrO4MoKQXq5WlK1l7hmtJakf6g0vTa0qz
 CfuBjiI3TpQEdgDWNFm/h2BVuotyD/4kbSnJKXr/pJShyfqWXJeFREU0CRyMrDYV7ive
 PUkhlXYbfpoP7zq7awGgFQajjhYJpT82NCW1+Y2YpyEKdUiRtnT9VOiMFw9wWieYMRXK
 Le2cshTcCYhnhxHcv8qZF3MdvmTD4VLBrq8L4+F0bw+w6c8XUoFajOsRisd5+gAbtFiv
 ShZvr5rJQgrI4ZTdCOYEJdqRoVymFG9YYwTptzVGSIxO4AxfGQ1lviPHErmO/b+f5qPR
 9tTg==
X-Gm-Message-State: AOJu0Yw5G4eSAx4AMaMmFiuhSgdGQVhXDC5YF0yEyfQF1sddTsY3nS0i
 cRB7bgSRZUiZNM9WhLYQqKK96ko1BOX+LEODdmfRkUUtjA8/EjrYs9v/MjFdofI=
X-Gm-Gg: ASbGnctScYG/WrYf0xWpigZqsIbLx8AHiNLPKfwiX4q1mCsaUKbLu/x7p0PzMjUQGjz
 ET5tuUYUCUIYhgELi6qsdRy7LFqjnoG6qEs1bMdUc+c4gp1T9jk1kC26957M+R2lycYQVHOn48G
 MBt6JLTS/z810iqXe9ekTxRiEaDQ7Yw/xkYIR51lfe8EQgFEq2L71nxKhYF/ewHdyiFM5caijzc
 Zw1lyvr6K+SlIaajccuOKe8UZpS6NkwpJ8xmek75PXcvJEqGONG271gXY0ZnzVkMvkWnVlU/uHi
 dw1S9pRcRtDshVIOKBWYH5aKtW3xF5f6iMG3jUUFIzl1FjoH6xQbUv6sB4p58ralaxzjYFkvnR8
 8MXMQnYPtKvA/4GEJtjSKFy59FmI=
X-Google-Smtp-Source: AGHT+IGfr4RLJeZ2J5JUPqnvRVSgp5YlPXqghBTkxA4j03Ali/5EGbOYSd1BCOZLKaxJx2a2DLYNLg==
X-Received: by 2002:a17:90a:c2d0:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-3087bb3c7f9mr5182781a91.1.1744996952794; 
 Fri, 18 Apr 2025 10:22:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dddd533sm1507720a91.0.2025.04.18.10.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 10:22:32 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:22:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [RFC 18/18] drivers/net: add hinic3 PMD build and doc files
Message-ID: <20250418102230.1e4132a1@hermes.local>
In-Reply-To: <20250418090621.9638-19-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-19-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:06:04 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +cflags += [
> +    '-DHW_CONVERT_ENDIAN',
> +    '-D__HINIC_HUAWEI_SECUREC__',
> +    '-fPIC',
> +    '-fstack-protector-strong',
> +]

What is this?
Should not enable PIC or stack-protector at the driver level.
I assume the other stuff is huawei specific compiler flags.

> +if arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
> +    cflags += ['-D__ARM64_NEON__']
> +else
> +    cflags += ['-D__X86_64_SSE__']
> +endif


This should already be handled in the existing DPDK meson stuff.
Doing it at a per-driver level seems wrong.
