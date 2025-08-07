Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34EFC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:47:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 778C940609;
	Thu,  7 Aug 2025 19:47:07 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 4200E4027C
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:47:06 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-76bd050184bso1853407b3a.2
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754588825; x=1755193625; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YOUkxQWdHs1MC3lC5nOusaov2x5gWFvu6P5rdR09C6w=;
 b=LzxqD6y8hl8GEfi7F2mXmL0+JBO3gF+UhPme52oJVtEQN5/pI4ZFD84ukGZMtGwPq8
 giQoy1cOIxd1RyDQupdKrifpivkM1/aHK8eZwzqbWQYBGUbcAyaavziCMGb6SuW4iUPj
 eejnzgT8uesWn+jT7+1RsHZD1eAfxlxNZVSkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588825; x=1755193625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YOUkxQWdHs1MC3lC5nOusaov2x5gWFvu6P5rdR09C6w=;
 b=rh5b6r1mwWu0sow8tMCit8VZtZGhCZ76uZ+kjerTOCai7D2MtwY8acO4ZOUxQ/0UET
 GyhN9gXMm/5h0x+aZ36lBJiXGBWCYMx4xGDv+DqJbw8TrvTeOmdf7cqENC20aA+qxn1X
 aL25WIS3e76wno0p0EDakh4kGUXSinb1iAcGFxSRjOu7FQXC+cwYdlnbAt2475jS03Gr
 akWZDfKvOMF6YNLSQ/nexe3kkvQIcN6L0dk9y1SdiFEvEkhrmsKaIbI57sJsXL81kg85
 Vf9sbUsw0UlLWB1F+oW/dUTDUMic5ofYfGSqGefUiGWEjhQiXivX3Tfd7v41dCDkZycS
 j+0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGejx3loK9OTsuZwnSvnfAALKz0Qf5MIVgmciMv/Hqk3+QdJmLcuSps9QUNL+l4/v1gLA=@dpdk.org
X-Gm-Message-State: AOJu0YyKcHZSHOF9WxXZZxeJuw8IvzQPBlk+kokA85hsIHPxXXAvL4Cw
 9AUOhItpZaiY3vg+XVBn54PVEkWG2ZzgwUEKWumuMf/3vB5tklqmoYwSoDjhuJlCWIt+MSXEK9Z
 u5Z/nmoN5lRG9b3YOI6QVJJHkglpphz6/DhdrljyGiQ==
X-Gm-Gg: ASbGnctdxdd0ErqSmuEc/l9SJYDO6OLTaSsT+ISvCT2WnPyI8Tz98Ndc0VyL7u4zX4E
 ns/X5CXhuOLg+3GmK2c7PgxJ3dQXONh/H3cp9RJk6NlC2BhFb17Bc75Qug00YznFx0UsqcIYXcG
 3ziEIuBRtERIoFIL3dE7NhWzbb8nxJfpggQm8baTGsuWAQRudqlYZVCfjlO3CCgeq/VnPaXEtiW
 dZJ5vCxTuAYJuIGgo6dBQ==
X-Google-Smtp-Source: AGHT+IHiOMjOBFE/ehLXcaPB3UUY9RtwEk27b28natF8PDOpkSmp/NNJqN8yg0F8PZrZcIn0uN6ZGt7h0ncpDSjVZ+4=
X-Received: by 2002:a17:902:ef10:b0:240:3ed3:13e7 with SMTP id
 d9443c01a7336-242c02bb4a5mr6906885ad.42.1754588825296; Thu, 07 Aug 2025
 10:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250807115943.690540-1-gavinl@nvidia.com>
In-Reply-To: <20250807115943.690540-1-gavinl@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 7 Aug 2025 13:40:49 -0400
X-Gm-Features: Ac12FXx0dD0A7ici6a1XWHLEKLs7HN3CtuKbnuTdVjVA1JmhEFyy-5l_jo3T5mo
Message-ID: <CAJvnSUDkYY7-OJjVo2vgX1VEfXCF+xFSvZKBkU+8NDfEu+=KGA@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: add support for flows targeting multicast MAC
 addresses
To: Gavin Li <gavinl@nvidia.com>
Cc: matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com, 
 thomas@monjalon.net, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, dev@dpdk.org, rasland@nvidia.com,
 stable@dpdk.org, 
 Dean Marx <dmarx@iol.unh.edu>, Andrew Bailey <abailey@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000a8b811063bca0bc3"
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

--000000000000a8b811063bca0bc3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gavin, I'm just flagging that this patch has a failure for the
dynamic_config testsuite's test_disable_promisc_multicast testcase.

It's a testpmd testcase which disables allmulticast on the port and then
verifies that a multicast packet sent to the DUT is dropped, then enables
allmulticast and verifies that a multicast packet is received. It looks
like your series is failing for the initial check (that the packet is
dropped when allmulticast is disabled).

I'm not sure why your series is failing if it is just allowing multicast
addrs to be stored in PMD device data. Maybe it is the case that your
series is allowing the multicast address to be added (correctly), and then
that is exposing an existing issue with disabling allmulticast on a port
with the PMD? Otherwise, I'm not sure.

https://doc.dpdk.org/api/rte__ethdev_8h.html#a2fe97cde3f374385ef0b12f61e7c3=
0da
https://doc.dpdk.org/guides/testpmd_app_ug/testpmd_funcs.html#set-allmulti

If you want to verify that allmulticast disable is working properly for a
future version of your patch you can validate it with testpmd, or even
better just run the DTS testsuite. If you need any help setting up DTS the
students at UNH are available to help with that and I added them to the CC
list.

Thanks.

On Thu, Aug 7, 2025 at 8:06=E2=80=AFAM Gavin Li <gavinl@nvidia.com> wrote:

> Rules for multicast MAC addresses are intended to filter multicast traffi=
c
> and are managed through multicast MAC add/remove APIs. In mlx5_dev_spawn
> function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC
> addresses via netlink and store them in the PMD device data, which
> includes multicast MAC addresses.
>
> To update multicast MAC address rules, create them within
> mlx5_traffic_enable.
>
> Fixes: 2d0665a7f771 ("net/mlx5: align PF and VF/SF MAC address handling")
> Cc: stable@dpdk.org
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_trigger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/mlx5/mlx5_trigger.c
> b/drivers/net/mlx5/mlx5_trigger.c
> index 6c6f228afd..6e82a8b021 100644
> --- a/drivers/net/mlx5/mlx5_trigger.c
> +++ b/drivers/net/mlx5/mlx5_trigger.c
> @@ -1813,7 +1813,8 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
>         for (i =3D 0; i !=3D MLX5_MAX_MAC_ADDRESSES; ++i) {
>                 struct rte_ether_addr *mac =3D &dev->data->mac_addrs[i];
>
> -               if (!memcmp(mac, &cmp, sizeof(*mac)) ||
> rte_is_multicast_ether_addr(mac))
> +               /* Add rules for unicast and multicast mac addresses
> synchronized from kernel. */
> +               if (!memcmp(mac, &cmp, sizeof(*mac)))
>                         continue;
>                 memcpy(&unicast.hdr.dst_addr.addr_bytes,
>                        mac->addr_bytes,
> --
> 2.34.1
>
>

--000000000000a8b811063bca0bc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gavin, I&#39;m just flagging that this patch has a fail=
ure for the dynamic_config testsuite&#39;s=C2=A0test_disable_promisc_multic=
ast testcase.<div><br></div><div>It&#39;s a testpmd testcase which disables=
 allmulticast on the port and then verifies that a multicast packet sent to=
 the DUT is dropped, then enables allmulticast=C2=A0and verifies that a mul=
ticast packet is received.=C2=A0It looks like your series is failing for th=
e initial check (that the packet is dropped when allmulticast is disabled).=
</div><div><br></div><div>I&#39;m not sure why your series is failing if it=
 is just allowing multicast addrs=C2=A0to be stored in PMD device data. May=
be it is the case that your series is allowing the multicast address to be =
added (correctly), and then that is exposing an existing issue with disabli=
ng allmulticast=C2=A0on a port with the PMD? Otherwise, I&#39;m not sure.</=
div><div><div><br></div><div><a href=3D"https://doc.dpdk.org/api/rte__ethde=
v_8h.html#a2fe97cde3f374385ef0b12f61e7c30da">https://doc.dpdk.org/api/rte__=
ethdev_8h.html#a2fe97cde3f374385ef0b12f61e7c30da</a></div></div><div><a hre=
f=3D"https://doc.dpdk.org/guides/testpmd_app_ug/testpmd_funcs.html#set-allm=
ulti">https://doc.dpdk.org/guides/testpmd_app_ug/testpmd_funcs.html#set-all=
multi</a></div><div><br></div><div>If you want to verify that allmulticast=
=C2=A0disable is working properly for a future version of your patch you ca=
n validate it with testpmd, or even better just run the DTS testsuite. If y=
ou need any help setting up DTS the students at UNH are available to help w=
ith that and I added them to the CC list.</div><div><br></div><div>Thanks.<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Thu, Aug 7, 2025 at 8:06=E2=80=AFAM Gavin Li =
&lt;<a href=3D"mailto:gavinl@nvidia.com">gavinl@nvidia.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Rules for multica=
st MAC addresses are intended to filter multicast traffic<br>
and are managed through multicast MAC add/remove APIs. In mlx5_dev_spawn<br=
>
function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC<br>
addresses via netlink and store them in the PMD device data, which<br>
includes multicast MAC addresses.<br>
<br>
To update multicast MAC address rules, create them within<br>
mlx5_traffic_enable.<br>
<br>
Fixes: 2d0665a7f771 (&quot;net/mlx5: align PF and VF/SF MAC address handlin=
g&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Gavin Li &lt;<a href=3D"mailto:gavinl@nvidia.com" target=3D"=
_blank">gavinl@nvidia.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/mlx5/mlx5_trigger.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigge=
r.c<br>
index 6c6f228afd..6e82a8b021 100644<br>
--- a/drivers/net/mlx5/mlx5_trigger.c<br>
+++ b/drivers/net/mlx5/mlx5_trigger.c<br>
@@ -1813,7 +1813,8 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i !=3D MLX5_MAX_MAC_ADDRESSES; ++=
i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_ether_ad=
dr *mac =3D &amp;dev-&gt;data-&gt;mac_addrs[i];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!memcmp(mac, &a=
mp;cmp, sizeof(*mac)) || rte_is_multicast_ether_addr(mac))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add rules for un=
icast and multicast mac addresses synchronized from kernel. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!memcmp(mac, &a=
mp;cmp, sizeof(*mac)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;unicast=
.hdr.dst_addr.addr_bytes,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mac-&gt;addr_bytes,<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000a8b811063bca0bc3--
