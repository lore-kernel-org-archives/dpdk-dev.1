Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642BCE8B361
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 20:58:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17EEC4060F;
	Tue,  3 Feb 2026 21:58:17 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id D1569402EE
 for <dev@dpdk.org>; Tue,  3 Feb 2026 21:58:15 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-126ea4e9694so4193534c88.1
 for <dev@dpdk.org>; Tue, 03 Feb 2026 12:58:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770152295; cv=none;
 d=google.com; s=arc-20240605;
 b=XXy4eIcM3x+W5vDbOaWm7ycQBZ5VvYICMR2ows0B8S42eM6Q3KZLzCEA5GZ3qednpu
 OSXo+N/73vBgIB0KUcuyjde+wdjzT85M7UgkmqeGWVd4v3vxf9+GUlohI00O98fPp2hV
 3QFMZDLzAAXp8eWEcdUg+yYIpPFtjTwwCMPqed9LgmwI7S9xl2heVmi25suzon63swrz
 Bo1nrGjDCDJ5sxt4QhlZSNg5hrVYcCw5t1zAWF2YJu+XWux69pLjw3n54U+/CJFfXCsk
 rE2RV/pLCJsA71wfP4R130/UHBWcVUo4ipv0rmKJDs2AgmNPy2TMCyG4QBUyZA8TuRJj
 +3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZEpX6PpQF/knFU48px2GE04bmzu8Izwr/VOCBmk8i30=;
 fh=ktZQ0KBrRSN6iVnNjXFXx6+jx1rBeC01WLlcXbnlLNk=;
 b=HuAqMEdNEtTLtrw2PFPtARk9dl4GCNEXbSPN8DLznuQI85NgTw2GTA7BQJTSArGcSN
 lDDmsoaKA8Pq1HTAy/Jm5hhWTDG5U2cf9ikdiLSxBlvFKgCFYThqpyMnUWjkdUZ5cXe/
 rrlyRCGl7r8rG2LiK+rA//tDi5qHj3SWEmqNSizLTm0rAJhV5CFEzBJdx1L1HODl0Az3
 18/cCxNSD9WZAQbwKZopbvGzrIZllQ0f8P/KuQfRtgr1PRI+GrUO4L6Yx8S3PQNwO+aR
 orQoshj7IC+Pn92KmS6AoBukEG/7U+zfNca0kmSHN2bYLCPhukN+uj8YINXLgrsWtx2F
 tC6Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770152295; x=1770757095; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEpX6PpQF/knFU48px2GE04bmzu8Izwr/VOCBmk8i30=;
 b=QRqQvOQHUvW9HVwQI0QhMch3Zx56C0fhjxuMgNA8Al9FPJ9H7n/I1/gu8Y+SuGD9OZ
 kMyU/R0UFTHdwXTW09SrU7sXs8cL2ZVAeG67PXW6dgaSG8D/nrQJvxsUzx1hl/laZz0v
 1Tcos0mpWmUgw2AjX4RQeP+a6IYOZ4ZLeXF8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152295; x=1770757095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEpX6PpQF/knFU48px2GE04bmzu8Izwr/VOCBmk8i30=;
 b=dvpZrEpw1SaRYmnEZ6nS1p5hyxKCLbwQjdgtDT62/xm1PMgkFk0YLbmAaB2bBfjBtr
 pqf6pMWukxgIrXqM1/wDGezpLHeFKl32jlAnXYJXai7A0Wnx2Slz5GAftMZIQv1SZfs9
 Bo91HpdC9oA/o/E+ETZbWnaM0rN4G7um4zPeK4nEm7FcyHWhsVzVumEfBO5G7J2UUlUB
 Lt4vZFewgMb29cq1y+HDyFhC4DQ1SBTwdSxTcd8tlukEAhjYH5XDRK/ywp0SH03495kJ
 S+AV1vtiib36/wVMxzJ+SOVdsU65b9qUXAf9k6j+XSbOsejI0gBUfE0Avqvv7GU0zeYr
 Xs6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Kv4SORyC6REkBIIzAVnhVYMpZbUbSGvkwzLfXHnXOVd+Dewyc66SGX/YuKtv1HGiJ78=@dpdk.org
X-Gm-Message-State: AOJu0YyEE1oQE8Eve2fSjEH0zW0LU9lfVpOL5EqECBWD69k1g5wPuU6y
 UqWXpkmIF1V7xOfe6tTQKfpiciazdRFr1OdteQLWbU/0SYPdv3EUPsamvx1y26Yi7hglFQCwb4q
 G80mrk7LK4FKYgO/VLkzOgGwuQqoDdMViRT1CmQr7xQ==
X-Gm-Gg: AZuq6aJPVA5YQ9PPL+1fitfiUkl4H9eNEQ9IfWwXMZ6JSIbJE8I7sVNYzTbi+gsTQLx
 vuZxdRvNO3Mo6ObPes67aujbMEwLUhA4S0P5Ctx8uwEHr5t9IhRwbiqdtvvr8PoenUt8Yxcnvg/
 n3dGlv+FHrfclaR2cdGBulSwFFx6v9O3Mp4fEGfGh6x2ilr1RxO3JMELnldiv0abZU6FV8WpOD/
 LK+7P95qW+q/1bNzE/3rxCP+q+xtCLPA5bjRkcs27KYH9slHxT1AZfOP+AUxR7hJM4VlZDdlkw8
 fxiy9ll6sOG6QIIbCU7SJk52FPcfjkteaQWwXh526Q==
X-Received: by 2002:a05:7022:a85:b0:11b:7970:ea3f with SMTP id
 a92af1059eb24-126f47bb0bamr388991c88.25.1770152294857; Tue, 03 Feb 2026
 12:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
 <CAJvnSUC3ze51WFHx=cRMGKezrwXvo7fCXH8o64qJsbWf9SXsZg@mail.gmail.com>
 <aXM5LAcV6EC6L9VS@bricha3-mobl1.ger.corp.intel.com>
 <CAJvnSUCd3MpiHbTuv17bXdQK+rfeXwiacW3=sJqpJgMxO3YkFQ@mail.gmail.com>
 <aXOXIJerY0lZz9VA@bricha3-mobl1.ger.corp.intel.com>
 <CAJvnSUBOU7QTb6kp2RypHnk7rF5QjSjk5G8WtsEEgT23VmW-vw@mail.gmail.com>
 <aXOdtd5SjD08kkBv@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aXOdtd5SjD08kkBv@bricha3-mobl1.ger.corp.intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 3 Feb 2026 15:55:45 -0500
X-Gm-Features: AZwV_QgvSOwoM1nmJaa0GASpgt9y8hLYs60ij0UZSCUQxoHRNS7Tm6aRbVE2Pks
Message-ID: <CAJvnSUDvWTA+W6PuOoNbSgLySyVRH7ULL47brS8WC7brTG8u=g@mail.gmail.com>
Subject: Re: [PATCH] build: bump meson version to remove warnings
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org, ci@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>, Aaron Conole <aconole@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>,
 Timothy Redaelli <tredaelli@redhat.com>, 
 Matthew Labrecque <mlabrecque@iol.unh.edu>
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

On Fri, Jan 23, 2026 at 11:11=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
.
> >
> >    Okay, both of the options above sound good. From my end if I had to
> >    choose I would just do the first solution (install meson at runtime =
in
> >    all cases) because it keeps our process uniform across distro testin=
g
> >    and there is no "special" container. But, the second option sounds g=
ood
> >    too so please let me know what you think is best.
> >
>
> Go with your runtime solution, it's fine - and possibly better.

I realized after looking at our scripting that I pushed a change last
year that does the "meet meson version at runtime based on the output
of buildtools/get-min-meson-version.py" last year. That was probably
when you originally added buildtools/get-min-meson-version.py. So, I
guess we can say that no coordination with the UNH group is needed
when the meson version is bumped in the future. The same should be
true for the other labs because as far as I know they are using
dpdk/.ci/linux-setup.sh for their CI jobs, but also it definitely
doesn't hurt to ping the ci@dpdk.org mailing list when these updates
happen in the future anyways. Thanks.
