Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75ABC0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 18:01:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE735409FA;
	Tue, 11 Feb 2025 19:01:05 +0100 (CET)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7929D4067A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 19:01:04 +0100 (CET)
Received: by mail-yb1-f177.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso4836052276.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739296864; x=1739901664; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yohDYG0kPu/KwBeeKB9vQIRKLLZSdC398fRYqSMGmco=;
 b=REllgc2UQNGk3Q//x7YmCJE8M2zpMX09Ks8sEFonsmNqRySqTffkTzqKo3CCY3wFcv
 Xh5qyR5Rsr0H0OGhspAgWBleXZM8MsSayDYJsl1rxZUf2H7Qrm9s4WLDPMI8US+gh/aa
 eviadv47AGqSPTkKmC+z7udSh9Rua1pB+MKq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739296864; x=1739901664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yohDYG0kPu/KwBeeKB9vQIRKLLZSdC398fRYqSMGmco=;
 b=bKiPEqhblqCUonqLL4nImnG3UTuJmOvWV2fn7Uq04NcHXsaUi2V8dmGn9fFR6cbJNS
 D5h1VLEpy3EhcnbtfZFiFyvurQaidHDeNwM8XCEyB0jc2/QpYhYOOSKIsgftDbMLUUBF
 uvyfgLLlTMYQS0x+dokZKgzREofuFVSElixO3jjJuidxryS43NJk0OQoEGgIqZlZuMS1
 tCzrpVEshI2jKePEA2caiMvXqi4rn/2w4u4yzXGAy6rp6vazEgx3ACygIILHSRo3FKNo
 52Cs30ijWhmn/8k3FGA5CsSpm3LSXEW/wWO3jT9CepdQhjlPCHK4VhWs96azoww4Ubiw
 WwAg==
X-Gm-Message-State: AOJu0YwDUN0wb2SoIMSAM0jfSrB2Skw6hCQ8pS5AZd/r9Znk5fo2icK0
 k8hSD2CJ601xMQxqNzy8PLe1BBizzmaHSo/qYkIZxTdshqB9JCSnmdWOW0feIflxNGtCJnhATsr
 XHkjEgX/8nMV214HwitlNvuVJNrMa2bpOLKH/mA==
X-Gm-Gg: ASbGncvxI6aDikwStyXRqeg0ZCfM6K0bNGWwTf7s8KsSJ6dfVUlKNMyj7BOXhKpV/xw
 MdyjnLyZc9SMRBLYBQIkxKyWmvyInjlywoWiMyKin0vMZehaeqxWgIM63HcfiapImr5ztbVAa9W
 UOAHAOjkMqQ8OygrlxxS3JwXjur1kg61Q=
X-Google-Smtp-Source: AGHT+IF4UTv2fkx2HwOgRoSzZi2RZzN0l0xWDVyUbxrBGqRP3UHCYIvD+HOVfnoakjZzJpJ6NIJayvltmRCZN3T7CsY=
X-Received: by 2002:a05:6902:2488:b0:e5a:e88e:b2d5 with SMTP id
 3f1490d57ef6-e5d9f0d08ecmr396800276.9.1739296863288; Tue, 11 Feb 2025
 10:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-2-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-2-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 11 Feb 2025 13:00:52 -0500
X-Gm-Features: AWEUYZkXlAjiiC96BXAoQuKr9zvK6MKcdFgNexGZbGk3ts1zPxgMVkZA6iuDugk
Message-ID: <CABD7UXOY+G2+ToYdCqLqxf23gm6bGmiO7cab-svR1c98t+D1Bw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] dts: add port topology configuration
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
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

On Mon, Feb 3, 2025 at 10:17=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> The current configuration makes the user re-specify the port links for
> each port in an unintuitive and repetitive way. Moreover, this design
> does not give the user to opportunity to map the port topology as
> desired.
>
> This change adds a port_topology field in the test runs, so that the
> user can use map topologies for each run as required. Moreover it
> simplies the process to link ports by defining a user friendly notation.
>
> Bugzilla ID: 1478
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
<snip>

>    system_under_test_node: "SUT 1"
>    # Traffic generator node to use for this execution environment
>    traffic_generator_node: "TG 1"
> +  port_topology:
> +    - sut.Port 0 <-> tg.Port 0  # explicit link
> +    - Port 1 <-> Port 1         # implicit link, left side is always SUT=
, right side is always TG.

Looks good to me, one small thing I think might be helpful to the user
is adding a section in the explicit link comment explaining that "sut"
and "tg" are the only options for the port_topology nodes, unlike the
port name which can be changed in the nodes.yaml file. This way the
user doesn't have to learn this through the framework, or trial and
error (especially since the ports have a name section as well.)

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
