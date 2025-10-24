Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84358CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 19:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7242D40151;
	Fri, 24 Oct 2025 21:22:45 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 47DCE4014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 21:22:44 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b553412a19bso1581097a12.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761333763; x=1761938563; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MgBretEFq/nqaGWEe4FGGRLMKFcpy633L+N23d7Edxc=;
 b=TkOA7nKNBRg3wM32hYSG6kqvjgDnqjtEQGONRjEJdpB5XcV2zw06Hz9gSikHgf/1YE
 FKq1WnYLRdQE+Tl8pQf49Ok1mVvl8uisBr8LDWTwoL27wuLlbB34YKCwRDhCvlSlZe5h
 UrWQUUD6rRFedmAOYm4nLT1AkVjGRSrDEdp0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333763; x=1761938563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MgBretEFq/nqaGWEe4FGGRLMKFcpy633L+N23d7Edxc=;
 b=PVrEUAKphD2dJIkfk3/XaQLsNqb+K/O3rJCXcM2rhNjCHu1orqxvk84Q/hLsyDy7NB
 Apam8ysIbUIsWrpcQmfCJbY+MG2jOdKFwqUrK5qfH5tkwezzVhexX97++/NTCJd3CfMo
 Oel9eo4cwa3/2IuBIUGCvxd0A4AnFur4XZcJSvXr+3QNeVtqqrTYxnO8rRoDkuQrvRnc
 tqUh9or0I3cfd4Iy0zGA3GBtcVjaStc3ZC9zTBgP0CG25CrN3MhAgB12xBm2R8GwCHQF
 SxRahymbk9zgAvhQjJgcSTiEFLvaSnCzlSubzuL+z4v1TNHUV1OjPiJ+Fj68nIbdSy/k
 Cvow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGVDfFHnM+aqaB8surarvx20WTW+yQ93PfCWCNlBYrknAqaYYJNNOKxP8pdovijpblvAU=@dpdk.org
X-Gm-Message-State: AOJu0YzV2IDp+vpU1Yp7jB85Dp3QIJWFz0Iuz7G5/W/N5OkHpxHaMEWL
 WYGRIbwP2QxcjVywk/sUSsVI3b9um6yC/FIjXAyzX8rmDya7HxCWzL5x4WM1ay2bc9NtCGv39Fs
 c21PpBphOywayD4bmBn2OqpBm8exeg8pY8lsW22Cgyoa4zREoX/rxkAI=
X-Gm-Gg: ASbGncsneuk5nQWY/+rNg5YoVktii5deItrxZm5plAcLuAg6URatGMr24gzv2nuot9R
 5HdXYDfHnO3Y2O97dG75tu3tlH1QApH2HomcMY4qgf+tl99pWUs88IeTqQUnJw1vSmjJSTksNJ6
 EuPQLeG6gCsCt+Pl3Uw45uxwdR7Kzmar+44KM4fiQOpR6Q+KRZQsgzDJfOIWvqoeTZT2MfeDivi
 PgDhBZFQrw/h0la2J+RV/+JabP9j9I1kTszLThochOwnJfle063QvBVICKQnKnSRASWUMj4j+cM
 DWD/QHPCbfY/mvI6DjuUozbATa0+
X-Google-Smtp-Source: AGHT+IHtZ2pL5ZUQFLGYgKGIgjoYen0DReJAD7O/3YtI6KG2VtjJ3LIgku21WdhUDGjhWbf8w+/F15IEL5gNhg0ewZg=
X-Received: by 2002:a17:902:e5cc:b0:270:4964:ad82 with SMTP id
 d9443c01a7336-2948ba0d9a1mr36773135ad.38.1761333763232; Fri, 24 Oct 2025
 12:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251023123223.56924-1-abailey@iol.unh.edu>
 <20251023123223.56924-4-abailey@iol.unh.edu>
In-Reply-To: <20251023123223.56924-4-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 24 Oct 2025 15:21:47 -0400
X-Gm-Features: AS18NWCyh83D5eQD3NWVVTOe1sqTU7YkcmEbBGkO9rlRbn4-Qiq-mTEvJT3MsEw
Message-ID: <CAJvnSUCz3743gtixSvFbt=utFHk=cGd+WhGV1VbFAHs5DJem0g@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] dts: add Rx Tx offload test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000049e8460641ec7908"
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

--00000000000049e8460641ec7908
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 8:32=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

>
>      def _set_all_queues_mbuf_fast_free(
> -        self, testpmd: TestPmd, port_id: int, on: bool, num_queues: int,
> /, verify: bool =3D True
> +        self,
> +        testpmd: TestPmd,
> +        port_id: int,
> +        on: bool,
> +        num_queues: int,
>      ) -> None:
>          for i in range(num_queues):
>              testpmd.set_queue_mbuf_fast_free(on, port_id, i, verify)
>

on and port_id are swapped from where they should be in the function call
above. I swapped these and reran the test and it's now working on Intel
E810. Normally I would just fixup and merge but since you have to submit a
new version anyways because of the issue noted in the 1/3 patch you can
send the new version with this correction.


> @@ -61,25 +64,24 @@ def test_mbuf_fast_free_configuration_per_port(self)
> -> None:
>              * Mbuf_fast_free can be configured on per port.
>          """
>          with TestPmd() as testpmd:
> -            to_verify =3D True
>              port_id =3D 0
>              testpmd.start_all_ports()
>
>

--00000000000049e8460641ec7908
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div><br></div><div><br></div><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Thu, Oct 23, 2025 at 8:32=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:=
abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><br>
=C2=A0 =C2=A0 =C2=A0def _set_all_queues_mbuf_fast_free(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, testpmd: TestPmd, port_id: int, on: bool=
, num_queues: int, /, verify: bool =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 on: bool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_queues: int,<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in range(num_queues):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0testpmd.set_queue_mbuf_fast=
_free(on, port_id, i, verify)<br></blockquote><div><br></div><div>on and po=
rt_id are swapped from where they should be in the function call above. I s=
wapped these and reran the test and it&#39;s now working on Intel E810. Nor=
mally I would just fixup and merge but since you have to submit a new versi=
on anyways because of the issue noted in the 1/3 patch you can send the new=
 version with this correction.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
@@ -61,25 +64,24 @@ def test_mbuf_fast_free_configuration_per_port(self) -&=
gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Mbuf_fast_free can be con=
figured on per port.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with TestPmd() as testpmd:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to_verify =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port_id =3D 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0testpmd.start_all_ports()<b=
r>
<br></blockquote><div><br></div></div></div>

--00000000000049e8460641ec7908--
