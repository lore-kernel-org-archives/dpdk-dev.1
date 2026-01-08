Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B70D1D478
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 16:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1F69402D3;
	Thu,  8 Jan 2026 17:10:20 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 350204027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 17:10:20 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso19833515e9.0
 for <dev@dpdk.org>; Thu, 08 Jan 2026 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767888620;
 x=1768493420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Foqnl1uOZxT/bgzGoMD9C9mUeTw71EFY24dUnN1Xfv4=;
 b=3XTHFxNK3ltGzZcoFrNldjpIOKG2NlZra6sr1Bniy+bUHfK7bIvgQcXc7mWUnSknM5
 s2bl2EYEnBiXVIAaZVOnQSoCUX8Bxe17neR84rjPV9gRgMot6ZT8OMMDCKM50PjLqes/
 k3/Z7GZqj4qDgR7mPQL1621kxvIq5EXi8obdpL4fcC15vjp6GnlD+u+hi7Oy4pig5x5q
 FORNevGfqdhRRxXO9/G24xdVVcfE5rCPPv87kOoEGNqrKPF7twE+3r0zFvPCxko5gC1T
 BkRMT3NvIt42IR+zswQN7GkPK1LPEZhyxIAU9ASd0nqW6rmKGG5K6oHDzOFex6xJqMyj
 Fk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888620; x=1768493420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Foqnl1uOZxT/bgzGoMD9C9mUeTw71EFY24dUnN1Xfv4=;
 b=aRfSp39sSBA7NE765RDDC8eSd692l7TAf94pOuFnUbBEqSdUbmBt5biHh/5qIJtpJe
 PPC1vNEIjuJpiDFOTFXJ//YDrvRr9zMMlGAyYD8iYx0dxADReYosWC3cHZegh1pmAZPB
 5DOQuu6Mp66IKgZq7uR4u6LdP4JUdeOvu2b/pyyuUdKyhN34blY04tnVUHzZEzCVE5Tw
 3GtIzmGrx41mSEJ1uvTZ8cS7wB3eWo367sTgkSaM9KYC3DyKsK1P1PpA6vbcJyb4z0Cy
 ZJyVnon9yJEbfr0msmEkmRty03c0DqWWtHobjZHMHwCKCAjXs8BtBXhfbV0yUDUEBwHC
 7J7w==
X-Gm-Message-State: AOJu0YzfNeyyBbh5GsRPUwdxP+1TEEwHq8im3X++On0AbVtVdTOW3fd1
 27eMwloae8k61xPPzoKHd/Ff9JV9Jb/DQiRzygKX4jAeO+Odv/bW6ltonai9pHR6rVz/7THA5iO
 iP1Bp
X-Gm-Gg: AY/fxX7fRdpB7GWpqO+Y6ev7Th/n3X0Lfi9QZqKxAoeMOTZPmw5qfMSFyBbDUSrGcQV
 lBP9yc6pHMqTfxRW9RsHYWWjvNBuBZMHSfz6s2nRW1agMnMK85xw8NfPuXDCJzznDSPhS3by2uK
 ekFlQf71Mqu8io6YTNfxHS00ZgxAgeTmAoS5XHW+/nn+ba6PnXm0SLjdUp5+ivpCW8VhEA52rrf
 QNcWC69tCVFIHMCIluq1c/jvVMWduzAtAJGADZAtRgM1TXsAIEucb3+xZYmkPgm7eoSltTz0RqQ
 kPwIva5LqNPKm3eTMpHfGH7jqyf1ILlkPLBsqfcQsT8mMGDY2RDHqyvIUAdUHXJggqZiCbwFEX4
 Hrn0GchFH7iROPzvSAisTjxlzAmRuf958o5iaEIAydgFR4jkhUoG3YGQYrEi5TpUeISmnWUY9v5
 ozNlt1+uG/3QdOoAIZY8dqLFSHIEUoGO+aiJXwYZHXu2I7FUs0y55z
X-Google-Smtp-Source: AGHT+IH975sQ9BMBIicus7ksNOjH3s5hmZEVBpS1+20ilQE29WMAoGwg+ejK1VFCf3Sg6Cucr9djXg==
X-Received: by 2002:a05:600c:1f8f:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-47d8487f5cfmr81181685e9.17.1767888619438; 
 Thu, 08 Jan 2026 08:10:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d865e3dfasm40034745e9.2.2026.01.08.08.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 08:10:18 -0800 (PST)
Date: Thu, 8 Jan 2026 08:10:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v5] net: optimize raw checksum computation
Message-ID: <20260108081013.730349bd@phoenix.local>
In-Reply-To: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
References: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
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

On Thu,  8 Jan 2026 01:13:38 -0500
scott.k.mitch1@gmail.com wrote:

> +#ifdef RTE_CC_GCC
> +	/* Suppress GCC -Wmaybe-uninitialized false positive. No assembly/runtime impacts. */
> +	asm volatile("" : "+m" (psd_hdr));
> +#endi

This seems odd and like a compiler bug, there must be a better solution.
