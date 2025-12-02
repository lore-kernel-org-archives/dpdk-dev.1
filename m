Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FEDD1171C
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:20:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3371C4021F;
	Tue,  2 Dec 2025 18:20:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3F43E400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:20:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764696048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6uw+yFmaKDv7T8FONC13RVnI+nFuQiklNJ3QhDYS3jo=;
 b=RI19y/7CJDe8VL+mHhcz9f+1UblrY9N3qjHz+rPf9P+lXpE/6CRGHCmV/agDqJTVvW0rjY
 iHUO0vIZ+ns3T8Kv9ADWtn5vgLL4LrnbxI+0qm3yAHvC9InMI6wIcooEZ+4Y0Kh56uuhUX
 Zzo3KPiINmRQhO0hFD8teWMLtdtTNA0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-aASKntrhNjmdKfSd9Woe8g-1; Tue, 02 Dec 2025 12:20:47 -0500
X-MC-Unique: aASKntrhNjmdKfSd9Woe8g-1
X-Mimecast-MFC-AGG-ID: aASKntrhNjmdKfSd9Woe8g_1764696046
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-596af6ada80so3027810e87.1
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696045; x=1765300845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6uw+yFmaKDv7T8FONC13RVnI+nFuQiklNJ3QhDYS3jo=;
 b=hxNlg78PjAPFXaKIkcD7PPT09q2VAx8hJlnZJNs/2Kx3OPol6j+0diwQnaPtit1/Qr
 i4ubHpTuHc6wnHO2d6qUrc9PEmQcTGLVPRPlJy4sTZAUi9HC/8y7ulZiNu4yr1fuClYI
 hCSaXRLpX2onFEBiUnuLnyNE3ydpC3yHtuRpgNoaesOX9ORWR4Xc0g+srhOfdVcuqNx9
 bp5FizwULRo9r+N+QI0qs6IqMCGQ8xbb57a2ZI5WSzUJXpwX2XYOPjWnD4PNon/EWY6v
 Mmft/1A3IZ+xtGhNuw0BqQ/GE/jZNHWqs3WRe6xXbzZ2blTiSevFhOWQ9UZSUrKs2ShO
 2cDg==
X-Gm-Message-State: AOJu0YxHJFA3urkmzatCz6zbtM+KjJobnhJLhgc1l6dGEBAJ33CHkaRt
 lE4U1yolI8tLUxDYiejPnRmSKVBGzGDvnlNnfapl1QDqwrukbuuuBcbZE8dFLxLS8xP8xEGFm6i
 cLRwwcTn0ega4wUL3+60loiRuQjHsg0/fQtkV+kgiATnr/ZhzZYrefO2kusLIalNuyePu586Lno
 /+Hj5IPriqbx8mW6+xL5A=
X-Gm-Gg: ASbGnculi+JwUsmhiFVhDrytAjj+eHkRkuS7m57+uAzzt1YORCvRYvvHHNmLvccO5Dy
 hJUTHLFYHBLaRRJdIIZz6ZvuBMeG5QiRVqk3TtiBy9s8lipUs8y7e+Vk8SIhf0cN/wlhpLcp/GZ
 QvD+KYUzt2YMux6w5GX/ovWSYoOKKCHXGSo5ghhTYvzWtgbYldBE/YukEYvr5nqdqgHk9V
X-Received: by 2002:a05:6512:3a82:b0:594:282d:f40c with SMTP id
 2adb3069b0e04-596b5277be8mr10877057e87.31.1764696045593; 
 Tue, 02 Dec 2025 09:20:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI5fnOiztb3uMDLXrvuDn1QEdWcwk6aCLmd/CksBgQCYJE7kRMjP2zNcMML1/f9Bg/i4uvYcfe4J/n+2aXPbg=
X-Received: by 2002:a05:6512:3a82:b0:594:282d:f40c with SMTP id
 2adb3069b0e04-596b5277be8mr10877035e87.31.1764696045142; Tue, 02 Dec 2025
 09:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20240718191049.84865-1-stephen@networkplumber.org>
 <20240718191049.84865-4-stephen@networkplumber.org>
 <CAJFAV8xvsa97Zi5Rc8M2BRKz7MDKb_DEM3q4UnnFduYBW77gEA@mail.gmail.com>
 <20240808091244.5039568d@hermes.local>
 <CAJFAV8zESsq2H0cK3=BtwJb0XOF+0yTwnZRHLUqwX6eDavaDaw@mail.gmail.com>
In-Reply-To: <CAJFAV8zESsq2H0cK3=BtwJb0XOF+0yTwnZRHLUqwX6eDavaDaw@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 2 Dec 2025 18:20:33 +0100
X-Gm-Features: AWmQ_blPtUGmXtqn94uk5MQ5CpsXW0rjyZmjF3MvJGXANCJ92WqzPjIDjkQ6bqM
Message-ID: <CAJFAV8x6Q1w92mxN3tSvvQREzwMYfwx7-6Qb=5ikbXxVKkp7qw@mail.gmail.com>
Subject: Re: [PATCH 3/4] test: make red test part of fast suite
To: Stephen Hemminger <stephen@networkplumber.org>, 
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Cristian Dumitrescu <cristian.dumitrescu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SfNlgTN2-jVtW00nXUZkcA8-dyp-lrO8oeMEbz7VF5U_1764696046
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

On Fri, 4 Oct 2024 at 14:17, David Marchand <david.marchand@redhat.com> wro=
te:
>
> On Thu, Aug 8, 2024 at 6:18=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Tue, 6 Aug 2024 14:28:13 +0200
> > David Marchand <david.marchand@redhat.com> wrote:
> >
> > > On Thu, Jul 18, 2024 at 9:11=E2=80=AFPM Stephen Hemminger
> > > <stephen@networkplumber.org> wrote:
> > > >
> > > > The red tests were not run because not part of any suite.
> > > > Meson warning is:
> > > >  WARNING: Test "red_autotest" is not defined in any test suite
> > > >
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > >
> > > There is an open bz about this unit test.
> > > https://bugs.dpdk.org/show_bug.cgi?id=3D826
> > >
> > So bug reported but no action taken. Maybe time to turn off RED then :-=
)
> >
>
> That's an option :-) but we did not announce it in before v24.11 LTS,
> so it's late.
> Can we schedule this for next LTS?

Time to schedule removal, especially as I see Bruce re-adding this
test in some testsuite.


--=20
David Marchand

