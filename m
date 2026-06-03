Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEF1CD6E60
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6883C40662;
	Wed,  3 Jun 2026 17:56:46 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 056454065F
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:56:45 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-137f0aa125bso4201930c88.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780502204;
 x=1781107004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwabCXoFQNjhOZPPEKEtzJsfv5v4FPaC7WG3m2Be/wk=;
 b=H1cAyu/gjpwbKCe3X7QXnVi+MlXxzrN2QF3T5WU/MAytYYMFM+8LNLAwEkAFL7gANC
 hAchhTNCFu8XlGKcdkRiT+o5sr68RtgNXrdOx1HNPUY5eF5A0A5iLhRveYHD9vMVy4EU
 s7hapBdub8hOKTHsrC15o1RrqhKWx+JUIllGaSyMJN/1lpQq0cLoksB7klrUU9bwgwud
 VidTCbktV24rBJ+fCXJ1KPyGWLpsu64OMZnCTVP6igc3/9q+6vmmrfFYHimhfx5qzxPr
 GfQuNJuHxq0C7jQIrAasPCuTo2241rGwNGXJrdxZ1JDAV98bgCyYZnk0OjpALnTZ4IWN
 pT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502204; x=1781107004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AwabCXoFQNjhOZPPEKEtzJsfv5v4FPaC7WG3m2Be/wk=;
 b=M0TnX3ANZd5rUv2kgf4MADXtow9fgGY2OwjJsHFkd9X/9bm1sVc29l+GAqX8Bj93a2
 t/6DeAyidB43IFMdhUqcbvIS3zaapx+bFvleFFweT8Byi5mwLewbzxrE3WktoM8f+xvR
 5G2gDpIFCT4e06xD1TTqte9b8z6yyRFEazbFfMwzk9EdI68Kq3BTBVsZVLVZsmPVlAK1
 8JTd0lUyNBYhxMhKzYho39uO679TlzW5eHp4ECNDCti6XGYjhCgoyUDwI4YIwEIJ6oY3
 sU3zYR4jWx+TnqddKv2kOgw520A07uhsJxA4YE2WAwOHw+oJY1VEOUusgX/qhnCtaEPF
 WiIQ==
X-Gm-Message-State: AOJu0Yzm6qjrW1f4gIa3KxUeCgcLhQ/DpCSZ3yZ4ylIzoKxvRdWYBTtL
 5qFRUdh6YZNM5afiuSiwqLHKRswyLc/vQkhn3zourMfpYvuCCGCNVXrm4A0d9SB5M7o=
X-Gm-Gg: Acq92OFd0NheerM5JvuTHsSgA3zm1/GxDrQcgGpzbt93EfMVQelB+HRomwgae2LjN5P
 apDtH5OVi5BITo+sDZMsdOxJ6CVELXdKTmf/xNDVTh5It34VAYh76UrzkpzGU5mVuDo9RiBuuId
 dgGepA75p0MwIJoVG6Xc2OMOTT6Qlvu41EbamSKnHXO9a7NOnz4ukNJZkrJDLHYvKpRYRP0mTr2
 lEkYYLIQE/EZfxhqDZ08DNlQhoqLmdCRabNJDZtNP+M2W12+o5Ku+aVKAw4YVeIHdFq9Ia/mKfB
 ErtWJXAEnCHCZ0VSiYScSlIbuyp1qCoJ70nTbOfhgsSxbIIFWyvSmkFwWyWw0M0lhh6ttJ+movH
 oGwqLhVr3PnUMspAZ09EV7rNh3+EsXB2KsK/Gz8sKL/x0hxh8U6s5Ja+bt6cTZ9kXIwWel28Ahd
 wph20Kt5cxD1P87EicGTCQlZ7iiFQ97qaxHZrXjikSue2ycCa231h8bGrzMO66cCC+nsiqfQDf5
 jg=
X-Received: by 2002:a05:701b:260a:b0:136:959a:abdc with SMTP id
 a92af1059eb24-137f6a464ccmr1079186c88.11.1780502203785; 
 Wed, 03 Jun 2026 08:56:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm2155710c88.6.2026.06.03.08.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:56:42 -0700 (PDT)
Date: Wed, 3 Jun 2026 08:53:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] eal: fix function versioning with LTO
Message-ID: <20260603085359.739ab626@phoenix.local>
In-Reply-To: <CAJFAV8w+bUJGTBSOgqp8xOHXm5av2xdFMo8TNwr=kP87R30AYg@mail.gmail.com>
References: <20260602225722.950617-1-stephen@networkplumber.org>
 <CAJFAV8w+bUJGTBSOgqp8xOHXm5av2xdFMo8TNwr=kP87R30AYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 3 Jun 2026 12:01:48 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Hello,
>=20
> On Wed, 3 Jun 2026 at 00:57, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > When using function versioning and building with Link Time Optimization,
> > the compiler does not see the __asm__ annotation of symbols and
> > therefore thinks there are two versions of the same symbol.
> >
> > The fix is to use compiler symver attribute on the function which
> > was added in GCC 10. Keep the older method for backward compatibility
> > with older compilers.
> >
> > Bugzilla ID: 1949
> > Fixes: e30e194c4d06 ("eal: rework function versioning macros") =20
>=20
> We never used the symver stuff, so it seems unlikely the issue was
> introduced with this rework.
>=20
> The fact that clang does not support this attribute is a concern.

Clang doesn't have this problem. It works as is.

> > Cc: stable@dpdk.org =20
>=20
> Why do we need to backport?

Well LTO has worked for a long time, it is not experimental just
not commonly done since it takes so long to build.

We were doing it years ago at MSFT.

>=20
> LTO is kind of experimental, so it seems good enough to reply "not
> expected to work in older LTS" if someone reported an issue.
>=20
> And in practice, no LTS release call the versioning macros, since a
> LTS drops all compatibility.
>=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org> =20
>=20
> I would like to reproduce, but I can't build main with LTO.
> What patches did you apply locally to avoid warnings on the hash library?
I use Debian testing and GCC 15 but shows up on older versions as well
I get no warnings building main

 $ git am ~/Downloads/v2-ethdev-add-buffer-size-parameter-to-rte_eth_dev_ge=
t_name_by_port.patch
 $ meson setup build-lto -Db_lto=3Dtrue
 $ ninja -C build-lto
ninja: Entering directory `build-lto'
[620/3781] Linking target lib/librte_ethdev.so.26.2
FAILED: [code=3D1] lib/librte_ethdev.so.26.2=20
cc  -o lib/librte_ethdev.so.26.2 lib/librte_ethdev.so.26.2.p/ethdev_ethdev_=
driver.c.o lib/librte_ethdev.so.26.2.p/ethdev_ethdev_private.c.o lib/librte=
_ethdev.so.26.2.p/ethdev_ethdev_profile.c.o lib/librte_ethdev.so.26.2.p/eth=
dev_ethdev_trace_points.c.o lib/librte_ethdev.so.26.2.p/ethdev_rte_class_et=
h.c.o lib/librte_ethdev.so.26.2.p/ethdev_rte_ethdev.c.o lib/librte_ethdev.s=
o.26.2.p/ethdev_rte_ethdev_cman.c.o lib/librte_ethdev.so.26.2.p/ethdev_rte_=
ethdev_telemetry.c.o lib/librte_ethdev.so.26.2.p/ethdev_rte_flow.c.o lib/li=
brte_ethdev.so.26.2.p/ethdev_rte_mtr.c.o lib/librte_ethdev.so.26.2.p/ethdev=
_rte_tm.c.o lib/librte_ethdev.so.26.2.p/ethdev_sff_telemetry.c.o lib/librte=
_ethdev.so.26.2.p/ethdev_sff_common.c.o lib/librte_ethdev.so.26.2.p/ethdev_=
sff_8079.c.o lib/librte_ethdev.so.26.2.p/ethdev_sff_8472.c.o lib/librte_eth=
dev.so.26.2.p/ethdev_sff_8636.c.o lib/librte_ethdev.so.26.2.p/ethdev_ethdev=
_linux_ethtool.c.o -flto=3Dauto -Wl,--as-needed -Wl,--no-undefined -Wl,-O1 =
-shared -fPIC -Wl,-soname,librte_ethdev.so.26 -Wl,--no-as-needed -Wl,--unde=
fined-version -pthread -Wl,--start-group -lm -ldl -lnuma -lfdt '-Wl,-rpath,=
$ORIGIN/' lib/librte_eal.so.26.2 lib/librte_kvargs.so.26.2 lib/librte_log.s=
o.26.2 lib/librte_telemetry.so.26.2 lib/librte_argparse.so.26.2 lib/librte_=
net.so.26.2 lib/librte_mbuf.so.26.2 lib/librte_mempool.so.26.2 lib/librte_r=
ing.so.26.2 lib/librte_meter.so.26.2 -Wl,--version-script=3D/home/shemminge=
r/DPDK/lto/build-lto/lib/ethdev_exports.map /usr/lib/x86_64-linux-gnu/libbs=
d.so /usr/lib/x86_64-linux-gnu/libarchive.so -Wl,--end-group
/tmp/cc3RQyqL.s: Assembler messages:
/tmp/cc3RQyqL.s: Error: invalid attempt to declare external version name as=
 default in symbol `rte_eth_dev_get_name_by_port@@DPDK_27'
make: *** [/tmp/ccVzgiZ2.mk:2: /tmp/ccTlGfA9.ltrans0.ltrans.o] Error 1
make: *** Waiting for unfinished jobs....
lto-wrapper: fatal error: make returned 2 exit status
compilation terminated.
