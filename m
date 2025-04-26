Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23FBC369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 16:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F027C40156;
	Sat, 26 Apr 2025 18:02:35 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 987E0400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 18:02:34 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3085f827538so4546751a91.0
 for <dev@dpdk.org>; Sat, 26 Apr 2025 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745683354;
 x=1746288154; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9sbRSCR+7BSZny1DardOyxR+ukRoq3oVbFoPgArZ38=;
 b=fYhmwQWkN93RgXuT5efGgV+iWE7pyhCyk8+oeCK2dFxD8Zg47RbCmMMo1m2w9Xn+FA
 uFqj+60CnDPJFPnawOS5+6aBACGvqJ1ebbWONUsh9YuvopfIJW58nDEyXuZgt2XIV6Xz
 e/MQ/ilqKINPsPmeNPfUijpeCHyvZRkvjm/nOUNCRaIYOEgFHvFO8nMQa2T3G6JLkGJ0
 eL85Rv4jVrpm2mIwC9M3dSBfTBwhineY6WAbr4QqtDZTymj/Ylum3IL/qfpj1NQvKtZu
 DI85Qb/qZzBmMbW5ixC21tt50zWSwwcrAoOvVa+BB74nvLRBN+1Hinyp9rTU5GFPYv2J
 qhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745683354; x=1746288154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9sbRSCR+7BSZny1DardOyxR+ukRoq3oVbFoPgArZ38=;
 b=benhafHMaTfTv5F7+x9PL9PNXZqdzFNccM6oDQipsxt+RNGSekCGH8ofxkTduQCPZb
 8Pn9h2HloIvJ6+6aSu+f2Ix1EfalqLIQbrOma1ZUh7MoT6szBcpKo2YoHO3XzVVszVhS
 kTsuDAi/uhB09PByOJUG1v4lZ0RToZCukf47k6/cnrBBKtBS7YwFTvlYGSkPkUCDZ2qm
 alhSeAahVYk4STY6ERMM23ppGg/yoBTGzR6nfGAPt1jQPawVr+R4+nNS23/zUVYiJRE+
 50RcMk/Aarm9XoD/tOFKwkwQOzjz5zkdH1s7H+mL6Pt2o7UCP1EMoXlQ95R6tEFOHi9n
 uoqg==
X-Gm-Message-State: AOJu0Yyz+bZhovdYFjzQb3+miX9FxcrnkouQOH49oN8pK0acW9c4vOmZ
 UlAGstm8pnNx2w/quxyQDqJbjCGrKcIyvbKxCri3dpjYiOqJkwWDidj3SgwCuTo=
X-Gm-Gg: ASbGncvDienF7c6c5HnCz4vriAeMIFS9jRC9ubL6JPVSuASWlC1liB1ffSFKHGG4Ngc
 dHrvfkHAg/zv8dHQCOZxX+lBm2eOACH752ii/N4prDVi3H+zO33PsEoDCH64hjEvcoeImjLzRkN
 AyXinL4Wboz8jO52C5XAih6nFzJQLysHICmk8iEiew6OZ+U6HPRVbQRyr/VWLILSSdXQ0FjTHUL
 UZBM/UM5I3d2k7S15xiDoLdsKNHMyfgp/X2P/E4W6LEsENxy0Cnx+RNRlvRAshB9VSnfct5GfL1
 lcLPBCO1Yqt5gGnvsLhVYZNJ6k6unXST+um/7npfKuDBY7AcrWyVlfqM6q4qrP/BrOGcXw9b/vy
 qKNcwsAHzzDJ/F/q0
X-Google-Smtp-Source: AGHT+IEXKTrr+xpevGbGC56wa8nIThSX5HhmImAVawmOS1d5l0jPfC7C6RcELbSqMZ43zylSnmdWDg==
X-Received: by 2002:a17:90b:5388:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-30a013291dbmr4639851a91.11.1745683353697; 
 Sat, 26 Apr 2025 09:02:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd3f9sm51332605ad.89.2025.04.26.09.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 09:02:33 -0700 (PDT)
Date: Sat, 26 Apr 2025 09:02:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 03/13] net/sxe: add tx rx setup and data path
Message-ID: <20250426090231.1358c357@hermes.local>
In-Reply-To: <20250425023652.37368-3-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
 <20250425023652.37368-3-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:42 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
> new file mode 100644
> index 0000000000..91ae1c792c
> --- /dev/null
> +++ b/drivers/net/sxe/base/sxe_offload_common.c
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (C), 2022, Linkdata Technology Co., Ltd.
> + */
> +#include "sxe_dpdk_version.h"
> +#if defined DPDK_20_11_5 || defined DPDK_19_11_6
> +#include <rte_ethdev_driver.h>
> +#else
> +#include <ethdev_driver.h>
> +#endif
> +

NAK
You can't depend on DPDK version. We don't care about merging
your driver with old versions of DPDK.
