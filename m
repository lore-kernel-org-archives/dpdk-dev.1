Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42331C3ABCB
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 15:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BAFC4026C;
	Mon, 12 May 2025 17:45:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 960034025F
 for <dev@dpdk.org>; Mon, 12 May 2025 17:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747064720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmRB2WZsHgg6gksvb19uub+yPS553bRU91tFkZQcp+s=;
 b=FMfFXAannqlC/zaBvQKJdTlh06fOIO+tGBjnq6yPheTRyIBGGYht5yO8ZKtGLRt/z03gnu
 TUZlHeMQn3CG5GmzPqA3oe4jhEYmrPPE0Wl9LpuOucsIBda6+TrW86MC4vRACyWtTJBJZF
 dtyjb8XOsevdjq6j0uTjTkOoG7V39pc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-996MaJbaPsCQgN2lYLnTig-1; Mon, 12 May 2025 11:45:16 -0400
X-MC-Unique: 996MaJbaPsCQgN2lYLnTig-1
X-Mimecast-MFC-AGG-ID: 996MaJbaPsCQgN2lYLnTig_1747064715
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30d8a6be01fso27214841fa.3
 for <dev@dpdk.org>; Mon, 12 May 2025 08:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747064715; x=1747669515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmRB2WZsHgg6gksvb19uub+yPS553bRU91tFkZQcp+s=;
 b=B3VOHMyXCIcw9+vbrywjv7LPIrJJvKLxi1poJICKg9b4r+bA7fZKTXdOXEduTGM+R1
 ywT0t2XO0c5s0d+GJ8wlD3+1MJwXt6+jFjRmsRvLyC8Kc7FTh1DIGJQe/WGvQLxpJuWZ
 HYQG37hrXzHj6WPjMiAq+gWQhaW68Q1hATZwJjyIjSPaUPp5WjSVL/iciy5miPvuZ4QB
 A1/lwYxba+Q8e/+mBIbqeUqGE15rnuvlLCGDMPzm9zq7cnN0csUloYyJpoPwd+DeEqxc
 KyPK207oG+AtqmpucbcVMc+r9gkLBaFdVTDx0gDbkNLj2N7NIXf3LSqBQ3tPEAckiXxh
 feHw==
X-Gm-Message-State: AOJu0YyHR2op2R15ZucxK1A5hiKe0tZEwGfF2VWuHFaI/afkOGqjk8Ux
 pFbaDTdUizUfnXZ8It6K1OaybvDcvlo+s+2QNPSIihX4x0J6rPz5GdkmrGBNCV3cQ8M4Gktv8x5
 H1UDlunu6eurJ7H/0imkvJ8ZIdwifGE9cCKvt0qND3Az8MofrZpF1PtenyCVVf8KE8nC26wFh/s
 aVrsr4XN+fEHdLca4=
X-Gm-Gg: ASbGncuQHGQQ+Q41lAhfAYfu+MszhNoOmOZ3wddUmrDxIMdTAJzBd/JSvbwgC9ftnqw
 cmO1PUPslkn31dfrNiSIu6+LFFtgorpmqM9pT39SHzuHBE/IxXSogzW7KKr1afH7YA622nrc=
X-Received: by 2002:a05:651c:30c6:b0:30b:b908:ce06 with SMTP id
 38308e7fff4ca-326c4619b5amr54606111fa.19.1747064714820; 
 Mon, 12 May 2025 08:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeAKSpyF+WCkolJNqHidkO3jjpechsEqfLr5Wwq81CTZegkZzyKAg4P+xvDlrEpErGhgleOmm2JWE3aAusQTE=
X-Received: by 2002:a05:651c:30c6:b0:30b:b908:ce06 with SMTP id
 38308e7fff4ca-326c4619b5amr54606021fa.19.1747064714449; Mon, 12 May 2025
 08:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250508044230.133966-1-david.marchand@redhat.com>
 <aCITmVz7OAjbNvCo@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aCITmVz7OAjbNvCo@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 12 May 2025 17:45:02 +0200
X-Gm-Features: AX0GCFvlL1GZT3dnwKTSiKq4mXdZbfhqbHtLovbmR840UK-SeC-oOm2qRFLj9x4
Message-ID: <CAJFAV8yd2O7UVyj3gaQfd1aeQtztE+JyyNo5Qs3qpGt+_xEX9A@mail.gmail.com>
Subject: Re: [PATCH] build: fix disabling developer mode
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PPJe-ZXwiMKjGYpcojt7-VVZ9SzBnRhq_1hm06KMVc8_1747064715
X-Mimecast-Originator: redhat.com
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

On Mon, May 12, 2025 at 5:28=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> On Thu, May 08, 2025 at 06:42:29AM +0200, David Marchand wrote:
> > A recent change broke disabling developer mode:
> > $ meson setup plop -Ddeveloper_mode=3Ddisabled
> > ...
> > drivers/meson.build:150:14: ERROR: Unknown variable "fs".
> >
> > Fixes: 8fa3af6c05f8 ("build: add generic support for base code in drive=
rs")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


--=20
David Marchand

