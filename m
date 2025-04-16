Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B54C369C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C6E40FDE;
	Wed, 16 Apr 2025 18:38:47 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 354C640EDC
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:38:44 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2295d78b433so73828005ad.2
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744821523;
 x=1745426323; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKgvJNLSZxmeiV++yiML2j7rw0u4A9S9YSC8bf3Djzw=;
 b=E++LYqlEaZZ9kte+CfGEzF5FrMyBQHRTMtxQhiXvbG2PeuwZQ48JSwRS/DJhv84dAZ
 g0NYRrOfoEeEEdEL058JJoO+7AYpIu740arFY7bpI4hIru8orUgnsa8McqbSEqnEfOf8
 nziIDLTC2KSSoU8ssjD1Gx4Ilzb1vZpz105FSxyCBtJubs5Oxmheg8UP2XsVwMZiehic
 52BDcuGzyaYCjWZ2u8CGnW6igXtb2z+5ymEk/3rEIzHnc8iH6mM3KKqoOx/xEmixvIMN
 TG3ZoO7Ppk9bLBg8ihskIJbJ3bdQg4AkKFvI83J4fwel88Shw/8m/bGjx+QU9/4gJuN9
 nBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744821523; x=1745426323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKgvJNLSZxmeiV++yiML2j7rw0u4A9S9YSC8bf3Djzw=;
 b=mJD8irLaEnBN8QffMhXZ2UQClgjhW0Pn9Qi73I1h5K/jNFlvl17FKaZevI2MiV9K2M
 4me3dyyslnIZOJ/3O9WNhLMHah9y7hrDLNO2GeCQ9aDseZf7k4LyQSO9gXlvFv1XtiRw
 2wBArrrp7+s5juM8aV6Axn2xiHxIh2J0iqj2cKJBwdKfkHBb4Xk0hio1U814nJKf+hi+
 HSfEDjciKvEyn9iPKJeLwCikoYbJk1oau0Ish40dhtJrr/shYWh7vb0mEEN36R68B6o/
 ll8Z34izpvF0qlUdf9H9CBL56M/kIW/y++OKXBmZuPA+X4Zqc2CiofHfnNb5AB3pNmeF
 Bxbg==
X-Gm-Message-State: AOJu0YxD/7OubPncTqCa1846TIARdXmIzF9394LUHkzzCCD6Na2yZw+k
 lBJdFz/9tj4fj761GRBCUPw84yGTV66027MKOiE4OUgpgMcXZNulcLpouhJ7o4Q=
X-Gm-Gg: ASbGnctvzaHhKIBgVwtWye0xtrHc+XaQOCEFiFACxMNT8RYB6e+/5RQiAz0CVCBAQtI
 QbdL56GDmyZw3WBiCAuKnFhDIctU9jGE6U8rXPx4wyQ++M+GuiH9PXzGUap2kGS54Q36xI06D1f
 ARPZTy+qF6Etxif2GwBCY7BSZoe1cq6Y9LtZjbg0BphtYSfSXVNIJYldVyGBzn7z27OlW0p42PZ
 MerTbS8BYM6F/t8qn/GWmT1MVLgQS5vRZJe64ckFd/3V2g+M7FxRAR2x/JN8dINo8NsOASaVLfB
 vYikXt/TnuUxRR0UHXYrp2JizFrlnJgtx0f6U6wveVedQ2uHsq3M4Yn8El+p6liLTjFN+0Munu6
 Wz0haL5wqq7eTCrpl
X-Google-Smtp-Source: AGHT+IEBj1UHvN5x1iW6l32CpKlPJGbxkHhdfu+n/egE9x5A54axfNXa2LIPJsWWfoYqpk3UsVsFNw==
X-Received: by 2002:a17:903:1a30:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-22c35974260mr47944285ad.34.1744821523434; 
 Wed, 16 Apr 2025 09:38:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1d414sm16413885ad.56.2025.04.16.09.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:38:43 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:34:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 2/4] net/macb: add new poll mode driver
Message-ID: <20250416093442.7f0f2299@hermes.local>
In-Reply-To: <1743577136-119797-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577136-119797-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:58:56 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> +int __rte_cold macb_rx_phyaddr_check(struct rte_eth_dev *dev)
> +{
> +

Dont think you need the additional clutter of __rte_cold here.
