Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F7C54754
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 06:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9CB340667;
	Thu, 15 May 2025 08:59:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 75581402C2
 for <dev@dpdk.org>; Thu, 15 May 2025 08:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747292363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUS1RaZh0vlfA1rkpRytXVmih9Eoz+544V0Yu6fMTl8=;
 b=Tsxi731q1MxJNfvzvrsvVCEe4b0DBbryDI8EICC+9p4hxFeEghMS3f6yGIYwrxkODpRjpc
 lCMrcNSr7P14mtHhtzwzfnBCcOuZbDezgdAmS5TxKmbTLR5gH3er2irQZWI+cIHQ5Ncezs
 G4E//RyB72T6lUVwYowkt6OyYXvzrPo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-NDT8gxpEN1eAX7ej3HZqLw-1; Thu, 15 May 2025 02:59:21 -0400
X-MC-Unique: NDT8gxpEN1eAX7ej3HZqLw-1
X-Mimecast-MFC-AGG-ID: NDT8gxpEN1eAX7ej3HZqLw_1747292360
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-326c9f269f8so2874831fa.1
 for <dev@dpdk.org>; Wed, 14 May 2025 23:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747292360; x=1747897160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUS1RaZh0vlfA1rkpRytXVmih9Eoz+544V0Yu6fMTl8=;
 b=NIFnXHYurAcEoMUTX36CyMwMv9aoFuCLEDdWStbmAQH/AKRbGBR4krAwKgpQRmv0CM
 awP/2wLHNDR4HCOIHpqNhRyZUkchW8SSZ0btKduhWPqWMLvxGHpFyq9VP1lKcZohUN0L
 luD8HkeU+/oPcx8exJdkvxGU1fAqX52qjUZJSAMS36oG1lpWrTWCAKXqaNgPnLwAqQGq
 CP7rl6ESaJaGQOGdypfDcyk14F4JpF+L52i5w1ol/f8J887NT6EbJalxbW4X4fJaIrcx
 Ugoo9lOjzLap2eSS6YcNrzUcePnsuZ5PigQX4EqVX7locThU8/qoXvEaoc3Wo+8s2ufM
 2mQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1dRwKM0KyRfnBfzaMp/FZ7X+TG1+oGnMRDA6rCdy4v2684m6AGZEeOdSrcJ36g2+f1zI=@dpdk.org
X-Gm-Message-State: AOJu0YwDiH74KpIqsLxakaGObL5KB4YyimqEzRsHkaTicWgyUyRRDWen
 alBs3+dTxmx5HIfDFhmS7PHsa3OUvvR2BFBrsbphZ6Z2X8JRULr+Dtzn7Jqqdzpz09xRAJwUdGh
 7wrD5FRDB5/V5Llpuwbtxeusa+6S+C7II+qkbGwiIS9+oyJimeWEIyg6mZpcSD+6frFxn4F5uZy
 b+8UT4VbjPN6wD6kA=
X-Gm-Gg: ASbGnct78CCI3spxZULPjNlC5akre3H/D8lw8e6iKbHt1gLXMN2TvUtKiWuL6UimK5Q
 EP8r6tKkkWlArUQ+bDPkjVdPybFSL429Psyk5iTb7CRe3P0Ri6Z1zhkdu40pBeRp52cE4s/8=
X-Received: by 2002:a05:651c:b08:b0:309:17:750d with SMTP id
 38308e7fff4ca-327ed1d934cmr25713081fa.27.1747292360085; 
 Wed, 14 May 2025 23:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF79mLvPQDgQ9TR4cWIdPKoaW+vg0/uj4nPCfUvMTxcCIG/gOpX1Ec5rb89q+hKcif6z7fbQqK6nfdTABHY/Sg=
X-Received: by 2002:a05:651c:b08:b0:309:17:750d with SMTP id
 38308e7fff4ca-327ed1d934cmr25712931fa.27.1747292359660; Wed, 14 May 2025
 23:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFAV8x_u9-PHh_1_3qimFDGseSYLbZBprty0jhKUZxehzOo=g@mail.gmail.com>
 <CAJvnSUDxPDuFyZytko1mxnE=6UQHvJ1OTbYBYnd1xM7zozsfsg@mail.gmail.com>
 <20240322163430.444bed0c@hermes.local>
 <CAJvnSUDZF9oTtj9yg12WuYRAQSVLsqxdFbdtFNu5Om1S1sWB4g@mail.gmail.com>
 <20240401174624.124d2f2f@hermes.local>
In-Reply-To: <20240401174624.124d2f2f@hermes.local>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 May 2025 08:59:07 +0200
X-Gm-Features: AX0GCFvmUjcX8CYB36LZ0m8o-7YmPKGdJPtOdQDhirBfkIKJhfPD_lS6F7uIMR4
Message-ID: <CAJFAV8xyZnjXVdbi3hsiSKMN5200H6tymEpxZ3O38X-Mh_dsFQ@mail.gmail.com>
Subject: Re: pcapng_autotest unit test false positive
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Patrick Robb <probb@iol.unh.edu>, dev <dev@dpdk.org>,
 Aaron Conole <aconole@redhat.com>, ci@dpdk.org, 
 Cody Cheng <ccheng@iol.unh.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2OZ04btqX_oaXZtd0-k_pTjFnEP3s1-fnc0M5N85XHw_1747292360
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

On Tue, Apr 2, 2024 at 2:46=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 1 Apr 2024 18:26:44 -0400
> Patrick Robb <probb@iol.unh.edu> wrote:
>
> > Another idea - maybe multiple timestamps are gathered from different
> > CPU registers during the same test, and they are misaligned for that
> > reason. Maybe we can try reducing the cores for each unit test to 1
> > and checking whether the issue persists.
>
> TSC is expected to be sync'd between cores. But of course packets can
> arrive out of order on different cores.

Just a note that there was one more occurence of this false positive today.
https://lab.dpdk.org/results/dashboard/patchsets/33170/


--=20
David Marchand

