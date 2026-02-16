Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31E6E83840
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 22:25:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03B3A40289;
	Mon, 16 Feb 2026 23:25:21 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 7FEE14026C
 for <dev@dpdk.org>; Mon, 16 Feb 2026 23:25:19 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so19257115e9.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 14:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771280719;
 x=1771885519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCwVD+ai7LjVgGyWQNpdkOPwzvlr7jefUpW+kogBTR0=;
 b=1GjlveNbMSDptIBgOsR1jZzGnPMz9rh7Yf9ylZ4yJEw48yiMNEwdtyYT/PdN8y445z
 kYgUeG3i2rSU+vFAgeqZ7IZSmscHyRDk3GMR+qmH/t4ZrfsKLB6RePUE3opBI6WG63G4
 RdbMNdpFBDPT9L1K6E8AMRgS+y+lWUamGUzjhr5H2YYJJ/hlPu2NqeQbdWVi3U+mmGl7
 DIm9AYTAccx5gXChyVEoJRVVmsgHSorwmlEXnx2M1VJma8qVtJZc/BmwLau4C8mR6X9q
 a8RxeJYdqPGmtIkkoqa+YmhhqU+G+CYJX4AMMP44n6nPHDk2FMOdkGPGQ6Y2v26wocsq
 QTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771280719; x=1771885519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCwVD+ai7LjVgGyWQNpdkOPwzvlr7jefUpW+kogBTR0=;
 b=mH4jLZ5ZOthjXpCyT277Wpi/IG00SFarID23/es5fkevVokDw5g69CmdBmvKRqlYo9
 wHMQgfzk5x9SIaGzqgYsALRrYdvNB7NDFBRujOY3LRSl52eWpeJwVnshykKQE/Z/Z2SN
 +rf1b8/thGUjoOlzUSzisb19/u1VJwx7o1R/C29Y2me9z8MBCqHVk+wU7xwh8bVK8sS0
 rhebemiZFkBneS/xd4h7m8jGR1Z57+qyVsneoac/Yrbi6zKBe5hZMt6qPhLOllFU+l6R
 IHTz1adRYABm05+cLy9gdmaD5tkhcjEn5Q2MsatwdjYUEXVf0Z/g0/s2ecmn/lgtn3WY
 QFwg==
X-Gm-Message-State: AOJu0Yw0oIgIWdEYZL1AZIK8HtveT6ge4aWeKkD1h7dCTZ5zPk/7SU20
 LbSuNVsL/yK9gDP++87UWh9WdslQ41UQyPo3nH42woTnP8ZQ4BlZsSNct2SrVmY8Q0I=
X-Gm-Gg: AZuq6aK5Sn+Ul7j6+H1CD/RApmC2K8FSGw14PFl3wgkkQqjxWEX8SQOGSVfVnLKvQvv
 oQgT5V4sXh9DnpGplQgVrj65eC5mE/pK96ONcvPSPG1KBohkqvHBaup8fuIU+htkq99Hl3Xe/ht
 GItropNH1zYG/NWwTx99nVijNnqDwA2FHNBvrUxKY7eldQ8JWFQTRkSo456P2ppFdc9e9YMpCMc
 vpxErvJ4Qcgnuz7NFlImAkpgdtpsyXtO8hpcPcAgviE+4ZVk8lXCFnvN5O1Ca+xdoUqTB3cr43b
 JwZLXWqKx9LfStlekONY4jCoyXhbn83HA48oXO6ARA/coxMXbmU2ZVdaTaj46K2GsGxXhzC5BYC
 As1bpY8Lk7ZH6CIVvBmgTj/Py3U3mTIbGlu7QTElzsq0EW00LO6BPYoga3tTZXy5KrRHvNORYWX
 Qkxt8WUAgpktAAgQP8vylGrqLTFLSuQzar1dZ0BERlLZ8TfknE8uzMOLaRDHf6IjsW
X-Received: by 2002:a05:600c:474d:b0:47e:e72b:1fce with SMTP id
 5b1f17b1804b1-48373a59a59mr196784435e9.37.1771280719043; 
 Mon, 16 Feb 2026 14:25:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4afsm850999695e9.11.2026.02.16.14.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 14:25:18 -0800 (PST)
Date: Mon, 16 Feb 2026 14:25:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 17/27] net/iavf: avoid rte malloc in VF mailbox for
 IPsec
Message-ID: <20260216142514.4d809fdc@phoenix.local>
In-Reply-To: <67e3dfc60d3d5709563cd93810dcc6390090c28b.1770978324.git.anatoly.burakov@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <67e3dfc60d3d5709563cd93810dcc6390090c28b.1770978324.git.anatoly.burakov@intel.com>
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

On Fri, 13 Feb 2026 10:26:28 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Currently, when calling down into the VF mailbox, IPsec code will use
> dynamic memory allocation (rte_malloc one at that!) to allocate VF message
> structures which are ~40 bytes in size, and then immediately frees them.
> This is wasteful and unnecessary, so use stack allocation instead.
>=20
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

AI spotted this:

Patch 17/27 =E2=80=94 net/iavf: avoid rte malloc in VF mailbox for IPsec
Warning (Correctness =E2=80=94 Uninitialized stack memory)

The stack-allocated anonymous structs (sa_req, sa_resp, sp_req, sp_resp) ar=
e not zero-initialized. The originals used rte_malloc (not rte_zmalloc), so=
 this isn't a regression per se =E2=80=94 the old code also didn't zero the=
 buffers. However, since these are sent as virtchnl messages, it would be s=
afer to add =3D {0} for defense in depth, particularly since individual fie=
ld assignment may miss padding.

This is lower priority than patch 22 since the old code had the same issue.
