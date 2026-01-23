Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE6BD77880
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB9EC40269;
	Fri, 23 Jan 2026 17:54:57 +0100 (CET)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTP id C650140269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:54:56 +0100 (CET)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7942b9663f8so22005447b3.2
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:54:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769187296; cv=none;
 d=google.com; s=arc-20240605;
 b=PF6Kz8wCGm7NSjwck0fcfnX8onBB/zCKnnuyR4XgG4ZkGtr2TzbiG8obRvKpZ6Nd8n
 ITL1xXR3zfsVP3jqxx1dHmrBcKzFkvqE+4Ahh2EnEYL4dlie3cpVUGuCmispWt8WEnjz
 hY5WJ44iqkpZ707PAN753eKpx1ByvLAKbHo3tn6byAsDxZKG4XNzZw0s7ofGPfduW+db
 ivCKcN8uJ1kYI6iD2ydF7Z7FGALUK8mK/vexJ3Rcorb21UzTQb7nx7k9tcEGw9cSoU0u
 VCM2DwMQAogBidD3+wnjlqin1w2lSy3s7yQMUTp8k2hQOshG4dJceq/LqNWguiAj0io8
 Se/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9UVmwB4khMlDMXB/+Iq0EV1OX67jZxHlCFkgc2wveYY=;
 fh=tfWD03yGBRkFh7m9/QccMid+Ut1tGB4CvK7ChXNBNSQ=;
 b=lNDZXlNThnNOT1bO3U1bHFY/YN5hFCW0yPZOzq5vaDvUhpS0OrXeuuB/u+25gc3tlH
 2uWjq1EpxG3mXh3suMwWTRWqroIlHOAH1O0Ka3Gkehh/YsIDz2n4e1pR3ZfLJMzGzWCw
 uMWOuQ104N06t4VhnIr8FDz+sOUbJZncmn9dGprcEAFqWRYA2b+d5arw54ItOV8LAN4j
 4rDi3F3eHRW7FaLWB6r2qZIphgEdY7GGsvMccQjuCujJBe/dLzwJveh4IOQwQri7a0rA
 oG+WBNCi/+t/zCc7GTVgCuqRtT+Wb4SwaI7m5dyrXuSpqwJC15qQxNpPY7vZmwC4InC2
 tEdQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769187296; x=1769792096; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UVmwB4khMlDMXB/+Iq0EV1OX67jZxHlCFkgc2wveYY=;
 b=WbMfg8BRPKwjMyXkxCaRWukGf9ILQ4wpK18lJnPKi7MT+wqENHoP9Rv4qHK2u30Tr3
 ZmXvgpNtae+Cbx2N4lXjHYi8xWjUzFwjy8YrjvnbQxqr8L8I3b01coHl9k0lLs6+dB+3
 hHYAc7fC1Ge9++1Esj2PKk0aItLK8oBDWQ2io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769187296; x=1769792096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9UVmwB4khMlDMXB/+Iq0EV1OX67jZxHlCFkgc2wveYY=;
 b=lKWxwZkuCzEHFfiLBI7jFFMt77x632CJu9NmiivyoRcDixRzTK/h22GIdYcU9S/HA4
 bKoPciVeWArRC9w/7ETB4iUGu2XUsfnmDzVBLG26UEQ/WKGSsLK2674Ze9wHkOwgf0st
 5vaEAvvAazxGA9y9C1UVl2lStkPhNnC5OIx6SpYo258ICV5WYXkgM3p6WTaPOL+4HU7B
 eJ0W54Y1lWIjBiirIZsdTOInw08le1poSLaS9mNtA+t4HPASdG9tYQjifqKHFOM7Fa3I
 jIbZOtvN3sKeH5opYW52hmyNB6p431NjigrHOXfgLuH9LzEJsaZ9+QXpUoJNiIIfe0jy
 nUfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq1epfx9nFgD60otSszRIj9/JARTqFNqY9HwPBgUVq2ZhOEAEJo9ul1DbIOwK23h5OrCg=@dpdk.org
X-Gm-Message-State: AOJu0Yx9wJX6/HJVZ9d8nKhPkmhCmbgfvwOQ5BdvoSJYkD58PIWdwMap
 mpzrPcuqqyvLJ6X65yDfzWIdzP6+hvEtxlJXZo3hHxtGG14HmtcRG/60R/bUPXqv0svJJPL9JSj
 pwGX/KBhTIY0zccxdIJ4yPelbmEv6uT0kbyJ/KSiQgg==
X-Gm-Gg: AZuq6aJe+pSUO1v9A/XorZ6aEGrppcP9c9RccXAC81Gqq/mvk3Jqy+0ro2QLJ3JlyOm
 eabFlFh6Aicc8n0CSoVXg8kKwXJ7fbdGiIl5AywcNcUzX9KoVXAr2fJtZwskGgDh+nVrvVtm7Av
 MLfXa0VASmhN8pFGK2PN1W8dMUV2eWujHr/WMGNf1UQunpERg9Cw45ABu1iE3UQNYvUt33FUy6w
 tIGpWUqmProF5gVFcGGV06e7DTX8ZayvWUYFxol4jZ0QKeyuLtTIweSQlt7mJygFGcVBF76JtMP
 Vn4S1Z9kmVTHQc5mjnsm
X-Received: by 2002:a05:690c:10c:b0:78c:64ef:9485 with SMTP id
 00721157ae682-79439a713cdmr29878897b3.70.1769187295958; Fri, 23 Jan 2026
 08:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260122214424.322422-5-abailey@iol.unh.edu>
In-Reply-To: <20260122214424.322422-5-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 23 Jan 2026 11:54:45 -0500
X-Gm-Features: AZwV_QjjehCyQ6iT81WZhA26_WL0dqSQ55dJwOUA8REPRnVPHgcxATPac7qjckM
Message-ID: <CABD7UXPc62H-P9gx=yB26KG0g5JoEecEF_QoWpXxA-awQ2=-6Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] dts: add crypto test decorator
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com
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

On Thu, Jan 22, 2026 at 4:44=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> Currently, a test case is decorated to signify whether to use Scapy or
> TREX. This change allows test suites that do not use a traffic generator
> to avoid the overhead of initializing either one.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
<snip>
> -        if self._lshw_net_info:
> -            del self._lshw_net_info
> +        del self._lshw_net_info

This patch looks good from a functional perspective but I think there
are some git issues, for example the above snippet is just reversing a
change made in patch 2. Additionally the following change:

> -    def load_vfio(self, pf_port: Port) -> None:
> -        """Overrides :meth:'~os_session.OSSession,load_vfio`."""
> -        cmd_result =3D self.send_command(f"lspci -nn -s {pf_port.pci}")
> -        device =3D re.search(r":([0-9a-fA-F]{4})\]", cmd_result.stdout)
> -        if device and device.group(1) in ["37c8", "0435", "19e2"]:
> -            self.send_command(
> -                "modprobe -r vfio_iommu_type1; modprobe -r vfio_pci",
> -                privileged=3DTrue,
> -            )
> -            self.send_command(
> -                "modprobe -r vfio_virqfd; modprobe -r vfio",
> -                privileged=3DTrue,
> -            )
> -            self.send_command(
> -                "modprobe vfio-pci disable_denylist=3D1 enable_sriov=3D1=
", privileged=3DTrue
> -            )
> -            self.send_command(
> -                "echo 1 | tee /sys/module/vfio/parameters/enable_unsafe_=
noiommu_mode",
> -                privileged=3DTrue,
> -            )
> -        else:
> -            self.send_command("modprobe vfio-pci")
> -        self.refresh_lshw()

Is removed in this patch, but then added again in the next patch. The
same happens with the load_vfio method below.

> -    @abstractmethod
> -    def load_vfio(self, pf_port: Port) -> None:
> -        """Load the vfio module according to the device type of the give=
n port."""

I'm not sure if this matters all that much since the series applies
with no issues, just figured I'd point it out anyways.

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
