Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01451C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 14:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C0B2402B1;
	Wed, 30 Apr 2025 16:48:53 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 32DD3402A0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 16:48:52 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso8030829a91.2
 for <dev@dpdk.org>; Wed, 30 Apr 2025 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746024531;
 x=1746629331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sapTnwdA9KGKXVMsi+Y5OOkpFlF+Za3s2CpY8AEOGFs=;
 b=KFkWIwNv22YrjFXRDGZFrYIzwEMWN6fgfHEaO52Upu+QCsna8qsvdqzeJeXDkbMXPW
 6oRV/ZX70Sn7DzVrbjSdVBXmTCSvEHO+AjVIiMzMUagSULxSm9EmYexEKXbU7FXSJdpi
 QhXGaAqY8OA3hM0uM85IXPMuPcPZHPBFcy/Gxd2GMe1me4u6935DJcj1t+eSvoQd7Hwn
 PZpWNv94/2Hiq1Jv3n+1ZlJ7H6uEAMpMobickLXSYgtSigXQHpyxaM9FB6by7ph2dhDG
 gM28d1W/GQgXBbK2JhX5jMaV+5iPm+mUea099AsHgJTpjcyL2k9+udkylrAkkLwK4P42
 vktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746024531; x=1746629331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sapTnwdA9KGKXVMsi+Y5OOkpFlF+Za3s2CpY8AEOGFs=;
 b=Za6YHkoUEz/SFQqO1xwEs0zoVETWuKGuO/sZG6jcCAkjAVOY64u7EXiFu+C7L44qot
 uY/dhTAOoyhdA8N7SvVWrr2dy8BAR0Prv3SPm7f8MDmmZmrEqsSTKurzzVPs/pYqepTc
 +NMBVXaP8C7Bbdn4+9CF8Q3UJ2gEhc60apQT4iRhJYe+aQQT9zeLEXC8cKxtsjdXlQJD
 2esvfFV5KGYtx5fQPHzU9ZjQoiSQoCh+UdpTYR63i9duRQEYk9AA/HyyEPjdNkd2dWJI
 tq1JR9CLoP6jTbCW2MnmVKPD01HSWAeQYLjyB7xtyQBsQXGKeZmw6JhqBxdXJvMzN2uY
 7rDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVw7N2kBlnhRqBryPEGswyyxoxDOHLPrRwC+cxGVSUwHGdJS3nJ6D3E7pUjVfbDPXQem0=@dpdk.org
X-Gm-Message-State: AOJu0YzcCrcxiYlDlpw01M915LxAEuP4FdunATd4VPuKHnUsIq7nQ0nW
 ddueW2Ugw6T1FCO12ZOHjFxzVrTgODf7OrXqAdOPtcVgoS4FaB1aw/EWQLdpBY0=
X-Gm-Gg: ASbGncuW0tnvz8FLmxytIfikjuSSJ797UT0T1yA3aQonsI8QRtLRnh5CaJvePDmlYw7
 KHyjhA4hrlEmskrwcPhlodtJ4OOTftPbAfuVmvNK3sTNwqGVnWgRZOMz3UmHqQLdG8agiqssAy6
 veQq88YwI6PgM0jWAnQ8pCFfPqdsN9xVVTk2SMjCUOZ6Z6FD0SbHdzT/GSJ1HhKEVAdcfQOexiQ
 lDKtmqPmvGsy1dj4V8QH8GGQEuWrB7tDInj7bMXFKg5UpPowaTCH4eSi7moG2AkWpmq6maY/1td
 GVoy2MTMkqoxhVdBFxii58EUA96DB67MvCPxf1hwt5b/FtHA/ggTIhsRaMs26CjtWXVnMowK8sB
 cZMkTjauXuT9N/guu
X-Google-Smtp-Source: AGHT+IGWXp5F8ctVAxgvFT/4kYFQNNFvXKhgyvvcLYb+5PP/tE6tYYBc8A90l2GBbIBTyixvm4vSMQ==
X-Received: by 2002:a17:90b:2708:b0:305:2d68:8d57 with SMTP id
 98e67ed59e1d1-30a343e8580mr3896627a91.5.1746024530996; 
 Wed, 30 Apr 2025 07:48:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a349ffeeasm1692707a91.13.2025.04.30.07.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:48:50 -0700 (PDT)
Date: Wed, 30 Apr 2025 07:48:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH v4 1/2] ethdev: support RSS based on RoCEv2 header
Message-ID: <20250430074848.570fee88@hermes.local>
In-Reply-To: <20250430102011.991865-1-kirankumark@marvell.com>
References: <20250430091051.789240-1-kirankumark@marvell.com>
 <20250430102011.991865-1-kirankumark@marvell.com>
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

On Wed, 30 Apr 2025 15:50:10 +0530
<kirankumark@marvell.com> wrote:

> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index 093b85d206..1da999685f 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -54,6 +54,9 @@ New Features
>       This section is a comment. Do not overwrite or remove it.
>       Also, make sure to start the actual text at the margin.
>       =======================================================
> +* **Added new RSS offload types for IB_BTH in RSS flow.**
> +
> +     Added ``RTE_ETH_RSS_IB_BTH`` macro so that the IB BTH header can be used as input set for RSS.


Need an extra blank line. Doc build fails.
