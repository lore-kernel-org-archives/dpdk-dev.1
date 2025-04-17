Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C27C369C2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 12:51:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B8AE400D6;
	Thu, 17 Apr 2025 14:51:15 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id A9D73400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 14:51:14 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-af5085f7861so467439a12.3
 for <dev@dpdk.org>; Thu, 17 Apr 2025 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744894273; x=1745499073; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+0jesN3NQypNFtRPhW0c56PlE3/shUnfTbv/Qs7Ib+k=;
 b=hZJh/ZDWEHd9k/Of8LdLP5lVlqTNUecam69IIbgGbgwaV2J9V00AZ9wEFEiP03rV7V
 EwWBoJU6jJoqkXoheugMxqQNG+NQ0FBUUAHyxSa/2GG9th/MnKgom5VCiUuJ/lH67THz
 lbWk4XdNDxTDP5WXKIjcdw6jZwP2tW2Eo85+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744894273; x=1745499073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+0jesN3NQypNFtRPhW0c56PlE3/shUnfTbv/Qs7Ib+k=;
 b=NVEcL2a/zLdMbqeodoTljhb/THInUQa6YHLy2z86AFMq/5LRed7UGojTegb6skz9SK
 Btrgun5keRuVw9C+40+l59BuCZZ82WYArBQd+2aWqA3oSGCFcqSam1cT/fwV0D7ciOLx
 uL8sxbedvugHsuiyphuDt2zTdr1NM2wcGLjE4V0GfKCn2Dtf+xVlqDMAb7LQ4rWTzxh5
 cUbwCQRxs+4kTpbsI8nQfLZezLSTA8cL/YUrfzps0SZ3IS7Wk9MhzGTRn9dclyvrWtlB
 ETQUjZr2pLENzz70PNWuEbFf4MMqXTMCkfXJtEvDrHzmGNe5K13IOqcAUJ2dnrv5lMan
 bO2g==
X-Gm-Message-State: AOJu0YxWikmgkrT2a0CofsOvD1zdl91TjfFveo1ClitrCmpGUfBe5Ckj
 QC1axBAv6wNFnccJ4QT57bFvigIEEg/QjNlyHUpgJvp/+oEX4JTzxdxXBJFA7fF3yVuMlyrYWAB
 LH/TgI2RCBuLOKi3aNtFj0z9PorLs/qb+huCtsQ==
X-Gm-Gg: ASbGncudJMRUUCjuLTqgM00OTZ3oNDXRR4PDCA4wwA0NPJDv7LiKiiJ6qfgsO1a8XzL
 8mOZ++RN66rwejZeGXYSBPD4piFEIyNzCU+NXwFV6dAQqnP37LWQWyaln38s+2+we+FFs++dcY5
 HZR6sBYoMyWrcI1D1tWPq/eCTco0m37xH3iP2Lwg==
X-Google-Smtp-Source: AGHT+IFCgx0lOy+lrbKSkMwkQXvcbeDqdgGt1Rr0ehXjlPlwRYLBsr78bVmOeC25fRDUmxmbEuB4hUZrprtEYMoI3Cw=
X-Received: by 2002:a17:90b:2750:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-3086417c55bmr8524034a91.31.1744894273051; Thu, 17 Apr 2025
 05:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250415094923.487014-1-luca.vizzarro@arm.com>
In-Reply-To: <20250415094923.487014-1-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 17 Apr 2025 08:46:57 -0400
X-Gm-Features: ATxdqUG9I4Vxig6uSCkcT8yRyxsozZEmk7KVyLXcp8Ly5uF6B7SbOj9AQG3Vg80
Message-ID: <CAJvnSUB7-HRHNKC7YGqhyMo9tBN7X-qC4+P8kzgaUSS1c-GKhA@mail.gmail.com>
Subject: Re: [PATCH] dts: add ICMP to packet filter config
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="00000000000050fe7b0632f8db3a"
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

--00000000000050fe7b0632f8db3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 5:51=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:

> NICs like the Intel E810-C often produce ICMP packets. These packets
> are stray and can interfere with testing. Therefore, add an ICMP
> filtering option in the packet filter.
>

Okay, this sounds harmless. But, is Paul okay with this approach? My
understanding is that he wants the testsuites to be written such that they
don't require that the wire is "quiet" from LLDP, ICMP etc.


>
>
> @@ -234,10 +237,23 @@ def _set_packet_filter(self, filter_config:
> PacketFilteringConfig):
>
>          def _filter(packet: Packet) -> bool:
>              if ether :=3D packet.getlayer(Ether):
> -                if filter_config.no_arp and ether.type =3D=3D 0x0806:
> +                if filter_config.no_arp and ether.type =3D=3D ETHER_TYPE=
S.ARP:
>                      return False
>
> -                if filter_config.no_lldp and ether.type =3D=3D 0x88CC:
> +                if filter_config.no_lldp and ether.type =3D=3D
> ETHER_TYPES.LLDP:
> +                    return False
> +
> +            if ipv4 :=3D packet.getlayer(IP):
> +                if filter_config.no_icmp and ipv4.proto =3D=3D IP_PROTOS=
.icmp:
> +                    return False
> +
> +            if ipv6 :=3D packet.getlayer(IPv6):
> +                next_header =3D ipv6.nh
> +
> +                if next_header =3D=3D IP_PROTOS.hopopt:
> +                    next_header =3D ipv6.payload.nh
> +
> +                if filter_config.no_icmp and next_header =3D=3D
> IP_PROTOS.ipv6_icmp:
>                      return False
>
>              return True
> --
> 2.43.0
>
>
^Looks good, thanks.

Reviewed-By: Patrick Robb <probb@iol.unh.edu>

--00000000000050fe7b0632f8db3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 15,=
 2025 at 5:51=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@=
arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">NICs like the Intel E810-C often produce ICMP=
 packets. These packets<br>
are stray and can interfere with testing. Therefore, add an ICMP<br>
filtering option in the packet filter.<br></blockquote><div><br></div><div>=
Okay, this sounds harmless. But, is Paul okay with this approach? My unders=
tanding is that he wants the testsuites to be written such that they don&#3=
9;t require that the wire is &quot;quiet&quot; from LLDP, ICMP etc.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br><br>
@@ -234,10 +237,23 @@ def _set_packet_filter(self, filter_config: PacketFil=
teringConfig):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def _filter(packet: Packet) -&gt; bool:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ether :=3D packet.getlay=
er(Ether):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if filter_config.n=
o_arp and ether.type =3D=3D 0x0806:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if filter_config.n=
o_arp and ether.type =3D=3D ETHER_TYPES.ARP:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return False<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if filter_config.n=
o_lldp and ether.type =3D=3D 0x88CC:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if filter_config.n=
o_lldp and ether.type =3D=3D ETHER_TYPES.LLDP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn False<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ipv4 :=3D packet.getlayer(IP)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if filter_config.n=
o_icmp and ipv4.proto =3D=3D IP_PROTOS.icmp:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn False<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ipv6 :=3D packet.getlayer(IPv=
6):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_header =3D ip=
v6.nh<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if next_header =3D=
=3D IP_PROTOS.hopopt:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next=
_header =3D ipv6.payload.nh<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if filter_config.n=
o_icmp and next_header =3D=3D IP_PROTOS.ipv6_icmp:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return False<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>^Looks good, thanks.=C2=A0</div><div><=
br></div><div>Reviewed-By: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh=
.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></div>

--00000000000050fe7b0632f8db3a--
