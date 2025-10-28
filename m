Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7537CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 20:50:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEC704042E;
	Tue, 28 Oct 2025 21:50:43 +0100 (CET)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id BAA214021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 21:50:41 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7a2852819a8so4537750b3a.3
 for <dev@dpdk.org>; Tue, 28 Oct 2025 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761684641;
 x=1762289441; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qYwV+VpbgwiqabPHaUyFrSP1BFP2Nu3yWS6JzwbstU=;
 b=P3065mN0/KTJ0qoZWJfmaHVIkxe2knyOn/HF4+cOEMqd9hHT6eQQ56O5EKz8bIp2KM
 ORoXl5Fi0xVVirvBGe9aUHG0By8E4FlalcMP7OM1T5/LY3iXBfHNmoLX5qstiRPWkChA
 gjv6f2Lj/ODIjiR9027JpxpbVvuu8ADYhxQ3uGWJ4tagFzlno7djj+dpWbMqYxMg93V8
 epCdot4Pc/uPMmcNCycMMvKDpfLiAAcKO8v5wTej7X3BaCjEkAFmBg51KelSyGbt5wxj
 BqD4cDmApMG0GSkSjBuuTxvfz0YjBw9arTKkjGliiECaCOMKGcTa3i20y+W8fPpHSoK7
 9x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761684641; x=1762289441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qYwV+VpbgwiqabPHaUyFrSP1BFP2Nu3yWS6JzwbstU=;
 b=Ampe0BK5Zg8khT4XBxbDbE5T27LMOdIqIjjnJ2rDH9rJsEnQpkErMrDlEBtewfI0ci
 6TqW9+NVHBk95E5/0kGxIAsM2XOVBcIodBY7VvGhCG9mjMcHXDzCxyzF6WILNgRIZ01e
 BUXFPL2zXCgKoV1aOL/+OUKEU3ThFjBwImsM2Dn4AOiks28WiJmtsLC7SQJ9zyFuULkb
 7GGR7Dfp9xLn7ComXivKZJi5/J7dhGo5Rw+SC+U9d2dxNbACLHHxZMp0YMPxDcK/yc1v
 BALVOfEPUpnOdcm6lzVPwCPsUiNxikPBP04wrwXautCmulqOYMHktYhHRQ+rTmnqyfP7
 eJZw==
X-Gm-Message-State: AOJu0Yw79QfvXS+eYyO6jL3sdPbpPogczP6Wwe/egNLFz9B9NVdFGjeo
 54Ia0gmP5pzbophsQACKoXYMx2fV7XoMvod6D5yaaS+thIPOI5c3jh6Sn3GFlf8ARnU=
X-Gm-Gg: ASbGnctRoM1uW0lc02tkPQgvD/aeWhqipYxwCSNxR3SG2zu0MYv5BllT1FidTR2OpDf
 xBRdWFtW138rLbvfWLyGckBLWU8YMtCP7hmnAX6y7ky1uOF+8t6krEc+auGIRvjeGFJ9ECPvHVF
 /D7ZR0oYNRszvABV7zl9hzJdClFCkOFQKCC/85RJ3G3L8cVHLO+OV/52qEDXcG1BHWJTWMpWs2J
 hs7k4UHA9yEb13YppNT7ynUXlLApKV00YcV0oED/ShiIWVafMxKUPVUIiIFPbA5HJLraIT26b3k
 0KznmUqG7X+r0gLoxv6BDIXt+WwSoBsxt9+/JlaZgZLB+95XuposGkeWgHAb/kUfntpE9XVFeqa
 NlEMAE6alZHK/wbDEGg9dKGNqTcOctzt41PRfP0I8ruZKHPwcyuAdTshnZw7ZwJafxa/kad0/5W
 2D2X+XRUHdzg5L1+TFp3N2MKd56F72/eu/Lw==
X-Google-Smtp-Source: AGHT+IHn6DFM75s/Rvdo/eIlj783ghm1lA33uu63kSqbDBrnm1kvWLL9RSV+pihXObYkdipm0H6y6g==
X-Received: by 2002:a05:6a21:33a0:b0:334:99f9:ff57 with SMTP id
 adf61e73a8af0-3465381373dmr370166637.47.1761684640915; 
 Tue, 28 Oct 2025 13:50:40 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414032c71sm12849828b3a.25.2025.10.28.13.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 13:50:40 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:49:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/9] net/nbl: address nbl channel integer handling
 issues 490942
Message-ID: <20251028134949.497a5108@phoenix>
In-Reply-To: <20251027101649.3337618-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
 <20251027101649.3337618-2-dimon.zhao@nebula-matrix.com>
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

On Mon, 27 Oct 2025 03:16:40 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Coverity issue: 490942
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
>  drivers/net/nbl/nbl_hw/nbl_channel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
> index 7cc214df01..17d9231dfe 100644
> --- a/drivers/net/nbl/nbl_hw/nbl_channel.c
> +++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
> @@ -376,8 +376,8 @@ static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
>  
>  	txq = &chan_info->mailbox.txq;
>  	next_to_use = txq->next_to_use;
> -	va = (u8 *)txq->buf + next_to_use * chan_info->mailbox.txq_buf_size;
> -	pa = txq->buf_mem.pa + next_to_use * chan_info->mailbox.txq_buf_size;
> +	va = (u8 *)txq->buf + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
> +	pa = txq->buf_mem.pa + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
>  	tx_desc = NBL_CHAN_TX_DESC(txq, next_to_use);
>  
>  	tx_desc->dstid = dstid;

Please use standard subject, like:

net/nbl: fix nbl channel integer handling

and add Fixes: line to track the original commit.

Also it is ok, to fix multiple Coverity issues in one commit.
