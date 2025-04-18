Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F77C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 480D1402D3;
	Fri, 18 Apr 2025 20:42:51 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 660CC402CB
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:42:49 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so1717073a91.1
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745001768;
 x=1745606568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWBU3bjFU1KUDPKatn/QNwR3w1tzsUOnammJ/ZpWaF8=;
 b=zRw8psr4sq11m0Wg23GsrVJdAc8S1EtEweV6tjc/opU2S9MIR76uA7q1D2YzaOgXKY
 6KsDUQ2TUIyHJCd8bzhzbkp6W9MS+8oYy1KeAhuT9XXDYIRDyISqWBcqOx6QUSQQ+uPu
 0kwzgbyW3vyHwERfF/1Uh0mfO2iuVbUWmrzlNqy2PrHJAAILivqQVUnWeKXLjWdiiMFj
 xDEfLb5K32wQXm3ar+P3dD3EfpGq9LizjRHfMW+bgiZ+7vLRXXQ+pAgukAFsHzbUeZIy
 3RqEKV0NYswAq4EOycm3DZCO6tXMi85u01xOe41Y+pzAb5HoHELnwzvR8pP3AJrfPYn1
 WCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745001768; x=1745606568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWBU3bjFU1KUDPKatn/QNwR3w1tzsUOnammJ/ZpWaF8=;
 b=Y5nilCgb9tMRHNW96iywolbHTAG1/LajZwQvYTEqKvIm+q1bprVkQ2ZH+86HidaIQM
 kcO9a8VO4c8x7M72qRGGel9IfiasgR290eAaCuggffEHIqXW6rcICW47DtdPdltHtHtB
 Cj6/9FqScxX9IDRfbug6CqVZTgkGC+7uuk+x4lTGEUmI0B74UWuN189UuBtndimywc1z
 +KCoYYIVEmMb7EYGveMtn/iR/g/cmDIT4UKpWz47qR7YhdaMd/ck6v4+B/R0ys5z1T7q
 JK/rdc0otRGGL+zce0cSFqpNh9L0Cb4AvIpIU72rF6GpMvv7WkWMxdw7/3PY513X/5q+
 RNKg==
X-Gm-Message-State: AOJu0YxAjefoMYEvL4pZyW2GejGNp4Pq2iiSfnXc+b+slLwTQk8zT/cU
 hpFiwYAoJWji+CDTgTgSp+atTMlIqE/s/d7TNy+ffwQgqnC4qkFzv3mvkgKYGLc=
X-Gm-Gg: ASbGncteXpNVP7hYbBJ7FGMrE3zg/ZDBPqrA7lYUWJXTbcisegJxwdpT9VlV26k3WVY
 tF4i5XMa1wHTL4kncM3yvLbO8n+4iOVrGOwYogih9zvu+5w70AQOSOTItkDmcD4ZJVvYCDPrCtI
 p6Ad4NFqdGZ/oZ1VzxT/fmi3GYg21x2DtlVMDyrGEHI3DQnWdcer49WwCqGcc4lQe5+RrB4pcQN
 6E8wOxM6kMJ6CZjuZJ7WeSIPdbqGXG3pDYqp8b1zPtI9bICt24Yrd1IwKA8HGW0rVkrLayJiGji
 mSg+mWZP7Pr52ljKgmK/vo3dBWSrHUs2njuI8t5Z+q5Bd8toiIZHsqgdaLsyIF4qQMllDAE+QW9
 y2Uelny9f6uNc23lb
X-Google-Smtp-Source: AGHT+IEUwsC8wKViQ6MzPIaRMDvON1lFAWWg/zwdE02ngW7lpJ7TMxKOYNlq599DiEfcM1OYZvcbzQ==
X-Received: by 2002:a17:90a:da85:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-3087c2ea556mr4802336a91.10.1745001768477; 
 Fri, 18 Apr 2025 11:42:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee889csm1583366a91.2.2025.04.18.11.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:42:48 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:42:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chaoyong He <chaoyong.he@corigine.com>
Cc: dev@dpdk.org, oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>
Subject: Re: [PATCH 3/3] app/testpmd: add a command to show VLAN filter IDs
Message-ID: <20250418114246.7fc06583@hermes.local>
In-Reply-To: <20250411081005.1133509-4-chaoyong.he@corigine.com>
References: <20250411081005.1133509-1-chaoyong.he@corigine.com>
 <20250411081005.1133509-4-chaoyong.he@corigine.com>
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

On Fri, 11 Apr 2025 16:10:05 +0800
Chaoyong He <chaoyong.he@corigine.com> wrote:

> +static void
> +rx_vft_dump_printf(int left, int right, int *c_count)
> +{
> +	if (left == right)
> +		*c_count += printf("%d,", left);
> +	else
> +		*c_count += printf("%d-%d,", left, right);
> +
> +	if (*c_count >= 120) {
> +		*c_count = 0;
> +		printf("\n");
> +	}
> +}
> +

Since VLAN id's are unsigned, should really not be using int.

If you are really going to have lines that long, must be a real
mess of a config. 

Once again, this is getting to be overkill for normal usage.
