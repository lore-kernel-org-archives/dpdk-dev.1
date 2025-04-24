Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEB6C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 16:13:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4FB6400D7;
	Thu, 24 Apr 2025 18:13:26 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 46BFC400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 18:13:25 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so2136488b3a.0
 for <dev@dpdk.org>; Thu, 24 Apr 2025 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745511204;
 x=1746116004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75h6DZk5yirBROsORoQ2ge0jl2lusuJ398dgripO9F8=;
 b=gmCp5vFJxrTfkeS6/DAu+0keQjH5zuoIDvwBeVNhqoEu/GQdonX6bDLJOl4rwx7PGn
 MSOV8J0Rbu3pezdWE9EfWI9+gdZAp07UbOnC4cvGGIVuq3WZd6vv8d32ZQ6eA1e0dtUq
 2hLA7QGk1C02tk4QuiLsAQHJf+wjoaXIFvAoviHUU9/o0E7alTZdN9oebFhW6uWfQDn+
 1zvXBohLwIpBGeYXKqrABnH3zFuI8FjjUxYCR+7PM4pUONnvoUmFlQdEQ2JeUjyD75P4
 BVVTxw58I7J1cCjBm40fSpf36JCsNJPlxwgZpHzLb0dWY4V0Riqj5LrGU+anYuJza7YH
 e3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745511204; x=1746116004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75h6DZk5yirBROsORoQ2ge0jl2lusuJ398dgripO9F8=;
 b=JR5WE/8JXAS4/hbwHyWQOAP+3OIAeC6XCM+dukFHDm4lL4tKl2HK4c29O1FiHn0FE2
 yJPyPgo52+ye8iGhfNGBg07ApCv5XX6Yzyo+C3OkFn8rHZKy11Ych/L+tqJVaj1R6WJK
 QMptN3ywffeVzp2dF9UtyVOP61WV60D1h27hRLY46AOp3DJMrmTJpHC3T8XOgc3qziBp
 UBwMrBqOZQNHnnX1SONDCIGj8Ut00/JUVaEJ0wHwHYDDlvxPbinAR6726oSeN8gnpjDV
 +tf3xAC9ACCmG9/M3OWFVNThVz6Pcj9DtQ6qjTVdPb085iYFwqq/D2NeBkwdc0WCzQ0T
 38+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR2RZTIogAx7fvSJ3UBgticVEljBAXFz26WDLnB49E30TRCdqNs2WW1CNHGwX+ne6bgrw=@dpdk.org
X-Gm-Message-State: AOJu0YxiDMdtOhJnhrBdaW4bKAxtex49JtVi5TotwxEmE2C2LdCOgL8y
 6D3IufyQeMrmXnToUncQjbyoxIECNx5gYeKadxkMb2+8Ko9NLnpwbnWR2dqUhWk=
X-Gm-Gg: ASbGncu9aQNFX9iXYrKg4jHcwqFDfTJTl/2J8C9W11CbYLD7YFicrbZdc2qCBFTydfD
 JKtE6sgurVU373Z+65HvF/GkxP/pYfMw577l6DSEyXNk7LZDHUlO4BjEXd0rs2jMVs0HW05xcYl
 KfH2VobqdSax1EU+jrw4d7/Sqhd0hjdXZEbR0qj6Bmn1Ae9sJmJTDXsbJFpUAihj1KaWyt1DgdH
 jtjNRunzPwKHlX8ryrWwFjiG+ARLwCphp+pPta1qQxHWdiuIMj/bVs3WBn84Usjvy9cQ9AbmsIi
 5T8MZSgzQWpHI4XqOW4EIgP2OiFThBNrBSpQnnKmQZYGtPJCI5WC4YRPaaZrl9bbGNz0qiwLwGb
 8c9WoJy12H82hHtJT
X-Google-Smtp-Source: AGHT+IEVOgQ3IQTJdoxAnNglkU7sBIW/R1hXI1iC3Jh4TC5BYPdYG6oTaAwD/uAMvjlHMfnmpJP9rg==
X-Received: by 2002:a05:6a00:4601:b0:73d:f9d2:9c64 with SMTP id
 d2e1a72fcca58-73e2684145emr4140679b3a.10.1745511204319; 
 Thu, 24 Apr 2025 09:13:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25acaba0sm1574544b3a.169.2025.04.24.09.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:13:24 -0700 (PDT)
Date: Thu, 24 Apr 2025 09:13:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Ori Kam <orika@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>
Subject: Re: [PATCH v2] ethdev: add support for flow action pop E-tag
Message-ID: <20250424091321.478e6c46@hermes.local>
In-Reply-To: <20250422054717.1253650-1-kirankumark@marvell.com>
References: <20250422054717.1253650-1-kirankumark@marvell.com>
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

On Tue, 22 Apr 2025 11:17:17 +0530
<kirankumark@marvell.com> wrote:

> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> Add support for the following OpenFlow-defined action.
> 
> RTE_FLOW_ACTION_TYPE_OF_POP_ETAG: Pop E-tag from the packet.
> 
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>

I don't think flow actions should be added until/unless a current
in tree driver supports them. Please defer this patch until you
send modifications to a driver to support it.
