Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E658CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Sun, 14 Jun 2026 19:30:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 087444364A;
	Sun, 14 Jun 2026 21:30:17 +0200 (CEST)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49]) by mails.dpdk.org (Postfix) with ESMTP id 6792D433C1
 for <dev@dpdk.org>; Sun, 14 Jun 2026 21:30:15 +0200 (CEST)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-6626cd98209so2605123d50.3
 for <dev@dpdk.org>; Sun, 14 Jun 2026 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781465414;
 x=1782070214; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvB5c2w6Kt6kDCuFPovtxgBUurHPoIfwUDwYrOz7zPo=;
 b=FsQxjOkAHtGw43j4TcWhUHTGys9d01DIXRP1SJJwU8+lv0XNhnYrv4N2et3UnfFFYs
 aNHBV6D874M/qARAgPNTta4+s2sf4+SACsXOnjnE5iGWwecEBTKqRfLgSJ6a39ML0NEQ
 EMjJI8gWMTLQVitAi/6fLz+62fW4qOfgBV5q5j3lSVGvR0TeB8S7sFThjr5TNowklcfM
 p91SGENKu0R+CF7OKjodbN/wOsfN3Vnz2VGBj8h23DXdlspBcAnc6xT7xXSH/qNBsp2E
 3NEsMkX33+WQdtMWTptO5JdtfMj5632JoXKbTRbg9S63x9aaBj5jutoSPmu+oh9MkhYP
 EK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781465414; x=1782070214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tvB5c2w6Kt6kDCuFPovtxgBUurHPoIfwUDwYrOz7zPo=;
 b=h0GPIsDh7IIbnCBRVNBMbwv/jOTxP5RqK8/8NbDrtSu7fmApi/DFkpEsreffyxdmDG
 GsFTCzs37RsnDVtOgpy1QPZFM7OLMT3YACE4BCVV1z3Hvy2G7TFHlvvkfwMsfwEvuGWp
 qxo1KLAOHo+LZnaegBH/WKLDiNXBEf6qu1jsftkEbfAQ5X0D6lonbWicOtOt1AWXXgrB
 Am+om/6ubyeZ8Rxe49YNF5hMGTkm1m/hrPhWsyuEsn7inK5xZezfNWrxmOiWJv+tOZpS
 EA9XaVfeDgD1rMH4Ug7/5p8i8IlM1wbRTyMT2/g0x7x42/cTe9RYbd9qvVaoaelb5jg1
 8JVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Jz98jz9e3atEs6VW7XS9Z4xpT8GGCcmwtnDtI6/r/gliXKzqlZBwtDYgf8v0vimTqcjQ=@dpdk.org
X-Gm-Message-State: AOJu0YyogjQ+xt1p+s+FykmAggtG2OdRMSPwJuFDUNZ+dDJxI0zA/EGh
 KjH/8a+z9hKjMEM4S88NMzhFbFMbjJxS0+uzlMxRp/MwKc3zZhnP7yFkBjkMh+WPETk=
X-Gm-Gg: Acq92OEFP3W4DQXB/sPYScvPmrVD4SFNTxP01xDTZkcfOtv9mKET6/ijSlmjpePMA1G
 jBDziXVSe/iulFtmvQBQ2GfDbLHZE9bfmpFRRe4tmiDmbk97nq82yWOo2rU9eY99fGa/HwjTrgM
 AsTbHWyMYYa+iiEVONziCXk4m8cIncx1Nyvekz7LyIiP3UGpQ7MGq2PHml31zOjHIGwZIYQoizs
 z7F3p2CH/x3etsD4opQGULiAyXR5kBc2DiPb37ZdwmGVGZPulB3c5Xoq1U18hA3azNi3EyJkiPK
 F3Ia5XymrPDW/a5PH7jsAcfk95FXPJOan0dGHsQB1pAG1Lp7cvQ1ULSKTZ9K+qzAWECJBR73QpR
 sIeM/11EfingSOcRvIlTFHHp0Cx++swHX7aXnAALWMmST7E/h7gGMSPAMOUGigrAyqxYF6shMSP
 cQ06oMgZBvglY5thy6aP9CcLmRRxVQmlcrzj3DwAbxQugKPsJOdHV9a/3PXNmtm2Fp
X-Received: by 2002:a05:690e:169c:b0:65d:b511:3ab1 with SMTP id
 956f58d0204a3-6627800ed65mr9867245d50.25.1781465414552; 
 Sun, 14 Jun 2026 12:30:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66274e5718asm3830115d50.20.2026.06.14.12.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:30:14 -0700 (PDT)
Date: Sun, 14 Jun 2026 12:30:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, dev@dpdk.org,
 stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Sunil Kumar Kori <skori@marvell.com>
Subject: Re: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
Message-ID: <20260614123010.089fa558@phoenix.local>
In-Reply-To: <20260611154926.392670-9-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-9-maxime@leroys.fr>
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

On Thu, 11 Jun 2026 17:49:23 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> eth_dev_fp_ops_reset() restores a port's fast-path ops on stop/release
> via a compound literal, so every field it omits is zeroed to NULL. It
> sets only rx_pkt_burst/tx_pkt_burst (and the rxq/txq data), leaving
> rx_queue_count, tx_queue_count, rx/tx_descriptor_status, tx_pkt_prepare
> and the recycle callbacks NULL.
> 
> In non-debug builds these ops are reached through an unguarded indirect
> call (the NULL check exists only under RTE_ETHDEV_DEBUG_RX/TX). So a
> thread calling e.g. rte_eth_rx_queue_count() on a port being stopped
> dereferences NULL and crashes, while the same race on rte_eth_rx_burst()
> is harmless because the burst ops are reset to dummies. A poll-mode
> worker re-checking rx_queue_count before arming the Rx interrupt and
> sleeping hits exactly this.
> 
> Reset these ops to the same dummies eth_dev_set_dummy_fops() installs,
> so a stopped port behaves like a freshly allocated one: every fast-path
> op is a safe no-op, none is NULL.
> 
> Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> Cc: stable@dpdk.org
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

I wonder if queue_count dummy should just return 0 instead of -NOTSUP.
There are never going to be packets in the queue to receive.

Ditto for transmit and the status routines.
