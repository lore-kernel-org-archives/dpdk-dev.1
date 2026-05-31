Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D17CD6E57
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 May 2026 22:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0159640431;
	Mon,  1 Jun 2026 00:34:20 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 9926440430
 for <dev@dpdk.org>; Mon,  1 Jun 2026 00:34:18 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-137d457acd4so1051371c88.0
 for <dev@dpdk.org>; Sun, 31 May 2026 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780266858;
 x=1780871658; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdIK/gvHilJ2zjjeU26QwgF+QJ3FYCA/RCLPHYcv4w4=;
 b=TQT4Toouj3tBmPmES2cZ5TR9AhXwugKFETyGvOtXNd2NC4A1d4URDYKLX4mB3zSZbC
 P6+ffbKEwonVil+Hqs1y/BbqRAWa0ZEfi77296Vyw43dOTQ9Jv0ePu9BTv4ZI+uLvc0x
 ON5OO2gYKRODDiBFArPD0C1wQPDTK5hAR0PtNfCIPlovoitsASyY8YfizAJ0MEPzfW08
 3WRdvLqSm6gpJtRIybEC88onmovGUbQ+MawJ3ljNV0oLGovZ/o1UEaiBWcbp6wJNkXlH
 RHeKEhoRaTN19XuCtOWCBnUz/masyP2oDHCjx5vedDTNfeo/MJKfFxppVue0yao8XU++
 8r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780266858; x=1780871658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tdIK/gvHilJ2zjjeU26QwgF+QJ3FYCA/RCLPHYcv4w4=;
 b=Ss0twGxNl4MZveJpE3DePeCdn5VtPLqyHVVrBSgDJ7Xp+xdS2Ouim7JRaLZohGVg9S
 JXkKgnsy20iObkhgndlATXI3g3m+5JvhCOlK0wMH16cG1JO8CrWeqH/rjisr2s7kfT8l
 euIEk90mrcMepaVspuuX48l6t36oYhrl07VZ9CfDP/EQuiYmtG0iFhzomkIFChjpkPwP
 VxYbCPPRVcHW0JneTk0sEl/2B9ePd5zVUfjrIBmz1eTl2BKopWutYBCdrKq0QuhHHIS2
 jS6/PjKue0urGJ1ktuR1MNXvlX/2QT/sGmvTi/gbAgGlcA3UB/ophij9f2/+lUKvfnmb
 GuDg==
X-Gm-Message-State: AOJu0Yw6exTqg5dtrN2rP2auGZxSG9HX0LZRWS3qkiZihyJ9FXnge3si
 02XEyOeWHgGsUzh7A7i09lTI8CjfC4sTubVQuJkU2pVKiEaVnDIS6rCTLRIxEE8SUh0=
X-Gm-Gg: Acq92OGUyUuIoUnC2EAsUrab1p/KaHJeLRGzM8So0jL5gRMBPPeJbjxR1/2pa1plMAl
 z3jTjpj5bqibPerOs+EeWj+taGNFdnPeEK16zp4twEhflVSTlFB1KnDYAAhIbYjPM6wbw12XIvg
 QDa/3bJlpGHNhbiE4pdW/0OGtCmKg6CDtWYgbo7xe9fjqgfvR47iVk9HM6IBVDdRz7wOAOENHsg
 LtOkuoTr0JRCg29OEcOgdJvPsHMUKLnJMSev2kFc8iddymk6ym2arNIYmeox3XpjEr/RJ3UG+Zf
 aL6wcjoFZHUzy8YBal32BW3543zFRGccMp2FMto0TUO0aZ2T89AJZgLq/hpdcC1+Q0jjPo//LZd
 KguBOPvsvLkUuHdgWtTjQhDxe9fC0UugOVbm4oUXUmCkMhFyqZoK1M94t4MDaGG+y7k3rYV8wSv
 hcl0OU7w/1kamOinlBBT7+CD/lyWSLB4ArwpEXGmiBaOfgC7CFWOH63YQHLWUh53cm2xZzn9yRQ
 VE=
X-Received: by 2002:a05:7300:6426:b0:304:c9f1:a0e9 with SMTP id
 5a478bee46e88-304eb115e9amr5316155eec.9.1780266857619; 
 Sun, 31 May 2026 15:34:17 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c10c1sm7033495eec.1.2026.05.31.15.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 15:34:17 -0700 (PDT)
Date: Sun, 31 May 2026 15:32:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 19/20] drivers: add testpmd commands for private
 features
Message-ID: <20260531153257.15f10683@phoenix.local>
In-Reply-To: <20260530184625.480938-20-liujie5@linkdatatechnology.com>
References: <20260530184625.480938-1-liujie5@linkdatatechnology.com>
 <20260530184625.480938-20-liujie5@linkdatatechnology.com>
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

On Sun, 31 May 2026 02:46:24 +0800
liujie5@linkdatatechnology.com wrote:

> diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
> index 43e8c59487..ed74c84ccf 100644
> --- a/drivers/net/sxe2/sxe2_cmd_chnl.c
> +++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
> @@ -7,6 +7,7 @@
>  #include "sxe2_cmd_chnl.h"
>  #include "sxe2_ethdev.h"
>  #include "sxe2_common_log.h"
> +#include <asm-generic/errno-base.h>
>  

If you need errno's then use 
#include <errno.h>

Ignore any advice you get from include-what-you-use (iwyu) tools.
More portable and better to just use errno.h
