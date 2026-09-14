Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66C2C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:25:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC62840272;
	Mon, 14 Sep 2026 13:25:15 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id 9F79F40144
 for <dev@dpdk.org>; Mon, 14 Sep 2026 13:25:14 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d4eb63f16so6586657b3.0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 04:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789385114; cv=none;
 d=google.com; s=arc-20260327;
 b=YsnDcq/goqmw2qtLQ4GI8Fqh/99AINXHbRsPipOh42//dnlkltpY7r0F0pSFem/EIV
 PV1dalfWyr0XneZXrFEzyISqGATZSz7THHLN4kvY5vFWLl7kPqHfAu9ig8hq8JDltt7b
 SYL0RdnQQ428sc8Wg2PEnkWW52uBu+Pc9kG3fL4SFudsjpA2VSyJzHosg7pIditJnCnl
 fXlSSZbPhPmhOyjyE0agj+10JmOC1tRl+e9yoKQyJtFMhBW3d9BKe0+v+kCf/gw8dgnR
 E8KZolqctZCe3WNWy8i5PkBLGHcU+ETxYrVkHeceaLjuq8Lx7qTqu7sCP/BD8lhW0lcS
 tL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=15JREU4xz28LWLbQgvMBeP8geb66w8O8UHSRZiAID/A=;
 fh=Fd3ZGCJ9fJG7z8FjoiOko4zegpNUt2XqU2Nj+0POl/g=;
 b=LPF8Sgwz/XwfBPxcjtAoqBgx1P5PrdkohAAkAbeMSc3IGUUP18h4GKymQBloCrzLac
 dcprafOZ2ohXZrAAcsFTlWVnlPrhgnmGy8Md4pxbP4vPxsSOLthFexa2PeDRfYyI1Ni1
 85rjrRZygt7gK84ph6cFKAPTWCV6gY1fh1ysWE0Un6DhNfpLcoZIlS5T0l3n0hlzSYwt
 jo+BgF4n5vd3DLboV/j3SBpINaBoprR71J9c2SS5/vQujnVMru0iDR/4QgDcUhiTusIz
 wmj/Al2IqzQ4s687C9adEm90iIyg6Mwzhwrp/lxeScHWyeaSCojcKL6piDbVgWbAsr7r
 SOCw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789385114; x=1789989914; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=15JREU4xz28LWLbQgvMBeP8geb66w8O8UHSRZiAID/A=;
 b=EpN8vtgTe1Db81FTqq0IIlJRzg0XrQSGuOli0fx5fnbuPS/5WSMhlAQnR/yg3nruly
 L/fGOQSCdZdA7bvvrDTF7I1Y4lOu4xNDoIQjG65qw+21h6OuqIIc25wq1p7O/DDbhzXv
 0os9jQFUyi/F85Ermfu1LD/kjStXQrrm0/ewmhP1REPCo6w+7xBOouvtWEkZh43cn5i4
 R2yi9CUPw98C2+pjaNsG5mQmHmraY0/nr4emwYfSth6TOZwcpY0SX6syveyDbnD/UgI7
 Ucp0g9XidgnvKOic5jDqgZZoOTU8my6FnZvxxZOk6fGQWm1NwDwxfvWy6zHqNxolhddn
 iHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789385114; x=1789989914;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=15JREU4xz28LWLbQgvMBeP8geb66w8O8UHSRZiAID/A=;
 b=hSTf7iddF2e4mHcg+Ox9Xso/b67CeqZFx+Fg8za2InE0Dubpz6jwq9tlEaZp2tEWNL
 yLCjEBrguE5BdFdueMYc0gkfrIKmL4e29u9lG9rxK+Ey2GnhM5c+92Vi5YOU5XnFlNd0
 yzaIvHclUhZ+a0uU1dPS90KtgB1eNnjetk+UvIiXYF4No8N3qT/jDCoej/Dml1SlBM70
 Kn3Mbg0jQ/OdYapxj0UvHqPT9yqf7lr6dxruLybWzjH8XNJauZGUkLR7mEPG4Fxt7Lam
 IRToHbigtTiSm6m9klBb2x6fai70rD7y3UWHhWUv+xqQsJeY4rmaLspmUnCo1BmoV5PK
 y3Uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBysQLQxRcH6XbLlJ+wit98qc7zp5Zmx7JBg8aUzR12h4Cbm/cpwCe66ehUvUaITh9s+JMY=@dpdk.org
X-Gm-Message-State: AFuF++lc+ayYaErvkhk/hsidiGd+GB7oMzAdnoeZEKpmDawpuaZtyIYV
 F5UcsNafk8UvP+RWoHzhN3il5BO/yfNA8W0/7ON4lXV0N7uvyroZ7equxlQveLcLWL5pTEUmCsK
 DH+59lrV3NQdaVIVNvvOw0aEoD/X70s0=
X-Gm-Gg: AYBFou2wOG8jsZCiLUwTpGD8BBscvvLQ6p15JpP2GwCl8//sd1mjOOPogDFYoCw79i+
 n9/aeJvmJtiZC5kbaSg6verPIM7kGA/f+TEpRZSjgTJWbB2mbCKnN1f8p+HRuQ4dX8BNipg7H9H
 416zesRRaKMYKzfiXaA0SPc3UY6oSJaYD9ZM9UyGSKMq+nO3/EO2/vvZljZcod1FU/Wxx13YngN
 QA+pD52ZlWFu2cu6QopzXbE4VJSsns67/vOEDCJDrVB4uWaRbhhQZeEBg/yn+SQLcVgC28COmzh
 z4AUbOorZU+sdQKvXUqlNv9DHlTg78mb1nJ0W6NS9e3qHebfSHQA5R9tdhZH7okRcNj09xag7Fq
 agSGVLBe0ixt4n+hQlh52aUGNQ0Orye21H9KZ8Xt5t7QH9kRsDeKK0TSbmcz9UFup6nBH5WRVTA
 1dI1+ldIxmOqdcF538
X-Received: by 2002:a05:690c:c047:b0:873:5c6b:a31a with SMTP id
 00721157ae682-88d4154fbd0mr2813087b3.20.1789385113805; Mon, 14 Sep 2026
 04:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260823184643.7105-2-mike@sugarmillgang.com>
 <20260823184643.7105-1-mike@sugarmillgang.com>
 <010101a02ff2ce57-509d6017-e6b8-40e5-872e-a6f25380bb08-000000@us-west-2.amazonses.com>
In-Reply-To: <010101a02ff2ce57-509d6017-e6b8-40e5-872e-a6f25380bb08-000000@us-west-2.amazonses.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 14 Sep 2026 16:54:47 +0530
X-Gm-Features: AcwNN1W93t8wB3x9zRak4tkXIOkNsRwVHCethXS92LudgqLZPlaZvPRKqkkHpRY
Message-ID: <CALBAE1NAkR6nwn0XD3dOjHXXCDO5o6=jhh3bwDKW=A6daJdQcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/atlantic: fix Tx cleanup descriptor read race
To: mike <mike@sugarmillgang.com>
Cc: "irusskikh@marvell.com" <irusskikh@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 "pavel.belous@aquantia.com" <pavel.belous@aquantia.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Aug 24, 2026 at 12:17=E2=80=AFAM mike <mike@sugarmillgang.com> wrot=
e:
>
> atl_xmit_cleanup() scans hw_ring descriptors for a set dd bit to
> know how many are safe to reclaim, reading dd straight from
> DMA-coherent memory the NIC concurrently writes, with no barrier.
>
> A torn or stale read here can make the scan believe nothing is
> done when descriptors have genuinely completed, so to_clean comes
> back 0 and cleanup is skipped. Since atl_xmit_pkts() only refuses
> to send when tx_free is too low, and only cleanup ever grows
> tx_free back, a missed cleanup pass can leave tx_free permanently
> short: every later send call sees insufficient free descriptors
> and transmits nothing, indefinitely, with no way to recover.
>
> Add a read barrier once the scan's dd checks are complete and
> before acting on to_clean.
>
> Fixes: 2b1472d7150c ("net/atlantic: implement Tx path")
> Cc: pavel.belous@aquantia.com
>
> Signed-off-by: Mike Murphy <mike@sugarmillgang.com>
> ---
>  drivers/net/atlantic/atl_rxtx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/atlantic/atl_rxtx.c b/drivers/net/atlantic/atl_r=
xtx.c
> index 2d551a341f..34f53cd6cc 100644
> --- a/drivers/net/atlantic/atl_rxtx.c
> +++ b/drivers/net/atlantic/atl_rxtx.c
> @@ -1162,6 +1162,12 @@ atl_xmit_cleanup(struct atl_tx_queue *txq)
>                                 break;
>                 }
>
> +               /*
> +                * Same dd/DMA race as the Rx path; barrier before
> +                * acting on what was just read.
> +                */
> +               rte_rmb();


Use rte_io_rmb() version to express as it is a barrier between Device
and CPU. Same for patch 1/2

Since it is affecting fastpath performance, I will wait for ack from
maintainers.


> +
>                 if (to_clean =3D=3D 0)
>                         return;
>
> --
> 2.34.1
>
>
