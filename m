Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F2CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 21:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0919C4026C;
	Tue, 19 Aug 2025 23:55:02 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id A5BFB40151
 for <dev@dpdk.org>; Tue, 19 Aug 2025 23:55:00 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-24457f581aeso44642145ad.0
 for <dev@dpdk.org>; Tue, 19 Aug 2025 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755640500; x=1756245300; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=arMOJKlgJeHP8+E3sbuujbwy/CjnLDL64b1U86dyIIs=;
 b=agHRfsbDOoy4rm1LbYqqL9elkbF8fQDCk/fEDHE65iuQSBjQn87p9lQcA2a0DqJfyz
 k8E5LMFbTgCkVwHl7a/05DJZJg+ncHXvuLGhfgeQiAgD8GeuKWKVbWezFtjgQ+Ecy8Mc
 da0jKPjYdxtehXN8iETPi9v2dBZ2bodmOI8qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755640500; x=1756245300;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=arMOJKlgJeHP8+E3sbuujbwy/CjnLDL64b1U86dyIIs=;
 b=m5ECNFQfT26O2BsiFlfJJAM2oTXfMXdkH+bq4GOgk1pL1vTaUB/kbZxvLJ9Xna0RW1
 MHZ3WZlP4b8RGinsJdNNTHArRBTWRC8jnqoQi8ZWTx7T7xygfRRqd/J68vUijF239+yn
 e+SJIEO+8SWBP1uYhGYDV5KCUTDvuaRmURefdW3obVuIyY0cegtyGx0LivZtenhKemij
 SJ1vxzksKcVTX4VJ2HAt4ubZngI7YXDbaXZOz+1j9aGvQsK/PfjQETc0xLWf7HEfkYtR
 D4BjkduIopo7F8JrxCyaZqG18xPdQ+0L/1KPN3JWHJyHAZgJJuZSuDdZgVVwGfSOlODh
 r0vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsMqWbsigfXJG+YLsTCsy3VM+8p356xopTlt8mWkJzAHpQojLoKLZQjDAFRZgPhk+jmJA=@dpdk.org
X-Gm-Message-State: AOJu0YwvkWfz8sG3MynCnfAhq9v+Ryxn462qtlmVOk258DauN1rxANx8
 FXliQLg2reD7SqpOYwUBqge+ONgVxX1v1dzrS0vtWw7YDoraVAKaxgVdOpXciw19/GGILkTpjcI
 6gah7fEiAr0YUnVElny77Wi33LT0gVZZ7mHaN49Y6nw==
X-Gm-Gg: ASbGncsDegVcTzmf/rH+j0fZyU7vOEQ1N4uPzt1gmh9CAEdyTuhb91dDeFrkgcfG8OM
 1XuLB76baaLqzGXHdVUfi637WW+qnFEi76wg9MlpnApU/pCQgqxxZidbzWAglKpsNkP25v9RdoC
 0J0WWP1V1gtxMfXwQZ0HYhGZirrN0I9Jhbiman4ZCt/Nahrfqnp0ryiPjXBJiZNDuDHqsN+BDze
 nL7K3r6JlGQtqDsvs7rwA==
X-Google-Smtp-Source: AGHT+IFKDeRdMJ698NLvpdV20UJUBVW6xt55LBcADTjFBJQQPt0lL+HcGa/yGOX4ILhgQLuQ9+U7pxwpqsxslPz4dg0=
X-Received: by 2002:a17:903:41c6:b0:244:9b69:c920 with SMTP id
 d9443c01a7336-245ef14380emr5692345ad.14.1755640499676; Tue, 19 Aug 2025
 14:54:59 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 19 Aug 2025 17:48:28 -0400
X-Gm-Features: Ac12FXxsimm7H6QIQzOXq_FwyLbmvg5gFBrrKFlWHO3FjT4dFbf-8s9ShR6UY70
Message-ID: <CAJvnSUC58OS+1GqvVgG0ZLCmLXXj3EgibkZ2_oH6EiptuJBm6g@mail.gmail.com>
Subject: Virtio testing goals for DTS
To: Aaron Conole <aconole@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Chenbo Xia <chenbox@nvidia.com>, dev <dev@dpdk.org>,
 "ci@dpdk.org" <ci@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000563f6e063cbee8e3"
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

--000000000000563f6e063cbee8e3
Content-Type: text/plain; charset="UTF-8"

Hi Aaron or Maxime,

I want to get your perspective on our testing goals for virtio in DTS if
you are willing.

Dean, who works on DTS, has been running various PVP and PVVP virtio
workloads on one of the SUT servers at UNH, as well as some single VM and
double VM (with inter VM DPDK forwarding) virtio workloads just on his
laptop, so that we can start to get an idea of how we can start validating
DPDK virtio.

We are aware that there is likely a need/desire for us to setup some
vhost-user + virtio testsuites, i.e. there is a tester (traffic gen) server
paired up against a SUT server, the SUT server sets up vhost-user
device(s), creates a VM(s), and creates a virtio-net-pci device which is
connected to the vhost socket from the host, and then we start testpmd in
the VM using the virtio-net-pci device(s). Then we send traffic from the TG
and assess the DPDK behavior inside the virtio VM. Or, we can run the
testpmd inside the VM frontend in tx_only mode and transmit traffic to the
backend vhost testpmd. In any case, these are vhost testplan specific
details which don't really pertain to my real question which is below.

The question I have for you is do you think there would be any benefit to
producing testcases that validating DPDK usage of virtio-net-pci devices in
a VM, but without involving Vhost, and keeping the entire "test"
constrained to a single host. By this I mean, instead of setting up some
vhost/testpmd application on the SUT and forwarding packets from physical
NIC ports to the vhost vdev (which is then accessed by the VM virtio
interfaces), the testcases would involve creating a TAP interface(s) on the
SUT, then making a VM and accessing the TAP interfaces via a virtio
interface in the VM, and then just starting Scapy on the SUT host and
sending traffic at the TAP interfaces, which goes into the VM? This would
mean that the test would not involve any physical devices, but it would
still be validating DPDK Virtio. One reason why this is attractive is that
it would not require particular hardware, I.e. it runs on 1 system and that
system could even be your laptop since it only relies on virtual
interfaces. David had asked about this possibility at Prague, and I think
at that time Maxime piped up to say "and this would also be useful for
virtio" or something like that. Anyhow, let me know if you think this makes
sense or any other thoughts you may have. If it is a reasonable direction
to go in we can start drawing up test plans.

I realize this is kind of a wall of text... happy to discuss at the CI
meeting on Thursday if that is better.

Thanks,
Patrick

--000000000000563f6e063cbee8e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Aaron or Maxime,=
=C2=A0</div><div><br></div><div>I want to get your perspective on our testi=
ng goals for virtio in DTS if you are willing.</div><div><br></div><div>Dea=
n, who works on DTS, has been running various PVP and PVVP=C2=A0virtio work=
loads on one of the SUT servers at UNH, as well as some single VM and doubl=
e VM (with inter VM DPDK forwarding) virtio workloads just on his laptop, s=
o that we can start to get an idea of how we can start validating DPDK virt=
io.</div><div><br></div><div>We are aware that there is likely a need/desir=
e for us to setup some vhost-user=C2=A0+ virtio testsuites, i.e. there is a=
 tester (traffic gen) server paired up against a SUT=C2=A0server, the SUT s=
erver sets up vhost-user device(s), creates a VM(s), and creates a virtio-n=
et-pci device which is connected to the vhost socket from the host, and the=
n we start testpmd in the VM using the virtio-net-pci device(s). Then we se=
nd traffic from the TG and assess the DPDK behavior inside the virtio VM. O=
r, we can run the testpmd inside the VM frontend in tx_only mode and transm=
it traffic to the backend vhost testpmd. In any case, these are vhost testp=
lan specific details which don&#39;t really pertain to my real question whi=
ch is below.</div><div><br></div><div>The question I have for you is do you=
 think there would be any benefit to producing testcases that validating DP=
DK usage of virtio-net-pci devices in a VM, but without involving Vhost, an=
d keeping the entire &quot;test&quot; constrained to a single host. By this=
 I mean, instead of setting up some vhost/testpmd application on the SUT an=
d forwarding packets from physical NIC ports to the vhost vdev (which is th=
en accessed by the VM virtio interfaces), the testcases would involve creat=
ing a TAP interface(s) on the SUT, then making a VM and accessing the TAP i=
nterfaces via a virtio interface in the VM, and then just starting Scapy on=
 the SUT host and sending traffic at the TAP interfaces, which goes into th=
e VM? This would mean that the test would not involve any physical devices,=
 but it would still be validating DPDK Virtio. One reason why this is attra=
ctive is that it would not require particular hardware, I.e. it runs on 1 s=
ystem and that system could even be your laptop since it only relies on vir=
tual interfaces. David had asked about this possibility at Prague, and I th=
ink at that time Maxime piped up to say &quot;and this would also be useful=
 for virtio&quot; or something like that. Anyhow, let me know if you think =
this makes sense or any other thoughts you=C2=A0may have. If it is a reason=
able direction to go in we can start drawing up test plans.</div><div><br><=
/div><div>I realize this is kind of a wall of text... happy to discuss at t=
he CI meeting on Thursday if that is better.</div><div><br></div><div>Thank=
s,</div><div>Patrick</div></div>
</div>
</div>

--000000000000563f6e063cbee8e3--
