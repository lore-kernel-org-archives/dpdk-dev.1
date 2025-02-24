Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF235C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 15:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B973841104;
	Mon, 24 Feb 2025 16:31:51 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 97FF3410D5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 16:31:50 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-219f8263ae0so95189035ad.0
 for <dev@dpdk.org>; Mon, 24 Feb 2025 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740411110;
 x=1741015910; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnpWOwNLUHl08P2QDkjLMU+qWQxxjSIi9ymyzl6l/ek=;
 b=uZ/OO3a5b7cf0I12VI14LK/7q0DmpTf1euNVth11AXwQZ4+/FhnQxQg0UjBzmzf1TC
 IRRLlGbozGjds8Aj3cbSAyOrMvGfTEnaIlWJrBO+cZQf1evPThnKDxOsarblfNfytr1H
 zEVAS/P7nYtJKyVWncncWsbW+gM127Rww33sBmdhEVRUrVvWBub+N7MSgFtrcM0A0RLP
 Oi50jJZQni4EMPFKzgITi2KAUx4VhecxZw8tCpePS9H/iHzEpylVQ3+TqBXY4ipsQSXs
 tQn/yMXoYv6CRO2n0cFdvUST73RYl+NRBtuM5VvWQuSm+1HO2gGtQ3VW2hv35PcNzAlG
 PTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740411110; x=1741015910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnpWOwNLUHl08P2QDkjLMU+qWQxxjSIi9ymyzl6l/ek=;
 b=BtXAebexCjSFfGefCfuvJZp/iyBM2uhUbpBNb5H/4k32tdkCqQcJqOIHNnec+yvnu+
 Ut3MOo/oU7V5ZlcVQGS75mCDLr59+cbkiVpucj/wdCIpuOKLbMyuR5YKiqHTt6TiTC3i
 UuK2wCwGKRaaJ/CTkMP1k6agBvXik10TwSprDpbjl96yyCwjOYdQ8v29yM3RoWh0nQmp
 QfaxDLJF0GIZHWnkPDXd3mBHQ609t/E1BQqjRmay9wFKd1CClmNJcwNjT5GxNy3jBsCr
 qfyS4C56E5We13fX3us/3/zWZhrRAO63UfgRjy8OIUIvmrvNDLwTDpBenIY/yLAU8JHX
 dlyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK6jAchuEhuey4WjnM47dQVsyX30IQKPq/o/hdfgCWgKtClskmxdwZpDwvrUR8XiCpYvg=@dpdk.org
X-Gm-Message-State: AOJu0Yw6l0OCAaoMEB4co6cY1Q+3VFLu4zKyUU4uZiTNi/LAmM4EeRhG
 1AJHoTm0oMUV4yoeyeGdzhwC3tYetJ6mPBxIQhyfh9mUuAJ5O/gSA96F9Ln4g8A=
X-Gm-Gg: ASbGncu1JnuXDZgVSN7+EEiwR5/LprVeOyveBZuPqxUsKxQEe5DKmk7vZ2bhSlfPJl4
 I4yP8JzwstxEnng0qIXgD4NxiLDMvSS9vJOhkVKxcd7Ripq5DZvW69JYVUw4VcQ4dKe5qhO+vBM
 /veZQFCLN9hnnV6e8b5vIMDChNRqphO+n6avqsuEkFf3ShwwqAKSazXUZUk7knSStgik9Ulnet7
 Z2Kgi8TVm6ye1gk0hyz6G/ESKiSIXMtbxjL2yu5GHHZlZfqizi8ayZ6VmGCkeeZUSvwXKqTiVQW
 /7tB0cGS7j3kPVjOxUzCFuP69yzAtfxjH/LekQlyDAaDn59/jeBQRJmsEdxWRiVnXapgmJHeSom
 R3d8=
X-Google-Smtp-Source: AGHT+IHJy1mCfkg7lRAgK5TrnUlN8WAfc9ipEcrxBsFLPTJTB7mgkGNodI3LS8RS8incWWCgdQl1HA==
X-Received: by 2002:a17:903:183:b0:220:d601:a6dc with SMTP id
 d9443c01a7336-221a10e637amr240910045ad.22.1740411109608; 
 Mon, 24 Feb 2025 07:31:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5364351sm182047475ad.76.2025.02.24.07.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 07:31:49 -0800 (PST)
Date: Mon, 24 Feb 2025 07:31:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: stephen@networkplumber.or, dev@dpdk.org
Subject: Re: [PATCH v2 00/16] net/zxdh: updated net zxdh driver
Message-ID: <20250224073147.1de6df5b@hermes.local>
In-Reply-To: <20250224061040.667005-1-wang.junlong1@zte.com.cn>
References: <20250221020346.494392-1-wang.junlong1@zte.com.cn>
 <20250224061040.667005-1-wang.junlong1@zte.com.cn>
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

On Mon, 24 Feb 2025 14:10:39 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> Hi maintainer,
>     Do these warnings need to be resolved?

These warnings do need to be resolved, but not necessarily a blocker for in=
clusing now.

>=20
>     The usage of this code is also supported by the standard C language,
No VLA is a GNU extension.

>     and other drivers also have this usage;
The DPDK maintainers are slowly eliminating them.

>=20
>     At the same time, why does the compilation still have [- Wvla] warning
>     when adding cflags +=3D no_wvla_cflag in zxdh meson.build

Right but MS C compiler does not support VLA's and VLA's not the whole tree
has been converted.

If you can fix it now, then that would be best. If not, then it will get
changed when other drivers are addressed.

>=20
>     Thanks
>=20
>     I will submit a new version that includes Enable assertions failed=E3=
=80=81
>     Enable address sanitizer for undefined checks=E3=80=81Extra memset an=
d cast,
>     and [RFC,0/5] net/zxdh: possible changes you submited.
>=20
>     and sorry for not modifying the cover scan and PVS issue in a timely =
manner.
>     I will make the necessary changes later
>=20
>=20
> >    =E2=9C=98 Enable extra warnings (edit meson.build) for
> >        -Wvla, -Wformat-truncation, -Waddress-of-packed-member
> >
> >[1600/3244] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_=
zxdh_queue.c.o
> >.../drivers/net/zxdh/zxdh_queue.c: In function =E2=80=98zxdh_dev_rx_queu=
e_setup_finish=E2=80=99:
> >.../drivers/net/zxdh/zxdh_queue.c:357:24: warning: ISO C90 forbids varia=
ble length array =E2=80=98new_pkts=E2=80=99 [-Wvla]
> >  357 |                 struct rte_mbuf *new_pkts[free_cnt];
> >      |                        ^~~~~~~~
> >[1603/3244] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_=
zxdh_rxtx.c.o
> >.../drivers/net/zxdh/zxdh_rxtx.c: In function =E2=80=98zxdh_recv_pkts_pa=
cked=E2=80=99:
> >.../drivers/net/zxdh/zxdh_rxtx.c:903:24: warning: ISO C90 forbids variab=
le length array =E2=80=98new_pkts=E2=80=99 [-Wvla]
> >  903 |                 struct rte_mbuf *new_pkts[free_cnt];
> >      |                        ^~~~~~~~
> >[1616/3244] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_=
zxdh_ethdev_ops.c.o
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c: In function =E2=80=98zxdh_dev_xs=
tats_get_names=E2=80=99:
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:1983:26: warning: =E2=80=98%s=E2=
=80=99 directive output may be truncated writing up to 1359 bytes into a re=
gion of size 64 [-Wformat-truncation=3D]
> > 1983 |                         "%s", zxdh_np_stat_strings[i].name);
> >      |                          ^~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:1982:25: note: =E2=80=98snprintf=
=E2=80=99 output between 1 and 1360 bytes into a destination of size 64
> > 1982 |                         snprintf(xstats_names[count].name, sizeo=
f(xstats_names[count].name),
> >      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1983 |                         "%s", zxdh_np_stat_strings[i].name);
> >      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:1989:34: warning: =E2=80=98%s=E2=
=80=99 directive output may be truncated writing up to 2991 bytes into a re=
gion of size 64 [-Wformat-truncation=3D]
> > 1989 |                                 "%s", zxdh_mac_stat_strings[i].n=
ame);
> >      |                                  ^~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:1988:33: note: =E2=80=98snprintf=
=E2=80=99 output between 1 and 2992 bytes into a destination of size 64
> > 1988 |                                 snprintf(xstats_names[count].nam=
e, sizeof(xstats_names[count].name),
> >      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1989 |                                 "%s", zxdh_mac_stat_strings[i].n=
ame);
> >      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:1994:34: warning: =E2=80=98%s=E2=
=80=99 directive output may be truncated writing up to 271 bytes into a reg=
ion of size 64 [-Wformat-truncation=3D]
> > 1994 |                                 "%s", zxdh_mac_bytes_strings[i].=
name);
> >      |                                  ^~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:1993:33: note: =E2=80=98snprintf=
=E2=80=99 output between 1 and 272 bytes into a destination of size 64
> > 1993 |                                 snprintf(xstats_names[count].nam=
e, sizeof(xstats_names[count].name),
> >      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1994 |                                 "%s", zxdh_mac_bytes_strings[i].=
name);
> >      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:2000:26: warning: =E2=80=98%s=E2=
=80=99 directive output may be truncated writing up to 339 bytes into a reg=
ion of size 64 [-Wformat-truncation=3D]
> > 2000 |                         "%s", zxdh_vqm_stat_strings[i].name);
> >      |                          ^~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:1999:25: note: =E2=80=98snprintf=
=E2=80=99 output between 1 and 340 bytes into a destination of size 64
> > 1999 |                         snprintf(xstats_names[count].name, sizeo=
f(xstats_names[count].name),
> >      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 2000 |                         "%s", zxdh_vqm_stat_strings[i].name);
> >      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:2010:41: warning: =E2=80=98%s=E2=
=80=99 directive output may be truncated writing up to 1359 bytes into a re=
gion of size between 54 and 58 [-Wformat-truncation=3D]
> > 2010 |                                 "rx_q%u_%s", i, zxdh_rxq_stat_st=
rings[t].name);
> >      |                                         ^~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:2009:33: note: =E2=80=98snprintf=
=E2=80=99 output between 7 and 1370 bytes into a destination of size 64
> > 2009 |                                 snprintf(xstats_names[count].nam=
e, sizeof(xstats_names[count].name),
> >      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 2010 |                                 "rx_q%u_%s", i, zxdh_rxq_stat_st=
rings[t].name);
> >      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:2022:41: warning: =E2=80=98%s=E2=
=80=99 directive output may be truncated writing up to 1291 bytes into a re=
gion of size between 54 and 58 [-Wformat-truncation=3D]
> > 2022 |                                 "tx_q%u_%s", i, zxdh_txq_stat_st=
rings[t].name);
> >      |                                         ^~
> >.../drivers/net/zxdh/zxdh_ethdev_ops.c:2021:33: note: =E2=80=98snprintf=
=E2=80=99 output between 7 and 1302 bytes into a destination of size 64
> > 2021 |                                 snprintf(xstats_names[count].nam=
e, sizeof(xstats_names[count].name),
> >      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 2022 |                                 "tx_q%u_%s", i, zxdh_txq_stat_st=
rings[t].name);
> >      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~ =20

I am not sure what causes this, it is likely that C compiler sees that the =
maximum possible value for i is quite
large and the stat_strings have large possible length. Not a big issue, but=
 worth looking at.
