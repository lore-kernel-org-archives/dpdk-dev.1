Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB75C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D56040612;
	Mon, 10 Feb 2025 19:24:59 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 30D2F40B99
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:57 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2fa2c1ab145so5881349a91.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211896;
 x=1739816696; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ak7TQxXVBfPJuHoyIQ3zDyIGWLtdjH7hMT1Ki1EQDA=;
 b=H9kBXEeyfYlEmJlYSo9Wc/pMWDIKepeIWvPfYj9nQ0jX+atEIoFXJ5PRWWHtQdltpi
 N6fmbmVrmenBRqZoN5AtjYegJyej/s4TeIpbNEXthRtUzwwug1tvSEXCD3QU6x2jRo4r
 ecHtokwG0ax+0eERvUeOeXLdXOMZE8o7+XDgDqlOq7nM+6+OC8O6x69hK17B1dyAkhdI
 f+2hxXvaeDr5Y8Mf2rLIxeti/gpfpyNJE7vL/SbvFt+gaDr06e8u1vuPqG30Y3XfQ19T
 9ZIuEYjNh8UJfmi2HOjhdWYQ+t5551BQQIaX8gnPZJdtdnVpPmIMWZiMkw1FoS4mS5/Q
 fvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211896; x=1739816696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Ak7TQxXVBfPJuHoyIQ3zDyIGWLtdjH7hMT1Ki1EQDA=;
 b=rK+mNxbFENupYXkjVHaWGJafv4FWps+9Yz2YMBV4GQCdcRHrXFpGc/5g/OoDG8FVSD
 y4L9xsFP3Gs9W9Oj+1A2po8BEiogCed3gESV62sVJjAXZHglA4U+bCJONQ/JBIgza0P0
 FZVEJJ/k7HexlYgxAl/CV3DVLkpjoShnDQzX352OFjZm7WlnvhIsPAPUq+h8yF7hrGfB
 aYpqqquq9MqHVqWrPLyJ8yoOXmgAPcP4tit6Ss2NM83xZ6JqMVDHF12Czkvq9cuCJCTY
 vcLL0CZrPSg2X2eJnhDecy5G3ATXrd3uJkZ1ixHbkiyXVAwainG3jdcvPQ73w3AEYpVE
 TlcA==
X-Gm-Message-State: AOJu0YxPWe8QkFRukfFU+oAEG+djdb7Fb7xYzMpj2ASybd5Lq25gevRU
 j5cU1kiTdFg2A0LnyqIYQHk0v9wOT7TTitcUMjGkk2Mfs2Onnr/4luLJPDz+Yuc=
X-Gm-Gg: ASbGnctCzwlmfH7e4GLlASGTW9UPwyy673WWdA1i6AjgUeeTzyS/O17Ek18vlbf00NA
 UKcQAnao4OqA6/fJ7yz4fEPXWG4wsLc/vTefbB9zBgOmrdc4SInr6W5/GyMXA4ATWIVTr7L1SaT
 K48hwmNB9Pjaclh2u6EtJh2PedL5nisM2W8NrnzjpdVZndfVR4v6pDnSbEbc98COhveFdO235Wv
 KhghZxHPOo0mlYDG4I3daQRIrZ75TrrxRsQ8IorNFh0zFpRg1j5R7d/CBJTiPmpEa/6wteNZik1
 0P9Wu7SKIfoX8QzWYb57inwl5bWuCU8B+1fDfvyGvYiZyLMOWkqC4zgNp7T2CGBJbQhy
X-Google-Smtp-Source: AGHT+IFQHVrXd5qb5EwkNfxBtfk6TCN07X0DggTOhSVxnPRgH7aPwZQ79LW/ORlrHw7mjRsgXKwOyQ==
X-Received: by 2002:a17:90b:4f90:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2fa243f0351mr23249636a91.24.1739211896375; 
 Mon, 10 Feb 2025 10:24:56 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:55 -0800 (PST)
Date: Mon, 10 Feb 2025 09:30:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 03/14] net/zxdh: add agent channel
Message-ID: <20250210093047.25e89f83@hermes.local>
In-Reply-To: <20250210014702.4105460-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210014702.4105460-1-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:47:02 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

>  
> +#define ZXDH_COMM_CHECK_DEV_RC_UNLOCK(dev_id, rc, becall, mutex)\
> +do {\
> +	uint32_t temp_rc = rc;\
> +	if ((temp_rc) != ZXDH_OK) {\
> +		PMD_DRV_LOG(ERR, "ZXDH %s:%d [ErrorCode:0x%x]!-- %s"\
> +			"Call %s Fail!", __FILE__, __LINE__, temp_rc, __func__, becall);\
> +		if (zxdh_np_comm_mutex_unlock(mutex) != 0) {   \
> +			PMD_DRV_LOG(ERR, "File: [%s], Function:[%s], Line:%u mutex"\
> +				"unlock failed!-->Return ERROR",\
> +				__FILE__, __func__, __LINE__);\
> +		}   \
> +		RTE_ASSERT(0);\
> +	} \
> +} while (0)

Way to verbose and messy.

1. Your wrapper functions already log on error.
2. The messages are broken across lines and don't give any more information, just more words
3. The file and line is already logged by the PMD_DRV_LOG
4. RTE_ASSERT() is ignored unless RTE_ASSERT_DEBUG is enabled, and in that case it panics.

