Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A553EFD3779
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 17:43:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDEA84027F;
	Wed, 25 Feb 2026 18:43:43 +0100 (CET)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 36B274027F
 for <dev@dpdk.org>; Wed, 25 Feb 2026 18:43:43 +0100 (CET)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-126ea4b77adso8595031c88.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 09:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772041422;
 x=1772646222; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0dwM+0TfiJt5NsUke+PDaL7KMLB+CEJEk4yLhdWj60=;
 b=qg2bZMkbkXlwEuAT7s3fmpN1f5Tp8b4Qq8zvtEM9cL6K21MYA1ETPWEd6MZvssgGbt
 5WS7f0i8WFypIi+kio/xZPWaYcyjRVGB0htTOtbdnTvxEPcBcsZoB+odtTBWFIUAx/AN
 N0b1Q+RbpI8mA/kkvqq03bCwpbpLTkRBxxCY4cteDbGeqjNy7Ee7M+4lSJ+6UmiHfPpj
 Q0tAvu5fa+gMKLNStnwifA2qjfWenVUVgwftGZ9VTmMD3nGhMMcEub1tawV2wYzm/ekd
 azqsgb9mWzGBBL0+2coCTO16u5BMP9ZBwomlU/rco5utrZnbEDnasvpaXSNEF2k3b5Vg
 SBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772041422; x=1772646222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B0dwM+0TfiJt5NsUke+PDaL7KMLB+CEJEk4yLhdWj60=;
 b=QabA/GwHdnlOPKUd4E5x7Uk/Bt4sBIiPiYQh1LR8XUo0kIwcbgD3z/XxWoBSf0lJ1C
 PKe56LYi6+heHuUUICiV7mUiD634IHnjgbyVKoJ1sXwY65WJjmnh8dAJ/6mhcA3jjhzE
 h++Zz1E21KLH/W73aZUFEn4irshgFLvIURc8SsUPp5PfyH1dSbkCnOg3pXvWXNB5lX1J
 a8hIKvYpswZm18gAY5L12KD8t2lAAy2/rHawyk4E8A43OhsOzia4/rYw/yaiqBYU/0uz
 YNPP8KLPL7MIX4HhCB6Q0LocpdMIxEnvzwnvcrGAzhK9G2lzOeTWFKFphyOylC9J2xhL
 aNNw==
X-Gm-Message-State: AOJu0YwmGsLMhs3CAN5V97geEB7JHSo1J14W2z4y6ra3M4hzFQQhuxGr
 TR5MQiIw03uVqhqFD5dPnaS2YMm6hjedY2ucLPtJNmBurBux9lP4iF17dGtrwox/DI0=
X-Gm-Gg: ATEYQzwQwx5u51QyuWcGIG7GaKDHFsEocMz7PHlmDzfQ+zLWxjosbYK7hAC3LpZDC2Q
 o/b7l/oMWYNyPT7r2JKRexhybrC8DQ35bwdkeokfV+SwSUpcMc6iSZ3nsQ3rBN8+Oa+XY7GJvPH
 INaeH4/8tuvgYZtOMm9upc+4Gu1b+RPX9oWMTs2XUDErkc7qXhu0YEiyoKrWQZaad2cX2uBU2+k
 loXaQZJPJqoge/tCWRNYK8mUs89ZBYPDul8QSWOzSzOjY+WrONK3FOiGs2XcTM/Bm0i6GWUCy9n
 GdUluZ8JPK4Mlbm2N7Rdmw0Z7zMiSDbbg80IDtfiPulZ4jSaxe1BIjmmad6Q08RsXQwh6AkC1IY
 DCgnLYoVGQgoV7TLH+MQ3YnUziGvBS7H4sfvBA0z1Yaqk6ISsLjjsbihW8ko23wL3uZifjLRtwK
 GcIYPubAirNiHtbXjKzgMmHwXmmRVTUEqbLQOFeDoX2v00LJ9r0NZIWs2slcHxMiPY
X-Received: by 2002:a05:7022:603:b0:119:e56c:18b1 with SMTP id
 a92af1059eb24-1276ad182b0mr6710729c88.25.1772041422156; 
 Wed, 25 Feb 2026 09:43:42 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af204acsm14712884c88.4.2026.02.25.09.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:43:41 -0800 (PST)
Date: Wed, 25 Feb 2026 09:43:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: Re: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Message-ID: <20260225094338.5f0641a5@phoenix.local>
In-Reply-To: <PH0PR18MB4086434B58662DA7BF5F5F00DE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260224203709.27696-1-stephen@networkplumber.org>
 <PH0PR18MB4086434B58662DA7BF5F5F00DE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
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

On Wed, 25 Feb 2026 08:01:19 +0000
Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com> wrote:

> >The generic build was building for all SOC types and that
> >takes a long time (like 10 minutes). The driver should only be
> >built if soc_type is set to one of the know values.
> >
> >Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >---
> > drivers/net/cnxk/meson.build | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
> >index 53caa6c171..4a2f4e1a92 100644
> >--- a/drivers/net/cnxk/meson.build
> >+++ b/drivers/net/cnxk/meson.build
> >@@ -14,8 +14,10 @@ else
> >         soc_type =3D platform
> > endif
> >
> >-if soc_type !=3D 'cn9k' and soc_type !=3D 'cn10k' and soc_type !=3D 'cn=
20k'
> >-        soc_type =3D 'all'
> >+if soc_type !=3D 'cn9k' and soc_type !=3D 'cn10k' and soc_type !=3D 'cn=
20k' and soc_type !=3D 'all'
> >+        build =3D false
> >+        reason =3D 'not supported on soc_type ' + soc_type
> >+        subdir_done()
> > endif =20
>=20
> Instead of disabling the build, we can just diable template functions whe=
n soc_type is 'all'
>=20
> diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.bu=
ild
> index 24b48d045f..00295246b6 100644
> --- a/drivers/event/cnxk/meson.build
> +++ b/drivers/event/cnxk/meson.build
> @@ -36,6 +36,10 @@ if meson.version().version_compare('>=3D1.1.0')
>          endif
>  endif
> =20
> +if soc_type =3D=3D 'all'
> +    disable_template =3D true
> +endif
> +
>  if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'
>  sources +=3D files(
>          'cn9k_eventdev.c',
> diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
> index 53caa6c171..9382491ae4 100644
> --- a/drivers/net/cnxk/meson.build
> +++ b/drivers/net/cnxk/meson.build
> @@ -52,6 +52,11 @@ if meson.version().version_compare('>=3D1.1.0')
>          endif
>  endif
> =20
> +if soc_type =3D=3D 'all'
> +    disable_template =3D true
> +endif
> +
> +
>  if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'
>  # CN9K
>  sources +=3D files(
>=20
>=20
> Thanks,
> Pavan.
>=20
> >
> > sources =3D files(
> >--
> >2.51.0 =20
>=20
>=20


Good idea, but fails miserably.
n$ git diff
diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.build
index 24b48d045f..93d7bfdc31 100644
--- a/drivers/event/cnxk/meson.build
+++ b/drivers/event/cnxk/meson.build
@@ -36,6 +36,10 @@ if meson.version().version_compare('>=3D1.1.0')
         endif
 endif
=20
+if soc_type =3D=3D 'all'
+  disable_template =3D true
+endif
+
 if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'
 sources +=3D files(
         'cn9k_eventdev.c',
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index 53caa6c171..d4d1dddceb 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -52,6 +52,10 @@ if meson.version().version_compare('>=3D1.1.0')
         endif
 endif
=20
+if soc_type =3D=3D 'all'
+  disable_template =3D true
+endif
+
 if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'
 # CN9K
 sources +=3D files(

$ time ninja -C build
ninja: Entering directory `build'
[1480/3492] Linking target drivers/librte_net_cnxk.so.26.1
FAILED: drivers/librte_net_cnxk.so.26.1=20
cc  -o drivers/librte_net_cnxk.so.26.1 drivers/librte_net_cnxk.so.26.1.p/me=
son-generated_.._rte_net_cnxk.pmd.c.o drivers/libtmp_rte_net_cnxk.a.p/net_c=
nxk_cnxk_ethdev.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_ethdev_cm=
an.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_ethdev_devargs.c.o dri=
vers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_ethdev_mcs.c.o drivers/libtmp_rt=
e_net_cnxk.a.p/net_cnxk_cnxk_ethdev_mtr.c.o drivers/libtmp_rte_net_cnxk.a.p=
/net_cnxk_cnxk_ethdev_ops.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk=
_ethdev_sec.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_ethdev_teleme=
try.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_ethdev_sec_telemetry.=
c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_eswitch.c.o drivers/libtm=
p_rte_net_cnxk.a.p/net_cnxk_cnxk_eswitch_devargs.c.o drivers/libtmp_rte_net=
_cnxk.a.p/net_cnxk_cnxk_eswitch_flow.c.o drivers/libtmp_rte_net_cnxk.a.p/ne=
t_cnxk_cnxk_eswitch_rxtx.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_=
flow_common.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_link.c.o driv=
ers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_lookup.c.o drivers/libtmp_rte_net=
_cnxk.a.p/net_cnxk_cnxk_ptp.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn=
xk_flow.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_rep.c.o drivers/l=
ibtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_rep_msg.c.o drivers/libtmp_rte_net_cnx=
k.a.p/net_cnxk_cnxk_rep_ops.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn=
xk_rep_flow.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_stats.c.o dri=
vers/libtmp_rte_net_cnxk.a.p/net_cnxk_cnxk_tm.c.o drivers/libtmp_rte_net_cn=
xk.a.p/net_cnxk_cn9k_ethdev.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn=
9k_ethdev_sec.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn9k_flow.c.o dr=
ivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn9k_rx_select.c.o drivers/libtmp_rt=
e_net_cnxk.a.p/net_cnxk_cn9k_tx_select.c.o drivers/libtmp_rte_net_cnxk.a.p/=
net_cnxk_rx_cn9k_rx_all_offload.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnx=
k_tx_cn9k_tx_all_offload.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k=
_ethdev.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_ethdev_sec.c.o d=
rivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_flow.c.o drivers/libtmp_rte_n=
et_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o drivers/libtmp_rte_net_cnxk.a.p/ne=
t_cnxk_cn10k_tx_select.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_rx_cn10=
k_rx_all_offload.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_tx_cn10k_tx_a=
ll_offload.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn20k_ethdev.c.o dr=
ivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn20k_ethdev_sec.c.o drivers/libtmp_=
rte_net_cnxk.a.p/net_cnxk_cn20k_flow.c.o drivers/libtmp_rte_net_cnxk.a.p/ne=
t_cnxk_cn20k_rx_select.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn20k_t=
x_select.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_rx_cn20k_rx_all_offlo=
ad.c.o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_tx_cn20k_tx_all_offload.c.o=
 -Wl,--as-needed -Wl,--no-undefined -Wl,-O1 -shared -fPIC -Wl,--start-group=
 -Wl,-soname,librte_net_cnxk.so.26 -Wl,--no-as-needed -Wl,--undefined-versi=
on -pthread -lm -ldl -lnuma -lfdt '-Wl,-rpath,$ORIGIN/../lib:$ORIGIN/' -Wl,=
-rpath-link,/home/shemminger/DPDK/main/build/lib -Wl,-rpath-link,/home/shem=
minger/DPDK/main/build/drivers lib/librte_ethdev.so.26.1 lib/librte_eal.so.=
26.1 lib/librte_kvargs.so.26.1 lib/librte_log.so.26.1 lib/librte_telemetry.=
so.26.1 lib/librte_argparse.so.26.1 lib/librte_net.so.26.1 lib/librte_mbuf.=
so.26.1 lib/librte_mempool.so.26.1 lib/librte_ring.so.26.1 lib/librte_meter=
.so.26.1 drivers/librte_bus_pci.so.26.1 lib/librte_pci.so.26.1 drivers/libr=
te_bus_vdev.so.26.1 lib/librte_cryptodev.so.26.1 lib/librte_rcu.so.26.1 lib=
/librte_eventdev.so.26.1 lib/librte_hash.so.26.1 lib/librte_timer.so.26.1 l=
ib/librte_dmadev.so.26.1 lib/librte_security.so.26.1 drivers/librte_common_=
cnxk.so.26.1 drivers/librte_mempool_cnxk.so.26.1 -Wl,--version-script=3D/ho=
me/shemminger/DPDK/main/build/drivers/net_cnxk_exports.map /usr/lib/aarch64=
-linux-gnu/libbsd.so -Wl,--end-group
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x0): undefined reference to `cn10k_nix_recv_pkts_no_offload'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x8): undefined reference to `cn10k_nix_recv_pkts_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x10): undefined reference to `cn10k_nix_recv_pkts_ptype'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x18): undefined reference to `cn10k_nix_recv_pkts_ptype_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x20): undefined reference to `cn10k_nix_recv_pkts_cksum'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x28): undefined reference to `cn10k_nix_recv_pkts_cksum_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x30): undefined reference to `cn10k_nix_recv_pkts_cksum_ptype'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x38): undefined reference to `cn10k_nix_recv_pkts_cksum_ptype_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x40): undefined reference to `cn10k_nix_recv_pkts_mark'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x48): undefined reference to `cn10k_nix_recv_pkts_mark_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x50): undefined reference to `cn10k_nix_recv_pkts_mark_ptype'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x58): undefined reference to `cn10k_nix_recv_pkts_mark_ptype_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x60): undefined reference to `cn10k_nix_recv_pkts_mark_cksum'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x68): undefined reference to `cn10k_nix_recv_pkts_mark_cksum_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x70): undefined reference to `cn10k_nix_recv_pkts_mark_cksum_ptype'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x78): undefined reference to `cn10k_nix_recv_pkts_mark_cksum_ptype_r=
ss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x80): undefined reference to `cn10k_nix_recv_pkts_ts'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x88): undefined reference to `cn10k_nix_recv_pkts_ts_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x90): undefined reference to `cn10k_nix_recv_pkts_ts_ptype'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0x98): undefined reference to `cn10k_nix_recv_pkts_ts_ptype_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0xa0): undefined reference to `cn10k_nix_recv_pkts_ts_cksum'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0xa8): undefined reference to `cn10k_nix_recv_pkts_ts_cksum_rss'
/usr/bin/ld: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_cn10k_rx_select.c.o:(=
.data+0xb0): undefined reference to `cn10k_nix_recv_pkts_ts_cksum_ptype'
