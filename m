Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C8DC0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CFF040A75;
	Mon, 10 Feb 2025 19:24:50 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 759B940A73
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:48 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fa286ea7e8so4906958a91.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211887;
 x=1739816687; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5zGxZZGUgKFH1ppgDNfX8X7dALNQYCyqpC9+x+u174=;
 b=0kGUZIsI2g9jdHXwS/jxWvowRkF56yQ0jsmJYD5zR3Up4CgoRBEBNEKwpv6iKd7+G/
 kVVhPJo3UbN/6eGbKLjRbrqeUYhDnKF+yxjbxWnRMHL800mb/Wg7/AImL/pduerpfHmL
 hC+bT4inzp5/7kHiRlrVUj6Sn6cRv5nl3SMKnwMoYbw2V9XqSxrmvsKTGIaCmOIqRtZr
 tzJmGTeqt010AA4p1BI26gwQ4xXE3PGJExDRDlwR5QayuX9wAb1LwPWEgbSkJGh+fpRr
 wLMcyKm6t9OfQbNzNFOhPfGlh9R5zQmeIEjw5Hoxf3nH9fFG0HXaWMx1TdnORZeNr3/V
 UVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211887; x=1739816687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5zGxZZGUgKFH1ppgDNfX8X7dALNQYCyqpC9+x+u174=;
 b=e8YS3gk2gkIxIbKHcfgJkMeL0/txMsEwVM7NdFRSV8S8sQBr7dHKa/j0aY+bZeMAnM
 KKkiCvcZqNdBMsUmzsbxWVv+AvmFxpX3ggFO/xDrOtvTNECEKoWJXY6eiUWxst54CiZ0
 5EInolGT3x/uqbbULZw+RRNIfv0iRtA2lMPosvUId0Tnf5tJZ+3/6bJ9BaNioXCoYyYH
 jylMGJdEK3zC465eRwBRXst0PS24NdalqhfU25xh4xhL/1b22rrCo/j0uy75G1PFReNe
 W8kIFGrer0hLbNGCkyjYl0UYWgXOixN63sH9pqFEJzp8zOz6V39bv5RVNcdzaQtyJu1C
 NZkg==
X-Gm-Message-State: AOJu0YyRu7DgsLlpMh/fqb9Sb8t4iNeDf5Ox7qW3c4ut5QLnWoRSsf9C
 5WlXT9rEquWG2kTeOcdw3KURoftsynL8aD6mlaBMV21EdYWnZzCgiv4MsxnjG4w=
X-Gm-Gg: ASbGncvT2WPj8TdrBaQgBaHaxNc0dP1Ex0g4iaK8lfmxDLsF7KcDNrBBOt42q92+Bb+
 sKSI/E+4B1LvRxxdDbuLcrQs7zS2I2yW3F0WBPsiwjxvGgK4y+/Wo3ZCoHQlsSgcXTb+zYhmEFz
 a6pe9DcWBB9aGAoT+i9v8W9vDM4hIwSkrm06YbsTXFMj8tOJ/TSbIdz5/wB4Hby+9/2nS1ehKq8
 CEMpZqrGlwqzZLjdDknFyzSbAJP0eD7Eu26FfP9n5OaTe5KOEJ3sWl8nhwxQcyBhCJg5WYYnuY9
 ETM57cxR93IEnCBxyAEemf7c7JDzzHrxYypkvDlMDsrkrJienPb8l1lE1DjADakerb+0
X-Google-Smtp-Source: AGHT+IHPJUZjopyOseIt/x8kdIraXqRBz6xdbyY/rWhUBhjFp6KaRJsAoZ3tml2tDUXVL14vPsKWrw==
X-Received: by 2002:a17:90b:3d03:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-2fa23f42672mr23164052a91.2.1739211887657; 
 Mon, 10 Feb 2025 10:24:47 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:47 -0800 (PST)
Date: Mon, 10 Feb 2025 09:35:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 07/14] net/zxdh: get flow tables resources
Message-ID: <20250210093557.40080e54@hermes.local>
In-Reply-To: <20250210015017.4105624-2-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-2-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:10 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint32_t
> +zxdh_np_get_se_buff_size(uint32_t opr)
> +{
> +	uint32_t buff_size = 0;
> +
> +	switch (opr) {
> +	case ZXDH_HASH_FUNC_BULK_REQ:
> +	{
> +		buff_size = sizeof(ZXDH_NP_SE_HASH_FUNC_BULK_T);
> +		break;
> +	}

C does not require each case to have { }
