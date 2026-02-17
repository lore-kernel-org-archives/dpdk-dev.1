Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261A8E83848
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 01:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD1DA402A7;
	Tue, 17 Feb 2026 02:28:59 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 725884029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 02:28:58 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so41634115e9.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771291738;
 x=1771896538; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=b4hWHkUEuIkNIvUJBhS433D2pcT2GVuLgIBvStEaU3A=;
 b=dE2zbNEbmfkuvZg1giETaHRFEld6CSzaWKinvuVKJpatYwpurCTHvzV6UsjEvP0TNt
 +bcnBCHG+mEVnjiJSa+h4by5qy1wpZ2+o43SVX327XRF2zN9SyLmL2tCS+lb2BvYe3XZ
 L+cwQb/PJ6lTb8Dbcp0e0RAb8kk6Z5JQWMIN7gaoIQr10qqW+MSd7ArCI6Gd14uVcDA2
 cmQCIB3esRgRFCSIKTe/pJ4/JNXAMw+Y5bgZwEJcGcl5QSYbLkdOQiC9eL4PpcROuqsx
 EeCq0WqcKA9CDex1TSyHylOdSKpXZ1yGMV74CVbrvDBaPhP2nvp6jI8ZFR9tlL4mhUTF
 TbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771291738; x=1771896538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b4hWHkUEuIkNIvUJBhS433D2pcT2GVuLgIBvStEaU3A=;
 b=t7SsDJ3B9DItGLvWlzng72pjqycMx0DN97AsgImH3Ea7IRqfRRCWOeKjxy0Js8n0NY
 gYRHDaDobXDgUfGSmNs4Rx7CJDQ1wJktGGGrqeJh7VsobCuiUEC37ECV3WqVHdkqnb+a
 j+am2JfxFyhh2ZmWhIlL1Ndog+wicKEpvssa9sVt1N2UB1ChD5rIUbPXk1AXlnOVy2le
 AsjBPocXbKas7tbsE12UeCzSt7KL689Xcdva56SRZcyqogsDMZ2BGrLEViyj+h7kstZa
 Cu2GgE+hxPvtvobIFaRaaDHsSXSPNG3fSWcayVnkFknVbIwtfR7e4SY3A7fRXOghYeYH
 nKQg==
X-Gm-Message-State: AOJu0YxLWKURsvHJG6Ii+YYg9ilzbNyUtnpDzSQuK8ZLEg5cPgJV3CTn
 yk8NGB7PXazmY8wZuMQB2pWDVcmRwr0E3oR7/WBona97svcluYXn59fMRnQz0eRWqwqb8HM7g8V
 WSHjl3zU=
X-Gm-Gg: AZuq6aKSoJ06Ba1SOu/8ehHN7qp19WPZoh85Z+64YJwtPdoMIGf7JrmjjfPgUsWUUdu
 CnQyfVkvYqHSkWyDmuknO+PHCgC2NWilK+ihRHk6AbFW3l2CToMDyqg0R+7RHGsKhtcHfM3Rz8R
 iWalhk3KSKGl8ARSHCM4TBoSrxRV8cESS/Izz8zQELltl2WL87cW+fga5Mjq5ObiyfhP01IY+vI
 4jWXpaBVsSs65qG1/L8x7aY1kGJaruuYs5R/XhoH5JI332pGBvFv3y7YwdtEyEuqT2TZiHk8mor
 cA6CRErQHVs4XRFcgz0LVgQ7TeqPjUTKPAe8slpzh6F5qtsTZ+J5dOvgNwa9gsbje6haik/8dJi
 RzlrmNjJwjtZE1nJUtezNICvMuBcEPKY5r8Kz/PjI5W59wL5l/0N+176ejlxfhVTLm0TufkJP+h
 EeS4FHond/3WmxwYNnn+zHFWrXf94zNEiFfPiNbEtE9WqUlCGgZ0CCxf1QC86ni0o4blSSR2iJq
 DU=
X-Received: by 2002:a05:600c:1f91:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-48373a69e47mr183141125e9.36.1771291737757; 
 Mon, 16 Feb 2026 17:28:57 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm539511615e9.6.2026.02.16.17.28.56
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 17:28:57 -0800 (PST)
Date: Mon, 16 Feb 2026 17:28:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v2 11/11] net/tap: track device by ifindex instead of name
Message-ID: <20260216172851.742aef30@phoenix.local>
In-Reply-To: <20260216230437.847578-12-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
 <20260216230437.847578-12-stephen@networkplumber.org>
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

On Mon, 16 Feb 2026 15:02:35 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Remove name and remote_iface strings from pmd_internals.
> The interface name can change at any time due to udev or admin
> action, making cached names unreliable.
> 
> Resolve ifindex once at creation via TUNGETIFF on the keep-alive
> fd. For per-queue opens, recover the name on demand with
> if_indextoname(). In tap_netns_change(), use TUNGETIFF to get
> the current kernel name before resolving the new ifindex,
> fixing a bug where a rename during namespace move would lose
> the device.
> 
> Log messages now use dev->device->name (DPDK vdev name) or
> the ifindex, following the pattern established by the rtap PMD.
> 
> Bugzilla ID: 1880
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

This patch is not ready and needs to be dropped
