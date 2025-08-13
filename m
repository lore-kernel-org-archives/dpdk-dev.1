Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3E6C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D336F40657;
	Wed, 13 Aug 2025 16:21:40 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id AE13D40265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:21:39 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so41153825e9.0
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755094899;
 x=1755699699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRAiXv5ifk2o2P6yIzDiW8jHD+ga9WOSeKA5mnT22jg=;
 b=m3l1QZ5PrXTtRkUMItVk0YMBPBPCk9B6qkH/6vFu/VEvQhcthQKrO+FHvcOB2wkahD
 a+zIpZchDgwc0HXoCOzquA69lMXqrjRt8HhXISm0dTEH2jbYOCbGaWedaD7NhmoPgvcl
 hqvxROShUpatf5tV9I5k9eLjsIJ5MMg7uG832G8dSDXpmDhLyG6yrbFjBfQicW0I22ej
 fWmm4ISMrPDkfD1NpDV2EElTm841akHtt79ZjgXYbJwK0yGTbUGvNTOaeA6tidMTN/Wj
 Q2Or6cdcoDlD2qlS4N3pGlLoxa7WhzWsSBOryBg/LhvCUv11lCgjsc/lLq6estJbnMLP
 rjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094899; x=1755699699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRAiXv5ifk2o2P6yIzDiW8jHD+ga9WOSeKA5mnT22jg=;
 b=NdiRdbn68KzAEOvy00t4+j5/C/Q3bRrLvUdMSLRZIuPB/rtFNhL9OnftCNN7vbsfNt
 XealWbM2Kh438jPqVQjHNps4dQpx6MCHy37hATg3GiCzRk7mqNGpvy7OdnmJGvK8hZ3x
 DwfDUxtDbWGvDW4pq/XiOBK5QuFTgmi0NO0Pz7YUAwd1qeplJNVRGwFbugXvsVtc8bSo
 SoERaAbYXE+yfYS6sQkVx43DUTKPWWix2p4Y6TxVuulR+LPTGwPgGfXTD+88YqCXGd37
 KhsiGZSuT8nM+eUph4qhborLEe4K15AZT3BUcnDN0KgiGUAREZhP600GzFHUlpFik70P
 4WuA==
X-Gm-Message-State: AOJu0YzUxPL9NOd+5H9PrAD7aEiADaMQbpuBOliPhmIGOmlDLYY3j/Mo
 VORipL6xbNNd2NgrM8hoHAzHNktpsgf7rtg3CRkCsJiJ5REzfBKGFSR9ex60IdkbivA=
X-Gm-Gg: ASbGnctfma88izltT6lj/loJiz+G1SLa6CpIuenEu9eAhc7Hf185cUA8vDYOg0kIVKh
 RDGqkWKr0vo5ludeMKCmmTmApan6Aa6wxR+LVOH5qs8jWvTYQ9ZnNb6lpLgp27DOpWnQ7H3S6Aq
 uuvJPRRRl8pGwO5YaIvmEnq1Cv+Wad+cag1INpfdfVVRCVXB+piX4sJMBzVXKvcFuQhRNZwHAwY
 fbUs6NyJmi6V2zjCqUS9liytJp5BEMgP58ZdCWbS7kWTFwMxlvNffLY6cfZCU6SJR/pQkxDE4y+
 7JEJgIo2KL3VyVKk1YVQzRmJ6QEWM2bq8KVY/WikMBW088f/0pqqTjgTLk+NFzZ4WG89hq45GZN
 B7IcWzEdfgXJYhkbzeUig9bg3MzBiQf78MSP6mPy2zC2L6VNAY3lM6wMVjki2lAe90ksiFegjpV
 0=
X-Google-Smtp-Source: AGHT+IFhnOAYKiAUesR/BCOI/nsrJCChYnIjKanv3DNtm4MBm4TopwWtUYVzeeNyVc0r4gZ4vpcXBQ==
X-Received: by 2002:a05:600c:3507:b0:458:affe:a5c1 with SMTP id
 5b1f17b1804b1-45a165a2d68mr30402295e9.5.1755094899222; 
 Wed, 13 Aug 2025 07:21:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a519159sm4664305e9.12.2025.08.13.07.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:21:39 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:21:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 04/16] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250813072134.694f9321@hermes.local>
In-Reply-To: <20250813064410.3894506-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-5-dimon.zhao@nebula-matrix.com>
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

On Tue, 12 Aug 2025 23:43:58 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> diff --git a/drivers/net/nbl/nbl_common/nbl_common.c b/drivers/net/nbl/nbl_common/nbl_common.c
> new file mode 100644
> index 0000000000..06dfbe7cc6
> --- /dev/null
> +++ b/drivers/net/nbl/nbl_common/nbl_common.c
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright 2025 Nebulamatrix Technology Co., Ltd.
> + */
> +
> +#include "nbl_common.h"
> +
> +uint32_t __rte_atomic nbl_dma_memzone_id;

__rte_atomic is old way. Newer code should be use stdatomic ie. RTE_ATOMIC().
