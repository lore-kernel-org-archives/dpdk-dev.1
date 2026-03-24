Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F320DF54AD9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:48:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43AA6406BA;
	Tue, 24 Mar 2026 17:48:54 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 28F94402BE
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:48:53 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12732e6a123so9182563c88.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774370932;
 x=1774975732; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuabhGcNycc70zdwuQUmuzXosQ82nl54Ot7RZguESLk=;
 b=vyDoKNIRyrPmPURv8x1KgCTss615cyMcLRaWfisW8SSZrG1D5x6pmQmJZLB1hzKKY3
 V5TUaRZvfDqCXC5Crv5In4MUFeSNdeeS30Vi/797YtVJzackaaxVB9Pc5g81PiVffw2C
 0KXyXQvZ9P5gjZH4kTTWcRdDlDQQdpWrjbcwpbHy6AqZGJl0tCTNgOCEi8ni44/bRry6
 G6JlJ+8WoaApmMqvTYJK4lKwjUwdUIE5mIuP1rHe31Muriinm1+KYHAMdpGTsCAvzusa
 sk6W42UhP47PmoWZ5KsCDO+2e9aGY0Y1DL9DpB3iktsu8sLL2rrcJ3L7A4UXhhUBrOaF
 M67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774370932; x=1774975732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FuabhGcNycc70zdwuQUmuzXosQ82nl54Ot7RZguESLk=;
 b=kzhnvfz7aOx7pR6sXCPK9z9Utdle1jQTu1g662nZZU8APpuykOQee8irtZzOVpS81u
 c8vE9LAMJVkMQK1gAZR+HKT6psV88mGSPwbmIEQpCiO+BhaPre9vDjyPEJudDTfpV5jh
 dZzcOO0CG3lgRTjMU1t30RhaO6gfrU81Fbyx/e7uOlBSm2B3HnTytL5x3M6LhmwLwRyK
 hoCYM6Q5bUG2sfeIVgieqAC3mJTXStT4oknj+m27FQ59AvQ8xQf6WSgxb1Khk0XbBnjp
 6TZmJROYcKf/fOTEKtdNctPN2Xsq+M2349OHOOMrWiXzU91NErPagkOEHr8TDQSGA8Bn
 3bmw==
X-Gm-Message-State: AOJu0Yz5aH4SNjByHOYbnLzu3cne61bi3nXJHCM2VSxoT58FINQPSf1W
 RNivdSADyzLwrcTKD+Agm7QZhXAhvHtuFM3HGfBlzHoSoI1Yue9g9+doNu66nijGuFY=
X-Gm-Gg: ATEYQzy49QASoLVUEnCPiDTSq4t5+bv503HsovgPlmGd0zUgQG2OkUJw9ib7i96N4PX
 GLmrqysKb+1iD9xcOXaeehudOFNBRszuSV7OBghtmsVG+YGqQq4ECs3DCNVwzUohIbnhZgFKaPf
 oJ6pdMRKR0YPYpY5UI0uvxK9C59EpNlb4Ua0MZ5aQbid5TyborsBuqRROSHgjLNNVAQXKISd20J
 C9cuwVZdY0M2zZQtqbUDAk+HXckEZTKPqic6SoL2l/34uC+FlnwGYraG3uLYjawJQC5Hr7SdM0B
 3wjZeOvxT2cEAL6nQV0qLO4oXztdi2qNYKZqvV+tebYZV7bcIpmqo1+wkkOmDg1qwPSuxtoDJ++
 dU/qpC1l25dQ+GrfTAOdfC9Ti5CvNu5kfjpBIV4MTfxs7MEiiMEabggRnnHLYGl06GxcVK5Iyfu
 DLel+IIJaTx7tilnvW4RhVihKRPVkVn3g7DWE=
X-Received: by 2002:a05:7300:c618:b0:2be:f15:c536 with SMTP id
 5a478bee46e88-2c15d2e38d8mr74193eec.14.1774370931865; 
 Tue, 24 Mar 2026 09:48:51 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2cde3bsm15590248eec.20.2026.03.24.09.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:48:51 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:48:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v20 13/25] net/pcap: add link status for interface mode
Message-ID: <20260324094847.786db627@phoenix.local>
In-Reply-To: <abgPo5lcjWccTMCL@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-14-stephen@networkplumber.org>
 <abgPo5lcjWccTMCL@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 16 Mar 2026 14:11:47 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Any reason we can't in future similarly query the link speed of the
> interface in use, and the other link parameters?

I did that in earlier version but it adds more complexity.
Each OS has its own way, and doesn't work for most common case
of read/write to file.
