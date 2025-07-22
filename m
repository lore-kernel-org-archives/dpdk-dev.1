Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEF6C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 13:39:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8CBF402DE;
	Tue, 22 Jul 2025 15:39:28 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4BC004003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 15:39:28 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4abc0a296f5so48038481cf.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753191567;
 x=1753796367; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGI6JtgwTsXBdnuhfuDTnc+vdvbF2Iqa1O1vV9o2+0Q=;
 b=fxu06lRCq+i2XO3V5CvAMGEd+7oaKS/4FXNkCTbOfIme1ToDf8A8zvfYxhpodF51ko
 4K5jISBU0/JSuK6z2ZTHXa7r7f7wu9/j8HzID77ValKk+VyUVEx+dLUbhljvEs4mT2bp
 rQ6amyHFuLuBalV35gB9qtTFLue3F1zlyGti8aEF44oEYIYFocB/QPF4xRfeCKhRotlR
 XczZxEEhvsQnfL1i4hUXhePGOuLyx1gMzptjDIrKCvL805KMwTbb4HmYBqzet3UhIdMZ
 Nhh3/iAV/iaH4IHIBk3YOhd/9iESwvCDMH4D4glauc/M30yaLyOpPfLvjIwMzX+VE1Yj
 3qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753191567; x=1753796367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGI6JtgwTsXBdnuhfuDTnc+vdvbF2Iqa1O1vV9o2+0Q=;
 b=W2DXprqETCut9QcoNbc8VNjf4ZlEW7gs4bwm1FTM6hJNyWsXssdWhl4zU84BoJCL0o
 HYTdsFmenOxD0XPV6Sju/UIh4+nzCJbRVt/2trFgq0DQOr0R1JCAxvXcspy9oOJ9+gyZ
 icUoRaD5IGGVAV/qhuKl86y1rw0wfYx7w8j4eF85jB/72ezltJ0HBR8YFnbZGRBifx/Q
 iXVfzcA2G7JpqFFYcBXRK0YjKuzRonKixrkaGeJS/oZJuE68BXYu8AoIMvH91oV3cPgv
 UFhi31kZ9XltM8DquZof9T0gMHLsEzBK4cq27/6isfheWnQ+iN9dVhKZhqj6Sm4iUobz
 aWIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEV1+52CHFeOCi5/7gZ7Ij4zcAZThBUcKbqxahpFbSF089yLOEdHYX4KDBZ7I0ceVXV+E=@dpdk.org
X-Gm-Message-State: AOJu0Yy52zl2LcsU10X0M1wzYNgm8wngiQNQgKKneMOPYp9l/BJ42873
 wcC1rUgJrO23rg1AsNmX8F5Fzdym+kHgBR0eNY/vT8hlCY5RGqki8hg12FvDzzS9KUfK+y+dZzz
 hkN1r
X-Gm-Gg: ASbGncunmU1tOZfEJNpoB0Q5HZ0JsBKK0cdn00pRDTn2BJpiTiOyPUzYUvWbOGaSw/n
 OQmT9PRcnwR+weRIDEBwKjwTEWoKcU/JGbjQ0ZUciV2F551aA7mlr7hToQGdvfp7v50ePrSq8Uu
 StwbBMuQ5r3gW/Jxo18hDNNFXWuh7JdBIkl+EERp0sgch/koP5CWeun4k/Pupbn4BKP2KPbtHZP
 TrSJhqG/CGDLnXTYD/HboZOzae/sg3txxvCnsdxx6EdmgKshQw7nzafFvI79cKgHVeFRE9V/R4N
 yw5nLMfXTj/T092imRI4QrlcAwbf0+rpEhIZl/ZIbsSM3b9DcmJeBSEhMSyCOhI7TJqcD+wUzcj
 I5Ji+wpL1BJJLGlLU4ghIzkmdNdLvLELqI6gORDXlyDRDmYloOjpbodDKjM0ai1/YvU5wgcz7TL
 Y=
X-Google-Smtp-Source: AGHT+IGSGDvQV+Zzvr6hAt1Ty26Oqw+ChqGVo7La98AnpX0halnnDA5QBbCnQL1LOUurZwMv7MnnIg==
X-Received: by 2002:a05:622a:1995:b0:4ab:408f:d1af with SMTP id
 d75a77b69052e-4ab93d8d7ecmr354082211cf.31.1753191567526; 
 Tue, 22 Jul 2025 06:39:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4af26bdsm52948721cf.35.2025.07.22.06.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 06:39:27 -0700 (PDT)
Date: Tue, 22 Jul 2025 06:39:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Message-ID: <20250722063924.2f87f3f7@hermes.local>
In-Reply-To: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Tue, 22 Jul 2025 07:54:39 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> +	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> +		(dev == NULL || dev->data == NULL ||
> +		dev->data->dev_private == NULL ||

dev can't be NULL and checking it here will cause a Coverity warning.

There are many other ethdev calls that will fail if primary dies.
stats, xstats, rx/tx burst, ...

I don't think it is good idea to add checks here.
