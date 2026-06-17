Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61ABCD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 21:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDC4240268;
	Wed, 17 Jun 2026 23:13:28 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id A5A4440268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 23:13:27 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-7dbcb505578so3423267b3.3
 for <dev@dpdk.org>; Wed, 17 Jun 2026 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781730807;
 x=1782335607; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSR+kHHzV/MVqOmoiQkTwsb6iiUefvNrY7efqEtblyg=;
 b=jkMGpPNstanyTsIFD8Kur9ZXgYBxd9VB4K+/4QKbT34dzGIyHMZbYbax6QuPMq5zrF
 A7W0OMKxQdIuAMZ9ZSxUHxxtNJSeFZUKI4FT+u1UhCfDG4xBJ2jqGol2G8tyx9/13I5Y
 +htCmjFqOHw6QpFvykt+zNZDSNCq1pr7SAZDXhOrk4huv8UuQP5V1mOdPJ8/1/WfLOPA
 VUCv1MwzQQ3yG3IbeiUVsxry9Ny09FPezOhUQvKWOWSvaY506bVTdzwq6EfvkAKLSIgG
 V4JJJE3iExDiqyYwNEP/ouRBmWl52jpJ/26re4qqGc/+ke6UB5ciScLRqdxpk4L+IIE2
 xpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781730807; x=1782335607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zSR+kHHzV/MVqOmoiQkTwsb6iiUefvNrY7efqEtblyg=;
 b=DqgKRfQRI0RdTR0WTNdvgL7iiTtNHWzei597ImYs+Tx8SMAh4XO+0Zwbs1jaAl6tFA
 9fOIc2EY7Hgzp/g8HUXEDLPJTfxYmbefgQ925QOCG3MAmZ815eIYafmyztOt36Qz0zMD
 wROxWn6f+gQ1gNmH83CncXDsgggO6ln6fx7pH7uti57ejhXv8CbFPZOqauC+vQUdmkYM
 7SDBVsRvpv423VS6Owg2sNHP27HDqF4OWr50WYFGWVrors/eXw9/XHOEBHCd+ePP7hca
 44UIQk/TwkVWt+uiZM20jQ639Uuxv6P842KtbyioneBNZRgHTpAIOZnpI5ReGZJ/UIaC
 A5RA==
X-Gm-Message-State: AOJu0YyVhcpk+BUBPcNBh3sPIe7al1xzdtzL++lXK+RkRsHl6HbjZqo/
 b2+WTiWix9J8KuSGOpehMUnTA8cJ0Qf4iFNzvWSNmEf2D3HXRDkVY7V5g/ZFV5C1kD4=
X-Gm-Gg: AfdE7cmcWVWwyQcImQiT/gwUc/AGQ5dqK7ZA89LuvlrUmyXj3QCxeaRsRsd6VV/qOS7
 zN5rgGd2YhwoW4gBXbK9UdjXcvyBPrIEVwH1zZIhFbyP9Si8AM//6tVtctCqStdyKc1360foJA+
 x1BSx9zvoxnR/4Cr4eG6knGvQExRnTQl0Ya4dex+QG+FyOTM8+vpWTaKsa0tPyntialT4jjWjqM
 ayE8um1V328DLafLtdF5Gi7JEpOelodO7EFeF8e/csiEFjdcxGxr0n+0lILsjaiRdjJCG8INs+F
 B7m8H/fnc3YxBsE1ezAT+LdgTqf7XK4V74wxCcrzx2rGdQV0/8gRSo9W++8Z2ZV2PUF47eQ/zs8
 HqrfiRxTVk2MeWQxqTKReToPiAaL621YqfmmTARp1mgf1UVC5JVL3ekatvtbKlyHf4NwL6KbmhX
 AimQRwQe3JsSYL+jxgunLRj0Tbk/QPYgjEGsdXq4gDhg05faedDyZqrw==
X-Received: by 2002:a05:690c:22c5:b0:7fd:a6d8:ec7b with SMTP id
 00721157ae682-7fe5d8a634dmr65205987b3.22.1781730806829; 
 Wed, 17 Jun 2026 14:13:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7fcd3465c7csm55245107b3.39.2026.06.17.14.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 14:13:26 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:13:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] ethdev: fix fast-path ops on a stopped port
Message-ID: <20260617141324.31176764@phoenix.local>
In-Reply-To: <20260616094259.686555-1-maxime@leroys.fr>
References: <20260616094259.686555-1-maxime@leroys.fr>
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

On Tue, 16 Jun 2026 11:42:56 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> Two small fixes for fast-path ops on a stopped port:
> patch 1 stops rte_eth_rx_queue_count() from dereferencing NULL after a port
> stop, patch 2 makes the dummy queue count return 0 (empty queue) instead of
> -ENOTSUP.
> 
> Maxime Leroy (2):
>   ethdev: keep fast-path ops valid after port stop
>   ethdev: return 0 from dummy queue count
> 
>  lib/ethdev/ethdev_driver.c  | 2 +-
>  lib/ethdev/ethdev_private.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

Applied to next-net
