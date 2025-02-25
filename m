Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D8C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 16:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3C5F40299;
	Tue, 25 Feb 2025 17:12:10 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 375054025E
 for <dev@dpdk.org>; Tue, 25 Feb 2025 17:12:09 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2211acda7f6so131387525ad.3
 for <dev@dpdk.org>; Tue, 25 Feb 2025 08:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740499928;
 x=1741104728; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMA8GJqnR3gQ29gRsWtxyoy28mw37RIzW7mXBVVXz/s=;
 b=XXMiIudBf592csXtkvd02qgX7y323N2VFboE8lpJIEvifyzAo3vSPbW0ZrOosN2NrE
 vfJhGLiW8jtBurOVpOPkCymDABHWU2fUjIZ4c6sJCyBaPahLzTdWH2C2S5MwERn86wLs
 zeIi8v/0UwrlbNjSoSVEJ96jJQWKMQVSMmlJUvGE/zsrQyG4qow03DVHugDWLDSawGEx
 0wEHLX4IOrVaxR9gM4NThH1nnAT91LvgdvGSlA0rpKnXmi9PkdQmDxxyLja8S2ad697u
 h8D+siGJrqrfWBIlnQwNTfO6XQl4mbrrOXrNa7QOaWFPxpMktZXefD0V5tq3uswJQINz
 lFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499928; x=1741104728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMA8GJqnR3gQ29gRsWtxyoy28mw37RIzW7mXBVVXz/s=;
 b=LgHZQiuoMDBB5RA/vpDfsWnC2h/cQ2sl2FocHrSqOkzsidQovbkVDgWlw01qRiZfJp
 7CyytuU+VHG/6/Xjsik42Mjkd4oe3UyQVtG/NHjAqzVZap/638c+atirlrAAfpmvJmUt
 RtmFTgFN/Z1tszCf8pVrw6ECPfSqf0Y+Pg3+S/emlWU4gjAhR4yjn9N93zsc5zguM8KQ
 Trm+ngm1BtGjPn/CP7zAuulcgxH7CRKEUiThKbsC1QkJ/Vif6bdAm8SAB68sPzRHCrD7
 B4X/iLeJD/kYV17zr17BoYDkn7g0rFMEpiP8drfPB6nEgKGuyba1Eic+kgqU1pYys4Wv
 0OYA==
X-Gm-Message-State: AOJu0YyF8OyIdnwK/lwwaXa0ldyCOUp9OvUtEPSR7+v7mw3F7f2N2wfR
 A8g//eL9kiBea7w7+RxfxP9MPGcyFu1OLDRktrVUrSGu4Exu2KOqPvKV8uMkhZAWB19N3BB8KVp
 NFUc=
X-Gm-Gg: ASbGncudPQ+/suTuLMg3l/bNLHyY+tqwTiVS2tbVRLQ+2wP+H5k3HEf9Q9QkKMjx7D2
 SHvc0fO29DYQ89RivTm7Wk7GLahlZsR63mHLwCEWLUA4xNW4Dt3mayNm5YAwZdE96g+nEkZnwl3
 grQ3fWaAp9/5fKyD4OxuunbcQkFIcUr5kxYBNVR5RSX6dTS0BJxRByrQjBOOcuJSVSN7jx39xEe
 BZkPj8ZqNUKFz0kFvTeN4Pz9TCFHuweR2f+dHCPLxNxBBw3TzLXLe154NzcQ5kUvhw7rbqNekUO
 nSNyW1sdox2WEkLDsIaNlXd4Z6py7Km/ycsne/wgESCbC4lczNalt8sjckai6LXKZIsWd4vEBwv
 OYso=
X-Google-Smtp-Source: AGHT+IHyAM/k4zEKy5cuscm1bHqDk7MOpGgxwdRzONJ9OAg9KPRi6DXn1Ihm3XUPs4TglEa1vLMVbA==
X-Received: by 2002:a17:902:e94c:b0:21f:f29:a421 with SMTP id
 d9443c01a7336-22320085412mr898395ad.10.1740499928336; 
 Tue, 25 Feb 2025 08:12:08 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a094511sm16182725ad.132.2025.02.25.08.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:12:08 -0800 (PST)
Date: Tue, 25 Feb 2025 08:12:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/16] net/zxdh: updated net zxdh driver
Message-ID: <20250225081206.68cc5fe1@hermes.local>
In-Reply-To: <20250225104311.732507-1-wang.junlong1@zte.com.cn>
References: <20250221020346.494392-2-wang.junlong1@zte.com.cn>
 <20250225104311.732507-1-wang.junlong1@zte.com.cn>
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

On Tue, 25 Feb 2025 18:42:52 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> V3:
>   - fix warning enable asserts compile.
>   - fix warning enable address sanitizer for undefined checks.
>   - modify extra memset and cast.
>   - remove __rte_unused from function prototypes.
>   - fix indentation in mtr get and use assign.
>   - make callback table const and static.
>=20
> V2:
>   - modify CI some error results(checkpatches warnings=E3=80=81Wrong head=
line format)
>   - fix warnings when enable extra warnings.
>   - modify apply memcpy script for coccinelle and unnecessary init and
>     unneccessary cast of void when use malloc.
>=20
> V1:
>   - updated net zxdh driver.
>     optimize init and some ops.
>     provided csum/lro/tso =E3=80=81extend stats=E3=80=81fw_version=E3=80=
=81module_info =E3=80=81meter, etc.
>=20
> Junlong Wang (16):
>   net/zxdh: optimize np dtb channel initialization
>   net/zxdh: optimize queue res alloc/free process
>   net/zxdh: optimize link update process
>   net/zxdh: update Rx/Tx to latest
>   net/zxdh: provided PF/VF msg intr callback
>   net/zxdh: optimize MAC ops
>   net/zxdh: optimize promisc ops
>   net/zxdh: optimize VLAN filter/offload ops
>   net/zxdh: optimize RSS/RETA hash config/update/get
>   net/zxdh: optimize MTU set ops
>   net/zxdh: optimize basic stats ops
>   net/zxdh: provided CSUM/TSO/LRO config
>   net/zxdh: provided rxq/txq info get implementations
>   net/zxdh: provide extended stats ops implementations
>   net/zxdh: provide ptypes FW version EEPROM ops
>   net/zxdh: provide meter ops implementations
>=20
>  doc/guides/nics/features/zxdh.ini  |   11 +
>  doc/guides/nics/zxdh.rst           |    5 +
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.c     |   49 +-
>  drivers/net/zxdh/zxdh_common.h     |    3 +
>  drivers/net/zxdh/zxdh_ethdev.c     |  725 ++++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev.h     |   67 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  918 ++++++++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   52 +-
>  drivers/net/zxdh/zxdh_msg.c        |  982 +++++++++++++++++++++-
>  drivers/net/zxdh/zxdh_msg.h        |  174 +++-
>  drivers/net/zxdh/zxdh_mtr.c        | 1223 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_mtr.h        |  114 +++
>  drivers/net/zxdh/zxdh_np.c         |  791 ++++++++++++++++--
>  drivers/net/zxdh/zxdh_np.h         |  264 ++++++
>  drivers/net/zxdh/zxdh_pci.c        |   10 -
>  drivers/net/zxdh/zxdh_queue.c      |  132 +--
>  drivers/net/zxdh/zxdh_queue.h      |  122 +--
>  drivers/net/zxdh/zxdh_rxtx.c       |  695 +++++++++-------
>  drivers/net/zxdh/zxdh_rxtx.h       |   33 +-
>  drivers/net/zxdh/zxdh_tables.c     |  378 +++++++--
>  drivers/net/zxdh/zxdh_tables.h     |  219 +++--
>  22 files changed, 6018 insertions(+), 950 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_mtr.c
>  create mode 100644 drivers/net/zxdh/zxdh_mtr.h
>=20

Applied to next-net and updated release note.
