Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C28CCD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 08:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 959E840150;
	Tue, 23 Jun 2026 10:34:03 +0200 (CEST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id 4EF764014F
 for <dev@dpdk.org>; Tue, 23 Jun 2026 10:34:02 +0200 (CEST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so9919017a12.2
 for <dev@dpdk.org>; Tue, 23 Jun 2026 01:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782203641; cv=none;
 d=google.com; s=arc-20240605;
 b=TLLj8gXdp+3Qh4T8wV55RMazxet+Vancdif2w9K/4W7XZ+jvv8l5xJwv0zQzN9FuLL
 wouhcXsGCw7R4speLaOPdy4NE+bBhbhkfg7S3hNeJ7JYwZWHpQJahKElaizM5nYlbX+z
 YeQGnE4ALpQLaR/AZ6bNnB88u11APpYW0A37elxvOpwNCB5BTz5rcPD75yUVVoOr6PBJ
 yyuEHMAeBMEMG9vKEU23xXYY/EfN0w6ZD6xPh1h7LBU18JFoTUr3DtxhncR8O83auUNt
 eZiZclegjAa7B66gHuuwEKV+xoTJGPDiev78y6R5JGwVZ6OnShnEY5XNKTw1QFbr4saN
 jtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8oMF1Z7YrMuaFcPxv/TCn9oHOLDDVhii6rSRoLoF65Q=;
 fh=ie/XjKJ+CY0y2o4RKE+mx4xWqUX8MkWmfapd6+Lg4cg=;
 b=NjyurkVsNWVd1Y31c/sBwqI0Gr/VTjmwBhXxYdHL0tOzCUhUkoS5dkt1A6UOWmuupO
 Gmr+pbI1CoH3bvaGTDlI9KVu0Xusbie9fYDg3i9+4Gkdve+tyF4gtS1O31ZuSdTXy4bg
 zZqCcKZhTDMyU2ncD9tOlS2lmq4PkK6QGdFouEXJDugqB+ufvbk2vyxx8i+Eh49RA7kQ
 Rn5/jQgIWDn/+Tu0MPgHRyNkfZoCLUjPgkscIvOwDSYmLx8zMX9iedaC4g/HF0KHFwKJ
 96Gq+/z/eZTxH7DIbMUDA2VASjegjxmBFZ8oEYDMsoK3/ppQJqSUpOYAAo3fleHmC5Qu
 wUWQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782203641; x=1782808441; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8oMF1Z7YrMuaFcPxv/TCn9oHOLDDVhii6rSRoLoF65Q=;
 b=m1EUOaIN3eHIsdDZs7PQC8+i65MFmQ0j10yC9OitZXqcghBgPzjOYgwYVWT6qXn+IY
 AzkxJJU2ycN3iocRFEOIPenXHNgOUsE7IFkQs0775hL1LS59nyU60n2/oiEtbU69vF3X
 8N5i586l3xixqrqI4Tw3jsi96n1lRVNdIaXhN7KGgjIiGDQFi8Nf1ml6eYKfNLkzoeRt
 dYBxqm/cJO38GSXjoVhLr6BP93Wqp3D7LzYHTzDPDzaI3SlFmS8Fm+JKvXxlpXLJAdIc
 q915zbWIMAIIhRc6jdcyUo2EJusMGTawlo2A9NTSL3qOVJRGMt4YQkMMPCTlGOfML0So
 YESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782203641; x=1782808441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oMF1Z7YrMuaFcPxv/TCn9oHOLDDVhii6rSRoLoF65Q=;
 b=FcWBaN82gP2m0ynvX+X3131VojR9eTK4M2rNS3cwcoadMPY3uFqOaGMrFTal3v6fgD
 d7pVLJ7z0ieOyZIGJm64RHCr5rCLCcRn9WWWxSJFYNWoBy4CSAik138tCmLroWlZl3m6
 2mSZqVQqDDXRyU6mH0OeWVkB12CB+YXwoPilTaAsWQtP1fyLkSyruqvlDf4Eci4POWAP
 mMYAt4RQWbJbU15WCjBXOm9wBzKPlF9uw1ralZh+8jR4JLYICgxN/wC2XsbIZne6t9Yb
 WTD9VrO16oBw73NPxMLxZthuaAuFBxdpwHJ/iJd3CoRxYsf4cEXt2DuqJL+m6pCMiOAb
 /Ydw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kyyj/X8MiAOdA+FAFPDSnyMrVetC2zbvkqs4rf5UxjLLxN6RtMKNpbi3/SIkRW8qE4O8=@dpdk.org
X-Gm-Message-State: AOJu0YxnaIApaMeP+LdoBWuWei/2HXxdo0sSSpgXNLPW42gHdsxmLFXI
 Nemw4DxxlKgKs3yFw1opCppS/FsrtXsyCetG9/8xTYdmE8fvNFESuWtQ8wgeo0DCVph3HDQnW7Q
 NW125Ngfgj2zOZsca2s5D9Efdp/SLDl0=
X-Gm-Gg: AfdE7cmqMycRFzVA2IfrcrziY+tBW0MCs7QDbBCh0rnrMG7kLx1hCfoHMg8uUbJrWOe
 V5o5yo+sGE0phN5ofMhLzTb+ipZJ5ONit9St7+cB108JhM0zktsywxxBi5XRzJNK3Bzke4IBnGt
 qgJTGF3imhhHuhc0cvY2jRCuJytMmOLr1QTjSGtfeSwNfSCXVUP1EsbFu9FeA8Oy0g4Qwa645k3
 XML6LLL85YZ5JdcHkCAIZisaOUR5EyKCkJU4pnukL+JHNDYLXKtJnpc8PEN6Ov4xm56dS9NLnAd
 S6j0BffrdOJNmKwmpzf/gR4UaUBRk8w=
X-Received: by 2002:a05:6402:2552:b0:697:8326:40c9 with SMTP id
 4fb4d7f45d1cf-69783265562mr5052480a12.2.1782203641301; Tue, 23 Jun 2026
 01:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260621184140.2878132-1-mb@smartsharesystems.com>
 <CALBAE1OCbZ9GB1oGYgR5hRtzjRmev2ZFOaSNndf02AZptihOcw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65937@smartserver.smartshare.dk>
 <CALBAE1OZDXfH1FoVLJ=vXVqr=9hYPgqeCzN8h278wN8FbU+XaQ@mail.gmail.com>
In-Reply-To: <CALBAE1OZDXfH1FoVLJ=vXVqr=9hYPgqeCzN8h278wN8FbU+XaQ@mail.gmail.com>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Tue, 23 Jun 2026 11:33:50 +0300
X-Gm-Features: AVVi8Cdw0CRWVWOSnTMhXAMNPeSE1E_1TvVnb-lBRzn0tY-gQbeG0xx7xK6OPyw
Message-ID: <CAHfVqdWKoDqb0uD_HrF8e=GqadThPhZj0vZnRYDW=KMPei0mXQ@mail.gmail.com>
Subject: Re: [PATCH v5] graph: add optional profiling stats
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Jerin Jacob <jerinjacobk@gmail.com>, dev@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
Content-Type: text/plain; charset="UTF-8"
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

> > > > +               /** Fast path area cache line 3. */
> > > > +#ifdef RTE_GRAPH_PROFILE
> > > > +               struct {
> > > > +                       uint64_t calls;     /**< Calls processing
> > > resp. 0 or 1 objects. */
> > > > +                       uint64_t cycles;    /**< Cycles spent
> > > processing resp. 0 or 1 objects. */
> > > > +               } usage_stats[2];       /**< Usage when this node
> > > processed 0 or 1 objects. */
> > > > +               uint64_t full_burst_calls;  /**< Calls processing a
> > > full burst of objects. */
> > > > +               uint64_t full_burst_cycles; /**< Cycles spent
> > > processing a full burst of objects. */
> > > > +               uint64_t half_burst_calls;  /**< Calls processing a
> > > half burst of objects. */
> > > > +               uint64_t half_burst_cycles; /**< Cycles spent
> > > processing a half burst of objects. */
> > > > +               /** Fast path area cache line 4. */
> > > > +#endif
> > >
> > > Is it an ABI breakage?
Can you consider one array for all cases?
also, instead of adding cacheline for this profiling data, can we
share with line 1 that used solely for xstats?
