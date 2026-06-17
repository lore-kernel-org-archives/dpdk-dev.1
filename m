Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE62CD98F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 14:52:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B59E640276;
	Wed, 17 Jun 2026 16:52:12 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 810F940268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 16:52:11 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso1885251c88.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781707930;
 x=1782312730; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTNQx/3+UEUJRk8eF0LuRrpxrldBq5JY+t2XZ7xpH14=;
 b=a9L6d2lsVJ4A6MI6OCKUGlmDwO0ODj4SCU6UJahTqX4mbIqJp7KnIqdjksXzyJpSNL
 VZJ6flRoDVhxlzu/0GLY2DFbmRk8t9/pCATinzm59logx4z4B07niQZuNUK/DFCJXBrA
 hNOyi+UwmdBCaPMNTYZMDgLWlGTZBQFanyf09VuQbNeGvSZW6y3cKELW0P94GhDhqK3x
 fEf+jz3Slhy9NdXJkX3JfH9bng5QouIHu9NVyWcjjudLplEyad7BBkHH3odA/Qel+/6E
 YJLY1ycevZvtGu6byTkqIzwuahS28Md7XlZkO6iGqbQTE7JyAP7Vb4rt1c/JNSpKaUYv
 hSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781707930; x=1782312730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vTNQx/3+UEUJRk8eF0LuRrpxrldBq5JY+t2XZ7xpH14=;
 b=g/jYJ5IQ4hJKVXh2itflFCe3Md+ipfxNHGDeQdtuj7r7iIg+Tva2SlGFmo8HzI4/P5
 zoVwV/D1D+k/xPzxzVek9zPy9zF4hu6TQjtEFgPxeamua2X558o/teqdmDN7R6sdjRPH
 BbVb24yKF4Yt6t8xN6n4d6P7uZV498wa8672/EniTjLeqSRrDKLfZvhh1QcsME5rfNV3
 JquTB4Ltu2YrB5xkoJm7XBw8AIqBGGQnY7mM0uiaHl99XFICZu3dKhFHAsg6THdvw9Am
 9SEQFVvPa1kW/Q23U7shCOXejRYK/DGlAR+AHVUz1oTrSwDR320nlMXBuiriUbamIGyc
 Gj6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SsX8k6SJG2AzmCcwmJlHUpth6zQhVnXthvHpNoLZpwyC9s5/5DxoF7p1d/lC+MtddksI=@dpdk.org
X-Gm-Message-State: AOJu0YzcAKukD0sUldDCroYyvwuI2yIyIpx+fxRfwwtIRFrQPjAObkoi
 6VDsQAJwh42WJ8C90CIuLfmW3j7hM6W81DVism0C1He8oYIckPwc8uttZzbRH5lDJFQ=
X-Gm-Gg: Acq92OF8E94TMXt5rYU7Nrgqia0lVk+hcVTyfwyOHLxsBrKUgIN+Nm/XDNcDogBjqhY
 nY5VTKImW6fr/EPIMmTJiS4caLhw9wq2+6ViZouGJ5FpGhMRjU+gN4xCVWwy7SFzxo92V6LfWP0
 W6yswuYfG3A+GoG3xTe6xD3J49sX23qsOfKF6Jkf0SSzmBxhVZNblqPyII3Li2Lu+ejQgmSJibp
 Mctac8rLckivuRyGLDEGmcDR6bR/oyOIuQdQa5JcUh2lKDBZicA/Lqzt6Br7f9OM/QERz+xbVm4
 zHG8cr1Drf4rpxTzjHPzbsUEhADHMl5/mWMh6sxKGTW49onyz0CCkBHF4FH6rzLjxPlWESm+1Gy
 MYCQNg6/Yc2OebK4nTqCW6MFQYlHkDM1BUq3fjL204lFhIJeVrwtHqsTrEt5oVK6jGvMtsmkIZx
 TAYUAj3aivazUvX4ji0uyGFJYdvLXO6aHnQUSEv/B8OCkOP/HpIZoHvQ==
X-Received: by 2002:a05:7022:2206:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-1398f6cbc71mr2006612c88.19.1781707930514; 
 Wed, 17 Jun 2026 07:52:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm16990082c88.14.2026.06.17.07.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:52:10 -0700 (PDT)
Date: Wed, 17 Jun 2026 07:52:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <dev@dpdk.org>, <jerinj@marvell.com>
Subject: Re: [PATCH] common/cnxk: add bulk Rx queue enable/disable
Message-ID: <20260617075207.13e0de0f@phoenix.local>
In-Reply-To: <20260617054943.287815-1-rkudurumalla@marvell.com>
References: <20260617054943.287815-1-rkudurumalla@marvell.com>
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

On Wed, 17 Jun 2026 11:19:43 +0530
Rakesh Kudurumalla <rkudurumalla@marvell.com> wrote:

>  
> +#define NIX_RQ_BULK_ENA_DIS_LOOP(REQ_TYPE, ALLOC_FN)                                               \
> +	do {                                                                                       \
> +		for (i = 0; i < nb_rx_queues; i++) {                                               \
> +			REQ_TYPE *aq;                                                              \
> +			if (rqs[i].qid == UINT16_MAX)                                              \
> +				continue;                                                          \
> +			struct roc_nix_rq *rq = &rqs[i];                                           \
> +			aq = ALLOC_FN(mbox);                                                       \
> +			if (!aq) {                                                                 \
> +				rc = mbox_process(mbox);                                           \
> +				if (rc)                                                            \
> +					goto exit;                                                 \
> +				aq = ALLOC_FN(mbox);                                               \
> +				if (!aq) {                                                         \
> +					rc = -ENOSPC;                                              \
> +					goto exit;                                                 \
> +				}                                                                  \
> +			}                                                                          \
> +			aq->qidx = rq->qid;                                                        \
> +			aq->ctype = NIX_AQ_CTYPE_RQ;                                               \
> +			aq->op = NIX_AQ_INSTOP_WRITE;                                              \
> +			aq->rq.ena = enable;                                                       \
> +			aq->rq_mask.ena = ~(aq->rq_mask.ena);                                      \
> +		}                                                                                  \
> +	} while (0)
> +

Why can't this be an inline function? large macros are a bad idea.
