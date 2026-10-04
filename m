Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD35CA5FEF
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Oct 2026 16:15:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E85A74060A;
	Sun,  4 Oct 2026 18:15:17 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id A94C340285
 for <dev@dpdk.org>; Sun,  4 Oct 2026 18:15:16 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc797656e44so291338a12.2
 for <dev@dpdk.org>; Sun, 04 Oct 2026 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791130516;
 x=1791735316; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+2ZGKsQf4kmPWWDkJ1xWZQp2djBUIEmmJ5wraAeDY34=;
 b=AIpxFMJXlzQ+dJF51CsWbgdKHOfcrzudtWrh0c7vGDb+KJE/OJfL28mhz7k3ACJqEM
 TZlKcqd/BnZ45SM8PpiaufVLGR6X9bvKsAGKwzt2mllK15TvWs9NKdXTg/PVDSt3Yw0i
 0VKq7D5eaLj7b/dFQns1cROr8KoJIJBE6SS/N2526UQSyN2dHXIllybIIxek3aD0EzKl
 tAnOhEyMMJuCx7yVZ5AlLPDnaE3xgOyhz9TOgrAPvC5/eSJLwIsA8dL9DSGxp5NLDJHP
 XYdC43+4tnVoRV60Xcr0TFlC8+Ho+VKCM+cpKg/M5PT2ZC5/eBX/R2NWYlb2lZUHmWEb
 u8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130516; x=1791735316;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+2ZGKsQf4kmPWWDkJ1xWZQp2djBUIEmmJ5wraAeDY34=;
 b=Rg1CDvcc8ZhL7QNBxVjDD2Y8ROhfh6d+alruJxVkdfRGjO9eOzcZ0ZiXbMAkzB9/p6
 HqmgsTJ8UoEnWznXXvw6vVtETMxqy2ECvV8RJfnYoV4NcbBcbL1i7yYlYU168YEpm0wr
 pm1RblrNzoPm2KHRxN627ykncS5NCNwSenE9i4UCdfLhKyygt08pC6aXFRo5R+cjcIIm
 CYx+W86GBUcoo6rCRSn7m7tOxhtxH3dSIaeGPOPbRJBEb0X20UJqyJQFjvmcx4OYPafr
 bzmW8EZ9BhmJZS8sNoztPnccEiZRnDn4joaQVr682FLw9VjC8a6eq85ZLiiqyY40s5qA
 aQcw==
X-Gm-Message-State: AFq9FYJFMpVDQmkifeWWKV5aHI3LuutEjk7jbO+fSIyskJr1tQe7wWVD
 bwn3SyQZ8PmVT827pg5Yqanhq+ZrDrOuEchFV93TsVmX5hsE3WpUXkLQ/8ciOSK3LD4=
X-Gm-Gg: AYBFou2cCb5yKI4TK9/ZA2MA35TCWFrpJexMFNOgxtESKS6pMBYe9Cbu/jf73pOxGDy
 M4yQ7uQrlIMfznohkF7KijfbMTMZ9ov1p2H7W66NNCWBpjYWxfgETjneWb4unbhYm0sRBQBNd1F
 qs8a95hXPCRVjD2ZaSdRxG/W45Lh1lGWlC50H1r5HG2XJqISgDHoz/eQfdKlTqazEWF/rAbygq1
 qSALmVdJZFByFwh70tt0e31TZIQRKmob6/rZmyDizLqhm6EGxXDtCo26cDkiYpFXGCFUyGdaUjE
 I9KQHpyxVZ+TvgRT+Q6qHhu0TbB9rdaze6GClxgXOTm1nAVQ308i6tOldJrxdl7x2UhTtyhXzQy
 U9IeHgWagA/UmidHES3/5WMeWdjyINMPteT6VJ8zMQd8Mxw2SkXo/X/oHSqGFeEKTBp+HVWyGOh
 ayQpDAWgV95mcz5UxqXTO2uTLbZYXlIjBrNZS4rXvLucfmcf/u8M1imIA1QSY3M/GW6fU+BTBDB
 nOJ9ZSRnVFwUE6kwOZ3HYlqcKokcY0VmuMmoyWZ
X-Received: by 2002:a17:90b:544e:b0:3a5:de8:2c4f with SMTP id
 98e67ed59e1d1-3a6ce9856b2mr5628679a91.65.1791130515593; 
 Sun, 04 Oct 2026 09:15:15 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78d660f29sm7101166a91.3.2026.10.04.09.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:15:15 -0700 (PDT)
Date: Sun, 4 Oct 2026 09:15:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/3] net/intel: make link state configurable on device
 start
Message-ID: <20261004091513.54a16319@phoenix.local>
In-Reply-To: <20261003215345.1774614-1-roma55592@yandex.ru>
References: <cover.1790970122.git.roma55592@yandex.ru>
 <20261003091832.2ee5b91c@phoenix.local>
 <20261003215345.1774614-1-roma55592@yandex.ru>
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

On Sat,  3 Oct 2026 23:53:45 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> On Sat, 3 Oct 2026, Stephen Hemminger wrote:
> > If you want something done better it must done at ethdev layer
> > and you must coordinate across all existing devices.  
> 
> Thanks, understood. I withdraw this series.
> 
> The problem behind it: a firewall starts its ports at boot but must keep
> the ports that are disabled in its configuration down, so that the link
> partner never sees them. Today rte_eth_dev_start() brings the link up
> on most drivers, and the application can only bring it down afterwards.
> 
> Would an RFC along these lines be acceptable?
> - ethdev keeps the administrative link state (RFC 2863 ifAdminStatus)
>   set by rte_eth_dev_set_link_down()/up(), including before the port
>   is started;
> - rte_eth_dev_start() honors it: drivers that support it keep the link
>   down on start, and for the others ethdev calls dev_set_link_down()
>   right after dev_start(), so the semantics are the same for all devices;
> - a new feature in the features matrix to track driver support.
> 
> Or would you prefer a separate API for the administrative state instead
> of changing the behavior of rte_eth_dev_set_link_down()?
> 
> Roman

No. Application should not call device start until it expects
to bring link up.

The RFC 2863 stuff is for layered devices where lower layers are
separate from the upper ones (ie. tunnels, bonding, etc).
