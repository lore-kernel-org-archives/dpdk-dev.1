Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E66ACA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 13:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0849F402D4;
	Tue, 26 Aug 2025 15:56:13 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 528A7402CE
 for <dev@dpdk.org>; Tue, 26 Aug 2025 15:56:11 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso29566105e9.3
 for <dev@dpdk.org>; Tue, 26 Aug 2025 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756216571;
 x=1756821371; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxbs6JLMRjkt63WrmLxGLEzbdSnivmRrEqfaBbn1suY=;
 b=uwO4LNS04m+1zP5T7sBP6EPNv/M2sXF7I4dbFP4PHFyPCDYjST0r0oqSNRbPzIX0ng
 +K+jkbjpQB4Trie7MEpvVIkPoXRQvqxMA9NfR1LSgTfJqa4qtD90M9+KlR5g63r1LtzQ
 tV5CXoBQD6M+2zqPZr9vBHf82rSUhuxfOp3uVl2gEwYptPcdtO9ZuLlNp1Cx+gzxEWGw
 Mabs+LpQTcpOfBjgproP3jl6ZYUFeSmeM6imcEc/JlGSFG+i8nClsHA2l+7k+2yFdvK8
 iRlrieFPZr/uIAsNwMW8hgfRHoGQuCRJgcIMV44bawiExvo+C4df6E310phdOKb0BLeR
 TTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756216571; x=1756821371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxbs6JLMRjkt63WrmLxGLEzbdSnivmRrEqfaBbn1suY=;
 b=foToUkIlHfqShVuD0tlMvBBqI6SdfG28nqC/x1jcNHG82fgshP9kRIlPdgNhcxmL41
 Fy0PGZUzEC6qhk9IrFhGftqWCPrJoOo9DubIm0XedtfWuCjelFPMpW1Rh1Q5aJ7uD3wd
 0/T1i7DfjaaYvval6uGKCsyvMn0TZOmD7RnQHXTenyGwN0l3u9o4+QM/Mho2hK6zmn0/
 DO2bjnMeKoaM+Im41NSWIVJiApHGqzKNQzfUrfyNGqhrEU/rBJK5V2ag5L/nxnxP8ySQ
 o2RWQ+hX0kX7Pcs45pp8dhOyUn8Uw1vWWhre2rB+4NPcHttPfnTa2BaVdXK3iG49ST1N
 m6Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8rOrXlfX/vs9zRVJgxTO0CXOT3PiYxN6NdzQ5lwkIXtU+FFj+36LqsTjOz1/UDvI+Tyo=@dpdk.org
X-Gm-Message-State: AOJu0YwRqgAaWVsr1r1FVdh9VX4U47ohbfSxr+kjbtWPEf2arvMZWUu8
 8oiM/7xq2fabn0fV9hQhgI0IZT8c94dkRW1J/N6+Mzkl7H5zD5Gtqm9XwT5S4mwZrJg=
X-Gm-Gg: ASbGnctDxTAmvXayYxQaG4E1wGUrQq/Vj7oT2f40KX3mjDkMXQCWrTHHRWlf68C3W+a
 LX1L7kN6+8c8mtl45PEI4Fj0D8x8WuLUFLguahn//sgzEii4dw3I2vBHHRHN41wuD7IQ3DuYycj
 Gd/iE8Q4vUCQrRhBdNyVuUGlpEFsn3ceUyOe2KbWOz7pg5FZYfG7T4yK8U/2exB7Nxpxn6QJ+n0
 OdHpxFhJzljnVz0Zd7H3aNi5pd5ALYYSIlxxCY9uTrgsQesYN6tH8yuFaG8PDfRYu9Fwf1p0ICi
 5NtUAOzxs4HElDAYVl4dnWMhb27y2uqDlStIMtqyMCcnMMBM45lD4G0TS/Sh1j4lAfjtj092gJD
 KzW2HvxJL/KEaOY5vkUnGMSo5qXxUUM1FNHjwDdySW8fa+cQHVi5W3qM3rCezgsnaFykgdr7xMr
 8=
X-Google-Smtp-Source: AGHT+IEbcStta3093GVt4Ug1hM9g4VF5Ul8qUOQOn+SWDxQhLNpXMf1YaH02XGjoAPZK5wjvBmTlKg==
X-Received: by 2002:a05:600c:530e:b0:45b:615c:cd2 with SMTP id
 5b1f17b1804b1-45b615c0df5mr63369015e9.8.1756216570784; 
 Tue, 26 Aug 2025 06:56:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4b9d30sm16103518f8f.13.2025.08.26.06.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 06:56:10 -0700 (PDT)
Date: Tue, 26 Aug 2025 06:56:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: longli@microsoft.com, Wei Hu <weh@microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] net/netvsc: cache device parameters for hot plug events
Message-ID: <20250826065606.13738b90@hermes.local>
In-Reply-To: <1756170959-19822-1-git-send-email-longli@linuxonhyperv.com>
References: <1756170959-19822-1-git-send-email-longli@linuxonhyperv.com>
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

On Mon, 25 Aug 2025 18:15:59 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
>=20
> If a device is hot removed and hot plugged, it needs the same driver
> parameters that are passed to EAL. However, during device removal, all
> EAL driver parameters are freed as part of the cleanup.
>=20
> Cache those driver parameters for future hot plug events. Because we don't
> know which device will show up, cache all the PCI driver parameters.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

Please fix this warning.

*Build Failed #1:
OS: OpenAnolis8.10-64
Target: x86_64-native-linuxapp-gcc
FAILED: drivers/libtmp_rte_net_netvsc.a.p/net_netvsc_hn_ethdev.c.o=20
gcc -Idrivers/libtmp_rte_net_netvsc.a.p -Idrivers -I../drivers -Idrivers/ne=
t/netvsc -I../drivers/net/netvsc -Ilib/ethdev -I../lib/ethdev -Ilib/eal/com=
mon -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I.=
./lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/=
eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../l=
ib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I=
../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net -I=
lib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/r=
ing -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../=
drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../driver=
s/bus/vdev -Idrivers/bus/vmbus -I../drivers/bus/vmbus -I../drivers/bus/vmbu=
s/linux -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winval=
id-pch -Wextra -Werror -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qu=
al -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-de=
clarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wp=
ointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wn=
o-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -m=
arch=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-form=
at-truncation -Wno-vla -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.netvsc -MD -MQ d=
rivers/libtmp_rte_net_netvsc.a.p/net_netvsc_hn_ethdev.c.o -MF drivers/libtm=
p_rte_net_netvsc.a.p/net_netvsc_hn_ethdev.c.o.d -o drivers/libtmp_rte_net_n=
etvsc.a.p/net_netvsc_hn_ethdev.c.o -c ../drivers/net/netvsc/hn_ethdev.c
../drivers/net/netvsc/hn_ethdev.c: In function =E2=80=98populate_cache_list=
=E2=80=99:
../drivers/net/netvsc/hn_ethdev.c:1469:40: error: argument to =E2=80=98size=
of=E2=80=99 in =E2=80=98strncpy=E2=80=99 call is the same expression as the=
 source; did you mean to use the size of the destination? [-Werror=3Dsizeof=
-pointer-memaccess]
   strncpy(cache->name, da->name, sizeof(da->name));
