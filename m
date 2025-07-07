Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667AEC83030
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 03:33:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CF584025D;
	Mon,  7 Jul 2025 05:33:01 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id D87FD4021E
 for <dev@dpdk.org>; Mon,  7 Jul 2025 05:32:59 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6fad4e6d949so15828736d6.0
 for <dev@dpdk.org>; Sun, 06 Jul 2025 20:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751859179;
 x=1752463979; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwvw7oemA7z3wDYd+s8YchxshwysdzubQRiQLcP7/As=;
 b=vUyEj3wH8oRPDpwPfWQac8DBeUNZg0dMyRuP2LfveY+fgGLh3YXVXsQKxb5STHUqHd
 Ps+ZeuoAHOKIqceQVd5zvNhZTc3wFzJ1NpU3Ij2GZzaYIwQUl6qefacGuXL3I5X1eBvT
 ZZwGV8GeKx2028+uSEHFn39+bVbuhWU5LJLsHpMhQ+bWM/ftHkaDNtY1yFG9wEpcOxXF
 4GzotKcV0TjmvZFgPxpuM1h5EzGPb0jxLUloDMON1zrWqaEzZzX/o4/DQZYNQz9d8JNB
 A66TvSB8W6Ps8Hg9/3CSytBzIDktjpj3Ui0uSHTBNvZVrlyVhyq5jEgAYN8YB5UnXLO5
 G5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751859179; x=1752463979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwvw7oemA7z3wDYd+s8YchxshwysdzubQRiQLcP7/As=;
 b=eEC1dy1GklCtfRGMUTmo0HVL0BtO5Mu3sQ8u4sOYaYVGZX3tNMRrcZ+t+7A3/gxeGS
 dJ5loyI0UwdhrSvhX/yZoU8jgBN9Cf9Nb/RdEHTzgG9pUagDsXtfBAap9+pIEZt2Uwqa
 ndbIUTilb2Qz2xnTgCe0UUTOa2GS+uRA/NjiMwLK+vWXAaXjveI+QKZzblENxvJRQrgk
 8kZe/c/YRqiqFM1SLB6j705aNSb4tmxOTYm9qSmIjvvcBd1uXOMkSJ9FwbYhxepNxP/Z
 3rbMYNnGaoitXOTfwEUOR+QTfsWBxI7nIILcA8N7eHSg7klzqTtElnDHH9tqg6v9JcSD
 HLQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIVYE7KdkjONN4xRnydhmuj54oFJUgGvz4XdgL5nh01m9VE6Ie5KUida4txWSeOArFsTU=@dpdk.org
X-Gm-Message-State: AOJu0YxZWg1y7GNgqAHUK+06Uqt2QT9j0UPkbr0wcnGHUCeurb+TY26P
 NZs2MUdQY+qeN8Xee4MVm5sWJlSs8pN29mALEUIe4SzIUrg6VmAOTkAOv69pJL5YNpo=
X-Gm-Gg: ASbGncsruGoS7en99wudccUBGvG+LHr71sFw3b8WSKy6p3anLpgB9UcGtOZJqDq7phB
 eC0NKCkc8HRzZR2uJa0JRiEjJtIOfKdM4tRjZUqHYLxcxOc1qSzIBdZD/cr3zo4IJh09JtgbwKG
 CNBTx01+RWVE7rP3SCNjk7lthAyGpRVveptjQYLVSyKZrqm+KH2AATJ4HXKBck1LaVL0gKv3LDE
 cw4jGhzE9ZWztr28MX9dGryYa0guVF0Iqpn5LT3c7pWG13XKplZSGktP1ycbZdM301BlXm4Hoch
 5eqCMPGZfj4txKo/3qdh0ZcDruddf5y87e0iz0FIix3BYaN5TfZfr53VjwDPMR6T3oXLwz9FL4E
 tMXbpRHXt/LBeOCwZJzqak6NwJg8JEcn1e2ezGmk=
X-Google-Smtp-Source: AGHT+IFKb2ThCCckB22V7UUzU5XFGXt/42af7HJ5rXll5/jxorxpeNi5wzV4zujziIOqLLga9UO0CA==
X-Received: by 2002:ad4:5cc2:0:b0:6fa:fb4f:b582 with SMTP id
 6a1803df08f44-702c8b723c3mr144512916d6.6.1751859179017; 
 Sun, 06 Jul 2025 20:32:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbe91380sm538053385a.95.2025.07.06.20.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 20:32:58 -0700 (PDT)
Date: Sun, 6 Jul 2025 20:32:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "wangfeifei (J)" <wangfeifei40@huawei.com>
Cc: Feifei Wang <wff_light@vip.163.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "chenyi (CY)" <chenyi221@huawei.com>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= [V5 00/18] add hinic3 pmd driver
Message-ID: <20250706203255.7e603de7@hermes.local>
In-Reply-To: <75071e071e8246588a27220674027b95@huawei.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250702020953.599-1-wff_light@vip.163.com>
 <20250702075537.4c497901@hermes.local>
 <75071e071e8246588a27220674027b95@huawei.com>
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

On Mon, 7 Jul 2025 03:27:20 +0000
"wangfeifei (J)" <wangfeifei40@huawei.com> wrote:

> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Stephen Hemminger <stephen@networkplumber.or=
g>=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=882=E6=97=A5 2=
2:56
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Feifei Wang <wff_light@vip.163.com>
> =E6=8A=84=E9=80=81: dev@dpdk.org; chenyi (CY) <chenyi221@huawei.com>
> =E4=B8=BB=E9=A2=98: Re: [V5 00/18] add hinic3 pmd driver
>=20
> On Wed,  2 Jul 2025 10:09:23 +0800
> Feifei Wang <wff_light@vip.163.com> wrote:
>=20
> > From: Yi Chen <chenyi221@huawei.com>
> >=20
> > The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver=20
> > support for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> >=20
> > v5:
> > - solve hinic3.ini unknown feature issue
> >=20
> > V4:
> > - solve patch application conflict issue
> >=20
> > V3:
> > - Fix checkpatchs error issue
> >=20
> > v2:
> > - modify CI compile errors
> >=20
> > V1:
> > - modify community comments and compile issues
> > - remove the compilation flags in the meson build
> > - remove (void) cast
> > - remove "BLURE HERE ***" in cover letter
> >=20
> > RFC:
> > - add hinic3 pmd driver code, modify the driver code to adapt to Huawei=
 SPx series network cards.
> >=20
> > Feifei Wang (2):
> >   net/hinic3: add dev ops
> >   net/hinic3: add Rx/Tx functions
> >=20
> > Xin Wang (7):
> >   net/hinic3: add basic header files
> >   net/hinic3: add support for cmdq mechanism
> >   net/hinic3: add NIC event module
> >   net/hinic3: add context and work queue support
> >   net/hinic3: add device initialization
> >   net/hinic3: add MML and EEPROM access feature
> >   net/hinic3: add RSS promiscuous ops
> >=20
> > Yi Chen (9):
> >   add some basic files to describe the hinic3 driver.
> >   net/hinic3: add hardware interfaces of BAR operation
> >   net/hinic3: add eq mechanism function code
> >   net/hinic3: add mgmt module function code
> >   net/hinic3: add module about hardware operation
> >   net/hinic3: add a NIC business configuration module
> >   net/hinic3: add a mailbox communication module
> >   net/hinic3: add FDIR flow control module
> >   drivers/net: add hinic3 PMD build and doc files
> >=20
> >  .mailmap                                   |    4 +-
> >  MAINTAINERS                                |    6 +
> >  doc/guides/nics/features/hinic3.ini        |   61 +
> >  doc/guides/nics/hinic3.rst                 |   51 +
> >  doc/guides/nics/index.rst                  |    1 +
> >  doc/guides/rel_notes/release_25_07.rst     |    4 +
> >  drivers/net/hinic3/base/hinic3_cmd.h       |  231 ++
> >  drivers/net/hinic3/base/hinic3_cmdq.c      |  978 +++++
> >  drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
> >  drivers/net/hinic3/base/hinic3_compat.h    |  266 ++
> >  drivers/net/hinic3/base/hinic3_csr.h       |  108 +
> >  drivers/net/hinic3/base/hinic3_eqs.c       |  721 ++++
> >  drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
> >  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  240 ++
> >  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  121 +
> >  drivers/net/hinic3/base/hinic3_hw_comm.c   |  452 +++
> >  drivers/net/hinic3/base/hinic3_hw_comm.h   |  366 ++
> >  drivers/net/hinic3/base/hinic3_hwdev.c     |  573 +++
> >  drivers/net/hinic3/base/hinic3_hwdev.h     |  177 +
> >  drivers/net/hinic3/base/hinic3_hwif.c      |  779 ++++
> >  drivers/net/hinic3/base/hinic3_hwif.h      |  142 +
> >  drivers/net/hinic3/base/hinic3_mbox.c      | 1399 +++++++
> >  drivers/net/hinic3/base/hinic3_mbox.h      |  199 +
> >  drivers/net/hinic3/base/hinic3_mgmt.c      |  392 ++
> >  drivers/net/hinic3/base/hinic3_mgmt.h      |  121 +
> >  drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1828 +++++++++
> >  drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1527 ++++++++
> >  drivers/net/hinic3/base/hinic3_nic_event.c |  433 +++
> >  drivers/net/hinic3/base/hinic3_nic_event.h |   39 +
> >  drivers/net/hinic3/base/hinic3_wq.c        |  148 +
> >  drivers/net/hinic3/base/hinic3_wq.h        |  109 +
> >  drivers/net/hinic3/base/meson.build        |   50 +
> >  drivers/net/hinic3/hinic3_ethdev.c         | 3866 ++++++++++++++++++++
> >  drivers/net/hinic3/hinic3_ethdev.h         |  167 +
> >  drivers/net/hinic3/hinic3_fdir.c           | 1394 +++++++
> >  drivers/net/hinic3/hinic3_fdir.h           |  398 ++
> >  drivers/net/hinic3/hinic3_flow.c           | 1700 +++++++++
> >  drivers/net/hinic3/hinic3_flow.h           |   42 +
> >  drivers/net/hinic3/hinic3_nic_io.c         |  828 +++++
> >  drivers/net/hinic3/hinic3_nic_io.h         |  169 +
> >  drivers/net/hinic3/hinic3_rx.c             | 1099 ++++++
> >  drivers/net/hinic3/hinic3_rx.h             |  356 ++
> >  drivers/net/hinic3/hinic3_tx.c             | 1028 ++++++
> >  drivers/net/hinic3/hinic3_tx.h             |  315 ++
> >  drivers/net/hinic3/meson.build             |   33 +
> >  drivers/net/hinic3/mml/hinic3_dbg.c        |  171 +
> >  drivers/net/hinic3/mml/hinic3_dbg.h        |  160 +
> >  drivers/net/hinic3/mml/hinic3_mml_cmd.c    |  375 ++
> >  drivers/net/hinic3/mml/hinic3_mml_cmd.h    |  131 +
> >  drivers/net/hinic3/mml/hinic3_mml_ioctl.c  |  215 ++
> >  drivers/net/hinic3/mml/hinic3_mml_lib.c    |  136 +
> >  drivers/net/hinic3/mml/hinic3_mml_lib.h    |  276 ++
> >  drivers/net/hinic3/mml/hinic3_mml_main.c   |  167 +
> >  drivers/net/hinic3/mml/hinic3_mml_queue.c  |  745 ++++ =20
> > drivers/net/hinic3/mml/hinic3_mml_queue.h  |  256 ++
> >  drivers/net/hinic3/mml/meson.build         |   45 +
> >  drivers/net/meson.build                    |    1 +
> >  57 files changed, 25926 insertions(+), 1 deletion(-)  create mode=20
> > 100644 doc/guides/nics/features/hinic3.ini
> >  create mode 100644 doc/guides/nics/hinic3.rst  create mode 100644=20
> > drivers/net/hinic3/base/hinic3_cmd.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_csr.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h
> >  create mode 100644 drivers/net/hinic3/base/hinic3_wq.c
> >  create mode 100644 drivers/net/hinic3/base/hinic3_wq.h
> >  create mode 100644 drivers/net/hinic3/base/meson.build
> >  create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
> >  create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
> >  create mode 100644 drivers/net/hinic3/hinic3_fdir.c  create mode=20
> > 100644 drivers/net/hinic3/hinic3_fdir.h  create mode 100644=20
> > drivers/net/hinic3/hinic3_flow.c  create mode 100644=20
> > drivers/net/hinic3/hinic3_flow.h  create mode 100644=20
> > drivers/net/hinic3/hinic3_nic_io.c
> >  create mode 100644 drivers/net/hinic3/hinic3_nic_io.h
> >  create mode 100644 drivers/net/hinic3/hinic3_rx.c  create mode 100644=
=20
> > drivers/net/hinic3/hinic3_rx.h  create mode 100644=20
> > drivers/net/hinic3/hinic3_tx.c  create mode 100644=20
> > drivers/net/hinic3/hinic3_tx.h  create mode 100644=20
> > drivers/net/hinic3/meson.build  create mode 100644=20
> > drivers/net/hinic3/mml/hinic3_dbg.c
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.h
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.c
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.h
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_ioctl.c
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.c
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.h
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_main.c
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.c
> >  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.h
> >  create mode 100644 drivers/net/hinic3/mml/meson.build
> >  =20
>=20
> Given the release roadmap, any new drivers need to be for 25.11 release n=
ow.
> Marked as deferred for review after this release.
>=20
> [Feifei] Thanks for the remind. Have 2 questions:
> 1. if this is for all new drivers will be deferred, or due to hinic3 driv=
er is not prepared, so it is deferred?
> 2. before 25.11 release, if hinic3 can fix all comments, it can be sure t=
o be merged?=20

The 25.07 release has reached the bugfix only stage.
Will finish review and put in next-net next week (13 July 2025)
