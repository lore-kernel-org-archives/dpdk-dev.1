Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94060FD8FF5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 18:51:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C718402ED;
	Thu, 26 Feb 2026 19:51:19 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id D96E94027F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 19:51:17 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-896f4627dffso19064646d6.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772131877;
 x=1772736677; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vk9sisQ76Jdd9HrhfsP9tw8Zouxx0exk3uCTXL+/Fc=;
 b=VnMTfRA1Jy53oR2CpkT7pt+dt6tB4S/E37nFgJNfIsnnRisrwjn2IiNt/SUsjr5Fhy
 JFc4DklqKp7RMjr+2JPcZIS+nCpt7oeQw0bNkI83YctJITlmyszxaDYbzZOpiaPL5Dqv
 af/IbLwH9w2fQtwg0zbGzHuZC4yCm9hLKDxGqBrFsOsbU6GieoHMctvjmDf7Txf6bso9
 PMSBCZI97wfpqr5bFilv6E2/VMdNeKO+VWX6Gh7It9dvHwKR9RhO1yTbHZKqlTSVrS4i
 TmYhT/E4JNJ6btdyMLsve7f97bIe0Vj8FH9rsM3P+cj4yM1YlKh/UEeY2tOyS9KYFcOw
 A9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772131877; x=1772736677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vk9sisQ76Jdd9HrhfsP9tw8Zouxx0exk3uCTXL+/Fc=;
 b=Sg0EjtESdQE3P3ACUMLF7FdS4ZL63wV1TbaQgQl7KCQZWSo/Qb0+SHxtXdp4uHWkRz
 N1QjFYl2nKbSqc5lMKUjfrvb+vyLTWwr1DMQNCbugIdZ5grZIFhzJGDpORglpuVZbrsJ
 1Up5F9csMGxb9tZPlxdul0HGltYCpU0zWiPqTRn0eOApgvptWEIw2/qIFjn8/wUCPAKh
 GZpQKPQ5OAFdJB/GhEzqPLvztqapNcYoGPl2zrWe0DEp+qniL2bmCFsji3eBtpY6du9J
 OgWDF1Yxjj70gk3i4rlpObE2eSWtfDWy8R8Qmd0Y1UDjcRkQkBdRKbBzfHi6FCAgy4jE
 AWUQ==
X-Gm-Message-State: AOJu0Yy5bMudWIZepv4MVoRDCsIWGBzBsq5Gaegkb/ctX18KIS6PnR4k
 ubAGMQIXqwWUIKO5g0kUhDOVVOZFUZmwj51t8GZ4tAFoJ1JmSoJXOqWinfI7z9fNZGE=
X-Gm-Gg: ATEYQzylcl6DcsQrG7UKMa0vVo1Ttt+dTdHgyvn0jRjgE+a3vhOShAlk6aksfEmKXYA
 pdfZPzr666pjo2vDwmB7xgeW2Ws7KI/GOhAVG13QrRWBk5b3zPvdmzd5xpxYigjYm/X36d1chkR
 ogD9ssjCgrSEKXGIVedSuGvjrszSd5iBhIWrH9GWPd7lTdrjkrUiNkDIh6UYCHfaY+IHRrSp3Bh
 kRHNTPvyG8hw4DtHAca1oR60C132VSeryVBDrZNGL1ARiwyCxbla/6CazaJPm0/uAP/ATM+y/Ki
 byK9h4+KLepSJhyis9vDBvO0Yfgw6gbksi63EUrTtVNtoxgEE7skq/TfKmOctCsyIMrM6uEv4vC
 ADU5lM4RNrq9CSYcE994Je8/h7EEw0A9EuMzbVfla1Kp94EL3WHYdiR1n1VEbaQ3yc0/LY3cdon
 vEzZKlkfy6zdaI6D6K3jJh3yckNUhKPedzhQ0Odw2rYJUoN+pQ3a05qqUQ+hgyrS25HWXY7f4B0
 ec=
X-Received: by 2002:a05:6214:1c4a:b0:884:6f86:e06e with SMTP id
 6a1803df08f44-899d1da5f4cmr1925326d6.16.1772131876880; 
 Thu, 26 Feb 2026 10:51:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf732bc1sm268524185a.46.2026.02.26.10.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:51:16 -0800 (PST)
Date: Thu, 26 Feb 2026 10:51:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linux.microsoft.com
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v4 2/7] net/netvsc: add multi-process VF device removal
 support
Message-ID: <20260226105113.45bbdf8f@phoenix.local>
In-Reply-To: <20260226023940.961844-3-longli@linux.microsoft.com>
References: <20260226023940.961844-1-longli@linux.microsoft.com>
 <20260226023940.961844-3-longli@linux.microsoft.com>
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

On Wed, 25 Feb 2026 18:39:33 -0800
longli@linux.microsoft.com wrote:

> /* Spinlock for netvsc_shared_data */
> +static rte_spinlock_t netvsc_shared_data_lock = RTE_SPINLOCK_INITIALIZER;
> +
> +static struct netvsc_shared_data {
> +	RTE_ATOMIC(uint32_t) secondary_cnt;
> +} *netvsc_shared_data;
> +

This looks a lot like a sequence lock (spin lock + atomic).
Might be clearer with that.
