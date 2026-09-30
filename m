Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D1CA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 16:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FF1F402DF;
	Wed, 30 Sep 2026 18:06:42 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 674E9402D9
 for <dev@dpdk.org>; Wed, 30 Sep 2026 18:06:41 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747eefae4so13998325ad.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790784400;
 x=1791389200; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ngj880J40dTd5FKM/lxwlHvczsb57G35urdx2QzIxkY=;
 b=wVgMWTMPm+l8OIQsyecoRIEQPPTlwv2KWIqJYrZnJU0fbWFcj24PHAZaY4wU4PjO5A
 YscmmEa1UODYszluL3c5HTU9lxDGCc+O7tmlGX+m++O8thp2PQtMBFJ4EHLF6ySENJIy
 +HRRaznr2AdhKOtUARAUYiHzXCOAoG9YODn5ZwJiVGsnhbVVYHLCrEGDAhPlK67cgHYE
 e8AfR2/xxRNhRNwHi8eC4arCbqU/4UT4ip9VUZTyHoPFYJq20FpeGUdwvMLq+Y4q/Q8m
 dkIhzQ6/ZgT2loOxihBOiW4nWQZgHMgtGbmd2VUlpNmnw7aU4bJHvTBPpU2MVf+qtZaE
 WNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784400; x=1791389200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ngj880J40dTd5FKM/lxwlHvczsb57G35urdx2QzIxkY=;
 b=JcSGlPJtDPyGpB9wqsj9sf39fV2HifZrs5mrdzIn8kTB7Td++ynOVyiAILwWad9KcP
 poXzReq975MsLGXkrIfmHTXbb5kHi1kQ8TGMz+yqoJIYfjwQLTF4NqAslxSwDu2fObAH
 HZw2rk0OywW2Pd2wrHhpLnzITUXCPcBntJKgbMB3S94yFc4dBq5ZOi5mjzFDEMF8j+BP
 DKdDrBCgLtlfA6wY8csMN+7EC7GhPAQe0ajb0yAJ7sWS8raFhaCZG71TwYj3BuoDdVct
 126gbtbpXTIrINeXiyRIj5T8Al/Xe8iPjg7RDLito+LeJ6Lq89y9gV8OumPqDFl1G3VK
 nWJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMNjEDgvcxMGlpgG6Qp/jbFAU5bimyQg82iE2g/dT6T0UhXW+30m09BmyEWOWh9ql6VlM=@dpdk.org
X-Gm-Message-State: AFq9FYJylWVhkaHtedqhjOHGK/ARUClN2ydXhGlqOU/Py5vzV7wQN9lU
 tCnCXnjpjeyWtDUxIVAQJeQTbBakQnjIjqS0mbYFjqPcqXOIL+AeSuyQ1HidHfC34v0=
X-Gm-Gg: AYBFou0qJ1hdY5+Lc9YcJazu1JzlMkZYsBKOdUX1WRcj9dkiknTltkLmy1rC2Xp9nQ0
 qwqpx/qAm/xHdZCGOBpVYTuwf+FtorDizurMHnxEY3HYKelQGFHi58piQ/ewUZX6MHNj1CqOKzQ
 Xi4pNqEsIuEAbN0MSnTlUMVqj8OtfP1Pgss/kBHX7MYm55J/pLuK0pViUk2+jOzwG3AOuPnkm4b
 P28PQAloR52FCv+6FXIeB0gKIjJtI5C8+2DIO/UAED8aR1geg0mX9btbgyGzjWpZMb7kpdiSKEZ
 Bkty9z9YRVuacIB9Wbgnw7MkP/qBj7mrGzt9ldfBThup8Lm9uT7xNEurUrPha2g2mHWYMfKRYZd
 xJrYVtDJJ6KelbB/hLGdO1qcUNW6fouZGDpwvJWcFCfmS5UADtYZ5J2W+j+lEMgVgmxcR5kGOq1
 NelZFFTIBsUzRatowKUy6BlmUfXeY5IhdIxNTU5ptH24vM8mH6dmotBnOl0WuuXChZ7Y3IY/BxZ
 2PZc+zyfzVe0CGvw2AOhHJjyXPr43YaLBO/V5PF7A==
X-Received: by 2002:a17:903:2407:b0:2df:9489:83f7 with SMTP id
 d9443c01a7336-2e3004226bbmr21205ad.40.1790784400030; 
 Wed, 30 Sep 2026 09:06:40 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2e5bac8dfsm10203895ad.32.2026.09.30.09.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:06:39 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:06:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v18 00/24] NXP DPAA driver enhancements and fixes
Message-ID: <20260930090637.1125cc72@phoenix.local>
In-Reply-To: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
References: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260930062437.3019096-1-hemant.agrawal@nxp.com>
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

On Wed, 30 Sep 2026 11:54:13 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> errata-workaround devargs. Documentation and release notes are updated
> accordingly.
> 
> v18:
> * Dropped the "net/dpaa: fix device remove" patch. It papered over the
>   symptom in rte_dpaa_remove() instead of fixing the cause, and was
>   replaced by the two fixes now at the head of the series.
> * net/dpaa: fix the double dpaa_eth_dev_close() call and the eth_dev
>   dereference before the NULL check in rte_dpaa_remove().
> * net/dpaa: unwind rte_dpaa_probe() through cleanup labels so the Tx SG
>   mempool failure path closes the device and releases the port instead of
>   leaking the port, the queue arrays and the QMan FQID/CGRID ranges.


Much better but still see some leftovers in AI review.
