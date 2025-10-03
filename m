Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FE5CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 18:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9715402C1;
	Fri,  3 Oct 2025 20:14:50 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0862F402B5
 for <dev@dpdk.org>; Fri,  3 Oct 2025 20:14:49 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-71d5fe46572so35980757b3.1
 for <dev@dpdk.org>; Fri, 03 Oct 2025 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759515288; x=1760120088; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1F4db378x3BXYeP6tVhLjwh4Q8nkQsArvOAGNpPX8hM=;
 b=E0Qzjf80Ib0/5yoh3ih6so2TX+XLxZvw94K91zz0iW2XKZB5YMYp/ynWT3aUfvA6//
 bahNeTw9aSi+tWMeHhZ5MgHd1a5fk0rtWXMdQgRL95/7tSLznb/49Rw5+TLg3S6G5bTs
 Fa8g2DsVKxPPkCwiamNDkzJahqz25ky/I3eks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759515288; x=1760120088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1F4db378x3BXYeP6tVhLjwh4Q8nkQsArvOAGNpPX8hM=;
 b=O7SzzoFIE9srSUaIzWdWaV3qBQkolWjb/9GiKKSgeeOFZMnyNiqM2UX1xKaClK6oef
 TlRPiqbQiklN2dmNbc/K+leUflIrHbs7d1NDA7F/ZeQ3LeZdQPapU2q6vSrqKx5Bq2gx
 E3lJaaPjDuMKGpD4Qa1Sd3+WcwIOZnvi79KKOeyKW+7At9AGnYWrbQTFV93fMyYRFk5Z
 0ULdiU1avdwE0fvd00p+e2Esb6jVoNsBag/n8NEO191N07aZCD4Z2AsGKRGIYUoPA/GP
 v6zT7cg4z/G57tTGkQVlIQWKqGZBx/reiEMkyP/mvd+NBu9WTt1OsiDsB4bM2ZUfbo/R
 3tGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMJddIo6r2+FQiXowxu89YSpte4EQ8i5q7vucUv+y5OjC4HlWhU9IUCzlj3me8+URyB98=@dpdk.org
X-Gm-Message-State: AOJu0YyEuPzFAz9A/m0TuTUUNbiKrmv/Nvnr1lLVISDTfuiQHihMK62N
 QDzBfBJIWkcRnDGsNy0f2vV6OJrdEfmh5TLg+0MLjC3jEkuUh6h8/BARVNeuG0Ywh50G6p9ozcO
 QLE1BE6joxc/KNnkYE5wE/pEItQMO0GJIzqE2uPorjA==
X-Gm-Gg: ASbGncv3t10VMefELUT6ilH8zPN2bj+LPMagRMGLdg+zb/9TXbTY76xza1YG/+ZDl1R
 wdnahQbSNGRuE42JHdPAb6hAaozVoinIXyLc2R973ciLyhEP0Ktyax3XYQt76uzs5NfhjHXY0dT
 Cj+438nkFSTJbHOmUJKBOAuodShtgiG2xs+E11OyTXt96f21RHiew/uy6zOAKh8iYmemXU9v/Ao
 0ge4/153EOfG5+E+WmfR0IWu7buwaTFRUOnXWG4wLTeaQ==
X-Google-Smtp-Source: AGHT+IFJAIJXJaNc9DMXgjb/fW3KR9xvNeFpRNZy+g1q42yzyxu1On9lpsgMEPR855CwZ582v6umrj7SwLxxEyFkPyc=
X-Received: by 2002:a05:690e:1545:10b0:635:4ed0:571e with SMTP id
 956f58d0204a3-63b99659391mr3663510d50.22.1759515288142; Fri, 03 Oct 2025
 11:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
 <20250916200458.259376-2-dmarx@iol.unh.edu>
 <175862694193.36951.18019709083217178912.luca.vizzarro@arm.com>
In-Reply-To: <175862694193.36951.18019709083217178912.luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 3 Oct 2025 14:14:37 -0400
X-Gm-Features: AS18NWDzqKf7M1d_8zGr9YYzq99g0Eq6fTkEqjkUVQeG9jTT1MLjoG8raRKBxKU
Message-ID: <CABD7UXNptEpXZjn4ym5Nd5R-K_S1u++12p+wKXt0yg6ahwjknA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: add virtio forwarding test suite
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, 
 paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> Would it be worth introducing a TextParser class that will actually
> parse the forwarding stats and present them properly to the test?

Yes I think that would be useful moving forward, I'll add one to the
next version.

<snip>
> > +        with TestPmdShell(
> > +            prefix="vhost",
> > +            no_pci=True,
> > +            memory_channels=4,
> > +            vdevs=[VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")],
> > +        ) as vhost:
> > +            with TestPmdShell(
> > +                prefix="virtio",
> > +                no_pci=True,
> > +                memory_channels=4,
> > +                vdevs=[
> > +                    VirtualDevice(
> > +                        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
> > +                    )
> > +                ],
> > +            ) as virtio:
> > +                pass
> > +            # end session and reconnect
> how could this is launched twice? Could use some explanation here.

Essentially the way it works is by launching a vhost-user testpmd
session, which waits for a virtio-user testpmd session to connect to:

EAL: Detected CPU lcores: 32
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/virtio_27338_20251003172250/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
VIRTIO_DRIVER: vhost_user_start_server(): (/tmp/vhost-net) waiting for
client connection...

Then, when the virtio-user session is launched, it connects to the
vhost-user socket /tmp/vhost-net:

VHOST_CONFIG: (/tmp/vhost-net) connected
...
VHOST_CONFIG: (/tmp/vhost-net) new device status(0x0000000f):
VHOST_CONFIG: (/tmp/vhost-net)  -RESET: 0
VHOST_CONFIG: (/tmp/vhost-net)  -ACKNOWLEDGE: 1
VHOST_CONFIG: (/tmp/vhost-net)  -DRIVER: 1
VHOST_CONFIG: (/tmp/vhost-net)  -FEATURES_OK: 1
VHOST_CONFIG: (/tmp/vhost-net)  -DRIVER_OK: 1
VHOST_CONFIG: (/tmp/vhost-net)  -DEVICE_NEED_RESET: 0
VHOST_CONFIG: (/tmp/vhost-net)  -FAILED: 0

By launching the virtio-user session through the context manager, then
closing it and starting a new session with a new context manager, the
original virtio-user session is closed, disconnecting the client. The
test case is verifying that the vhost-user socket can support multiple
sequential client connections.

> > +            with TestPmdShell(
> > +                prefix="virtio",
> > +                no_pci=True,
> > +                memory_channels=4,
> > +                vdevs=[
> > +                    VirtualDevice(
> > +                        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
> > +                    )
> Wouldn't it make more sense to store the vdev in a variable and re-use
> it?

Definitely, I'll fix that

<snip>
> > +        self.sut_node = self._ctx.sut_node
> > +        if not isinstance(self._ctx.sut_node.main_session, LinuxSession):
> surely you could just use the `self.sut_node` you've just created :D

Good catch thanks

I'll send out a new version within the next week addressing these
points. Thanks for the review!
