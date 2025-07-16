Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F0DC83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:40:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F65D4013F;
	Wed, 16 Jul 2025 22:40:13 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 520B8400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:40:12 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7e32c5a174cso23569485a.1
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752698411;
 x=1753303211; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttiyzp8rutS6KLJu8qd6M7Jjmo07ANdnTDEZyFQMBwQ=;
 b=tZenZ+3iUcnQkxA3CO6T2Dx/O0fEMYwMs4l88N74t5HzGyzfzR0fejK7uHNzidFUrI
 7A+4PpF3nToSZKf+ZI/towgipcu54Xatt30sMHkc6FYR7/o9L6tk3gwrmKvJ2QWXGbcy
 08b31E+2Q2BJsolH2ClX5JRHWRE/UXlkc5vuO/KUq4bWJM7pGaxEJWROZosIYBTJTEL0
 Wr1Dc3qRD3LO1nwfgZUAnwG1zs/G/7J4EDqs7ruXL0KMZ5+57zDao+/xsNztJYUbIiAx
 1ltpi6U+u71ZzzP0dQKsEAluABTOEg9+mJmJ0R3DiNEPaTScNDKdjAlbJDBjRQy/z+Co
 MRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752698411; x=1753303211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttiyzp8rutS6KLJu8qd6M7Jjmo07ANdnTDEZyFQMBwQ=;
 b=Im6sxjYRUrtv+WIPwDSoLXHGCnsxEZSkYjb5OVwKt60yXKdJOM0uT/vkRPtL69ei8Z
 8l8OtrNE4/Y3Vu+PzAO/bYvuc1pJCsqYORiatxsv1NcrnlZIXtlwf9Kk5r+1pARH2swf
 y0hgLIwQyY9bj5+VUpyXK1luHaeyXBCLq3632uHJ8gq3aatEvEAcmdWIqqVRz2Kdi2hD
 3JJ0bb2PHCQG9lw2x0O89lwscM7SeAoKiramh+A2HAthZ/GPCt8UiBRjpfw6hC6MLZRZ
 4NQbhf62HMoBj9L0AjEOdqt+3vwVB+QTPjdwOpGEeAbGGuCAU8aihxy7RnbQ1l8Z5mRX
 O2ZQ==
X-Gm-Message-State: AOJu0Yzj3ERzHaDJfn98k4Z5xP3hQOEx+bw3DZW15l0TCpo1RB7/fMSb
 wjdeRp1bq1VhG+tFhb4tqHlzYMnBGRQomT/jMwJz0EnepkY+9B8ihIZmgKwUUmpSqoI=
X-Gm-Gg: ASbGnctIR9IMYjQ1qOJgDbW0iYeF/nWGcUM/K+Ihl3JBRZjY1Gim2zFj8UNuQUnSz43
 VNtm/uPIy8W0lI1fSorciQPzgJi/mHwrQRVhuVKAreitBnkMt8d11a8iVsbLkUzpgZ7r9yqPvwY
 SeR4Qnjv6MiYtr9xinK7QAZrtCehClMtw3pnDOjlJbIH+BYPf109DSIozuHGBaqIitJ6k+Dg+Qy
 73jsAhd96Ne7clKjq/wok/o3lWHVB3fL4l+29wG6si6WryRMwP67OUy9MTAAb0JhL9fEX3CFvE2
 1KkgI9z8vKZxbbWoIpwq92tjgztPFWG9BVqrqbXNiQ/n0zoGrmmiilVpN+0C+FAK/w5zCYsA1/S
 BMxUlZIBL2ZlP/eDz5lIq7JluYZcbmsi73hS5DSGHiQ0zVL/j/6pYjeSOp0D4Nn5//0E6ctcrIV
 Y=
X-Google-Smtp-Source: AGHT+IFgYNo0L/yOvcVM7SqlW8WuSCv3uwj9YopewmtFixX1dmyfpzMrnjYPvs9/4dNhU7ezdAPojg==
X-Received: by 2002:a05:620a:7088:b0:7e2:9c28:c310 with SMTP id
 af79cd13be357-7e34d8fa84cmr66288585a.21.1752698411512; 
 Wed, 16 Jul 2025 13:40:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e06760904esm578742085a.50.2025.07.16.13.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:40:11 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:40:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 02/14] net/sxe: add ethdev probe and remove
Message-ID: <20250716134008.04f06fce@hermes.local>
In-Reply-To: <20250716082930.83026-2-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-2-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:18 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
> index dad9ee44a0..34571522f7 100644
> --- a/drivers/net/sxe/meson.build
> +++ b/drivers/net/sxe/meson.build
> @@ -1,9 +1,22 @@
>  # SPDX-License-Identifier: BSD-3-Clause
> -# Copyright (C), 2020, Wuxi Stars Micro System Technologies Co., Ltd.
> +# Copyright (C), 2022, Linkdata Technology Co., Ltd.

I assume you got acquired, changing Copyright requires approval of
the original author.

> +cflags += ['-DSXE_DPDK']
> +cflags += ['-DSXE_HOST_DRIVER']

Please avoid #ifdef and cflags. The problem is that no one ever
tests the negative case. As Yoda said:
   "Do or do not, there is no try" 

> +
> +#subdir('base')
> +#objs = [base_objs]
