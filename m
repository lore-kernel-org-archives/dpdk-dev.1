Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5008CA1012
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 21:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8498C427D1;
	Thu,  4 Sep 2025 23:21:42 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 897B7427CB
 for <dev@dpdk.org>; Thu,  4 Sep 2025 23:21:40 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-329e1c8e079so1333097a91.2
 for <dev@dpdk.org>; Thu, 04 Sep 2025 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757020899; x=1757625699; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W2GCqUdFcH0iCsu+OXJqmoQIwRJV8qBUewd9f764HeI=;
 b=fdoMMDgd0VRWSlkQ7d7Mtg80v5nJW7IckS60UdqcEcg8RsATC9aCBgQb8opKk/uoXL
 g3Qgk9XV4ovILhnkHCmppaE5KjXHfacZwaBfyuX9GtJFB50A6TbdKiVH0PC9SJV9ElR0
 8hsx9y7jDs8NQohuusV+D3NOM5diflw8RcP1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757020899; x=1757625699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W2GCqUdFcH0iCsu+OXJqmoQIwRJV8qBUewd9f764HeI=;
 b=NtgykyBd5tNkWzTlsUH6+VDyPR3aL4kAbQOGf2LeYiOI5Lhu1yiIwjAtbvToQWl6B7
 wWdTHwhwAdXG7JPN2mM99Czwh+fste7uZG/vcWdH7rKwNdTMBTNHQhuDFwFyrESQ4mZ7
 Ck3mr5duSWFfHL+pN3XUEP2VwYRkU4zARGl2FTa/5RWoYMh3nq4cKXLXu1UsxOq852OW
 9a431y1zA3FjYn8HL6NwtdKqYA36k1k/7BoPxI0ICWuIskMR7kHmrrS8V+n2GQFuoqiE
 osskUVYGNqWR4WQM1AWIkemaY8xbEHVBuYMAGSJa9ZbhDvcQdKO+BodWri6m7uhaQL7c
 KNyA==
X-Gm-Message-State: AOJu0Yx0ciTT8ISVN0xkJDm8TlO7sThlEWe07bb+yppZ9yfB8yC1dcfp
 TZi01L/Ub1X6rRyJJ5bV+GhLvPQwdGSLsI8uWAHfc/688tIsP3hL9E9P6FpeY1FJMzn95Gjyxpa
 TmmNc/YMlkjgznYwt+739ZkC9g7F1WkXBn5nRujk3kX2cFoFf471A
X-Gm-Gg: ASbGncuIO1p3nrZRg363ssSMUsim+28BizRanOXq395j9fgsa1libQrjREWCrPZByau
 NfsotQOA2FPVvb3dXBEg9PzXprwFKVS5ZGIzuIjlN+CgBGF2KH1DWXylTFH3S1EEci8J6Fdbn9H
 94vYz2224BQ4H54OA1xI52QrY7VYfzy2GmUgBfaqi/X+azeDJqpMY37pKzA8hlLr4aIqOlmeor9
 SncU7blpQxjgbyZaqdXZPEtqv1eBlC91oYzxQ58
X-Google-Smtp-Source: AGHT+IFSL3mWsf0AGUijQNP8fxuKPDwvtYsuiEi+oqJS8+8mx1qQeVoO+bnEzPKaovgZlcsjOAi3YIyhjgZCpPOhV/0=
X-Received: by 2002:a17:90a:ec85:b0:32b:be39:7810 with SMTP id
 98e67ed59e1d1-32bbe3978ddmr1169407a91.16.1757020899587; Thu, 04 Sep 2025
 14:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250904114653.199080-1-luca.vizzarro@arm.com>
 <20250904114653.199080-6-luca.vizzarro@arm.com>
In-Reply-To: <20250904114653.199080-6-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 4 Sep 2025 17:14:52 -0400
X-Gm-Features: Ac12FXyqSvXKryj9s6lnvT3SNPyrQVkZmx-Xss8dJ1JYhvSlU2V94j-vqACliSo
Message-ID: <CAJvnSUD=k6yPbdmv3GYk0u1Z4CA42RGbuHDPZeb7HgtuKPbt7w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] dts: make log files into artifacts
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000009553d0063e004e9e"
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

--0000000000009553d0063e004e9e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:47=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.com=
> wrote:

>
>  @dataclass
>  class TestSuiteSetup(TestSuiteState):
> @@ -474,6 +457,11 @@ class TestSuiteSetup(TestSuiteState):
>
>      logger_name: ClassVar[str] =3D "test_suite_setup"
>
> +    def before(self) -> None:
> +        """Hook before the state is processed."""
> +        super().before()
> +        self.logger.set_custom_log_file(self.test_suite.name)
>
>
Makes sense thanks for the new version Luca.

--0000000000009553d0063e004e9e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 4, =
2025 at 7:47=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@a=
rm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><br>
=C2=A0@dataclass<br>
=C2=A0class TestSuiteSetup(TestSuiteState):<br>
@@ -474,6 +457,11 @@ class TestSuiteSetup(TestSuiteState):<br>
<br>
=C2=A0 =C2=A0 =C2=A0logger_name: ClassVar[str] =3D &quot;test_suite_setup&q=
uot;<br>
<br>
+=C2=A0 =C2=A0 def before(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Hook before the state is pro=
cessed.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().before()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger.set_custom_log_file(<a href=3D"htt=
p://self.test_suite.name" rel=3D"noreferrer" target=3D"_blank">self.test_su=
ite.name</a>)<br><br></blockquote><div><br></div><div>Makes sense thanks fo=
r the new version Luca.=C2=A0</div></div></div>

--0000000000009553d0063e004e9e--
