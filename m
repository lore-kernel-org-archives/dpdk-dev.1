Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF9CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 20:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6214C40A6D;
	Wed, 24 Sep 2025 22:32:10 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 982AC4067E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:32:09 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-78f58f4230cso1551796d6.1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758745929;
 x=1759350729; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrF8fq9v26ppfjEA4pdtN7PHwlO1bTWOzODy+3UNEX8=;
 b=RbjpkbXqexMCrxGJlzBI8L/CfY0jDFf4ISrH0mmKg2Vs5dokyoVWZcbOt/P6Xif54d
 akRhzZ1k3qcZMGR+SsS4mbmCPtVD+PxMk4Cx8NhVjVMpU96O55O3XtyUaZoeczVIjh1i
 5HjBpEsBM5cYwOT1gz0EPoWYAhSHN9pAAYAQrQPZ2MBxpe6uhp0gM7RstZAUxLjocFX0
 eGqFvkfXyNJJdDJMx4dPx0GzGLfdbg+P+M2Yun7gfO/BhXwVaeQRf/vHGzZojI1KJnec
 VVnvBG7Mfrly2HB6wg2EQA280jKQ05o4U7bZdOelZdf+W6w1foD5dUY1u47jEOFoGtXb
 397Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758745929; x=1759350729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrF8fq9v26ppfjEA4pdtN7PHwlO1bTWOzODy+3UNEX8=;
 b=iK1KebFwNHJ0ERSDqWpOHfWrLgIJPb5PDvCShpFc3dJO0ndj9a1kUc9lD1+awk7e4G
 EZnuZNigBBLXmzy/64s7obypRTTSAI5/TXduLZwxlq42aiIFjwcw99DbJ4t6HbXrR8u2
 qxeIpXWy61MXoM/1vc3E3141bVftT2pIeG34qJyzdelhuIw4f4u0TtZqXtSn51jZnKO8
 phLPVVO001wmOUMDHVtfdCHFl0Dwtk5TN8SVrwTlYCVJ1wq2FUsWJkL5/L+B1Fnm2uEy
 l3gtPvTRYGe9ydvch7RmcnA/RbPX3ApKM+p02DKFbtNX5RQExKfVsbtG+1KtVfXUoXct
 85/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSrGeCpMa+afGYY0sXCOaUcqKGAaQbsVAznRa5CJ9XUb/Lvfd/y5+d4LYBxzAxcO0LKX0=@dpdk.org
X-Gm-Message-State: AOJu0Yw1I6JKwbQJ4K/p4vy3KMI0hEcEPG6XUrs925ZTGNg8GrsR+3xp
 lnFYrHpANsVmpjbVydxbUpKOQrP+gcbEo2zUL8yeZysDIsRVuhF4vjdmCubq7OUIKBh+uuKGW10
 GKM1y
X-Gm-Gg: ASbGncsFFggdHOMj6Iq4pqkdZK7e7tg5+vYYfqq0sGKDDYnmf2Ssxl6c/cHyjP63fbR
 XgrvElvefiNetIkZQ3zpOVcTiASIyvMvkweh809ukgHsgOmH8tTx3lvOqPI8/yPlCztuxdHi0Rk
 ZsUsMeOmpR4oxJ36opy1GaC4+Ubq2XGNz5pa2Usdwz820Y3sdBknlarz6Emp1AWJLKbEwJP+7vz
 hE13YD4/56JVHBY5hLp0ozsRQUwft1mYdhbqoj8QBZDfk4R/1xl49my8c98vsWQKdjmBRrsg1aQ
 bibeLcuI3gT8FXCbjTZQMHBh93RPMdBufbJWONADzS9eB9KlrRWAA/yfnzBkKDgX4QV+IibbEfx
 73KVsor/eBYsSTw1aaW+kmWFg/qJXebop4HgIw1H5pqgxFINGnPAfniUaxRPLE4wiQl6nm46Zvg
 M=
X-Google-Smtp-Source: AGHT+IFcgTJv9ftJjioorHrH/3yKSANv57AktfKGjlP5nYy/ZL+uOWcnKNUPtJBnstrd1VXctIGbLA==
X-Received: by 2002:ad4:5f0a:0:b0:766:3902:b9ca with SMTP id
 6a1803df08f44-7fc394637e6mr22071726d6.25.1758745928840; 
 Wed, 24 Sep 2025 13:32:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8013e5d5f8esm672046d6.27.2025.09.24.13.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 13:32:08 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:28:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: support multiple PF process flow table
Message-ID: <20250924132833.2751a8ba@hermes.local>
In-Reply-To: <20250924082331.39962-1-zhang.tianhao2@zte.com.cn>
References: <20250924082331.39962-1-zhang.tianhao2@zte.com.cn>
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

On Wed, 24 Sep 2025 16:23:31 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> diff --git a/drivers/net/zxdh/meson.build b/drivers/net/zxdh/meson.build
> index 7554d4dc60..0213ccb2fa 100644
> --- a/drivers/net/zxdh/meson.build
> +++ b/drivers/net/zxdh/meson.build
> @@ -1,15 +1,9 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2024 ZTE Corporation
>  
> -if not is_linux
> +if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
>      build = false
> -    reason = 'only supported on Linux'
> -    subdir_done()
> -endif
> -
> -if arch_subdir != 'x86' and arch_subdir != 'arm' or not dpdk_conf.get('RTE_ARCH_64')
> -    build = false
> -    reason = 'only supported on x86_64 and aarch64'
> +    reason = 'only supported on 64-bit Linux'
>      subdir_done()
>  endif
>  

This seems unrelated to the PF process flow table.
Should be split into a separate patch
