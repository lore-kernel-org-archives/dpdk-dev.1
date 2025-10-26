Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A10CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Oct 2025 18:02:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF94D40151;
	Sun, 26 Oct 2025 19:02:27 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6736C4003C
 for <dev@dpdk.org>; Sun, 26 Oct 2025 19:02:26 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-290d14e5c9aso53583865ad.3
 for <dev@dpdk.org>; Sun, 26 Oct 2025 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761501745;
 x=1762106545; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4MrHX6wrnE7eO+Lk2u7x+jzTrBIhc52qTIMiCiklSs=;
 b=tBWDurfUHvjo30+nlT+o6knNncNicpPMV/mfmxXQeREkWCHkJT0QpsF9ccnadAo9rg
 uZtgBaaFbJpEMixBs4LIZ+xweta5ii4/yWVjzzpATOEiGTpJYZ3EdAqD0yhjN9svwFH3
 C+nv77Vm3WFz0tcGGO/L91gNzVKNlShjC3Uxv7JwdiITkbw4oRtM+BLIxWsdAQ2C4U2I
 703SJJZOnzUnR1Oy2H/6rpxeUd+l0ql4F5kLkjmODZFw09OHkmduQM7TEIZZND9WDjpk
 CW8+x46DdWOwretA9nTwTKH3+iXIrqigU6gZeNPanoGLQpW8/HsvVYASQTsGKieUsnl1
 UHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761501745; x=1762106545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4MrHX6wrnE7eO+Lk2u7x+jzTrBIhc52qTIMiCiklSs=;
 b=LYyRNU+p0lyUYrDZaZsiijFlPGLn0o42XfuUQ1ZZ/LCan/N9i36csRI34WducZ8dE+
 DwM59A/Hz9aT8g374WWHJPRUut04Cd+MrABI4NIgwd+Ld59UrCr/M/5k9AfguwTvGgGz
 IMlan8B3nQtab6oO7b5HyWEzvlvk7CP57EiBAOZ2FCzFj5fDmESDdtnf8/SjPG6xHbnc
 emzodQR84FXxXLU3cbfkZB9LzNqKe5GH/xjRZ/dyoLxFunGpzVi7llBISUFSU3cgFQU3
 X9ZZB1mgj3Kh9s7RLriVspsGgQx5e2a0FuLWX53fR7KXs+9qGWJ1/fCaObk9jHkb5eX1
 YB+w==
X-Gm-Message-State: AOJu0Yw9b4IqpFbLwVyI04BA1hSSj6DfrlJTTAutfhblUDbOwWb4mqmZ
 V8MFqaeTa15iKbOtJrHk1GnM8jrg9+ZdSJCUJmh9JDIVkpRzfrEu9TgbXQf+K+1uGD+NYXToyA2
 tiG/t
X-Gm-Gg: ASbGnctJKTGDUYPKADx+VI2ipG1guh2svv0pVaBQou2f2G3vEUVc1flkMVWXIaeG6y7
 Ms/APHioAnTKUbaUWRXirBxj4KMMN1+DI++JIVOGJdytxLbOEs4iD8g0mvsxHWwCZlt8avw3htu
 vzY12vBuWxqACdH/Pinv38iKFN2rk+S1DbPvxzRHb2/Xz36vjyQjVrieNIDm1ZXljsCWxPtFAdo
 E7TgcIVxur1724vMSB17OyUE1qt/yljxIpcqqrGIoTogw56OD1lcve7cxV4xaphYQ42WJJPy4Pe
 I9rH8PrSAAvCNE3aXCECHzvmHvmUpqUvxvxtGdeyjEokRiCQ0M06CoH2AZYrh4dF133Vdrc7gYr
 FHhxSN+mBzYCADBDOb03tZ/3O7NabYejjbV4xZdl/sJKFuYGE0Afc9cRvZpZUsKlbDtvOmULtGN
 9UIybd4ovrO+zYQ4MWFik4Vh/3ruxHl+NKVA==
X-Google-Smtp-Source: AGHT+IFnu/3R068pzsTIxWlt7rhI3QezZTqCbYSYV9janLiFKNufHkqSyglhfdNsdXKZtmqECMjN2w==
X-Received: by 2002:a17:902:e5c8:b0:290:c5c8:941d with SMTP id
 d9443c01a7336-290caf851a8mr542776215ad.39.1761501745136; 
 Sun, 26 Oct 2025 11:02:25 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b71268be14asm4962550a12.4.2025.10.26.11.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 11:02:24 -0700 (PDT)
Date: Sun, 26 Oct 2025 11:02:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 3/4] net/macb: add NEON vectorized Rx/Tx
Message-ID: <20251026110222.1f24c933@phoenix>
In-Reply-To: <1743577152-119846-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577152-119846-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:59:12 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> To optimize Rx/Tx burst process,
> add NEON vector instructions on arm architecture.
> 
> v4:
> * Support hardware Rx checksum offload.
> * Fixed some code style issues.
> 
> Signed-off-by: liwencheng <liwencheng@phytium.com.cn>

Build is failing on Fedora for this.

FAILED: [code=1] drivers/libtmp_rte_net_macb.a.p/net_macb_macb_rxtx_vec_neon.c.o
clang -Idrivers/libtmp_rte_net_macb.a.p -Idrivers -I../drivers -Idrivers/net/macb -I../drivers/net/macb -Idrivers/net/macb/base -I../drivers/net/macb/base -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/arm/include -I../lib/eal/arm/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wextra -Werror -std=c11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wcomma -Wd
 eprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=armv8.1-a+crc+crypto -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-member -Wno-comma -DRTE_LOG_DEFAULT_LOGTYPE=pmd.net.macb -DRTE_ANNOTATE_LOCKS -Wthread-safety -MD -MQ drivers/libtmp_rte_net_macb.a.p/net_macb_macb_rxtx_vec_neon.c.o -MF drivers/libtmp_rte_net_macb.a.p/net_macb_macb_rxtx_vec_neon.c.o.d -o drivers/libtmp_rte_net_macb.a.p/net_macb_macb_rxtx_vec_neon.c.o -c ../drivers/net/macb/macb_rxtx_vec_neon.c
../drivers/net/macb/macb_rxtx_vec_neon.c:59:30: error: cast from 'volatile unsigned long (*)[1]' to 'unsigned long *' drops volatile qualifier [-Werror,-Wcast-qual]
59 |                 vset_lane_u64(*(uint64_t *)(&mbuf.rearm_data), mbuf_initializer, 0);
|                                            ^
