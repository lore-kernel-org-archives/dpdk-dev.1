Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96459FD376A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 17:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1736F402E5;
	Wed, 25 Feb 2026 18:01:29 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2FD484027F
 for <dev@dpdk.org>; Wed, 25 Feb 2026 18:01:27 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8c711959442so103324085a.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772038886;
 x=1772643686; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whJXPGlu08Cz9FTVkV989wkyjVzTu0YYaf76MDU3h50=;
 b=TZoJT/kdOOkjXwdyxt6WVyHpSW2sCIaEKA5/34NCmpqg9Zx34BTqTBz1jFIS7MQnH2
 CWXT6sJCa6Qy1HRjq5VpcdBrB+FKXWJR0vtKiRJ6P+WwRqPJfq2tY6HhbtumESLzQ5jT
 zBB5o9IaHYW2xxGvChq/TisEW2kszSrGtlJSPGh8T0pTFulUkHvP50KYgb/95Dc0CNvS
 2sciq/PxCJe3fQXzw+9NkEBIS8cdfN3lQWis7NU4TCWLlTqC9I8S1+ycB492Ai7AwsZa
 BhnLMw4X+TeVO63aYuJFM+V+1sV6o5htwThVNm8eyQspkHQ9eYyGFExNJxZXqV6xeJYr
 EfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772038886; x=1772643686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=whJXPGlu08Cz9FTVkV989wkyjVzTu0YYaf76MDU3h50=;
 b=i4PotZHJHdsYJ9kIV65CP4/mxl7sjMaDQOGNELpOvVIEGEf6yBqIU+brBNbSQBJbMa
 sKPCIAo+eVPBgTE8O16F4qk0XREj7z2OeUuO49dcSZxlIc2IamtvKdsyEJs9y6sCgfIf
 sU0l2M1KH86IIUA3s+RACX4rEdnS6lEVPyuhI9ImyQU3wFsRUc4Qe7hmLAUrFZkZe9dI
 9dFdVne+8f1TltdiadALMTpdL3emNSy1r4J9LGa7rGmDzWL1XqWg73wWFR27mZMufaVH
 /GyGC5ERDZ7K45hpfUMg4kW0tJPBP/6FI6wSdRt9Zchhv62Ezyqh7cXtPdreL7ZHGDeT
 h1AA==
X-Gm-Message-State: AOJu0YyGwtxthml3rBQL4nW5/N61OFCfyA+45sCv/HsD5TNAC32soNM9
 T4WFT9Wib1EbC+k4IZn//5OhERSzDMM57pBnWIU9S4+yUnuSQ6b530Vox2YqmJhx2RU=
X-Gm-Gg: ATEYQzzDlElH8jTDwVYGe5FbvGvV+WSlU4zbYq9RDpg63qH8272gmk0w3+eOyZMNfgV
 +DhZAzc9SbNfGWBbANyXObeV4jC3prsk4sabnOIRXJI1g896ymLiEBOcj833RbwT3HAyrBc6pPo
 HNIqgLZBvy1NDdRAvXCCzAZPlTJ5PtQHxDCT62zrXNHwcqIGUcN0zlyjU2DW3HoFb5cmPj19plk
 2oIuoyckMUuWHjOjLnbpzX5N4oqDmNfM59BX1sRCwreV2WRoZfxP2Fm+8zxQVg+J7fdV7KQaVnq
 fywV4YJJ1ZkuTSvuE+vdUUTIJAucIh3V+cJ9XA32Z+qj1rYziaKuSjdkfUMzuZU+KAhBDPg6xWm
 /vXtz4eSpoJaMLMjY/zz7O5cBTBh5AfnRbDKh07ZwZRnqRC/22Yl2qVMMHhVVO1vJSx/p1aFHWd
 j9MsgZx+tGBKcyHIgCZH6QCPxcdgLGfDB8UEWcmLq6l483xfa4eNrFTxBEB2Z65XTe
X-Received: by 2002:a05:620a:916a:b0:8cb:bae9:9f59 with SMTP id
 af79cd13be357-8cbbae9a4bfmr191644985a.30.1772038884194; 
 Wed, 25 Feb 2026 09:01:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb8d1202e2sm1294956685a.44.2026.02.25.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:01:23 -0800 (PST)
Date: Wed, 25 Feb 2026 09:01:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Chas Williams <3chas3@gmail.com>, "Min Hu
 (Connor)" <humin29@huawei.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Long Wu <long.wu@corigine.com>
Subject: Re: [PATCH] net/bonding: clamp Rx free threshold for small rings
Message-ID: <20260225090120.20e17300@phoenix.local>
In-Reply-To: <20260224121358.3102740-1-bruce.richardson@intel.com>
References: <20260224121358.3102740-1-bruce.richardson@intel.com>
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

On Tue, 24 Feb 2026 12:13:58 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The bonding driver creates a minimal-sized Rx ring as part of the setup,
> using the driver default parameters as it does so. However, for some
> cases the default values need adjustment for absolute minimal sized
> rings which can cause failures - for example, having an free threshold
> of 32 is too large for a ring of size 64.
> 
> Unfortunately, the drivers themselves cannot properly handle this by
> adjusting their defaults because:
> a) the defaults are returned from info_get which gets called before the
> desired ring-size is known
> b) the replacement of the NULL rxconf value, which indicates use of
> defaults, happens at the ethdev level, so the driver is unaware of the
> source of the requested parameters - whether they are explicitly set by
> the user or substituted by ethdev layer.
> 
> Therefore, we modify the bonding PMD to clamp the free thresh value to
> ring_size / 4 which should work in all cases.
> 
> Fixes: 4da0705bf896 ("net/bonding: fix dedicated queue setup")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Queued to next-net
