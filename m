Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27DC28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 18:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02C1740151;
	Thu, 20 Mar 2025 19:54:06 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id BCFB3400D6
 for <dev@dpdk.org>; Thu, 20 Mar 2025 19:54:04 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-224171d6826so32680025ad.3
 for <dev@dpdk.org>; Thu, 20 Mar 2025 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742496843;
 x=1743101643; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMHzMGoaZnQjz1uoZP5LeZUMvZiK3WDWBUyS0rIjOt4=;
 b=DAv0laMoFP4dZMogJmbfpSAps6sfPizqSsvMmoubQ1QzOEsh2EF48dZrdFIoTCHgaP
 ULsxglSRN/yb08wjCtk79YbERHOh+VlX7oiWSMMNfNdBY4wIJKtxRGCwUBe9vBheIJSZ
 MhfhyIAZneg3hmkJG+75AldqkuB4uxRtuLKP0v6DIkETENIsg8n+fQyf8x35dwwNQtfQ
 MQnHzrESUkjRUzD2F9SIrXg8zc2ckachwD9d4Qr6FIkk+6j4NOTIx87+Tg5wIazBNyZZ
 2mZ3TUIu5R1X5/zEHGmeIcD807OiyPm288e6zBopjllbPmMzeXN3r2/cS560YMN+j3ox
 87BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742496843; x=1743101643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMHzMGoaZnQjz1uoZP5LeZUMvZiK3WDWBUyS0rIjOt4=;
 b=VVzCGxQ9VqZrxpws/MXH2iJK1pL6XC1bF6BgocV/Sfy3AtNawcfwAEgPrRO4SgHUmC
 8bRlUkqlPr0cqkfIS4N9jEoCAQNSnY81bLtHo3WPLax7RSAMqkXMYB4Ibf9+1o8xGmXr
 mmg0i0/S6QM5uWDHImb68iSYhzFiPghFeaC+F8HWh8As69EJXM8ZBHoHqj4guUotcqja
 lVX/YnVAYwyZW7nXfLcHRI9JpQXoA06lp/BXtF7qt4ldYzsDbKny9n+RFjOezm4rU+6h
 /r7BYgpwOyD+L/kxPNC6D3axxNISPMk7xysByunJO87ldElt+AUbVzmKNldZLVImD8iY
 7/lA==
X-Gm-Message-State: AOJu0YynIit0oocCK6eCj7enVQSa3YYgAqyFZxpRodayi9FJvngSO4HH
 1PEKFffWabjx/j3SgfXtTFG/3SPI6v7iTQFiHGuHhY0QvHfKI2u0+E1WkvbvjaFnaO288W9mZa/
 A
X-Gm-Gg: ASbGncvCukugnSF6xF7ahsHlgsr2nTz1i619GuXUVGviHm0l6oUJiDDwbtiGEyxZEI7
 mDDIMt5XUph9Nq7XHoHKsLAz4h9yVmQiNyGKlOlH61mC2zew6CbrhBF92rKwf+3J6hrMLE5i+Y2
 y0qTlnFSxl/7Sm3W6rXY2ux8jDmBaciHjQvR11/OR5A5I1Fn/cMITeHmYmlBqm3nvkAXupnrvqA
 WkikQ7Uv1bdaKJnDPgLR5P5+W9Hi60STsmmIQ9v65zD8TORi20FAkfg62AbPQcBnS33S824giGb
 JALJHrbsrrjrl+h4FBGQ5qeRiLNT05XImyJP8VOglwd9JGYG8jwwruRN/y39Naa9uYC2uxpC1xQ
 vnRS7wrDvU4FN19dvpTLSsA==
X-Google-Smtp-Source: AGHT+IGc8Wc/9jNpvOac1Itx4xpfurDabGh67Txb+v5jbDz1IfnYmz8kML0tw+2uPs3+c0CH0MtqWA==
X-Received: by 2002:a17:903:41c8:b0:21f:7082:1137 with SMTP id
 d9443c01a7336-22780d8aa55mr6116185ad.22.1742496843556; 
 Thu, 20 Mar 2025 11:54:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f65casm1266985ad.230.2025.03.20.11.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 11:54:03 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:53:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 4/6] net/macb: zero ol_flags in each recv function
Message-ID: <20250320115353.57423556@hermes.local>
In-Reply-To: <1733814479-412155-1-git-send-email-liwencheng@phytium.com.cn>
References: <1731310932-1743343-1-git-send-email-liwencheng@phytium.com.cn>
 <1733814479-412155-1-git-send-email-liwencheng@phytium.com.cn>
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

On Tue, 10 Dec 2024 07:07:59 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> Because macb driver does not support hardware offload, ol_flags
> field of mbuf structure needs to be zeroed in recv function.
> 
> Fixes: 97fd6a929cf8 ("net/macb: add new driver")
> Cc: liwencheng@phytium.com.cn
> 
> Signed-off-by: Wencheng Li <liwencheng@phytium.com.cn>

Don't send incremental patches like this.
Driver is not yet merged. Pleas fix the first commit instead.
