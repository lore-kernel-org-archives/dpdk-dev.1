Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7EBCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 21:56:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 649D44026C;
	Tue, 19 Aug 2025 23:56:08 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3812E40151
 for <dev@dpdk.org>; Tue, 19 Aug 2025 23:56:07 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b47174aec0eso3898147a12.2
 for <dev@dpdk.org>; Tue, 19 Aug 2025 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755640566; x=1756245366; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KiEQQ/5flOQTAKJzUy+9C1ZBzVosTjxKoQ4McRWqWnk=;
 b=W77el7n6152aScd8CEwU6nWu7tUaHcE3F6VwLEBV3q3wpYKveornTUzMKG5rSsAZbZ
 36E9VQ7IpRTLQs2Ep5Bv+y9EB4RdlU7AJ9b89xiUr9RgFDpE7d+C/0XEMb6ngfpjMXJ6
 BKTIklza7XCvo9di7eEk5lIGwRl943RDqYxWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755640566; x=1756245366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiEQQ/5flOQTAKJzUy+9C1ZBzVosTjxKoQ4McRWqWnk=;
 b=cPtWQwsX8BQtBu+/1nyrPSI4blj6xkh2sNM6becxqVEzNIxD0PrkaXi8KczbOk2z9P
 IWdwxfn1f0xjo2BpDlNVA+/0MzDh/BS9SrOLmrLzNc/A46io8/kjZUI01v2fDhfOP/46
 t++GYVZoExy+N7LQD2VeeM+HLZ6TwDoq4AqPnlyxYsVUv6N6JITT7n2E7b+7L8D2ON1k
 7X1UvlxAaZFl2nD9IP2i1E4os4RncURfvkSGCCLBwBINQ+oYqwKL20LI2Xugs4sIc0aY
 TNERjwv1PNBsBnK/PRLq/TV3ArxCDJWP4ku93fU9/ZPXUQxKexQtbzmQhxnz3F2YU7Bj
 Ecqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLz93mLGerGtyU+ICngH3G3L31o3+B0P7SCXrh2L+TVUL6Yzam87a0wUs+X6ZP2L4ApcQ=@dpdk.org
X-Gm-Message-State: AOJu0Yz2rzaN7EPGc648R1X3Lwx9UnHjxvmynbe4Ekyed1BaaJL0J4PH
 908/UUWjqLgkxWdJ2SEJmq9paoxW0WXIFQ9Oh8hFfZgbSmqnMq5x7Qqpfa0wx9MnPMNGtKZcy4g
 IQourmqJQUJjQkiRyXrNk3NkVXl7HYxkRqjjBGAY6VQ==
X-Gm-Gg: ASbGnctRei7RRssWWrmh1aY/NwQ/sQ4S2l8dzU7jNMV2+keBM2KO1xSYPdiyReFy2IJ
 S+AU1Mq0i5XQjtG8yU4eoSevHOOt9Apu5Wu8jbyxCHcpHA+YbRHkzPsyxhDC/synUBMiZZNWa9O
 7kiARSyAF46p1+zY1ZzrxfkQfjKyPCNu7A0sIvfOnzM5i4VPfivrJn2t29lYRDFx0QLXc3OILt5
 ArWgkSHlnpvPWhF2WTv8yruHf/72eob
X-Google-Smtp-Source: AGHT+IEd555I25GBHpyYL4oPxW60KWrM2Urv2JWldjE8B44lFcW3fz2kDjIDALiUpoBUyELPaF6Xekk8/ufI2WNLbPQ=
X-Received: by 2002:a17:903:1aeb:b0:242:9bc6:63c3 with SMTP id
 d9443c01a7336-245ef27bb12mr5052735ad.54.1755640566302; Tue, 19 Aug 2025
 14:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUC58OS+1GqvVgG0ZLCmLXXj3EgibkZ2_oH6EiptuJBm6g@mail.gmail.com>
In-Reply-To: <CAJvnSUC58OS+1GqvVgG0ZLCmLXXj3EgibkZ2_oH6EiptuJBm6g@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 19 Aug 2025 17:49:35 -0400
X-Gm-Features: Ac12FXzR0FNJWV1cheyq3ai0wArbD6XK9lw735EAjCigjJe8Rh0YL_65L7jAnb0
Message-ID: <CAJvnSUAB9u7oYipsFWKTMWMpVDF7FjX5BcqbkngNS28OsAmR_A@mail.gmail.com>
Subject: Re: Virtio testing goals for DTS
To: Aaron Conole <aconole@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Chenbo Xia <chenbox@nvidia.com>, dev <dev@dpdk.org>,
 "ci@dpdk.org" <ci@dpdk.org>, Dean Marx <dmarx@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000004ee562063cbeec5c"
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

--0000000000004ee562063cbeec5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Dean who I forgot to CC.

On Tue, Aug 19, 2025 at 5:48=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Hi Aaron or Maxime,
>
> I want to get your perspective on our testing goals for virtio in DTS if
> you are willing.
>
> Dean, who works on DTS, has been running various PVP and PVVP virtio
> workloads on one of the SUT servers at UNH, as well as some single VM and
> double VM (with inter VM DPDK forwarding) virtio workloads just on his
> laptop, so that we can start to get an idea of how we can start validatin=
g
> DPDK virtio.
>
> We are aware that there is likely a need/desire for us to setup some
> vhost-user + virtio testsuites, i.e. there is a tester (traffic gen) serv=
er
> paired up against a SUT server, the SUT server sets up vhost-user
> device(s), creates a VM(s), and creates a virtio-net-pci device which is
> connected to the vhost socket from the host, and then we start testpmd in
> the VM using the virtio-net-pci device(s). Then we send traffic from the =
TG
> and assess the DPDK behavior inside the virtio VM. Or, we can run the
> testpmd inside the VM frontend in tx_only mode and transmit traffic to th=
e
> backend vhost testpmd. In any case, these are vhost testplan specific
> details which don't really pertain to my real question which is below.
>
> The question I have for you is do you think there would be any benefit to
> producing testcases that validating DPDK usage of virtio-net-pci devices =
in
> a VM, but without involving Vhost, and keeping the entire "test"
> constrained to a single host. By this I mean, instead of setting up some
> vhost/testpmd application on the SUT and forwarding packets from physical
> NIC ports to the vhost vdev (which is then accessed by the VM virtio
> interfaces), the testcases would involve creating a TAP interface(s) on t=
he
> SUT, then making a VM and accessing the TAP interfaces via a virtio
> interface in the VM, and then just starting Scapy on the SUT host and
> sending traffic at the TAP interfaces, which goes into the VM? This would
> mean that the test would not involve any physical devices, but it would
> still be validating DPDK Virtio. One reason why this is attractive is tha=
t
> it would not require particular hardware, I.e. it runs on 1 system and th=
at
> system could even be your laptop since it only relies on virtual
> interfaces. David had asked about this possibility at Prague, and I think
> at that time Maxime piped up to say "and this would also be useful for
> virtio" or something like that. Anyhow, let me know if you think this mak=
es
> sense or any other thoughts you may have. If it is a reasonable direction
> to go in we can start drawing up test plans.
>
> I realize this is kind of a wall of text... happy to discuss at the CI
> meeting on Thursday if that is better.
>
> Thanks,
> Patrick
>

--0000000000004ee562063cbeec5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Adding Dean who I forgot to CC.</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Aug 19, 2025 at 5:48=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailt=
o:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div>Hi Aaron or Maxime,=C2=A0</div><div><br></div><div>I wan=
t to get your perspective on our testing goals for virtio in DTS if you are=
 willing.</div><div><br></div><div>Dean, who works on DTS, has been running=
 various PVP and PVVP=C2=A0virtio workloads on one of the SUT servers at UN=
H, as well as some single VM and double VM (with inter VM DPDK forwarding) =
virtio workloads just on his laptop, so that we can start to get an idea of=
 how we can start validating DPDK virtio.</div><div><br></div><div>We are a=
ware that there is likely a need/desire for us to setup some vhost-user=C2=
=A0+ virtio testsuites, i.e. there is a tester (traffic gen) server paired =
up against a SUT=C2=A0server, the SUT server sets up vhost-user device(s), =
creates a VM(s), and creates a virtio-net-pci device which is connected to =
the vhost socket from the host, and then we start testpmd in the VM using t=
he virtio-net-pci device(s). Then we send traffic from the TG and assess th=
e DPDK behavior inside the virtio VM. Or, we can run the testpmd inside the=
 VM frontend in tx_only mode and transmit traffic to the backend vhost test=
pmd. In any case, these are vhost testplan specific details which don&#39;t=
 really pertain to my real question which is below.</div><div><br></div><di=
v>The question I have for you is do you think there would be any benefit to=
 producing testcases that validating DPDK usage of virtio-net-pci devices i=
n a VM, but without involving Vhost, and keeping the entire &quot;test&quot=
; constrained to a single host. By this I mean, instead of setting up some =
vhost/testpmd application on the SUT and forwarding packets from physical N=
IC ports to the vhost vdev (which is then accessed by the VM virtio interfa=
ces), the testcases would involve creating a TAP interface(s) on the SUT, t=
hen making a VM and accessing the TAP interfaces via a virtio interface in =
the VM, and then just starting Scapy on the SUT host and sending traffic at=
 the TAP interfaces, which goes into the VM? This would mean that the test =
would not involve any physical devices, but it would still be validating DP=
DK Virtio. One reason why this is attractive is that it would not require p=
articular hardware, I.e. it runs on 1 system and that system could even be =
your laptop since it only relies on virtual interfaces. David had asked abo=
ut this possibility at Prague, and I think at that time Maxime piped up to =
say &quot;and this would also be useful for virtio&quot; or something like =
that. Anyhow, let me know if you think this makes sense or any other though=
ts you=C2=A0may have. If it is a reasonable direction to go in we can start=
 drawing up test plans.</div><div><br></div><div>I realize this is kind of =
a wall of text... happy to discuss at the CI meeting on Thursday if that is=
 better.</div><div><br></div><div>Thanks,</div><div>Patrick</div></div>
</div>
</div>
</blockquote></div></div>

--0000000000004ee562063cbeec5c--
