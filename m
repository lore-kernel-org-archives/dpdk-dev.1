Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F43C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 15:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B9E9402C4;
	Wed, 19 Mar 2025 16:42:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 447064026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 16:42:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742398958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTIkQcMWvnyc0YENeXm3aJ6ABCAXUuOu7IHeWoDlB5s=;
 b=jUCiVm6f9SZEidqelkw0fHSi+TTKF7gNUISMNvyk9d1CnK/zPfJ4MBW2yqOmUl1VJzWDz3
 7oAdZ0KXpgTXU1xprF1TvIfuzmX9hKSLH34LloL7Ssd1J03uR8NO3+lTY1egvvJorZDMU2
 3FeQUnqkgkVYkcdQYyTZ1wdjkxifJxc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-8GOvHgOXObqwPvy93ltZHQ-1; Wed, 19 Mar 2025 11:42:37 -0400
X-MC-Unique: 8GOvHgOXObqwPvy93ltZHQ-1
X-Mimecast-MFC-AGG-ID: 8GOvHgOXObqwPvy93ltZHQ_1742398956
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-549aec489c5so3473756e87.0
 for <dev@dpdk.org>; Wed, 19 Mar 2025 08:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742398956; x=1743003756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTIkQcMWvnyc0YENeXm3aJ6ABCAXUuOu7IHeWoDlB5s=;
 b=kaiYr5f9qutzMVZD+n4uxTAtH9gqOLq35f3YQgBxFMy/jhlRZa8pBKZQr19klecLT6
 FQ/ozki/uwOFdbgX/aZVEhrTMVv7KLws/zaiE42GZVqDB1cOLqCED0FcUIWxw9flIPrH
 WCRryPsT48nu/RdIsuFQtMEPmYe+ZAG3XSKHj2j8MhiQ0G/WCfaA+ApUtP7Q1KmY6Ymb
 iyocrH98E7rfJYYxEVm8zWuHB7BILx+BChUFoGSvt5dY5zJyhjZ4mt5aGzv5nherlFfr
 S6Z6PDXi9oKZZ+W7Y+Vb/pysAyOd7olC6R9yWAW8DcjTTuk/249fwRCKpRZGt1i0F7eD
 e7Kg==
X-Gm-Message-State: AOJu0YxolEPfWS5qZWNWWYXLQztfVpROQTK3fqRBiSLMl4lup6r6p2R9
 ZFeFw3wS7uAwIOmuFFO7R7f0u1eBUOc2tQbyKWrBdrxyz+I0GFYVr5+PddOn1cAdrkJABYSwRAf
 F2r7uCmQTOpChddFLKSDzFkxZTBvUN1kFDg0JPDx/nML/59evv0uE9gXFOOryAPLMvoBiqkqerP
 +HNWYzXXdKKMfIWVM=
X-Gm-Gg: ASbGncuiBvxyoQTTNE2NsG/2cRsrc3jkq7YdHIhUX6tKeT9MAsQGlCH1xxxpsSa2Xvf
 YgS4a3AYzmUBXGFs3aEaacG2C5EuvsyIdk/abjBSgIsMu2plKMjA2vw2F3ZPNNmGDk+XQqrcjl9
 U=
X-Received: by 2002:a05:6512:1392:b0:54a:c835:cc4d with SMTP id
 2adb3069b0e04-54acb21bbc6mr1437808e87.49.1742398955713; 
 Wed, 19 Mar 2025 08:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPw7TuOhHelH50FHleo1M/WlKYhWB2p4CEov8wVI3CyfUxwheKS6qoG66zGvx1d4KxRsUUPfCpL65oojzZxGE=
X-Received: by 2002:a05:6512:1392:b0:54a:c835:cc4d with SMTP id
 2adb3069b0e04-54acb21bbc6mr1437784e87.49.1742398955313; Wed, 19 Mar 2025
 08:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250305134720.907347-1-bruce.richardson@intel.com>
 <20250305162458.1059282-1-bruce.richardson@intel.com>
 <Z9mwaI1dYk_6UR64@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z9mwaI1dYk_6UR64@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 16:42:23 +0100
X-Gm-Features: AQ5f1JqDlk8sCTkb8_lZll-4OfhHbKbB2snAN38EcJI39-viHc_0PdJIZL-OceA
Message-ID: <CAJFAV8xHC5dKtCbNqkJm46Fn6E0zvk_V=64GpS4pYwDBLnYDOA@mail.gmail.com>
Subject: Re: [PATCH v2] eal: fix undetected NUMA nodes
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ww8jEzZO4ZWVQX3Lmexf9JtwtMN8AfGiz6b7I9mZC2M_1742398956
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

On Tue, Mar 18, 2025 at 6:42=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Mar 05, 2025 at 04:24:58PM +0000, Bruce Richardson wrote:
> > In cases where the number of cores on a given socket is greater than
> > RTE_MAX_LCORES, then EAL will be unaware of all the sockets/numa nodes
> > on a system. Fix this limitation by having the EAL probe the NUMA node
> > for cores it isn't going to use, and recording that for completeness.
> >
> > This is necessary as memory is tracked per node, and with the --lcores
> > parameters our app lcores may be on different sockets than the lcore id=
s
> > may imply. For example, lcore 0 is on socket zero, but if app is run
> > with --lcores=3D0@64, then DPDK lcore 0 may be on socket one, so DPDK
> > needs to be aware of that socket.
> >
> > Fixes: 952b20777255 ("eal: provide API for querying valid socket ids")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > ---
> > v2: handle case where RTE_MAX_LCORE > CPU_SETSIZE (i.e. >1024)
> > ---
> >  lib/eal/common/eal_common_lcore.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> Ping for review.
>
> For anyone wanting to test:
>          To reproduce the issue, do a build of DPDK with max_lcores optio=
n
> set to less than the number of physical cores you have on a socket.

You also need to have those cores contiguous for a numa node which is
quite frequent on the systems in my lab.
But anyway, the bug is not hard to understand, I'll reply on the patch itse=
lf.


--=20
David Marchand

