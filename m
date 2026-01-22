Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE9D3EE68
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 13:48:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE2F04027A;
	Thu, 22 Jan 2026 14:48:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F2CB24021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 14:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769089684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+ToUUZQlsacifu6xfb/sG9nn3yRTVnpxxsYNLdX0yY=;
 b=L1xW0mp+kdi3YuD5SmEoadYQoZ1VxaHatOrkNLRcTHFCdk6g8+R+40+V5dCpdKmjZHEt7w
 diTUuwi5N1mGL09hMWvvrxOE0OmP2q47LmcbRVCCIGOjssvbLhRNN6V45qmU5crXgKgR9J
 KMxBAAdK9U007r7A2G8X66HG6Tegbn8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Rp-GEhl1NK24prsyc4zGrA-1; Thu, 22 Jan 2026 08:48:00 -0500
X-MC-Unique: Rp-GEhl1NK24prsyc4zGrA-1
X-Mimecast-MFC-AGG-ID: Rp-GEhl1NK24prsyc4zGrA_1769089679
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b77f5f4cbso386514e87.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 05:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769089679; x=1769694479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N+ToUUZQlsacifu6xfb/sG9nn3yRTVnpxxsYNLdX0yY=;
 b=uwbf/WmWDrOzZyK9SqNQhl1ePPMHW7+msDC6dEhwr9ulBcSJ1rMW7dCfnTSrc7Y7J6
 w5tkxkB98YnfWXcJ+QTV9r98IoenlBmb9gtRwD1vkUJa2CDQkXAFafDGrEJqhz3B08fA
 /LL3pvhxwhaN4gL7NUh0odoJWE4Nu5TxqFvV203IGNCvWI+9DmHkcta1aERpP+5uQFAy
 VfLIUn3rQ4HVrecFWhTUXE1NLi/KOWPsX6/PUWNOwOC9ele3SWyJYhjNIdEhRJ1+mZxb
 Zq87ou3zKb3KP7lmbyhB6lGwC4Vyj7MvKlBzfVrRSv/nXdknuedFPHWb+oN8D83YOD6a
 Aqsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0TR9g1im0stQMnbwJ1qvLbPeNc9oYc75EjkKMPsiuE327NE0r+H0otZwVmaKmPsYICwE=@dpdk.org
X-Gm-Message-State: AOJu0YzhFRg/xqubONd9de2uXRpJLklX7Rhny5uem8xOfUB7QlzQxZ+C
 FTrh9jvEeX04RRWRCBRZ04ZBH8RHJl6m/Hedjdi9P9bTDmCWzYgLIPrRFXS3wnc+PRJhlNYJaNA
 qYkL/Sm7h6q6YYYpmtEtMEj/34IG2KXBSzd9DO8VdNgTqUPs08Lf9/8zzDekvkvIQSLYc/GvxXE
 WxTkmKjOf21rdkIam7Ljc=
X-Gm-Gg: AZuq6aIJ7PFZBX5im6FLXvMCGMePrkQ/hlkiFkN7p6l6+ByW3mO0wdth3zcmQ8ZR+MA
 dsCWJQ8/7ZZj5xTo9S+64GBekai9qHgILIh3bFzjRr5cDUwd574OYnpUNabfKr2hhAWp+kIq+ww
 balKaTlTm6gZrWuKw7YnhSKYX4XPVtBNkRChvdjfBrXLXrOYzZwS/3U+RG6cBByJokxwTC
X-Received: by 2002:a05:6512:4152:b0:59d:e2d1:bdf3 with SMTP id
 2adb3069b0e04-59de2d1bf37mr237982e87.51.1769089678891; 
 Thu, 22 Jan 2026 05:47:58 -0800 (PST)
X-Received: by 2002:a05:6512:4152:b0:59d:e2d1:bdf3 with SMTP id
 2adb3069b0e04-59de2d1bf37mr237968e87.51.1769089678461; Thu, 22 Jan 2026
 05:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568E@smartserver.smartshare.dk>
 <aXImy8tDAqFygz_T@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aXImy8tDAqFygz_T@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 22 Jan 2026 14:47:47 +0100
X-Gm-Features: AZwV_QjBIVESrF87ZJmY1lXOGSi0EY3KXQ-pd2B_hCiy2FvBdAgRylQKhbafJHA
Message-ID: <CAJFAV8zyEbVUOJsw4ZwN8Zdcrb-C+=tF6gYn0SYm-zOc9Aoy8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drivers: always enable the null net driver [RFC]
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MxPDTGr-C4HUzIlKTssV5F-bJSW1QCdYW8t-3Cs6Wxw_1769089679
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

On Thu, 22 Jan 2026 at 14:32, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jan 22, 2026 at 02:13:06PM +0100, Morten Br=C3=B8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Thursday, 22 January 2026 13.24
> > >
> > > Having the net_null driver always available can be convenient and
> > > allows
> > > use by unit tests, so add this trivial driver to the always-enable
> > > list.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > >
> > > ---
> > > I'm not sure if we want this to be always enabled or not, so sending
> > > this as an RFC. I can see definite advantages to doing so, but I also
> > > dislike having too many components on the always-enable list.
> > >
> > > Since I'm ambivilent myself, including this patch so the community ca=
n
> > > decide.
> >
> > I don't think real applications use this.
> > If they do, they can include it manually.
> >
> > My main objection is:
> > We are setting the wrong precedence if we make stuff like this mandator=
y for convenience.
> >
> > But I agree with the reason you are suggesting it.
> >
> > Is there some other way it can be enabled for unit tests?
> > Maybe the null driver can depend on the unit tests being built?
> >
> > I don't mind that the driver is being built.
> > I just don't want it included by default when statically linking a mono=
lithic application.

Same, I don't want a driver with almost no maintenance on it (even if
it is trivial code) to be linked in a final application.
(it would be a pity to get a CVE because of net/null ;-))


> >
> > I'm flexible on this RFC, so it's a very soft NAK from me.
> > If it can be disabled at build time, I'm OK with it. (But still concern=
ed about setting the wrong precedence.)
> >
> Yes, I agree.
>
> Why I'm proposing this is because, in order to give me faster rebuilds an=
d
> because of the hardware I have available to me, I generally set up my
> builds with "-Denable_drivers=3Dnet/intel/*", since that really speeds up=
 my
> dev-build-test cycle. In doing so, though, I do miss out on having some
> unit tests available when I run the fast-test suite, which is why I
> suggested this addition in case there are others who limit the builds to
> just the hardware they are using.

Unit tests are mainly run by the CI or DPDK developers, so how about
putting this addition in the always enabled list under the
developer_mode check?


--=20
David Marchand

