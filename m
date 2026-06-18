Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553AACD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 01:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E6454027E;
	Thu, 18 Jun 2026 03:47:14 +0200 (CEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7299A40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 03:47:12 +0200 (CEST)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-39669bcaadfso3725241fa.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 18:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781747232; cv=none;
 d=google.com; s=arc-20240605;
 b=jvXILoielXC5sruu64GtJLpwct18VZ3sLd24D7zMVP9U+UgW+d7nC1Mgf5/ioFT1Tr
 YnT/LKMR97B+29amlqTqUKaRbxv+miO9wnqlTPgnGFvYSoXS5gHlg+PTTQ7DWBBOXY3P
 QQeuZGLGj+3Xkk+sYPbpKj5Ke+hBdG79jcO1IDNb9QNnWyz6NsOv/h68uWbN1XOqO2iI
 jdl/LaZoHITNw5qw8xusKMSDXCtYoAbpD5s9cttL6u5L4cVxV2GTJjnIWeLORBYtlsF7
 IQUoUOLsw2FKdftKPFBW+uY2AcQSmnSuTkAWz32gb6liPxdclucdG5giZ9qiDdlrTBO+
 yMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6ZnUdwrXEJHO5dfBUQ8EAJCU+Jzi5eJCcKWHv3UVVbA=;
 fh=DHOoBj7LO4vIeryg1DvngdF32JtYMB6UtplBtYykrIE=;
 b=aHpJh892pOOHt05mDTXfI+kNPehIJyx0VNoEMy+70+Pf8yvM/3DVp9BMpws7FH/3Sk
 R0iBcDLPR0eDvPDrdEsj2jh/Q1U537KxfdlVp0mF8bgctRsTMj0UikEbCLH1acJNRxCU
 hs43SgnMugJVdntDq4O52kdFfLMqGzE4C99MN7BGfuqSmjIrZ+Vg5LdiSH7ALEmLwwQv
 UEolbI0cJkyJ8d0L08dm9FNXD2FuIOOmWWI3/ui6Lgr20n95CWL1AQN8afiJ+0WI+xZZ
 +Z9PruAJQvA6+7oqlg/Q1cDs/jBdiLtk5fOesPLHH473lS7JCXna1bj9sTBeh4+tQ8aE
 xLuA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781747232; x=1782352032; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZnUdwrXEJHO5dfBUQ8EAJCU+Jzi5eJCcKWHv3UVVbA=;
 b=I5lPFSU1B16u7JMHjwa/YP1JhnWa+tyCfBR3xGQXeBsq9jN61KKBq65i/54137gMQY
 dJ1a7QCEE0f30QsXBSj8sOJRVx9pKClVILfOWxTJ5Azh2kdqHo1TDKzLyS/tQCHg0c2x
 fRvBF3WOrT4r63VscdyQUxTb3MA+EDs1PfcilFrV7IL+jAi5ah+oZ1vNwmz0yOSGNvYl
 8HBiU8ebeLmJFxfGtS712cMgCl20AClUTxzPhFjfk+WoJB4OvN1cJhoWFEeTg9oDNyJz
 AwmkwvrFMH55I/lAtnnYUGqjdLQm/2uXGGg472L3XSJEmOUrA4IpxGDsQOzHvugJC0bk
 9cnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781747232; x=1782352032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZnUdwrXEJHO5dfBUQ8EAJCU+Jzi5eJCcKWHv3UVVbA=;
 b=TiuTaqrVMCkV/PVZ/YqjqjhLmahzrfDi3xQJU3ee6blAvT/mwI8NBH3QQcETHogGIT
 di3jzTMD5htcNDz6aaKwNzbJpCIk8BHtuXwgKrvPuhiuIJupLwoQm/sk8fe5t3Y6H7FO
 jPnfgFQCUsVWtuuZrwEiW0Pe5WFj2mdXhDkyPwAQtr878Y50wlnWK1eObTS4V/bey9T4
 NqbiC/mZWAYu81GttUvDUUGshbPNAbkcsge19mzyHJJX6Ihru7mFKiRbOwcUB1Fcy5V2
 0bbq6brUWAG8nlK6xJ3ZMq3gmEN8AQFRc1Ht5qgwpu6QNi+BFmtpf1AtopqDZGWXUAP0
 oP3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wTfDd4yCxoMD9Mso6gZ/8VE+iEr//YOOqX7j2ETt3/i0ETitrrAFnF672JCGt+RIYyuE=@dpdk.org
X-Gm-Message-State: AOJu0YxSQU3P7hb3A4C4MlN6eRJ9cr2zJfWN/GJNKOSnB7m2rE/p7/wr
 EDw44IoZJK42ECg5CZtbHD25LeRMieUFJypbsS/FsS6FpkXwStIfRgzfSITDoAfg7VAMhATYQkV
 abINTx7THpS0K76b+9yw2G+Pv5mEAl74=
X-Gm-Gg: AfdE7ckmxkN/vMO+towtYTMID94uqwedkJ4X8tC0UhmSqKkOwa/jC2kScydeW22u7Bn
 7eLozvvFH9xwelUcJu0fH1TqZEReOmvdqdI/qhZf8TS6XRjjUkdjBQUgGTLxGGoSFE3mSc/SUyA
 d+DO0Q8Zr3J+NmLhCtuImoiaXf6Lk7KljMp3KMsmHONUmIeIW3k+CFeWAtimuvBs42UpQfkPRP/
 IyqcIRLmb+yrZQ6LGvqMnElF8Du9liXDuXRIqL69+EWaBlTib6pWfhFAKchCSs+ajmoJiLNuW/I
 aqfpWoZE0FTvLIJPOvrce8SKk+guNvuZk5pXyCRAfGcz69d2n1aIxs+KihVg
X-Received: by 2002:a05:651c:3608:b0:396:b398:5918 with SMTP id
 38308e7fff4ca-39969a560dfmr17760931fa.1.1781747231417; Wed, 17 Jun 2026
 18:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260518175424.253600-1-abailey@iol.unh.edu>
 <20260617155748.59724-1-abailey@iol.unh.edu>
 <CAK6Duxt3ZSCrHQyFp-n1OrEiWH7-4YNPzC8LP_U1HxvbouSwvg@mail.gmail.com>
 <CABJ3N2Wxr0wAmuF7FGThGgfssacuHQhgU7vs15rHh5dCedLdvQ@mail.gmail.com>
In-Reply-To: <CABJ3N2Wxr0wAmuF7FGThGgfssacuHQhgU7vs15rHh5dCedLdvQ@mail.gmail.com>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 17 Jun 2026 21:46:59 -0400
X-Gm-Features: AVVi8CcpuVzMEULp3py_vTwlIZ4mHTpd4CRf6DaViw0P_FPFf3Vf6PyCN7I7iqI
Message-ID: <CAK6Duxt6C-0pJ3qhWkUkWcnre_WKWJmrk39rq5rrCyO71n-OCw@mail.gmail.com>
Subject: Re: [PATCH v5] dts: add retry loop to trex traffic generation
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, lylavoie@iol.unh.edu, knimoji@iol.unh.edu, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000cee96d06547d5ab8"
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

--000000000000cee96d06547d5ab8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts, thanks Andrew.

On Wed, Jun 17, 2026 at 4:59=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Thanks Patrick,
>
> yes it was intel NICs having these link issues.
>

--000000000000cee96d06547d5ab8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts, thanks Andrew.</div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, Jun 17, 2026 at 4:59=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:=
abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Thanks Patrick,=C2=
=A0<div><br></div><div>yes it was intel NICs having=C2=A0these link issues.=
</div></div>
</blockquote></div>

--000000000000cee96d06547d5ab8--
