Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E808C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 12:14:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C6FA40283;
	Tue, 22 Jul 2025 14:14:29 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id AC5A040265
 for <dev@dpdk.org>; Tue, 22 Jul 2025 14:14:27 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-23694cec0feso50699715ad.2
 for <dev@dpdk.org>; Tue, 22 Jul 2025 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753186467;
 x=1753791267; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZPDCD75v8lA1R3U+m4mWKsFegwnaaMZoRvM53N1FIU=;
 b=WqCns3W7B9ii/oKsrIB/Ut5GfFWkPy395nACV7vWx658LmhYz/+VbdqLYy2qJqh8DL
 froO3kK5+1ZdNVY9EIaeFvO1OfnGsik9gHMrrCOpteiAT9V8jnhIJp2UMd+y0HeEWQEB
 8d+gkphj8LUNcDEKXJvSHwky9cxzdW5yaP3KUnrZxYa2h3tviQjow6Cih3MxqlqmVTCd
 kH0gKjC0WjxKcX4XaufFm2gw+tdsy+gs4Mdx8HvjxpDNYnAHdvdMnMvWQm2bNBJK7iS1
 Yz0b2KPw2yAOnLhJ7t2e1rcDMqH9i/KB3h5okPqmD6o29+PJJEuqj6IO7Kw/YodCjjHg
 F3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753186467; x=1753791267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZPDCD75v8lA1R3U+m4mWKsFegwnaaMZoRvM53N1FIU=;
 b=vqTaN2LXYRyEeNzeUVJ2cWeDQ142JlwWT9+LhtWcCjkXRb8RjZ48EqEFa12tsPSUJL
 DsZe7E+VWBoPh3yJlva0UQIaAxAaQVZJgj+02dzpRocak2Q7H6sKi3wMGOtCYMmpNTx9
 B+1lG5jIMio23ywpHOKg37WL4ssVB5sDcQ+yZBaXq9l5UYG5rDrDePLepbbQqctEZ/Zw
 0VutpOpAALwQcUHU4ymTP2nd0A97rAn2gtLVb9ll/xngAfrh5fCUPrYfr+KyY7H3z4BX
 s2KeWVfWlMQzOWUMcbN+RFBI+um9Trcqo7SDVwS2aJCi+JvHOCTqifVIqOi1F+3Iw3tp
 Md9Q==
X-Gm-Message-State: AOJu0YwkGU4jZlEvvzu/LD/gC8QhETqh/MirK/M4f/dPvHJjAx/90iat
 Fra5uv2tIpmUyyBOixPye56R/9i94rbs2Ce3vMSicoiQuh/GUNBUZm5Xeb4jvyqLu+4=
X-Gm-Gg: ASbGncuZLg5cyzzBLYo3VLtcLmA69HR8j4O/YZ+pHWxaU3VQaWh9C4jY28fNTkoluVp
 ZLgWpPsHChbaKblC1fd3wXwtYPJTwqCDdhsb2cX088JzwmhssvtQwMfZuL9a2B++QWR3y3nL4LJ
 eMIVpLc4hnQXD0P955wxGn8NBoKx40hTwW1Gb2PpM3GlFdvjoAfjGiQI+aK+eZ6KMcwSqGsLtkG
 ncNPekHCiUqm8QRmY5AONRTwhhC0h3AiKq/Pv6ivu/P+25yihvsxC3/V/2p/BMQ/kDiq1eAEpKY
 eOxyI8254brGWs/qXaL/X+bV2qKWaB/g0c5Yp8zU+FDHDDQ06LoA2liI/f0YlKxhgb/kMhUTqPs
 dC+NUJO2ymxrdnlg31Ti/DJOExAJYg9hvsmlCEtE98IOFY50B
X-Google-Smtp-Source: AGHT+IFRmzdAMOq7dYhBrj9CLMfZRdqGvnnhUA9UuafjitJNKYHQz8y/qQF8GL1ZElyw/MxGhuthzQ==
X-Received: by 2002:a17:903:183:b0:23d:fda6:1aa6 with SMTP id
 d9443c01a7336-23e24f59be1mr334114045ad.41.1753186466743; 
 Tue, 22 Jul 2025 05:14:26 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3cb7sm75557175ad.17.2025.07.22.05.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 05:14:26 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, ferruh.yigit@amd.com,
 dsosnowski@nvidia.com
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org, viacheslavo@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH] ethdev: add dev_private check for secondary process
Date: Tue, 22 Jul 2025 08:14:15 -0400
Message-ID: <20250722121415.1357967-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721140127.r6orvsqsox7ytlhb@ds-vm-debian.local>
References: <20250721140127.r6orvsqsox7ytlhb@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Yes, I think this can be addressed at both the PMD and ethdev layers.  
To centralize the logic and avoid duplication across drivers, I’ve also submitted 
a patch at the ethdev layer that checks for `dev_private` accessibility 
in the secondary process context.

Please see the updated patch here:  
https://patches.dpdk.org/project/dpdk/patch/20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk/

Looking forward to your feedback.

Best Regards, 
Khadem Ullah
