Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1377D3E783
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 01:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97C5640289;
	Thu, 11 Dec 2025 02:21:40 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id F3AE240285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 02:21:38 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-295548467c7so5873905ad.2
 for <dev@dpdk.org>; Wed, 10 Dec 2025 17:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765416098;
 x=1766020898; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1DEeC2mLuf4TA1lQdvQ72Qth6c4GXCdojZmne2XwE0=;
 b=Mi7ezmC4gc2+POjNvvuH3nGPX1i0R+y1S5Q/tX3Y/V6LtxMtgQ3g61ou+a/7di3/Zp
 ZW+z865nSHRGLEKcoYHncBwzZTrJiju23Ff7Jq66GtmWJbDTy44ZtNA7JaIzZ4DzNjla
 pcodH0FQx5aifvU2+X8U/IPjJHtD5J3DIaOyCIKpp3IztC3SfS2DV6UiAnVwJ1Rk0Uj/
 SSIwwnP5mjv0VEITNg2pb3/62ITd8zO8gVHjpjZSfX2ykIdGM7kjdBROL1n8vzfmxCZt
 BefgBf1ic2YW0C70YzUsGm2+abstWzeqgmYGB+NyBMfSe2quQsXMnBx/aEaA/YoWALGb
 LkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765416098; x=1766020898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u1DEeC2mLuf4TA1lQdvQ72Qth6c4GXCdojZmne2XwE0=;
 b=TREK8G/eRzQkkppXf085DhhoLa01U+XmPaPIFfTWdYwWBBt5EWSxs4S9GWUtmYqXsI
 UTuLjaz1oY/r9lyfLJw1xvLQTX3/QSeDMU+uo6oQ3+bUQe+dcI/CxJ89gJtKwzG6s22j
 lX0lDWCFnfajdS7J5ugnrHjbkWKFUS5jGF6/2XDUFfwrmMgYY90/bq8bPoltgc1pZuzo
 c+AzLBhFkCJ7Atb4PvXolYZMCBvlXAx5mXLeN4n2CFIWMUleEEz1Ywo0+xge/LN0c37H
 i1ZjaagtQ97K/PPr9iialCHQoWNhc8AvBe5zKOw1wrAopm3pm4HnLUgn27s/46d3fLg0
 aw3Q==
X-Gm-Message-State: AOJu0YxyYv0PbAQId4xqV3qXs/87XIXQiwBnSVFQm+8ZcIYTyizv6VdD
 yvzrw2Tnk9DvWEJhetV2SLeI/fLAXB3+IUpprzGXeZ/lPj613HhBNGTz7dyPsvZ6QeY=
X-Gm-Gg: AY/fxX4Y7lRburyLStJbYCnAgDEyPf2v0J3yaN5Vt6b0AAtIM5iX6FBPq/craY7cR5L
 cuyFTxR5n0kvbwQ5jwmisdc8CRWVBdMq2eOAOj3qH463AIeZESnb9yY9rOVJAihcmoBbfEq/t5p
 q2RzGWWmupd+0824r2S/Byztr+/bfdsTk7/y7lIP62+h/6+kiVPTO/5cAGsPfCoGcTcDfunM8IZ
 e+exPd8DeDmhlGIf1zcw4FXs1tSG74qX54P+RY3VU1N3TWFfDvCK+1A/Td2qeKNJmMeW2vzSCEx
 CmFlqU5MqHUQnZMYr2+cmcLiaD6wvtX2NVm4VjOyDHgKHkcgatt/fPHEK/Ru9/7nDqcxu4zdxTT
 wg6Yae6jAgFm2xLGTmMY7cNSBs1uixCrrgwjG8pA6UhEiDRMwLX4T5Tiqc1aVSGWpn9o0OWXlMo
 1z5MNTtt2jtC5GxtNb978S0JHV39Rw/N3v43mpchts9wWl3Q7I3jgdYatNL8A=
X-Google-Smtp-Source: AGHT+IEvp/1MjxVInHvZNfpa2OAmYu78Un+o6PYkt38jJsk8wd2x6jg4TmhHDRk8Zq5g6nm3BeDb8A==
X-Received: by 2002:a17:903:240c:b0:29e:76b8:41e5 with SMTP id
 d9443c01a7336-29ec2d3c7cdmr37800415ad.30.1765416097927; 
 Wed, 10 Dec 2025 17:21:37 -0800 (PST)
Received: from stephen-xps.local (p99249-ipoefx.ipoe.ocn.ne.jp.
 [153.246.134.248]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea043d62sm5312845ad.82.2025.12.10.17.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 17:21:37 -0800 (PST)
Date: Thu, 11 Dec 2025 10:21:32 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: Minutes of Technical Board Meeting, 2024-November-26
Message-ID: <20251211102132.14addc9b@stephen-xps.local>
In-Reply-To: <d4dccf88-6813-4bbc-b75e-a8ea4240ce1b@redhat.com>
References: <d4dccf88-6813-4bbc-b75e-a8ea4240ce1b@redhat.com>
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

On Wed, 10 Dec 2025 15:01:50 +0000
Kevin Traynor <ktraynor@redhat.com> wrote:

> # Discussion of VLAN offload in PMD
> 
> - Discussion over patch for nbl driver that hard codes a return 0 forJ
> vlan_offload_set callback
> - https://inbox.dpdk.org/dev/20251124153545.7123c338@phoenix.local/
> - vlan offload is done in software
> - Issue is that existing OOT driver does this, so it would break apps vs
> in-tree driver if it returned ENOSUP
> - For current release, leave code as is
> - For future release, consider to do some validation at ethdev level

Just to follow up, the underlying problem here was me misreading the code.
The driver is doing VLAN offload in software which is fine (it is what virtio does).

It does raise the issue of maybe this should be done in ethdev layer so
all drivers that don't do HW offload could just be done in software by ethdev.
That would make the mbuf consistent across all drivers.
