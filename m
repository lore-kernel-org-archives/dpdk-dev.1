Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503CEC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:46:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7004F40279;
	Mon, 10 Mar 2025 16:46:22 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id E325740270
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:46:20 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-224100e9a5cso81909675ad.2
 for <dev@dpdk.org>; Mon, 10 Mar 2025 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741621580;
 x=1742226380; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAYS5wwX6FGACBkV43WjAPj/Sfh6FomBVLURwhpxVqc=;
 b=miJWR230N9sb7S0UbWXJHjaHL0H3jtAyT+eo43uwFuDaJaGh54zifbnkgNH933WyuT
 09yVk6uD2vGWXxuLDzY6wWeTlZIOX8ndBZtVydCpEnJj/tByrcHV3WCX6mPIIXK3s869
 QroTPOuJTPk6PRU0dsWWZwGVIoywWEPPlA5BfgK65YAflQmDj/SNB7JAiRKxL/XJOWDS
 pRu0GWmXuYaDM6WIcXEXCP6Yt2tCgMfV926XuhiVzNRDEGYorG1Ze+PXM2GYTi09lgoD
 KiqVfQs/9tSGyhVhP4dqiCaCX1QRuV3eKO8UfwwBqgFYLe7v6uGbplI2OixloID4gF+F
 wGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741621580; x=1742226380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PAYS5wwX6FGACBkV43WjAPj/Sfh6FomBVLURwhpxVqc=;
 b=xECKxGnCZr12ZYzMZdoLAB6spdKv1CXPvjZFg3xrcgpZqtfko/6JDJ6BdH1ix5Fknd
 b9BOR46EJ7gcZaAu4vGXwuEBnKMKHF+kSwjLWS1I1CYKy65pz6QNqH6OcZGcODqUQjjr
 huXVUdJD81CdEY8A7gmvpxziN9o0v0cWMAHRsS29zOwvk27RII2/jmizUMYzk8cHJ5lp
 DyFhA9zMhKa4YzPhj/b/jC9vt1af6jujsIRJ0qizKPUA1cE59JlFDqMlzRwd+BfHtBPA
 ciCVuVZjaqSMHpvPx6dPG0XJ6x31pG6soE/otSpHkutfEdDwW9/9t+CoxMXyo8JU8wvh
 cMKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGQDvp5J2AZ9p4TJ4TQlckEJWUxrH2wuRvahrHBUWmLnvuS3JnY477RhLAYEcQ888VFhQ=@dpdk.org
X-Gm-Message-State: AOJu0YwhNfhogepDesCPWW1ZHliTTWESDC2lamv7KrimuG1+FkzMfTsn
 SLSEJ8TClp8fdaogbqqbvD6ZclXWmLjQ64xUS3j5dFWNtF3pRWjMisxeqe9fdVw=
X-Gm-Gg: ASbGnct3U/aRdaYOqH5Vy2beE+gK7uT+S7cdy5+NeM4r85K4uLpC+wgb9C0nc8ZOrLb
 67NVK3whQux8L53zlBIAxeIWP4EBffAVr7xotgSwIr59Sr0PVwFSwJlamyuMktrcPf6hF2ZSQ5h
 pit2nJ0rBygcJ+OciO1C8W9y8pThLLiO49QrNaiI2+Ql4THn8xw4zu2BB1xTqlMFSonX8ZXMx1a
 mlSU27hYFC0Mt+u5Zmz3nK9jJkIh2fLSIEPwPFX2JMjndFbYiAuahg5mijpCkTdDNRIB/PJ80qs
 4ukGgNHd5OW+9zx2fl3BLwpuuWcqT5AQsxD74EGY9bvb5f01VR2e/qoMriFcdbY7vmFcaDpGuq5
 JFyLq+hikMzdk9xPywzIlLhoi+uO4mYhJ
X-Google-Smtp-Source: AGHT+IHEG7KpFJddtXWoIQdkCAyIa7DoWdCkPTtaJqVLg45k7fAGLH4aTPdLWkzA7ThbWohmerR2Yg==
X-Received: by 2002:a05:6a00:8d0:b0:736:339b:8290 with SMTP id
 d2e1a72fcca58-736aaae450fmr19292720b3a.17.1741621579827; 
 Mon, 10 Mar 2025 08:46:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b9fe8655sm5419682b3a.2.2025.03.10.08.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:46:19 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:46:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH 6/6] bus/vmbus: set event for channel without monitoring
 support
Message-ID: <20250310084617.353a082b@hermes.local>
In-Reply-To: <1740704941-1631-7-git-send-email-longli@linuxonhyperv.com>
References: <1740704941-1631-2-git-send-email-longli@linuxonhyperv.com>
 <1740704941-1631-7-git-send-email-longli@linuxonhyperv.com>
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

On Thu, 27 Feb 2025 17:09:01 -0800
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
>=20
> For vmbus channels without monitoring support, use kernel UIO interface
> to indicate packet through interrupt page and UIO file handle.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

Will consider for 25.07 release.
Please fix the build issue

-------------------------------BEGIN LOGS----------------------------
###########################################################################=
#########
#### [Begin job log] "ubuntu-22.04-gcc-stdatomic" at step Build and test
###########################################################################=
#########
[703/3227] Generating symbol file drivers/librte_bus_pci.so.25.1.p/librte_b=
us_pci.so.25.1.symbols
[704/3227] Linking target drivers/librte_bus_vdev.so.25.1
[705/3227] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vm=
bus_common.c.o
[706/3227] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vm=
bus_bufring.c.o
[707/3227] Generating symbol file drivers/librte_bus_vdev.so.25.1.p/librte_=
bus_vdev.so.25.1.symbols
[708/3227] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vm=
bus_channel.c.o
FAILED: drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o=20
ccache gcc -Idrivers/libtmp_rte_bus_vmbus.a.p -Idrivers -I../drivers -Idriv=
ers/bus/vmbus -I../drivers/bus/vmbus -I../drivers/bus/vmbus/linux -I. -I.. =
-Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux=
/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/=
include -I../kernel/linux -Ilib/eal/common -I../lib/eal/common -Ilib/eal -I=
../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metric=
s -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -fdiagnostics-color=
=3Dalways -pipe -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werro=
r -std=3Dc11 -O2 -g -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -W=
format -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissi=
ng-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsig=
n-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-align=
ed -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dcorei7 -mrt=
m -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno=
-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=3Dbus.vmbus -MD -MQ dri=
vers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o -MF drivers/libtm=
p_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o.d -o drivers/libtmp_rte_bus=
_vmbus.a.p/bus_vmbus_vmbus_channel.c.o -c ../drivers/bus/vmbus/vmbus_channe=
l.c
../drivers/bus/vmbus/vmbus_channel.c: In function =E2=80=98vmbus_send_inter=
rupt=E2=80=99:
../drivers/bus/vmbus/vmbus_channel.c:35:28: error: passing argument 1 of =
=E2=80=98vmbus_sync_set_bit=E2=80=99 from incompatible pointer type [-Werro=
r=3Dincompatible-pointer-types]
   35 |         vmbus_sync_set_bit(int_addr, int_mask);
      |                            ^~~~~~~~
      |                            |
      |                            uint32_t * {aka unsigned int *}
../drivers/bus/vmbus/vmbus_channel.c:22:51: note: expected =E2=80=98_Atomic=
 volatile uint32_t *=E2=80=99 {aka =E2=80=98_Atomic volatile unsigned int *=
=E2=80=99} but argument is of type =E2=80=98uint32_t *=E2=80=99 {aka =E2=80=
=98unsigned int *=E2=80=99}
   22 | vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t) *addr, uint32_t ma=
sk)
      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
cc1: all warnings being treated as errors
[709/3227] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_li=
nux_vmbus_bus.c.o
[710/3227] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vm=
bus_common_uio.c.o
[711/3227] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_li=
nux_vmbus_uio.c.o
[712/3227] Compiling C object drivers/libtmp_rte_common_cnxk.a.p/common_cnx=
k_roc_aes.c.o
[713/3227] Compiling C object lib/librte_pipeline.a.p/pipeline_rte_table_ac=
tion.c.o
ninja: build stopped: subcommand failed.
##[error]Process completed with exit code 1.
###########################################################################=
#########
#### [End job log] "ubuntu-22.04-gcc-stdatomic" at step Build and test
###########################################################################=
#########
