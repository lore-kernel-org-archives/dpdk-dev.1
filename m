Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CE7CD6E4C
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 05:12:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C5D540264;
	Mon,  1 Jun 2026 07:12:34 +0200 (CEST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42]) by mails.dpdk.org (Postfix) with ESMTP id 144BC400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 15:23:13 +0200 (CEST)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5aa5aba358dso580229e87.2
 for <dev@dpdk.org>; Fri, 29 May 2026 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780060992; x=1780665792; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iOY+GSfbDfflbz8U7Z92L+4vuMoBXfpelNiR0nfK0M4=;
 b=fdxXUfT2ur1WQhwtqfudidqd65VROOCLttcmC9MReWaBYYcOrScVfvQbMmu1M34fQS
 qIvc+7DESFvJD+7x/1OQffrw4LZ8kr+UvP0T0IXTZ/iR5hnnkZYkj5uaTgglNufPuxXz
 6ne4btBeceJnMKGAm36mqY+TlEbO9FhwyWvZyBKeF29hrRsNU02NaekstKzqfflOTLng
 wDZwbjnfz1SkiuLlcE8JRCjZUCbUA+6kgXEX/smWxRAvq4OuLLzz+YIKnANw/4mnLt5H
 isNEX6yIj2fVKujlMVbi7+GkyTE1FUoWuMwsCZm54NwQaC30m/21CScI8TFs0Z8bt7gW
 4nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780060992; x=1780665792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iOY+GSfbDfflbz8U7Z92L+4vuMoBXfpelNiR0nfK0M4=;
 b=DgqNU35asVoF4WNf2r+rF4DX4J5fmuAooNa44bnK4Ey+AgF+BHfYNYClz5hMfoX+pG
 gk/appAT35ZKohgoT+gC35IUImq/uHYutmYOKlD2omZIDqlai2hoKTIfMUYA38h9+4PM
 VBHqVlYgbhU6aZK6B4xdDm3BgHWWZerTWXe7XWnFQiuFBHt5aSQTjI1OOhAna1SMYvUx
 ClfVPH49UkEs36wZP4j23xkipsxtKZkDmGyH0mNKFAZ9f9B+hUa29V2G0HqqbtK+JOqz
 iSofnzLJpoKl6R8NbroTq8LwXiy5LvGY3oZzwmgjK1JIfiB1NeGQE1WWY3s/Z7L9sR7q
 ZjAA==
X-Gm-Message-State: AOJu0Yw8rRhtA0cXpWgAleRlje8WIBcQjD+ATV+l0QbHC53DfKDlqUmT
 ZPFoE1+RmJQiwvuq+BBJxCP3VLWM2aEhzJIJ66Hh029iaUuMgorwQx+vUHLwsg==
X-Gm-Gg: Acq92OGcK3sdHN/oaz1iDsXJ+g8FzhIYM42ZpWaLA8riWI1xyAjCgW8Q8zz+hlEGSqr
 5PZUfviO81Vxt7StPiGH4Dh4PXJcftWyX4vXb4a1iVOXtU2/VdB1IQXxdOssGL28KjRQkr3XlpU
 xDF+SpH7EBAuEjnXHG0qnCk//ryY4Pr7GKwPEz3bMUTOZYezWtHgKtpwJuGXeCpI/A/D/IaKLvN
 MtlHjmBW7l0mtLYM2+GTTCfPp+2vGqbBMUj1WgyAXOJdMVbOxx2rsjz7RVq6MVm/rsGOryMmIIW
 Hf806+tQl8mPmV9Fbto1y6dTSWA6Pq9LO9bYMY/OnxCVTEeK9fAfLLmaBgBWz1xK7P5klsc7Vay
 kj17naYZxskSEJTzzp9CJfyzdOTkbXYfxVBsVJccy/B80w+FDW5+W3X+fNKz4BE0f+zDR0/SH//
 9XtPDbn+FT1eF8Jk6dOW7zNBxsv92ld5TAAqjwffTnYyaC7KkU2KK2dxjfa+9tMcL0c/Wk2UtFq
 MA=
X-Received: by 2002:a05:6512:110e:b0:5a8:6747:b053 with SMTP id
 2adb3069b0e04-5aa594b4674mr1006925e87.27.1780060992020; 
 Fri, 29 May 2026 06:23:12 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39659c90b95sm2137011fa.11.2026.05.29.06.23.11
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 06:23:11 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: dev@dpdk.org
Subject: Re: [PATCH v2 0/2] dpaa2: fix error propagation in remove path
Date: Fri, 29 May 2026 16:23:08 +0300
Message-ID: <20260529132308.358-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260516110845.2345-1-shofiqtest@gmail.com>
References: <20260516110845.2345-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:12:32 +0200
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

Ping. Any feedback on v2 welcome.

Thanks,
Shofiq
