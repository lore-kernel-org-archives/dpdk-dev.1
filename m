Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95BC36002
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Apr 2025 16:09:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BECE140270;
	Sun,  6 Apr 2025 18:08:59 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 435444026A
 for <dev@dpdk.org>; Sun,  6 Apr 2025 18:08:57 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so2497600b3a.3
 for <dev@dpdk.org>; Sun, 06 Apr 2025 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743955736;
 x=1744560536; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iNrjp+aFadP6HXHjq4mJDqsEj5Hg29WIgoZirAezKE=;
 b=xoDHKtjjIBuzWZaJ4WLzlF5IqL8u7D5+JpcvAP8pfVt/VepIIvlJirQ1F2sfMFTag9
 ssJQlnHS83vdegIPmo85o7ECqHk+Syc+Gc/Q84/OroPF+majvIyiDTdunWwqSE5NR2pT
 cXexJZwoV7X+xjrl5THs4ljgiNuxnzR1ti7IVHmIA4TYH5W4Imn8mc9+Imn+0gkOg/RG
 9O0nNfspzhmLYD/z61v+p5cDX00NVTla9O4eHCG4V/TBnglY7t5gzNiayoxniu9RiI0d
 t0BrmR4FbKbD+dzwCNkKh+Ft/NcYa278hiYY98Z0cwYgJofjRNeuHVFKU+bxjlzx4YzQ
 TbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743955736; x=1744560536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iNrjp+aFadP6HXHjq4mJDqsEj5Hg29WIgoZirAezKE=;
 b=tBQT2HzwPsYpCJ7bZ9iYMSaFSMgNlwAOk8h0AA1tyjddzh5sqWlCZWj6v5SJZZ/cTb
 aYEPv5F1gBn5zhwjEs7x3pvRUZqZavvHMxdKn9AWHPHsQKPlO1qJAG2djUGeeH3zCJbm
 iQ1xLZnC/XmHREpeWv5F48EWOJ4SKPlzP+ZcdF1mpR4x1d//ZKTK6qawsMHFTSV7FpCf
 oRqyDTv9gVZjmc5KKj/nqREFmAHk94oeQUXPQzj93rao7FlXvGdGGdDNWCMVCc+0WZph
 20TettLV165o6b8f1KMzfWdTuHtjhGXSSFTS47h27VzgCnMJrntgpbig2L5Y/c66Z7Ug
 kC4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuRBBw7KSIHPzomgUqMryxSd3HB/flpyX/ocmmeoUBv8PO4SCwFWKkpV8OivCd32PJQjg=@dpdk.org
X-Gm-Message-State: AOJu0Ywoqk+E9QszeyZIleUTaVnS1jpLsanfJAL412BUbJC41L7tgBgp
 HosTjX4fV8h9DSYibFQI31UgvIyV/mtbi0go9OVIyh8Pw1H72ENfbHvNbD5p1Oo=
X-Gm-Gg: ASbGncuMaYCXaAuI4DoZAkbrFLZ3F6kbEBjNbQ8kXAaqXDF4xO8pMejS71xIQHUjUH0
 7yfyBf0U/LiotewPsy197JHfTBHBzackWRtZtfDJoUplmcHFn09gQ2hWtOZHONl2FFRDy6opDMu
 7n/+qeRFn88yhch1MH0PR4PvTSgLKHMUDVpVUCBsXJDKxO2TRLqTdvQ74Cd6vV36oj8ebZs51zZ
 aTS+hGmnmyG1rMXStSnGCn9U0qqsxVJlTN6JkIz5J8jfir7OH9noK8F1uWfuTRi/cV+3xgLo2gE
 Qk0wvXeZJE36XsNw7F4wLIxZRa5yYgwUDWlT3L68K5lfKRChZtsOFFCigBlSfLPgZafQoh6CS49
 SGzJhAoWevDZCTR/IL5Ow
X-Google-Smtp-Source: AGHT+IFM1xsNWwS00k/g2Pe0Tu0zwoRk7tzSm+J23PV8l4YcDXRI/4nA5vk9ZQ6hm2+dGVR4Vl/vpw==
X-Received: by 2002:a05:6a20:9c8a:b0:1f5:6e00:14db with SMTP id
 adf61e73a8af0-20107efeef3mr14788430637.14.1743955736125; 
 Sun, 06 Apr 2025 09:08:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc32fb83sm4843572a12.31.2025.04.06.09.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 09:08:55 -0700 (PDT)
Date: Sun, 6 Apr 2025 09:08:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v3 6/6] bus/vmbus: set event for channel without
 monitoring support
Message-ID: <20250406090853.78499346@hermes.local>
In-Reply-To: <1743813338-28238-7-git-send-email-longli@linuxonhyperv.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
 <1743813338-28238-7-git-send-email-longli@linuxonhyperv.com>
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

On Fri,  4 Apr 2025 17:35:38 -0700
longli@linuxonhyperv.com wrote:

> diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
> index bccef168d3..81e8096190 100644
> --- a/drivers/bus/vmbus/vmbus_channel.c
> +++ b/drivers/bus/vmbus/vmbus_channel.c
> @@ -24,6 +24,19 @@ vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t) *addr, uint32_t mask)
>  	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst);
>  }
>  
> +static inline void
> +vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t relid)
> +{
> +	RTE_ATOMIC(uint32_t) *int_addr;
> +	uint32_t int_mask;
> +
> +	int_addr = (RTE_ATOMIC(uint32_t)*) (dev->int_page + relid / 32);
> +	int_mask = 1u << (relid % 32);
> +	vmbus_sync_set_bit(int_addr, int_mask);
> +
> +	vmbus_uio_irq_control(dev, 1);
> +}
> +

This part doesn't look right. RTE_ATOMIC() is just a macro to add the _Atomic attribute.

Can it be simplified like this?


static inline void
vmbus_sync_set_bit(RTE_ATOMIC(uint32_t *) addr, uint32_t mask)
{
	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst);
}

static inline void
vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t relid)
{
	RTE_ATOMIC(uint32_t *) int_addr;
	uint32_t int_mask;

	int_addr = dev->int_page + relid / 32;
	int_mask = 1u << (relid % 32);
	vmbus_sync_set_bit(int_addr, int_mask);

	vmbus_uio_irq_control(dev, 1);
}

