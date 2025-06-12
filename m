Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6061C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 17:49:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C113E410FB;
	Thu, 12 Jun 2025 19:49:54 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id BCC26400D6
 for <dev@dpdk.org>; Thu, 12 Jun 2025 19:49:52 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7d09a032914so107370485a.3
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749750592;
 x=1750355392; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Vgdib4wvPccIbevn3+fcXQawWrq39Wn633vh5qcjOg=;
 b=CijZVBh+HwFVna0Rjjh7N/X/lSGGcxYKmZOtKa0HQO4AbUxhAXDjRC+NVIjoOhemnE
 zfIP2JYpUKJ8GFwFNJNcmybbJcLrnoKlgOhLlP5aJcegCAmfdUYowXxZaLj6+vYRbFtL
 MPKK1jurLIR7iL0k8OK51OWtSVDrKHZgHKJWuagxsIjI/YRXZTwU/uowrfqu6J7K7hdY
 9v3y5dwGs+THske4yQxg287mY1Mfr1fAM4jv45+84hVMq3Dr65gUUXZzxhkDEQoDRZAA
 vLGWM6Q8PEfxnvxDDrumvJTskZeCpTMmI83s8BbXD+VqevH53vX1QvKZPmNiHIZ7gqps
 a8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749750592; x=1750355392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Vgdib4wvPccIbevn3+fcXQawWrq39Wn633vh5qcjOg=;
 b=Wy5sW9Fn2Kjb6r5aakMt7bLSXfuFc8BS+JkD5qhkICFqbe25IWcYHBP+VaHnFjBxCp
 FfwXbqtwqj1A5wGB7FNNAMZplyw7OnKVi/iZF8K1nevFEQLio+e4lJFOiPuvzGgjbSiZ
 M0NW+ePz/uhC4vFsS3H5rfOS5hja/goySBMK0UxyTpEol4oc3u2I5xu25u5v2y9YVbEX
 FsAjLoTXooUKnag4Ty1vfq4j8sBzjggA791CbyAHYvOEFGApwefrnF8raonpQmyOb85B
 Kd/BTSQeYZRNiK73xquMNN1aeHIShIV2NeXOxadymoBU0Y7BeU0B2VnGJL2sDmPi7kd3
 ATCA==
X-Gm-Message-State: AOJu0YxRBrAKj4XvqiQd66ukBxCkAJQ9C0PcHXqKk3bUZ4dA1P4d+Fey
 P7wkrWyuUZmN62g56bzu35Vwx/tLwnnipLZb8yIz/1WXDTEA1AHiNWVQcYwZhyQPWR4QUyc1fLL
 yQ13N
X-Gm-Gg: ASbGnctr4t6h9tKVw1EiSTt6P3ASj0eFvc1+R8ijn/NyP2e9HBPCRBKjJfB3mAGxPBt
 kCnaF4hrilOylsLpgbDx8mEvrHVSsA2ctrGDS1ln879QMPIgCeBmMjQUdfzJgA8Al6aADhKOJXe
 xI0zJ13B3Twr8brpRMsX/tXyDM0dhtHRs3lW75ww3LEAWdum2cfKiZ9UfW0w3hfPsF6+kKNLJFZ
 f+ynhYBoodEoXn2OCjQ1rxXKTVhKMXcXacwA+ufzT5rjDxxewK6s/i2QhqRR0xtm3Iqd5uwd1el
 cAMNYv1uBkrChOUrCjfC3uLIPzuWMs57MDmNUFpFfFOuOw0xPbHAht5J+xGRTsBapNqHzR6mf+w
 CoKxPAUoJnbEkXrE/cnu6z4aBXmjhBVVjVfbHJHw=
X-Google-Smtp-Source: AGHT+IHc7YwR4YQliXpa+D1aY+K0IKCZOnosiDfWt+dpnWI5SIllFKdytAE9Oh0o1viB+NDKmtWqjw==
X-Received: by 2002:a05:620a:1a85:b0:7d2:26e8:d186 with SMTP id
 af79cd13be357-7d3bc47d91amr34768285a.36.1749750591831; 
 Thu, 12 Jun 2025 10:49:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8dc9313sm66892585a.24.2025.06.12.10.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:49:51 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:49:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 02/17] net/nbl: add simple probe/remove and log module
Message-ID: <20250612104948.6404d009@hermes.local>
In-Reply-To: <20250612085840.729830-3-kyo.liu@nebula-matrix.com>
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
 <20250612085840.729830-3-kyo.liu@nebula-matrix.com>
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

On Thu, 12 Jun 2025 08:58:23 +0000
Kyo Liu <kyo.liu@nebula-matrix.com> wrote:

> diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
> new file mode 100644
> index 0000000000..1697f50a75
> --- /dev/null
> +++ b/drivers/net/nbl/nbl_include/nbl_include.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright 2025 Nebulamatrix Technology Co., Ltd.
> + */
> +
> +#ifndef _NBL_INCLUDE_H_
> +#define _NBL_INCLUDE_H_
> +
> +#include <ctype.h>
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/genetlink.h>
> +#include <linux/ethtool.h>
> +#include <netinet/in.h>
> +#include <net/if.h>
> +#include <net/if_arp.h>
> +#include <pthread.h>

DPDK locks and thread are preferred over direct access
to pthread.

> +#include <signal.h>

Not used, do not include

> +#include <stdarg.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/eventfd.h>

Direct use of eventfd is non-portable and should be avoided
in drivers.

> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/queue.h>
> +#include <sys/stat.h>

Driver does not use this header?

> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include <rte_ethdev.h>
> +#include <ethdev_driver.h>
> +#include <ethdev_pci.h>
> +#include <bus_pci_driver.h>
> +
> +#include "nbl_logs.h"
> +
> +typedef uint64_t u64;
> +typedef uint32_t u32;
> +typedef uint16_t u16;
> +typedef uint8_t u8;
> +typedef int64_t s64;
> +typedef int32_t s32;
> +typedef int16_t s16;
> +typedef int8_t s8;
> +
> +#endif
