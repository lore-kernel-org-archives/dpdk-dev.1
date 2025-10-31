Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E98ACCF9FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 15:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D88840655;
	Fri, 31 Oct 2025 16:14:06 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4E71740649
 for <dev@dpdk.org>; Fri, 31 Oct 2025 16:14:04 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b67684e2904so1697178a12.2
 for <dev@dpdk.org>; Fri, 31 Oct 2025 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761923643; x=1762528443; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4g3T8UzFlTMpCrC35gpq6X6scEqhc7FALyGLFt2jz7A=;
 b=PrXobmpsZBQkRF7Ak6xcoyg3GinxVpPTKNtRez1MWwhRArgTIEzqlpugOnV944HdsC
 jyk7Tg3gnKJxOe7ilzz5LmQgQonIhe9OZ6KS9f6t+M6Rht4QALmrd+WF4RR7b/glkIPd
 Ps2PJJMHqZtqidnSItdgRivnO9LQ6FcV00vYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761923643; x=1762528443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4g3T8UzFlTMpCrC35gpq6X6scEqhc7FALyGLFt2jz7A=;
 b=DO9xJS9v0KWNWIBZ5S2YrKbxbDcEx9QsxFPHEKBzsClpo3tJP+xdfkM46soaoR68Dp
 UCvOuc8YZcf5cEs8bt3X/j8A3WIcwg7pt2ilgxM3Fy0EIPg5kb+zyMgE0q0cO/0BX0UW
 4ngLsAXxjxdAesADKjEz0eFp3CSgZBiRaVRLA8pwEOaCYGsWTWveXVpqhR0Q9sScGQNq
 I7ieTPXVHc3JJKsoq4gjdkeBX4ZC6Yw4km/OsvttFS6mrOPmt8t6jYnuLHR/JG2bkJGe
 eALmmg1bBANd4rTW44qeJfyYZss76V7K3kAX3OUYLUtjzYe1L08VKKghcOzwsrHVazIN
 Y+vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjD72RjALK/lwIjAk+z+ZchYS+Ir8jzOHE5u/jjPKRTjzUiq3UyqPOAjP03hBU0IluHn4=@dpdk.org
X-Gm-Message-State: AOJu0YzLTinOjkr4Y5d6JpciUIZQyjqN3+p/F6wUBGIG7vUjDKCiVA82
 AWPduhbzXDh3CgBfW/K2F+msUpIdek5Sktf7kiZ5H/ycyVuiTFHh/LzK246uKe6FawAz1RXlEyU
 /I3nu16r3pvfNasi7Q3/wX9MsaEDdE+RWedu4IhQa2Q==
X-Gm-Gg: ASbGncuv3lzkr2MspSEdo+nVh/vs8gYhvdgCZsNYsKYhsh0Av9UhDH6gaNO5JJB22j8
 JX+nM59lnM3o/oA7UJsYLIhXQeqVi595J+keGZkQNn6hkJNw5aptgbZIaaNQ/qPrxqgU+4KTxfN
 OiIQQbWDhkqpDCm5XBZAiDCddRtMNrUMQi0jV/cucvvSeeG4x6h3jqR6NzwCflmmSp+z/jWBLm6
 vrRASOvd2AeTn4YFTmT+FDaYnwo4CMy6OWGSIsKobLqq/Ez4Q/VBRVFQ0SIyDtyReiLysK8ahs5
 QmvLIEqf2OT8H04kgg==
X-Google-Smtp-Source: AGHT+IHsd9csprSugW7KlQcLhFxTW5tqsClstFSG3lm1hhq8NZgRt/fL6J6IPYxc22wlbw+lZax/zrIP8YrU+id/Oa0=
X-Received: by 2002:a17:902:e78d:b0:271:479d:3de2 with SMTP id
 d9443c01a7336-2951a3d0b37mr59237025ad.13.1761923642999; Fri, 31 Oct 2025
 08:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6551F@smartserver.smartshare.dk>
 <CAJFAV8yn0n2B32W1WUaZSKs1N3DbBPCGZxrT-ats4x0mo0Py-A@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65520@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65520@smartserver.smartshare.dk>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 31 Oct 2025 11:13:01 -0400
X-Gm-Features: AWmQ_blvxGNh-AlBdRlpbkFiUPpd6UIowrvDk1CupgTR2CYUIkWUoUPdnijdLA0
Message-ID: <CAJvnSUD8pJJeXYQ1adxC0d5mUT9Zm7jODoufrDjePN+7gy3MAA@mail.gmail.com>
Subject: Re: Disable SPDK testing again?
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: David Marchand <david.marchand@redhat.com>, bruce.richardson@intel.com, 
 Aaron Conole <aconole@redhat.com>, dpdk-techboard <techboard@dpdk.org>,
 ci@dpdk.org, dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000dcd8da064275d0ca"
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

--000000000000dcd8da064275d0ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 6:02=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com>
wrote:

>
> If we disable SPDK testing due to this SPDK bug, how will we notice when
> they fix it, so we can enable SPDK testing again?
>
>
One option is I can disable SPDK testing for the "per-patch" testing, but
leave it enabled for the periodic (once per 48 hours) runs on DPDK main.
That way patch submitters aren't left wondering if their patch has broken
SPDK, but we will be able to check in later on the DPDK main periodic
builds to see if the SPDK side is fixed, at which point we can re-enable
SPDK for per-patch testing.

--000000000000dcd8da064275d0ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 31,=
 2025 at 6:02=E2=80=AFAM Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smarts=
haresystems.com">mb@smartsharesystems.com</a>&gt; wrote:</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
If we disable SPDK testing due to this SPDK bug, how will we notice when th=
ey fix it, so we can enable SPDK testing again?<br><br></blockquote><div><b=
r></div><div>One option=C2=A0is I can disable SPDK testing for the &quot;pe=
r-patch&quot; testing, but leave it enabled for the periodic (once per 48 h=
ours) runs on DPDK main. That way patch submitters aren&#39;t left wonderin=
g if their patch has broken SPDK, but we will be able to check in later on =
the DPDK main periodic builds to see if the SPDK side is fixed, at which po=
int we can re-enable SPDK for per-patch testing.</div></div></div>

--000000000000dcd8da064275d0ca--
