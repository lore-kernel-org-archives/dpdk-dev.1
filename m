Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137ACC282C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 15:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C09B402DD;
	Fri, 28 Feb 2025 16:47:18 +0100 (CET)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49]) by mails.dpdk.org (Postfix) with ESMTP id F15C8402CA
 for <dev@dpdk.org>; Fri, 28 Feb 2025 16:47:15 +0100 (CET)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-866de72bb82so978773241.1
 for <dev@dpdk.org>; Fri, 28 Feb 2025 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740757635; x=1741362435; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K/OvJ+Hu3TCXkpTyxy+bnUS5ZJ0/1IYrShA+JF8geIA=;
 b=bTwsg8Cot/9TLSRmXYLK93rw+sU2DbMtsdwp/UFoibsdp8gI+YDInbCkMqGsji3I0v
 XZjrxKJcGdc8QDVpUUkawq6fKjhHDweSe9NpBt9TxUW2Cgktik7Y0jTuHPbW8uQ5X5vJ
 ZJf3ai6vOOimcoXTLSSvDt8rmvFi1k2wUhYTe/2AAfGymUU908itFDMT5IxVOR3yhPhu
 Jnx2LiDpRXDVoMB1+NApqRnSCH4/iupNXUr16hRut1BxK0CnNZzsxsDcoY3I4eiFKQVd
 HT0HINE84+twdsVTqbzdwBsR5hD2nCotqO3crUc7kCrFhW7ZIsG+BWfa8FAku7S0buI3
 ez4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740757635; x=1741362435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/OvJ+Hu3TCXkpTyxy+bnUS5ZJ0/1IYrShA+JF8geIA=;
 b=ikpt3+JlOms87gEUERCXOBpZOVRPJkJ9y3uNf1S8mD7C/k0MSZ5ldDTMLM8XRL/aOx
 1zgBNThbJm6MLk4leyT2vPIzCRe8zSNphdZ1FeaM3HaxCHr2GBY7SCD6VlnEpH9UlTb6
 eXVOAs6Yj8cQ06XY+lM8G11cyA83YKBk5r5AeVeKj/Inzi92F6p4SJXsN7E4VTLDoRD4
 /4v8TaGQ2zepBbXTh1pYgE3o9gRTfZsqHkA6vX/lbya/r03YelaTxgFQgzOy9A1ReTPb
 0cnl3fyxmSIWwoS36Lj2R1jd2aeiBIJzOV4rA4JkNMV+e6sJBQ1RE4iUUiKBsYmnIJ91
 c6SA==
X-Gm-Message-State: AOJu0YyduARzEIWE+SdFwwU+Om5YmK3oYrdqI24peTcquXfsmHwoHEym
 +GDazH5Dm0FgHrQKkNJlF2bYhW2W9dtFgMoSFJpkCbUdb3RU/w9gJy24hYJ5UPYVtSkpubp/GCp
 upT/qR1ap0TLVDfH3biR9zf0qqw8=
X-Gm-Gg: ASbGncuRlCmuJmsSs8JiAlvCmlQ+TWkiHMcZxx6R7dNMLEmy6q0BVKxHFnvL9OR0lPn
 GRg14/ucsYf4ZMTtktEVJe4Jq5byNSD7tkUoslLr/AYa586/twbW004Gq7Y8aPSHhgUzR/nmFHb
 uBq+eEreVu
X-Google-Smtp-Source: AGHT+IEfg/eTKF/+rwN8+AO8h7I/KTGLCRVNqv8U9H2wRens5S+YBE81qtf70S4S78ODSMrHvJSqUe6p/UKA5CC6bg4=
X-Received: by 2002:a05:6102:6cb:b0:4b6:18b3:a4db with SMTP id
 ada2fe7eead31-4c044b01888mr3224088137.8.1740757634979; Fri, 28 Feb 2025
 07:47:14 -0800 (PST)
MIME-Version: 1.0
References: <CAKx8PBic6QVBP2ntcke_mxxjjPmAtGmMY4YtSN0gZ5wmjcfTRg@mail.gmail.com>
 <3484257.VLH7GnMWUR@thomas>
In-Reply-To: <3484257.VLH7GnMWUR@thomas>
From: Ben Magistro <koncept1@gmail.com>
Date: Fri, 28 Feb 2025 10:47:03 -0500
X-Gm-Features: AQ5f1JoN0UsrqUoBLy-Y1t8zAU1cjlMMwCnEOAJ30i9qkC0VNddOpqkVOSiykbU
Message-ID: <CAKx8PBhFzZ-5C6RSH5UJDrORmNkoaWmms2rTQsy1vo7TAr0cEw@mail.gmail.com>
Subject: Re: Link custom libarchive meson support
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Content-Type: multipart/alternative; boundary="0000000000007924e2062f35b835"
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

--0000000000007924e2062f35b835
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delay in getting back to this and appreciate the assistance.
I do not have this in simple setup right now to reproduce but imagine
cloning libarchive into say /tmp and setting the appropriate prefixes would
get you to a minimum needed to reproduce.  I've substituted out the
company and application names but those should not be a factor here as the
paths are good.

The .pc file is correct but the include paths are not being included in the
DPDK make commands

We patch the .pc file from libarchive so that we don't need to track some
cmake variables before/after processing libarchive.  The final file looks
like this.  The link_libs variable was added by us as the link libraries
need to be passed to dpdk as well.  We build libarchive as a statically
linked library and only produce a .a file which is present at the path
listed here.
```
prefix=3D/opt/companyname/debug-trace
exec_prefix=3D${prefix}
libdir=3D/home/bmagistro/bitbucket/application/build/lib
includedir=3D/home/bmagistro/bitbucket/application/build/_deps/libarchive-s=
rc/libarchive
link_libs=3D" -lz -lbz2 -llzma -llzo2 -llz4 -lnettle -lcrypto -lxml2 -lxml2
-lz -llzma -lm"

Name: libarchive
Description: library that can create and read several streaming archive
formats
Version: 3.7.2
Cflags: -I${includedir}
Cflags.private: -DLIBARCHIVE_STATIC
Libs: -L${libdir} -larchive
Libs.private:  -lz -lbz2 -llzma -llzo2 -llz4 -lnettle -lcrypto -lxml2
-lxml2 -lz -llzma -lm
Requires.private:
```

In cmake, we make the following call for dpdk to do its build as an
external project (fetchcontent) command.
```
meson --prefix=3D"${DPDK_BUILD_FOLDER}" "${DPDK_MESON_REBUILD}"
-Dibverbs_link=3D"none" -Ddisable_libs=3D"${DPDK_DISABLED_LIBS_CSV}"
-Ddisable_drivers=3D"${DPDK_DISABLED_DRIVERS_CSV}" -Dtests=3Dfalse
-Dcpu_instruction_set=3D"${PROCESSOR_ARCHITECTURE}"
-Dpkg_config_path=3D"${PROJECT_SOURCE_DIR}/build/_deps/libarchive-build/bui=
ld/pkgconfig/"
build && cd build && ninja install
```

That expands to
```
Execute
meson;--prefix=3D"/home/bmagistro/bitbucket/application/build/_deps/dpdk-sr=
c/build";;-Dibverbs_link=3D"none";-Ddisable_libs=3D"bitratestats,cfgfile,fl=
ow_classify,gpudev,jobstats,kni,latencystats,metrics,node,pipeline,port,pow=
er,table,vhost";-Ddisable_drivers=3D"common/cnxk,common/cpt,common/dpaax,co=
mmon/mvep,common/mlx5,common/octeontx,common/octeontx2,common/sfc_efx,commo=
n/qat,bus/auxiliary,bus/dpaa,bus/fslmc,bus/ifpga,bus/vmbus,mempool/bucket,m=
empool/cnxk,mempool/dpaa,mempool/dpaa2,mempool/octeontx,mempool/octeontx2,m=
empool/stack,dma/cnxk,dma/dpaa,dma/dpaa2,dma/hisilicon,dma/idxd,dma/ioat,dm=
a/skeleton,net/af_xdp,net/ark,net/atlantic,net/avp,net/axgbe,net/bonding,ne=
t/bnx2x,net/bnxt,net/cnxk,net/cxgbe,net/dpaa,net/dpaa2,net/e1000,net/ena,ne=
t/enetc,net/enetfec,net/enic,net/failsafe,net/fm10k,net/gve,net/hinic,net/h=
ns3,net/idpf,net/igc,net/ionic,net/ipn3ke,net/ixgbe,net/kni,net/liquidio,ne=
t/mana,net/memif,net/mlx4,net/mlx5,net/mvneta,net/mvpp2,net/netvsc,net/ngbe=
,net/nfb,net/nfp,net/null,net/octeon_ep,net/octeontx,net/octeontx2,net/octe=
ontx_ep,net/pfe,net/qede,net/ring,net/sfc,net/softnic,net/szedata2,net/tap,=
net/thunderx,net/txgbe,net/vdev_netvsc,net/vhost,raw/cnxk_bphy,raw/cnxk_gpi=
o,raw/dpaa2_cmdif,raw/dpaa2_qdma,raw/ifpga,raw/ioat,raw/ntb,raw/octeontx2_d=
ma,raw/octeontx2_ep,raw/skeleton,crypto/aesni_gcm,crypto/aesni_mb,crypto/ar=
mv8,crypto/bcmfs,crypto/caam_jr,crypto/ccp,crypto/cnxk,crypto/dpaa_sec,cryp=
to/dpaa2_sec,crypto/ipsec_mb,crypto/kasumi,crypto/mlx5,crypto/mvsam,crypto/=
nitrox,crypto/null,crypto/octeontx,crypto/octeontx2,crypto/openssl,crypto/q=
at,crypto/scheduler,crypto/snow3g,crypto/uadk,crypto/virtio,crypto/zuc,comp=
ress/octeontx,compress/isal,compress/mlx5,compress/zlib,compress/qat,regex/=
cn9k,regex/mlx5,regex/octeontx2,vdpa/ifc,vdpa/mlx5,vdpa/sfc,event/cnxk,even=
t/dlb2,event/dpaa,event/dpaa2,event/dsw,event/octeontx,event/octeontx2,even=
t/opdl,event/skeleton,event/sw,baseband/acc,baseband/acc100,baseband/fpga_5=
gnr_fec,baseband/fpga_lte_fec,baseband/la12xx,baseband/null,baseband/turbo_=
sw,gpu/cuda";-Dtests=3Dfalse;-Dcpu_instruction_set=3D"skylake";-Dpkg_config=
_path=3D"/home/bmagistro/bitbucket/application/build/_deps/libarchive-build=
/build/pkgconfig/";build;&&;cd;build;&&;ninja;install
```

And when it tries to build dpdk we get the following (i've trimmed the
output a bit to keep it readable):
```
make -j12 dpdk
Scanning dependencies of target archive_static
...
[100%] Linking C static library ../../../lib/libarchive.a
[100%] Built target archive_static
Scanning dependencies of target libarchive
[100%] Built target libarchive
Scanning dependencies of target dpdk
[100%] Building dpdk in
/home/bmagistro/bitbucket/application/build/_deps/dpdk-src...
Execute
meson;--prefix=3D"/home/bmagistro/bitbucket/application/build/_deps/dpdk-sr=
c/build";;-Dibverbs_link=3D"none";-Ddisable_libs=3D"bitratestats,cfgfile,fl=
ow_classify,gpudev,jobstats,kni,latencystats,metrics,node,pipeline,port,pow=
er,table,vhost";-Ddisable_drivers=3D"common/cnxk,common/cpt,common/dpaax,co=
mmon/mvep,common/mlx5,common/octeontx,common/octeontx2,common/sfc_efx,commo=
n/qat,bus/auxiliary,bus/dpaa,bus/fslmc,bus/ifpga,bus/vmbus,mempool/bucket,m=
empool/cnxk,mempool/dpaa,mempool/dpaa2,mempool/octeontx,mempool/octeontx2,m=
empool/stack,dma/cnxk,dma/dpaa,dma/dpaa2,dma/hisilicon,dma/idxd,dma/ioat,dm=
a/skeleton,net/af_xdp,net/ark,net/atlantic,net/avp,net/axgbe,net/bonding,ne=
t/bnx2x,net/bnxt,net/cnxk,net/cxgbe,net/dpaa,net/dpaa2,net/e1000,net/ena,ne=
t/enetc,net/enetfec,net/enic,net/failsafe,net/fm10k,net/gve,net/hinic,net/h=
ns3,net/idpf,net/igc,net/ionic,net/ipn3ke,net/ixgbe,net/kni,net/liquidio,ne=
t/mana,net/memif,net/mlx4,net/mlx5,net/mvneta,net/mvpp2,net/netvsc,net/ngbe=
,net/nfb,net/nfp,net/null,net/octeon_ep,net/octeontx,net/octeontx2,net/octe=
ontx_ep,net/pfe,net/qede,net/ring,net/sfc,net/softnic,net/szedata2,net/tap,=
net/thunderx,net/txgbe,net/vdev_netvsc,net/vhost,raw/cnxk_bphy,raw/cnxk_gpi=
o,raw/dpaa2_cmdif,raw/dpaa2_qdma,raw/ifpga,raw/ioat,raw/ntb,raw/octeontx2_d=
ma,raw/octeontx2_ep,raw/skeleton,crypto/aesni_gcm,crypto/aesni_mb,crypto/ar=
mv8,crypto/bcmfs,crypto/caam_jr,crypto/ccp,crypto/cnxk,crypto/dpaa_sec,cryp=
to/dpaa2_sec,crypto/ipsec_mb,crypto/kasumi,crypto/mlx5,crypto/mvsam,crypto/=
nitrox,crypto/null,crypto/octeontx,crypto/octeontx2,crypto/openssl,crypto/q=
at,crypto/scheduler,crypto/snow3g,crypto/uadk,crypto/virtio,crypto/zuc,comp=
ress/octeontx,compress/isal,compress/mlx5,compress/zlib,compress/qat,regex/=
cn9k,regex/mlx5,regex/octeontx2,vdpa/ifc,vdpa/mlx5,vdpa/sfc,event/cnxk,even=
t/dlb2,event/dpaa,event/dpaa2,event/dsw,event/octeontx,event/octeontx2,even=
t/opdl,event/skeleton,event/sw,baseband/acc,baseband/acc100,baseband/fpga_5=
gnr_fec,baseband/fpga_lte_fec,baseband/la12xx,baseband/null,baseband/turbo_=
sw,gpu/cuda";-Dtests=3Dfalse;-Dcpu_instruction_set=3D"skylake";-Dpkg_config=
_path=3D"/home/bmagistro/bitbucket/application/build/_deps/libarchive-build=
/build/pkgconfig/";build;&&;cd;build;&&;ninja;install
The Meson build system
Version: 0.63.3
Source dir: /home/bmagistro/bitbucket/application/build/_deps/dpdk-src
Build dir: /home/bmagistro/bitbucket/application/build/_deps/dpdk-src/build
Build type: native build
Program cat found: YES (/usr/bin/cat)
Project name: DPDK
Project version: 23.03.0-rc0
C compiler for the host machine: ccache cc (gcc 11.4.1 "cc (GCC) 11.4.1
20231218 (Red Hat 11.4.1-3)")
C linker for the host machine: cc ld.bfd 2.35.2-43
Host machine cpu family: x86_64
Host machine cpu: x86_64
...
Found pkg-config: /usr/bin/pkg-config (1.7.3)
Run-time dependency libarchive found: YES 3.7.2
...
Build targets in project: 308

DPDK 23.03.0-rc0

  User defined options
    pkg_config_path    :
/home/bmagistro/bitbucket/application/build/_deps/libarchive-build/build/pk=
gconfig/
    prefix             :
/home/bmagistro/bitbucket/application/build/_deps/dpdk-src/build
    cpu_instruction_set: skylake
    disable_drivers    :
common/cnxk,common/cpt,common/dpaax,common/mvep,common/mlx5,common/octeontx=
,common/octeontx2,common/sfc_efx,common/qat,bus/auxiliary,bus/dpaa,bus/fslm=
c,bus/ifpga,bus/vmbus,mempool/bucket,mempool/cnxk,mempool/dpaa,mempool/dpaa=
2,mempool/octeontx,mempool/octeontx2,mempool/stack,dma/cnxk,dma/dpaa,dma/dp=
aa2,dma/hisilicon,dma/idxd,dma/ioat,dma/skeleton,net/af_xdp,net/ark,net/atl=
antic,net/avp,net/axgbe,net/bonding,net/bnx2x,net/bnxt,net/cnxk,net/cxgbe,n=
et/dpaa,net/dpaa2,net/e1000,net/ena,net/enetc,net/enetfec,net/enic,net/fail=
safe,net/fm10k,net/gve,net/hinic,net/hns3,net/idpf,net/igc,net/ionic,net/ip=
n3ke,net/ixgbe,net/kni,net/liquidio,net/mana,net/memif,net/mlx4,net/mlx5,ne=
t/mvneta,net/mvpp2,net/netvsc,net/ngbe,net/nfb,net/nfp,net/null,net/octeon_=
ep,net/octeontx,net/octeontx2,net/octeontx_ep,net/pfe,net/qede,net/ring,net=
/sfc,net/softnic,net/szedata2,net/tap,net/thunderx,net/txgbe,net/vdev_netvs=
c,net/vhost,raw/cnxk_bphy,raw/cnxk_gpio,raw/dpaa2_cmdif,raw/dpaa2_qdma,raw/=
ifpga,raw/ioat,raw/ntb,raw/octeontx2_dma,raw/octeontx2_ep,raw/skeleton,cryp=
to/aesni_gcm,crypto/aesni_mb,crypto/armv8,crypto/bcmfs,crypto/caam_jr,crypt=
o/ccp,crypto/cnxk,crypto/dpaa_sec,crypto/dpaa2_sec,crypto/ipsec_mb,crypto/k=
asumi,crypto/mlx5,crypto/mvsam,crypto/nitrox,crypto/null,crypto/octeontx,cr=
ypto/octeontx2,crypto/openssl,crypto/qat,crypto/scheduler,crypto/snow3g,cry=
pto/uadk,crypto/virtio,crypto/zuc,compress/octeontx,compress/isal,compress/=
mlx5,compress/zlib,compress/qat,regex/cn9k,regex/mlx5,regex/octeontx2,vdpa/=
ifc,vdpa/mlx5,vdpa/sfc,event/cnxk,event/dlb2,event/dpaa,event/dpaa2,event/d=
sw,event/octeontx,event/octeontx2,event/opdl,event/skeleton,event/sw,baseba=
nd/acc,baseband/acc100,baseband/fpga_5gnr_fec,baseband/fpga_lte_fec,baseban=
d/la12xx,baseband/null,baseband/turbo_sw,gpu/cuda
    disable_libs       :
bitratestats,cfgfile,flow_classify,gpudev,jobstats,kni,latencystats,metrics=
,node,pipeline,port,power,table,vhost
    ibverbs_link       : none
    tests              : false

Found ninja-1.10.2 at /usr/bin/ninja
[85/746] Compiling C object lib/librte_eal.a.p/eal_unix_eal_firmware.c.o
FAILED: lib/librte_eal.a.p/eal_unix_eal_firmware.c.o
ccache cc -Ilib/librte_eal.a.p -Ilib -I../lib -I. -I.. -Iconfig -I../config
-Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include
-I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include
-Ilib/eal/common -I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/kvargs
-I../lib/kvargs -I../lib/metrics -Ilib/telemetry -I../lib/telemetry
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch
-Wextra -O3 -include rte_config.h -Wcast-qual -Wdeprecated -Wformat
-Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition
-Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-address-of-packed-member -Wno-packed-not-aligned
-Wno-missing-field-initializers -Wno-zero-length-bounds -D_GNU_SOURCE -fPIC
-march=3Dskylake -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API
-Wno-format-truncation '-DABI_VERSION=3D"23.1"' -DRTE_LIBEAL_USE_GETENTROPY
-DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.eal -MD -MQ
lib/librte_eal.a.p/eal_unix_eal_firmware.c.o -MF
lib/librte_eal.a.p/eal_unix_eal_firmware.c.o.d -o
lib/librte_eal.a.p/eal_unix_eal_firmware.c.o -c
../lib/eal/unix/eal_firmware.c
../lib/eal/unix/eal_firmware.c:6:10: fatal error: archive.h: No such file
or directory
    6 | #include <archive.h>
      |          ^~~~~~~~~~~
compilation terminated.
[106/746] Generating lib/telemetry.sym_chk with a custom command (wrapped
by meson to capture output)
ninja: build stopped: subcommand failed.
make[3]: *** [external/dpdk/CMakeFiles/dpdk.dir/build.make:82:
_deps/dpdk-src/build/lib/libdpdk.a] Error 1
make[2]: *** [CMakeFiles/Makefile2:4580:
external/dpdk/CMakeFiles/dpdk.dir/all] Error 2
make[1]: *** [CMakeFiles/Makefile2:4587:
external/dpdk/CMakeFiles/dpdk.dir/rule] Error 2
make: *** [Makefile:1168: dpdk] Error 2
```

Linking errors
```
[16/89] Linking target app/dpdk-dumpcap
FAILED: app/dpdk-dumpcap
cc  -o app/dpdk-dumpcap app/dpdk-dumpcap.p/dumpcap_main.c.o -Wl,--as-needed
-Wl,--no-undefined -Wl,-O1 -Wl,--whole-archive -Wl,--start-group
lib/librte_graph.a lib/librte_pdump.a lib/librte_fib.a lib/librte_ipsec.a
lib/librte_stack.a lib/librte_security.a lib/librte_sched.a
lib/librte_reorder.a lib/librte_rib.a lib/librte_dmadev.a
lib/librte_regexdev.a lib/librte_rawdev.a lib/librte_pcapng.a
lib/librte_member.a lib/librte_lpm.a lib/librte_ip_frag.a lib/librte_gso.a
lib/librte_gro.a lib/librte_eventdev.a lib/librte_efd.a
lib/librte_distributor.a lib/librte_cryptodev.a lib/librte_compressdev.a
lib/librte_bpf.a lib/librte_bbdev.a lib/librte_acl.a lib/librte_timer.a
lib/librte_hash.a lib/librte_cmdline.a lib/librte_pci.a lib/librte_ethdev.a
lib/librte_meter.a lib/librte_net.a lib/librte_mbuf.a lib/librte_mempool.a
lib/librte_rcu.a lib/librte_ring.a lib/librte_eal.a lib/librte_telemetry.a
lib/librte_kvargs.a drivers/librte_common_iavf.a
drivers/librte_common_idpf.a drivers/librte_bus_pci.a
drivers/librte_bus_vdev.a drivers/librte_mempool_ring.a
drivers/librte_net_af_packet.a drivers/librte_net_i40e.a
drivers/librte_net_iavf.a drivers/librte_net_ice.a
drivers/librte_net_pcap.a drivers/librte_net_virtio.a
drivers/librte_net_vmxnet3.a -Wl,--no-whole-archive -Wl,--no-as-needed
-pthread -lm -ldl -lnuma
-Wl,-rpath,XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-Wl,--export-dynamic /usr/lib64/libpcap.so -Wl,--end-group
/usr/bin/ld: lib/librte_eal.a(eal_unix_eal_firmware.c.o): in function
`firmware_read':
eal_firmware.c:(.text+0x22): undefined reference to `archive_read_new'
/usr/bin/ld: eal_firmware.c:(.text+0x36): undefined reference to
`archive_read_support_format_raw'
/usr/bin/ld: eal_firmware.c:(.text+0x46): undefined reference to
`archive_read_support_filter_xz'
/usr/bin/ld: eal_firmware.c:(.text+0x5e): undefined reference to
`archive_read_open_filename'
/usr/bin/ld: eal_firmware.c:(.text+0x73): undefined reference to
`archive_read_next_header'
/usr/bin/ld: eal_firmware.c:(.text+0xb5): undefined reference to
`archive_read_data'
/usr/bin/ld: eal_firmware.c:(.text+0xe2): undefined reference to
`archive_read_free'
/usr/bin/ld: eal_firmware.c:(.text+0xf8): undefined reference to
`archive_read_free'
collect2: error: ld returned 1 exit status



[11/89] Linking target app/dpdk-pdump
FAILED: app/dpdk-pdump
cc  -o app/dpdk-pdump app/dpdk-pdump.p/pdump_main.c.o
-L/home/bmagistro/bitbucket/application/build/lib -Wl,--as-needed
-Wl,--no-undefined -Wl,-O1 -Wl,--whole-archive -Wl,--start-group
lib/librte_graph.a lib/librte_pdump.a lib/librte_fib.a lib/librte_ipsec.a
lib/librte_stack.a lib/librte_security.a lib/librte_sched.a
lib/librte_reorder.a lib/librte_rib.a lib/librte_dmadev.a
lib/librte_regexdev.a lib/librte_rawdev.a lib/librte_pcapng.a
lib/librte_member.a lib/librte_lpm.a lib/librte_ip_frag.a lib/librte_gso.a
lib/librte_gro.a lib/librte_eventdev.a lib/librte_efd.a
lib/librte_distributor.a lib/librte_cryptodev.a lib/librte_compressdev.a
lib/librte_bpf.a lib/librte_bbdev.a lib/librte_acl.a lib/librte_timer.a
lib/librte_hash.a lib/librte_cmdline.a lib/librte_pci.a lib/librte_ethdev.a
lib/librte_meter.a lib/librte_net.a lib/librte_mbuf.a lib/librte_mempool.a
lib/librte_rcu.a lib/librte_ring.a lib/librte_eal.a lib/librte_telemetry.a
lib/librte_kvargs.a drivers/librte_common_iavf.a
drivers/librte_common_idpf.a drivers/librte_bus_pci.a
drivers/librte_bus_vdev.a drivers/librte_mempool_ring.a
drivers/librte_net_af_packet.a drivers/librte_net_i40e.a
drivers/librte_net_iavf.a drivers/librte_net_ice.a
drivers/librte_net_pcap.a drivers/librte_net_virtio.a
drivers/librte_net_vmxnet3.a -Wl,--no-whole-archive -Wl,--no-as-needed
-pthread -lm -ldl -lnuma -larchive
-Wl,-rpath,XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-Wl,--export-dynamic /usr/lib64/libpcap.so -Wl,--end-group
/usr/bin/ld:
/home/bmagistro/bitbucket/application/build/lib/libarchive.a(archive_read_s=
upport_filter_xz.c.o):
in function `xz_lzma_bidder_init':
/home/bmagistro/bitbucket/application/build/_deps/libarchive-src/libarchive=
/archive_read_support_filter_xz.c:515:
undefined reference to `lzma_stream_decoder'
/usr/bin/ld:
/home/bmagistro/bitbucket/application/build/_deps/libarchive-src/libarchive=
/archive_read_support_filter_xz.c:519:
undefined reference to `lzma_alone_decoder'
/usr/bin/ld:
/home/bmagistro/bitbucket/application/build/lib/libarchive.a(archive_read_s=
upport_filter_xz.c.o):
in function `lzip_init':
/home/bmagistro/bitbucket/application/build/_deps/libarchive-src/libarchive=
/archive_read_support_filter_xz.c:576:
undefined reference to `lzma_properties_decode'
/usr/bin/ld:
/home/bmagistro/bitbucket/application/build/_deps/libarchive-src/libarchive=
/archive_read_support_filter_xz.c:581:
undefined reference to `lzma_raw_decoder'
/usr/bin/ld:
/home/bmagistro/bitbucket/application/build/lib/libarchive.a(archive_read_s=
upport_filter_xz.c.o):
in function `xz_filter_read':
/home/bmagistro/bitbucket/application/build/_deps/libarchive-src/libarchive=
/archive_read_support_filter_xz.c:689:
undefined reference to `lzma_code'
/usr/bin/ld:
/home/bmagistro/bitbucket/application/build/_deps/libarchive-src/libarchive=
/archive_read_support_filter_xz.c:715:
undefined reference to `lzma_crc32'
/usr/bin/ld:
/home/bmagistro/bitbucket/application/build/lib/libarchive.a(archive_read_s=
upport_filter_xz.c.o):
in function `xz_filter_close':
/home/bmagistro/bitbucket/application/build/_deps/libarchive-src/libarchive=
/archive_read_support_filter_xz.c:736:
undefined reference to `lzma_end'
collect2: error: ld returned 1 exit status
```

In looking at the errors, the include and libe paths from the .pc file are
not included in the command being run the so the include fails.  When the
include path is resolved by adding the include dirs (we do this by patching
config/meson.build and adding them in if libarchive is found, same for
libs) we then get a linking error starting with a cannot find archive.
This occurs because the link libraries path from the .pc file are not being
added.  When that is resolved we get to the final link error that comes
from the additional libraries libarchive is linked against not being passed
to dpdk.  In pulling this together the link errors may be limited to the
apps in dpdk.  Several were listed but picked one I know we build/want for
troubleshooting purposes.  I hope this helps clarify things and am happy to
try/provide additional info.

On Wed, Feb 19, 2025 at 12:42=E2=80=AFPM Thomas Monjalon <thomas@monjalon.n=
et>
wrote:

> 11/02/2025 19:46, Ben Magistro:
> > Will acknowledge this may be more of a meson question and less of a DPD=
K
> > issue but things didn't seem to work as expected and had to tweak the
> > config/meson.build to want to start with the DPDK team.
> >
> > Our project is cmake based and we use fetch content to pull in our
> external
> > dependencies (eg dpdk, libarchive, etc).  We recently noticed
> > (rediscovered) that DPDK was not linking libarchive which causes the OS
> > provided DDP for the Intel ICE based cards to be unable to be
> > decompressed.  Previously we had some additional items installed that
> > provided an uncompressed DDP file.  As our project already builds
> > libarchive we did not want to install it at the os level for inclusion
> into
> > DPDK as we may now be mixing versions within our application.
> >
> > In our cmake we added -Dpkg_config_path to help meson find our libarchi=
ve
> > build (it is not installed as it is statically linked into our app).
> This
> > worked but did not expose the include and link directories or any libs
> that
> > may also need to be linked from the pc file.
>
> I don't understand this part.
> It should be sufficient.
> Are you saying your .pc file is not correct because not installed?
>
> > We had to make some changes
> > to get those added and allow things to compile cleanly.  I can confirm
> the
> > changes here work but feel they should not have been necessary.
> >
> > What is the correct way to link/use a custom libarchive (or any
> dependency
> > for that matter) with DPDK?  I've attached the diff for the meson chang=
es
> > plus the generated pc file for libarchive that we are telling meson to
> find
> > with the pkg_config_path parameter.
>
> The correct way is to give the path to the .pc file.
> Please give more info about what is failing.
>
>
>

--0000000000007924e2062f35b835
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry for the delay in getting=C2=A0back to this and appre=
ciate the=C2=A0assistance.=C2=A0 I do not have this in simple setup right n=
ow to reproduce but imagine cloning libarchive into say /tmp and setting th=
e appropriate prefixes would get you to a minimum needed to reproduce.=C2=
=A0 I&#39;ve substituted out the company=C2=A0and application names but tho=
se should not be a factor here as the paths are good.<div><br></div><div>Th=
e .pc file is correct but the include paths are not being included in the D=
PDK make commands</div><div><br></div><div>We patch the .pc file from libar=
chive so that we don&#39;t need to track some cmake variables before/after =
processing libarchive.=C2=A0 The final file looks like this.=C2=A0 The link=
_libs variable was added by us as the link libraries need to be passed to d=
pdk as well.=C2=A0 We build libarchive as a statically linked library and o=
nly produce a .a file which is present at the path listed here.</div><div>`=
``</div><div>prefix=3D/opt/companyname/debug-trace<br>exec_prefix=3D${prefi=
x}<br>libdir=3D/home/bmagistro/bitbucket/application/build/lib<br>includedi=
r=3D/home/bmagistro/bitbucket/application/build/_deps/libarchive-src/libarc=
hive<br>link_libs=3D&quot; -lz -lbz2 -llzma -llzo2 -llz4 -lnettle -lcrypto =
-lxml2 -lxml2 -lz -llzma -lm&quot;<br><br>Name: libarchive<br>Description: =
library that can create and read several streaming archive formats<br>Versi=
on: 3.7.2<br>Cflags: -I${includedir}<br>Cflags.private: -DLIBARCHIVE_STATIC=
<br>Libs: -L${libdir} -larchive<br>Libs.private: =C2=A0-lz -lbz2 -llzma -ll=
zo2 -llz4 -lnettle -lcrypto -lxml2 -lxml2 -lz -llzma -lm<br>Requires.privat=
e:=C2=A0</div><div>```</div><div><br></div><div>In cmake, we make the follo=
wing call for dpdk to do its build as an external project (fetchcontent) co=
mmand.</div><div>```</div><div>meson --prefix=3D&quot;${DPDK_BUILD_FOLDER}&=
quot; &quot;${DPDK_MESON_REBUILD}&quot; -Dibverbs_link=3D&quot;none&quot; -=
Ddisable_libs=3D&quot;${DPDK_DISABLED_LIBS_CSV}&quot; -Ddisable_drivers=3D&=
quot;${DPDK_DISABLED_DRIVERS_CSV}&quot; -Dtests=3Dfalse -Dcpu_instruction_s=
et=3D&quot;${PROCESSOR_ARCHITECTURE}&quot; -Dpkg_config_path=3D&quot;${PROJ=
ECT_SOURCE_DIR}/build/_deps/libarchive-build/build/pkgconfig/&quot; build &=
amp;&amp; cd build &amp;&amp; ninja install</div><div>```</div><div><br></d=
iv><div>That expands to</div><div>```</div><div>Execute meson;--prefix=3D&q=
uot;/home/bmagistro/bitbucket/application/build/_deps/dpdk-src/build&quot;;=
;-Dibverbs_link=3D&quot;none&quot;;-Ddisable_libs=3D&quot;bitratestats,cfgf=
ile,flow_classify,gpudev,jobstats,kni,latencystats,metrics,node,pipeline,po=
rt,power,table,vhost&quot;;-Ddisable_drivers=3D&quot;common/cnxk,common/cpt=
,common/dpaax,common/mvep,common/mlx5,common/octeontx,common/octeontx2,comm=
on/sfc_efx,common/qat,bus/auxiliary,bus/dpaa,bus/fslmc,bus/ifpga,bus/vmbus,=
mempool/bucket,mempool/cnxk,mempool/dpaa,mempool/dpaa2,mempool/octeontx,mem=
pool/octeontx2,mempool/stack,dma/cnxk,dma/dpaa,dma/dpaa2,dma/hisilicon,dma/=
idxd,dma/ioat,dma/skeleton,net/af_xdp,net/ark,net/atlantic,net/avp,net/axgb=
e,net/bonding,net/bnx2x,net/bnxt,net/cnxk,net/cxgbe,net/dpaa,net/dpaa2,net/=
e1000,net/ena,net/enetc,net/enetfec,net/enic,net/failsafe,net/fm10k,net/gve=
,net/hinic,net/hns3,net/idpf,net/igc,net/ionic,net/ipn3ke,net/ixgbe,net/kni=
,net/liquidio,net/mana,net/memif,net/mlx4,net/mlx5,net/mvneta,net/mvpp2,net=
/netvsc,net/ngbe,net/nfb,net/nfp,net/null,net/octeon_ep,net/octeontx,net/oc=
teontx2,net/octeontx_ep,net/pfe,net/qede,net/ring,net/sfc,net/softnic,net/s=
zedata2,net/tap,net/thunderx,net/txgbe,net/vdev_netvsc,net/vhost,raw/cnxk_b=
phy,raw/cnxk_gpio,raw/dpaa2_cmdif,raw/dpaa2_qdma,raw/ifpga,raw/ioat,raw/ntb=
,raw/octeontx2_dma,raw/octeontx2_ep,raw/skeleton,crypto/aesni_gcm,crypto/ae=
sni_mb,crypto/armv8,crypto/bcmfs,crypto/caam_jr,crypto/ccp,crypto/cnxk,cryp=
to/dpaa_sec,crypto/dpaa2_sec,crypto/ipsec_mb,crypto/kasumi,crypto/mlx5,cryp=
to/mvsam,crypto/nitrox,crypto/null,crypto/octeontx,crypto/octeontx2,crypto/=
openssl,crypto/qat,crypto/scheduler,crypto/snow3g,crypto/uadk,crypto/virtio=
,crypto/zuc,compress/octeontx,compress/isal,compress/mlx5,compress/zlib,com=
press/qat,regex/cn9k,regex/mlx5,regex/octeontx2,vdpa/ifc,vdpa/mlx5,vdpa/sfc=
,event/cnxk,event/dlb2,event/dpaa,event/dpaa2,event/dsw,event/octeontx,even=
t/octeontx2,event/opdl,event/skeleton,event/sw,baseband/acc,baseband/acc100=
,baseband/fpga_5gnr_fec,baseband/fpga_lte_fec,baseband/la12xx,baseband/null=
,baseband/turbo_sw,gpu/cuda&quot;;-Dtests=3Dfalse;-Dcpu_instruction_set=3D&=
quot;skylake&quot;;-Dpkg_config_path=3D&quot;/home/bmagistro/bitbucket/appl=
ication/build/_deps/libarchive-build/build/pkgconfig/&quot;;build;&amp;&amp=
;;cd;build;&amp;&amp;;ninja;install</div><div>```</div><div><br></div><div>=
And when it tries to build dpdk we get the following (i&#39;ve trimmed the =
output a bit to keep it readable):</div><div>```</div><div>make -j12 dpdk<b=
r>Scanning dependencies of target archive_static<br>...<br>[100%] Linking C=
 static library ../../../lib/libarchive.a<br>[100%] Built target archive_st=
atic<br>Scanning dependencies of target libarchive<br>[100%] Built target l=
ibarchive<br>Scanning dependencies of target dpdk<br>[100%] Building dpdk i=
n /home/bmagistro/bitbucket/application/build/_deps/dpdk-src...<br>Execute =
meson;--prefix=3D&quot;/home/bmagistro/bitbucket/application/build/_deps/dp=
dk-src/build&quot;;;-Dibverbs_link=3D&quot;none&quot;;-Ddisable_libs=3D&quo=
t;bitratestats,cfgfile,flow_classify,gpudev,jobstats,kni,latencystats,metri=
cs,node,pipeline,port,power,table,vhost&quot;;-Ddisable_drivers=3D&quot;com=
mon/cnxk,common/cpt,common/dpaax,common/mvep,common/mlx5,common/octeontx,co=
mmon/octeontx2,common/sfc_efx,common/qat,bus/auxiliary,bus/dpaa,bus/fslmc,b=
us/ifpga,bus/vmbus,mempool/bucket,mempool/cnxk,mempool/dpaa,mempool/dpaa2,m=
empool/octeontx,mempool/octeontx2,mempool/stack,dma/cnxk,dma/dpaa,dma/dpaa2=
,dma/hisilicon,dma/idxd,dma/ioat,dma/skeleton,net/af_xdp,net/ark,net/atlant=
ic,net/avp,net/axgbe,net/bonding,net/bnx2x,net/bnxt,net/cnxk,net/cxgbe,net/=
dpaa,net/dpaa2,net/e1000,net/ena,net/enetc,net/enetfec,net/enic,net/failsaf=
e,net/fm10k,net/gve,net/hinic,net/hns3,net/idpf,net/igc,net/ionic,net/ipn3k=
e,net/ixgbe,net/kni,net/liquidio,net/mana,net/memif,net/mlx4,net/mlx5,net/m=
vneta,net/mvpp2,net/netvsc,net/ngbe,net/nfb,net/nfp,net/null,net/octeon_ep,=
net/octeontx,net/octeontx2,net/octeontx_ep,net/pfe,net/qede,net/ring,net/sf=
c,net/softnic,net/szedata2,net/tap,net/thunderx,net/txgbe,net/vdev_netvsc,n=
et/vhost,raw/cnxk_bphy,raw/cnxk_gpio,raw/dpaa2_cmdif,raw/dpaa2_qdma,raw/ifp=
ga,raw/ioat,raw/ntb,raw/octeontx2_dma,raw/octeontx2_ep,raw/skeleton,crypto/=
aesni_gcm,crypto/aesni_mb,crypto/armv8,crypto/bcmfs,crypto/caam_jr,crypto/c=
cp,crypto/cnxk,crypto/dpaa_sec,crypto/dpaa2_sec,crypto/ipsec_mb,crypto/kasu=
mi,crypto/mlx5,crypto/mvsam,crypto/nitrox,crypto/null,crypto/octeontx,crypt=
o/octeontx2,crypto/openssl,crypto/qat,crypto/scheduler,crypto/snow3g,crypto=
/uadk,crypto/virtio,crypto/zuc,compress/octeontx,compress/isal,compress/mlx=
5,compress/zlib,compress/qat,regex/cn9k,regex/mlx5,regex/octeontx2,vdpa/ifc=
,vdpa/mlx5,vdpa/sfc,event/cnxk,event/dlb2,event/dpaa,event/dpaa2,event/dsw,=
event/octeontx,event/octeontx2,event/opdl,event/skeleton,event/sw,baseband/=
acc,baseband/acc100,baseband/fpga_5gnr_fec,baseband/fpga_lte_fec,baseband/l=
a12xx,baseband/null,baseband/turbo_sw,gpu/cuda&quot;;-Dtests=3Dfalse;-Dcpu_=
instruction_set=3D&quot;skylake&quot;;-Dpkg_config_path=3D&quot;/home/bmagi=
stro/bitbucket/application/build/_deps/libarchive-build/build/pkgconfig/&qu=
ot;;build;&amp;&amp;;cd;build;&amp;&amp;;ninja;install<br>The Meson build s=
ystem<br>Version: 0.63.3<br>Source dir: /home/bmagistro/bitbucket/applicati=
on/build/_deps/dpdk-src<br>Build dir: /home/bmagistro/bitbucket/application=
/build/_deps/dpdk-src/build<br>Build type: native build<br>Program cat foun=
d: YES (/usr/bin/cat)<br>Project name: DPDK<br>Project version: 23.03.0-rc0=
<br>C compiler for the host machine: ccache cc (gcc 11.4.1 &quot;cc (GCC) 1=
1.4.1 20231218 (Red Hat 11.4.1-3)&quot;)<br>C linker for the host machine: =
cc ld.bfd 2.35.2-43<br>Host machine cpu family: x86_64<br>Host machine cpu:=
 x86_64<br>...<br>Found pkg-config: /usr/bin/pkg-config (1.7.3)<br>Run-time=
 dependency libarchive found: YES 3.7.2<br>...<br>Build targets in project:=
 308<br><br>DPDK 23.03.0-rc0<br><br>=C2=A0 User defined options<br>=C2=A0 =
=C2=A0 pkg_config_path =C2=A0 =C2=A0: /home/bmagistro/bitbucket/application=
/build/_deps/libarchive-build/build/pkgconfig/<br>=C2=A0 =C2=A0 prefix =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : /home/bmagistro/bitbucket/applicat=
ion/build/_deps/dpdk-src/build<br>=C2=A0 =C2=A0 cpu_instruction_set: skylak=
e<br>=C2=A0 =C2=A0 disable_drivers =C2=A0 =C2=A0: common/cnxk,common/cpt,co=
mmon/dpaax,common/mvep,common/mlx5,common/octeontx,common/octeontx2,common/=
sfc_efx,common/qat,bus/auxiliary,bus/dpaa,bus/fslmc,bus/ifpga,bus/vmbus,mem=
pool/bucket,mempool/cnxk,mempool/dpaa,mempool/dpaa2,mempool/octeontx,mempoo=
l/octeontx2,mempool/stack,dma/cnxk,dma/dpaa,dma/dpaa2,dma/hisilicon,dma/idx=
d,dma/ioat,dma/skeleton,net/af_xdp,net/ark,net/atlantic,net/avp,net/axgbe,n=
et/bonding,net/bnx2x,net/bnxt,net/cnxk,net/cxgbe,net/dpaa,net/dpaa2,net/e10=
00,net/ena,net/enetc,net/enetfec,net/enic,net/failsafe,net/fm10k,net/gve,ne=
t/hinic,net/hns3,net/idpf,net/igc,net/ionic,net/ipn3ke,net/ixgbe,net/kni,ne=
t/liquidio,net/mana,net/memif,net/mlx4,net/mlx5,net/mvneta,net/mvpp2,net/ne=
tvsc,net/ngbe,net/nfb,net/nfp,net/null,net/octeon_ep,net/octeontx,net/octeo=
ntx2,net/octeontx_ep,net/pfe,net/qede,net/ring,net/sfc,net/softnic,net/szed=
ata2,net/tap,net/thunderx,net/txgbe,net/vdev_netvsc,net/vhost,raw/cnxk_bphy=
,raw/cnxk_gpio,raw/dpaa2_cmdif,raw/dpaa2_qdma,raw/ifpga,raw/ioat,raw/ntb,ra=
w/octeontx2_dma,raw/octeontx2_ep,raw/skeleton,crypto/aesni_gcm,crypto/aesni=
_mb,crypto/armv8,crypto/bcmfs,crypto/caam_jr,crypto/ccp,crypto/cnxk,crypto/=
dpaa_sec,crypto/dpaa2_sec,crypto/ipsec_mb,crypto/kasumi,crypto/mlx5,crypto/=
mvsam,crypto/nitrox,crypto/null,crypto/octeontx,crypto/octeontx2,crypto/ope=
nssl,crypto/qat,crypto/scheduler,crypto/snow3g,crypto/uadk,crypto/virtio,cr=
ypto/zuc,compress/octeontx,compress/isal,compress/mlx5,compress/zlib,compre=
ss/qat,regex/cn9k,regex/mlx5,regex/octeontx2,vdpa/ifc,vdpa/mlx5,vdpa/sfc,ev=
ent/cnxk,event/dlb2,event/dpaa,event/dpaa2,event/dsw,event/octeontx,event/o=
cteontx2,event/opdl,event/skeleton,event/sw,baseband/acc,baseband/acc100,ba=
seband/fpga_5gnr_fec,baseband/fpga_lte_fec,baseband/la12xx,baseband/null,ba=
seband/turbo_sw,gpu/cuda<br>=C2=A0 =C2=A0 disable_libs =C2=A0 =C2=A0 =C2=A0=
 : bitratestats,cfgfile,flow_classify,gpudev,jobstats,kni,latencystats,metr=
ics,node,pipeline,port,power,table,vhost<br>=C2=A0 =C2=A0 ibverbs_link =C2=
=A0 =C2=A0 =C2=A0 : none<br>=C2=A0 =C2=A0 tests =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0: false<br><br>Found ninja-1.10.2 at /usr/bin/ninja<br=
>[85/746] Compiling C object lib/librte_eal.a.p/eal_unix_eal_firmware.c.o<b=
r>FAILED: lib/librte_eal.a.p/eal_unix_eal_firmware.c.o <br>ccache cc -Ilib/=
librte_eal.a.p -Ilib -I../lib -I. -I.. -Iconfig -I../config -Ilib/eal/inclu=
de -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include =
-Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal/common -I../lib/ea=
l/common -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -I../lib/metri=
cs -Ilib/telemetry -I../lib/telemetry -fdiagnostics-color=3Dalways -D_FILE_=
OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -O3 -include rte_config.h -Wca=
st-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissi=
ng-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definitio=
n -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-string=
s -Wno-address-of-packed-member -Wno-packed-not-aligned -Wno-missing-field-=
initializers -Wno-zero-length-bounds -D_GNU_SOURCE -fPIC -march=3Dskylake -=
DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation &#39;-D=
ABI_VERSION=3D&quot;23.1&quot;&#39; -DRTE_LIBEAL_USE_GETENTROPY -DRTE_LOG_D=
EFAULT_LOGTYPE=3Dlib.eal -MD -MQ lib/librte_eal.a.p/eal_unix_eal_firmware.c=
.o -MF lib/librte_eal.a.p/eal_unix_eal_firmware.c.o.d -o lib/librte_eal.a.p=
/eal_unix_eal_firmware.c.o -c ../lib/eal/unix/eal_firmware.c<br>../lib/eal/=
unix/eal_firmware.c:6:10: fatal error: archive.h: No such file or directory=
<br>=C2=A0 =C2=A0 6 | #include &lt;archive.h&gt;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~<br>compilation terminated.<br=
>[106/746] Generating lib/telemetry.sym_chk with a custom command (wrapped =
by meson to capture output)<br>ninja: build stopped: subcommand failed.<br>=
make[3]: *** [external/dpdk/CMakeFiles/dpdk.dir/build.make:82: _deps/dpdk-s=
rc/build/lib/libdpdk.a] Error 1<br>make[2]: *** [CMakeFiles/Makefile2:4580:=
 external/dpdk/CMakeFiles/dpdk.dir/all] Error 2<br>make[1]: *** [CMakeFiles=
/Makefile2:4587: external/dpdk/CMakeFiles/dpdk.dir/rule] Error 2<br>make: *=
** [Makefile:1168: dpdk] Error 2</div><div>```</div><div><br></div><div>Lin=
king errors</div><div>```</div><div>[16/89] Linking target app/dpdk-dumpcap=
<br>FAILED: app/dpdk-dumpcap<br>cc =C2=A0-o app/dpdk-dumpcap app/dpdk-dumpc=
ap.p/dumpcap_main.c.o -Wl,--as-needed -Wl,--no-undefined -Wl,-O1 -Wl,--whol=
e-archive -Wl,--start-group lib/librte_graph.a lib/librte_pdump.a lib/librt=
e_fib.a lib/librte_ipsec.a lib/librte_stack.a lib/librte_security.a lib/lib=
rte_sched.a lib/librte_reorder.a lib/librte_rib.a lib/librte_dmadev.a lib/l=
ibrte_regexdev.a lib/librte_rawdev.a lib/librte_pcapng.a lib/librte_member.=
a lib/librte_lpm.a lib/librte_ip_frag.a lib/librte_gso.a lib/librte_gro.a l=
ib/librte_eventdev.a lib/librte_efd.a lib/librte_distributor.a lib/librte_c=
ryptodev.a lib/librte_compressdev.a lib/librte_bpf.a lib/librte_bbdev.a lib=
/librte_acl.a lib/librte_timer.a lib/librte_hash.a lib/librte_cmdline.a lib=
/librte_pci.a lib/librte_ethdev.a lib/librte_meter.a lib/librte_net.a lib/l=
ibrte_mbuf.a lib/librte_mempool.a lib/librte_rcu.a lib/librte_ring.a lib/li=
brte_eal.a lib/librte_telemetry.a lib/librte_kvargs.a drivers/librte_common=
_iavf.a drivers/librte_common_idpf.a drivers/librte_bus_pci.a drivers/librt=
e_bus_vdev.a drivers/librte_mempool_ring.a drivers/librte_net_af_packet.a d=
rivers/librte_net_i40e.a drivers/librte_net_iavf.a drivers/librte_net_ice.a=
 drivers/librte_net_pcap.a drivers/librte_net_virtio.a drivers/librte_net_v=
mxnet3.a -Wl,--no-whole-archive -Wl,--no-as-needed -pthread -lm -ldl -lnuma=
 -Wl,-rpath,XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -Wl,--export-dynamic /usr/lib6=
4/libpcap.so -Wl,--end-group<br>/usr/bin/ld: lib/librte_eal.a(eal_unix_eal_=
firmware.c.o): in function `firmware_read&#39;:<br>eal_firmware.c:(.text+0x=
22): undefined reference to `archive_read_new&#39;<br>/usr/bin/ld: eal_firm=
ware.c:(.text+0x36): undefined reference to `archive_read_support_format_ra=
w&#39;<br>/usr/bin/ld: eal_firmware.c:(.text+0x46): undefined reference to =
`archive_read_support_filter_xz&#39;<br>/usr/bin/ld: eal_firmware.c:(.text+=
0x5e): undefined reference to `archive_read_open_filename&#39;<br>/usr/bin/=
ld: eal_firmware.c:(.text+0x73): undefined reference to `archive_read_next_=
header&#39;<br>/usr/bin/ld: eal_firmware.c:(.text+0xb5): undefined referenc=
e to `archive_read_data&#39;<br>/usr/bin/ld: eal_firmware.c:(.text+0xe2): u=
ndefined reference to `archive_read_free&#39;<br>/usr/bin/ld: eal_firmware.=
c:(.text+0xf8): undefined reference to `archive_read_free&#39;<br>collect2:=
 error: ld returned 1 exit status<br><br><br><br>[11/89] Linking target app=
/dpdk-pdump<br>FAILED: app/dpdk-pdump<br>cc =C2=A0-o app/dpdk-pdump app/dpd=
k-pdump.p/pdump_main.c.o -L/home/bmagistro/bitbucket/application/build/lib =
-Wl,--as-needed -Wl,--no-undefined -Wl,-O1 -Wl,--whole-archive -Wl,--start-=
group lib/librte_graph.a lib/librte_pdump.a lib/librte_fib.a lib/librte_ips=
ec.a lib/librte_stack.a lib/librte_security.a lib/librte_sched.a lib/librte=
_reorder.a lib/librte_rib.a lib/librte_dmadev.a lib/librte_regexdev.a lib/l=
ibrte_rawdev.a lib/librte_pcapng.a lib/librte_member.a lib/librte_lpm.a lib=
/librte_ip_frag.a lib/librte_gso.a lib/librte_gro.a lib/librte_eventdev.a l=
ib/librte_efd.a lib/librte_distributor.a lib/librte_cryptodev.a lib/librte_=
compressdev.a lib/librte_bpf.a lib/librte_bbdev.a lib/librte_acl.a lib/libr=
te_timer.a lib/librte_hash.a lib/librte_cmdline.a lib/librte_pci.a lib/libr=
te_ethdev.a lib/librte_meter.a lib/librte_net.a lib/librte_mbuf.a lib/librt=
e_mempool.a lib/librte_rcu.a lib/librte_ring.a lib/librte_eal.a lib/librte_=
telemetry.a lib/librte_kvargs.a drivers/librte_common_iavf.a drivers/librte=
_common_idpf.a drivers/librte_bus_pci.a drivers/librte_bus_vdev.a drivers/l=
ibrte_mempool_ring.a drivers/librte_net_af_packet.a drivers/librte_net_i40e=
.a drivers/librte_net_iavf.a drivers/librte_net_ice.a drivers/librte_net_pc=
ap.a drivers/librte_net_virtio.a drivers/librte_net_vmxnet3.a -Wl,--no-whol=
e-archive -Wl,--no-as-needed -pthread -lm -ldl -lnuma -larchive -Wl,-rpath,=
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -Wl,--export-dynamic /usr/lib64/libpcap.so=
 -Wl,--end-group<br>/usr/bin/ld: /home/bmagistro/bitbucket/application/buil=
d/lib/libarchive.a(archive_read_support_filter_xz.c.o): in function `xz_lzm=
a_bidder_init&#39;:<br>/home/bmagistro/bitbucket/application/build/_deps/li=
barchive-src/libarchive/archive_read_support_filter_xz.c:515: undefined ref=
erence to `lzma_stream_decoder&#39;<br>/usr/bin/ld: /home/bmagistro/bitbuck=
et/application/build/_deps/libarchive-src/libarchive/archive_read_support_f=
ilter_xz.c:519: undefined reference to `lzma_alone_decoder&#39;<br>/usr/bin=
/ld: /home/bmagistro/bitbucket/application/build/lib/libarchive.a(archive_r=
ead_support_filter_xz.c.o): in function `lzip_init&#39;:<br>/home/bmagistro=
/bitbucket/application/build/_deps/libarchive-src/libarchive/archive_read_s=
upport_filter_xz.c:576: undefined reference to `lzma_properties_decode&#39;=
<br>/usr/bin/ld: /home/bmagistro/bitbucket/application/build/_deps/libarchi=
ve-src/libarchive/archive_read_support_filter_xz.c:581: undefined reference=
 to `lzma_raw_decoder&#39;<br>/usr/bin/ld: /home/bmagistro/bitbucket/applic=
ation/build/lib/libarchive.a(archive_read_support_filter_xz.c.o): in functi=
on `xz_filter_read&#39;:<br>/home/bmagistro/bitbucket/application/build/_de=
ps/libarchive-src/libarchive/archive_read_support_filter_xz.c:689: undefine=
d reference to `lzma_code&#39;<br>/usr/bin/ld: /home/bmagistro/bitbucket/ap=
plication/build/_deps/libarchive-src/libarchive/archive_read_support_filter=
_xz.c:715: undefined reference to `lzma_crc32&#39;<br>/usr/bin/ld: /home/bm=
agistro/bitbucket/application/build/lib/libarchive.a(archive_read_support_f=
ilter_xz.c.o): in function `xz_filter_close&#39;:<br>/home/bmagistro/bitbuc=
ket/application/build/_deps/libarchive-src/libarchive/archive_read_support_=
filter_xz.c:736: undefined reference to `lzma_end&#39;<br>collect2: error: =
ld returned 1 exit status<br></div><div>```</div><div><br></div><div>In loo=
king at the=C2=A0errors, the include and libe paths from the .pc file are n=
ot included in the command being=C2=A0run the=C2=A0so the include fails.=C2=
=A0 When the include path is resolved by adding the include dirs (we do thi=
s by patching config/meson.build and adding them in if libarchive is found,=
 same for libs) we then get a linking error starting with a cannot find arc=
hive.=C2=A0 This occurs because the link libraries path from the .pc file a=
re not being added.=C2=A0 When that is resolved we get to the final link er=
ror that=C2=A0comes from the additional libraries libarchive is linked agai=
nst not being passed to dpdk.=C2=A0 In pulling this together the link error=
s may be limited to the apps in dpdk.=C2=A0 Several were listed but picked =
one I know we build/want for troubleshooting purposes.=C2=A0 I hope this he=
lps clarify things and am happy to try/provide additional=C2=A0info.</div><=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Feb 19, 2025 at 12:42=E2=80=AFPM Thomas Monjal=
on &lt;<a href=3D"mailto:thomas@monjalon.net">thomas@monjalon.net</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">11/02/2025=
 19:46, Ben Magistro:<br>
&gt; Will acknowledge this may be more of a meson question and less of a DP=
DK<br>
&gt; issue but things didn&#39;t seem to work as expected and had to tweak =
the<br>
&gt; config/meson.build to want to start with the DPDK team.<br>
&gt; <br>
&gt; Our project is cmake based and we use fetch content to pull in our ext=
ernal<br>
&gt; dependencies (eg dpdk, libarchive, etc).=C2=A0 We recently noticed<br>
&gt; (rediscovered) that DPDK was not linking libarchive which causes the O=
S<br>
&gt; provided DDP for the Intel ICE based cards to be unable to be<br>
&gt; decompressed.=C2=A0 Previously we had some additional items installed =
that<br>
&gt; provided an uncompressed DDP file.=C2=A0 As our project already builds=
<br>
&gt; libarchive we did not want to install it at the os level for inclusion=
 into<br>
&gt; DPDK as we may now be mixing versions within our application.<br>
&gt; <br>
&gt; In our cmake we added -Dpkg_config_path to help meson find our libarch=
ive<br>
&gt; build (it is not installed as it is statically linked into our app).=
=C2=A0 This<br>
&gt; worked but did not expose the include and link directories or any libs=
 that<br>
&gt; may also need to be linked from the pc file.<br>
<br>
I don&#39;t understand this part.<br>
It should be sufficient.<br>
Are you saying your .pc file is not correct because not installed?<br>
<br>
&gt; We had to make some changes<br>
&gt; to get those added and allow things to compile cleanly.=C2=A0 I can co=
nfirm the<br>
&gt; changes here work but feel they should not have been necessary.<br>
&gt; <br>
&gt; What is the correct way to link/use a custom libarchive (or any depend=
ency<br>
&gt; for that matter) with DPDK?=C2=A0 I&#39;ve attached the diff for the m=
eson changes<br>
&gt; plus the generated pc file for libarchive that we are telling meson to=
 find<br>
&gt; with the pkg_config_path parameter.<br>
<br>
The correct way is to give the path to the .pc file.<br>
Please give more info about what is failing.<br>
<br>
<br>
</blockquote></div>

--0000000000007924e2062f35b835--
