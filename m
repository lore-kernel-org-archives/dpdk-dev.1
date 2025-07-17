Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A150AC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 16:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 785914013F;
	Thu, 17 Jul 2025 18:46:03 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3C533400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 18:46:01 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so1580229b3a.2
 for <dev@dpdk.org>; Thu, 17 Jul 2025 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752770760;
 x=1753375560; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Flb5PALDsd7ty1hzeaKUOqFbFkYUUqCZwuAK3oWs9Q=;
 b=fzgGPOGC8z+ibfa0FNEC0o/ctQeOOMrJ2WKAhNMle1xlZuilD/VqRJY62GYCsCs5Ym
 h5kVuojmV5ryBaihCKJ7KAP18eSa3bMUhqkRy/vu8wDgNxuKYYkmZEr92h1KNd7+ppQT
 D1h8Dv7mdvy+nnoMqsSDzAxmiaVWNk9DKzkJNi+7QE4PZLiCjRb/AriBv0GOhhg3q2QU
 DkI7A7seiESPCuVEnwvdKSNya5xZwcMDFYF9YHboSX0VLBdYkIZ72CEEUw/2ic8R4+VD
 uNYhgeobNTzrU6SRHon+p22b9qTfL9yrzx3a2wJdMUiX1XbrmM0xn1YhddeSwlfZR/Z9
 2chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752770760; x=1753375560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Flb5PALDsd7ty1hzeaKUOqFbFkYUUqCZwuAK3oWs9Q=;
 b=wL8ebQwNPU+C6FNcOMYuDW+FLW0tm3huWsumyc04+xg6PiwOzOFgdi6ohgHpIFfsMn
 NUibSWWi9u94Anmt/hNcHw6OiXjrWNWjbtf4qbqTJbfzXRLUAi/j0VHnc7QVaUYv3lPK
 fWMGgep95UioJZymao0C8Bef+qBHAmwK29+wVIsjPYqugq368xmkAVeVFiHD4GdmTMoy
 5EkfYpPCxOakPYWhkIQxKWpW3NbIEsPhjfXjoxq7CkttETSFedlVTy/2d+gsrvuuTgl8
 U6yo9xZJGTjS+IWpK3arZO2g9TGbNfnLk56fo6KCc4yIENZ3MesKEbxfFV82YUywLbBx
 9ghw==
X-Gm-Message-State: AOJu0Yx9aaXRDpyp+a9591xtg95rnVvmhmAKRRLqTQ3ZdFXm6mB6/PeB
 B+e5JPpJf3B6gAqSc8qXr8amskCpSNY3b1GPr6Q9sqbiq3t33/ezj+LFibpR4QXtvaiffz+pebX
 cKd1Z
X-Gm-Gg: ASbGnctX43xrTbBeMvHdUvo/+upRewXs1Mt+NBxndDF8V6HycZS/eknJVPBWNTJ7pmy
 SQayJpmVuoxrF1bpapMeE9ysxG4gPw1+8rLyU0A2amv1jhiUtJVeYzAhtT0DMrk74Z7swBRrkOS
 TdLdbmo5EhGc8LXnzUspe0l6PdDPNMvkzmAX3T8GBJDyYGiHQBI6911F3d/K9jYthu2Q8AFH37i
 bg5T/ls03KnSoDviua+CfalgXJ0/TYxwoM5SFG/MSg21sGWzsyr87ICfFjxnwHXfw0w98RBYxZj
 wl37Iu155KyhWCCrBxpkM3I1o2WzckFjprKQK8H0VFOlyn273NiFI2iszkahepf9xxWt+X0XFgp
 C57P5+8d/gjSTNpQbfEGzvrT5vzlRF7oDN0sg7gH0wL7h7fsjgrfsaa93FDhP6cai9hWEGAcqyQ
 DgAlc3CfApzA==
X-Google-Smtp-Source: AGHT+IGds/mf3i77ULPEKW60SrqkWruU2KhNxXM3pPNVdPca6U8GJcfvJejrQUzgrL5ddS9jxHarYA==
X-Received: by 2002:a05:6a20:914f:b0:235:2cd8:6cb6 with SMTP id
 adf61e73a8af0-2381325304cmr12486310637.34.1752770759926; 
 Thu, 17 Jul 2025 09:45:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe723d3dsm15643885a12.67.2025.07.17.09.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:45:59 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:45:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 13/14] net/sxe: add virtual function
Message-ID: <20250717094558.22ee96a3@hermes.local>
In-Reply-To: <20250716082930.83026-13-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-13-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:29 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +struct sxevf_thread_param {
> +	struct rte_eth_dev *dev;
> +	pthread_barrier_t barrier;
> +};
> +

This whole struct us defined and never used.
Driver should not spawn or manipulate threads or signals
because it impacts DPDK application.

Some exception for use blocking control threads allowed.

I look for including pthread and signal as flags that driver
is doing incorrect things.
