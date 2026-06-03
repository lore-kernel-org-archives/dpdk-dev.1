Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E80CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A56C402CC;
	Wed,  3 Jun 2026 17:25:01 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 143D8402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:24:58 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-137f18f45dbso1695216c88.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780500298;
 x=1781105098; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9GFlvz9WnqAaA5FiVvHWcMw/3OcKCdFfSjSvd3qpqE=;
 b=FQUUL/KT5ZdFexgihJfNdi+r5EJ8kQnhGyQuY+DwgICHdiaeHPkZnXSHklxSaIR39o
 rYY2uLXeZJwyv29g71kr3DTB7WgJsVYiKPmIhI8X4tjilhLbwoC9FtwgAYx8VF4TT8Nj
 018+goF1D+cvizo0GEg3QWGi4OC9Lpt9O59BVGZJtpjIq0c/ZO+DbJ0QluObn9uHBHUz
 TdmfWRZKMvPaMF1RcxomxeMVtlHhCPY9YUDuZ5kuo66IJIlT21BDuqb8+6Yp7UDrP8hx
 X/f44WkKLDnYefONu8yTHY246EhkYAerk5DsJfZxBFf1kLy1+tSatsFKshsOMcmyNDll
 Axjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780500298; x=1781105098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g9GFlvz9WnqAaA5FiVvHWcMw/3OcKCdFfSjSvd3qpqE=;
 b=kiHUxlvkIfRcoZXYggpBW4LwOo7GO+2eSLQg7KxGQN4BSxPzxqo85cZ4FtIfiaB5av
 zXJWgGB3n1G6V+g9+60YewFAmt1+NyEQq4VYslQvOS7SmYSr2ebkm6qscpvuIayjobmB
 TuNPGYFZPSXgGeS9u2zIXOBDjshJb6Hf2o684he1AFUsR7ovIcLnlTqz27ZH3wGKN3pC
 DdQ6o9IxG+C9rGe33KcCCqiq+VeN41DE0yIjfxy9J63ExcduXTrYHy9UE//E7avJXcFQ
 ndfTcW9urnPDXg9H7eqPCJT1A5yr/fzdZrxvyBJe9/iViuIurw7II/2gF9k0UH/m4drZ
 DP3A==
X-Gm-Message-State: AOJu0YwRyii07Sx3nvcn9Zlwb3Ub3SNTkLtipcv9LH3l9djTBIapYC8o
 08SpTHFpqGwo70waMMwbl4s7w0S2TvLcABCj2QdUcTwdG+UzdUbEehBLsXikQU3nqgE=
X-Gm-Gg: Acq92OEDwkMOhIBBR3FMTgChrqlo/9YZ1YvFdKmm8j1nsgWorohf9CG2MMXITa6fJ7p
 4rJXq1vgC/q+8dZlgN7ci6RUf3e0L8Vkasgp2U8RFNys4z3RB/w5ILyJHBzetAPCFb7Lxrsq3LU
 QhgdsODplEjHYZYV/+DHbEDTyylriQWEv+bJXfbS674r506/p97Hr2rIMJuyAI75F0EQYuOSbx6
 zZKdvnPFxHRKOtfygSBiIQO26XVWp2klG9idPrDp9oGj06HQRkdcGalGCeXOodf+p1w0ABSP/fg
 Ip9vU5MdyVecO/QEQNoGskp1PMzB8ZMmHKCKR5f3b7S3DA+XWTcByarwnhuN3aKEzbjF5TyCinM
 NKcIVmfpG3+p/6KksWqOnaa7GYOcsx66iOSs7+CLRN3gH6Cqr2uczmeRr0THdmakr9qDQZpVbAx
 50n0F+07NEO12gYGotpk7CMTf60LOscIH8jO8ackK9tJVkAqIptdtqo30kH1HsxbIkVG+PQE8ik
 An0l24aurwkaA==
X-Received: by 2002:a05:7301:1010:b0:304:5b65:5971 with SMTP id
 5a478bee46e88-3074fb4a05cmr2117391eec.20.1780500297906; 
 Wed, 03 Jun 2026 08:24:57 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df805d1sm2344811eec.28.2026.06.03.08.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:24:57 -0700 (PDT)
Date: Wed, 3 Jun 2026 08:24:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] eal: fix function versioning with LTO
Message-ID: <20260603082454.1af734d7@phoenix.local>
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
>=20
>=20
> > Cc: stable@dpdk.org =20
>=20
> Why do we need to backport?
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
I get no warnings from current main with GCC 15

I was doing test build of net-next with this patch:
https://patchwork.dpdk.org/project/dpdk/patch/20260529000748.275863-1-steph=
en@networkplumber.org/

The LTO build is done by:
 $ meson setup build-lto -Db_lto=3Dtrue

The result was:
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
/tmp

Fed the result into Claude, and it said "yeah, I see the same problem on
other projects, the answer is ...". With a little searching found an example
in Gentoo https://github.com/InBetweenNames/gentooLTO/pull/458

With this change symbol versioning with LTO works on both GCC >=3D 10 and C=
lang.
Clang LTO doesn't have the attribute, but it also doesn't have the same LTO=
 issue.

