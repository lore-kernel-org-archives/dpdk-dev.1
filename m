Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E43BC369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 17:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B1B440156;
	Sat, 26 Apr 2025 19:08:33 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id D241340156
 for <dev@dpdk.org>; Sat, 26 Apr 2025 19:08:31 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso3399427b3a.0
 for <dev@dpdk.org>; Sat, 26 Apr 2025 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745687311;
 x=1746292111; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDyTHWCCfkj3tZYFId9S8ymABd7PKfbmpDRuyKhbwTQ=;
 b=hBh3FoqoTCBzC8ANzg4GzHlEegDYQwQ9b1qHSKkgdgh9dYpbj9Z0JBDnptR61ozA7/
 GAaQxUXQYkxymkl5tPxo42u6GAJ2UYJEhj47FFJXNKCgqTJ10VJYICBcLcShkQtGDB2Y
 7aTLCHyp80dpPlqjwQ/EUoCXZu0h6YYmngi+h8eJOXV0tOkSFtzBBReNf/Ps4arn9MKA
 +DWFICIznzCyHT9JfC3s4lkYlQxMLNA1Yl9t8WHmAD9B0YqYoNUKw/aOOhIE0mmqu+a/
 G7Ck3PsywtFj008Qs150UAYa1tGcyih7qMSX4JXMaJGrqO4IaQVNOeb1v8n6Ndl387Ui
 7kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745687311; x=1746292111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDyTHWCCfkj3tZYFId9S8ymABd7PKfbmpDRuyKhbwTQ=;
 b=SUZVe9KvZj0OFlbxymcemt/rOFZtg878ckd80YslAE/eB0hIBTMRTky8v+wAWuALQg
 ufWOBd5rEFrv6GcWMCp7CUH5gUQwjgh8MduC3/nrdZx2RyWcb91bt4lNLnoiwQZPsnP3
 KCQp25YmPzGXp5CK2rw9URqOoCNObQA/ULB0KD6KgdTsvurY4wEwyxIsOOQAyu4/rLzV
 vFjTwvLm0TstXpTwa6UA3aTDUhuahCRJ/oe58Jz05aeWJ8XLK/w5Z59NKS//+voX+kxF
 ggkxxVL537GBfKzSc8VbDcDqygO1ui/KwFFZJF6iD2xxud6JWJZYGybmHvJa/aHN/m/Z
 R9+g==
X-Gm-Message-State: AOJu0Yx7JISIkgTx7cJiB21yCWMzrbmOzBvPuyXk6Fwbq4yCWL+CKwy0
 +1njtoBDtz7EoZqRgtbO3QCXlmCc/lFSkA5sfk12C+I7WwgIphfgQ7K9kBCqxCW6zUrTl1e/lBh
 R
X-Gm-Gg: ASbGncsmcThEWA6Y1cW3Q8zuw/YyGlTFGWUFAoO1iRpU+pEWdjf9M331eVoYou2qfN3
 2jjQgvoo0xWtpURNFqgiIfZszjCwIcooXVNp7+degaAzScuBRi1y2zV8Xg5+WunHh1LvJzpcasL
 7V/+FOLjWTK7A+tqEoXIIosB+HEGNsL9T7dThpHayVIPI1ie54IPRcUdmyeLC+Ku+1aNxt40qMS
 tRNyjnT8thBZTC7w+6sSD4gfWQhWg1XnObUkvJwq9hwygg0oUU+xVUIjj9I2e2VZOCKfyMu4V7C
 fRdzAziJPdSEntfwH6qPvnXqELNoN6mg0T0qf6gWQOil9SsNrSB3Ix5PWU7u1ZNOxHisUbVcZGn
 uVXFS7kj1/XchGsXi5vUiDdZ0AfU=
X-Google-Smtp-Source: AGHT+IHugFCSdhqJYAc+AhTKUSJx3yZcuSBHrYLryDozFHjTbVvR06/pt3zKxqlt6GR5uoc0kkdzZg==
X-Received: by 2002:a05:6a00:2e83:b0:732:5276:4ac9 with SMTP id
 d2e1a72fcca58-73ff729d9dcmr3983595b3a.9.1745687310765; 
 Sat, 26 Apr 2025 10:08:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a17csm5040819b3a.111.2025.04.26.10.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 10:08:30 -0700 (PDT)
Date: Sat, 26 Apr 2025 10:08:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 01/13] net/sxe: add base driver directory and doc
Message-ID: <20250426100829.444b4018@hermes.local>
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:40 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> From: JieLiu <liujie5@linkdatatechnology.com>
>=20
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
>=20
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

Cross build for windows fails:
DPDK 25.07.0-rc0

  User defined options
    Cross files: config/x86/cross-mingw
    examples   : helloworld

Found ninja-1.12.1 at /usr/bin/ninja
FAILED: drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_main.c.obj=20
x86_64-w64-mingw32-gcc -Idrivers/libtmp_rte_net_sxe.a.p -Idrivers -I../driv=
ers -Idrivers/net/sxe -I../drivers/net/sxe -I../drivers/net/sxe/base -I../d=
rivers/net/sxe/pf -I../drivers/net/sxe/vf -I../drivers/net/sxe/include/sxe =
-I../drivers/net/sxe/include -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common =
-I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../li=
b/eal/include -Ilib/eal/windows/include -I../lib/eal/windows/include -Ilib/=
eal/x86/include -I../lib/eal/x86/include -Ilib/eal -I../lib/eal -Ilib/log -=
I../lib/log -Ilib/kvargs -I../lib/kvargs -Ilib/net -I../lib/net -Ilib/mbuf =
-I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib=
/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/meter -I=
../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/wi=
ndows -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib=
/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -fdiagnostics-color=3Dalways -D_=
FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -include r=
te_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wf=
ormat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs=
 -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes =
-Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initiali=
zers -D_GNU_SOURCE -D_WIN32_WINNT=3D0x0A00 -D__USE_MINGW_ANSI_STDIO -march=
=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-t=
runcation -Wno-address-of-packed-member -DSXE_DPDK -DSXE_HOST_DRIVER -DSXE_=
DPDK_L4_FEATURES -DSXE_DPDK_SRIOV -DSXE_DPDK_SIMD -DRTE_LOG_DEFAULT_LOGTYPE=
=3Dpmd.net.sxe -MD -MQ drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_main.c=
.obj -MF drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_main.c.obj.d -o driv=
ers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_main.c.obj -c ../drivers/net/sxe/=
pf/sxe_main.c
In file included from ../drivers/net/sxe/base/sxe_hw.h:13,
                 from ../drivers/net/sxe/pf/sxe_main.c:30:
../drivers/net/sxe/base/sxe_compat_platform.h:32:9: warning: "min" redefined
   32 | #define min(a, b)       RTE_MIN(a, b)
      |         ^~~
In file included from /usr/share/mingw-w64/include/windef.h:9,
                 from /usr/share/mingw-w64/include/windows.h:69,
                 from ../lib/eal/windows/include/rte_windows.h:28,
                 from ../lib/eal/windows/include/pthread.h:17,
                 from ../lib/ethdev/ethdev_driver.h:17,
                 from ../drivers/net/sxe/pf/sxe_main.c:23:
/usr/share/mingw-w64/include/minwindef.h:177:9: note: this is the location =
of the previous definition
  177 | #define min(a, b) (((a) < (b)) ? (a) : (b))
      |         ^~~
In file included from ../drivers/net/sxe/base/sxe_hw.h:16:
../drivers/net/sxe/sxe_drv_type.h:21:14: error: conflicting types for =E2=
=80=98BOOL=E2=80=99; have =E2=80=98_Bool=E2=80=99
   21 | typedef bool BOOL;
      |              ^~~~
/usr/share/mingw-w64/include/minwindef.h:131:15: note: previous declaration=
 of =E2=80=98BOOL=E2=80=99 with type =E2=80=98BOOL=E2=80=99 {aka =E2=80=98i=
nt=E2=80=99}
  131 |   typedef int BOOL;
      |               ^~~~
In file included from ../drivers/net/sxe/pf/sxe.h:16,
                 from ../drivers/net/sxe/pf/sxe_ethdev.h:8,
                 from ../drivers/net/sxe/pf/sxe_main.c:31:
../drivers/net/sxe/pf/sxe_stats.h:52:47: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   52 |                                         const ulong *ids,
      |                                               ^~~~~
      |                                               u_long
../drivers/net/sxe/pf/sxe_stats.h:53:41: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   53 |                                         ulong *values, u32 usr_cnt);
      |                                         ^~~~~
      |                                         u_long
../drivers/net/sxe/pf/sxe_stats.h:62:15: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   62 |         const ulong *ids,
      |               ^~~~~
      |               u_long
FAILED: drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_filter.c.obj=20
x86_64-w64-mingw32-gcc -Idrivers/libtmp_rte_net_sxe.a.p -Idrivers -I../driv=
ers -Idrivers/net/sxe -I../drivers/net/sxe -I../drivers/net/sxe/base -I../d=
rivers/net/sxe/pf -I../drivers/net/sxe/vf -I../drivers/net/sxe/include/sxe =
-I../drivers/net/sxe/include -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common =
-I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../li=
b/eal/include -Ilib/eal/windows/include -I../lib/eal/windows/include -Ilib/=
eal/x86/include -I../lib/eal/x86/include -Ilib/eal -I../lib/eal -Ilib/log -=
I../lib/log -Ilib/kvargs -I../lib/kvargs -Ilib/net -I../lib/net -Ilib/mbuf =
-I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib=
/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/meter -I=
../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/wi=
ndows -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib=
/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -fdiagnostics-color=3Dalways -D_=
FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -include r=
te_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wf=
ormat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs=
 -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes =
-Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initiali=
zers -D_GNU_SOURCE -D_WIN32_WINNT=3D0x0A00 -D__USE_MINGW_ANSI_STDIO -march=
=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-t=
runcation -Wno-address-of-packed-member -DSXE_DPDK -DSXE_HOST_DRIVER -DSXE_=
DPDK_L4_FEATURES -DSXE_DPDK_SRIOV -DSXE_DPDK_SIMD -DRTE_LOG_DEFAULT_LOGTYPE=
=3Dpmd.net.sxe -MD -MQ drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_filter=
.c.obj -MF drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_filter.c.obj.d -o =
drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_filter.c.obj -c ../drivers/ne=
t/sxe/pf/sxe_filter.c
In file included from ../drivers/net/sxe/base/sxe_hw.h:13,
                 from ../drivers/net/sxe/pf/sxe_filter.h:17,
                 from ../drivers/net/sxe/pf/sxe_filter.c:19:
../drivers/net/sxe/base/sxe_compat_platform.h:32:9: warning: "min" redefined
   32 | #define min(a, b)       RTE_MIN(a, b)
      |         ^~~
In file included from /usr/share/mingw-w64/include/windef.h:9,
                 from /usr/share/mingw-w64/include/windows.h:69,
                 from ../lib/eal/windows/include/rte_windows.h:28,
                 from ../lib/eal/windows/include/pthread.h:17,
                 from ../lib/ethdev/ethdev_driver.h:17,
                 from ../drivers/net/sxe/pf/sxe_filter.c:12:
/usr/share/mingw-w64/include/minwindef.h:177:9: note: this is the location =
of the previous definition
  177 | #define min(a, b) (((a) < (b)) ? (a) : (b))
      |         ^~~
In file included from ../drivers/net/sxe/base/sxe_hw.h:16:
../drivers/net/sxe/sxe_drv_type.h:21:14: error: conflicting types for =E2=
=80=98BOOL=E2=80=99; have =E2=80=98_Bool=E2=80=99
   21 | typedef bool BOOL;
      |              ^~~~
/usr/share/mingw-w64/include/minwindef.h:131:15: note: previous declaration=
 of =E2=80=98BOOL=E2=80=99 with type =E2=80=98BOOL=E2=80=99 {aka =E2=80=98i=
nt=E2=80=99}
  131 |   typedef int BOOL;
      |               ^~~~
In file included from ../drivers/net/sxe/pf/sxe.h:16,
                 from ../drivers/net/sxe/pf/sxe_filter.c:21:
../drivers/net/sxe/pf/sxe_stats.h:52:47: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   52 |                                         const ulong *ids,
      |                                               ^~~~~
      |                                               u_long
../drivers/net/sxe/pf/sxe_stats.h:53:41: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   53 |                                         ulong *values, u32 usr_cnt);
      |                                         ^~~~~
      |                                         u_long
../drivers/net/sxe/pf/sxe_stats.h:62:15: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   62 |         const ulong *ids,
      |               ^~~~~
      |               u_long
FAILED: drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_flow_ctrl.c.obj=20
x86_64-w64-mingw32-gcc -Idrivers/libtmp_rte_net_sxe.a.p -Idrivers -I../driv=
ers -Idrivers/net/sxe -I../drivers/net/sxe -I../drivers/net/sxe/base -I../d=
rivers/net/sxe/pf -I../drivers/net/sxe/vf -I../drivers/net/sxe/include/sxe =
-I../drivers/net/sxe/include -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common =
-I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../li=
b/eal/include -Ilib/eal/windows/include -I../lib/eal/windows/include -Ilib/=
eal/x86/include -I../lib/eal/x86/include -Ilib/eal -I../lib/eal -Ilib/log -=
I../lib/log -Ilib/kvargs -I../lib/kvargs -Ilib/net -I../lib/net -Ilib/mbuf =
-I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib=
/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/meter -I=
../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/wi=
ndows -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib=
/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -fdiagnostics-color=3Dalways -D_=
FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -include r=
te_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wf=
ormat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs=
 -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes =
-Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initiali=
zers -D_GNU_SOURCE -D_WIN32_WINNT=3D0x0A00 -D__USE_MINGW_ANSI_STDIO -march=
=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-t=
runcation -Wno-address-of-packed-member -DSXE_DPDK -DSXE_HOST_DRIVER -DSXE_=
DPDK_L4_FEATURES -DSXE_DPDK_SRIOV -DSXE_DPDK_SIMD -DRTE_LOG_DEFAULT_LOGTYPE=
=3Dpmd.net.sxe -MD -MQ drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_flow_c=
trl.c.obj -MF drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_flow_ctrl.c.obj=
.d -o drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_flow_ctrl.c.obj -c ../d=
rivers/net/sxe/pf/sxe_flow_ctrl.c
In file included from ../drivers/net/sxe/base/sxe_hw.h:13,
                 from ../drivers/net/sxe/pf/sxe_filter.h:17,
                 from ../drivers/net/sxe/pf/sxe.h:14,
                 from ../drivers/net/sxe/pf/sxe_flow_ctrl.c:5:
../drivers/net/sxe/base/sxe_compat_platform.h:32:9: warning: "min" redefined
   32 | #define min(a, b)       RTE_MIN(a, b)
      |         ^~~
In file included from /usr/share/mingw-w64/include/windef.h:9,
                 from /usr/share/mingw-w64/include/windows.h:69,
                 from ../lib/eal/windows/include/rte_windows.h:28,
                 from ../lib/eal/windows/include/pthread.h:17,
                 from ../lib/ethdev/ethdev_driver.h:17,
                 from ../drivers/net/sxe/pf/sxe_filter.h:13:
/usr/share/mingw-w64/include/minwindef.h:177:9: note: this is the location =
of the previous definition
  177 | #define min(a, b) (((a) < (b)) ? (a) : (b))
      |         ^~~
In file included from ../drivers/net/sxe/base/sxe_hw.h:16:
../drivers/net/sxe/sxe_drv_type.h:21:14: error: conflicting types for =E2=
=80=98BOOL=E2=80=99; have =E2=80=98_Bool=E2=80=99
   21 | typedef bool BOOL;
      |              ^~~~
/usr/share/mingw-w64/include/minwindef.h:131:15: note: previous declaration=
 of =E2=80=98BOOL=E2=80=99 with type =E2=80=98BOOL=E2=80=99 {aka =E2=80=98i=
nt=E2=80=99}
  131 |   typedef int BOOL;
      |               ^~~~
In file included from ../drivers/net/sxe/pf/sxe.h:16:
../drivers/net/sxe/pf/sxe_stats.h:52:47: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   52 |                                         const ulong *ids,
      |                                               ^~~~~
      |                                               u_long
../drivers/net/sxe/pf/sxe_stats.h:53:41: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   53 |                                         ulong *values, u32 usr_cnt);
      |                                         ^~~~~
      |                                         u_long
../drivers/net/sxe/pf/sxe_stats.h:62:15: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   62 |         const ulong *ids,
      |               ^~~~~
      |               u_long
FAILED: drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_irq.c.obj=20
x86_64-w64-mingw32-gcc -Idrivers/libtmp_rte_net_sxe.a.p -Idrivers -I../driv=
ers -Idrivers/net/sxe -I../drivers/net/sxe -I../drivers/net/sxe/base -I../d=
rivers/net/sxe/pf -I../drivers/net/sxe/vf -I../drivers/net/sxe/include/sxe =
-I../drivers/net/sxe/include -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common =
-I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../li=
b/eal/include -Ilib/eal/windows/include -I../lib/eal/windows/include -Ilib/=
eal/x86/include -I../lib/eal/x86/include -Ilib/eal -I../lib/eal -Ilib/log -=
I../lib/log -Ilib/kvargs -I../lib/kvargs -Ilib/net -I../lib/net -Ilib/mbuf =
-I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib=
/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/meter -I=
../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/wi=
ndows -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib=
/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -fdiagnostics-color=3Dalways -D_=
FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -include r=
te_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wf=
ormat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs=
 -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes =
-Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initiali=
zers -D_GNU_SOURCE -D_WIN32_WINNT=3D0x0A00 -D__USE_MINGW_ANSI_STDIO -march=
=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-t=
runcation -Wno-address-of-packed-member -DSXE_DPDK -DSXE_HOST_DRIVER -DSXE_=
DPDK_L4_FEATURES -DSXE_DPDK_SRIOV -DSXE_DPDK_SIMD -DRTE_LOG_DEFAULT_LOGTYPE=
=3Dpmd.net.sxe -MD -MQ drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_irq.c.=
obj -MF drivers/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_irq.c.obj.d -o driver=
s/libtmp_rte_net_sxe.a.p/net_sxe_pf_sxe_irq.c.obj -c ../drivers/net/sxe/pf/=
sxe_irq.c
In file included from ../drivers/net/sxe/pf/sxe_irq.h:15,
                 from ../drivers/net/sxe/pf/sxe_irq.c:23:
../drivers/net/sxe/base/sxe_compat_platform.h:32:9: warning: "min" redefined
   32 | #define min(a, b)       RTE_MIN(a, b)
      |         ^~~
In file included from /usr/share/mingw-w64/include/windef.h:9,
                 from /usr/share/mingw-w64/include/windows.h:69,
                 from /usr/share/mingw-w64/include/winsock2.h:23,
                 from /usr/share/mingw-w64/include/ws2tcpip.h:17,
                 from ../lib/net/rte_ip4.h:21,
                 from ../lib/net/rte_ip.h:9,
                 from ../lib/ethdev/rte_flow.h:25,
                 from ../lib/ethdev/rte_eth_ctrl.h:11,
                 from ../lib/ethdev/rte_ethdev.h:1472,
                 from ../drivers/net/sxe/pf/sxe_irq.c:4:
/usr/share/mingw-w64/include/minwindef.h:177:9: note: this is the location =
of the previous definition
  177 | #define min(a, b) (((a) < (b)) ? (a) : (b))
      |         ^~~
In file included from ../drivers/net/sxe/base/sxe_hw.h:16,
                 from ../drivers/net/sxe/pf/sxe_irq.c:26:
../drivers/net/sxe/sxe_drv_type.h:21:14: error: conflicting types for =E2=
=80=98BOOL=E2=80=99; have =E2=80=98_Bool=E2=80=99
   21 | typedef bool BOOL;
      |              ^~~~
/usr/share/mingw-w64/include/minwindef.h:131:15: note: previous declaration=
 of =E2=80=98BOOL=E2=80=99 with type =E2=80=98BOOL=E2=80=99 {aka =E2=80=98i=
nt=E2=80=99}
  131 |   typedef int BOOL;
      |               ^~~~
In file included from ../drivers/net/sxe/pf/sxe.h:16,
                 from ../drivers/net/sxe/pf/sxe_irq.c:27:
../drivers/net/sxe/pf/sxe_stats.h:52:47: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   52 |                                         const ulong *ids,
      |                                               ^~~~~
      |                                               u_long
../drivers/net/sxe/pf/sxe_stats.h:53:41: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   53 |                                         ulong *values, u32 usr_cnt);
      |                                         ^~~~~
      |                                         u_long
../drivers/net/sxe/pf/sxe_stats.h:62:15: error: unknown type name =E2=80=98=
ulong=E2=80=99; did you mean =E2=80=98u_long=E2=80=99?
   62 |         const ulong *ids,
      |               ^~~~~
      |               u_long
ninja: build stopped: subcommand failed.
