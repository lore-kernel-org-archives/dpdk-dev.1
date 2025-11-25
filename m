Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC6D0E6FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 543284066E;
	Tue, 25 Nov 2025 16:28:05 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 790E740615
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:28:03 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so2605330b3a.2
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084482;
 x=1764689282; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tidwzHcokAsabk/KOVy8CUmVMZ1EMRHoFASPf1k62BM=;
 b=P2MD61gWgfw4Ec3PWAgwSc4qQSBS2g/+f0jdzws8sn3gZqzqItoH/dEcn70Vl8qMXf
 QcN+aIL8UxuYPs//XXyBCyEHYUdQzLROtj/s7lH7042UJWibW3zWy5SJ2/I9Wl0y9Qjl
 6Lfrq00DlvbqEx+/Sak3ucN11Qm1xwDZE69wpn/NW0bgW9+UJF0Te2NuS1U7opowBoCR
 vfuHqAbHxtFJ0RS+xbo4riWTDNeTArni3TxyXItn465W7O6xA9cstHF8ly0/c5REBN3C
 PxuPkCWpqWiOfdvQDI6O4xAZM4Tqf+vQIXmihb9l8hSpQDSq4XI2F86t8i00v27hbwQ3
 Ihng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084482; x=1764689282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tidwzHcokAsabk/KOVy8CUmVMZ1EMRHoFASPf1k62BM=;
 b=ahNLWwjYVDlxnusWjXx2rdHwNaHRDXTHhjxsvyxqOZ7+JFrkYAtPM0OMjWBagSa0vm
 GKBps9bl+FmkPtWkcpIeCM4o+0fdgEczygqByLYcDKooBygc5VXlQvpZKh9W63fUAJB7
 LW+iKB8XttFysa/SsONHjjJIOJsr+pxeQH6fJCJheJNHp4JvH1GXB5Jr+NcedRwQFMeo
 eliuPzwuePf6dHMusHoXmIbZ1H1KS4geWn9cZWi5NhZOz7yfZwM+vP//fvWGkHhYLP67
 BmE/vu0AfmQhPOiCXT0uRyVcO9cvQzYGcwdG1di1xRYmFyMTUJJtH5ALrckmA/CqK5aY
 HZ0Q==
X-Gm-Message-State: AOJu0YzyO9dikZ4QOJT5frKf3y2vsneSi+O6UvRV7YLPnHAHaQz1JsuJ
 57LVVdTEJR8SGczx+/BDxprIln20i98AGwBowEStAkBeRV5XyKQ1NyQrbhKAYiVmcKJCmo7j9+Y
 CkTyP
X-Gm-Gg: ASbGncsP0nKLIWwHfD1YgJAU8SJHqmehcEPkfeGQarwCUbbFtHm2J2mQQSBjb835pgH
 ScHYdlCpTNbJRApsz8/M9Bb5xRX1VlE8FtIN4a3qv3U82PX+4NOQq/TVwF6JJLRDyASg1h/7hUK
 kqkxoC4fMBjzxRE8gs01xeRtdrCAOdAmfrOYAIt+v4DkjhGAIaC+DGCd1la8Fp2TCEO3jOhkoi7
 vXX9D23ZJX2ey+VJ8XiWkehqS3Rv4XFLnZaBvTyxbp1ap6/UOnzrGL7fQVS1B5uez3Hf8tNTnHr
 RJLR2oIOV/eWbIQTKRlqw7LWnMHBMyHOwczKUDWbjSGo5vTJdAjMe3xKiv6OpRavvU2GcoZ5g+j
 XKGtY5jrMTOe70uAhL2NrZwyRNFlAUOcQnaopx5+duT4YNk77NecCKUfDU2F4joUYRfGE9O3U9k
 DD7vfK0iDhZiBSgjMk/d0Pfz5lnxUtgUr98iTP7w==
X-Google-Smtp-Source: AGHT+IGPFP1cxsDHxBUlr3lEpQq6QW4cvhwrHkHdE+DcVeBP9UV0WSWem0/+nWoklGXsX1Wo9uTNKQ==
X-Received: by 2002:a05:7022:ff47:b0:119:e55a:9c00 with SMTP id
 a92af1059eb24-11cbba535a2mr1973004c88.28.1764084482239; 
 Tue, 25 Nov 2025 07:28:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11cc631c236sm11792200c88.7.2025.11.25.07.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:28:01 -0800 (PST)
Date: Tue, 25 Nov 2025 07:27:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Dimon" <dimon.zhao@nebula-matrix.com>
Cc: "dev" <dev@dpdk.org>, "Kyo Liu" <kyo.liu@nebula-matrix.com>, "Leon"
 <leon.yu@nebula-matrix.com>, "Sam" <sam.chen@nebula-matrix.com>
Subject: Re: =?UTF-8?B?5Zue5aSN77yaW1BBVENI?= v1 1/1] net/nbl: add VLAN
 offload set interface
Message-ID: <20251125072758.37b8b100@phoenix.local>
In-Reply-To: <c28f7d63-7af2-4b48-9c2c-9dcd51ed9ebc.dimon.zhao@nebula-matrix.com>
References: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
 <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
 <20251124034026.3680873-2-dimon.zhao@nebula-matrix.com>
 <20251124153545.7123c338@phoenix.local>
 <c28f7d63-7af2-4b48-9c2c-9dcd51ed9ebc.dimon.zhao@nebula-matrix.com>
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

On Tue, 25 Nov 2025 10:28:38 +0800
"Dimon" <dimon.zhao@nebula-matrix.com> wrote:

> Hi Stephen,
> Thank you for your review.
> http://patches.dpdk.org/project/dpdk/patch/20251107073459.3532524-3-dimon=
.zhao@nebula-matrix.com/ <http://patches.dpdk.org/project/dpdk/patch/202511=
07073459.3532524-3-dimon.zhao@nebula-matrix.com/ >
> In this previous commit, the driver is advertising RTE_ETH_RX_OFFLOAD_VLA=
N_STRIP
> in the offload flags. Because we do not support QINQ and FILTER,
> we are not advertising QINQ or FILTER flags.
> dev_info->tx_offload_capa |=3D RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
> dev_info->rx_offload_capa |=3D RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
> In this previous commit, we simulate support for Tx and Rx VLAN offload,
> while in reality we handle Tx VLAN insertion and Rx VLAN stripping in sof=
tware.
> For Rx VLAN stripping, the driver uses rte_vlan_strip to achieve this fun=
ctionality.
> It does not have the capability to do this in hardware.
> So when enabling or disabling Rx VLAN stripping, the driver and hardware =
do not need to do anything.
> Why vlan_offload_set is Required?
> The rte_eth_dev_set_vlan_offload function has this flow:
> int rte_eth_dev_set_vlan_offload(uint16_t port_id, int offload_mask)
> {
>  // ...
>  if (dev->dev_ops->vlan_offload_set =3D=3D NULL)
>  return -ENOTSUP; // This causes the error!
>  // ...
>  ret =3D dev->dev_ops->vlan_offload_set(dev, mask);
> }
> Without implementing vlan_offload_set, users get -ENOTSUP error when runn=
ing:
> testpmd> vlan set strip on 0 =20
> Since hardware doesn't need configuration changes, our implementation is =
minimal:
> int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev,=20
>  __rte_unused int mask)
> {
>  // No hardware configuration needed - everything handled in software
>  return 0;
> }
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AStephen Hemminger <stephen@networkplu=
mber.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2025=E5=B9=B411=E6=9C=8825=
=E6=97=A5(=E5=91=A8=E4=BA=8C) 07:35
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9ADimon<dimon.zhao@nebula-matrix.com>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Adev<dev@dpdk.org>; Kyo Liu<kyo.liu@ne=
bula-matrix.com>; Leon<leon.yu@nebula-matrix.com>; Sam<sam.chen@nebula-matr=
ix.com>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH v1 1/1] net/nbl: add VLAN =
offload set interface
> On Sun, 23 Nov 2025 19:40:26 -0800
> Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:
> > The rte_eth_dev_set_vlan_offload function internally calls
> > the vlan_offload_set interface, so we must implement this function.
> > Otherwise, an error will occur when
> > executing the vlan set strip on command.
> >=20
> > Fixes: 9d7757dce874 ("net/nbl: simulate VLAN offload")
> >=20
> > Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> > ---
> > drivers/net/nbl/nbl_dev/nbl_dev.c | 5 +++++
> > drivers/net/nbl/nbl_dev/nbl_dev.h | 1 +
> > drivers/net/nbl/nbl_ethdev.c | 1 +
> > 3 files changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_de=
v/nbl_dev.c
> > index 58eb1c6231..923de2e9d0 100644
> > --- a/drivers/net/nbl/nbl_dev/nbl_dev.c
> > +++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
> > @@ -758,6 +758,11 @@ int nbl_promiscuous_disable(struct rte_eth_dev *et=
h_dev)
> > return 0;
> > }
> >=20
> > +int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev, __rte_u=
nused int mask)
> > +{
> > + return 0;
> > +} =20
> This seems broken in handling VLAN.
> The intention is that the driver changes how vlans handled based on the m=
ask
> in the API call.=20
> The driver is not advertising RTE_ETH_VLAN_STRIP_OFFLOAD in the offload f=
lags.
> Same for QINQ or FILTER flags.
> What is the intention? How is the hardware handling VLAN tags? Does it
> have the capability to do this in hardware? Can it be enabled and disable=
d?


If device does not support VLAN offload then it is correct for any
attempts to change the mask to return -ENOTSUP. This is what happens
now with all of these kind of devices.

You could make an argument that at the ethdev shim layer, requests
to disable any feature that a device could not support could be reported
as allowed. But that is such a odd case, that it is more logical to
argue that: "Any change to offload X should be reported as non supported
unless the device reports it can do feature X".

If you have some customer or internal script expecting testpmd
to always allow vlan strip 0 then that is the real issue.
