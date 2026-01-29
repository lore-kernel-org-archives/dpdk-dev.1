Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF6D46C01
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:52:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5B364026F;
	Thu, 29 Jan 2026 02:52:05 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id B34F74026A
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:52:04 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so3310095e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651524;
 x=1770256324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQbsXbj7lZzXuQnYiydHn4wl4TnlnCSpRY29C5DV7ME=;
 b=KUeY57XfZZ2bZLksJOY6l+bPvpomLtYuaprzDAZKXbl56LNQbVGU75+WLN3fXMBHUN
 23PRuROUrArzcfp/J6i/+BTRgs8nHQ/ulfwrK4/8tg1FrNmiXl7/20lvKsuzWSScyzis
 fTl8jRpXbeuN+3Xf1n5KyYG6tMi0zRgsppKQq6uHhrCjSg1dH1lhKJVtIUgBjxuGejwl
 LRt9RHYUhSIBwnWpG1a78UBxn9EkL3Gj74kC6snr44ukZPt5TMKr7dJ5ufBj0Gb4tjOi
 cdsRnbaJZfdxxw3h36b9NySSO3gos6eJ6EOF+0D1I0krG2tJ1O2W6n3tPKOxg0d6ucGx
 UIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651524; x=1770256324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQbsXbj7lZzXuQnYiydHn4wl4TnlnCSpRY29C5DV7ME=;
 b=XzTQtVs5YsrHHmMuLe65zEnuIoUD6RGnpWkKfSFWwmuE38yTBlNkyAWWfxYOKTj747
 NWWOa29ZtETZ4aH/3qMw7FNv7ong/YLmLPhh6N0ZlS1mlX0RRLful8m2D6syCQYNxb3z
 s8Dbgfh6OCRpVrsRbSlFHlchRedTYCXG7ACRBl8MQUvfNlAJD5366HsSQCZuQ1Cuwt2z
 8CsS5cZj10D6gdTExCZH0Nuf734RRKxHDzHCw2HjSFqi6f7aCRyOyCVSwvDLv6ZL7EEZ
 CFhblyCpgg5afr94JWOKkyyDO9vyLEKPsdSUFSjSFqfO5TL9N/mvIodRx67Gn457QGku
 ttlw==
X-Gm-Message-State: AOJu0YwbvDnor09hiFUWPAuS1P2JT9DlPNbldCYLxkr29RZoffovqtSj
 AV2paYoa5wYt+Lr+q4Ebvr+RFt8wFZkGSyM2tPbpTl3pnSUZHr6ka3UJfSK8OLunHUI=
X-Gm-Gg: AZuq6aJGAU92yh3bu+nO2Hpo8LaITyMndr01NgdDrc+pFvK2DyKNxLyQ5xCJRQ6U3/s
 LAKyFXk6I6BNcGeywCbz7ONi5JqX+suoD45mgwIoNJPwRxwQzlZdpohBr9cWwVntAfdb+OZcYxp
 yknY+7bEqGs9hhlz2gnHEhU1D0AuAbd8Oix7eTzTCFbjBqudrGqhIDSqpZnRxkQtVa30nSZKK33
 3kQxJIaJHek+bmrMzU9vd/DKvVFOVUoCsgDEWthiY9VeK6GtZi2yLh8WM01pfwx+QZDKJGCU9ll
 DVvgJ8jthlqmDhsUjfuBtYa81tvQ4d0NJJyBnBpSlz3kT5F2EgMj9NjkwNr+T2VL+fLKl3m1xoG
 6bUai4ST/GaFc8zXDxKhSdTwp/pXWOtCRirCV0IE+727yDTSv2tsDCyGCqt4blCIl9W6GDIvAAb
 k/9VhW071QTN2KmpjtwyfbZSZceCnb3ZmA8AcX9ha/LLgKnM5qOyxx
X-Received: by 2002:a05:600c:4f95:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-48069c66b3bmr87082805e9.27.1769651524348; 
 Wed, 28 Jan 2026 17:52:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5d3164fsm3686395e9.4.2026.01.28.17.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:52:04 -0800 (PST)
Date: Wed, 28 Jan 2026 17:51:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cliff Burdick <cburdick@nvidia.com>
Cc: <dev@dpdk.org>, <anatoly.burakov@intel.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH 2/2] common/mlx5: support dmabuf
Message-ID: <20260128175157.15169b10@phoenix.local>
In-Reply-To: <20260127174429.1504288-3-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
 <20260127174429.1504288-3-cburdick@nvidia.com>
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

On Tue, 27 Jan 2026 17:44:09 +0000
Cliff Burdick <cburdick@nvidia.com> wrote:

> +static struct ibv_mr *
> +mlx5_glue_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
> +			uint64_t iova, int fd, int access)
> +{
> +#ifdef HAVE_IBV_REG_DMABUF_MR
> +	return ibv_reg_dmabuf_mr(pd, offset, length, iova, fd, access);
> +#else
> +	(void)pd;
> +	(void)offset;
> +	(void)length;
> +	(void)iova;
> +	(void)fd;
> +	(void)access;
> +	errno = ENOTSUP;
> +	return NULL;
> +#endif
> +}

I would prefer the callback hook did not exist (was NULL)
if you don't have your #ifdef.

The (void) change looks messy and better handled by caller.
