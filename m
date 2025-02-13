Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA9EC021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 17:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45D9C42ED7;
	Thu, 13 Feb 2025 18:17:34 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7AF5542EB1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 18:17:33 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f6d2642faso29500145ad.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 09:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739467052;
 x=1740071852; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xb6iS8WQXm2UTvDtrj/uiMbQEGlOr83XbspMEIdMqM4=;
 b=2CiuD38DG/wSaLwVlpPAMfd5RZPUb31sqJblsUG9JaKWEeBMve/nYKjo4I8VRvY6+r
 SF3JpSQ8a8a76KErbZmTdXfao34Sht88o612Z0FnvpLTOMGxov229Nd0KdiOURcIkQMf
 h8VRJoYYOzzdiJsF+NuL9LxBE/FSqaPKMnUhiokCZhKY8esNZKQdKjg6qJn1S7AMPoEq
 G7Fb4gyfH9W3NKamjdAfxd38Z5mry0+VjxOaTtvIW4lJGbOIFU/3pVvz5BojYpW1Kc7E
 fEdb+RZRM5WZ40czj1P9iSIGAD07RmasNw7b6Cr7hniFyq1X+FUCGjSmFzbDukr/Bn38
 sykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739467052; x=1740071852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xb6iS8WQXm2UTvDtrj/uiMbQEGlOr83XbspMEIdMqM4=;
 b=noIy7giWva5v7NIfI5g2yqDQ6is/g//nroW7NxOa4vY1heCBcmNBugAMpuFRRI8QC6
 0Q2UJarRFGKvgwKfYIOvReGChGqmb19JBW5ws/GXaqAXk0XBbmcKdZyisBxsBRL8r1MQ
 CjfxsmObXL/ROKTcDODwjbDDkCgvPLrwp7mQD5Z1lrMk8DHQ8pk9uX18P/ed1TowAJvy
 SqfiB1XRCxXOLWKLIs+drPucxrLS8LZIyzLJiTr3iyGEmCaStPsUJ/ac5mIdcPzk5wfE
 BqDivjtMw/b3jSMxjC4QoNBLzctPCoS0AEVIy4KxR4qSahE24o+FV+bNVpH/8DuOOrYH
 /5gQ==
X-Gm-Message-State: AOJu0YzBVQBUpSV+UzImZYJU+CYm41W10Ep0H75wVn984bluV8lzOB8i
 3Xl6nNkk+ys+UHNMgIejYFTUTCBsXxxFAFSl+LSSqrM593eA2y8WNvsVXhxl0Qw=
X-Gm-Gg: ASbGncuFsyHBB4eh0Ge6vlYrE8aOsdTG1zyCGx8Z1xnsNfZ/mMV+16+cwjbjDzwv3SB
 VmJ0jgsp6IraFpelvw3BkSxYxctaW+/hc/LLXfiPcxZuzKGGIePN0z0pM21sQllN8+pPuy1BCi9
 Y/O9ZaMy+4UzOIBbrM/hTy2DOsyj3ClRYV9Pix1JVxUUGRjsDlnKpP17k3VmwYWf9EaBlm9rYR9
 Yfi3tNHFJmR54UFeIWp0OnThAUcPrMW7yjhIZRlk/wwECafQRqj2B5n9mXBPtVUme64HAgyi9vU
 IY1Wd5Jn5bWqNyKWwOr3Oms7HBRch/Nh6KPLwpLQ2iwvkAZoo4Ov2h3BKuwpToLA+/ko
X-Google-Smtp-Source: AGHT+IG5Se8/e87zJCHZqWB/EZf24ARi37we95OzKAlP6IeFJk7QIdzDXES8pfyFGZFOmaKE/fdkPA==
X-Received: by 2002:a17:902:e946:b0:215:e98c:c5bc with SMTP id
 d9443c01a7336-220bbc77f99mr145648465ad.48.1739467052552; 
 Thu, 13 Feb 2025 09:17:32 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d3b1sm14841535ad.163.2025.02.13.09.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 09:17:31 -0800 (PST)
Date: Thu, 13 Feb 2025 09:17:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/16] net/zxdh: updated net zxdh driver
Message-ID: <20250213091729.7a4b807c@hermes.local>
In-Reply-To: <20250213064134.88166-1-wang.junlong1@zte.com.cn>
References: <20250121034433.3033681-2-wang.junlong1@zte.com.cn>
 <20250213064134.88166-1-wang.junlong1@zte.com.cn>
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

On Thu, 13 Feb 2025 14:41:16 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

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
>   net/zxdh: update rx/tx to latest
>   net/zxdh: provided msg(pfvf) intr callback
>   net/zxdh: optimize mac ops
>   net/zxdh: optimize promisc ops
>   net/zxdh: optimize vlan filter/offload ops
>   net/zxdh: optimize rss hash config/update,reta update/get
>   net/zxdh: optimize mtu set ops
>   net/zxdh: optimize basic stats ops
>   net/zxdh: provided csum/tso/lro config
>   net/zxdh: provided rxq/txq info get implementations
>   net/zxdh: provide extended stats ops implementations
>   net/zxdh: provide ptypes fw_version module info/eeprom ops
>   net/zxdh: provide meter ops implementations
>=20
>  doc/guides/nics/features/zxdh.ini  |    8 +
>  doc/guides/nics/zxdh.rst           |    5 +
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.c     |   48 +-
>  drivers/net/zxdh/zxdh_common.h     |    3 +
>  drivers/net/zxdh/zxdh_ethdev.c     |  660 ++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev.h     |   63 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  906 ++++++++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   53 +-
>  drivers/net/zxdh/zxdh_msg.c        |  940 ++++++++++++++++++++-
>  drivers/net/zxdh/zxdh_msg.h        |  112 ++-
>  drivers/net/zxdh/zxdh_mtr.c        | 1223 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_mtr.h        |  114 +++
>  drivers/net/zxdh/zxdh_np.c         |  728 +++++++++++++++++
>  drivers/net/zxdh/zxdh_np.h         |  262 ++++++
>  drivers/net/zxdh/zxdh_pci.c        |   10 -
>  drivers/net/zxdh/zxdh_queue.c      |  132 +--
>  drivers/net/zxdh/zxdh_queue.h      |  118 +--
>  drivers/net/zxdh/zxdh_rxtx.c       |  696 +++++++++-------
>  drivers/net/zxdh/zxdh_rxtx.h       |   27 +
>  drivers/net/zxdh/zxdh_tables.c     |  378 +++++++--
>  drivers/net/zxdh/zxdh_tables.h     |  206 +++--
>  22 files changed, 5890 insertions(+), 803 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_mtr.c
>  create mode 100644 drivers/net/zxdh/zxdh_mtr.h

Did you look at outstanding Coverity issues?

https://scan4.scan.coverity.com/#/project-view/65610/10075?selectedIssue=3D=
456598
