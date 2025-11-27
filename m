Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41973D11183
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 08:16:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 682CF40B8F;
	Thu, 27 Nov 2025 09:16:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DCBFE4013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 09:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764231359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=Nga0YxO4hdV0Qx8voSg+5+kFJtERQQ5jpYnLIw1qWNM=;
 b=QzcITe9LSwQcnRGkVW+I6qnPwWck4UE3xtC1Ya6ppko2P8ayPoa0/w54bA3miHidwMgqsM
 LEyc+97yWk4RzaX5N5MF5SqRssjzB490HdZHzBwbHe74c0FJlnS7/Ge1qONRjy44KbmXmP
 hFFsFxDZeCeOvtGZpePKMStmvfVnmfc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-eA5pWml7PeOwfkA3bHc-Ug-1; Thu, 27 Nov 2025 03:15:53 -0500
X-MC-Unique: eA5pWml7PeOwfkA3bHc-Ug-1
X-Mimecast-MFC-AGG-ID: eA5pWml7PeOwfkA3bHc-Ug_1764231353
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-657501e1dcfso511275eaf.1
 for <dev@dpdk.org>; Thu, 27 Nov 2025 00:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764231352; x=1764836152;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nga0YxO4hdV0Qx8voSg+5+kFJtERQQ5jpYnLIw1qWNM=;
 b=VLnH3xMNEItMsONeuhLokMYFKRcsDUunq9HTLAiSte9G85kcaTwBPXvz265O7IJFPp
 zKRvDJB2LEgz6ZS3yH7cpVK4Vd63NdXzmqYt4yc31SQXSinHtJ+ZlkiTTYCTm/ETjSHa
 sqgegd5nCvV6RQ0zcgu9sNMiKDwue1qEQa9evgN94aIh+xjzvUrCyUfcAmpO9ZlpMQUa
 FDFmuWPjuwz1OWFfSZLuHVLghPHTO+ZePsuF4Es0tiivK63F0oPygG7wl5MxwbhBxEO3
 Tg8KYa6qh+z5P3urpGpai+HdEZBXs8Wo7V5TwtD0is4rG1LOs+mvpEc3tjJLoTye6bMW
 elPw==
X-Gm-Message-State: AOJu0Yx6tn5Jk+reFO6XTuC35teW+nobyfui9r7eXMQQldFoMWwRWkLg
 ycpls4NiujdWN6daoVKznbxECpkPv58Wu2JWpEqLjRyqGe2aVpCEApwc/dckwo9DzZifORP7sK2
 WTXTsMOEa3lAEwCyn0MRr15c40Nr0XHFCe8DFAMt8dstGQBo1rtGnhe9UMJRnsg/qKbF1HJ7O1k
 JSsXvn28QO8hqx0lgWCCXbaBbsWZY6ZgQ0
X-Gm-Gg: ASbGnctUNTgp4HqqL4Nhd9NRy65y14G1Jy6+X6wmXDBVq41GMuyJu5joflc2b3gxv43
 BOf2nnZDoJckqQdRK12urd2B6ah5UBS5yPSPBGcK7XAXf/iL9i5aXnv5LYPlbpTxf8MXU/9hgxu
 1HOJ4TA3KXnxlGPjKEBTkg5/MM+qTYkh4i1QrYn5G/nThUQ7ecA4LUv9GexG6yI8jFu0w=
X-Received: by 2002:a05:6820:1525:b0:654:f77a:1a5c with SMTP id
 006d021491bc7-65790b0f406mr9215604eaf.3.1764231352495; 
 Thu, 27 Nov 2025 00:15:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo+k/QOCtdxH1HrzAW4K8P0Y0DuXwVcXL4Cwt8xgsvw590K2mDYKmzeXsJFVQWTwFzaDQNSGDScFu57jVoFKQ=
X-Received: by 2002:a05:6820:1525:b0:654:f77a:1a5c with SMTP id
 006d021491bc7-65790b0f406mr9215600eaf.3.1764231352229; Thu, 27 Nov 2025
 00:15:52 -0800 (PST)
MIME-Version: 1.0
From: Yanghang Liu <yanghliu@redhat.com>
Date: Thu, 27 Nov 2025 16:15:40 +0800
X-Gm-Features: AWmQ_bkTs1ql_p0x-MoEFK1qg932CPEcHbf3HITFo4nO7eqpC4irmOotsdGeL1M
Message-ID: <CAGYh1E-XYZ+-KDpQ=EPat2bqrRfz5gL+i83D=s0TiqH70LVvVw@mail.gmail.com>
Subject: RedHat QE's test result for DPDK release candidate v25.11-rc4
To: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e8-m0z_41HFrTt9KfwPNpSbecHEL1imk1hcU7dT33eM_1764231353
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000000d333806448f1f30"
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

--0000000000000d333806448f1f30
Content-Type: text/plain; charset="UTF-8"

I tested below 18 scenarios on RHEL 9.6 host and didn't find any new dpdk
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

   - qemu-kvm-9.1.0
   - kernel 5.14
   - libvirt 10.10
   - ovs 3.6
   - git describe
      - v25.11-rc4


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>

--0000000000000d333806448f1f30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><font face=3D"arial, sans-serif">I tested below 18 scenarios on RH=
EL 9.6 host and didn&#39;t find any new dpdk issues.</font></div><div dir=
=3D"ltr"><ul><li style=3D"margin-left:15px">VM with device assignment(PF) t=
hroughput testing(1G hugepage size): PASS</li><li style=3D"margin-left:15px=
">VM with device assignment(PF) throughput testing(2M hugepage size) : PASS=
</li><li style=3D"margin-left:15px">VM with device assignment(VF) throughpu=
t testing: PASS</li><li style=3D"margin-left:15px">PVP (host dpdk testpmd a=
s vswitch) 1Q: throughput testing: PASS</li><li style=3D"margin-left:15px">=
PVP vhost-user 2Q throughput testing: PASS</li><li style=3D"margin-left:15p=
x">PVP vhost-user 1Q - cross numa node throughput testing: PASS</li><li sty=
le=3D"margin-left:15px">VM with vhost-user 2 queues throughput testing: PAS=
S</li><li style=3D"margin-left:15px">vhost-user reconnect with dpdk-client,=
 qemu-server(qemu reconnect): PASS</li><li style=3D"margin-left:15px">vhost=
-user reconnect with dpdk-client, qemu-server(ovs reconnect): PASS</li><li =
style=3D"margin-left:15px">PVP =C2=A0reconnect with dpdk-client, qemu-serve=
r: PASS</li><li style=3D"margin-left:15px">PVP 1Q live migration testing: P=
ASS</li><li style=3D"margin-left:15px">PVP 1Q cross numa node live migratio=
n testing: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-u=
ser 1Q live migration testing: PASS</li><li style=3D"margin-left:15px">VM w=
ith ovs+dpdk+vhost-user 1Q live migration testing (2M): PASS</li><li style=
=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 2Q live migration testing=
: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 4Q li=
ve migration testing: PASS</li><li style=3D"margin-left:15px">Host PF + DPD=
K testing: PASS</li><li style=3D"margin-left:15px">Host VF + DPDK testing: =
PASS</li></ul></div><div><br><font face=3D"arial, sans-serif">Test Versions=
:<br><ul><li style=3D"margin-left:15px">qemu-kvm-9.1.0</li><li style=3D"mar=
gin-left:15px">kernel 5.14</li><li style=3D"margin-left:15px">libvirt 10.10=
</li><li style=3D"margin-left:15px">ovs 3.6</li><li style=3D"margin-left:15=
px">git describe</li><ul><li style=3D"margin-left:15px">v25.11-rc4</li></ul=
></ul></font></div></div></div></div><div dir=3D"ltr" class=3D"gmail_signat=
ure"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><font face=
=3D"arial, sans-serif"><ul><li style=3D"margin-left:15px">Test device : X54=
0-AT2 NIC(ixgbe, 10G)</li></ul></font></div></div></div><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_si=
gnature"><div dir=3D"ltr"><div><font face=3D"arial, sans-serif">Tested-by: =
Yanghang Liu &lt;<a href=3D"mailto:yanghliu@redhat.com" target=3D"_blank">y=
anghliu@redhat.com</a>&gt;</font></div></div></div></div></div></div></div>
</div>

--0000000000000d333806448f1f30--

