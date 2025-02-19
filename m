Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF308C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 06:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 962AD4028B;
	Wed, 19 Feb 2025 07:03:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 916AF4025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 07:03:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739945008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Mel0DyMUk+oo3cPFOcMduroM4lkp/MZ8Nz0tnr87N+s=;
 b=QjeZ+HDoxZinCVfuDIsoVKcn9XHiEbK0vwYIGvvEeQSwy3wndT3TvA9x5FpZadAzsJG5JM
 PALMXMILjfQNCrSUFHv0aelaCMRpvfKC4HLsw53plIzqbagQzcibCrbGaSAq52SFLtJB5f
 brFacdiIdHi4LHldej18XQB4idEkxAk=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-jXXjaliFO-eVS5PNcm3M9A-1; Wed, 19 Feb 2025 01:03:25 -0500
X-MC-Unique: jXXjaliFO-eVS5PNcm3M9A-1
X-Mimecast-MFC-AGG-ID: jXXjaliFO-eVS5PNcm3M9A_1739945004
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2bcbd5bfc95so2705568fac.3
 for <dev@dpdk.org>; Tue, 18 Feb 2025 22:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739945004; x=1740549804;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mel0DyMUk+oo3cPFOcMduroM4lkp/MZ8Nz0tnr87N+s=;
 b=Cmjj9kDnSE3DJKaBsswvN8BoubgnmQsavM8GhvvlMOpbmYzEL7VPeIeAxrLrL7q18a
 tvfGeXHOAxwenclJLnOL+wAABv3YwUxXjP6WNjdi0vPVpAcUPK6RcetYkYw421cZbN1I
 ZPoEkhzaW3ditSUKIt9+VxH7hWrBbHsj4sXD6RJu0qxGuf3tUE69Ibo1I22CBZDtmTKt
 4SK/VBNmMFOZ7PD5m6QMcWn4udsJ2Q5Y3WXjfaJe6zzs0oREBe0UllEk+Py8s7Fv1xRw
 ZNPckN2/Zw3XdSMpxW33eDpmJts3+pPGCQDANYy0Opgj9gMfE2P4QvVGHGbWiENh8Ubq
 NFcQ==
X-Gm-Message-State: AOJu0YwX588ojl4sJ0M19MoXfkZEwvI1BQKXB7ellOgzXDMN6oYBOULq
 ot8E1Anp77Ja4zl4sfG6XVS0+jNZU5r0WSOz+plYBvhB/AL3kUiT8hWDmqSouMyaTiwPEI8E2/2
 9/tgdVqkIqPHVQyvrFTT+6g3LmnF4QcBaSQHmj0TTVbp90Rkp5cvRjSxt/YPaKWt68SN4bcxmP6
 lmEIFeAtNhrpWUoeC386+F67t8q1fC
X-Gm-Gg: ASbGncvR6h6XUbjGOGqVpG4nez23MvK5HGKruWBA75mHQeWMpNC1lKY7oQCJsDfKn1S
 JnS3faPO2JegLsUbkqGvYrldHDN1Y77pMv30pJ5AJqI7u4vGVXn4QjBJqxN7zOIQ=
X-Received: by 2002:a05:687c:3385:b0:2bc:fadd:ece8 with SMTP id
 586e51a60fabf-2bcfade0fa6mr3117418fac.28.1739945003917; 
 Tue, 18 Feb 2025 22:03:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElGE7yDTWsguW/kG4x7BxmR5M0Z9tffjyO7CeqTr6zACXWvOB6WTbEjw0vODEMpH1RvT873lAs1982FFuYPC4=
X-Received: by 2002:a05:687c:3385:b0:2bc:fadd:ece8 with SMTP id
 586e51a60fabf-2bcfade0fa6mr3117402fac.28.1739945003601; Tue, 18 Feb 2025
 22:03:23 -0800 (PST)
MIME-Version: 1.0
From: Yanghang Liu <yanghliu@redhat.com>
Date: Wed, 19 Feb 2025 14:03:12 +0800
X-Gm-Features: AWEUYZnw_tqCUk8nT0QhYI_GLLZGsNouhC3maYu2Ng7q-WS3a7DSx5v2_ToJhgs
Message-ID: <CAGYh1E_mcZKmJwjSey_hA44FfHXF3vjrnXuMUTLcFjmysW2j3g@mail.gmail.com>
Subject: RedHat QE's test result against DPDK release candidate 25.03-rc1
To: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Cc: Kevin Traynor <ktraynor@redhat.com>,
 David Marchand <david.marchand@redhat.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PdL8ntzyHC52n0TY9W37Yx6wzIq8z89eLpdP-2y7xng_1739945004
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000de6844062e7883a3"
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

--000000000000de6844062e7883a3
Content-Type: text/plain; charset="UTF-8"

I tested below 18 scenarios on RHEL 9.4 hosts and didn't find any new dpdk
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
   - git log

                          Commit e5176f23ae8b31437c3e5eb875c81f95bf3a9942
                          Author: Thomas Monjalon <thomas@monjalon.net>
                          Date:   Wed Feb 12 17:13:27 2025 +0100
                              version: 25.03-rc1
                              Signed-off-by: Thomas Monjalon <
thomas@monjalon.net>

   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>

--000000000000de6844062e7883a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature=
"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><font face=3D"arial, sans-serif">I tested below 18 scenarios on RHEL 9.=
4 hosts and didn&#39;t find any new dpdk issues.</font></div><div dir=3D"lt=
r"><ul><li style=3D"margin-left:15px">VM with device assignment(PF) through=
put testing(1G hugepage size): PASS</li><li style=3D"margin-left:15px">VM w=
ith device assignment(PF) throughput testing(2M hugepage size) : PASS</li><=
li style=3D"margin-left:15px">VM with device assignment(VF) throughput test=
ing: PASS</li><li style=3D"margin-left:15px">PVP (host dpdk testpmd as vswi=
tch) 1Q: throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vh=
ost-user 2Q throughput testing: PASS</li><li style=3D"margin-left:15px">PVP=
 vhost-user 1Q - cross numa node throughput testing: PASS</li><li style=3D"=
margin-left:15px">VM with vhost-user 2 queues throughput testing: PASS</li>=
<li style=3D"margin-left:15px">vhost-user reconnect with dpdk-client, qemu-=
server(qemu reconnect): PASS</li><li style=3D"margin-left:15px">vhost-user =
reconnect with dpdk-client, qemu-server(ovs reconnect): PASS</li><li style=
=3D"margin-left:15px">PVP =C2=A0reconnect with dpdk-client, qemu-server: PA=
SS</li><li style=3D"margin-left:15px">PVP 1Q live migration testing: PASS</=
li><li style=3D"margin-left:15px">PVP 1Q cross numa node live migration tes=
ting: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1=
Q live migration testing: PASS</li><li style=3D"margin-left:15px">VM with o=
vs+dpdk+vhost-user 1Q live migration testing (2M): PASS</li><li style=3D"ma=
rgin-left:15px">VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS=
</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 4Q live mig=
ration testing: PASS</li><li style=3D"margin-left:15px">Host PF + DPDK test=
ing: PASS</li><li style=3D"margin-left:15px">Host VF + DPDK testing: PASS</=
li></ul></div><div><br><font face=3D"arial, sans-serif">Test Versions:<br><=
ul><li style=3D"margin-left:15px">qemu-kvm-8.2.0</li><li style=3D"margin-le=
ft:15px">kernel 5.14</li><li style=3D"margin-left:15px">libvirt 10.0</li><l=
i style=3D"margin-left:15px">ovs 3.3</li><li style=3D"margin-left:15px">git=
 log</li></ul><div><span style=3D"font-family:Arial,Helvetica,sans-serif">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Commit e5176f23ae8b31437c3e5eb875c81f</span><span style=
=3D"font-family:Arial,Helvetica,sans-serif">95bf3a9942</span><br style=3D"f=
ont-family:Arial,Helvetica,sans-serif"><span style=3D"font-family:Arial,Hel=
vetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Author: Thomas Monjalon &lt;</span><a hr=
ef=3D"mailto:thomas@monjalon.net" target=3D"_blank" style=3D"font-family:Ar=
ial,Helvetica,sans-serif">thomas@monjalon.net</a><span style=3D"font-family=
:Arial,Helvetica,sans-serif">&gt;</span><br style=3D"font-family:Arial,Helv=
etica,sans-serif"><span style=3D"font-family:Arial,Helvetica,sans-serif">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Date: =C2=A0 Wed Feb 12 17:13:27 2025 +0100</span><br sty=
le=3D"font-family:Arial,Helvetica,sans-serif"><span style=3D"font-family:Ar=
ial,Helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version: 25.03-rc1<=
/span><br style=3D"font-family:Arial,Helvetica,sans-serif"><div class=3D"gm=
ail_signature" style=3D"font-family:Arial,Helvetica,sans-serif"><div class=
=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Signed-off-by: Thomas =
Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net" target=3D"_blank">thoma=
s@monjalon.net</a>&gt;</div></div></div><ul><li style=3D"margin-left:15px">=
Test device : X540-AT2 NIC(ixgbe, 10G)</li></ul></font></div></div></div></=
div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><font face=3D"arial, =
sans-serif">Tested-by: Yanghang Liu &lt;<a href=3D"mailto:yanghliu@redhat.c=
om" target=3D"_blank">yanghliu@redhat.com</a>&gt;</font></div></div></div><=
/div></div></div>
</div>

--000000000000de6844062e7883a3--

