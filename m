Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7CDC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 12:12:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D5F4400D7;
	Thu, 24 Apr 2025 14:12:38 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 27B61400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 14:12:37 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso790391a12.1
 for <dev@dpdk.org>; Thu, 24 Apr 2025 05:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745496756; x=1746101556; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wiS01noUWgHKjrvB5GS4zSs5KTykl8MWAto3WaUsjsM=;
 b=QD1PE7aI53k54GveR+wcZJ9NDMk51G/vOf7ChMgltmx3B74GJxd0iCoWrbCcrk/Jnu
 40vhlLv7gzcUBXCh07W0droEs8mgUrG2Qs/1/sOyONkeNWH4JtCtpbTzz4JkGb1KwGIZ
 m3mcS9f0v7jmQ4aZ6SbaQV7zWqh3CqdLvLc0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496756; x=1746101556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wiS01noUWgHKjrvB5GS4zSs5KTykl8MWAto3WaUsjsM=;
 b=gpTCGSqKQfRecgVudm4dGCuc68Qzy8iEGs1zOcoz4DBGkDhGRPgLWf9EE++6HUsLKQ
 uSVndIUBjfAzjEkjdlt8R1ouKxZ8OMYptvYlmAK+mDyTvL8OuM16g2UEi4kPxX7y5Dt/
 uLTuFY2+HwJye9mf/20YhjRubq5HsyZw6iuH4k2RTr9PkUbT8OhF2r3P9ohIwb2VJ89s
 Zj1EtmFYJHodRQlI7zncv7zOlGtYYT/vq4g5VgVKyV4s8/bn6pHBIDRnCV0rJYKCMWHK
 p6fMOW0cYWXVUfZGBtEWSF+LBaaxhu3Nl2rRrPmH+vuQ2ES2s0luwmIeC0DEbg5vZT2k
 rYGg==
X-Gm-Message-State: AOJu0Yy8U3bKRN9ka6eawWBSPF29liTVdNcLuX5WC+i9LzldD7gNS7xm
 fjmCMXVf/tKoUzPM/tPoTrZjBByAQYpk4xQzbeGtUz6JYSSrPJtZFeI/7QHbI0r18x1qUOTHTR9
 kevi928UUGaG6mypdALfVycb1OfLh/yh2zbuMQQ==
X-Gm-Gg: ASbGncuuQiKCCpVgsqchCcNynNP0C5BxTdz0Ml1PMOSBaxDcVauG5xewwuSEWWIm5q6
 OYfwLIzBxrNQQZHPRL1lORNHfhgMPdPwWCtYjWNrsXlsYCHwbLNv+JAFVJkGsADH4bmyVXi0zJU
 2XlW5kEBbTuqNGIMEAhPRzYxzYfMHSrP3SovNbxai9R58XD8yk3KK+n3Q=
X-Google-Smtp-Source: AGHT+IF1GY6LP34z0DInAggeKuhYnK/djYngbX5OZB5d4IKF9ud5t8RiTuvVH3A2NHqUolm24xCi1/eQdY21PXaq1Bg=
X-Received: by 2002:a17:90a:8a87:b0:309:f46e:a67c with SMTP id
 98e67ed59e1d1-309f46ea6a6mr1496a91.11.1745496755915; Thu, 24 Apr 2025
 05:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240814182005.12251-1-jspewock@iol.unh.edu>
 <20250424014412.3849896-1-probb@iol.unh.edu>
 <20250424014412.3849896-3-probb@iol.unh.edu>
In-Reply-To: <20250424014412.3849896-3-probb@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 08:08:14 -0400
X-Gm-Features: ATxdqUHKBYOJ6ZjXC4YgH1GJpxKIDXRk7-NelM3QEkXi00geSpFHCRECO2rF1Pk
Message-ID: <CAJvnSUDUQ7Hi6zmwyqTdL2A4ZNdbL11OeTkW=O2cag+7q2-6vQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: add port control testing suite
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu, 
 thomas.wilks@arm.com, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000017e1b50633852200"
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

--00000000000017e1b50633852200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:48=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> From: Jeremy Spewock <jspewock@iol.unh.edu>
>
Should add:
@requires(topology_type=3DTopologyType.two_links)

> +class TestPortControl(TestSuite):
> +    """DPDK Port Control Testing Suite."""
> +
> +    def send_packets_and_verify(self) -> None:
> +        """Send 100 packets and verify that all packets were forwarded
> back.
> +
> +        Packets sent are identical and are all ethernet frames with a
> payload of 30 "X" characters.
> +        This payload is used to differentiate noise on the wire from
> packets sent by this
> +        framework.
>
>

--00000000000017e1b50633852200
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 23,=
 2025 at 9:48=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.e=
du">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">From: Jeremy Spewock &lt;<a href=3D"mailto:jspewock@io=
l.unh.edu" target=3D"_blank">jspewock@iol.unh.edu</a>&gt;<br></blockquote><=
div>Should add:</div><div>@requires(topology_type=3DTopologyType.two_links)=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+class TestPortControl(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;DPDK Port Control Testing Suite.&quot;&quo=
t;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def send_packets_and_verify(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send 100 packets and verify =
that all packets were forwarded back.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Packets sent are identical and are all etherne=
t frames with a payload of 30 &quot;X&quot; characters.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This payload is used to differentiate noise on=
 the wire from packets sent by this<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 framework.<br><br>
</blockquote></div></div>

--00000000000017e1b50633852200--
