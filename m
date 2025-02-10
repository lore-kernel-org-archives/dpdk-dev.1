Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EB2C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:04:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78F39402C9;
	Mon, 10 Feb 2025 20:04:12 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7BB10402C9
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:04:11 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-21f53ad05a0so54335655ad.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739214250;
 x=1739819050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xM94kRD4ajRuEcOyEhrxKm2Bx0Mdcy+WzXM71SkpFLI=;
 b=2bZsg0lNj8wqiVs8bUSyFmsIgRgYJmhIA6o5PNrfrK/eosBmx2KT5oy+yI65DCk38W
 uUjDtraQb0ZvDfBjqyyS91DClQKbq1bOy4tsuYcVEsKyUq0qXueO0benTFy5RDr6XPO3
 uO2Fmr61rrgZPoeQP11jpJsG3uBttkjruuul24YXp/e5XdXE6BBHEEY0vjq9gr5GXgyL
 kszLAPAfX8TNvykhqssER+8uwKEGNVINFD0LyAqXEp8OpMVV/CJXpu734zMTihYiDK0c
 h9RVRqkSfXd4rMNv53C5AO9eWqd596eECFFF8Lxlfr57LhP6pBkTO3HL9NrfwtfxqifT
 QKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214250; x=1739819050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xM94kRD4ajRuEcOyEhrxKm2Bx0Mdcy+WzXM71SkpFLI=;
 b=CYUWVEzvPEyyIYw8kwTr6Kz5YlBUZolIhpac1vmBejamMp5SW2uVlAJAyissXJP05r
 K4RvPKt4SJPgt2OuN/bD7DRVqkhEGLbcpmyYDqgWM+Bur7viT3pJdR5E2bZtmlGrangg
 R8YFSb1287DDwJexwAFvgpmsS+9VAkrcaq1wlocq2MVwVLNWatnc+JBKMe/vku+/YNfS
 0XkARkCyco9fd3ODeH6lMGPIa1jN3q3UCvj1Y5Nwcrcgg6S4ElsGYe3nxgmaPRi+m3Gl
 MyhLR7dVrXSBMRmVJQKeJhY1w0eV4tHyvoqMq/cA6QMxO9ST2eNlFdPqQqfq8Tsfn36h
 JvFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ+MYVVN9Iv69YCulczJKkrx1I19qySe0uGGH9CEjKwp98SZDMdomtNSw5/HN4qo6M0MA=@dpdk.org
X-Gm-Message-State: AOJu0YzNdu1L7f9Uo6dO0IubI7TbKXO4h2aDD2yAnxgaqpFar1oyiLQg
 pfx7PPCgDnZvKjFZKRPORsgxcxFSzJIZZUgcYcGq7C3DeIEG6cIvSbzCrqYenFo=
X-Gm-Gg: ASbGnctf1LPHCc0wS7X5Itaq3nUJ6Dz6NNWL98NO6R5TtByKljS7rUsxZQBKsaMiwMT
 tO4N412AYCr5MgLY75GzTXbVVBe/W0d4RZZSV7Cw/3dhGYlN8/M7Y9EcUODNuZHYaQh/ZLKwVuY
 jfcUELmiA1BWx31mDwx7+IKpcyYfBg0qBkS1IG/uvRPD3pjOcGt7Q7Sd+3AWH+7FI85qMQgQHDN
 0/dQG74c7seCCAtl6NzzE3YLYSPlMxEfJxvG1TcYSkZOPTw1V1BbzP7c0Nreuw2+vCTF07b2xlB
 jGF8nXIpg9vVvm+NPLDPWKcV1Cb6oP8FKCoLx5UyhPPCSYAs0QFp8HLA++sZoVZz5FDH
X-Google-Smtp-Source: AGHT+IFWcsAd4KR7TwlGfOXTzsKBbezLT+bZlwDCMW40HMXN8wQUdnHci+zTEgcP0CUvi1VAv0hidA==
X-Received: by 2002:a05:6a00:1884:b0:730:927c:d451 with SMTP id
 d2e1a72fcca58-73217f8cb8amr1233829b3a.20.1739214250569; 
 Mon, 10 Feb 2025 11:04:10 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73077975f05sm4511914b3a.14.2025.02.10.11.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 11:04:10 -0800 (PST)
Date: Mon, 10 Feb 2025 10:36:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v8 01/28] net/rnp: add skeleton
Message-ID: <20250210103658.28a54c22@hermes.local>
In-Reply-To: <1739172415-48507-2-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
 <1739172415-48507-2-git-send-email-caowenbo@mucse.com>
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

On Mon, 10 Feb 2025 15:26:28 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> Add basic PMD library and doc build infrastructure
> Update maintainers file to claim responsibility.
> 
> Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
> Reviewed-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  MAINTAINERS                      |  6 +++
>  doc/guides/nics/features/rnp.ini |  8 ++++
>  doc/guides/nics/index.rst        |  1 +
>  doc/guides/nics/rnp.rst          | 82 ++++++++++++++++++++++++++++++++
>  drivers/net/meson.build          |  1 +
>  drivers/net/rnp/meson.build      | 11 +++++
>  drivers/net/rnp/rnp_ethdev.c     |  3 ++
>  7 files changed, 112 insertions(+)
>  create mode 100644 doc/guides/nics/features/rnp.ini
>  create mode 100644 doc/guides/nics/rnp.rst
>  create mode 100644 drivers/net/rnp/meson.build
>  create mode 100644 drivers/net/rnp/rnp_ethdev.c

You need to add your mail address to .mailmap

$  ./devtools/check-git-log.sh 
Wrong headline format:
	net/rnp: add support link update operations.
	net/rnp: support VLAN offloads.
	net/rnp: add support VLAN filters operations.
	net/rnp: add queue info operation.
Wrong headline case:
			"net/rnp: add support mac promisc mode": mac --> MAC
Missing 'Signed-off-by:' tag: 
	net/rnp: add get device information operation
Contributor name/email mismatch with .mailmap: 
	Wenbo Cao <caowenbo@mucse.com> is unknown in .mailmap
