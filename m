Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF5ECCF9E3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 14:46:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FC4C4028E;
	Thu, 30 Oct 2025 15:46:42 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id EBD604026F
 for <dev@dpdk.org>; Thu, 30 Oct 2025 15:46:41 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-63c4b41b38cso2238432a12.3
 for <dev@dpdk.org>; Thu, 30 Oct 2025 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761835601; x=1762440401; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CaUQwneDim37sQhsC15p1Er16oYgx6XY0rt8DhZ7wbQ=;
 b=HEk+KgNZFCODVQJM6Fmp6BCiMaRZAI6wc6DrVWy7JOFVKpnWSJl5caEwEW/77JHUiZ
 m55LHzN81lzN/+osGzO5yQZtVLwXqEyJKw5cqEs2do8YPmoVJ1+e7s0SbGnsV8zZxHf0
 1xR/FI1gxpWiv7Qgs7rBOJcNd3/Cu7plrOIsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761835601; x=1762440401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CaUQwneDim37sQhsC15p1Er16oYgx6XY0rt8DhZ7wbQ=;
 b=n3HOMph86z69JnLTwEu78EuxwlEzcIR1sCSOas377mS+dV1c4pcZKFbOgUJPLmSUkg
 jMZQkAxGruDxuLnK30QYzGoDr90n5L7sQRwvCX16PtzNVBbSLSNtvVKcvk+BX1Zx49Fc
 gxR1zF0Ab+d1mK39VuIGd+LVaQhkXPXcJ6eziBjjzry6C7/K93In6YcQciqL6Sc6to02
 3jS5pjGKHXwQnWAtaH1e91s0E0J8h48dfSzXdGpbvyhjHgtF8dB15sUIlqH29sD2lt4y
 xhDeT6yjbMfdBAa6H5dNN3sx3+wgOddInHQfZoOtl/XYfmg+GhEtXuzZ6XIkkIMckZSg
 dV/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ6h5lF9D9aRUfkplZ2ezFPsQKnN7k7b3vaVfAvWCEFx/z/UTq7IC51d53x+XuEM7dFWw=@dpdk.org
X-Gm-Message-State: AOJu0YwjsdKojkkCSTtlSYRFIJgdQwQfu0sKCRbs9sJCvnytVOr6zEm/
 W9K++eWiz38QeJtORKcGFDljgH5co1aVnYEwre5GZlQWdQcYZFRjlQISvRaKnmDvy+zhViyYitS
 L1xjXJgclLvvbVJEYUPpn0PEuoXjieI8PqzwiQnXe8Q==
X-Gm-Gg: ASbGncue8SLfIRin1UuUoFUq5DRHbaCAj0g3sLsjjFewMSR6VtkW8z+R6O90pdRdL+T
 MKrpycrdwSzM2hbZI3vg5xRnZEg077xf3rxvwK5C0y2Uy7DwmsTaJbkCZalQSrLaevXbPsnNJCw
 cx16TdzwxEqDsISl48HKgV0s+BjztV0XInAtsb2jbfA3bl6mPX3XRxujQTtZAqlvStRG0nNlBCr
 aZP7nGDhw+UOFqCaiRUjfJYAaXSaZThLwfSTLyOIgqli/WzyfyOtZfU0GlRn9kq1BWipZTEJfi0
 NHsmwN4qM47rj7ip+oFoReknnb35
X-Google-Smtp-Source: AGHT+IFb6UgfJTG+farz73SQg6FSEAGsEhYuNYi63PMbr0FXB3AwBMVfyP1KwlgdGjPdyK231BEGi4AmMtZAGHouVRM=
X-Received: by 2002:a05:6402:5110:b0:63c:334c:fbc8 with SMTP id
 4fb4d7f45d1cf-6404425219dmr5501456a12.17.1761835601528; Thu, 30 Oct 2025
 07:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251001231659.2297751-1-probb@iol.unh.edu>
 <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251023013049.1368129-3-probb@iol.unh.edu>
In-Reply-To: <20251023013049.1368129-3-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 30 Oct 2025 10:46:29 -0400
X-Gm-Features: AWmQ_blXnZqjT_6NYCGy8YZMD9qrpCUzjVqw2hTvJWAwbzT1PtqZMEZ8luYfmrA
Message-ID: <CABJ3N2UXFBfQzbVgcpMyz7hJgNgVDfokkW=-mHSc889rXq6=Mw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dts: add trex traffic generator to dts framework
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.ed, 
 Paul.Szczepanek@arm.com, Nicholas Pratte <npratte@iol.unh.edu>, 
 Dean Marx <dmarx@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000002e97f50642615188"
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

--0000000000002e97f50642615188
Content-Type: text/plain; charset="UTF-8"

>
>
> +
> +@dataclass(slots=True)
> +class TrexPerformanceTrafficStats(PerformanceTrafficStats, TextParser):
> +    """Data structure to store performance statistics for a given test
> run.
> +
> +    This class overrides the initialization of
> :class:`PerformanceTrafficStats`
> +    in order to set the attribute values using the TREX stats output.
> +
> +    Attributes:
> +        tx_pps: Recorded tx packets per second
> +        tx_bps: Recorded tx bytes per second
> +        rx_pps: Recorded rx packets per second
> +        rx_bps: Recorded rx bytes per second
> +        frame_size: The total length of the frame
> +    """

Nit: missing full stops on attributes.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--0000000000002e97f50642615188
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br><span style=3D"color:rgb(80,0,=
80)">+</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0=
,80)">+@dataclass(slots=3DTrue)</span><br style=3D"color:rgb(80,0,80)"><spa=
n style=3D"color:rgb(80,0,80)">+class TrexPerformanceTrafficStats(Pe</span>=
<span style=3D"color:rgb(80,0,80)">rformanceTrafficStats, TextParser):</spa=
n><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=
=A0 =C2=A0 &quot;&quot;&quot;Data structure to store performance statistics=
 for a given test run.</span><br style=3D"color:rgb(80,0,80)"><span style=
=3D"color:rgb(80,0,80)">+</span><br style=3D"color:rgb(80,0,80)"><span styl=
e=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 This class overrides the initializa=
tion of :class:`PerformanceTrafficStat</span><span style=3D"color:rgb(80,0,=
80)">s`</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,=
0,80)">+=C2=A0 =C2=A0 in order to set the attribute values using the TREX s=
tats output.</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rg=
b(80,0,80)">+</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:r=
gb(80,0,80)">+=C2=A0 =C2=A0 Attributes:</span><br style=3D"color:rgb(80,0,8=
0)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_pps:=
 Recorded tx packets per second</span><br style=3D"color:rgb(80,0,80)"><spa=
n style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_bps: Recorde=
d tx bytes per second</span><br style=3D"color:rgb(80,0,80)"><span style=3D=
"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_pps: Recorded rx packe=
ts per second</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:r=
gb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_bps: Recorded rx bytes per sec=
ond</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80=
)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size: The total length of the frame</=
span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+=
=C2=A0 =C2=A0 &quot;&quot;&quot;</span></blockquote><div>Nit: missing full =
stops on attributes.<br><br>Reviewed-by: Andrew Bailey &lt;<a href=3D"mailt=
o:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;=C2=A0</div></div></div>

--0000000000002e97f50642615188--
