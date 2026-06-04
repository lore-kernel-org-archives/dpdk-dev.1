Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4768CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 07:50:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CC51402E1;
	Thu,  4 Jun 2026 09:50:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 50B2540270
 for <dev@dpdk.org>; Thu,  4 Jun 2026 09:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780559441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iP8o4796V4MBjsc8qUy6laKIld1owBCqQ4TTfpP2f60=;
 b=cZ/pJ3K0h2QhlJSSzk01uHqmxkvAXGbRKiGePFfUrMuEtSlbCM/2/VJbZ8ZH+O4dMIVpgv
 eNyG/gUgE8yDbMSdX606oHuZwBUWFrXOveGy11SbSXLPyG+S18uN3Rdj6GQWdrsB3oEclq
 o3NArkTMASq0BcpEnCQbH4X9ZM7/wAw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-h0NYxXFqP5GKshcDv-3ocg-1; Thu, 04 Jun 2026 03:50:39 -0400
X-MC-Unique: h0NYxXFqP5GKshcDv-3ocg-1
X-Mimecast-MFC-AGG-ID: h0NYxXFqP5GKshcDv-3ocg_1780559438
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39664f3e398so2624311fa.2
 for <dev@dpdk.org>; Thu, 04 Jun 2026 00:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780559438; x=1781164238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iP8o4796V4MBjsc8qUy6laKIld1owBCqQ4TTfpP2f60=;
 b=UDjFsam661vhkNfCyoUhGAbpXZpELgBTbH8hQY3N5uIR8X6mkRJawToe6G4G5aAu+P
 Dt7EAavdHL1+7r1nn197jaqULC6AyYoBdD3bYmuYDqgzwciTSm9m7FlSnzkkmP7f8tCo
 YJta8STKW6/n7n6sTy0sSk1q3WSbVHcvPqjZ29jhRRgKsL2Lx0AifVWzZRqSeTEKpbTl
 N0VKOhljP22Mt6n6pAW8ceP9q1H/lJQa8ZaEDYacXCvWYic09V3ek8utfwlBii91NYp8
 QlYTOhMlwfkl2gecOjX4GIDQyZTcrYOv9rgsDDniseW6OoRNit/cwtZrz38Va/isWJFu
 BMkQ==
X-Gm-Message-State: AOJu0YyIo43TBCpO3Y2e8rGmun/IoftNpAYI8Ccqd7Og2+po1B6eaMeX
 ufpupyjJkdOU/sjFU54BtTtjR8mlTXxf3t+b2Xr9NiYsBAZyXahpjLPUh8WPBzpA5GnAZ3S8NLh
 Nwaq/N7lwaSStU3OqHnKl7sf8yHhzV2gGmhjnSI33LocleqjjhwF5LrkSLpT5hljCFCFgPvp1aM
 3QmzCvEEiDVxf/nBCPKtI=
X-Gm-Gg: Acq92OEJG0UB+wiHYJj4aHJ3Km9OPWFcghG7K6U4Unvz6728Rc7e/OyuZZENOl53Tms
 PxYct5ryKn0ERVSNvy6B3o6Hs/h9X5CfbJ4R5DWiMtImxbCj+LX7E7T14uh6nzRLOUZZ+6lf8mV
 fIW1Ch0GCH4CsoRx6OwvMT/VTcRV+Z2IzcWX923wNf5cwvsrCFLFyQtWhBvRFbMSCG5YDQ5xKW1
 ia7HWaZQ5tfCSct2mp+jCqyeu4k6taL6X3Xc4xDE60LFZ2mDRaSl0E1iJUyUDfGXwRJsry3fRXT
 oUZO
X-Received: by 2002:a2e:a987:0:b0:38e:a883:6303 with SMTP id
 38308e7fff4ca-396af1610e1mr20146081fa.9.1780559437888; 
 Thu, 04 Jun 2026 00:50:37 -0700 (PDT)
X-Received: by 2002:a2e:a987:0:b0:38e:a883:6303 with SMTP id
 38308e7fff4ca-396af1610e1mr20145951fa.9.1780559437323; Thu, 04 Jun 2026
 00:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260602225722.950617-1-stephen@networkplumber.org>
 <CAJFAV8w+bUJGTBSOgqp8xOHXm5av2xdFMo8TNwr=kP87R30AYg@mail.gmail.com>
 <20260603085359.739ab626@phoenix.local>
In-Reply-To: <20260603085359.739ab626@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 4 Jun 2026 09:50:25 +0200
X-Gm-Features: AVHnY4JQ40KYH9f74RvEFpCka93KwbaZ1fvRl8QJjYffbGDaRyM3ivaoNXWlBW0
Message-ID: <CAJFAV8zEg7YNuoO-U-fwnWCJ4MWk9Zm0Zp9pwoirRRn9LHFKrQ@mail.gmail.com>
Subject: Re: [PATCH] eal: fix function versioning with LTO
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pLueSmAw9ITGsRuA5zF8ZaW9-EmoIlY9f7FPWHaIzxY_1780559438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 3 Jun 2026 at 17:56, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 3 Jun 2026 12:01:48 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> > Hello,
> >
> > On Wed, 3 Jun 2026 at 00:57, Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > When using function versioning and building with Link Time Optimizati=
on,
> > > the compiler does not see the __asm__ annotation of symbols and
> > > therefore thinks there are two versions of the same symbol.
> > >
> > > The fix is to use compiler symver attribute on the function which
> > > was added in GCC 10. Keep the older method for backward compatibility
> > > with older compilers.
> > >
> > > Bugzilla ID: 1949
> > > Fixes: e30e194c4d06 ("eal: rework function versioning macros")
> >
> > We never used the symver stuff, so it seems unlikely the issue was
> > introduced with this rework.
> >
> > The fact that clang does not support this attribute is a concern.
>
> Clang doesn't have this problem. It works as is.

The Fixes: tag is wrong regardless.
The issue is probably present since introduction of the versioning
macros, or introduction of LTO in DPDK (not sure which came first).


> > > Cc: stable@dpdk.org
> >
> > Why do we need to backport?
>
> Well LTO has worked for a long time, it is not experimental just
> not commonly done since it takes so long to build.
>
> We were doing it years ago at MSFT.

Well, sorry, but every time I enable LTO, I end up with some warnings somew=
here.
I don't think I am doing stuff really exotic though.

Looking at bugzilla, we had various fixes for LTO over the years.
We still have one open bz btw: https://bugs.dpdk.org/show_bug.cgi?id=3D1709

Hence my feeling this feature is not something used by many people around.
And without a CI, we will keep on having to fix bugs/issues.


> > LTO is kind of experimental, so it seems good enough to reply "not
> > expected to work in older LTS" if someone reported an issue.
> >
> > And in practice, no LTS release call the versioning macros, since a
> > LTS drops all compatibility.

Just to be clear, we don't need fixing the macros in LTS: every time
we prepare a LTS rc0, we drop any kind of symbol compat.


> >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> > I would like to reproduce, but I can't build main with LTO.
> > What patches did you apply locally to avoid warnings on the hash librar=
y?
> I use Debian testing and GCC 15 but shows up on older versions as well
> I get no warnings building main

Building from scratch, I do avoid the warnings I hit yesterday.

The fix looks correct, my problem is with the form.
Fixes: tags accuracy is important.
And I prefer we stick to "It is not broken, don't fix it".


Thanks.


>
>  $ git am ~/Downloads/v2-ethdev-add-buffer-size-parameter-to-rte_eth_dev_=
get_name_by_port.patch
>  $ meson setup build-lto -Db_lto=3Dtrue
>  $ ninja -C build-lto
> ninja: Entering directory `build-lto'
> [620/3781] Linking target lib/librte_ethdev.so.26.2
> FAILED: [code=3D1] lib/librte_ethdev.so.26.2
> cc  -o lib/librte_ethdev.so.26.2 lib/librte_ethdev.so.26.2.p/ethdev_ethde=
v_driver.c.o lib/librte_ethdev.so.26.2.p/ethdev_ethdev_private.c.o lib/libr=
te_ethdev.so.26.2.p/ethdev_ethdev_profile.c.o lib/librte_ethdev.so.26.2.p/e=
thdev_ethdev_trace_points.c.o lib/librte_ethdev.so.26.2.p/ethdev_rte_class_=
eth.c.o lib/librte_ethdev.so.26.2.p/ethdev_rte_ethdev.c.o lib/librte_ethdev=
.so.26.2.p/ethdev_rte_ethdev_cman.c.o lib/librte_ethdev.so.26.2.p/ethdev_rt=
e_ethdev_telemetry.c.o lib/librte_ethdev.so.26.2.p/ethdev_rte_flow.c.o lib/=
librte_ethdev.so.26.2.p/ethdev_rte_mtr.c.o lib/librte_ethdev.so.26.2.p/ethd=
ev_rte_tm.c.o lib/librte_ethdev.so.26.2.p/ethdev_sff_telemetry.c.o lib/libr=
te_ethdev.so.26.2.p/ethdev_sff_common.c.o lib/librte_ethdev.so.26.2.p/ethde=
v_sff_8079.c.o lib/librte_ethdev.so.26.2.p/ethdev_sff_8472.c.o lib/librte_e=
thdev.so.26.2.p/ethdev_sff_8636.c.o lib/librte_ethdev.so.26.2.p/ethdev_ethd=
ev_linux_ethtool.c.o -flto=3Dauto -Wl,--as-needed -Wl,--no-undefined -Wl,-O=
1 -shared -fPIC -Wl,-soname,librte_ethdev.so.26 -Wl,--no-as-needed -Wl,--un=
defined-version -pthread -Wl,--start-group -lm -ldl -lnuma -lfdt '-Wl,-rpat=
h,$ORIGIN/' lib/librte_eal.so.26.2 lib/librte_kvargs.so.26.2 lib/librte_log=
.so.26.2 lib/librte_telemetry.so.26.2 lib/librte_argparse.so.26.2 lib/librt=
e_net.so.26.2 lib/librte_mbuf.so.26.2 lib/librte_mempool.so.26.2 lib/librte=
_ring.so.26.2 lib/librte_meter.so.26.2 -Wl,--version-script=3D/home/shemmin=
ger/DPDK/lto/build-lto/lib/ethdev_exports.map /usr/lib/x86_64-linux-gnu/lib=
bsd.so /usr/lib/x86_64-linux-gnu/libarchive.so -Wl,--end-group
> /tmp/cc3RQyqL.s: Assembler messages:
> /tmp/cc3RQyqL.s: Error: invalid attempt to declare external version name =
as default in symbol `rte_eth_dev_get_name_by_port@@DPDK_27'
> make: *** [/tmp/ccVzgiZ2.mk:2: /tmp/ccTlGfA9.ltrans0.ltrans.o] Error 1
> make: *** Waiting for unfinished jobs....
> lto-wrapper: fatal error: make returned 2 exit status
> compilation terminated.
>


--=20
David Marchand

