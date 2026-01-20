Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87A7D2ECEF
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 00:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FE38402E4;
	Tue, 20 Jan 2026 01:03:35 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 9127540274
 for <dev@dpdk.org>; Tue, 20 Jan 2026 01:03:33 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so34373125e9.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 16:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768867413;
 x=1769472213; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gThSgSfiK7IqXXKReOleZaiFEzA8aqgeSh6XP1Rt1hQ=;
 b=UIaoE4jFRT9dk7fnXvjsgYv1Gj5MNHYNTbuk+L6TmRoPBT0IxpLlRZiJj3VqqPsSh6
 VXc1iSccdzUJsd0xb7RK0BAVjFXgF4x55ryZw+bftchBdOioKX1xebXfM5Duac2Bc3ZQ
 IYHIK4lyp0FAgue7AHyPer59U9vVAu5PC5Em8y/nRuw8CuHzMMg4BlJl+NACGfWHt5Xe
 KJQQA+H8DVWv7XohO2VqXXyfugQ6GNbiIOhhB6mBxmOSCvJNjKBX3Zsll7iilByBoVjZ
 IZ23f902hMvmHOXSOd6BFg6nVKNeGU0NWkGK7uOTMFhy0qCP38qcpC1LuvxVBbIZiMF4
 rgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768867413; x=1769472213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gThSgSfiK7IqXXKReOleZaiFEzA8aqgeSh6XP1Rt1hQ=;
 b=tmmPuEDbACNUs+w29+RxMX/tRdQ5truScwctN0rtkBRRRsgdRqTSAawuEC7kjoi6nW
 9WCp2LZ86z4u2uWy9XWxOvzB06i3SZ08rNfdIye4TeZG93pQPqzjaDGTp6boPqOmEdf/
 4gsgvGVLY570qbD81gvrJewqRL6A/YMdeXp3lMhzk3nqcI9UBCR5tBAHVO6UY9zX0qVy
 p/yD7oCQd3sVO6kqTEUb3nuVCXZjY0odF47yElx81PhZNePzrD4JQZh7D1ypSP5RNWCd
 J1SyM5N1G8o+pFDzqpnbMJD3tl2/7MTYvbI4EaJthOfmWuA0BwkB8svyVFFPP3t3KGMm
 GQDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSb0DLEb+lMwvLJ82oDhTngTXRx9ccVuYdlSG1B9OWs2cHdMR6ZQnM7AdR0o6AIbkd80w=@dpdk.org
X-Gm-Message-State: AOJu0YxamWsydPtEc018qAmqf4OhlXt7wjp2SENDB8E5rC7J2etkb1h5
 C0XazOs1WrORCnZHTbUb2FD/vdItrCb+7qH0bdokI8tzSGoMMzoOZlnnNH35GlZKqYg=
X-Gm-Gg: AY/fxX6pNzbX1zeSDh8VjNkT55KENpWbjvOPR0v69dbSg+IZydyX0bSddCjGAuWn6au
 1va1zpyRDxW5UFIsBLoFPiCj/kJQv0F9ftBEMEg/1hVwq+F2dr5TUBWyEDDkAZ50hBlmJlyC8g9
 gbQe8tBuqqza5HSy+Lzcq8492f43krTqlECjQkChwG+ERk9Q52gXJlZrLw/6tDBCOtfNJej0W8W
 UA1KiiocTv30b9SjOF+T6LUYh02iC2zCv8tL5qUEwTdrZRMLIzWn9crD9DNOzMlBk4PuVoshS5S
 udMxX9ie0k5Olju1g6tNGnl/1IdZeKNP07SoA6xiQgtMQT0QnY2owg8gFZIuaeMgSmmJcKc8Ibk
 WQGPzCZmYkohcaEO33j55Cj0jPwDYPW0GE5WF7WsTmNFJ6seZ/Du44W8mBaVP1QSByzI0ASinxQ
 Y+wOEARP+hgzXx26zPAv9KrL+3iVj3FEcP1nFciSFy5rD2uMKEFqMk
X-Received: by 2002:a05:600c:4ed3:b0:477:9d88:2da6 with SMTP id
 5b1f17b1804b1-4801e4db3bemr161331805e9.0.1768867412960; 
 Mon, 19 Jan 2026 16:03:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c9cbcsm215725495e9.12.2026.01.19.16.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 16:03:32 -0800 (PST)
Date: Mon, 19 Jan 2026 16:03:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH 3/6] test: fix race condition in ELF load tests
Message-ID: <20260119160326.06a6094c@phoenix.local>
In-Reply-To: <3f0009fb007b410a931f4f161282cd1e@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-4-stephen@networkplumber.org>
 <3f0009fb007b410a931f4f161282cd1e@huawei.com>
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

On Mon, 19 Jan 2026 11:42:25 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> P.S. Did not worth its own patch, but since you are working on it can you also 
> do s/sizeof(struct rte_mbuf)/RTE_MBUF_DEFAULT_BUF_SIZE/g ? I overlooked it last 
> time.


Where is that bit?
