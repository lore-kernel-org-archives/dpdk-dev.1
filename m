Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64713C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 05:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 443B940292;
	Mon, 16 Jun 2025 07:56:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8D5A44027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 07:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750053405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gAx14hQ9kL1/Aq5XactiK5XGfJ5Kr5HXn9Tf9OIxyko=;
 b=dt608zpXDxQAg1wDcRBgDW5RFg9IzwYT0z/cuh9ZJLzBECu0GtEha97YwGSkQMyYLhh1V3
 QKbf9W8cjLkGr3AQ2jraCmUUSw38POfptXT/LRDvB2vYRtxctTp7YXnJ5cc7QGrw+Wt9Bd
 LUoNH9yHahGe1dUewwrSfVlUi1L9TZI=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-EG_tscH7Nr63DThKlQ7dwg-1; Mon, 16 Jun 2025 01:56:43 -0400
X-MC-Unique: EG_tscH7Nr63DThKlQ7dwg-1
X-Mimecast-MFC-AGG-ID: EG_tscH7Nr63DThKlQ7dwg_1750053403
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2e42bf99e78so3625775fac.2
 for <dev@dpdk.org>; Sun, 15 Jun 2025 22:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750053402; x=1750658202;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gAx14hQ9kL1/Aq5XactiK5XGfJ5Kr5HXn9Tf9OIxyko=;
 b=HAAzSQHJYfT8hk4y0Yf3miw+Vwx82VeXpT+j1z/t/p+EPNlgiH4Hgx8lIsnCHydK4j
 hxR9T1ppcp43sNsL0/WMbUmW+CxIutiEiy/uqQrSUTvmnnRQNu0WiUI8GbAW15LPPMM0
 IY8+fTvKd7TX2LxjYLLmzFsmD/BBQUtXe0nBqz01jmHqgisR5ZG599RFbkNENS2hqOY3
 gHvyEWtYCzU4bme0hHkNPTIT0GlGvJpwSmLfsf8NRtS8wCWKSIlT9QZPLnXABxz5cyuh
 2t4KZVmAl226Bdq1RbcM98LmIeHUHaE8PTEOMvqqGFwnA1OK7RbgoUt5XxTeVR8fA1Hj
 dU0g==
X-Gm-Message-State: AOJu0YxtkCQc9k5L0j5Q95jUf+Ig3JC+nSmXns2cjaBGGfmLByQndtkG
 vAcf4sbHeD6WBX95GUxmfoVT9E4JrI4W7zxUQ/qahryxguRjGmwBs9gvNKCZcRJGChfbE24sdHe
 o3XmqBwNDB4r1nVG12xL2LQI69BSKCsczdj+SrnbmYUdfTKmaiiklVJ6XzstJ3xq6TT+8PdicFe
 teirYGT8RuDy0e1FD15bSP8Sc2IbXZww==
X-Gm-Gg: ASbGnctOiY5I+xyVAzWmK257oXXN0YDJN4haR3+p+lynsfGoby/6DlanMXuToSzAuAc
 CYqR7WGliFH9JFBzLVwknyHL/ABXKLIouF+FEKwJP5erzA3aqB/RInTZuYKMzh/1DpdQ7J2nNT+
 pi5qRm
X-Received: by 2002:a05:6870:4691:b0:2e9:e5e:8456 with SMTP id
 586e51a60fabf-2eaf0aa27cbmr4482612fac.22.1750053402380; 
 Sun, 15 Jun 2025 22:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBMgTOo6V83Vr2n/foVr+1aiBpPN8IkW/GP4RgtoNZqouLEGM+0QE/ca2UQHLZ7IkfwkfkJ2kOjYZBoy3Txmw=
X-Received: by 2002:a05:6870:4691:b0:2e9:e5e:8456 with SMTP id
 586e51a60fabf-2eaf0aa27cbmr4482605fac.22.1750053402102; Sun, 15 Jun 2025
 22:56:42 -0700 (PDT)
MIME-Version: 1.0
From: Yanghang Liu <yanghliu@redhat.com>
Date: Mon, 16 Jun 2025 13:56:30 +0800
X-Gm-Features: AX0GCFuPi3RKQKyfdxIt13q1C59eDBipcgk6QiCoEx4_jNILJ6IP9ZrlHLcKnKw
Message-ID: <CAGYh1E-mzKZS7f4za9E=sTds-b8CqOPytBkyu8WeCvafDjYtgw@mail.gmail.com>
Subject: RedHat QE's test result for DPDK release candidate v25.07-rc1
To: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Cc: Kevin Traynor <ktraynor@redhat.com>,
 David Marchand <david.marchand@redhat.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lXE2_9ZtvCuaOfraNYPkxuyIy6nlskxWU908Oz85ZrQ_1750053403
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000005ee7cf0637aa0f77"
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

--0000000000005ee7cf0637aa0f77
Content-Type: text/plain; charset="UTF-8"

I tested below 18 scenarios on RHEL 9.4 host and didn't find any new dpdk
issues.

   - VM with device assignment(PF) throughput testing(1G hugepage size):
   PASS
   - VM with device assignment(PF) throughput testing(2M hugepage size) :
   PASS
   - VM with device assignment(VF) throughput testing: PASS
   - PVP (host dpdk testpmd as vswitch) 1Q: throughput testing: PASS
   - PVP vhost-user 2Q throughput testing: PASS
   - PVP vhost-user 1Q - cross numa node throughput testing: PASS
   - VM with vhost-user 2 queues throughput testing: PASS
   - vhost-user reconnect with dpdk-client, qemu-server(qemu reconnect):
   PASS
   - vhost-user reconnect with dpdk-client, qemu-server(ovs reconnect): PASS
   - PVP  reconnect with dpdk-client, qemu-server: PASS
   - PVP 1Q live migration testing: PASS
   - PVP 1Q cross numa node live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 1Q live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 1Q live migration testing (2M): PASS
   - VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 4Q live migration testing: PASS
   - Host PF + DPDK testing: PASS
   - Host VF + DPDK testing: PASS


Test Versions:

   - qemu-kvm-8.2.0
   - kernel 5.14
   - libvirt 10.0
   - ovs 3.3
   - git describe
      - v25.07-rc1-8-gdbeb8ae8d0


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>

--0000000000005ee7cf0637aa0f77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr=
"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D=
"arial, sans-serif">I tested below 18 scenarios on RHEL 9.4 host and didn&#=
39;t find any new dpdk issues.</font></div><div dir=3D"ltr"><ul><li style=
=3D"margin-left:15px">VM with device assignment(PF) throughput testing(1G h=
ugepage size): PASS</li><li style=3D"margin-left:15px">VM with device assig=
nment(PF) throughput testing(2M hugepage size) : PASS</li><li style=3D"marg=
in-left:15px">VM with device assignment(VF) throughput testing: PASS</li><l=
i style=3D"margin-left:15px">PVP (host dpdk testpmd as vswitch) 1Q: through=
put testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-user 2Q thro=
ughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-user 1Q -=
 cross numa node throughput testing: PASS</li><li style=3D"margin-left:15px=
">VM with vhost-user 2 queues throughput testing: PASS</li><li style=3D"mar=
gin-left:15px">vhost-user reconnect with dpdk-client, qemu-server(qemu reco=
nnect): PASS</li><li style=3D"margin-left:15px">vhost-user reconnect with d=
pdk-client, qemu-server(ovs reconnect): PASS</li><li style=3D"margin-left:1=
5px">PVP =C2=A0reconnect with dpdk-client, qemu-server: PASS</li><li style=
=3D"margin-left:15px">PVP 1Q live migration testing: PASS</li><li style=3D"=
margin-left:15px">PVP 1Q cross numa node live migration testing: PASS</li><=
li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1Q live migration=
 testing: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-us=
er 1Q live migration testing (2M): PASS</li><li style=3D"margin-left:15px">=
VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS</li><li style=
=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 4Q live migration testing=
: PASS</li><li style=3D"margin-left:15px">Host PF + DPDK testing: PASS</li>=
<li style=3D"margin-left:15px">Host VF + DPDK testing: PASS</li></ul></div>=
<div><br><font face=3D"arial, sans-serif">Test Versions:<br><ul><li style=
=3D"margin-left:15px">qemu-kvm-8.2.0</li><li style=3D"margin-left:15px">ker=
nel 5.14</li><li style=3D"margin-left:15px">libvirt 10.0</li><li style=3D"m=
argin-left:15px">ovs 3.3</li><li style=3D"margin-left:15px">git describe</l=
i><ul><li style=3D"margin-left:15px">v25.07-rc1-8-gdbeb8ae8d0</li></ul></ul=
></font></div></div></div></div><div dir=3D"ltr" class=3D"gmail_signature">=
<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><font face=3D"a=
rial, sans-serif"><ul><li style=3D"margin-left:15px">Test device : X540-AT2=
 NIC(ixgbe, 10G)</li></ul></font></div></div></div><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signa=
ture"><div dir=3D"ltr"><div><font face=3D"arial, sans-serif">Tested-by: Yan=
ghang Liu &lt;<a href=3D"mailto:yanghliu@redhat.com" target=3D"_blank">yang=
hliu@redhat.com</a>&gt;</font></div></div></div></div></div></div>

--0000000000005ee7cf0637aa0f77--

