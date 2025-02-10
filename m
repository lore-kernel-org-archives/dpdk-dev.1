Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41605C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3103940662;
	Mon, 10 Feb 2025 19:24:52 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id CC8B3402E8
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:50 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so7263335a91.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211890;
 x=1739816690; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmnvdZEk8INNTxG3oDj8q9YRQ7YajDItl1znlC7Nqmo=;
 b=eBmFkxM7hldtrDEgId8B2g7Q11IQuhDzgiC8L/FWnD3MbiUUnVxeoF7oBhXnAIhthc
 U9z7UjEktyEDCa3Ys/Gx0ADLr6AapYRUxVFo9G9WxbyhHT8JobUK8fv6sr6oUYHm3hRo
 Og1VJrKznnj+7IQGpIM1aFZmmNDBHyB/Js50SizGJBEKvxxQqx3DKGEdB4j7ZEgDMmmA
 onaeON6onFnk+CpTAqMnSc/DtqU8PQqm/TZAEPwx/jAJWpP8OeKWNcwLXO/7WQ/sxFNb
 Se9TnB6amdMlmfgIbbnpxvnhARW+CedXmka51AIgeJKz6cJpJ/4WxQIl3Z6DpLChBx+K
 GZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211890; x=1739816690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmnvdZEk8INNTxG3oDj8q9YRQ7YajDItl1znlC7Nqmo=;
 b=mymTgFrdmCwNCQLlAi42545LmCPon92MbyB6Da96JtC84ekzdpxKO9vr/0Q+wnonq4
 cyONJlIeYhgyogSL8lP3+AY6EvPaWe4orKOHV3gveIKcqTE1Xfw+6QVex8ApGOrGEA0R
 ZUICofJn6KmHrSf00pphU3gZGWn2zi6Nf+ST3IdFetyEiCGYOIkv4dcHGFHdor+4+Uhh
 5rZp0iJdrQiiZPnmhTqvL50ZQPSbUwpU0ZZVRzAG7w08muKPGfWH+T7y8RAMPXCGTlFL
 J4Tbh7eBx+e+ihZDFwxUmUG35IKwDvPQGayoBfuJM7zFGcfEZ32eK7n1GUQnoB8Wd1iQ
 1bCQ==
X-Gm-Message-State: AOJu0Yw3V3uYyvx9d/tQ3wtatmDs3YUPVkW/fkqLrmL32H1RLrvYS1/e
 cNG6ZsfnkChsdoDkqsH9YHf9r7R2I91otosy+ZgSMJZr/NfBtsnxWyg7plupEYU=
X-Gm-Gg: ASbGnctS8y3sIAu0wfSxvtxrNLeNWrdbk9uo916P6WFctSCNwlaJwQvgDgSf5l1u9o0
 +RgGBokbeoZk1czLL3geCZta4GXPUxDZvvkZBX+Rglwas6Z468oiUaYARePOZdP5O2XuUsyqDnd
 WCIaJKtIvSgzxcYWxaxm3R4QFZc2FA1As9KyBk+C9nLW7po4paHe+On4GuC6uQ5imwzoocIDA09
 sj6ZLMYGiJTBJ326j7u3Xi0Iw0n9g1y0zy61SSco16svVzm0op0MtLZ/oKFAE5nIhSgLoLvKEn7
 ZC2sx0fa7JkbNouq/8hPiYmVXg6Hx4009Ogh1fWp2gdarzwAB9g0oxBvKNRQZt5RFa5d
X-Google-Smtp-Source: AGHT+IFLB2BpOyu9q8ycyZuDXxIFMAwIYIfF/5SKQIaX4o8jw35MOWvVuI5nrMIk1hiFInvzA7yIcA==
X-Received: by 2002:a17:90a:da87:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2fa240634ecmr22272102a91.8.1739211889884; 
 Mon, 10 Feb 2025 10:24:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:49 -0800 (PST)
Date: Mon, 10 Feb 2025 09:43:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 09/14] net/zxdh: implement tables initialization
Message-ID: <20250210094350.66a8c42f@hermes.local>
In-Reply-To: <20250210015017.4105624-4-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-4-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:12 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint32_t
> +zxdh_np_sdt_mgr_sdt_item_add(uint32_t dev_id, uint32_t sdt_no,
> +		uint32_t sdt_hig32, uint32_t sdt_low32)
> +{
> +	ZXDH_SDT_SOFT_TABLE_T *p_sdt_soft_tbl = NULL;
> +	ZXDH_SDT_ITEM_T *p_sdt_item = NULL;
> +
> +	p_sdt_soft_tbl = ZXDH_SDT_SOFT_TBL_GET(dev_id);
> +
> +	if (p_sdt_soft_tbl == NULL) {
> +		PMD_DRV_LOG(ERR, "Error: %s soft sdt table not Init!", __func__);
> +		RTE_ASSERT(0);
> +		return ZXDH_RC_TABLE_SDT_MGR_INVALID;
> +	}
> +
> +	if (dev_id != p_sdt_soft_tbl->device_id) {
> +		PMD_DRV_LOG(ERR,
> +		"Error: %s soft sdt table Item Invalid!", __func__);
> +		RTE_ASSERT(0);
> +		return ZXDH_RC_TABLE_PARA_INVALID;
> +	}
> +
> +	p_sdt_item = &p_sdt_soft_tbl->sdt_array[sdt_no];
> +	p_sdt_item->valid = ZXDH_SDT_VALID;
> +	p_sdt_item->table_cfg[0] = sdt_hig32;
> +	p_sdt_item->table_cfg[1] = sdt_low32;
> +
> +	PMD_DRV_LOG(DEBUG, "%s 0x%08x 0x%08x", __func__,
> +		p_sdt_item->table_cfg[0], p_sdt_item->table_cfg[1]);

Duplication here.

define PMD_DRV_LOG(level, ...) \
	RTE_LOG_LINE_PREFIX(level, ZXDH_DRIVER, "%s(): ", __func__, __VA_ARGS__)
