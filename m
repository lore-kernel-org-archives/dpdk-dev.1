Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54494FEA800
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 03:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5035C40DCE;
	Thu, 26 Mar 2026 04:28:05 +0100 (CET)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 35278402C4
 for <dev@dpdk.org>; Thu, 26 Mar 2026 04:28:03 +0100 (CET)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2c160308a54so1297920eec.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774495682;
 x=1775100482; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=km0s8Pl5bdFjT0J9YpOX/Eh5GF2iytr6UJ5p5B3KlT0=;
 b=O3TLiE/P6mSOtdNMm3mtSaEeslNaQkVOUjybHUtkS9eTghCyYwSK5zmRk5dU1NFSw6
 u5dKF3NKg1UIKxzAP9JNbglCPXzp/h0uf6Sqt6SdNG33OgJmVmY3K/KPx9vyH0h2B3qg
 m+Ap1oRIFvkfPVdT25TxUPBo4vEugES4JgzlvyU92sJnk8EyNm5gvpvt6UOoAy9dtuaV
 QZn3m0/uOs75lV8c57e4mEVnLzxlaqz9rLOtcWd31CQN/1mf8jr4uHdifolda007+Oxk
 rz1UGtnKnOdZnna2FY767YtKPQmOefAUODYnLBtdd8/HrUHPoaS1wOR637aNRU16EM4d
 NKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774495682; x=1775100482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=km0s8Pl5bdFjT0J9YpOX/Eh5GF2iytr6UJ5p5B3KlT0=;
 b=OalRvrf5EOO9f6OCcTlqnt1yzrxuvA02YMiA/O66RfINHBNygdgolydVR7EstuzdF4
 Ec1eKhsGDHg0Y9vxO0oWNwmnNQX/rYBIvSUdYQoUGm2mHcv19NQ3isO0dU+OvVIB06Hr
 mQuuoKxhohHKxbMfhbSgfFVm8GOt7fdinjciWWSFNcrlFGV7xGxNhEdqVJzMSHXZQUOQ
 1kSlCOCm5/xSOsp5vXxW1rVQzeRgH+rhi4r2BS0I+hz/mQFWrpE5vza+sYc5FIxuWA8x
 Qi98Yko1WEERo7lkdAVLu9un8tP0/n26Ut8jse6CPn8QG3/+ig4k+Sy49Y0zC+Xxhr8Y
 CJ1Q==
X-Gm-Message-State: AOJu0YyrbxEBqRwl0yVz0CSs5PFJRjJypIC8szryFafgF2HlenerWJPQ
 kmpcrgF48gCodcFmXSl/FCM2LRusdtYQbvUGy9/AirOG/hxf6MW+Z9URobWSZhD5KKk=
X-Gm-Gg: ATEYQzxGOM5ST+yqH2sWoE5oqOtL9gtJPaJ6dNJjz7QVcqpCfB8xHy+xootH+wQnhGv
 3AJjY+iZIaCJr6fFjtAGk6066AnIBiGuFbsnie64OiASrAQc0lYDIpMSc31CbfNv3i1w+RQGPA2
 g3uNc98KCwIJFqqX4Pm5f69cRXf/fdgABsPgIxemAipGrgZeNi/FI3odv7YGoYd+7i6nYUBkw18
 OUg3YnZmUVasSlsADxCbciruYi0bKPJpENy0E2WfkqwDJ2Y7tXkuLYeowiyoY8YhC1ZrlezseqX
 te603RLEbYN7PiGR/MyfNSO+3R0Jkyog7NldJn+AhgennMiybAlPq93SE1y46i86lJHMAcYtRi8
 SFAfmBpiXFuzVjwDZs3KSeMG4SBJjQS3ei5jxRcXJ/hpXj2fWHhC99RfQLpBQ6+SENkdyhpTEtr
 /Yn8k7qBsp8GvU6h1LQI/m33saroYB5EEdSOw=
X-Received: by 2002:a05:7300:ed18:b0:2a4:3593:645b with SMTP id
 5a478bee46e88-2c15d290e90mr3296392eec.11.1774495681995; 
 Wed, 25 Mar 2026 20:28:01 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ec495b8sm1462055eec.10.2026.03.25.20.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 20:28:01 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:27:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260325202759.301e70b3@phoenix.local>
In-Reply-To: <20260326022828.998541-1-wang.junlong1@zte.com.cn>
References: <20260326022828.998541-1-wang.junlong1@zte.com.cn>
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

On Thu, 26 Mar 2026 10:28:28 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> This patch optimizes the ZXDH PMD's receive and transmit path for better
> performance through several improvements:
> 
> - Add simple TX/RX burst functions (zxdh_xmit_pkts_simple and
>   zxdh_recv_single_pkts) for single-segment packet scenarios.
> - Remove RX software ring (sw_ring) to reduce memory allocation and
>   copy.
> - Optimize descriptor management with prefetching and simplified
>   cleanup.
> - Reorganize structure fields for better cache locality.
> 
> These changes reduce CPU cycles and memory bandwidth consumption,
> resulting in improved packet processing throughput.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---

Two late for new features in 26.03, will look at it for 26.07
