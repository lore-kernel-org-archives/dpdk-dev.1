Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FEBC7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 12:25:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AE9842E70;
	Thu, 19 Jun 2025 14:25:19 +0200 (CEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mails.dpdk.org (Postfix) with ESMTP id DBFBA4025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 14:25:16 +0200 (CEST)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-32a9e5b6395so6901241fa.0
 for <dev@dpdk.org>; Thu, 19 Jun 2025 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750335916; x=1750940716; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JDSqQqBcgmaMCE2jNG/eAqXgxohm/UY6651h+N1QIpI=;
 b=ckobxPyTDM82wCOGLYCPc6jaIwh+ZdE1xqwg2Lsi+/i8NFneTdHa7+Ka5WDOL6U0O4
 n0J5Va1Qad+xaR88CzyyM557yEN6EIOzY2ZDEjbXsmsuRRDc0pc9E5Ojdown8/tGLhEN
 LmvBTGhFpTKQM6IZFTMmFEjp88TOLHvBGf8LPFYMAU8kjp3glODE7hogxsStwwoPdTba
 awSL8LzjAaEfyR5UcmZh6ql8BO5qsHovCoKpvcd2npiC0ZpiqdayktvdDr42VPg1xhU9
 RegBwUTk0b2wruf0iRyv9zaJYKBIS0GeMoG074RssjIe4fBGiDLkIRJ2qg0gdDGoMsvC
 jwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750335916; x=1750940716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDSqQqBcgmaMCE2jNG/eAqXgxohm/UY6651h+N1QIpI=;
 b=M3NKoPYz8pbJWr7p6k89L///fqmc39996VvK93Clpdbswuz+YlOX2Wle2XV0+TG/5i
 AtXfvcyOWby4qJD6ECK8nIMQbvldW9bu0t0ChsS6VdQgUR6qC9N3J3sEby2l36BsosnT
 7BzfK0TyX/h9PhPvBVV2XrXyvlINnsdnAyoEv+zC/+Aad89xDaWIstP8i6qDAvsxR6b2
 vQJseMv7qr/6eOM/jdfpgAXMOb0DXhv9lkA/lt/5AS6xVCXtxUjwD3tzmo1zRToBXIW8
 Z2j281lZ69yMQBuGFOLgnj6rppOCLMzXA57RQeD/rOB5Ib7IDRQB3yj2nr51ntSABBa1
 wfAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/MNhjt1JKnjnTct76Dwz2BNGKVbQxv93lGB6DfTQp2EL80YjUcwfqLXQbgAiNLK0jLZg=@dpdk.org
X-Gm-Message-State: AOJu0YyNtbS1KErDFfGbTQKbDH/PxHHqpCLGQNJkdqCEV/ZS9NfQ34fR
 wHkVEHf3vzCu+Pe9VIu3G3hEQxiYiqzwVE/774nxCZvig2x5893eTP5ofEIqH5ctV1irEs/QWmW
 /QEU8VgSbHjHbiRupUnF51YsZ+Iz9MBzBNKRGIT1IZQ==
X-Gm-Gg: ASbGncsyJkMHGjKI0+tUhW5nRz4v1xrV2nR2UVjqkXHsyNvL/nJ7U1P1Dwr7NnmlyG0
 3TBr9X04/t9H/dsnm8vGSuN3j8/yOuuLjdAQofUtB0SXsvDku5wxZBb5R6NM8+LLeoWEp3uDuUN
 sfBPEYgrmcdZRp1xCRnl3WaYvsj9FynLZ/df5fY+z42uJU7FmV
X-Google-Smtp-Source: AGHT+IGxm7QyU0FLddHT5L7ffwNSY2+oB5Vo0AKkOfTLmuH0ajOeTZ82awA2afNrFou69duJOnTSVdAEvOMy5bTj5Rg=
X-Received: by 2002:a2e:a547:0:b0:32b:3ca0:dbe3 with SMTP id
 38308e7fff4ca-32b4a2cec5amr52173111fa.15.1750335916090; Thu, 19 Jun 2025
 05:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250616025027.209883-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484CC09006031419CD1BBCFD873A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484CC09006031419CD1BBCFD873A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 19 Jun 2025 20:25:04 +0800
X-Gm-Features: AX0GCFt4kIDfY90UBOndOEMFKpbaUZk8kIePsfrJwfUNm1Aj1FNrhjKlPULEoNc
Message-ID: <CABQgh9ES74YHT6r4PHPnvVe5P691i-F7LLDzgO_1G+TWktjn8Q@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v2 0/2] uadk: realize async mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 18 Jun 2025 at 05:13, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > Realize async mode to replace sync mode for better performance
> >
> > v2:
> > Add version check, requires uadk >= 2.9
>
> This version DO NOT exist as of now.

Sorry, Akhil

The tag 2.9 was just released today
And will send v3 with different table names to solve the conflict as well.

Thanks
