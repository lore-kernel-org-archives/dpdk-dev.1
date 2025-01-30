Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0591BC0218A
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 23:55:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94EA640E54;
	Fri, 31 Jan 2025 00:55:08 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 2E77940281
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:55:07 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21619108a6bso24153875ad.3
 for <dev@dpdk.org>; Thu, 30 Jan 2025 15:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738281306;
 x=1738886106; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQhUJNlRPdI1jfxeXpx5W+dkl8lKz0VsW1zDMJMFsMg=;
 b=l/ftUHngagAfgfgUixPI4hYGX71fBEm2PGmeexcKwAAGV/BbjNLewQqRjkGpLztp3F
 vI4miC1Pd/mk+YxVa0sYRuOC6brDBuWWKjZEjPvlfE9z8TV4ejBf3EZ2m/SFpYxhkvCZ
 kICXUOXiN5gvZX8wGW4Mo6H11+A0UH5H8D2HsXxim0P8dOLY7hAg2zqdaKgIjJZS78Z5
 mUyarqEoAc1zJ8bH12KhEiLD5543mWKWHf+G5HSycJDAtLHCN2GxocYuXRl9NzQR/06+
 8+OW8fFDm8lDHMsx87aohz9rnB5XKQbSQjIGudemye76O1It8O3j+WqWMrM0sa0KTKKc
 y/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738281306; x=1738886106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQhUJNlRPdI1jfxeXpx5W+dkl8lKz0VsW1zDMJMFsMg=;
 b=G0bf9QLuluVk2+8VcUaqItvM/hUlfWn3200Rzx0Me5eKQ6G25WbQHhSmIzls87p+lq
 MYc+GcYdwH3kpIat1sLu6jLQwHhSwS9DiO8ENNWryRhCUDCYdi7B8dVKsRA7cgeyxD+4
 I1jgDh/bwoKjALds9MR3Kxb7HPTXcOIn8xRIXA7kPsxbMRcTOwwVkaOxgTV7Mc7kdANV
 oNABxDa+jdWApn/5AfkmPveE5ywqeo0TTZvat9bBclkgfLSz7VSNOdzaL93RQ4rPYaNH
 9G6xj6betVjtU6Mhr+zewenPZj402EqVcD4yqz+G7RESyJ28G64MDiKrXHLofsRiLV6z
 tiVg==
X-Gm-Message-State: AOJu0YwNw0lEzmgAMPi1FaYl4owbdsEk+7HgGcCtBsQEk9zmHT8yHU+1
 9fjerMQ1OkiHj2iE1RDXfXtWifsZjo8VySDD1BJ0KjQ19PRqd9srZ9pMTr8Ljz4=
X-Gm-Gg: ASbGncsqVvWyG+eYn0JyadE36dsKOzZwauRoGZXF/CuA/aazkcMjfEAdZTLojW6kHVf
 Vpu9Hu3uPJI+3OM5DoC8IVOgxSf69XJsc0lUdrKnbOJK9P/b/39hqqtgCUyowXKo+3mgZAZAiMz
 UrF3Gc0071iyQ8jnR4xn/QR3wv2p70WRhmBpfyiELex1+IEDp06MkJ3xs+yCO+rOC0QxrtzVeNG
 GIzKELDVuveQ+eeebFTK64rexBFu4v7697GMdrCRls4GQsevTjGeIuM8alwmXsvtB8hvHgGhn5S
 fYzg1Ntc3c3M2PnkhaK9wpnIZAwVT/6fQk7f3uaxl3vi162sQLkLjubK1nfNQ2P4jWRE
X-Google-Smtp-Source: AGHT+IHBHbwwlUDG4Cr1IRm5q4nbpYHW27x2zJITtkuKNWQ9x4M+pSjNuWKSfM0Icdew61U72lZ0BA==
X-Received: by 2002:a05:6a20:d049:b0:1e0:cf9a:87b1 with SMTP id
 adf61e73a8af0-1ed7a49a2d8mr14936007637.6.1738281306080; 
 Thu, 30 Jan 2025 15:55:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6424f5dsm2038909b3a.42.2025.01.30.15.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 15:55:05 -0800 (PST)
Date: Thu, 30 Jan 2025 15:55:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, Ciara Loftus
 <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH v4 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Message-ID: <20250130155503.733797ca@hermes.local>
In-Reply-To: <20250130221853.789366-3-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250130221853.789366-1-ariel.otilibili@6wind.com>
 <20250130221853.789366-3-ariel.otilibili@6wind.com>
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

On Thu, 30 Jan 2025 23:18:53 +0100
Ariel Otilibili <ariel.otilibili@6wind.com> wrote:

> +static inline struct xdp_desc*
Need space after xdp_desc to follow style used elsewhere in DPDK.

