Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5159C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B46B140615;
	Mon, 10 Feb 2025 19:24:25 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 5934E4065D
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:24 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fa5af6d743so2824240a91.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211863;
 x=1739816663; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLvUFSbjakCcPBXXQs/Enk4jKiQGmBuZ3+h/2VRsKLI=;
 b=qEUibpUTG6VVa5Kk7dyrD0vQgknH+/YvJ/4ZrMFx+o0PW4d9lVgfM2P8TewrDQxJYx
 dRBlM/Cc3XedCvz5/3Vdwm29jJx5iZIUlGxQ5CX4B6gcyq9dQAxmKBOM56eDZNQoxaNt
 eVC3jkdU/U0KBUfx74QvN9BtlfgbyZSuWYxI3IQydzkNNjE/7eM4jLjsMjpmmjatoX1z
 KTT4PFaWU4NjDt94qNer4LCUTwB3vGWIX+TJVup9m4ebVHofq7ID58PaW/1X/i/v8bAc
 l0LQseD0xtEKnM7iydu3H/+QV350zwAkSDlcWjP1L9FB5N7xjC7yMKRQ8ekVtyxAXR7M
 L80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211863; x=1739816663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLvUFSbjakCcPBXXQs/Enk4jKiQGmBuZ3+h/2VRsKLI=;
 b=eclSKmlqkruAGG98e+2YEK928LhW2ioqCnSLyKp8G2c6mYBMk5Sq/aMjz/NBKWwgUn
 s2zaqtshIT756Hquv56BWVG/mY0JcZiTQTQsGNYy/367landoIFdnBmr2b5rE/GlU6i+
 xYBloas3ZCcgk/woaonvM1FVSP7w4L6i7L6Up8KQ7mIHtUqyySr8TljPOiAQcbRFgkfG
 +IbTCzypub/R1WvvaLPmL1mU1qZDKELoR1haO9WaAdR3PxpS5uWlUQHr8V+Akf3JgL5M
 US8Vbab8lBPPzcVA/ledSy79RyE2dUWwGHrWHjMqyxESB741INimM0+1OQPbIXqacZyn
 52hA==
X-Gm-Message-State: AOJu0YyjRJDn0uY6snQ1745E0iHr0Ftaa7miFEMa4ofZfs8ltdpNNeeT
 nKKE2WdglxvKYq0wd3Ykflw2YjJUCFmX+ot5p3dyLfuX5Py/2q2MsZF7xzad5mpx+c2DzUWLxgB
 N
X-Gm-Gg: ASbGncumBD3NLQFB9JVXFI5s93RTrsd9FeIJSdCNwVsHOJT5Ztl4v6jDPAGthp/EjnA
 obBhTq7gR0Vh29myP5VHB/Gs3xdx0+Oz4vJr5Kn4Wk5v+mlDZK/ZJbByhrMeVyUpHOnZmrw1wex
 hltLV7i5OnrawrV8rWLxctOVb2F7dx1nOvmRJCdBbVFO5nsTK5YjbgDxPtTkdX6/pweVihO4fed
 B4Z06Zc2V2wQQl05PG0Srk57YrGSzUNBwCXxOu/anGxxN6ooe+lFUgZRYSyHoGrx1HL9zCo43z1
 VFyZnqzP2UrktGAl/YD/RstJDJcUOFid92VTMnxClgdPRtHAYihjD1YMlSif7xDAjFtA
X-Google-Smtp-Source: AGHT+IEhs8xzMfwnAtjJV4Sl+yuW6FDDprONqjn9lKWiSBF4JwLN5wm3/N0x4cqOtRUNLZlAdSAJfw==
X-Received: by 2002:a17:90b:4b8c:b0:2ee:c91a:ad05 with SMTP id
 98e67ed59e1d1-2fa23f41ddcmr19463317a91.3.1739211863555; 
 Mon, 10 Feb 2025 10:24:23 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:23 -0800 (PST)
Date: Mon, 10 Feb 2025 09:31:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 03/14] net/zxdh: add agent channel
Message-ID: <20250210093113.381466c3@hermes.local>
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

> +
> +	switch (type) {
> +	case ZXDH_DEV_MUTEX_T_DTB:
> +	{
> +		*p_mutex_out = &p_dev_info->dtb_mutex;
> +	}
> +	break;
> +
> +	default:
> +	{
> +		PMD_DRV_LOG(ERR, "mutex type is invalid!");
> +		return ZXDH_ERR;
> +	}
> +	}
> +

Why all the extra { } here?
