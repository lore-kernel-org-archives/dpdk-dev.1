Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618A8D3EE89
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 16:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6BEC4027A;
	Thu, 22 Jan 2026 17:09:28 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 8519C4026F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 17:09:27 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so13007785e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769098167;
 x=1769702967; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAdSQLyAI2x6B/ZqrUQBe0G5boUNWurrF13dt7P6wGk=;
 b=rmpfXJR06cnQYPZBrznvS2x/J91u+v03Q37cyT0gey6bQWffFsCtlhtmjOdnAN7gbi
 IxrbC2+3YY58u0qSt+Otd96Qp3ZBOon+9LxxHno6NUDLSg9dcgp4jmcz8Cq7oH/pK8Qu
 f3boRfSISZ97J//18RNkDN0+VFPxfi/c/6baoJV/A3Hd08v2FytyWYOa7fOludmceOLn
 EqACFb6KkDK+ZsUcyirDy33u01r08rjJ5ABRikXwfFMXn7lt6gz7j1M8hC0Ob9YVD1Fl
 1fZCvwJiOhOJt51XcpQZL2mxielaH5EhbtiTkEqjXJzj0Vp3MBgBjKP5SDYMu0j3XtTK
 enPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769098167; x=1769702967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HAdSQLyAI2x6B/ZqrUQBe0G5boUNWurrF13dt7P6wGk=;
 b=eZFVVB6yHJjk9EquZULylDluoKl7oPCdrJYGOA4AVfgP/7vwFyg1/n+4oR52S2X1Yv
 eOa+MBFBJAUyi9tSF/V/r3i/Ahez+v51FwcWsQKbopVJmVZD9dcAYFeLR0FQrvmgHgkO
 D29YexpXYnEIsIDBqP5g57wTgl3JZ4vEz8lCSsA9+QUswmjTrBTOcEGnmMwADn6rK5qZ
 bTIotOYqIhihmMgLQjNJVOzcAdauF5rTy+lG8YfMCtINT/SXE/R3g9igg6/u8JqAcb7C
 GHUz5ufGTuZQQML358yOR4k+nrFtc+wWgXkWcF5EAF6CJTFjFnHTTvxSq3yiasLhELge
 rw1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz95XWDwRAA/vSjKP3IYXyRhh+urzITyR+ylTW9Su1BRTLP3j8ONkyLuI2+72qSPi0iG4=@dpdk.org
X-Gm-Message-State: AOJu0YzV3zqIKk6Iqtss87HVo2M0Ig2kYQXWD3OOG69Ul/Olnccyp2H4
 QxVWfECT4oiY58Tnd4/RltjAhc2o9wAhVlSX8kMjQNj5eAhE1crFa0iFcBufpm0JjVY=
X-Gm-Gg: AZuq6aL+s69MfYOYOLWD1YnHx46ElbYBDXMYA2ubgTncR8xszyGAYmEDOIyaLWltW8Q
 Avux5obsXNA7bLjGuo9Zg5++E81AaNvLZ06vDGZ02jSm+aDI2fEXEWSpHa9DesB+8NBe1A1Svqg
 1zPxv1ZxshKy0EVgq3Gz3U4Yp3EAER/GopdU1uOkDqk6xg52JqoWkjZG0PrQXDzcKWNj8l9o1FV
 Encx2j36IuuFq2ZPezY/e+cntI7yvpbqHj4QWZqQKYLfhqX/rRgacFv9AqUvAxY01qSJTSNa9Os
 I6JwMu9M3JKQs7gZxgs4muI0SlcVNFgRwuc7wyMyh1bYiCqF1QkaTLbBLEMZukHW5UnTHWMEZQ9
 GyvH1sbZzuGCUHzA0hizu+ktKWIv3ohUNQtBPPgN3ZAUl0hhSTeFTARXRZPzdQfdbInCdQxPPN2
 kwxZAqPANzHXmpQ4GgZvLfzi0yCQuyKlPDv/Vm4dmsEaXQTUMByOEP
X-Received: by 2002:a05:600c:37c7:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-4804c9bc5d3mr2077485e9.17.1769098166702; 
 Thu, 22 Jan 2026 08:09:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435ab458d85sm5953907f8f.26.2026.01.22.08.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 08:09:26 -0800 (PST)
Date: Thu, 22 Jan 2026 08:09:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, <dev@dpdk.org>
Subject: Re: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Message-ID: <20260122080921.1f06d6af@phoenix.local>
In-Reply-To: <aXI7STpuEtMWQloB@bricha3-mobl1.ger.corp.intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568E@smartserver.smartshare.dk>
 <aXImy8tDAqFygz_T@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568F@smartserver.smartshare.dk>
 <aXI7STpuEtMWQloB@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, 22 Jan 2026 14:59:21 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

>  
> > Then I'll suggest an alternative to this patch:
> > Change the fast-test application, so it emits an informational message about which tests are being skipped because the net/null driver is missing.
> >  
> That is sadly non-trivial, and if we do so for net-null, we should also do
> so for a bunch of other components where we disable tests if they are
> missing. But the idea of just informing the user rather than force-enabling
> the driver is a good one.


I am ok with either of three solutions:
  - require it to be always enabled
  - in meson.build, add dependency on net_null for tests that need it.
    (that is what my patches did)
  - add per test checks for vdev_init failing and return TEST_SKIPPED
    There also is unsupported status, but that doesn't appear to be used
    or work right

Doing dependency at build time is my preference.
