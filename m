Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6512CE9A05A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 18:58:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45C4F402C6;
	Thu, 19 Feb 2026 19:58:51 +0100 (CET)
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com
 [209.85.219.66]) by mails.dpdk.org (Postfix) with ESMTP id C68B6402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 19:58:49 +0100 (CET)
Received: by mail-qv1-f66.google.com with SMTP id
 6a1803df08f44-8946e0884afso23182626d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771527529;
 x=1772132329; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZ7AKkGmaD+guHv7ol8bVRu6gb0pjbCGxjuvgdwAuSA=;
 b=bwV11T5kFAHOlJ7S3CCJJJXMTScuaRE15ZGH2+ktK+/1T3kh3Kl93ttUg7rhe/zHxw
 Vr26x8isL0FfnTlTFQK5J3Q4QLY9ATk2o42LR9r7VPAEuRA7ivqSXd8FR5kARYkhiHwL
 ojk2aHaevl4GqpuFYTmSpQaR6RvbLITuqkQzi6JtauW1J5fv4JIkNuTvFd+7cxL7lWSf
 0WuCy/Uz6kymKMZwbgeGlsDidGp1xU4dmbN57lWmwXrNKL/bsb20QCCkHdCurDEeDSCH
 S5QERP9eHlIRYOKa3DI6nvgjVfmmbQmqhXD1gEQVKx62QgR/W4TqPXkmg+7ulGY8nZ8r
 VSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771527529; x=1772132329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vZ7AKkGmaD+guHv7ol8bVRu6gb0pjbCGxjuvgdwAuSA=;
 b=i4yf/w6oQYmlWTStIw4vXQDOENQRifsodCsRt1A1MmSOBsuRf0VnICFgjfPcb5C6u/
 Pakh86cwC2SqykJaw/Uz/DSoCawse4C2UADY6MVzf9zbrb0JPdCvUDMoNWBkX4BG/y6G
 dqDYuYE4JbM/tUz6L8Q2gHNwczG+5EgKAKXlVA6KeUoq9vqAgrBlUVpbzrKlWRi9JCZ9
 9x0DJzEiXdLvEE8FSeBQIlgVpFU3Utm2EDgEaSM50Kxnzb1rQx0v28o4V5HCGqiMAlVd
 YV/6gNheq4RBSFXLE4/XSTUJ5h38+5tpSdSCiRu9tSCkw5zrjyA9A21Wlz7eVQFXqdpr
 0oPg==
X-Gm-Message-State: AOJu0YwOz0aaACGQpD8ch0MrMHQGFckl0iqKW44TM5bOu6E+lVaTEG7C
 ErK9ZO2hy+hj7VhgKEKfCUGNBjOL7QsGV17MEG+qUcLPn+u/kqNyk72PTMf29pZDfKs=
X-Gm-Gg: AZuq6aKgSCbTuHA8wLZmHRbLuiHlUEzpyl/s/q4io9H0IRFykAb/AavnaPUH1AmMc/5
 +ZZdEiHEzPpow73krtr+Hx0P9joS7Q1m12zL5kTKdXZIN7Q+rK0rtOh+TtKckihyadrPEkFQE/V
 zYTIGv1Fk89So0tEU2uKlScDdFvM2ACAabWp42RenAyuXw+5Qy9tDrxMvmBNZV3/0exN1EPmpbM
 W7CYWvvfq4IRyGrCydyz0pzDeNBNED5pQxhtDVeL2JGLd9Ybf/WOIaTtwua1yxVYdQqme+pQrgp
 cI0Ri7OBDi73CtIydH0oJSj/Hi8Uijo2TyNMKYLd89hxlQSqhVByuuKmyH+8NLXLS5fIt5DUUQU
 T9rOBuKDp2W5eoZaRsqVeKSbVPqp0NXdpXuctvJHBkth5i94ufhVn9S0GW8VcGf0BwHBBWqBLWL
 MOppvVFBLXa3mvZyHKJS86dY3KrnPpsHbfdItMI2Jm7K848hdL0pNsz1Nq/jlkluj7
X-Received: by 2002:ad4:5dee:0:b0:890:7fc7:8837 with SMTP id
 6a1803df08f44-8974030af62mr293855246d6.19.1771527528971; 
 Thu, 19 Feb 2026 10:58:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b1c883dsm2073918685a.32.2026.02.19.10.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 10:58:48 -0800 (PST)
Date: Thu, 19 Feb 2026 10:58:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: Re: [PATCH 1/8] net/cnxk: support of plain packet reassembly
Message-ID: <20260219105845.42a54e18@phoenix.local>
In-Reply-To: <20260219090847.3257753-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
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

On Thu, 19 Feb 2026 14:38:40 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
>=20
> Adds support of plain packet reassembly by configuring
> UCAST_CPT rule.
>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---

Automated review found these issues to address.

Patch 1/8: net/cnxk: support of plain packet reassembly

&dev->rqs[i] can never be NULL =E2=80=94 it's an array offset. The NULL che=
ck
should be on eth_dev->data->rx_queues[i] instead, which is used
immediately after without any guard.

If roc_nix_inl_dev_rq_get() or
roc_npa_buf_type_update() fails mid-loop, RQs obtained in prior
iterations are never released via roc_nix_inl_dev_rq_put().

cnxk_nix_ip_reass_rule_set() returns -EIO on all error paths,
discarding the actual rc. The mcam_write_failed label also overwrites
rc with the result of roc_npc_mcam_free(), losing the original write
error.=20

Missing co-developer Signed-off-by (sent by Rahul, From Rakesh).

Patch 2/8: net/cnxk: support IPsec Rx inject for cn20k

sa_base &=3D ~0xFFFFUL is inside the per-packet loop but only matters on
the first iteration. Should be hoisted before the loop for clarity.

Release notes: "CN20k Soc" should be "CN20K SoC" to match patch 1.

Patch 8/8: common/cnxk: enable CPT CQ for inline IPSec inbound

nix_inl_cpt_cq_inb_setup(): if cpt_lf_register_irqs() fails, the CQ
from cpt_lf_cq_init() on that LF is not cleaned up, and prior
successfully-setup LFs may have inconsistent state during the error
path teardown.

Unnecessary cast of void * to struct roc_cpt_lf * in nix_inl_cpt_done_irq().
