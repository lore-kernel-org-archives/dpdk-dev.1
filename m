Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A28E81A40
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 16:26:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2755A40612;
	Mon, 16 Feb 2026 17:26:27 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 3670D40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:26:25 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4833115090dso30442395e9.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771259185;
 x=1771863985; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3BOtVA5v903SMOTsevvyZCyIXGJWXyO7JWdgk36UmQ=;
 b=ShxZl0B/CAJDqRblNVimVJ+eCK8ynJdeUvdRuBt+oTAMszlbGEzvyx/BNHthQP7YZH
 4lj/yJJumETi8OihsD11D0tNpk+ZWcIfQcDVxiI9nWEz8PAqXHo5vvY55N6Cc5k5YClA
 GiDzda5WJv7S7a0/m/BgyGquNjZsFxcSZl8dUsDD7WD9x7Krle0zNysHEElTBdHZXj4Z
 jWfiHZeauvGkXKGd+nqF/eYag2es+GSJHylHco+VKMZj7DcF40tauUBYASbtA/D55Qim
 l7W4FT8+/iAXH5l3qSqQcipfEf50vo7c+7E4p5BD6hExs1JvtNFCJPe1w6VBluMU0vCa
 aolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771259185; x=1771863985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K3BOtVA5v903SMOTsevvyZCyIXGJWXyO7JWdgk36UmQ=;
 b=NEzYThFNSRvAjCC5oO2mHmaa3ogR/pXANTLSFJrmbMx+0t4KRn7YWfKJAPwtKMeRjE
 VVjLXDqP+BeLFT9rgfbD4AHj0anL8YIwPkBrtrYsf09Hfa2Z+v5SepRz3invRpmxKquz
 pMmJaqb4xYlyItIi849oNK7nHNDuAUKyBQuu37XxcvXt0SWS8L9cWh3tD1wMtDtBWg2F
 1zLcFv8Io1kjmM9YBKLNsR0ACc8Wp5OcOm1e0kIuxaB/zEq0Yj4lpFp+Q8ov0b+3u1Eg
 VnOPo4hJubI1oGx+1H4kLYv3at6HIPZrEonBi4t3PqDwOzoTSo74XFIda+NGQ5H+jfNt
 6s9A==
X-Gm-Message-State: AOJu0YzF0E6YIaqPQaciZGYkljGzX2BlfcZItla6qalFHcHt/mknlk+z
 ZS4YdyYLTDBZfx7x2b55Isi2O9Q0PPgrD92CD8yyS9egApq1kOucOYVEc0fRVzXZKmxpK2C/VhL
 LBY3fHLQ=
X-Gm-Gg: AZuq6aIPYWxkFgRoYPlECPON+Zw8DioJs1KlghqZvMEXi5edveUEI6HVUXHPAFWkhAA
 HGSBsfGCNMEBTVATbPLSR2a0RlAi1sdRPSw2M0X4gkVUuCBwpM4gU9uUyzlptLLK/LbuOIF205P
 Zj3CEHnzlzG1BHZJmewLhakkTDpfrBGoV4IOeUY4BUn2Oxmiiw2M4XoRRLRQbMugndlwvZlSVFp
 AZX/coS9Lm1ObF2qu/cmvHrADQkHBxkLCClIdlresCCdU0mSG2fZv6LHnYHPTMwGIScvIluZmuf
 QL7h1NiegkUrqePQCuUZmi+yq7gTm1vniUsTRQ4PR/l8FvrhVEmGgRI6iIeGIWn6q+GVb6z2sjN
 Wd0F0W03hWuDk3xh88SLPexoDoIWYryOXKT7IZ2tGwBaffkU6ffRRD90lEkNW8Ds7YDunc8mcjy
 sY1bWLeZTEl9VcpRNp4hFB6dDD/E+lYmgjPNCZbukCS0E/czSuPqN3OAZdWY7OTZ/y
X-Received: by 2002:a05:600c:3145:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-48373a74362mr178431715e9.30.1771259184709; 
 Mon, 16 Feb 2026 08:26:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a3f077sm88188295e9.2.2026.02.16.08.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:26:24 -0800 (PST)
Date: Mon, 16 Feb 2026 08:26:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v7 6/7] test/pcapng: skip test if null driver missing
Message-ID: <20260216082619.0e42f1ef@phoenix.local>
In-Reply-To: <CAJFAV8x-9SDi2hfeAHT3zaxr0kSiAEdW=GtHkKz+DTr_K7-H6w@mail.gmail.com>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
 <20260213192039.221213-7-stephen@networkplumber.org>
 <CAJFAV8x-9SDi2hfeAHT3zaxr0kSiAEdW=GtHkKz+DTr_K7-H6w@mail.gmail.com>
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

On Mon, 16 Feb 2026 11:01:34 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Fri, 13 Feb 2026 at 20:21, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > If null PMD is disabled in the build via -Ddisable_drivers=null
> > then do not build pcapng test.
> >
> > Fixes: 6f01a3ca5c7f ("test: fix dependency on pcapng")  
> 
> There was no dependency on net/null at this point in git history.
> Instead, this fix is about:
> Fixes: 0c614a0fa6c6 ("test/pcapng: cleanup")
> 
> 
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> 

The point is if the null driver is disabled the test would always fail.
The commit log is incorrect, the flag would be -Ddisable_drivers=net/null

Seemed better to just not build the test if the driver isn't there.
Alternative is to detect it and marked as SKIPPED. But vdev_init
error codes are very broad, and my preference is to save space/time.

# DPDK_TEST=pcapng_autotest ./build/app/dpdk-test --no-huge -m 2048
EAL: Detected CPU lcores: 32
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
APP: HPET is not enabled, using TSC as default timer
RTE>>pcapng_autotest
 + ------------------------------------------------------- +
 + Test Suite : Test Pcapng Unit Test Suite
Failed to create vdev 'net_null0'
