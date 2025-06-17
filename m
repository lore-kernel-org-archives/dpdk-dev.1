Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CBC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E336A40E5E;
	Tue, 17 Jun 2025 15:39:43 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 417A740E3E
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:39:42 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7d21cecc11fso1079582885a.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750167581;
 x=1750772381; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/81qBmpzNOAbVn4QXWEnM9him1B4BxtQA+a9IyyJpo=;
 b=ZfpapVLfp2d/QmBzLL9cPFQfB8acVcdG0jcxgrad/uFss1WQfhZgM4LyGbz8StmtEk
 QzvC2p8EHkeAOdqNivoMsFdErWONu1janN33vjXEMt1/X9/C1pD9oLwmPeC3kGvEiJ4I
 4CM0O3op+nal06ePypLW/6DPvhOjGNajdwUPNPACDWASpt6KS61WklEbDRSATe0ticii
 msqKe78e6+HpieCsJpY//JTkuk0WEEF9Msn2/59qi6Te05zsF31cLYsV2pNg7KhMNYfo
 AoiByon6gy9b718tV5WHivubnYv85syEvO9r36WoqxI0AR4LkTYYw/+qmKISw31k2Dhn
 5/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750167581; x=1750772381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/81qBmpzNOAbVn4QXWEnM9him1B4BxtQA+a9IyyJpo=;
 b=FbfvzbEsv5LBR3R2T/h4ly4rK7UIfYNzl+B5RqcUnxqwRjLRxBvblgsMmhzxBK7O33
 O/WT1OCr1AHBvajyZv/Jl03TZ8nK4nsHz/cPa7VRC1UNYHkfnRd1cLaoI4kbdPH+zIH7
 15UOuQ/eMkq+j33s/ke4qn0WmNnq9bzlM3+mIPXZaSLwjYfzelv0UeTAElJGwXf9Z0Cd
 MldywDK/XJ+gO8vP5PSKkVPhijKjiBDfn/MaiptHuyt6kLzPvh06veVmHjmypdzYuy1V
 AeGN5/92eY7wDP7Rc8sorQ7QPOT/yKtOsoq0ddGiYmhNKsarVQuTBC8TAkiCxMWIZvoA
 VZvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWwk3qPI1dOuzNYGgsKdcdy3uxt3N+KPugrRoZ4IqJAb3iXPfsSDHLRJjj1IEQ6+qg2nQ=@dpdk.org
X-Gm-Message-State: AOJu0YwgoRcqWTLSHv373TfSnd+jygLKinBr/kom9Zc6xBUVMf/5OLBK
 fSUVC1vdo9G9Tei1MsuGRQ5MV3dF8SPvTtuK0y4+wr9HZNT5KGIcxjJmqy8fUYQ0Nn4=
X-Gm-Gg: ASbGnctKTDHGUaJJpNdQwMAz1jHP6tIyrw/ZRTQxa0rtglKOECaP9cX6+IqktGWDaCU
 Qk3SFqeDLWPPal2l2rJLCXn8vkqJpHSLi9i3X+0a72LriNR+PWb2iizzgn/xnw/snZF6NMj50lL
 yRlIQ44CcqHduURuPPf50/++0JaIrJGuQHZ7E7aTWUEr2sfRNiBLfvSYAaxgtfuJIcN42aYNcK0
 mFLe/WCBR1HDME4C2cCTCswbqQPZpx2wqlDabH39eTuAQylPZJTW6h/m2yi7Qf4guhQZarSKipL
 ieKZLYVaIrhm0FZ67kcJpxTtCQz1y/TZnILU3P0e8At/cHInrmXSBQEKoy3lHD8xlcoq2okWwlx
 Jg/Cczq57TBlT/0lIRdxg9mi2wx5StrYPozCTQdI=
X-Google-Smtp-Source: AGHT+IEwJfcf0u19UKak0B7GATNcUPI9O4ue6U0xXb/bhsPESDjgRhtSsCSTrjzz1MgIL9YKbiDZGQ==
X-Received: by 2002:a05:620a:1911:b0:7d3:914b:abe5 with SMTP id
 af79cd13be357-7d3c6cca860mr2439667785a.37.1750167581269; 
 Tue, 17 Jun 2025 06:39:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb561aa7bcsm22198316d6.30.2025.06.17.06.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 06:39:41 -0700 (PDT)
Date: Tue, 17 Jun 2025 06:39:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1 1/1] net/zxdh: add support flow director ops
Message-ID: <20250617063936.1acc52f7@hermes.local>
In-Reply-To: <20250617063608.3564103-1-chen.bingbin@zte.com.cn>
References: <20250617063608.3564103-1-chen.bingbin@zte.com.cn>
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

On Tue, 17 Jun 2025 14:36:04 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> Provide support for ETH, VLAN, IPv4/IPv6, TCP/UDP, VXLAN, and mask matchi=
ng,
> supporting multiple actions include drop/count/mark/queue/rss,and vxlan d=
ecap/encap.
>=20
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>
> ---
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.h     |    1 +
>  drivers/net/zxdh/zxdh_ethdev.c     |   27 +
>  drivers/net/zxdh/zxdh_ethdev.h     |   13 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |    2 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |    1 +
>  drivers/net/zxdh/zxdh_flow.c       | 2004 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_flow.h       |  237 ++++
>  drivers/net/zxdh/zxdh_msg.c        |  263 +++-
>  drivers/net/zxdh/zxdh_msg.h        |   31 +-
>  drivers/net/zxdh/zxdh_np.c         | 1664 +++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_np.h         |   42 +-
>  drivers/net/zxdh/zxdh_tables.h     |   10 +-
>  13 files changed, 4224 insertions(+), 72 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_flow.c
>  create mode 100644 drivers/net/zxdh/zxdh_flow.h

Newer versions of Gcc complain about this intialization.

FAILED: drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_flow.c.o=20
gcc -Idrivers/libtmp_rte_net_zxdh.a.p -Idrivers -I../drivers -Idrivers/net/=
zxdh -I../drivers/net/zxdh -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I=
../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/=
eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x8=
6/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal=
 -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib=
/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mb=
uf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -I=
lib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../driver=
s/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/=
vdev -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-=
pch -Wextra -Werror -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual =
-Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-decla=
rations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpoin=
ter-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-p=
acked-not-aligned -Wno-missing-field-initializers -fzero-init-padding-bits=
=3Dall -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -=
DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-member -D=
RTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.zxdh -MD -MQ drivers/libtmp_rte_net_zxdh.=
a.p/net_zxdh_zxdh_flow.c.o -MF drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_flow.c.o.d -o drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_flow.c.o -c .=
./drivers/net/zxdh/zxdh_flow.c
../drivers/net/zxdh/zxdh_flow.c: In function =E2=80=98fd_flow_parse_pattern=
=E2=80=99:
../drivers/net/zxdh/zxdh_flow.c:1469:40: error: initializer-string for arra=
y of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destinati=
on lacks =E2=80=98nonstring=E2=80=99 attribute (4 chars into 3 available) [=
-Werror=3Dunterminated-string-initialization]
 1469 |                                 .vni =3D "\xff\xff\xff",
      |  =20
