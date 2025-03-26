Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF77C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 14:22:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D35DD40613;
	Wed, 26 Mar 2025 15:22:43 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id BC556402E0
 for <dev@dpdk.org>; Wed, 26 Mar 2025 15:22:42 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2264aefc45dso131432145ad.0
 for <dev@dpdk.org>; Wed, 26 Mar 2025 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742998962;
 x=1743603762; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=waIxRZaiO+am95vzpvVO08nrQP5gUcD+a7U2YXY4bdA=;
 b=Vq2N1pze1pQrDF/wKkUKG7jCjAQJ+4nGqq9mnW5C8tKQu2/c85WPATDToWD4rfPsUm
 zfLABcjLITAWJrffFYg2kna/Lg2OFwbrV//MOIGhkRGpNnHeHKIE6plZ9u7UW3PasNnY
 XRk1lQsy04Kb6J6gJJ85R+JrGyuxaLugzAm70BoNQBwaSx53SLPJq+as3m/nnM5t0Jim
 ubGiLxNwEYC+sQehBZO+5DsnRFebMXTqfGJxQtbOiCrVBtfXrLgNAd4S7J1vg/soesNX
 pWqEG/BoYO7d32ndOsQ6o7+FrXdRdYYfyHdVqeC7xhvMDA/6SEAA3IRRH9mLuV1OgSTS
 MOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742998962; x=1743603762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=waIxRZaiO+am95vzpvVO08nrQP5gUcD+a7U2YXY4bdA=;
 b=WG86FctKq4UUQ8+sg61JC6DzW41PKKpWU5sYwdcuRfT0ynmjFTwTb9TdT8z933C/DS
 pSX+duZ8v5iNw7VHOfG2y77Nki/Hqlk/g4ur5SJy3mMBL7Mbn6A0jhqtFRd6bees+rdJ
 vEUYbdypuZEck0UMcstMD/xGAB6hmcNKQO8Hu4xA2Qt6/igocoQbO4uWeoLjqvDWr8ti
 ZUUK2n+L/a6Rmp1kfaWlpcqnv6jQtbZGW5HrDc7jx+2Sgw1lLL1N4R/asYz73SZyFtqO
 qF1jW2IXvynWOY74jD2p2qBwAOhShBF47NAMtgCQ6cR1VCm2EEGXDpl0PyJ81eb6eavF
 51JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqycA4gWrtiAW7jwIQdpZPO5zC6h2TLwsvCcl0xZbNOTTppW3nxEUfJ1GiZfWky+tx8Mo=@dpdk.org
X-Gm-Message-State: AOJu0YzZ6FKynBFTSRHsPjaHHnG7j1UdQ3zUo2NOtPNmc7b1riav9XHt
 XRIFALyPjbeJd9X/WGLIgIrDzT1u03J8w5ohmXCBAhmIH+isvA8mpvOERadqNAk=
X-Gm-Gg: ASbGncsuU+xKa/RutYnPxxuIHeQaLE2iJMs9T0W1o0/5uLZzuZ212TYKT/jfEp6Txud
 CM5N+YqaFjuVVxqqp1qSdPtZsrcUTDSlnv/3bYprTTxFBdGuk2+hPx03CTv5PXMdY5KZbPbrBTr
 rKYwPHO0OyIabmBRHXgtk9l0/5LW8+V21qaYjFZ4gxglmx9Xur03ZWMiVlKKwMJqg50bJIwFtX5
 k5EBmWIag+gpitllAkZJTm8JyeJ+BdBUK8fO6peW9Z+lThfwWd4kxQ41PZMdizxbJBUVE0BII6g
 Z9uVwbE+x7Ngb8UQrrDgO45FpkAW3VQ597t1sQrQtRseoxVy8Ii4gpQRbLYbXlw3XPQUgwlGXgi
 XfjudHhOpIuI8ao0ANOUVJdc4xsO6SS4=
X-Google-Smtp-Source: AGHT+IH8mn3/vBk4jPJYNRun88unW9Da7N6UXURRMoY7ro8gnhjz39R8jQd98AinLdcKX/6XjvDWpQ==
X-Received: by 2002:a17:903:2346:b0:224:1c1:4ac1 with SMTP id
 d9443c01a7336-22780e22b60mr255536045ad.47.1742998961686; 
 Wed, 26 Mar 2025 07:22:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781208959sm110678965ad.251.2025.03.26.07.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 07:22:41 -0700 (PDT)
Date: Wed, 26 Mar 2025 07:22:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pbhagavatula@marvell.com>
Cc: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: Re: [RFC 2/2] eventdev: add default software vector adapter
Message-ID: <20250326072238.7b534f2f@hermes.local>
In-Reply-To: <20250326131441.5965-3-pbhagavatula@marvell.com>
References: <20250326131441.5965-1-pbhagavatula@marvell.com>
 <20250326131441.5965-3-pbhagavatula@marvell.com>
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

On Wed, 26 Mar 2025 18:44:36 +0530
<pbhagavatula@marvell.com> wrote:

> +
> +struct sw_vector_adapter_service_data {
> +	uint32_t service_id;
> +	RTE_ATOMIC(rte_mcslock_t *) lock;
> +	RTE_TAILQ_HEAD(, sw_vector_adapter_data) adapter_list;
> +};

Do you really need mcslock here?
mcslock is for locks where there is large amount of contention and lots of CPU's.
This doesn't seem like that.
