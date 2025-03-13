Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB79BC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 13:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1280D40FDE;
	Thu, 13 Mar 2025 14:00:26 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id A9CA440EF1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:00:24 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-224019ad9edso23348735ad.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741870824; x=1742475624; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jeWoQNXbz22T9y02/E5+qVYYGc60gr/CZxlWhg3RWfc=;
 b=Q6zxSiz2cl7JU9yFv6TNtQJNWDIToxhltbljwAoxk1CLgl1F/xhdDuEV51peFy/ZWl
 1QMW2oy7L7jd3IdufjaTAnIAoaXhBvfR/lmyVJjreQQK4gVvnJK9s/nwvOSvz13Sw48e
 J8fVFch/pOkKHE1+r3sY2oQOWkGidNA+qoDqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741870824; x=1742475624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jeWoQNXbz22T9y02/E5+qVYYGc60gr/CZxlWhg3RWfc=;
 b=YjI1qGpkoFyPfIsXJ1MyDLNwBor6i84bAj61ReLCEv1ImARAtdEYLb8WqYIAbs75Ks
 VIDSZZ/IrfCLAFoOinwJeRaf1vyYErP1YQL/xpCzr1/lKZTmuZdRCYtnRJIujTxwF/8B
 RO5TKQur/JGw7WQGXZEertjBumbuCy0gEhP+Ci9Sh7wzswLHwGHm5Szq1V6nQqrHcQEf
 KrMKqUYa7p8vEirC+E3AeEGQVSoOLiEgVX6R2/nbmXlrhz3WYMNT9GB5g8WWZGNxZDdm
 3bSddk+YhJrD8L3prOcH4reV0ckmiRilU7uufDodbGPyNCFoU3Y8Wih5gaLe2Aem5gZ9
 maeg==
X-Gm-Message-State: AOJu0Ywac/ziUZi5MQ3ILKNKSE0VxwNl/chJo4DQftDz1dhwObacpimQ
 RRHt0AgUnxuzjDD372JCj1kGBLYGj8pQJ8cSvxDqu3yq4i6GgKGLps7uFDcdI76vz6G718OBGkY
 hQzpaEidLnP1MK581Eqmp1fQFUwFrpEsPYiKOMw==
X-Gm-Gg: ASbGncuqY2vWGH4ukIMWFl1tnuxdcOeCxBDPnbTIRPG443Kd4aCeyR8chyfpUzvAkhS
 BaQW8+nPjo8luBeor/vopVh5bIworGXwa4hrAQRiYfLH4lVJGZyTLxQ4Aqqa6Gq43F9INipb6oD
 EjQmxLvDAfX4BtQoBXGt617TEg
X-Google-Smtp-Source: AGHT+IE7LX3rrkAlDbso9WfhFpYgi4VqG4Zj5QV0LmVdxfEjQ5fdYSZgVpKkENgSCiZsjUw3+pue+7sWyNlagRMs8TE=
X-Received: by 2002:a17:903:19cf:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-22428ab75cdmr449686885ad.40.1741870823555; Thu, 13 Mar 2025
 06:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240821191557.18744-1-jspewock@iol.unh.edu>
 <20250313033611.1896695-1-probb@iol.unh.edu>
 <20250313033611.1896695-3-probb@iol.unh.edu>
In-Reply-To: <20250313033611.1896695-3-probb@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 08:56:41 -0400
X-Gm-Features: AQ5f1JqGb_c-5ZsinQM8Vqt74GdZpSbo8UzO3ufsFqV6o74Fd5UfxOTRO_m1n3U
Message-ID: <CAJvnSUC3r7JYHZqa7RjJxvcphVSdtLXwDgsm9Q_AyHiVb_tpng@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dts: add VF configuration and workflow
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu, 
 dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000aedb62063038e7b9"
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

--000000000000aedb62063038e7b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:40=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> w=
rote:

>
> +    def set_vfs(self):
> +        """Create virtual functions for the port."""
> +        self.node.main_session.create_vfs(self)
> +        addr_list =3D self.node.main_session.get_pci_addr_of_vfs(self)
> +        for addr in addr_list:
> +            vf_port_config =3D PortConfig(
> +                name=3Df"{self.name}-vf-{addr}",
> +                pci=3Daddr,
> +                os_driver_for_dpdk=3Dself.config.os_driver_for_dpdk,
> +                os_driver=3Dself.config.os_driver,
> +            )
> +            self.virtual_functions.append(Port(self.node, vf_port_config=
))
>

From doing additional runs from this patch, I am seeing for some reason
like 10% of the time there will be some StopIteration error on a VF port
init from get_port_info(pci), when it is indeed being provided with a pci
address (I think but I can debug).


>

--000000000000aedb62063038e7b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 12,=
 2025 at 11:40=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.=
edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><br>
+=C2=A0 =C2=A0 def set_vfs(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create virtual functions for=
 the port.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.node.main_session.create_vfs(self)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr_list =3D self.node.main_session.get_pci_a=
ddr_of_vfs(self)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for addr in addr_list:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vf_port_config =3D PortConfig(<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3Df&quot;{<a =
href=3D"http://self.name" rel=3D"noreferrer" target=3D"_blank">self.name</a=
>}-vf-{addr}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci=3Daddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os_driver_for_dpdk=
=3Dself.config.os_driver_for_dpdk,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os_driver=3Dself.c=
onfig.os_driver,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.virtual_functions.append(Po=
rt(self.node, vf_port_config))<br></blockquote><div><br></div><div>From doi=
ng additional runs from this patch, I am seeing for some reason like 10% of=
 the time there will be some StopIteration error on a VF port init from get=
_port_info(pci), when it is indeed being provided with a pci address (I thi=
nk but I can debug).</div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
</blockquote></div></div>

--000000000000aedb62063038e7b9--
