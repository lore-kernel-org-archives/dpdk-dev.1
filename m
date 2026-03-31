Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B792A10F930A
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 23:29:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4F9340275;
	Wed,  1 Apr 2026 01:29:49 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 6E6354026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 01:29:48 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-35d9827661bso1903757a91.3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 16:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774999787;
 x=1775604587; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HVFBJHP7ltBj+sjg8mQaWNwdt2KEiGOWCVgpNBVjdU=;
 b=fLm7Bje6uHTcPtDkZ9iDKqxrHgH/xO1pbGoIPou8tX0j8VkanSGQc6SMqpdvQJsdMw
 R0HorDKVkTHIaStFJ7UZd0Gc7LDYFB80ootMLO24hYlJ37KkcY9ENFOOpJjrYjL5WTHU
 ihq4BUwfXbxwVDkqcOVMm5SMB+HP5V4jj284gF0rE0Pk6dzVHn5lX2rLc0l4Y+3MSeCa
 2NsCUkRnvaB+MjRx2Lzeh6HCS25lAo+2s0TuMzcrTtebi/LRQ9mGsWLLg2Yd/ivaLq5I
 pRi61uckJRJXLi5CeMgfcHM5Zz4xq49EXaGFOZy9HwrPlo5FtQxg7TPy1YwvD0iO+1SF
 IKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774999787; x=1775604587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8HVFBJHP7ltBj+sjg8mQaWNwdt2KEiGOWCVgpNBVjdU=;
 b=nNqWspNjqE7J6ELa0HBf7kr8QXVESCQ/9NXQQQWKvLLmKTd+FaONMP4wewDmbEYjox
 y6q2kOrMbvDunBX+fxJxG4+ej2R7EvuYhyOkHUXm5hILZiG8hAQK0aT4j/9HwpGQZrFR
 I11yuQD7A8ss1vPwdcX6XefEYOTznA9hdfKX2R+KMr6DbV8peRcyUM7Q2b4YuAr6hvH7
 Uxjs9xMVixy3pDYPteMsGrlbGp+GT37k8fdubhtPuDbfL8iH3azG6JZlhHNansTaSCEj
 GVqPHdfMvTvMPLTCBSlZObAgj81cUigrgrHVYLonZ2GOq5XsCBuXgmOmRsrXkR35PbK+
 eR2A==
X-Gm-Message-State: AOJu0YwUFD+GKXoODlJmCE0MQIBXSEdmJ8AmxMqI3yTjaZyWmbRa0PUF
 jyzYiUGIFAKrF8lX8aW7GdsOOykJ8dycsz72+3ZPbnvJ3IxaP12cNJIDTuJ6+m6nnXI=
X-Gm-Gg: ATEYQzx21R6cb1t5rAXGUSC4sKiYCzjWpUeORhTZU27zN2zjvlx8012aAYRe+5sXhYx
 9SS24q/LA9UdeYP8aXZr0F+VV98VYbWPt6A97JIzdOAi7AFJJUz7zRmzaYjP10B6ASVh7iTRDPO
 JARTOzSkpo9iIlZAxWle7FYskwuqIh9um/ZLk6PwWbLatptkvEMDGapCFICtIQn4WHzf+3DYX2n
 8E7vsAnzMFJX+xv6XU9JnG31aVtpXkcxG1v//cKqP0ezIXmsZIoLY7LAkiNko/kqhuAkUEJI3Ic
 zEOzMCDwjxqGY5VxixTjipLul5p94co9Oe9lpb5enFUi5x4HB8MByFh+zlbpBUUPqZN6z6ir5dY
 4pZq83Jt876AHATM3m7oeLXFC2My2OF7l4usRuaDDv/qVQWYh+BPK1txUmfngnTQzM4TJrcqIrv
 B4xu9Lt06PupNk97ErlA9F7Zj2HXuAuEhqSn1IX8RPoyb1zw==
X-Received: by 2002:a17:90b:57c6:b0:35d:997c:8ebc with SMTP id
 98e67ed59e1d1-35dc6fae436mr929564a91.19.1774999787339; 
 Tue, 31 Mar 2026 16:29:47 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe6d8682sm2770929a91.14.2026.03.31.16.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 16:29:46 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:29:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] power/amd_uncore: detect esmi lib64 using pkgconfig
Message-ID: <20260331162939.4fbfd937@phoenix.local>
In-Reply-To: <20260331040958.126869-1-sivaprasad.tummala@amd.com>
References: <20260331040958.126869-1-sivaprasad.tummala@amd.com>
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

On Tue, 31 Mar 2026 04:09:58 +0000
Sivaprasad Tummala <sivaprasad.tummala@amd.com> wrote:

> Replace manual detection of e_smi_lib64 library from find_library() with
> dependency() via pkg-config in meson.
> 
> Meson find_library() API may select incompatible libraries,
> requiring additional checks. Using pkg-config avoids this
> by providing correct build flags via .pc files.
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>

Looks much better. I know Fedora has the library not sure about RHEL, Ubuntu, ...
but they will get there.

The documentation needs updating and a release note (for 26.07)
would make it easier for the user.
