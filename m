Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2021FC7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:29:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 728814060C;
	Sun, 29 Jun 2025 19:29:34 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 862FE40288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:29:32 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4a6f6d07bb5so18701671cf.2
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751218172;
 x=1751822972; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0F0YEZv4RV54Nr8G5e6j13PAHhnxMBSgibOkmyeqARY=;
 b=KgbCDE4E3+Gj3yB/V5nKdmEQZoCJxFClPehtssN3arykJjHBz0meI5+u4RKXa7yicN
 xeWAny6cGZHWXLIMzK6BHjT/JdZyxUpRsm3NENXJHzuJs1IVV2cNezJF4ttw/2vO/B9I
 zP0PfpPTDJKQ/G6ODH/kWcrJtBYPz0schr5/kvkvdDVbyJ4WUaqj3sI8RB+Pil4IXvKT
 G+yNHb0MDmE1RMK88o0fq2Lpdt2gzCdFAPt+OSIIABrEyuCwrjg54kwWFeM3CY7KYjKH
 mFlr5YcYUUgznSOcTIkYr57Lt2bOhAQADzE7SsPutqHWvghg5Ko064sPvuM8L90T/Gvo
 WS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751218172; x=1751822972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0F0YEZv4RV54Nr8G5e6j13PAHhnxMBSgibOkmyeqARY=;
 b=e6emM8e/vztW/fdaW/sxzJ7Y+g4lEKR7DCtucDNKCY5kU1hcr6psW69bB1Jo8gU6BE
 ManZkcel2llBMt28Qd4kwCEL3haD0Ugnh4D8H72iXAVC6enMABINjL0Tav8xtTuIU13Z
 p+mrDnM6E/PTkotPb1JRnixkM3xD9unCAYo+8zm2uAbJ5QPzQaomKSNCgqhorvLBwJ5M
 EM5xzajcAvpLew1t7vj/QF0Ifz+G2lCHlzLCsaRyQpAMTNNroi+DrQ95Yb9zB5pYMDV7
 d1XSEYIId1OpE9F4vsVSnBPExVsSMJrF5lMVZwh/8oSsurYl/PbZehoVlasWMlHd45Dm
 ds1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtjZpOs5703O2B0sVVZtFNhyVLBnSzGoxH5+uaxmycFClOhynN7xDIG+8jVCqgW1d1p2c=@dpdk.org
X-Gm-Message-State: AOJu0YxVS2Z7JvBGU1H7AJFg8ZQ9dEZEef2N3n++mV29XSTpVgzREFcf
 +hB0it3VqfrO9UmYIXmYq6oNm2+0+odoPa+8CxUQUE+O6QYhbbWNaYkmywxeVjpRO2E=
X-Gm-Gg: ASbGncvAxGQi0PEbmrwfpaAnVuc5TWTy965Tt/vNiwFJVWkBh+ITx2nIdYRkUcPWgyN
 B1eBvHeN1CmB/IAb3OhY4uQ/OIXuqquU0G64SxDl1dqir99UyWV67avIA08WgUp+mr73Oyu+5lS
 S72Jt7yysOGlMo+wppbv2GINscyFGqFDOM4F5I3j4lRXUBUMVUsJp+xUpKv1SwRHpVb/V+FbgrM
 Fv2ZrBwQ3q2I2JGzUfwzfEgmXit/nTbtTfZw4JIoc8HEAIPar5bZM8rXLCgmemLp83GEufU3s9x
 pUuPI5HHK+cmSlQcaPky2+9qNNqBiwbSwJ62JcvDyg/8g15aBL/ZBA2yngLN4mOWTGc6VaveRmZ
 xE0oNPlLoPD7rsJtaquvUUyFmmFlUt6zl1KKTcQE=
X-Google-Smtp-Source: AGHT+IG56Pp/ukJpK0Ppw+RsBvkeF+Atu9FfAJir24sj9MxsSYrshJSxHtOym6ZKqiAeSsVecVutHw==
X-Received: by 2002:a05:622a:1486:b0:4a7:9b9b:aad7 with SMTP id
 d75a77b69052e-4a7fcbf9f29mr184125541cf.49.1751218171897; 
 Sun, 29 Jun 2025 10:29:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc55c62bsm46943151cf.46.2025.06.29.10.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:29:31 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:29:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: joshwash@google.com, dev@dpdk.org
Subject: Re: [PATCH v2] net/gve: support gve driver on FreeBSD
Message-ID: <20250629102929.25f6fb6b@hermes.local>
In-Reply-To: <20250626211921.2291937-1-jtranoleary@google.com>
References: <20250625182751.1936925-1-jtranoleary@google.com>
 <20250626211921.2291937-1-jtranoleary@google.com>
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

On Thu, 26 Jun 2025 21:19:21 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> This commit adds small changes so that the gve driver can build when
> FreeBSD is the host operating system.
> 
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> Acked-by: Joshua Washington <joshwash@google.com>
> ---

Patch is in next-net
