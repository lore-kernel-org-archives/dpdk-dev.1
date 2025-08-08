Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF8C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA2C3402AB;
	Fri,  8 Aug 2025 18:12:29 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 1F0AF4028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:12:28 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3b788feab29so1398994f8f.2
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754669548;
 x=1755274348; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTi4thcmayqveNmNZ6C04Ik5T9ty5+4UFrSmkv0emHw=;
 b=J+PqzyrZG3oMqgJsqajpLgNB3GVlVj9Yh13M+AszbCtv0bHXhVhpZwPaP1BETDMd15
 J8AZgyP0RgR6MXHWV0HYemcjqLgqiOZ70vZxcBppoS1MZa1/mao6H3BceRgHbkTIozdL
 4Eizv3K6GNx1noJ3ssE/Iv51RzpdUJBLgBHuLLlykPIZKAUQZo9TLBfbdGS6zGvrzM/x
 fgZ4NrIoWVbaH1jgS+6JVSMyfOnpV+HM8Au2jOFzj7l9Vp0dhxFhPqeF3BRliJgpIvVl
 zBrlwGeAO5lfWZRmgNhtx/bUc6/rWWS2XWev3QIzQ0znwbRdXb3ajtp6LHvhCfh/D50F
 Xt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754669548; x=1755274348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTi4thcmayqveNmNZ6C04Ik5T9ty5+4UFrSmkv0emHw=;
 b=Xdz4S5VriB0ik2eZ70utuR9jZUr5Tj+VLrYhZ0mS2mWMAiueeQ9mgtkHMknQVxwCfD
 inloNGrXzpzVmjvQrhiup0kHMd8kHSVCFeIQ+mNv7ewQTJdaiJZDOJOl+hpJSsvzAp0L
 7swnvKbzRII6B/YrjWb24ofxVp9CV7evEp+DDLIENhg7KA2ZpM9zZrUuMH2E868dxqOe
 BSrAjZFLM7dw0HKlZdMmFOidbVYS5OP/oK5ogE53oDSeClqzqX122gfcYDl11sI2GTbX
 KeqjuNp9LNIo9xk/YDEbdLQRG8L7mWmCVYpuUvq5U1S1msm5J8q7BDVwxKWotiEJJEMg
 DiuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjbhNP2hOCvrGsboa/KCTOP0jQnT+ESPor7xGuwV4FAm4GfHM40DlWhyB6s2+q4IEAyXA=@dpdk.org
X-Gm-Message-State: AOJu0Ywp6QXRncgUmk2oL6HSXdaC5MLppDWOc/JTd+gCXUf3BVrxPiEa
 Fu39k3smLcSRllJ75+iRe9NAYLoGXwCb7t64LJygq0k4G3Po6hqpvZ5rCvL0scd2zTA=
X-Gm-Gg: ASbGncsTHxC0xuw4LDiz/ETMrONbnKpEG0kZQDzSyz0HEIXtS+j8CsYmkSmtd6kZb4Z
 sgLR9EXC0Bp0lQ35BWjVA2PaycgqHj0NqeQsovfvt0SF8zSPjKFbkJJ56Ur/UEFb2qqRR1YYlq+
 CbNraCtAzkdlTP/xsJXPhu2oLmwMGErneYA283YO6M1mxP+/yHUyxeSttyuPVnn1XZHZlPx2SpI
 Jrf5WcZaC3e9j8x4xJZXx+qW/8W89BvY0nTl7oj4NN8mXWitUZ3/E8vF3myUsNJ4IIjTxd1+dnI
 RYgdAzb6KPJlUfA9LqFE95E8vMO4turOig3UK4e2Isf6NASdbc9phfZlrNIpNXga18wcln/qZ5y
 RkJEZ98spq4qqNGKHUVeNeGLybHIEmNLvFOKBOLz74HrWYgjjeBUKR3C26sgN489vnJGTaS0V+3
 4=
X-Google-Smtp-Source: AGHT+IHyOvpHJ4lhbV1LTMkSP2JoSmZc5G77/DOdiSL+COuRC2FWBZxSbMOp42IwTWmwbtrbqpxrSA==
X-Received: by 2002:a05:6000:402b:b0:3b7:8481:e365 with SMTP id
 ffacd0b85a97d-3b90093f7bemr3105087f8f.10.1754669547631; 
 Fri, 08 Aug 2025 09:12:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c45346asm30868619f8f.39.2025.08.08.09.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:12:27 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:12:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: yang.yonggang@zte.com.cn, dev@dpdk.org, Bingbin Chen
 <chen.bingbin@zte.com.cn>
Subject: Re: [PATCH v4 2/2] net/zxdh: add support flow director ops
Message-ID: <20250808091222.1cc721a8@hermes.local>
In-Reply-To: <20250808071048.1906724-3-wang.junlong1@zte.com.cn>
References: <20250702073453.113779-1-chen.bingbin@zte.com.cn>
 <20250808071048.1906724-1-wang.junlong1@zte.com.cn>
 <20250808071048.1906724-3-wang.junlong1@zte.com.cn>
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

On Fri,  8 Aug 2025 15:10:37 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> From: Bingbin Chen <chen.bingbin@zte.com.cn>
> 
> Provide support for ETH, VLAN, IPv4/IPv6, TCP/UDP, VXLAN,
> and mask matching, supporting multiple actions
> include drop/count/mark/queue/rss,and vxlan decap/encap.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>
> ---
>  doc/guides/nics/features/zxdh.ini  |   16 +
>  doc/guides/nics/zxdh.rst           |    1 +
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.h     |    1 +
>  drivers/net/zxdh/zxdh_ethdev.c     |   26 +
>  drivers/net/zxdh/zxdh_ethdev.h     |   12 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |    2 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |    1 +
>  drivers/net/zxdh/zxdh_flow.c       | 2000 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_flow.h       |  237 ++++
>  drivers/net/zxdh/zxdh_msg.c        |  264 +++-
>  drivers/net/zxdh/zxdh_msg.h        |   31 +-
>  drivers/net/zxdh/zxdh_tables.h     |   10 +-
>  13 files changed, 2529 insertions(+), 73 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_flow.c
>  create mode 100644 drivers/net/zxdh/zxdh_flow.h

Missing include of stdlib.h

==== 20 line log output for CentOS Stream 10 (dpdk_meson_compile): ====
../drivers/net/zxdh/zxdh_flow.c:664:25: error: implicit declaration of function 'free' [-Wimplicit-function-declaration]
664 |                         free(result);
|                         ^~~~
../drivers/net/zxdh/zxdh_flow.c:664:25: note: include '<stdlib.h>' or provide a declaration of 'free'
../drivers/net/zxdh/zxdh_flow.c:664:25: error: incompatible implicit declaration of built-in function 'free' [-Werror=builtin-declaration-mismatch]
../drivers/net/zxdh/zxdh_flow.c:664:25: note: include '<stdlib.h>' or provide a declaration of 'free'
../drivers/net/zxdh/zxdh_flow.c:669:33: error: incompatible implicit declaration of built-in function 'calloc' [-Werror=builtin-declaration-mismatch]
669 |                         entry = calloc(1, sizeof(struct rte_flow));
|                                 ^~~~~~
../drivers/net/zxdh/zxdh_flow.c:669:33: note: include '<stdlib.h>' or provide a declaration of 'calloc'
../drivers/net/zxdh/zxdh_flow.c:677:25: error: incompatible implicit declaration of built-in function 'free' [-Werror=builtin-declaration-mismatch]
677 |                         free(entry_flow);
|                         ^~~~
../drivers/net/zxdh/zxdh_flow.c:677:25: note: include '<stdlib.h>' or provide a declaration of 'free'
../drivers/net/zxdh/zxdh_flow.c:685:9: error: incompatible implicit declaration of built-in function 'free' [-Werror=builtin-declaration-mismatch]
685 |         free(result);
|         ^~~~
../drivers/net/zxdh/zxdh_flow.c:685:9: note: include '<stdlib.h>' or provide a declaration of 'free'
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.
