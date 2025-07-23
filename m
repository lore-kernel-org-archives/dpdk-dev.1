Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687DEC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 15:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C15EF40ED0;
	Wed, 23 Jul 2025 17:09:26 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 185D940E3E
 for <dev@dpdk.org>; Wed, 23 Jul 2025 17:09:26 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d9eac11358so652121985a.3
 for <dev@dpdk.org>; Wed, 23 Jul 2025 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753283365;
 x=1753888165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bup+ClTWhco2BBBFg5ufSxILVImQie2M2sqjtBeRRuY=;
 b=H8HnQA21+NYDi1aJFMnT+32bDTHVzewVvAQJn3gGNt2/rA6d4OIB2fjWU268s+CD9o
 1DfOi3iKYi3vPU6i62glUE7N92TI2G7EawbF7cvMAIsqq92OkLnqAYrOZQTNwAcOWbQa
 Fly7g0moFLJ2nzp5I+ZpLc7kBJPfk3Zsy/kfFebfBT+ChFxz8YHKmMSs6SbneKIpBty1
 tAUVd1zPoMVTAG+5LGLVgWtR0sSeMDSDJeNerfBeg7Q+wUAsx2LPwLG8K+5p5SKhkuYB
 e4KfD3RV9qGxt3/hh9JiX1wBvY+IoHubed8NXhg08M58HYMjuupVHB7XnKHuDnteg9F6
 +XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753283365; x=1753888165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bup+ClTWhco2BBBFg5ufSxILVImQie2M2sqjtBeRRuY=;
 b=IBtlMuFKfHsK3mMPKmFCNnzDnP0gksEnH5AOOiCMff+ANbZm903eDWB+hOS9WXGb8A
 b8QxqGwiEGSLhS3oJCJKqqze1H2vpnFJiyOnsYFJBrFoWwIa/l+Y0SmMCc+ZEki+cOKn
 vgclGDhtyY/OPsOiUQ2FxRfJavR7eAVoJ20RLDy9E2HZ8Hsb5FpGKlyiH8YbLjYPXH0b
 EmvBz73wesrhudHE4N3fPF05MhUY0mwZsFhACx+WxOdE4H1aZPfNOQCMs5bKtcBzbAlh
 XHu+Tpc8oKnisoowDhFH2hF/aFiMdf2dpI9GP8O8NRweS/hbGC5ES4oB3EG/UC3LPLgN
 ZQNA==
X-Gm-Message-State: AOJu0YzhMh8GkKnKIWTdbnxLqMqi1wQTJZcfOgy75S1XmEk1wWu6uoZF
 7neFI7FurCH3e/EV3zCUoo7/yskmcnIq392nGeL1EkhINhwHemkA1UXP9woBzAsRgU0=
X-Gm-Gg: ASbGncu24+r1LvhbH9klLlqHN+yQXnX1y2C6QWvGefM9GmGTILt3xGNYalhpX1dZp6v
 4ff+SVGVIu4ZI6eszZEhZSK8bFP5aCop3dGO2BqgZWTOtlarO5GqLDlCWHkFqCkdzVl+bx3zJCN
 ijc4rZDiz5kiLKaYz8A2H37A/itvGdR4O6bTuajvxPiVO5DMgLmLkddOUUQ+bsOOfbjDnrDAaIb
 zuOZw6bPD5+/uNlTkU/kvIvSbfdK681Px4MOY6R2x0Qafsqk2Ioet54E7X9DcOO5dyN/mXowfP6
 c5QzyUxVhEnW0cW2iZsNp4P4lfmINREItn/qKh8wtIwAMZAKeSZh14eL6wE63EHHFKteOpVPzu7
 vUMDtwDxLcF7JfDMDTi+tnXZxD1Ux6o6WA5exegaztsz8SUk25rPBXeetDdN3e0NpZTaOa44IsJ
 A=
X-Google-Smtp-Source: AGHT+IEzOwqkhngUeBDpqJYqY3VwfQGGeW/hmz6q27/HV8TZpJXfYWcd6JrvOIJIW0ERBVraEG/X3A==
X-Received: by 2002:a05:620a:2993:b0:7cc:8a39:29df with SMTP id
 af79cd13be357-7e62a138aacmr451902485a.9.1753283364830; 
 Wed, 23 Jul 2025 08:09:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b46238sm654533485a.26.2025.07.23.08.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:09:24 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:09:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 03/13] test: add test for hotplug and secondary
 process operations
Message-ID: <20250723080921.707076de@hermes.local>
In-Reply-To: <7f61a6f8-e381-95e6-d362-208444d89923@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-4-stephen@networkplumber.org>
 <7f61a6f8-e381-95e6-d362-208444d89923@arknetworks.am>
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

On Wed, 23 Jul 2025 05:31:03 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> > +
> > +	ret = rte_eth_dev_get_port_by_name(vdev_name, &port);
> > +	TEST_ASSERT(ret == 0, "Lookup vdev '%s' failed", vdev_name);
> > +
> > +	ret = rte_eth_dev_configure(port, 1, 1, &dev_conf);
> > +	TEST_ASSERT(ret == 0, "Configure port %u failed", port);  
> 
> I may be very wrong here, but if this code is supposed to be run in the
> secondary process, then is 'rte_eth_dev_configure' allowed in such?


It works because the state in port structure for is in shared huge pages.
The issue with start/stop is that it causes state changes that are not shared.
