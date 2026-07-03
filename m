Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D755DC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 14:27:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8D93402C5;
	Fri,  3 Jul 2026 16:27:26 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id D0E564026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 16:27:25 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso247476a91.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783088845;
 x=1783693645; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l6XmyDrWD2smaoSd3EGS1pJ1knZk54bVqi0DWL/l3GU=;
 b=yKPwVEIyyZA44XZK3qhq6nS5fEl5QGeDTu/AtLxEBRR96Y4y71eAI6CeiPMP20i1H6
 ucTW0ePf9/yS9bTYN1M570o8l13btkREC8TFtgjZAQbRBkK+v2kG0yB6XGYuyn7+sZtD
 vZvsU1v4uMHfhHDSUEvFWYTchB7i+GgEdSU/yNPFewTuEfBJjkTgwMomMW6rJoKxrEWN
 Ayh16mJSu2vGHKCHrLcz7doS4sPJQSrX5ZYJJtHm4kcmKWy/v4QB4f5JU8Zy8KMr8DKS
 QwRzxiQOnqSI0JIYn8Vo+wqjP028AB7D9f77s6JqDafXrRkowkw5VhP76Y8tIzplNcZm
 z6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783088845; x=1783693645;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l6XmyDrWD2smaoSd3EGS1pJ1knZk54bVqi0DWL/l3GU=;
 b=V5cPaPIsee4ZEa/+8/G6Zdb45xZgWoMaa8JUR2NIC4Fk7Jm1Ak3sZL31N8f74qEHX8
 ZfIOIBhpP4zJjE4+5u47UpXYbDmbF6okqtT7RDqW77ogVypUJvFcK88N9xoWaP1QNv2S
 ig8pMB4p+/e9BLVS5Wr0qVuTk0pRnCer+NZW8Gdpvrlo0d0Qe8wbto8ZWd3OEGkn4rOY
 3Dpmjn/liFNB3zJ5Dd4/bREH8umpMe/Qx51iTqN5JOoIJSUk2jlkuheL++LUHQCSbmeM
 JuPlrvri7mhgIBJEgmg94sieEiEG1oZrod9sMGczTL83UDmMydy/dadwQSoZQfmPEFK4
 yRXA==
X-Gm-Message-State: AOJu0YwWAQtmZBwP+BsqkIPIsgPd4yNWiK7VqCPob3OEWafRK9OUwTmJ
 FGuocBQszji2uHnlZ4m7zTQXeERBF1yF2iMmJI2zmxptbxO6hlUO3lH3k3jO+8zKCUo=
X-Gm-Gg: AfdE7cludpyqeG81/KN/xS9Dze0cH92tUAx9VkoT1ya4iNxAdjxd3GvHneqov0oFoWX
 jHmIjXuusmEk61aaZN+zQciQMIzqmrSgOu29pdYhmIEwynhytQqRaaN/QTDWfTxCF40iwfnvije
 3W436zNIuoLsksqHrMyYHYGlCthRHl6Vi4xaOPVwdne9IUp9gchAiN11ciVlcVyVH73LLAx2vpb
 6zvVGC1yGXYCImv9HKW0ehgz00c+lPH2bC15AYxsCPs7vWe1s2F6cjgj3z/GqvlmOJKK+hsvRN/
 apROrYt9abF4N2U7iti228x2GilDSJBJdF7diyvLjHG68DhaG1fMHkixM25pa+NbK12EiLltNmZ
 OcveA8vfYjAeEkCRewEaIzVY9J5ABJoDiTpP1CHe3G8xIcx0XUgox+C5H8wIqWUd/D9yf38OO1N
 SwdhQPsZHYG9F2PsyNvrIBEGXByyBgcro9dpeptODvqX6ImWq0iU1tSw==
X-Received: by 2002:a17:90b:3810:b0:37f:9ce1:cdaf with SMTP id
 98e67ed59e1d1-380aa1ed882mr11267976a91.29.1783088844519; 
 Fri, 03 Jul 2026 07:27:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd2362sm23028726eec.20.2026.07.03.07.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:27:24 -0700 (PDT)
Date: Fri, 3 Jul 2026 07:27:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/9] Stability fixes for GVE
Message-ID: <20260703072721.18c5987a@phoenix.local>
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
References: <20260703131308.2507403-1-joshwash@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri,  3 Jul 2026 06:12:57 -0700
Joshua Washington <joshwash@google.com> wrote:

> This patch series consists of mostly unrelated fixes in the GVE driver.
>=20
> Joshua Washington (9):
>   net/gve: clear out shared memory region for stats report
>   net/gve: delay adding mbuf head to software ring
>   net/gve: copy data to QPL buffer when mbuf read does not
>   net/gve: validate buf ID before processing Rx packet
>   net/gve: set mbuf to null in software ring after use
>   net/gve: free ctx mbuf if packet dropped after first segment
>   net/gve: increase range of DMA memzone ids to 64 bits
>   net/gve: don't reset ring size bounds to default on reset
>   net/gve: restrict max ring size in GQ QPL to 2K
>=20
>  drivers/net/gve/base/gve_adminq.c | 12 ++++++--
>  drivers/net/gve/base/gve_osdep.h  |  4 +--
>  drivers/net/gve/gve_ethdev.c      |  8 ++++--
>  drivers/net/gve/gve_ethdev.h      |  1 +
>  drivers/net/gve/gve_rx.c          |  3 ++
>  drivers/net/gve/gve_rx_dqo.c      |  6 ++++
>  drivers/net/gve/gve_tx.c          | 46 ++++++++++++++++++-------------
>  7 files changed, 53 insertions(+), 27 deletions(-)
>=20
> ---
> v2:
>   * Remove unused definition
>=20
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>=20

Better but fails on 32 bit build during post-merge testing
DPDK 26.07.0-rc2

  User defined options
    Cross files           : /home/shemminger/DPDK/next-net/devtools/../conf=
ig/x86/cross-32bit-debian.ini
    buildtype             : debugoptimized
    default_library       : shared
    enable_deprecated_libs: *
    examples              : all
    werror                : true

Found ninja-1.13.2 at /usr/bin/ninja
ninja: Entering directory `./build-32b'
[937/2812] Compiling C object drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx=
.c.o
FAILED: [code=3D1] drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o=20
cc -Idrivers/libtmp_rte_net_gve.a.p -Idrivers -I../drivers -Idrivers/net/gv=
e -I../drivers/net/gve -I../drivers/net/gve/base -Ilib/ethdev -I../lib/ethd=
ev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib=
/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linu=
x/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux =
-Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log =
-Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/arg=
parse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Il=
ib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/m=
eter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ili=
b/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -fdiagnostics-c=
olor=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror =
-std=3Dc11 -O2 -g -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wfo=
rmat -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing=
-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wshado=
w -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-no=
t-aligned -Wno-missing-field-initializers -fzero-init-padding-bits=3Dall -W=
no-pointer-to-int-cast -D_GNU_SOURCE -m32 -fPIC -march=3Dnative -mrtm -DALL=
OW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-addres=
s-of-packed-member -Wno-vla -DRTE_COMPONENT_CLASS=3Dpmd_net -DRTE_COMPONENT=
_NAME=3Dgve -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.gve -MD -MQ drivers/libtmp_=
rte_net_gve.a.p/net_gve_gve_tx.c.o -MF drivers/libtmp_rte_net_gve.a.p/net_g=
ve_gve_tx.c.o.d -o drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o -c ../=
drivers/net/gve/gve_tx.c
../drivers/net/gve/gve_tx.c: In function =E2=80=98gve_tx_burst_qpl=E2=80=99:
../drivers/net/gve/gve_tx.c:338:42: error: cast to pointer from integer of =
different size [-Werror=3Dint-to-pointer-cast]
  338 |                         qpl_write_addr =3D (void *)(txq->fifo_base =
+ fifo_addr);
      |                                          ^
cc1: all warnings being treated as errors
