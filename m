Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B61CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 15:39:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65CE740287;
	Fri, 19 Jun 2026 17:39:40 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id B28764027C
 for <dev@dpdk.org>; Fri, 19 Jun 2026 17:39:38 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-800619d5e7eso18972627b3.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781883577;
 x=1782488377; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c18DBSTiTk4m/xwfgJhrP3sXdCs5a2PcWDmDTPpkzTY=;
 b=DEXTzg4Btq6ujf1T5cKxQjiMbLnuAKy3WYtuTLeYJfW8SuPC4EAo4/3wNmEZifLqcG
 4HuEumNXUdQuJKfQRY5fGaWXe4XK6EabRG6qXdMfZ4D8kJpkJaOqsJsh8X3Tdo82dvAC
 O6Tphct3ntZ2i2CB2Tu98oq5+iwSJM1ltA9ygw3EFm9DBB8w/OYIME5R1a2U9MnDJTfB
 sqqdLxafCGkR9iq9kFWLxq5xU0QTR7Sozz0Kzf4Snyc1Rokh5tietSU+dBTxgvqbcGz9
 4tD0E20n767/vHFHjUs1IamlQuZj8BU+vGSh00wncaqdeN09IGHWQfrAsVoJ14WwuHtW
 9txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781883577; x=1782488377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c18DBSTiTk4m/xwfgJhrP3sXdCs5a2PcWDmDTPpkzTY=;
 b=YP38zFcFQlEgM5Z6SyuTqHqq0CU1a/bo4yn0YH8S9hQM5swoVfvozYxR2j5aHPnUGb
 WGLbHjz86XFq5BWjSN/x8l8j7UuFGWy7xe93PmjA8KNo/uAsjrLucUeouK7Gjmb6lHP5
 EqaKhI0y+QrXezaBuvP4A8EkfBwIh/0H/xjzGUloGp5x47OWWbyMj5VFdrRZaI41yFRQ
 eG0TllgOGUByxIZMteY5ddb73U4tX5dRuEor6QUhxbWUyYgiaW/y5ht/S3/BeBNCcrV6
 pxKlqec5vfEYMj1IaPN9bLWQ+GOZ5W6G03Fe5EnaCtexbQiqKwmfx/UWfztGKp+uNLvY
 WAeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86AqpvGZfbaH9ZAyKEMx0dpu2UcGgLonzRvK+DGGNCxMsjDlP8SY2Q7nZD29IrfSQVHPw=@dpdk.org
X-Gm-Message-State: AOJu0Yy7S9eCBXDvPqQBwrTPRECrFnGZlsKVsprZ7lLRh7ODZ0sFnQ4R
 eICkJhV8rPW3/SHvtzr/SM3qBPWssUoApJg9/S3Dkgjwxarra9wkfhlY/VJAEa0Srt4=
X-Gm-Gg: AfdE7clGdyD6WfRkfMLFFlx2EJV+LOeFyrniWhozP6Q5P9D+LmQzxsaFrIBbfhtJhCU
 sLDd3bf1VidpqJRyYJ++OTyATymJ4xtGXoFA5q70X8yg7JGXjCluYpEMeC7qOUZwzGJP178z+36
 nB5LCBcxC75EDqvMQ1qesHjIa+Jwc5OQsxnc9CCytJB05gq4dLIm+df708APvlkM3bqADHV6AyJ
 ikGWTUC+jKQs9x2VOVT0AR/4UnrrQ5RX5nuMwk0Xpik1X+Cfepz//ENna3f7bvnCEgL0EhAIdry
 efqxPAelZwuZc2Q4Zc+eXxwVAKYli5AXEM1RjvXtNvWnyYVDCgf+1kUBV2FuLppIneTTawppWQ0
 f2hd5qxYNGeb2u66y8+kP6uG6IYXEiGTKZU2ieHphQDPi449sWjT8nXiZy8yZ8H038zNCClsJBp
 PuO16HircrnLO5WjoJsebsxf8Bhu5sFrcXx+g5NsUbBsbqWELBui5Agw==
X-Received: by 2002:a05:690c:22c5:b0:7db:ccda:a40d with SMTP id
 00721157ae682-80133fc68a4mr41043557b3.5.1781883577521; 
 Fri, 19 Jun 2026 08:39:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8011daf3828sm12641687b3.43.2026.06.19.08.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 08:39:37 -0700 (PDT)
Date: Fri, 19 Jun 2026 08:39:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Thomas Monjalon" <thomas@monjalon.net>, "Huisong Li"
 <lihuisong@huawei.com>, <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>,
 <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v1 0/5] prefix lcore role enum values
Message-ID: <20260619083934.510bd2d4@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65929@smartserver.smartshare.dk>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
 <20260618190339.2fc76616@phoenix.local>
 <ApV03BBBSN-iQgiffDgXRg@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F65929@smartserver.smartshare.dk>
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

On Fri, 19 Jun 2026 09:54:51 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > > The problem with this patch it causes build failures now with abi =20
> > diff.
> >=20
> > It is probably a bug of an old version of abidiff.
> > I recommend updating. =20
>=20
> With the #define's the ABI has not changed. It's probably too indirect fo=
r abidiff to understand.
> If we absolutely want to please abidiff, we could keep the existing enums=
 and #define RTE_LCORE_ROLE_RTE ROLE_RTE for now.
> But I'm in favor of what was done already.

The build failures on github, not in my local builds.
https://github.com/ovsrobot/dpdk/actions/runs/27789889172/job/82235965090

It makes looking at patchwork dashboard difficult, all patches show up with=
 red mark
