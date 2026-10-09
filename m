Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE62BCA9EBE
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 17:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B786140274;
	Fri,  9 Oct 2026 19:29:36 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id EAC634026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 19:29:35 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-88c72646f03so3701012b3a.2
 for <dev@dpdk.org>; Fri, 09 Oct 2026 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791566974;
 x=1792171774; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EjvyItP5YwAA8bfhQbqIMFTiD23YxEbJIKf/Y/1ihuw=;
 b=sGExUVDjaLPX6uQDy/IC9kYa/JY95v4HD4XxzTYtPc5RCTisP2uXxJ+T0cnCMbkiX+
 hkOzhME5s0d9bPLheAIn+I7k2gyUL5Eza5fmxk70mgsz0nJu7iA8wez59agKGrjaXBaQ
 DTBJdZgppX9J3GZo/c6AVAMeBZ9kTPY05MWs4QFvUd19TWuLp8ERk/A30kRWilb95y/M
 mrsGFtfrAMzF4/5zlWJsQpM9nA/e4u159FhVeg4+wSJ+i1AnF+9PM5GC2bj6FBe6E1wU
 kAOZWEZCLL3BB2BlisYhfcv1WUKrVUIeqxlIZ7csJi4ennAUgR2A9SnOvwNsHtulZnpu
 +9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791566974; x=1792171774;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EjvyItP5YwAA8bfhQbqIMFTiD23YxEbJIKf/Y/1ihuw=;
 b=hsDcpHwRnRGBuSiJV4OaU5lcfFSihtuttv49efMY4iSUDiXI2WdxymZ+9gZQdBBYMU
 Pg0od2LjDR+eVa/Ioh3QCoZ2ndcsMYG+0VGw1RtMQHeWUNEoyralqFfU2DkRoxCmnPNF
 AEPz9XDrSshnjG5ue6DQqf3Re/MZqCiW6eR7vpiOkWdDCjODGw9lo3zozgRYmpKE2T7f
 sp8tD0OQw9Evra4VYiS+B2DbgsT2oOPneVR1YXQi6lq75cJcYy/09yJggg7cTvVAO2AM
 Nuzisnzp15iFwZJrTlxcSrtSJ7OpyE5dRbo7zf3qDG16MruSxpUMFwSIp3yS/U3tQ+ox
 PuWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVojg+/4W3Jx4oL/wlQG8ex4NM6hoTPzHAStb3fL1EJfLVTJtW1N4oeZZVEa4fFWUTzl0=@dpdk.org
X-Gm-Message-State: AFq9FYIUU38FtCVTUBIQkpn8/BWg5PrIGL4XN8mgU0IE/6XobNRmycuG
 hkC6wHj9rxD6vYAAjZc/cJyGyZNU5qLO/ODgBgrQmwI8kp4APaDM1n1V2xb5k7tui7I=
X-Gm-Gg: AYBFou30pyv3C6RNnIiDeW874zQ54u2xC8ctSB6d1wuBF+54RJFzKlpj8XMJmytmqhe
 OgvlU9nrz+W9C+XIkIlnHOg4tuUQOxLktLso7eS5VCBZ6rySr3vzfx3LcbozeouVyhD96Y5eHmU
 ub8BKPEHiRUEWs/t0Qp1v1Z3cq2OWsxuc3lKzAWL+XyN8rFYDwviHI59ZO0xUFPP97bMj1GPuNo
 Trd39Bei3y01cdbCjaeyBJ8PYVg8BtI0VFoJ5Dtk6I470m8yCA7pnew3lOiwaLSmDixpKHFErGW
 XmRVM003fR1+bUP6YkGkqK2QOjMlVQv0hV0f8C1xXo6MJvBxd1rqCvxhMTjGXHm9FLY87K/tOP6
 7LS4RE0UvMPCdP1Iac8p+Hwt8tASn77Braf45zMgppRtOE+nGfdwgXPAm0PaP3lXB0zdzvqS4T8
 svM/sQPdVR89mU4q9yzbLoOEqyZ23hyFyBZRv2Aq3xgSRAaBB8aE2WoYZpa3nu3CWw+WULTsV8g
 w9B50Mg6aULz8/NCddebdzPYprFOVRDwg6UMQ/s
X-Received: by 2002:a05:6a00:3d16:b0:892:8a3f:450e with SMTP id
 d2e1a72fcca58-897c81b6476mr2536799b3a.45.1791566973999; 
 Fri, 09 Oct 2026 10:29:33 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c31071absm1538483b3a.15.2026.10.09.10.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:29:33 -0700 (PDT)
Date: Fri, 9 Oct 2026 10:29:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v23 00/27] NXP DPAA driver enhancements and fixes
Message-ID: <20261009102931.25cc00eb@phoenix.local>
In-Reply-To: <20261009091101.1703494-1-hemant.agrawal@nxp.com>
References: <20261007072439.3135351-1-hemant.agrawal@nxp.com>
 <20261009091101.1703494-1-hemant.agrawal@nxp.com>
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

On Fri,  9 Oct 2026 14:40:34 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> errata-workaround devargs. Documentation and release notes are updated
> accordingly.
> 
> v23:

I did build test on this and it fails with clang-23 which has more
detection of unused variables.

FAILED: [code=1] drivers/libtmp_rte_bus_dpaa.a.p/bus_dpaa_base_qbman_bman_driver.c.o 
clang-23 -Idrivers/libtmp_rte_bus_dpaa.a.p -Idrivers -I../drivers -Idrivers/bus/dpaa -I../drivers/bus/dpaa -I../drive
rs/bus/dpaa/base -I../drivers/bus/dpaa/include -I../drivers/bus/dpaa/base/qbman -Ilib/eal/common -I../lib/eal/common 
-I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/inclu
de -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvar
gs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/a
rgparse -Idrivers/common/dpaax -I../drivers/common/dpaax -I../drivers/common/dpaax/caamflib -Ilib/eventdev -I../lib/e
ventdev -Ilib/ring -I../lib/ring -Ilib/ethdev -I../lib/ethdev -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/m
empool -I../lib/mempool -Ilib/meter -I../lib/meter -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/timer -I../l
ib/timer -Ilib/cryptodev -I../lib/cryptodev -Ilib/dmadev -I../lib/dmadev -fdiagnostics-color=always -D_FILE_OFFSET_BI
TS=64 -Wall -Winvalid-pch -Wextra -Werror -std=c11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wcomma -Wdeprecated -
Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-styl
e-definition -Wpointer-arith -Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-missing-field-i
nitializers -D_GNU_SOURCE -fPIC -march=native -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncat
ion -Wno-address-of-packed-member -Wno-cast-qual -Wno-pointer-arith -DRTE_COMPONENT_CLASS=pmd_bus -DRTE_COMPONENT_NAM
E=dpaa -DRTE_LOG_DEFAULT_LOGTYPE=bus.dpaa -DRTE_ANNOTATE_LOCKS -Wthread-safety -MD -MQ drivers/libtmp_rte_bus_dpaa.a.
p/bus_dpaa_base_qbman_bman_driver.c.o -MF drivers/libtmp_rte_bus_dpaa.a.p/bus_dpaa_base_qbman_bman_driver.c.o.d -o dr
ivers/libtmp_rte_bus_dpaa.a.p/bus_dpaa_base_qbman_bman_driver.c.o -c ../drivers/bus/dpaa/base/qbman/bman_driver.c
../drivers/bus/dpaa/base/qbman/bman_driver.c:19:12: error: variable 'bman_ip_rev' set but not used [-Werror,-Wunused-
but-set-global]
   19 | static u16 bman_ip_rev;
      |            ^

$ git grep bman_ip_rev
drivers/bus/dpaa/base/qbman/bman_driver.c:static u16 bman_ip_rev;
drivers/bus/dpaa/base/qbman/bman_driver.c:              bman_ip_rev = BMAN_REV10;
drivers/bus/dpaa/base/qbman/bman_driver.c:              bman_ip_rev = BMAN_REV20;
drivers/bus/dpaa/base/qbman/bman_driver.c:              bman_ip_rev = BMAN_REV21;
drivers/bus/dpaa/base/qbman/bman_driver.c:              bman_ip_rev = BMAN_REV21;

There are some non-urgent things from AI feedback that you can cleanup later.

Applies cleanly to main (1d020e1).  HEAD and each of the 27 commits
build with -Dwerror=true (gcc 13.3, x86) for the DPAA drivers.  Not
built for arm64.

v23 resolves the v22 items.  The 01/27 and 11/27 commit messages now
give the right reasons, 19/27 and 20/27 document that a malformed
value fails the probe, and 26/27 releases FQIDs in contiguous runs,
only after a successful shutdown.

No errors or warnings.

Info
----

Patch 25/27, 26/27: Each qman_create_fq() also takes an FQ lookup
  table entry (CONFIG_FSL_QMAN_FQ_LOOKUP_MAX, 32K, on 64-bit), and
  only qman_destroy_fq() returns it.  Nothing calls that, so every
  probe/close cycle leaks 2 entries for the oldev port and 4098 for
  dpaa_sec; the dpaa_sec part predates this series.  Suggested
  follow-up: mark the FQ out of service when qman_shutdown_fq()
  succeeds,

	fq->state = qman_fq_state_oos;

  and call qman_destroy_fq(fq, 0) after each successful shutdown.
  For the oldev FQs (QMAN_FQ_FLAG_DYNAMIC_FQID) that also replaces
  qman_release_fqid().

Pre-existing, not introduced here: in FMCLESS mode net/dpaa never
releases the Rx FQIDs it gets from qman_alloc_fqid_range(), on close
or on probe failure.

