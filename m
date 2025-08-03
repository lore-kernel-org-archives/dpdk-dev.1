Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EB9C87FCB
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 15:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECAF04026C;
	Sun,  3 Aug 2025 17:56:14 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 01A5D400D5
 for <dev@dpdk.org>; Sun,  3 Aug 2025 17:56:13 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso14575985e9.0
 for <dev@dpdk.org>; Sun, 03 Aug 2025 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754236573;
 x=1754841373; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Btoux/psIIQ2DJ8iwIBZB50jZ69lEdnJglR53dD21Ok=;
 b=fMaeOACFSQSN4yhVDcqhi6XEz+HrvXXPHmLlNLk/veRC7/VVr3sfyenEJi8LgTCeqN
 JRgthwQkl+blHw3L3z9ZKuheEnD1mmnWuOLpJ2Z91oZuFhTf7Cp+o7k93jBwD0kleUPr
 FNusRrvSvMQ2NET7RZkeknQfMNFHFcrI61Oz2567iwaNBsH7SOupQvxY4yzcum8AllM3
 m45dIJZMFSXGHAFCxBsCoKZhpkw40ymHZJzEOxElSl/U+Q5UzAehMjv00inbswNFbU2m
 kfs6KwYvg/YBh0OT782P3X2BHYP5lGPbKhfprKb9LHbTki/knOWKnUyDuQwNdWnrjRkQ
 UaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754236573; x=1754841373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Btoux/psIIQ2DJ8iwIBZB50jZ69lEdnJglR53dD21Ok=;
 b=QTvB5gm/qb6VR0dcIpa+UcO7Xm37U5j89JqSPnnQUbxP4nvFpcX1JxhKJfcmbjml6r
 JJjkTqg2zmMo2qMJGLNFgQNzodUbkfAUO/zVGCd+SBzZu1O6xIyU5T4z6W4Xn4AizLeX
 9EYTfzm0BgGvXoInWZolBhgYyMmKtOSLwN3ZnIwzJPLrOCwtGILvJD78pILf2HyyfnRx
 W9xVVbMATcB99NBWcFlsQoFzRoiMbxn0DonCdgwf1XWPY9scqS5DyAz4nc1jPF7LuxsO
 IhQsSBawZxDteISGUw3rETvQ+OReefZ8L9O8gm/VzBuH4bkGh8s8QWXaPRkKhTSXY6lx
 s+JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF2IqDUjNWbmPDhYeSA0kStptKc8xCN4wV32xEh13tEEuZpEsSZxQ92pd2vo/W6XvZf9Q=@dpdk.org
X-Gm-Message-State: AOJu0Ywsuvi/Djy2EsKSIRA8IwZinYaT/ue3VrNg6Cw7HKXHH8UJb89Y
 yvTSmhwyduc5qkgPbbH8F2t9Ahzq2RWnsaYjV2Qrq7/PuyGKn35RxzpDFszy+IOVxy+sjAO5o48
 LwSTi
X-Gm-Gg: ASbGncvrKTbOqrzMF0wzGL+fAL1YgiMFJvNNZU4uvgO+0LGTzVWQEW7qlwpLuOU2x6p
 sFbcyhBIQdoqaWNnrbsVOZNYacCwCxpCf56zM5ecNb2vfPm4vxpkvQroEBbrVLXudnqjQzvK/3V
 RU8tC9VpbbZZmbcRCDfyOQq0zvuNSEb/Wn3MMMAu03oO46sF2QwOHkDoP+QRc5p9sdEDMU6kReB
 ZMVnjEm7wSuGPo/x74jhXbUK2+BT3EDqgyZcPQfmEpqOx0SZRwNssklkGVQA/UYJFaimrlFvZb5
 u3nwg8CpWKTkRuCFUhpMhZOrTKf8Ud6wCMbBGHejwiv++THg8K7KpJpWw45F7ec9cVFBq48SIUs
 UzcWgGDQJ16lTUWpjSo6vGS5vpy6TIymFyeAtpThMKf4Y1Aj6TJ2bVUaBSEBisbsO/fLR7NEPwl
 yqpBHUr/vXX1YAAfwdz2Fq
X-Google-Smtp-Source: AGHT+IERjQntqmEAcqMTAvMyj/UHI6NOif8zLVRNMS55Y6TKZhA53EldhQ4gFpGONPLyAqN6txvPHQ==
X-Received: by 2002:a05:600c:16c4:b0:456:1a87:a6cb with SMTP id
 5b1f17b1804b1-458b71aa7e2mr33503115e9.19.1754236573270; 
 Sun, 03 Aug 2025 08:56:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4818c1sm12447132f8f.65.2025.08.03.08.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 08:56:12 -0700 (PDT)
Date: Sun, 3 Aug 2025 08:56:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Ivan Malov" <ivan.malov@arknetworks.am>, <dev@dpdk.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, "Andrew Rybchenko"
 <andrew.rybchenko@oktetlabs.ru>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] ethdev: Reject conflicting TX offloads configuration
Message-ID: <20250803085607.11cf44b7@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDE2@smartserver.smartshare.dk>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250802135354.158d8561@hermes.local>
 <66e365f2-8398-43b2-58a6-cda29bae08e1@arknetworks.am>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDE2@smartserver.smartshare.dk>
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

On Sun, 3 Aug 2025 12:51:59 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Ivan Malov [mailto:ivan.malov@arknetworks.am]
> > Sent: Saturday, 2 August 2025 23.34
> >=20
> > Hi,
> >=20
> > On Sat, 2 Aug 2025, Stephen Hemminger wrote:
> >  =20
> > > On Thu, 31 Jul 2025 09:07:31 +0000
> > > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> > > =20
> > >> +		RTE_ETHDEV_LOG_LINE(DEBUG,
> > >> +			"Ethdev port_id=3D%d tx_queue_id=3D%d, Tx offload %s =20
> > potential conflict with per-port Tx offload %s, " =20
> > >> +			"runtime support depends on the driver", =20
> > >
> > > Shorten the message, and get it on one line.
> > > When a message is so long it won't fit on one line, it is too verbose=
. =20
> >=20
> > I am not an expert in naming, but on the premise that 'ethdev' is
> > already
> > printed by 'RTE_ETHDEV_LOG_LINE', perhaps consider this variant:
> >=20
> > "id=3D%d txq=3D%d offload clash %s vs dev %s: PMD to decide"
> >=20
> > Thank you. =20
>=20
> Ivan's suggestion is good, but this file has plenty of long (and even mul=
ti-line) log messages, e.g. [1]:
>=20
> 	if ((local_conf.offloads & dev_info.tx_queue_offload_capa) !=3D
> 	     local_conf.offloads) {
> 		RTE_ETHDEV_LOG_LINE(ERR,
> 			"Ethdev port_id=3D%d tx_queue_id=3D%d, new added offloads 0x%"PRIx64" =
must be "
> 			"within per-queue offload capabilities 0x%"PRIx64" in %s()",
> 			port_id, tx_queue_id, local_conf.offloads,
> 			dev_info.tx_queue_offload_capa,
> 			__func__);
> 		return -EINVAL;
> 	}
>=20
> [1]: https://elixir.bootlin.com/dpdk/v25.07/source/lib/ethdev/rte_ethdev.=
c#L2703
>=20
> Which do you prefer:
> a) Follow the local coding style for log messages, or
> b) Follow our general coding style, and log as Ivan suggested?
>=20
>=20

I have distaste from long error messages after seeing what VMS and Windows =
NT did.
The purpose of error message is to say "something is wrong" not to describe=
 to the
user in detail how to fix it.

Keep longer description for documentation or comments.
The real problem is missing description in documentation and longer messages
don't help.
