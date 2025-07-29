Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25885C87FCA
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 04:13:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCACF40668;
	Tue, 29 Jul 2025 06:13:18 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 34ACE40647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 06:13:17 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b78776fb25so1120213f8f.1
 for <dev@dpdk.org>; Mon, 28 Jul 2025 21:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753762396;
 x=1754367196; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDDOpB2+dZ1P8cx0y8HExIlJAx8uaUZ9IT9dZNwVOns=;
 b=JrX2vf3+xBqvifK89dLwqUJND/clCs0VMunQ/nOfgak6N85/AYotUcDW1jh97XEj9H
 CF037LfAmzUTj4GqeO3h2xqMMPCkgrUqtMJ3M7C1BbGUJseSDtaON5u+COmxvKgvuWfK
 Wa/zWUWx5LaAfkQnFPrZ0JgCjrYTTAj0iA3LJRJ1t3gU6N3pQaaH135NbG36odPv22RJ
 cgjv2RtCDYVGpvJ9xC7cnkLAgti8/9wo9duKeqxRJpo0jvfzGS2MhVraW8O6GlyBm/ci
 YgM8SYnZs27GkSymZ7cNVjvXeTxviHuSK1Yko4SDJ7lDPVc+s3z8JtVAI8sJxD1oboDP
 6ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753762396; x=1754367196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDDOpB2+dZ1P8cx0y8HExIlJAx8uaUZ9IT9dZNwVOns=;
 b=WzliQm0yTIWekA5zdElqyp09+gTmZ8nqPj+PGY9SS6/E+7SlLd7MfeWbIK3phUPKtO
 gRfriYrgbxC4YSOfyG7xgpIeh1rsB80ILVJQOb5N9lazjX68LA6f35c1dYX7qCapaayI
 kb2v0AY++fzDkXKFmPdgs6Fj6SLqYToq1cl1kTFNH9d6aBH6IquWkkhW7xw7v9w1Ccfn
 phw+GDHJHTVtuAJ1IUMH4OLIUxkSF/6ieam3BuoZxmRMO8W45xz025mbSp/hsQnUvfAc
 7DMdh09VjHr3psRmKwGHIr9N3e8wkmx++EGgA/EgX8nIDEZ+KCQKEUwRz25Rma3dGZfg
 4uBg==
X-Gm-Message-State: AOJu0YwuIsXzGyF21FQ62yWXbYJFJ+kV7uiUG7GgtM7Q5jLDUeaKmDId
 egd4jpfDKLE1FCtprMl2rj4MONA6xMmKzBZroYlcRixpjK51iqnH6DpL3T1hrEfM9ck=
X-Gm-Gg: ASbGncuVOVfhW0i3jVmw85Egyq1CN7+W97zXCE5KsR27rcJ0yL3NwOoj3FQs/H0nNMC
 GQg6zwWMka8nu+nWE2Tdy/F6vgi9hTgi7QQMR1dNH4MIhc1KYLj6dtAs/kdgy7QPZCSJyXlcumq
 fUfHeUHqOQ28JdCLbNKRY9NQKfi+jvIOytE40sJK2cL6zkJ8GY6kqDndp1GAAc4+mFw6lSej7aF
 7At5utNw1+D9Eubu0jST6fUaCJeo+p9cRMsaFQdemiQZk+PE9GQ8+RnvV8AWWf6YbBEKCFuo/6K
 nyzzTGk1xxvgHsnM7NM2T3dkcFmGMoJ9QE7uq1TexgvtkSDzHJXE0qYGimfHlAzLSou0Pt9UL1F
 TY5UtH4dJAf8esMRI0YY0/3qiqX1M5xM79nl8GC/sMtQ2EhajXjAt5WRL7f7OXjJWYynKHApHlX
 o=
X-Google-Smtp-Source: AGHT+IEPJirhrCCZXEdaDwRRgHvpssqZyP5aajupAdrWDOV3a0eV0YcdLIm5nU2nKn2GfUNM86UTtQ==
X-Received: by 2002:a05:6000:3108:b0:3b7:792c:e8d9 with SMTP id
 ffacd0b85a97d-3b7792cebc2mr7503180f8f.14.1753762395766; 
 Mon, 28 Jul 2025 21:13:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7822d8cbasm8662435f8f.68.2025.07.28.21.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 21:13:15 -0700 (PDT)
Date: Mon, 28 Jul 2025 21:13:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, wisamm@nvidia.com
Subject: Re: [PATCH] app/test-flow-perf: support testing the flow tables
 query rate
Message-ID: <20250728211310.4330fb6e@hermes.local>
In-Reply-To: <20250508023638.37812-1-sunyang.wu@jaguarmicro.com>
References: <20250508023638.37812-1-sunyang.wu@jaguarmicro.com>
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

On Thu,  8 May 2025 10:36:38 +0800
Sunyang Wu <sunyang.wu@jaguarmicro.com> wrote:

> Support testing the flow tables query rate.
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> 
> ---

Applied to next-net for 25.11
