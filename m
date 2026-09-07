Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A6FC79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:25:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E23C7402E8;
	Mon,  7 Sep 2026 20:25:03 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id F2AD340262
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:25:02 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so3850373a91.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805502;
 x=1789410302; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=78p/XqFzF6AkWv7jakTlSJK9U6Rf7neFwgMjKCRFYdE=;
 b=rwqRUfmeMjyexCiwC2Sl34Ry2okuACWi+A0lMm10CBhtDJy0YFwIdrjZGIoGf+TZgD
 gnrcB6YfjhueYZtUpnW515Gmscw1gci1p5gFUFwUIhk1Tm+9h2lOR5Matw2tsf0kMWNv
 YnMVol8nFZqjSPpALHcBY+eDz8jwqLcxTbANd+eKZC0n/wcGaX0VufUbeAXCiqpNnba2
 wRtCy5QFnK4W+gFCVnlJW7OLuj5HjOI4EEWUUdN6cr5JAAcOXo6PtQU3Ioqj6dk492HZ
 VgSrKYCAixPloqf95rKbLVZlhbgJAhvVc3GCLdsQ/gtN6AqLcMnzQtrc15UGCPdLK3NQ
 vMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805502; x=1789410302;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=78p/XqFzF6AkWv7jakTlSJK9U6Rf7neFwgMjKCRFYdE=;
 b=L6grJVpd8yw3QG0fUkoc1/n/lZd8djOpWAhrFhlGJbwFyy7v5wQlo9xKzNVuDHdHhl
 J2Z/qVIyyqiYpSTdavEQLLvfUPBJJd4q1oHFc4rxkrCPV6yve3Xsu8GL1+ycnV4bPsfM
 wC1xneJ0wEPQ1cg4NZbo/VhKVq1PbpczB4vfUEQ7At4bgZ0TjPymAMvKhnKYegUpOHSq
 sIkIUk0IDeZhU3Ry8aX4ZZF3pd0BlZd4yEYr2tFADgMOUwhy2PLOHOcmXR3oDQQ7TOIX
 N4lUy4xJpRCXoxamBHDle/GtnAA7yfGI2FE2t7xmZY04fkJgg7qWrh48A/7a2V8GxD06
 x3ow==
X-Forwarded-Encrypted: i=1;
 AKwUvByYzYyalNfrNoX7z7gNLoZ5zZLLwkorHRhNf14Nh12NI5oRxpEWojVGHus1SYHgWJ4hnYA=@dpdk.org
X-Gm-Message-State: AFuF++kRSac1XPX/10WNXNIQyTNUsSL9PkmR/qweJqEJHOffY89ldio2
 v32V2NAJJRcbqnqCMlgwe96JZbmD91MZK2xwQWr950NW9xaN2QXrIXACQIxqzH4OBno=
X-Gm-Gg: AYBFou0MoPrQOkifjRnSs+nB3De1gqfmKt70kEINxCSgc7xtLkZzyjwqFTWC6Kk5XiI
 C21u7cAWk2DPNx5BC6T4SqU/XiklX+N0ZrlEg2Y7AGFGYb6SWfoOpDdQz/0fWMa2VWhSHLFLpES
 gU7xSTMO0OPqgrt2FAQn5XVCDzMEBh+sykBKGbmzHG8o7dwXOSSSxwUJapgUrPoibMYgnrsPwis
 EIe416bbArZbVVy4ngxJ+kuyHrMS/z2eW/Li59c4gIy7YlJSRWyVP0uMw7qHpgREUQ8y2NUlP+h
 GnCsgX2AZHLfp+0QZbIP5iZvOYlgP+QdwXryoR4tsFmCM3j1sUaaEU48sdK0jzF/dMijDWIap3S
 gdMC/dwvIH2ZDu4jNZd+WLZ0UyxuVCQjMaKXFfVluEKCKe+NXQ/re6BjoPFW77PC9Hm0gVWABee
 vuoTnFjx4RXq6GV4dcmnq2KjOHa4HSfrUZRdW9NlqOqCm4ZYSJVZtk0PWaOqkWv9ME9yf7UtLbO
 9XrZbAdLbVe8B94CnaMrbDi6t417inf95S2iWg9
X-Received: by 2002:a17:90a:6081:b0:39b:51cc:4586 with SMTP id
 98e67ed59e1d1-39b51cc65admr11789152a91.19.1788805501991; 
 Mon, 07 Sep 2026 11:25:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39451sm28004532a91.7.2026.09.07.11.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:25:01 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:24:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>,
 Alexander Kozyrev <akozyrev@nvidia.com>, Adrien Mazarguil
 <adrien.mazarguil@6wind.com>, Olga Shern <olgas@nvidia.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] app/testpmd: fix error handling in flow API commands
Message-ID: <20260907112450.372f13a8@phoenix.local>
In-Reply-To: <20260907034831.791724-1-kirankumark@marvell.com>
References: <20260907034831.791724-1-kirankumark@marvell.com>
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

On Mon, 7 Sep 2026 09:18:31 +0530
<kirankumark@marvell.com> wrote:

> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> Fix two robustness issues in the flow API command paths:
> 
> - port_flow_configure() committed the new queue attributes and job list
>   before rte_flow_configure() succeeded, leaving the port state
>   inconsistent on failure. Build the job list locally, free it on error,
>   and update the port only after configure succeeds.
> 
> - port_flow_create() and port_queue_flow_create() indexed ports[port_id]
>   without validating the port id. Add an rte_eth_dev_is_valid_port()
>   check before accessing the array.
> 
> Fixes: 9ad3a41ab2a1 ("app/testpmd: add flow engine configuration")
> Fixes: 938a184a1870 ("app/testpmd: implement basic support for flow API")
> Fixes: ecdc927b99f2 ("app/testpmd: add async flow create/destroy operations")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
> ---

Applied to next-net
