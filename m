Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34731C3ABDA
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 20:12:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 221E2402DC;
	Wed, 14 May 2025 22:12:45 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 48C43402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 22:12:43 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-30c5a5839e3so47686a91.1
 for <dev@dpdk.org>; Wed, 14 May 2025 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747253562; x=1747858362; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o89LufUwVVh3GLIRSwJgsFxDvsFFktmUchmxJs+EIDE=;
 b=C4JZF7wWw9PM8buFVwY6iJ0Yke43j6ytzqILx/5R+4djNyLb/o3609pYSrHkXt2oxo
 IB4qva3rBRPh3gszlTRVgQof+zXjPXtmE+M8mI5JLUTh7nGighqc15TS5WYkkffthdrO
 Z6yfPTywWKQyuHnsAR877RzEE5l9lnfrj8w4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747253562; x=1747858362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o89LufUwVVh3GLIRSwJgsFxDvsFFktmUchmxJs+EIDE=;
 b=ZkkN+e/Thw2vnnPFY8WkaxcpbCr8Giu3pyNM45JO8tL+YnFuSPDGp7y/x+CL7w0fNH
 9Q6x6GLefctjQnsHblLF8g6orvKZ6nyqOfMDSI+8YMM5t8hEWQ9WVkTjsVs/hH4CxffR
 nCaHdAyoyxW2KVyc8aIXgX6jXTDIutgYJkM03kQuaX7LEQ6J5D6LltyouyRAUkyP9/cP
 TX930M9dIQx9VRVOc069wdLlOesLo51irFmIcT6v6LO0i6dF/wmSrugfMkSSQq98+ZUg
 vCIqcSP1np6stRRPrHSG6G6g5SJc1ZJS7VhwEbDJ1rNvJVxF1lm59pgWl/QlRD7xw7kv
 WxLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNNI5Aa0IJNC8dlyfD2aS+ZIVvtjQ/urediKQ0KjirjJKTR5t5cYfzSSnTWMe1W0d0ZGE=@dpdk.org
X-Gm-Message-State: AOJu0YyFGFzR6gHZ5+eoLUnAWM3fxvaAB83K6cXTP/QxXFrGsyyvUVCK
 zvpKUXRbwAzhGeHqU+xccXm7lzSVd3uF/D/SE3iqmfCQtxdn29wXSa9zRSasg0CrbPvvf5w8El4
 fS24O+NbpMkn9Xjt1tek7rBQIzYhw5uCAVOdhrA==
X-Gm-Gg: ASbGncvSv/8Ng+88wVpOv+YMvpRkdLkDYCCHcG2O14Ys/n/wzhkyHZ2sGyvWdmocIOf
 +utrxzLfd6MBEhwFbE1N+v1jtk8hY9qYZnGLpFwYe7wCbVzffug182m/l3PZwyv7s1MAAHrbC5t
 HOGAqKkylI6BW8vzJkpa0o28rpBx/IaL58XtzHj0o5MyWExvlJ
X-Google-Smtp-Source: AGHT+IFkIcLewTlLeHAMYHIOEXv11q2fK0dY9IIqgrfQvNrN/mfkIMz90/FAn03x2TK6Jl9p3LVcyz52fV3QVlVUCRs=
X-Received: by 2002:a17:90b:3b43:b0:30c:29ca:fd95 with SMTP id
 98e67ed59e1d1-30e2e64d7admr2522341a91.8.1747253562335; Wed, 14 May 2025
 13:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
 <20250306214747.579340-2-dmarx@iol.unh.edu>
In-Reply-To: <20250306214747.579340-2-dmarx@iol.unh.edu>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Wed, 14 May 2025 16:12:31 -0400
X-Gm-Features: AX0GCFs-4x_dCFR4OJQ4ZnZqJ0s-olI4Mv4yOKCHI7QydxwYyQEw9DugmkIELBM
Message-ID: <CAKXZ7ehpNCXYwRxW8kVy0QiutqNtr-jQ13aL7rretPBETga2KQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dts: add layer 4 port field to verbose parser
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

Makes sense to me!

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Thu, Mar 6, 2025 at 4:47=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote:
>
> Add a field to the TestPmdVerbosePacket text parser
> that stores destination port values for TCP/UDP packets.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/framework/remote_session/testpmd_shell.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framewor=
k/remote_session/testpmd_shell.py
> index 1f291fcb68..f99c24bb04 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -1278,6 +1278,11 @@ class TestPmdVerbosePacket(TextParser):
>      l3_len: int | None =3D field(default=3DNone, metadata=3DTextParser.f=
ind_int(r"l3_len=3D(\d+)"))
>      #:
>      l4_len: int | None =3D field(default=3DNone, metadata=3DTextParser.f=
ind_int(r"l4_len=3D(\d+)"))
> +    #:
> +    l4_dport: int | None =3D field(
> +        default=3DNone,
> +        metadata=3DTextParser.find_int(r"(?:Destination TCP port=3D|Dest=
ination UDP port=3D)(\d+)"),
> +    )
>
>
>  class RxOffloadCapability(Flag):
> --
> 2.48.1
>
