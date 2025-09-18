Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEADCAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 21:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CA4F40655;
	Thu, 18 Sep 2025 23:42:32 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 1D646402D0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 23:42:30 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-79390b83c7dso11859936d6.1
 for <dev@dpdk.org>; Thu, 18 Sep 2025 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758231750;
 x=1758836550; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8Wzr+Fv2CZQUy9Xc5fBiPgiMUe8sWggjk4WlgDmjvc=;
 b=o7PidjVjEIYrykPS/KV3Z1lYqCF44V49HoCl/cKlwqweliEKG3JZrC8sLX86U0go6F
 S52xjVT3sIJbE/jtVmrf+wIeSDVNpHMB4Rj+pDDdwtnSbgV8MnM/VoQUQJnQVHoxFBuM
 GjxvMj+gepHNse20CP6bcH38nzNlRhfiZfHkrCJWfmh9xjM/KJYzzXPnryGSAicYCRVu
 rgUHzfQh0EU/IYUp+/wMjjPagxNx9KlXvqi6hXlWoJCxaNB//TzSjuWfP3Xh2XWwxmCz
 O9C52FIpgmO6F8mdNtXICKyKE5ar6q4xeXqafxrSnTTriZBS6fl8Zk6bHZ/bwiH6xiC1
 BkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758231750; x=1758836550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8Wzr+Fv2CZQUy9Xc5fBiPgiMUe8sWggjk4WlgDmjvc=;
 b=pZI6kYMUNqJjMuB9yadRdCFjDe6c14FRMt7vrA2u5u9X3PC6QFZ80p9oGSrnszkx7b
 YY7H3mfCN/uY2hNGuljSnj7GE/XVr42ZZT83D/a4LVCxZ34G/GJiu8OdB82UwH/Hl313
 /A74Mm8osJWSgyWQYGt90hda95l5NTBzx4jgxGLps/bTBylMQLarGTbb6qCA8tAX3J4f
 4rZUObH2PfKQOWH2yQPHak2EQrxS6iOC6+KcYvm08VQt2tRYpMWqNC5wNX4GzSpYHjKF
 icpRpV0JUhf6maCv5QM9WMUJwADLOLmGYBqar4GqX4p4TimXSnDfHLo0B8eL8wBL6pDr
 SJXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf1HWqsKsoexFv/uvF+9BM7QUIPTZOI3URMFu61g6RDhL6XAlW1sryu+727AXtYTA+sk0=@dpdk.org
X-Gm-Message-State: AOJu0Yyw8SH4q54nVtaIiysESPGGuruJZqLtFjDl1iZHTJOCSTj3MNLN
 L3m2kHtj+dy4TPLZSRHPXXYCWBGzb2EdRKLhCMJtW0tLQ0mQhkhLv0wXSakNM7CJEjU=
X-Gm-Gg: ASbGncvfCKVQCvYcLL9GC33UsYKqKFfoTG5g67fpRINPS61OvMr+ikllcWlURcwxx3k
 yHyfp9yfinC9dFNWzH412yQGHZJ4IjS6WKhnSXFMhtVHBPmLQi8Z4ivDfsK0jPdiPncAD2bVL7Z
 JgK9OTzhyO2tmKcSSmgvDWbPngJ+dpJzj17auA0/l7qlQeblYNZargOVf/lxjyiHOMqj/IvstAi
 3k30BbgBbE/K5pwMxDytVtCHsi7bAI9smETMyWdDUdUPfP61zxLJ2uDtaHRHVPFxckqjeoa4DNk
 0gBna7jQCtbZ5nTSejnmjIlsR8duh+LRiueQVyenzJAKWGbPxpyBNhQUFR2KNXiV4LR/Jot1TEV
 DrZEi+gO81cXd+n5Y/i9fO9Lu+4RSGHsoaX9coV3ttISDiKNTPDcRMqXfgdt79hCUHxmJtCj5bk
 8Zc1PlRhDy9+LVG1+9lQ==
X-Google-Smtp-Source: AGHT+IG5T0hj2pB3lv4luooG+4I55kMLJhBA5iB2jykAXz1iYGPIwbUsFSuoOEcq7ElVOQffzm+VTw==
X-Received: by 2002:a05:6214:d4c:b0:78e:49a0:2ba4 with SMTP id
 6a1803df08f44-7991dfd7de2mr11037406d6.58.1758231750188; 
 Thu, 18 Sep 2025 14:42:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-793533affbcsm19624036d6.49.2025.09.18.14.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 14:42:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:42:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sameer Vaze <svaze@qti.qualcomm.com>
Cc: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>, dev@dpdk.org
Subject: Re: [PATCH] compress/zlib: support for dictionary and PDCP checksum
Message-ID: <20250918144225.63a09b8d@hermes.local>
In-Reply-To: <20250918203210.1689254-1-svaze@qti.qualcomm.com>
References: <20250918203210.1689254-1-svaze@qti.qualcomm.com>
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

On Thu, 18 Sep 2025 14:32:10 -0600
Sameer Vaze <svaze@qti.qualcomm.com> wrote:

> Adds support to provide predefined dictionaries to zlib. Handles setting
> and getting of dictionaries using zlib apis. Also includes support to
> read dictionary files
> 
> Adds support for passing in and validationg 3GPP PDCP spec defined
> checksums as defined under the Uplink Data Compression(UDC) feature.
> Changes also include functions that do inflate or deflate specfic
> checksum operations.
> 
> Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
> ---
>  drivers/compress/zlib/zlib_pmd.c         | 173 +++++++++++++++++++++--
>  drivers/compress/zlib/zlib_pmd_private.h |   8 ++
>  lib/compressdev/rte_comp.h               |  31 ++++
>  3 files changed, 203 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
> index 92e808e78c..1b1abd72e7 100644
> --- a/drivers/compress/zlib/zlib_pmd.c
> +++ b/drivers/compress/zlib/zlib_pmd.c
> @@ -4,6 +4,7 @@
>  
>  #include <bus_vdev_driver.h>
>  #include <rte_common.h>
> +#include <rte_malloc.h>
>  
>  #include "zlib_pmd_private.h"
>  
> @@ -15,6 +16,120 @@
>  		(data = rte_pktmbuf_mtod(mbuf, uint8_t *)),	\
>  		(len = rte_pktmbuf_data_len(mbuf)) : 0)
>  
> +#define BOTTOM_NIBBLE_OF_BYTE 0xf
> +#define TOP_NIBBLE_OF_BYTE 0xf0
> +
> +static void
> +process_zlib_deflate_chksum(struct rte_comp_op *op,
> +		z_stream *strm, enum rte_comp_checksum_type chksum)
> +{
> +	uint8_t *dictionary = NULL;

Maybe best to not initialize this. That way if there attempts
to use the variable when still NULL, the compiler can detect
use of uninitialized variable.

> +	uint32_t dictionary_len = 0;
> +	op->status = RTE_COMP_OP_STATUS_SUCCESS;
> +
> +	switch (chksum) {
> +	case RTE_COMP_CHECKSUM_NONE:
> +	case RTE_COMP_CHECKSUM_CRC32:
> +	case RTE_COMP_CHECKSUM_ADLER32:
> +	case RTE_COMP_CHECKSUM_CRC32_ADLER32:
> +		ZLIB_PMD_ERR("Checksum type not supported");
> +		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
> +		break;

Why is this different than the default case?

> +	case RTE_COMP_CHECKSUM_3GPP_PDCP_UDC:
> +		dictionary = rte_zmalloc(NULL, DEFLATE_MAX_WINDOW_SIZE, 0);

Is there a requirement that the dictionary be in huge pages.
If not use malloc() since that has better error checking.
