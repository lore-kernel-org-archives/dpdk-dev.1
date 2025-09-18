Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36D5CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 15:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ECAC40288;
	Thu, 18 Sep 2025 17:13:37 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 162EC40288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 17:13:36 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-78f30dac856so12613806d6.2
 for <dev@dpdk.org>; Thu, 18 Sep 2025 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758208415;
 x=1758813215; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddl3XAkBE8a2zGgwlauoeE+12RTBMvntE6ZQvpHMTs0=;
 b=a47xKgXqhMjMjHgRucZY6R9Zh9t6JaMunP3/AZ81RlGTEFhwwQsL4SmqOaS0K/oiwV
 aVdgzkFwH76kn0IL/5aaTKkUc3m9SK+SuMa+SC4ksMMwCLwfYtuSeOflTU+NylmJuZCY
 UzPohspQo+UFAVRCprVdl8vx+cv9ANUOcclV3UMXnWEQIsqRjIV2TlvwFRf9gaScXaOy
 kPwmLHeUEjcHsx88MtxxgIDHoZ0Oe69Sn3WnlmE5QMrSNmfanIZ20VXOrcudz6Xw7arc
 UyEMp2U6cllBoF+JFo25VXRndc9wMOWGdgoMwmAoyeKCLLUCVO9lPvSfPleP2YEuc2fG
 lJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758208415; x=1758813215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddl3XAkBE8a2zGgwlauoeE+12RTBMvntE6ZQvpHMTs0=;
 b=oiWEteJiMABYav+rmfowAnzIQ0Z8PMSjpJMm/4+w63329v9MxNLo/e25ol81tf+NBl
 3jYL50sL2EQ6tRncdlp+9bSYklOsyJzFn376EuVOGkD9gQKI73wQfqVBbdG0BYQX2Y8X
 llr6ij0Mv350r6yFw3NQz2IGZ9YKxYjDRQaRQ99NURhosASOK1DjFGv3LmTNrdbALXgP
 hnlUoP+cpnQ8wzuLnPbKyOg/ogCzAJXhLJNLU5NGApp7HYxMwPC+QN8FZCaml7a7+eSz
 Ob9577MafEU5W60LrFz4K98tl+H4Hk/mVaRQ0kWSYBC9q4mVLvVwu6Cl+r7nK2jF8cCo
 pfvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS6UqfwOlS/kE6wQ4FiDlojWhcVQ4igAFQYLI+qR96gdWS2P5LYR/Jv4f36DltnRkzcc4=@dpdk.org
X-Gm-Message-State: AOJu0YwwvNAXZpFQ9yGen/u7MIy10uDSrP3veEa9+SrBXpW5CIiE/Zge
 90XRSrSpVWyTjFbi68Icu/G9FFRIKGZghwunhWBaFjnNp2gy1YHWdG3GGSMUW1CrDbo=
X-Gm-Gg: ASbGncv5OCc2r398+gvbjfym1eN2nCUKWXEn0EqSJ7eqUGyRewo4K7n0zIs6YFjw4en
 TIlPQGYl1Xuk9weIl6bB1lOQIGZtAUzYhZKBkZWIkFdZETCzn+HCj+e0hXSyFGAezhFtkyFYRXC
 H81GKjkzbIl/zkE3UaduQb0NNxuBY3Lj0QCMe8/Mb/oKBVT2zou0Xr/VXm0+VTxfKWaEv1N8Cch
 XjXvDX4e8fGlU9TZ6FbQodJ5OYK+qRY+wR7SXMWAcH5h9pQnH+ehg9d9E3j5Y65y7nxRDZaoYYM
 h8PH5t9NHYHJQ+yWFveMyzPn9h1DHTTUCJz1ruwvTrtP0HYu91yvlcAIPtJWOtlzIdPwMQKIv8M
 fP75sGH6jlnA3ECTCgGTVGjbYXM2v25rxLeZKWCjgj37RwXlBc8Z7XWk7SVC6d525WOrxe8rYW0
 qaCn1TbFff5wfAuT0jrR2wWMm8MLK1
X-Google-Smtp-Source: AGHT+IHFVllFQi8txDowKHKiU8k+wP/YtajfmTKbNzkIAR+U0uo8RDj+irOpPNxYmbKNS0E4l+UmHg==
X-Received: by 2002:ad4:5c41:0:b0:780:555c:7690 with SMTP id
 6a1803df08f44-78ecf3053d0mr60310226d6.66.1758208415056; 
 Thu, 18 Sep 2025 08:13:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-79351f713a5sm14329046d6.44.2025.09.18.08.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:13:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:13:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Ajit Khaparde" <ajit.khaparde@broadcom.com>, "Somnath Kotur"
 <somnath.kotur@broadcom.com>, "Nithin Dabilpuram"
 <ndabilpuram@marvell.com>, "Kiran Kumar K" <kirankumark@marvell.com>,
 "Sunil Kumar Kori" <skori@marvell.com>, "Satha Rao"
 <skoteshwar@marvell.com>, "Harman Kalra" <hkalra@marvell.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, "Sachin Saxena"
 <sachin.saxena@oss.nxp.com>, "Shai Brandes" <shaibran@amazon.com>, "Evgeny
 Schemeilin" <evgenys@amazon.com>, "Ron Beider" <rbeider@amazon.com>, "Amit
 Bernstein" <amitbern@amazon.com>, "Wajeeh Atrash" <atrwajee@amazon.com>,
 "Gaetan Rivet" <grive@u256.net>, "Xingui Yang" <yangxingui@huawei.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>, "Praveen Shetty" <praveen.shetty@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, "Anatoly Burakov"
 <anatoly.burakov@intel.com>, "Jingjing Wu" <jingjing.wu@intel.com>, "Rosen
 Xu" <rosen.xu@altera.com>, "Andrew Boyer" <andrew.boyer@amd.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, "Viacheslav Ovsiienko"
 <viacheslavo@nvidia.com>, "Bing Zhao" <bingz@nvidia.com>, "Ori Kam"
 <orika@nvidia.com>, "Suanming Mou" <suanmingm@nvidia.com>, "Matan Azrad"
 <matan@nvidia.com>, "Wenbo Cao" <caowenbo@mucse.com>, "Andrew Rybchenko"
 <andrew.rybchenko@oktetlabs.ru>, "Jerin Jacob" <jerinj@marvell.com>,
 "Maciej Czekaj" <mczekaj@marvell.com>, <dev@dpdk.org>,
 <techboard@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Ivan Malov" <ivan.malov@arknetworks.am>, "Thomas Monjalon"
 <thomas@monjalon.net>
Subject: Re: Fixing MBUF_FAST_FREE TX offload requirements?
Message-ID: <20250918081327.06fcdadf@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
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

On Thu, 18 Sep 2025 10:50:11 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Dear NIC driver maintainers (CC: DPDK Tech Board),
>=20
> The DPDK Tech Board has discussed that patch [1] (included in DPDK 25.07)=
 extended the documented requirements to the RTE_ETH_TX_OFFLOAD_MBUF_FAST_F=
REE offload.
> These changes put additional limitations on applications' use of the MBUF=
_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually exclusive with MULT=
I_SEGS (which is typically used for jumbo frame support).
> The Tech Board discussed that these changes do not reflect the intention =
of the MBUF_FAST_FREE TX offload, and wants to fix it.
> Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually exclusive.
>=20
> The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements were:
> When set, application must guarantee that
> 1) per-queue all mbufs come from the same mempool, and
> 2) mbufs have refcnt =3D 1.
>=20
> The patch added the following requirements to the MBUF_FAST_FREE offload,=
 reflecting rte_pktmbuf_prefree_seg() postconditions:
> 3) mbufs are direct,
> 4) mbufs have next =3D NULL and nb_segs =3D 1.
>=20
> Now, the key question is:
> Can we roll back to the original two requirements?
> Or do the drivers also depend on the third and/or fourth requirements?

IMHO fast free should be as much like normal as possible.
Only things that would have a measurable impact on performance would help.

The reason for the single mempool is mostly related to not requiring code
that would walk a multi-segment mbuf to disperse the segments to potentially
different pools.

The reason for the refcnt =3D=3D 1 is that updating refcnt requires atomic
operations which need to read-modify-write on memory (not just cache).
And RMW operation can take several memory clock cycles.

