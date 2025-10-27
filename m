Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814B5CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:18:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0E214028E;
	Mon, 27 Oct 2025 17:18:51 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 52BFF4028B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:18:51 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-29488933a91so44225135ad.2
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761581930; x=1762186730; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=En6ev/FzwJd/7cXiv97C8pdkz8hWlAPduZNt+xSrf1U=;
 b=RDeV2ONaHBHDfn+IzUEkHVcMy491rHU3ouBko4EPUC3pJxAaIXvYvKQwAhGWn0Pq2u
 JfvpifwhkXwkOcJEmI4EFte5pLbOj5TteTMdvgxnq9QlVORF1YNiKQm67m6+MLtMTCs5
 HF+3eLS4DCIF0TcCg2zaNu4g/2/KitfioSmOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761581930; x=1762186730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=En6ev/FzwJd/7cXiv97C8pdkz8hWlAPduZNt+xSrf1U=;
 b=A29nu7SZmDEfoPAALN25QmPvciNEKoFdKrG/lJIvaVhvVh4vsBCyVRzGCfnTAO3kA1
 giGgrA11P1cVlLRrJgl/EgqyF0gJD/eRIFEm+WnEZaAiByZHjob7AxgnPb+NpNzy+ybg
 LQq+eoc9VMgiQkDS0X0ZFzeKYo4rRHcXrkTrOAuyU0y41TDVe7OTmiypuuHS/u2TbP69
 KidW0WRrSBDH0p6ggIC48FWoxctZsmxmzM1WMzxIn8/eMtPg+RirEny2L2yLdW257d/+
 23QuH8oCY3ILTf2EKwgunmEfArW12HzbucJ54DUD/FfN2LCCHPH1b2c2qzsIKTpTln8L
 qsTg==
X-Gm-Message-State: AOJu0YwZiLAYaPPfW9XgPB+WlKOJvwHzSa3kbHUrEIiPIPI5o2bxpU/1
 lXzTUj8i73db7VnHzsxDq9rGYT6coPSrOu2bw1x6Jo2KcmsVdamIFICpyvj4TjL3CdBRXEmb6e0
 HpLibDuxgqmDxK0IDjsuYYeYDIhgjZ3bQe6zgAJ57MA==
X-Gm-Gg: ASbGncvxfyus8aIOJddg12EB8kjSZOI8Kjpz7un9VmdXp3rKMHSshXGWJiUe9BT+SRe
 VAegnO6YCqsaIZhx5yPfNrQqsT+jz2yWy00UAeGqsoCe1d80VupYtmlz4VnuwU/wAq7Qncn8jps
 C0+iyVL2fPyrgiayT0AkwuQHCc1qJLAkz94qoXQTHjynzQBdf7JcY90H0UnfsUZ1K8o3yiT4cXo
 IFwhTmCnCVLKk82GpFuozoEUGjO2MkGWInXwKRowdzDS3WpxNw82IHSTvjAj4+2w5ZZQ2geRBFC
 xMsxUQIrsutvHcJuqL+bKTYwEUfY
X-Google-Smtp-Source: AGHT+IFmcsin/eyZYz1JrlvTjB+F2HxHxGm0ej6PoO06Hdb16FGLBMNnfDZ4E2tfhmfm/jEJEFteNmOX0dHueoxddQs=
X-Received: by 2002:a17:903:1d2:b0:267:da75:e0f with SMTP id
 d9443c01a7336-294cb37a9f3mr5514845ad.11.1761581930338; Mon, 27 Oct 2025
 09:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251027130215.95444-1-abailey@iol.unh.edu>
 <20251027130215.95444-4-abailey@iol.unh.edu>
In-Reply-To: <20251027130215.95444-4-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 27 Oct 2025 12:17:53 -0400
X-Gm-Features: AWmQ_bnYmXvkQdihp3PDs9dfRaJ_5TZXKKZc4v8ghMxXLQ4vUcKMOUFWuXaTkow
Message-ID: <CAJvnSUDyok0SmTDYUtXd5x12CMsC7PnufOgft4uZhyUNJOQH3Q@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] dts: add Rx Tx offload test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Content-Type: multipart/alternative; boundary="000000000000336bf40642264156"
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

--000000000000336bf40642264156
Content-Type: text/plain; charset="UTF-8"

It looks like the testsuite only requires 1 link, not 2 (the default). Can
you decorate it saying so?

Otherwise this looks good and I've done a testrun.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000336bf40642264156
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It looks like the testsuite only requires 1 link,=C2=A0not=
 2 (the default). Can you decorate it saying so?<div><br></div><div>Otherwi=
se this looks good and I&#39;ve done a testrun.<br><div><br></div><div>Revi=
ewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.un=
h.edu</a>&gt;</div></div></div>

--000000000000336bf40642264156--
