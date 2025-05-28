Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6810C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 20:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60846402B6;
	Wed, 28 May 2025 22:33:33 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7000D40156
 for <dev@dpdk.org>; Wed, 28 May 2025 22:33:32 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso2704695ad.3
 for <dev@dpdk.org>; Wed, 28 May 2025 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748464411; x=1749069211; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SAPxg7J4BIkv0HLM3uKWUWnXGX5B5gQVaZ6ueHITaig=;
 b=YGwlVk4a8MnJ2GKxB2SsKXccm/uTx4BqKvDF3bBD2pzOFdLhARMNipwPJE/Hec5Wx6
 8Q1hofCWNPkqQRKAqqkrK5G5lt5mpga1FuLnbAgg+6SsOL9piWJq1b1ROJOisQzXzpjH
 qzlYtUEOhTFJkHAaSK5V1c+gnN/JmXWTGalyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748464411; x=1749069211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SAPxg7J4BIkv0HLM3uKWUWnXGX5B5gQVaZ6ueHITaig=;
 b=RZBvM+OUdx3DOFqQsuu9+573AB61ip0jP4lyT1+tLPjjm7od/kuReyNX6e2XJco4kt
 J9o8xS/3r8TfpIrMREx3dGcy6OpaF/wDJZq61JKmYgdKWEt5T8YEdPmod1N3ClmznhVz
 19/d5ruA5f3JS4Pnzu/fXpiu4NVTCSZ18hF1I5rdv2r/yWKLs22l4x8sSv6kwdub8TnB
 Sfk6SGgYc9fejZJzJ3947KSIru5Yy15g91ZBi5yJVqBue5yliR0Bk7KOFhdQfzmMKa2V
 OeFLlms6e2tah3qYCyFwyCr07xFjHbKFBY8IUpR50oMKl/TfAsNMm9uZstWsNlQ37gyW
 FOSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBmEoLvd/XtGygeZZqr/zUAsb9n9n2FnUJDcA2ZQj/5W6I5gBWWOLsXPpVB+hkyiHcRzk=@dpdk.org
X-Gm-Message-State: AOJu0YzBGhYy1Tipct5LSKjnI3C+jawqhImDTWaQvIgziS86HN1ZSCxD
 KNKaRZ62v4NjSUGIZnrmZB2glIc4ZfzuTOagOQL8aER6PmFTSKVE2hAgnVwktDeVGgqQgYkq/Ud
 TyAy/RyxDKwkkXStGu+FfRh6d5iTDFLkACUaNtC/zPw==
X-Gm-Gg: ASbGncuMSJ0h9eGgV7dE6m5Rnw+U2oFta7bPODfdKcRp5WmgL7pbn7IKRAxFEfEX/fp
 cqXjoO3EV8KKS0Qi9AIwjucLR/dVW/TYDJqsvGNVzJJEtxG+4Kt10nS+GjG7Wrmr/5z6fVM9x4H
 eQmV12bQJNjesiJrJuexHZddcPU2Y3XHmFM8eOQlSoDJ1Ur+eU2jV44crOzkgZkhIrVQ==
X-Google-Smtp-Source: AGHT+IHd3Bv7laRy+mdnJOuiZiFAlyVxNvfXcFx0ePA5CyN0tpZLxcsJx0MU5AWEMEUo7sP1dMXYIXuhAkUGzdG6WnA=
X-Received: by 2002:a17:903:2f4e:b0:220:d257:cdbd with SMTP id
 d9443c01a7336-23414fe55a6mr314287375ad.48.1748464411145; Wed, 28 May 2025
 13:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
 <20250527153734.368235-3-dmarx@iol.unh.edu>
In-Reply-To: <20250527153734.368235-3-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 28 May 2025 16:28:36 -0400
X-Gm-Features: AX0GCFv6dBDSgMTPYkAgeiTCv6S1PwCEZGSkfKOr0sfkIMKsfO8WOmnOPXvPWwo
Message-ID: <CAJvnSUB1cU0kzaAsLQv57y3Zbmp70FkKyK0BGBRg8Qb6m7Bs9A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] dts: fix doc generation bug
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000210d9806363818a6"
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

--000000000000210d9806363818a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 11:37=E2=80=AFAM Dean Marx <dmarx@iol.unh.edu> wrot=
e:

> Fix a bug in the port stats check test suite that was causing
> the DTS doc generation to fail.
>
> Fixes: 8f21210b1d50 ("dts: add port stats check test suite")
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/tests/TestSuite_port_stats_checks.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/dts/tests/TestSuite_port_stats_checks.py
> b/dts/tests/TestSuite_port_stats_checks.py
> index 2a3fb06946..491c2263b6 100644
> --- a/dts/tests/TestSuite_port_stats_checks.py
> +++ b/dts/tests/TestSuite_port_stats_checks.py
> @@ -51,10 +51,15 @@ class TestPortStatsChecks(TestSuite):
>
>      #: Length of the packet being sent including the IP and frame header=
s.
>      total_packet_len: ClassVar[int] =3D 100
> -    #: Packet to send during testing.
> -    send_pkt: ClassVar[Packet] =3D (
> -        Ether() / IP() / Raw(b"X" * (total_packet_len - ip_header_len -
> ether_header_len))
> -    )
> +
> +    @property
> +    def send_pkt(self) -> Packet:
> +        """Packet to send during testing."""
> +        return (
> +            Ether()
> +            / IP()
> +            / Raw(b"X" * (self.total_packet_len - self.ip_header_len -
> self.ether_header_len))
> +        )
>

Looks good. In my opinion this should be a standalone patch, since it's
unrelated to patch 1 and 2, but it's not functionally relevant since there
is no such thing as a series in git, so you don't need to resubmit. Keep in
mind for future series though that they should be logically grouped.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>


>
>      def extract_noise_information(
>          self, verbose_out: list[TestPmdVerbosePacket]
> --
> 2.49.0
>
>

--000000000000210d9806363818a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 27, 2025=
 at 11:37=E2=80=AFAM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" tar=
get=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Fix a bug in the port stats check test sui=
te that was causing<br>
the DTS doc generation to fail.<br>
<br>
Fixes: 8f21210b1d50 (&quot;dts: add port stats check test suite&quot;)<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/tests/TestSuite_port_stats_checks.py | 13 +++++++++----<br>
=C2=A01 file changed, 9 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/dts/tests/TestSuite_port_stats_checks.py b/dts/tests/TestSuite=
_port_stats_checks.py<br>
index 2a3fb06946..491c2263b6 100644<br>
--- a/dts/tests/TestSuite_port_stats_checks.py<br>
+++ b/dts/tests/TestSuite_port_stats_checks.py<br>
@@ -51,10 +51,15 @@ class TestPortStatsChecks(TestSuite):<br>
<br>
=C2=A0 =C2=A0 =C2=A0#: Length of the packet being sent including the IP and=
 frame headers.<br>
=C2=A0 =C2=A0 =C2=A0total_packet_len: ClassVar[int] =3D 100<br>
-=C2=A0 =C2=A0 #: Packet to send during testing.<br>
-=C2=A0 =C2=A0 send_pkt: ClassVar[Packet] =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether() / IP() / Raw(b&quot;X&quot; * (total_p=
acket_len - ip_header_len - ether_header_len))<br>
-=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @property<br>
+=C2=A0 =C2=A0 def send_pkt(self) -&gt; Packet:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Packet to send during testin=
g.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Raw(b&quot;X&quot; * (self.tot=
al_packet_len - self.ip_header_len - self.ether_header_len))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br></blockquote><div><br></div><div>Looks go=
od. In my opinion this should be a standalone patch, since it&#39;s unrelat=
ed to patch 1 and 2, but it&#39;s not functionally relevant since there is =
no such thing as a series in git, so you don&#39;t need to resubmit. Keep i=
n mind for future series though that they should be logically grouped.</div=
><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@=
iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0def extract_noise_information(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self, verbose_out: list[TestPmdVerbosePac=
ket]<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>
</div>

--000000000000210d9806363818a6--
