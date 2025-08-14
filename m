Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC1CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 040A7410E4;
	Thu, 14 Aug 2025 18:07:57 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 8667D402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:07:55 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so7943245e9.0
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755187675;
 x=1755792475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQHLH2u1JAfB5DKRiaYRk78Qr3N/tTuD4zGru9PsFOg=;
 b=iVL465bt3LxRP+/y3SZrWADIbErbw3hDgnFA1PoYIXAKilHkv1pXkeUWcWuIpWMn0Q
 KqufIh65UBuntLlV2j7vYXQmGaN5UvjDXF3TGgZFH6GJhlYja70IG9PIUvKvS4DAYQC2
 UeDQRrB9A9/JoB5AB9BgeZwQviAlAfLnWQXMKC4PMMkGE+ElHDuQGUf3AZ53R1uWbz+/
 RNBCHaI+cDzq21kUgZdhSdP5dFQKx1Znw0cZfkJ3T5y4Hhyl4Po+NPR2p719UV/03buW
 zIAI9ElgWTWZwtiakmy320W0ZXgmvzAO/F5aPk26aNbjOdbFy6e7m3Ji84Hq3rLPlwT+
 nYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755187675; x=1755792475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQHLH2u1JAfB5DKRiaYRk78Qr3N/tTuD4zGru9PsFOg=;
 b=poeofiHVbvQWTao6vrFTXTBLxF+xfNdUm+cugGD8isAN3T8fK5MxDxHDTyP/SWsAiu
 R5r9P09IghbtyU7dL+zIkaSvLfswt6eU2V9a6ZWy/gvT6rsFzhzzd34yr/ied93srtSi
 uWVUohu7nFXqgTUbGUXXzEY6EXCjHOA8zgrrJg/b5dycoRjuoFL4fSTbNjuG3JG55NF2
 tuDw2/C7mxoC8xlZXiIp2j5oXRYj9/m9zGqFGj029SYziBp2yuxIyu2tS1Lq5buX5WFQ
 jIvY3T1wOIJoK8uCTP36iA2nEXj/gXk/ViRp/MIyYr6g9sa38w1LWeRLdTr+Y3KZcF+A
 lExw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEcsjZWNqg+inyzZQPi2I1pIzbHYiiiUFmpqEicUsIXbja6Suyah9cWUPRskx60LxTdZk=@dpdk.org
X-Gm-Message-State: AOJu0YyNMel7wbv897715MbEGVZWEnv5KOXfhWjTnmki60TQhnOmn4Au
 xq22ZPKKTlIZIkXkK9Yk3aQnDQ9W3kDMYF3t668MwysNOgZYWiqt13s0cantZkLXsT4=
X-Gm-Gg: ASbGncseShQoXw5LAG82KeZHBiJ5Zx41d4DsfNesa/h0SRgr6mRsI62zdW/0Uyb+JZ4
 B+l6HQTkSWUVxd9aLh4f6pGSKGUqmLr7szKXAFNDr5OSMZUsqDwDF7LwL7bxmHchd0bqK6xKzSA
 gXS85AQQCo4rbeErUlogL87lmeNiDhrikl7zZBDZ4BC16k+w7CZj5QbzrxBBA31HF8iaD5EVnjI
 e+Tmbe+WHlsK8EILK5qLFkHQx1Rvd8fJN1ttchkFUSQG06zkK3lab06v4ItTOBKyLrWxG1TQhCL
 g4dO6HPx6pP4qZY0iPe4H6tCjD1Rp94B5dRiXnaRiq/S9Ydp2QzBaZnQq8c4gYMw+rswBiPUuDE
 a/e0vQzRNMaKaJwBWP32ML61ZnUnWM1yLd9jPXd3u2r0wqytFBGxlzcJ5P31UA8ce3ue/MCGdJE
 w=
X-Google-Smtp-Source: AGHT+IHsqV/TfGI8srb7eiU9ItbOEWdAjEY1QjjazuGoV9ormlRcJrRKoLYhpm9xhjmbOA/tQhxm6w==
X-Received: by 2002:a05:600c:1907:b0:459:d3ce:2cea with SMTP id
 5b1f17b1804b1-45a1cc22d11mr22655815e9.6.1755187674738; 
 Thu, 14 Aug 2025 09:07:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c61a383sm26579405e9.0.2025.08.14.09.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:07:54 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:07:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v4 1/1] ethdev: add support to provide link type
Message-ID: <20250814090747.0fe0ca15@hermes.local>
In-Reply-To: <20250814081215.1904078-1-skori@marvell.com>
References: <20250813084508.1446318-1-skori@marvell.com>
 <20250814081215.1904078-1-skori@marvell.com>
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

On Thu, 14 Aug 2025 13:40:05 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> Adding link type parameter to provide the type
> of port like twisted pair, fibre etc.
> 
> Also added an API to convert the RTE_ETH_LINK_TYPE_XXX
> to a readable string.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>

Several build failures (see CI).
Fix and resubmit
