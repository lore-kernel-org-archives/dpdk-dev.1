Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C648C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 17:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3933141143;
	Sat, 22 Feb 2025 18:34:51 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 38A0F402B7
 for <dev@dpdk.org>; Sat, 22 Feb 2025 18:34:49 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fbfa8c73a6so6330651a91.2
 for <dev@dpdk.org>; Sat, 22 Feb 2025 09:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740245688;
 x=1740850488; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrBiZLyGbNDoPpRwnnSyCXIF6QTWeAjQvyUrK5NIyNo=;
 b=DbZrCtskITMGgHj2pfkfuFchfBoi/JKvpKJDXtJ8DVFv0b9QEJVut8mMy9jK5VarNd
 hwVQeIqD3rzAc6kZGb8p3K8v82xhbQm6AeRKpp4mQJVjrEhce7C3xSPzm+xiphZA+WlG
 p7mKPWCHi5/nNTY9IAXhFPsRmnYdXB3rLRFbEN6bjIa9mS/5kfAwB5tjkNtsoz0G29yp
 s8e4DLiWEy6sOwWwcfn6z0WapPBmgLTp0DofQ+P6tVoqeJlS7k+FEW4xsSt37ir+2duA
 mbfTGa6xygq7R5FbopGtOdap4EtNqDbCL9Vr3Y6Jdc0TeAUznnc7wEirD9A7DWw7fBwe
 LVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740245688; x=1740850488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrBiZLyGbNDoPpRwnnSyCXIF6QTWeAjQvyUrK5NIyNo=;
 b=o1gkhEE/Ker2NzU3AeWO9RhUkHpRv9Y9MkLcwMy1GhSenkWCck4wvq+Tc6GtyHO47L
 X76oXVl9w69wtKLGHRfvlqKWcG+BErx+rypSB3CHu2C2zYWlNLn/WDkVyhGOS8eetgqx
 K8IVr7LcLBsVtdgdnWc4AiI1idV44Yw616MeNu6nSHctT+fexF8dNJU72Xx+GvmT9xuR
 SHYYONTOtn1OU0M+bEtp7B+8yIAYbSuGzOyQZhmiwWhpdrdtwQk1Tn6zx5EhGt0SWJ8u
 Mi/ZZzdEKeKftXZ1iEtU7YwPY7OH0K3Bw5jrI9jReSQV5BzBuWlP95f0i/uvnvwu3aVB
 qr6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNnflIg2TsNleFLAnwONomWMFJpwh1yRsR53e98hmxrvqiJwAYdJuDL0Roi/cwZUaRfYs=@dpdk.org
X-Gm-Message-State: AOJu0YxyessbwjJeokBcFBG+BPKUBeWx31ZD8kHLYyX1qyBSoLV5/7xG
 0/iFHT0eYMducG/CiDtePXFs7+jOnoRVta6K2NDCR1oqsUSxcoBUTg9C9zwWUv8fOQNUcM4KNNv
 V
X-Gm-Gg: ASbGnctni2kh1PWudgedY6K+PF1/dOeX0e7PACHTr+jjVK0eY+av7/OPe4evr2S34/d
 oEsFybmeFk8PU57Snk/JIJNahUhlhxavbq36SO+A2qUbU8vg2ZkLFlCpAuQhjxKD/F4AbBea1TC
 vTn2iZT7OncIrh2GPDu5wvNos12kR3m4rS5jtjug3O0Q9HMKFbapRYkRtiK0xWehpEaIJJIrL+T
 9qwXg+Ovegy+WukKB7mLpMzLAASwxrRPJEx1vdjsoachJQ3fJr2hz7Yh0xDGvMZmpcW3uRRcgGZ
 Gwo3mFVtIiTPoED3M+OXZfBF4FOV6B5VwZRRBZf0Ozy6Bp+XkHgMACDsCeYYA4zrxBK8wiBP/uq
 /5iM=
X-Google-Smtp-Source: AGHT+IGdzaMzKUTALuWP0MT3OTeG4/M4QUK3JH32UQv+KW9zyb94FJaNGLZLRJeFhNG2p/X6Dtz76g==
X-Received: by 2002:a17:90a:d40c:b0:2ee:fdf3:38ea with SMTP id
 98e67ed59e1d1-2fce87243b6mr10433137a91.23.1740245688363; 
 Sat, 22 Feb 2025 09:34:48 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb04bf70sm3413558a91.16.2025.02.22.09.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 09:34:48 -0800 (PST)
Date: Sat, 22 Feb 2025 09:34:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v2 14/14] net/zxdh: clean stat values
Message-ID: <20250222093443.131f1b8a@hermes.local>
In-Reply-To: <20250222072232.561353-15-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250222072232.561353-1-chen.bingbin@zte.com.cn>
 <20250222072232.561353-15-chen.bingbin@zte.com.cn>
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

On Sat, 22 Feb 2025 15:22:32 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> Implement stat values clean operation by agent channel.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>
> ---

The conversion to spinlock is good idea, but now the lock annotation
is catching a different issue.

It helps to have a cover letter on each patch series

-------------------------------BEGIN LOGS----------------------------
####################################################################################
#### [Begin job log] "ubuntu-22.04-clang-stdatomic" at step Build and test
####################################################################################
[2300/3227] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_common.c.o
[2301/3227] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_msg.c.o
[2302/3227] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_queue.c.o
[2303/3227] Compiling C object drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_tx.c.o
[2304/3227] Linking static target drivers/libtmp_rte_net_xsc.a
[2305/3227] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_np.c.o
FAILED: drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_np.c.o 
ccache clang -Idrivers/libtmp_rte_net_zxdh.a.p -Idrivers -I../drivers -Idrivers/net/zxdh -I../drivers/net/zxdh -Ilib/ethdev -I../lib/ethdev -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal/common -I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wextra -Werror -std=c11 -O2 -g -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations -W
 missing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=corei7 -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-address-of-packed-member -Wno-vla -DRTE_LOG_DEFAULT_LOGTYPE=pmd.net.zxdh -DRTE_ANNOTATE_LOCKS -Wthread-safety -MD -MQ drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_np.c.o -MF drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_np.c.o.d -o drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_np.c.o -c ../drivers/net/zxdh/zxdh_np.c
../drivers/net/zxdh/zxdh_np.c:621:1: error: mutex 'p_spinlock->spinlock' is still held at the end of function [-Werror,-Wthread-safety-analysis]
}
^
../drivers/net/zxdh/zxdh_np.c:620:2: note: mutex acquired here
        rte_spinlock_lock(&p_spinlock->spinlock);
        ^
../drivers/net/zxdh/zxdh_np.c:626:2: error: releasing spinlock 'p_spinlock->spinlock' that was not held [-Werror,-Wthread-safety-analysis]
        rte_spinlock_unlock(&p_spinlock->spinlock);
        ^
2 errors generated.
