Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D38C021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 22:04:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F227402D1;
	Sun, 23 Feb 2025 23:04:10 +0100 (CET)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by mails.dpdk.org (Postfix) with ESMTP id 61A1C402CF;
 Sun, 23 Feb 2025 23:04:09 +0100 (CET)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5461dab4bfdso4681041e87.3; 
 Sun, 23 Feb 2025 14:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740348249; x=1740953049; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sA3p7vFOY4LjdJqRbMiL7BUSj1uiTbYsejsC/vyPjLg=;
 b=NoLpsN06PvEktmaLm/k8lyEdJbfU+vA7H26SJhm9t7V6kXzunY2AS87Gj61tBalkrK
 xoN9bdpF7fojRNdMgP0ONXox9DVFUuZhZWo2uE4JQoATZwsn+yltgUdHoXMLWxy0QiPU
 RkGvwrYSjyKBKEovS2MZ5mI8MYvKQGLkoHlKzFc0BunzR1CleFVHQxcn+qWpMOOHSkPV
 KSBSeGZRze7bD4xr0qLiRScRfNmwzRB5lHqHwa/WU5Xe/E24b6DMu48u1R7RJC/it+wP
 FtADE8p+9CL+5glG7JTokiPYv/13kTPEDdqu9ECw1wY0SpBMCK4cnA5BJMYG7o4SUn8J
 rHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740348249; x=1740953049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sA3p7vFOY4LjdJqRbMiL7BUSj1uiTbYsejsC/vyPjLg=;
 b=BaMHUkVUJ5ceOG8r1WWc1qoZgpibukgBOaxUhFYvjtvUl6QImds9Jqxq20Qb0Gs4Ms
 ja6Bv0fhl7DdXqIOvNq5G0vTcifRdPq23yN3vH5OtZTiMFYxX67ujpUbiCuYoy2enx81
 EBTnMlF/J+1rEOg0hQUcq6tSYrXzLKUg1m7ITVQ7qPkrRUHvfjMVSYBYldPqtG0uVrJF
 TSPiilTey/XHGE7q2i69Y7+D+8fwA5gt/3ajsJ5QDpj1BciKkIGJretoceQabAKaKANy
 PbrwjadNT3mKj2muGLR10f/D9O25/W0Dr/x7O2b0L3iDMBjkAYMrhFt5xraF7cULsbAg
 uj9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk0V+vGd1uZLlsk4tat6gO1VFDRh49/Qt8rc0D5J7MLEibmhSRmVZ+XyjBd4tTQp/ypLbeEpQ=@dpdk.org
X-Gm-Message-State: AOJu0YxhvxUHVru3lRJBVv6CfT37MLtv/lRTAK0qzRjdRh7skaEZzWc/
 suy86WvokBNwZajZian4Kx+eTzS5DJwvZvsjOZufcxueRxnJkB83
X-Gm-Gg: ASbGnctS8bWFcEvk5uqrDups7cePI02XotbFsgWYUVup69Z4DdtruG+802wOCygOLbr
 w+2R5NVqbG8t46IVdOR2Py39qdFTfr8AxxxZ5HVjGQdRYhcY+xNeHaXLxjh7Fo9atEhimeQxp7y
 NMoPvaBvZnsKqH7hAOTu8irAgnGb27besponb9vYVmK/Fh4vqIf/ZkA26hZ8nAB5o16+25uplUQ
 s/NBolcRWsGpxdSYvsQhtnGq65HoG8GA2sfRWuqooWwHB45EU02ai+IwxeopBlOB/uqO2NIvA/S
 bznC1yYr2/s7C3nCHP23aPh70c4fs2lmPxkoOWQKm7GVfufJL9EuzuEIXG9zIJHVyQlew+TDGg=
 =
X-Google-Smtp-Source: AGHT+IHArFyCXCtv6gO2mRep5Kue+M0GaGM+MhIkrI0m/mNgYGHFhh9qTSkgXN6W6TkWkqz7Bhxlsw==
X-Received: by 2002:a05:6512:10d4:b0:545:ae6:d740 with SMTP id
 2adb3069b0e04-54838f4c919mr3617370e87.41.1740348248460; 
 Sun, 23 Feb 2025 14:04:08 -0800 (PST)
Received: from sovereign (broadband-109-173-43-194.ip.moscow.rt.ru.
 [109.173.43.194]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5483fddbec8sm584232e87.191.2025.02.23.14.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 14:04:06 -0800 (PST)
Date: Mon, 24 Feb 2025 01:04:04 +0300
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: Re: [PATCH v2 1/1] pcapng: warn if NULL is passed to rte_pcapng_close
Message-ID: <20250224010404.32b9a34a@sovereign>
In-Reply-To: <20250223214123.447579-2-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-2-ariel.otilibili@6wind.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

2025-02-23 22:41 (UTC+0100), Ariel Otilibili:
> diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
> index 16485b27cb46..d2cbcea42885 100644
> --- a/lib/pcapng/rte_pcapng.c
> +++ b/lib/pcapng/rte_pcapng.c
> @@ -716,6 +716,9 @@ rte_pcapng_fdopen(int fd,
>  void
>  rte_pcapng_close(rte_pcapng_t *self)
>  {
> +	if (!self)
> +		rte_errno = EINVAL;
> +
>  	close(self->outfd);
>  	free(self);
>  }

Still dereferencing self == NULL.
