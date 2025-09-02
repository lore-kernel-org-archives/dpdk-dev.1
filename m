Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14952CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 11:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5089E402B3;
	Tue,  2 Sep 2025 13:48:59 +0200 (CEST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47]) by mails.dpdk.org (Postfix) with ESMTP id 229BB402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 13:48:58 +0200 (CEST)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-61ec59e833aso614437a12.1
 for <dev@dpdk.org>; Tue, 02 Sep 2025 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756813738; x=1757418538; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zdhbF+aKPnZfZRF4zP9tY6mZd0nRTMu/Doe9VxvZjPY=;
 b=Ks/iHh0F+gSM1d+Z1RF52EHM0pXVagcGtSzpkRj9KZr1J6g8k4QLsLwM0wfkCGGDlz
 Ick0DHAGSk5UCd1GsSG7cZE6rJ5c34HeiDjnIAY8dTRHvumFoj8u8jFL5LLrmh0286HV
 K0s01xmswofsJeu4yaGiB0jG5bMYgEaoQKzDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756813738; x=1757418538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zdhbF+aKPnZfZRF4zP9tY6mZd0nRTMu/Doe9VxvZjPY=;
 b=M2AIoWzty/8DSDppAyTJ3M6zJ5FLoreUe3zmFMe208M4K9ZGOXHGoXovTb/ATQ9Iph
 Wx124/CWhkcR4wCUfcE0IuHbfoAcscxnMzxpaFuJi8+vvMR8ak4jp59ArLryFKZY/wK+
 BS7YEBB6HhttwYlOmTcHQ+BujsC3XB5T5K5pdv6il//BREHN9AVfNPARO1KA36gW58Xq
 wivuOsVDliZ2wA20FE6rQunAXn0PTyDeVs+JtODeP0JyurRFfY6CoprksiQLhFMDXyh9
 eTehUbigIjmrJJFXUdmqZ9eouXAg3bh9v3wpvwo/j9pmE/0iPSr/o8v+u9R5FydwWEPM
 HzzQ==
X-Gm-Message-State: AOJu0Yy19iJeEPE7yxX0AWGRyv0L2DWhXrFALKOzPat3MrTlNd9PL9CJ
 YOR/LPi9yqWDJM3we/QfMviX10CaeL7IoftaESiTVG7gpqQtIHpq1th92kxXX/VDl8ZbgMYETOg
 rGQtQljbzxFZhpXlyAIGqhF9oKm7GLgsxVdgjPrEurQ==
X-Gm-Gg: ASbGncsV/3IOuAbf69dAahUIpdmrtK4g2T3MUz9psJDg4bfU+O2hHoQRF2IQKiBwV8n
 rLrjdNJECNz1FKluyXD6bS+ugvGub/0yflSDJXOAnUYykCriud0mAKHXRow9ECSP7hUkuVx2ZxA
 R71f6j/CVUPBj6bYfBxm2zFqydIMrPKWMrKIqP2uNYg2sjLtF9eO6dG74Eej7fmNoIqd5a9a5Pi
 /pq/M7APDEXmt6dalYaYtoirrgOZREYWnHfDsXz
X-Google-Smtp-Source: AGHT+IH6t8lrNvXKaQ/DYdvba6iWAAJeA2SVWJTVcCXsK79OjIydspHmW2eu5+Z4mIUHMYecRqF9ZNH4XsaynXYL5nk=
X-Received: by 2002:a05:6402:27d1:b0:61e:8fe4:a9eb with SMTP id
 4fb4d7f45d1cf-61e8fe4aa2cmr2532795a12.37.1756813737605; Tue, 02 Sep 2025
 04:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
In-Reply-To: <20250902114327.48185-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 2 Sep 2025 07:48:45 -0400
X-Gm-Features: Ac12FXyzrtQtxbSC78jiLclNrKaCtIb0RQe7635aQj-Pw9Y96ZI7a_gQiibVfWk
Message-ID: <CABJ3N2UbixNX3Rejm1Ch+KaVqtedxw7xsUm4W5uYfM_zhAQtYA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] dts: add tx_offload support in dts
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000c44a96063dd0123b"
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

--000000000000c44a96063dd0123b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch set in its entirety was sent by mistake, please ignore.

On Tue, Sep 2, 2025 at 7:43=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu> =
wrote:

> This patchset introduces the support for TX offload configuration
> through DTS, allowing test cases to be written utilizing TX offload
> capabilities. Along with configuring these capabilities, they are also
> added to the NIC capabilities class, in which they can be required by
> test suites. Finally, a test suite was created using the aforementioned
> changes to update the RX TX offload test suite in legacy DTS.
>
> Andrew Bailey (3):
>   dts: add TX offload capabilities to NIC capabilities
>   dts: allow mbuf_fast_free to be set with testpmd shell
>   dts: update tx_offload test from old dts
>
>  dts/framework/remote_session/testpmd_shell.py | 340 +++++++++++++++++-
>  dts/tests/TestSuite_rxtx_offload.py           | 153 ++++++++
>  2 files changed, 492 insertions(+), 1 deletion(-)
>  create mode 100644 dts/tests/TestSuite_rxtx_offload.py
>
> --
> 2.50.1
>
>

--000000000000c44a96063dd0123b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This patch set in its entirety was sent by mistake, please=
 ignore.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, 2025 at 7:43=E2=80=AFAM Andrew=
 Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This =
patchset introduces the support for TX offload configuration<br>
through DTS, allowing test cases to be written utilizing TX offload<br>
capabilities. Along with configuring these capabilities, they are also<br>
added to the NIC capabilities class, in which they can be required by<br>
test suites. Finally, a test suite was created using the aforementioned<br>
changes to update the RX TX offload test suite in legacy DTS.<br>
<br>
Andrew Bailey (3):<br>
=C2=A0 dts: add TX offload capabilities to NIC capabilities<br>
=C2=A0 dts: allow mbuf_fast_free to be set with testpmd shell<br>
=C2=A0 dts: update tx_offload test from old dts<br>
<br>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 340 +++++++++++++++++=
-<br>
=C2=A0dts/tests/TestSuite_rxtx_offload.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 153 ++++++++<br>
=C2=A02 files changed, 492 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 dts/tests/TestSuite_rxtx_offload.py<br>
<br>
--<br>
2.50.1<br>
<br>
</blockquote></div>

--000000000000c44a96063dd0123b--
