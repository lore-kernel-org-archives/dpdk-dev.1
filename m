Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E67DC369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 15:59:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B125740156;
	Sat, 26 Apr 2025 17:59:29 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id C2950400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 17:59:27 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so3923251b3a.0
 for <dev@dpdk.org>; Sat, 26 Apr 2025 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745683167;
 x=1746287967; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeOTflAoxXLRjTnkjLH1IrMz/Chft/JXio0BQ9RpZnQ=;
 b=DBirBVZF/PhRgGQXwux9BJyRqyT0uVuxOXgikf0MU4GYdxsLSBKus06MAFDMPDD1d7
 QL7eFPA/50WC0M4Kidkn4IJEH/jWIX+C/e/CtOACF5kspc+us73ftob1FfAvciiUSQwU
 BjtuUjZspLL6k5m56lYyupipnObVd/w4Pd9hGCqSdzvcn2//ybCevqYo1evq76ojOl1w
 pTziC8ywRgdkqsQ/ag/JDGSQJnQff774aedEvGfsWWnfSR9vi4xygn70qIZvwaBWAjuD
 Gc30HHC0uLdG5Nn+GrsO2BPSMvJGQfcAyGxoLMP2lZ5tRvRl5T2qGCNi+g0nmkxjoOiA
 v9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745683167; x=1746287967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeOTflAoxXLRjTnkjLH1IrMz/Chft/JXio0BQ9RpZnQ=;
 b=gyHEclQN/CFj3KKInDD+zw9dnl4eBBO9cIn28Snj2sDD+RSF4vtgMZSLz7hzNElr8o
 3pahN32bi/Xkag6X0AQ88DlnOIJWOHe75eBb5E/gm4MQ+lQZT5DBvT97emqDTt1bNRu7
 n41y7xUK43/KE6BVnqvcVa/GmoEp/Cwc1m9L1XFefgdacfTiMfpC5tYBTtv2ciLKNcGn
 YCBO35S4pv+qK6jjvkGGiUgsQI4dHoJa14jhLwmgN+ND0sqEcXtIVtsCP7zo1ERX44Le
 ByufNtx5Ch8q7uLxXJtMyMTm/zf0qYtAgoukrZlZIHxhgcunk4TDCoiO045HyKGX31NO
 xp3A==
X-Gm-Message-State: AOJu0YxaNplzZzZjsXUzsGNu+SILBWWomw7l88VAL0yRTGRvh8Tu2jvN
 tktOnGw0qOagY+FTPCuoO9JqNsvwac5Z1xSlMZno5Wk4MAsN6Pxyy88ETRTow9ovhRVcrv3Dy+5
 n
X-Gm-Gg: ASbGnctWPSyIRCJd6O8bEwaQgh1dcTaNqwaYysMNbW5YuCDwLb7Gq1gouLMfq4+hnjt
 XfVVSRtDRdCOl3CvKRg+eft4tYkDeixFGHdcANGcMSoXcmp5/pwVe7JAiNSowcmRa3WyB9UQZ6X
 +ewoQ30NIHHZUla5k5SjFFy1/gyiYxuIMPRQlKiMrIyx0Z4qpjSIgjvd5C2kvIcNZ2AQbKaaIM+
 pCnSvGNQRIh4Q4rdiCxG6MjkJ9ZfxnXOXCsg6a+BMR/25uAyFoCOqpngURyxuY7Yk8SR27bk6uY
 yED3/QDNEKsDqi2oY+njk+1YE4f/SqMjRCeaXmhOJx0KvEwZ52GWWkt6uebnI9YYS2Eic9/JxLm
 qIqgmeiCdjfGkTuvXE2ytg1rTaWo=
X-Google-Smtp-Source: AGHT+IEXbmXc4pzyKxnzkfju9YgPEjzhI9Gyy8uvbD3Im+VU668doz9MAQ5TDyevHvdVBLwnqGULag==
X-Received: by 2002:a05:6a21:9984:b0:1f3:34a4:bf01 with SMTP id
 adf61e73a8af0-20446023399mr14199998637.17.1745683166771; 
 Sat, 26 Apr 2025 08:59:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f8597fc6sm4558282a12.46.2025.04.26.08.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 08:59:26 -0700 (PDT)
Date: Sat, 26 Apr 2025 08:59:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 01/13] net/sxe: add base driver directory and doc
Message-ID: <20250426085924.6af1152f@hermes.local>
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:40 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> From: JieLiu <liujie5@linkdatatechnology.com>
> 
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

Fix your editor settings.
All files should end with newline.

Applying: net/sxe: add base driver directory and doc
Applying: net/sxe: add ethdev probe and remove
Applying: net/sxe: add tx rx setup and data path
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:141: new blank line at EOF.
+
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:162: new blank line at EOF.
+
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:578: new blank line at EOF.
+
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:1141: new blank line at EOF.
+
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:1175: new blank line at EOF.
+
warning: squelched 6 whitespace errors
warning: 11 lines add whitespace errors.
Applying: net/sxe: add link, flow ctrl, mac ops, mtu ops function
Applying: net/sxe: support vlan filter
Applying: net/sxe: add mac layer filter function
Applying: net/sxe: support rss offload
Applying: net/sxe: add dcb function
Applying: net/sxe: support ptp
Applying: net/sxe: add xstats function
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:726: new blank line at EOF.
+
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:809: new blank line at EOF.
+
warning: 2 lines add whitespace errors.
Applying: net/sxe: add custom cmd led ctrl
Applying: net/sxe: add simd function
Applying: net/sxe: add virtual function
/home/shemminger/DPDK/main/.git/worktrees/sxe/rebase-apply/patch:4006: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
