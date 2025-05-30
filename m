Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B05C5B549
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 16:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDD64402C5;
	Fri, 30 May 2025 18:07:42 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id EBEA8400D7
 for <dev@dpdk.org>; Fri, 30 May 2025 18:07:41 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b200047a6a5so2847597a12.0
 for <dev@dpdk.org>; Fri, 30 May 2025 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748621261; x=1749226061; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TjrbV9p70YCFX1vNxereCTN2xPQPN8hBaWSbW0UhmBw=;
 b=bEHGxgUZdXFKJ2Fo+fVJt83a7B63DSC5aV1lC2yNrdp5KeKmEPZMK2MMzN2zlOOg2h
 J++aEWHUl3vhRP7JLBwx5kqg1edxpzhn7UwzZy2gZQDIRlB3e6ausiuPOlisz1P2SXtg
 6PGgiWte5kx8yx/TzjcuHHfOjW2IqtmxIW1HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748621261; x=1749226061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TjrbV9p70YCFX1vNxereCTN2xPQPN8hBaWSbW0UhmBw=;
 b=Sq2CjxXC6Ln8/RL/3DoLpcv5Wi5Jm512L2Wz9HlPvMpJMmrU3L2hzmb7O39Du1j4Qg
 9ugVYaJdzeDrbkFvNjesil6MMqjl0V9WVpAT0PpHhnbYEUu4BIZCXTTiWVX65eiFY82Y
 Ga+1I5LwDYXuv7VNEKNL6QP+q8sxEg8HvTa7Xnv+upkl6w7+Aw0Q/xkxTjW0j6D+G0nI
 PGDAJOvfBuZ+2YQJGcmOmh5FdyJiEcyVcgeyuB32b1kOUm1qDQBA5mWN+2WKi6sROLgX
 fBpZK1EzARb2GXewI/tfhYmWDQzJbEDEIsTyEtWxmdESmgvCgmrnKm6dA6DUI/gqWaxP
 JCdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT6QL9j9ILq6fJdmxU1BAm1Re/AB/8S5HH49qsSFsdrcNtozVPLy82SJ40GBxMVawqUZY=@dpdk.org
X-Gm-Message-State: AOJu0YyRYjTy97/uLNrl2u93EaGiEhdP+EwLyDNquMJCuzb9RRfff1tR
 jHDNzX0fnPu2EZf8HIic1zT6NvavViubLN6/eiKpxgQhdiP0iIdmbMQUlQ8KE8+1CTQKswrSZAU
 YOoxdt+L4k4lduW44a/DQPdOt9JDRzP7iuKIUsNoJCw==
X-Gm-Gg: ASbGncuOY2rDenjtQ8cdbMX4yAxAo0VuOYZqRiwZrTwlAd2owtb2GQncLiIPzbEyyMs
 J1rbUyFeul/CslEnPBu0W6HV2QEMqeUff7JS1feQLdHtuBENoys7yfXIcPsV2Ve9Jsh1DgHG2N3
 qqMpMACXR360ySc/6Do0aRLmDUkV4UK6BEnL2DkDOUVm6Ql1Q7UrWHkehlJzqJFovBXQ==
X-Google-Smtp-Source: AGHT+IGEr6PSvWPQVdBiAyDUxgwntnxd4H19uj0BCBx6UzIIjNYqH9wBlpm0NFMgQzOwHRJ63914vDEJjCVncZ4eQM4=
X-Received: by 2002:a17:90b:5487:b0:311:9cdf:a8a4 with SMTP id
 98e67ed59e1d1-31245df03e9mr5980876a91.8.1748621260783; Fri, 30 May 2025
 09:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUDfGsKk0c7Mk9jsRMxh4wO6M32quitrnkDPWHHiTZEiCA@mail.gmail.com>
 <f7tzffp7rqw.fsf@redhat.com>
 <CAJvnSUBh+8--cnqXDtLChD+iK8s98g+t=Hi4x-HEa8iH6fpUiw@mail.gmail.com>
In-Reply-To: <CAJvnSUBh+8--cnqXDtLChD+iK8s98g+t=Hi4x-HEa8iH6fpUiw@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 30 May 2025 12:02:41 -0400
X-Gm-Features: AX0GCFsdbf70Y937P2x0A3D9FBtdg2Z_yD1lOlEETdiZKrjywYeLrWPxsX6vi3U
Message-ID: <CAJvnSUDvPZJvqsiy2J4a-b2i0f-BukJiZt61s6PR55vDh99YzQ@mail.gmail.com>
Subject: Re: Polling for patchseries in DPDK - the /series/ and /events/
 endpoints
To: Adam Hassick <ahassick@iol.unh.edu>
Cc: ci@dpdk.org, dev <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>, 
 "Brandes, Shai" <shaibran@amazon.com>, zhoumin <zhoumin@loongson.cn>, 
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>,
 Aaron Conole <aconole@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000018969606365c9da6"
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

--00000000000018969606365c9da6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I went looking through recent series on patchwork and I think this is a
good example of the timestamp condition:
https://patchwork.dpdk.org/api/series/35145/. Looks like the original
commits were made on April 18, then the newest version was submitted on May
5 but the series record retains the 4/18 date.

And I see that there is no project filter provided by the /events/
endpoint. https://patchwork.dpdk.org/api/events/

Adam, would you agree the project filter for API requests is pretty low
hanging fruit? Seems like a common sense improvement to me.

On Tue, May 6, 2025 at 3:08=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:

> Thanks for the clarification regarding the datetimes. Yes let's clear up
> any remaining questions offline at Prague. :)
>

--00000000000018969606365c9da6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I went looking through recent series on patchwork=C2=A0and=
 I think this is a good example of the timestamp condition:=C2=A0<a href=3D=
"https://patchwork.dpdk.org/api/series/35145/">https://patchwork.dpdk.org/a=
pi/series/35145/</a>. Looks like the original commits were made on April 18=
, then the newest version was submitted on May 5 but the series record reta=
ins the 4/18 date.<div><br></div><div>And I see that there is no project fi=
lter provided by the /events/ endpoint.=C2=A0<a href=3D"https://patchwork.d=
pdk.org/api/events/">https://patchwork.dpdk.org/api/events/</a></div><div><=
br></div><div>Adam, would you agree the project filter for API requests is =
pretty low hanging fruit? Seems like a common sense improvement to me.</div=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">On Tue, May 6, 2025 at 3:08=E2=80=AFPM Patrick Robb =
&lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=
Thanks for the clarification regarding the datetimes. Yes let&#39;s clear u=
p any remaining=C2=A0questions offline at Prague. :)</div>
</blockquote></div>

--00000000000018969606365c9da6--
