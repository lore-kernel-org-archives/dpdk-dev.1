Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED5BCCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 432DE40667;
	Tue, 21 Oct 2025 19:35:46 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id BEA14402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:35:44 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-784807fa38dso48024077b3.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761068144; x=1761672944; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKiwndp2+1Bqt3Gki7f1/2RtJOXCqB1eYANzr48OX/8=;
 b=d4I+J5W/MQLfG6d/yPm6inuNrJhZ483ADeMdCoQAqGTjKuC92ZwJ5qg2v+ZbtjxnaY
 s6hNRNM84zk6Xj38Ios3Nw4VOzQp/HoDiPIchh0C+93ayAdrnY02q9GyfZN33QsP3NPc
 /qW8g8SOwOt8SYJ5QUfX/xqi4gFrDXd9A510A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761068144; x=1761672944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKiwndp2+1Bqt3Gki7f1/2RtJOXCqB1eYANzr48OX/8=;
 b=WG/IITPBpwJbwqslqiFSeo8fDZREUZN1iTjUsdbYTwDNa/5B9ay5lGPGatC8NZuJx4
 J5OKZI2WBCZVtdWXzsKUn43QftBjPHEvOSmbK4Rb9e9nh9qa81SvAIZ6Fb4vkvkXDMuO
 mHB51bZZWJvQu9gRnv76JFmsAywcUGt2nMTAXPOQvTt9d0Ch3W3TIypVjVwqpsMlaxPf
 u8/my/iVv69UQAn107pgZueYJIwkbm/azslvPejGs45Z56v50Cz5DIWAXdcaxVk+ORGv
 QIEM6ci8Gr6Ty/9g4uiS3HYT6Ci1TDDFBp8BgtdM+yAgp21X3FWKrwKpP66RGABe3MLH
 nuZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsyaL1kTXv055AG3vRkme0a9Efuk4/u3WSuLKzkjjE1DxTPVfwPzoQ5qA8VTpViAkY2m8=@dpdk.org
X-Gm-Message-State: AOJu0Yz1gjLV5agfY/wqM+LrQt2LhpE01wZNmuRje59xGhB5HjEU3y4C
 twx7WO708ghTlNmug7Ezl2oUPowjHiLrreSGZGqCFnlgiAJVgn/oTBkbtZzs4OYgvc4Kb+0+Gz3
 0cHVTmL9MChvuBEV4XOlghWZXBm4oUXzRocWSOAjTo45OhiDXJ2kp
X-Gm-Gg: ASbGnctJwFir8+9vRBdNflfWNOzR5P0rrLflWneAS5Huzn3IUziSmjAo9/rImgN5ir5
 +e1B3rxyDto98ZkLmHEML7ftjHSiwtT1JtXVKhHmSBaGhiFFdiGagAOEr7r+uTFeRTCqn0vs6Cg
 ZDkMaj1flJh2+VvBZw5IbwgMHxVdO1iFCW/ENQUzYbynBHE2H8+/vTnV4oxiJsojpN5J6YpJNkQ
 b6lofxlkUMQ7+ZuSikOFZ7h13Pgg2cqPnrOqhk2OdNQzewQUAY5DPI6k5ixPFoJgANS+st1dmlb
 y2riRVWOiKJj1Ublyos=
X-Google-Smtp-Source: AGHT+IE2zr6g+mdV+UF7KvIQZdP0t9xHslUeB42QKjclJEXB17ZayADLWk1RQSC4oPdJ+o4bJ/Nr+30avdpxy93Hujs=
X-Received: by 2002:a53:be4f:0:b0:63c:f5a6:f2f7 with SMTP id
 956f58d0204a3-63e161da571mr10251513d50.57.1761068143806; Tue, 21 Oct 2025
 10:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
 <20251003192717.444490-1-dmarx@iol.unh.edu>
 <20251003192717.444490-2-dmarx@iol.unh.edu>
 <176105647358.88782.2909811739370348721.luca.vizzarro@arm.com>
In-Reply-To: <176105647358.88782.2909811739370348721.luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 21 Oct 2025 13:35:32 -0400
X-Gm-Features: AS18NWBzsOGgLpRkFznTdcAT-j-VhaJHsU8o4uIV323bxwYP8idUD8ixljQlyOw
Message-ID: <CABD7UXPoNjmb4tYm2tKG86UX4hyKfQo1M21JH6v78MYUqjjnMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add virtio forwarding test suite
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, 
 paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Oct 21, 2025 at 11:13=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om> wrote:
>
> On Fri, Oct 03, 2025 at 03:27:16PM +0000, Dean Marx wrote:
> > Add test suite covering virtio-user and vhost
> > server/client forwarding scenarios with
> > testpmd packet validation.
> >
> > Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
<snip>
> > +
> > +virtio_fwd Test Suite
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> this is fine, but ideally should be aligned with the heading.

I'll change this, I just noticed I put it in the wrong directory too
so thanks to you and Patrick for pointing that out

<snip>
> > +    class vdevs:
> > +        """Class containing virtio-user and vhost-user virtual devices=
."""
> is it actually vhost-user? or just vhost?

It's vhost-user since it's using a unix socket path (/tmp/vhost-net),
whereas a vhost version would use a kernel network interface like tap0
or something similar.

> > +
> > +        virtio_user =3D VirtualDevice(
> > +            "net_virtio_user0,mac=3D00:01:02:03:04:05,path=3D/tmp/vhos=
t-net,server=3D1"
> > +        )
> > +        vhost_user =3D VirtualDevice("eth_vhost0,iface=3D/tmp/vhost-ne=
t,client=3D1")
>
> How come you put these properties under some internal classes? Not sure
> how this helps. The vdevs class should technically be capitalised as
> well. Either way if these are just class variables, they should be made
> as such. Doing the following:
>
>   parse_rx_packets: ClassVar[ParserFn] =3D TextParser...
>   parse_tx_packets: ...
>   virtio_user_vdev: ClassVar[VirtualDevice] =3D ...
>   vhost_user_vdev: ...
>
> is perfectly fine and acceptable.
>
> I've changed the naming of the parser functions, because you are
> effectively treating these as functions, then they should be named as
> such.

Got it, I'll change this

<snip>
> > +
> > +            rx_packets =3D self.ForwardingParsers.rx_packets["TextPars=
er_fn"](forwarding_stats) or 0
> > +            tx_packets =3D self.ForwardingParsers.tx_packets["TextPars=
er_fn"](forwarding_stats) or 0
>
> So I understand you are basically reusing the functionality of the
> TextParser functions here. I guess it's not a bad shout but I would not
> expose the internals which are only meant to be used within the
> TextParser class for handling with generic dataclass metadata.
>
> Ideally we want this:
>
>   rx_packets =3D self.parse_rx_packets(forwarding_stats) or 0
>
> You can implement __call__ in ParserFn to make this happen. In the best
> scenario we'd want the return type to be correct as well instead of just
> Any. If you want to, you can play around and implement a Generic[T] in
> ParserFn to replace Any with T. This will probably require you to make
> changes elsewhere though. It may get tricky easily, so it's not really
> mandatory.

Hmm okay, I'll try to write a workaround for this without
overcomplicating things

<snip>
> > +        with TestPmd(
> > +            prefix=3D"virtio",
> > +            vdevs=3D[VirtualDevice("virtio_user0,path=3D/dev/vhost-net=
,queues=3D1,queue_size=3D1024")],
> > +        ) as virtio:
> > +            self.sut_node.main_session.send_command("ip link set dev t=
ap0 up", privileged=3DTrue)
>
> This should have been implemented as part of main_session. If it's not,
> it should. Shouldn't call send_command directly like this.

I'll add this to the next version

>
> > +            with TestPmd(
> > +                prefix=3D"vhost", no_pci=3DTrue, vdevs=3D[VirtualDevic=
e("net_af_packet0,iface=3Dtap0")]
> > +            ) as vhost:
> > +                virtio.set_forward_mode(SimpleForwardingModes.mac)
> > +                vhost.set_forward_mode(SimpleForwardingModes.mac)
> > +                vhost.start()
> > +                virtio.start()
> > +
> > +                packet =3D Ether() / IP()
> > +                packets =3D [packet] * 100
> > +                captured_packets =3D self.send_packets_and_capture(pac=
kets)
> > +
> > +                self.verify(
> > +                    len(captured_packets) >=3D 100, "Sent packets not =
received on physical interface."
> > +                )
> > --
> > 2.51.0
> >
