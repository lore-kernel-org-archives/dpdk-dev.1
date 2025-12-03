Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F2D1268A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 00:09:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9496C4021F;
	Wed,  3 Dec 2025 01:09:38 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 1BAC6400D5
 for <dev@dpdk.org>; Wed,  3 Dec 2025 01:09:37 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so62600555e9.2
 for <dev@dpdk.org>; Tue, 02 Dec 2025 16:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764720577;
 x=1765325377; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHtCF8nsk1qlqeyAzofMGcSZXvchAtECw4H+YigACT4=;
 b=iYKrKjJMBI8PiDwR/qxMN+hw6TPgb2k/8hBTZZB27uaRWWKiVgulwj8YIP3PzesVhZ
 AhnxNuWIL16ysN2SHe+D9zLLUNCqcMUvk2VWFQnosvucDT3z+kZsC5nhtUA3XxsEm1Wj
 BcOI+Dhth1DgPIbnX4lJdNbzdgeuHaCHU9vgIecmk0QikdFGwB9eRLvsI4qNOm2H5fTs
 7g+peSWYESBBL0aPnXtI2GIoZcaqWSjo4nTJ99oMhhU1OgaxgElUcSZVymH54syPXO8m
 YGSjYEaehdSr8wf7tVpQN3cWqfJStMKmRS2lb6kRiPGiARtVqlKUug1lsc7+3sUcS/St
 Z+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764720577; x=1765325377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zHtCF8nsk1qlqeyAzofMGcSZXvchAtECw4H+YigACT4=;
 b=BjjhKpJ6+O34EG63+F8M4d5L7S3zxDCh9g6nqM6+QRnnK+1LQlOaP/F3Dvu2pOyxe3
 Cdd1BUKt/jTdEtGsIAuaiU1zh5p6yagH2d3wpp/c+CD0+DKTPsldHJVQCpvJZXDf3Kym
 4x72GUR5oSbaAO4j0LPZQZw7ILlIGJYPyTiH/mM8lnwTI0zD443YHkwvHv4ZGYzQ0TqR
 j/uy2MiZ+ZH1E1i/wQO2SXYUDg7RlGIZnV/bFxM7uZ1vuac+eHKQEcN6/P8AagBB42DC
 ZJ6Qraud1Gjk/5QTvmGZjEKCVN4qZf5ku+0hEF9T46NOR8n3gMZFqBiVY1xxAVB39aoL
 bQOA==
X-Gm-Message-State: AOJu0Yx4j6VeGFWHmlyeLz07tY5sfQT0NxCt8JJLrnHWXX0CVJRbhKjX
 rtYTt0rnU9QmWNjO920N4l1gfG6l/WRVzSlUnTmrsIZNix5zARKTVQR3bQuTRxb/2S0=
X-Gm-Gg: ASbGncupzMcVg0WYAr9GYUq5g+qj6uUay6QgQ3DAeBcHfUvqGLVRNAi1zuWJNwAa3IZ
 RjtMhchXuFmQrHguxHd/FU3lAxTYW3XYU2Q4Oxx/4Uc4og7Ad9PLdEV8ka0GbTCszZ9z+mOjAnV
 XD22ZRd7f/JuleNHnyGRe0VQ57hFtOi0w3f+d5gyK5JwQbULzp0daXnWzX/z+KS8gR8m8FdJ9Mt
 5ar5Hw2+LDkFdpw02WevJlvAdo59RacU4m3ue/neUI0V5FTg8Eop+hMvb+N1dJhLjZGqgH+qdHd
 VeKLHolK9Xo7Ys/lMNdoGseo09qo+PzyOpCHB/NACvH3o7ZhsC/M16tMKql29AlUiPwXdOwAsTT
 GQgh6OHiILVpVVEGpiCMaRaB/h/G/dawYC0kJQvxb66I94mmX8a8jskRjLi948dsDCDxQwnt5UW
 nWFNUgrlvdlseBo8JYN23z8EjF3qQldKItLaMThR4y8IMVnlkTdCDs
X-Google-Smtp-Source: AGHT+IHdlk1VRCChY50rrAM/R8cOPCYjHLjEH9XdA7d5Sdc47EWSWXdrTaPT1/xMipXJjkpccfgxeA==
X-Received: by 2002:a05:600c:4755:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-4792af44bc1mr3404025e9.34.1764720576205; 
 Tue, 02 Dec 2025 16:09:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a7a87f8sm15129625e9.12.2025.12.02.16.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 16:09:35 -0800 (PST)
Date: Tue, 2 Dec 2025 16:09:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, orika@nvidia.com, thomas@monjalon.net
Subject: Re: [PATCH v2] ethdev: add GENEVE encapsulation and decapsulation
 actions
Message-ID: <20251202160930.2de5b87f@phoenix.local>
In-Reply-To: <20251114061917.20948-1-sunyang.wu@jaguarmicro.com>
References: <20251114061917.20948-1-sunyang.wu@jaguarmicro.com>
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

On Fri, 14 Nov 2025 14:19:17 +0800
Sunyang Wu <sunyang.wu@jaguarmicro.com> wrote:

> Add new flow action types for GENEVE tunnel manipulation:
> 
> 1. RTE_FLOW_ACTION_TYPE_GENEVE_ENCAP - For encapsulating packets into
> GENEVE tunnels
> 2. RTE_FLOW_ACTION_TYPE_GENEVE_DECAP - For decapsulating packets from
> GENEVE tunnels
> 3. struct rte_flow_action_geneve_encap - Data structure to define tunnel
> encapsulation parameters
> 
> These actions allow users to build more flexible network virtualization
> solutions using GENEVE tunnels as specified by RFC8926, which are added
> at the end of the enum to maintain ABI compatibility.
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---

For any new flow action we need an in-tree PMD that supports it
and support for it in testing framework. Please submit this as part of
a multi-part patch series with that.

