Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A528CDB479
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:32:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 169484029D;
	Tue, 23 Jun 2026 18:32:00 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 2A5E440150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 18:31:58 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30c52cc5285so2616416eec.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782232317;
 x=1782837117; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Bkg1PH6YnhDCkIr2vOAjI7aK6Ci1LtV9X7Yo2w00kA=;
 b=S6yzsFh8X42JwrbezOotfhc5DgJctjwVIR1vhi5SNuMW4LKg/FyaNBCTJxMR0/8y5q
 oIXJXNFIjm46RJqNuL24uBVv7LY9s7IbY3YMCn8Hi0gIKvhFwmBDTWPO1Tc6hWcVOA6s
 UjWpTALVerfK+S2yEb86g0XJ7nGR2rsDJPTG8YFWEzbyL/qo2a2P/7UcK5rUBlb3Y0kG
 JEYWXg2LzdVjaaTXlMPMs4ueg+kfia590qkIpjkjFLW8ezipS1WpJYDpvPsn7O4q+Iat
 VuYslDkGu2Pd8hGUH7+LvW/3scRETr/8dblN/cQrwJYcJiEIiBhCwfJAsSvu110qr5ia
 lVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782232317; x=1782837117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Bkg1PH6YnhDCkIr2vOAjI7aK6Ci1LtV9X7Yo2w00kA=;
 b=J/TWjaLHhOJsY+3hQ+rMhb9CeSWaFv8y60ta9aeebZSiDdJLyYv1cAV2lpPLvNtLT9
 KuZQyJlenJuaEkqiUcwxjg+YY6Vor/fvaR89qnQwbDH5Suzc9PVfCFOWTQ3XjYVKbhN0
 Uy4gSmxOpMnYZYKz2B73LX50yMvPuEU5WDFJxv6UlV8B98TVJuBhBGJxbLLpRpRvfb2z
 2jrxVdsmcDnZLaugFOcKJV96xueixXFwEHcFfWuJhwsrpPvBqfIb0olkOoZy/ku2K61v
 wHvh4jU/GnMNLi3CAH5eqefLPoTgoCP0lTd9CXIt7IL20m6p2EHjXhrhuSJXhkcs0VJe
 6Hlw==
X-Gm-Message-State: AOJu0YyGkZkBXvQ5UpGnMJnRl8gjgZwxcjHDZ5T1Ga/Vy970JuSvGyUi
 Ld5m3vepn01XEqlgni1csxFebqP4ce9EWpeUiU2Wb3nzvXUfJIsuACtUscjEZIaeFyo=
X-Gm-Gg: AfdE7cl3vLCoRL36urwtk+rYarzH2he0rcv9Z+qMFaIJB7FxzOQ2ygKtN+IPCoR44sd
 aWsObZDJ7KBqQFRanRWnWVlDsZeFhNABFI6332KHftcrJ8hgtbaGQ2Bh1D+hKkY2PzW8p/N5nkF
 DcGtpGVeaJdzv6WwbMHnhsltFGGGBxGvqAT28c3rkpFMHkaBFhi1aBeYJSoq1hxrq2HmMMx4LyT
 MPAPDyuIFJZEHyT2j5IJ+RVEYzwiS73zUyp3VLmgMWOlT/XLNv21dMHW6DfIf3JrbIrTgaSgBan
 P+J9jfMhHuSN1QiihoYhOB7U3bygpj+KHyX9B5bEilwH42MFTwq5pwE2ycLVDJhQ3O4rTwNSc57
 4f0V4E1HSp87BSyaDRXG+QQMNqhBWc3xB8JylVn5ewf+PeAMCkIOA+2ptXfLggSaWqwHfj4qRCg
 3BymXJ0TC82Xkj7c5zh3Nrg7UxJH6naJqEA7oi1cKfshWQ0WxmJ3eQxzo4Xwpbzmgw
X-Received: by 2002:a05:7300:641a:b0:307:d4e7:b177 with SMTP id
 5a478bee46e88-30c06e0cb8fmr14852114eec.16.1782232316929; 
 Tue, 23 Jun 2026 09:31:56 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c5c1056f8sm5236099eec.15.2026.06.23.09.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 09:30:47 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:30:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v9 07/21] net/txgbe: fix Tx desc free logic
Message-ID: <20260623093043.31f7a791@phoenix.local>
In-Reply-To: <20260622111111.21024-8-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-8-zaiyuwang@trustnetic.com>
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

On Mon, 22 Jun 2026 19:10:55 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
> index e2cd9b8841..d6efb3b8cc 100644
> --- a/drivers/net/txgbe/txgbe_rxtx.c
> +++ b/drivers/net/txgbe/txgbe_rxtx.c
> @@ -98,12 +98,11 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
>  		if (tx_last_dd >= txq->nb_tx_desc)
>  			tx_last_dd -= txq->nb_tx_desc;
>  
> -		volatile uint16_t head = (uint16_t)*txq->headwb_mem;
> +		uint32_t h = rte_atomic_load_explicit(txq->headwb_mem,
> +						      rte_memory_order_acquire);

This will fail build on clang since txq->headwb_mem is declared as volatile
not _Atomic type.

Please fix, and resubmit both patch series.
