Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD8D30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39FD0402DE;
	Tue, 13 Jan 2026 21:04:33 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id BFD2B4028B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:04:31 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b871cfb49e6so417627266b.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768334671;
 x=1768939471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16WR6jQsdAXnx0viAH8STYqHBTM+GVmlayphAJqwpbA=;
 b=Ptyovu5aPSAw3/cx81hl52eOzImJmaUPrvMM0Bj2cEdNAWMhlIdzmjIs8VUAUPjIJt
 nka24IjdUAR6dymdT+jefV+LIlUaz34xj4svGrfHi4wt8xN74RzH3c0Yj0z6sPood+e6
 geAcNkJSc7/883r4ji8gZN/Ns3otNbWdeMR6ZhZ17fuxZw3bOfkTZZZ+7XXfuBf2oNX2
 to2Mv5OY6jSOPzL9TSDqmZBgYeQs17c47PXp4cPN+ygN+oyDVJLrmYzIp+In5YxxcTYO
 +bmm9CC2BO+7X9abPe4kTlDSfjBrk4PtgHYElnIDillpJVO4wXMi/qZEd10wCR8cHFGF
 UzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768334671; x=1768939471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=16WR6jQsdAXnx0viAH8STYqHBTM+GVmlayphAJqwpbA=;
 b=Wlu9sVlo0NexeCcVNXWOj9hGF/84IJ6k6YhnvP6++MIt54x2jEv1hDeySG7JuAiX8q
 1o8Wmn052QuELjuTid0jlxKACXO4fyG5YM8xhfPElEox9osQXAUSqbAf1s1eFayfwTut
 Y2+tFKJkPTiW7x5o7BuKHL5KV01hA6tpMpEQVzmsGPAZOhP5t13E0rGM/lE6IRpXID4V
 v2emzEfz3QMCi07mK0DvPOIN11u9SFWH1ngirtAf27zyIhdvYJCsZ34Eg5sOgciLEaSt
 yDdFXD963lw2lwcwwlFymNKy9uyJaBluUSus8rTtU+OXhTlI4Eqk0ukpZ4HVd+R5mTlQ
 kvWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5o0k0Z8gkGQjJQGE1Ajxo0IJHM5zwm7uF6hmmuEXYuv00573KfFJePToAgWYLfaRgdbI=@dpdk.org
X-Gm-Message-State: AOJu0YzImomGYOAjndadFILEBnv13Ip0GYdz8o9FbPDkY2AThwyw+yKv
 4VdU+5Jpb/qMm2Wuvz6pDfNfDAVaLR+9h35XLIuCfP1Lj7PmBU6QRC0veSzEP7wUnRI=
X-Gm-Gg: AY/fxX6Pd+hA1wEeMm/9oVywTDlRrSFmvdNUhTmsGpX/ys6BwMuJ9/8PUGYtmOdybC1
 ILybOR1zcICRFNKxOVVZJAY9unUTj3YziqfhbLEGSEcINTaXsnMFFCNcv48SqxPun0AsBmRkMMu
 JpUznSWmib3Ey3/JWcShn7wCYkybi5iWwzQ/I8YjnUZKSWFDHZDaC57u7wTSVbPRnJo574lQxEL
 u1xW1cCWB6k5qKWjk5xy0XDK6oAkPywYg+A1Vg+LgmECB8RQSnbmnAT7lr8r1zYcLbnd+t86Nef
 g9ZSbzPQU+bWkh4iMNkhnPkmj531a3cNl6syTxvxBjWXa0W+HKAdPZf7Col2LB9AblPPF73mFmw
 vwbFwkSbug1oEYBhC3OwAjBhgKroi3gP7WrliMB7snaQiEiAHmUwmPtCWEndUV2de05iTwQt3q3
 y7b8tK3ABub2oC/4m7u8e4hc7E7L7MseyStefHWJCGtmvaA1DUvzJJ
X-Received: by 2002:a17:906:6a14:b0:b80:402e:6e77 with SMTP id
 a640c23a62f3a-b87612b7004mr29814366b.54.1768334671153; 
 Tue, 13 Jan 2026 12:04:31 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f1e95273sm1065890466b.62.2026.01.13.12.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:04:30 -0800 (PST)
Date: Tue, 13 Jan 2026 12:04:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenwu Ma <wenwux.ma@intel.com>
Cc: ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 amitprakashs@marvell.com, abhinandan.gujjar@intel.com, dev@dpdk.org,
 stable@dpdk.org, tingtingx.liao@intel.com
Subject: Re: [PATCH 3/3] eventdev: fix uninitialized variable
Message-ID: <20260113120425.273056ff@phoenix.local>
In-Reply-To: <20241125064755.3943-4-wenwux.ma@intel.com>
References: <20241125064755.3943-1-wenwux.ma@intel.com>
 <20241125064755.3943-4-wenwux.ma@intel.com>
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

On Mon, 25 Nov 2024 14:47:55 +0800
Wenwu Ma <wenwux.ma@intel.com> wrote:

> This patch fixes the variable 'events' may be used uninitialized.
> 
> Fixes: 3c89e8c42022 ("eventdev/dma: support adapter service function")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Wenwu Ma <wenwux.ma@intel.com>
> ---
>  lib/eventdev/rte_event_dma_adapter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
> index ff2bc408c1..3c05fb615f 100644
> --- a/lib/eventdev/rte_event_dma_adapter.c
> +++ b/lib/eventdev/rte_event_dma_adapter.c
> @@ -655,6 +655,7 @@ edma_ops_enqueue_burst(struct event_dma_adapter *adapter, struct rte_event_dma_a
>  	nb_ev = 0;
>  	retry = 0;
>  	nb_enqueued = 0;
> +	memset(events, 0, sizeof(events));
>  	num = RTE_MIN(num, DMA_BATCH_SIZE);
>  	for (i = 0; i < num; i++) {
>  		struct rte_event *ev = &events[nb_ev++];


This shows that what every tool you are using to detect these errors is broken.
The loop here is setting the appropriate events.
Each event has two unions 64 bit words. Both of them are being set.
I can't see any unitialized data and neither does standard compiler.

