Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEA1C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09D954065E;
	Sun, 29 Jun 2025 19:53:22 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 62E1340655
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:53:21 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6fb0eb0f0fbso41132246d6.1
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751219601;
 x=1751824401; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGoELcfXnjAaBty+cpebNr+WSmm77hAQmU+Y1Yy8PkQ=;
 b=h/9Xichi/ctD5KzNpVqygyPMmIqiyytpgxZzrr2kD1r9TjNZ9vudzk48BWqxym+5zV
 dXKTAMAypp/nftuEFjpUcz6d+f/LQGCOt9Kw2KMC6G+WGoQncwotJHSyFC2dniRHTHMW
 yRlPR5wPzcFKKVx7jXQy/elx9OjFHwTGwlIwRkcr1N1bFEIWmGp91gsT70pB+MWjE+Xr
 r8IEGhBlxQ1dFdvd1pML/8BpWCvIYLOD0W2BY+yezzkNB1mlYCjYgAEHkJL2qCq630iF
 Jce6yGIwuJoFarnOEUoJfg5oSrY5kZGXddv6wTNhJvtrW2Kb/KHSZETZlxiQhv8MYSkj
 UW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751219601; x=1751824401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGoELcfXnjAaBty+cpebNr+WSmm77hAQmU+Y1Yy8PkQ=;
 b=fsTbTWKm4iG237hEEh/vhOE2J//cGN89DIXO1K7iEtd3cjBBkOGiUzP1PsZxnrRzoO
 or6e43+1AIjoKCNbng8y/n/2VWRkJ/bi+j/v/AM12I9ANFIHtWuAcSAM+sm/BUlBh+Ci
 vAjBgIpd99w5w4FrT1R7JPeBpFgHY35IVGvGUiiUKguIzAA+XBfYYs58dJWkUF93vupF
 G3FWqMp4O18/zw98KlSWRRbbT61mVvvwjEPvHvW90Qn2sg3Y9tr0AqkKd1nNem/Vq+Xy
 wy+2J2aY/x/+9SiiAuuB3WB6AVJC6Dl5uIcshm3DB6DvbI8O6W0Vj8hZvrlq8YncCXhX
 I5hg==
X-Gm-Message-State: AOJu0YwsS741EirkPvW40a14pyoezmeqzDDIzHTQsYY0Nu+FS34jvhbx
 PKmQuiTfvp1IN4/4lUxOndveR0cCpOXwwYBdn+iBhdaTPgflRM6L7onfHx3QKYyp5PkBa8J3PSa
 WH2JLdHc=
X-Gm-Gg: ASbGnctHmVVSmOtfyfRSDJUl5oecXOfNC1Sobs1r/XpXiWSjlMNIHgXaw5mEmaqwK8k
 UinicQN7G6kuQEonIKh3mxKOd288pqOWeULwr7RASnlxqePkFOpq5oIeVIwJQqHCh52bCReEs0q
 /2CfEP8jff/ioI0uyPpkITYpPgOyw6405D3YwTaXspmr9fMRdNwrWhjT2Ta/bjkKPGx8FsLgNh5
 g0Kwp1+wZe5CTZVB2lZLo2wQo42elYXkx3EDOZC3qKTr3IAYGIdKo+Uj3vzfZinWandpRv0yUJA
 aPIIJzQWYFVVTEt8TYSdp1jd7OX5/PBF49zBzyeePuamSjSsFrkcPb+YWknq+7krWqifHn1LpUo
 eur12RdALrJO9G5ZY8ufMuZ5l7DjFF2tO12N+UOWeGjLM769Phw==
X-Google-Smtp-Source: AGHT+IHIpdYLGM9Nos1G/SKnhVAUjSG1NYf3hApGYSrDd/47KuJijV0JN0FzK9MnG+YJHUDfns4hzQ==
X-Received: by 2002:a05:6214:224a:b0:6fa:ae40:3023 with SMTP id
 6a1803df08f44-7009214990cmr163349586d6.7.1751219600700; 
 Sun, 29 Jun 2025 10:53:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730af00sm54700546d6.113.2025.06.29.10.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:53:20 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:50:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oleksandr Kolomeiets <okl-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 1/4] net/ntnic: implement start/stop for Rx/Tx queues
Message-ID: <20250629105042.00929828@hermes.local>
In-Reply-To: <20250620112707.294596-2-okl-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
 <20250620112707.294596-2-okl-plv@napatech.com>
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

On Fri, 20 Jun 2025 13:27:04 +0200
Oleksandr Kolomeiets <okl-plv@napatech.com> wrote:

> The following functions exported by the driver were stubs
> which merely changed the status flags:
> *	rx_queue_start
> *	rx_queue_stop
> *	tx_queue_start
> *	tx_queue_stop
> 
> Proper implementation was added to control queues's state.
> 
> Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>

Since these were broken (and now fixed), you should add a Fixes: tag to this patch.
