Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37335F8D76A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 19:01:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F38E40668;
	Thu, 16 Apr 2026 21:01:38 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 0439440297
 for <dev@dpdk.org>; Thu, 16 Apr 2026 21:01:37 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso8687284eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776366096;
 x=1776970896; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDTVeUDPxo4DJIyoLcQX3ciPFTipmOikvAeE15V90CU=;
 b=MuicaufGOIXyUxQ3aoZyeUGFA65al14/9NPIELMMuH9i3Q7p9A/wwhmvH7naPrVsnT
 522jdIP9KSQp8WsOzs44JddR6DPtPo8iuLTdnaYuyeSzdgHHfWbhxqgdL1oNnuFW2EW3
 4PmCjppBE8dqg/3WM4yy8eL5tKdA0JyDdCTyNSXSxKCexzdNtdLkzAKY3TH4FKtC0Za5
 35a521I6BeZAkVO/bqlNztp7mOAkrbxVl6/VS9tQEJz7KrkbHk5jPfKxBOfH33lffF7h
 2RKGNFY+zdRMwAREzhOSaA1aBlU/ZsDrWINjGa6syVUu7hn7u094Rq8gHX+vvYp9XWco
 OR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776366096; x=1776970896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FDTVeUDPxo4DJIyoLcQX3ciPFTipmOikvAeE15V90CU=;
 b=GdnYVMmxJ0k+Z4SIiunKrgzzIMjMTafryZtrtrFYPtcWCfJeTxTUcUx1Wv7cyL7/1c
 37YNXK7xHH+8sMZidC7QI+0tCi6Xr7WE97qI5UKEpZ+ALImWBHwmGLXw/BremQCY6JWL
 TDYhY4/wl66QbwG8ZQQ6CiR6unmr1kmWj2h1sKxIerWtwjoKzDXox3ST93xlHLLnnH9A
 OdtGFEVf3T7Rynr4BJnIhgmwCs0El4tpdkvlVNZYnisg7mR6ct6QyPvZnFtMOmXROH53
 ahFjgyi9ey52gRgwz80fJ90RSu2AZno9y6+zFi80Op9u8U8PRzkU2YcUUvHnXl/Gr2/S
 tebA==
X-Gm-Message-State: AOJu0Yx+QEFfPJskc1H/3w3+GMcqT70Ps1iCB+LGfP73n8wkWbF5FdDl
 8f77FWNUesSeF1559SCENFLrxougknpdPgSGZlAxPIcctF5M50sOPyOLv8heMWOdyg4=
X-Gm-Gg: AeBDiesQ0ZAzttVGHZCrBuESncYXgOdMhqQshY538FRI7dLedohvGUdjB0A3dtlZlzF
 7GBzlU9eGRq3w/eVofrX/MX7pBek6SEXUSgrIP+x7aF+jNSS3LClN+WNbfZGj+6YgrNJfiXLPFh
 zlW+HlwxDay7WzVDh4qIgGfRzfmGcyo9rbrWsXX0ZlVM6U1rzLSTkPFSkFy342kYXTChmvfnOTe
 K2wyrClpRdE+zk6y4WrP18LLs7uhs0A+NNMPMiwLwaQLLy9eheeRc6fN73TTBhWjYVYPrc30lL4
 perekXctEUHA911YZKuPt2Cn/pueMBWU5deFKcl9drvO9xEtomk7on/1NEPi9dUldo6jHi7X5n8
 LQqah9w0C70yX06UeQZcYz05IHe0aJpA6WHA6vzeIhQj82acDwpNJqB2hRH3WzjGuI7rhrevhyA
 wgJt71wDAXexG1mfRsp9SVyWOzuOdxT9VAQ7hHkgT5xmBb9A==
X-Received: by 2002:a05:7300:d717:b0:2d4:94cc:eebb with SMTP id
 5a478bee46e88-2e2e4c37d4dmr262846eec.13.1776366095402; 
 Thu, 16 Apr 2026 12:01:35 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8fd54ef0sm8196741eec.29.2026.04.16.12.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 12:01:35 -0700 (PDT)
Date: Thu, 16 Apr 2026 12:01:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH v4] net/axgbe: mask unsupported PHY half-duplex modes
Message-ID: <20260416120131.12f2e761@phoenix.local>
In-Reply-To: <20260416070526.1504-1-ashokkumar.natarajan@amd.com>
References: <20260402065450.1074-1-ashokkumar.natarajan@amd.com>
 <20260416070526.1504-1-ashokkumar.natarajan@amd.com>
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

On Thu, 16 Apr 2026 12:35:24 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> The AXGBE MAC supports only full-duplex operation at all speeds.
> However, the PHY auto-negotiation configuration could advertise
> half-duplex modes, including 10BASE-T, 100BASE-TX, and 1000BASE-T,
> which are not supported by the MAC.
> 
> Update the Clause 22 and Clause 40 PHY advertisement handling to mask
> all half-duplex modes while preserving existing PHY, strap, and
> vendor-specific configuration using read-modify-write.
> 
> To maintain backward compatibility, full-duplex advertisement for
> 10/100 and 1000BASE-T is preserved by default when no explicit PHY
> advertising mask is provided.
> 
> This ensures IEEE 802.3 compliant PHY advertisement while avoiding
> regressions on platforms relying on PHY default configuration.
> 
> Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
> ---

Looks good, applied to next-net
