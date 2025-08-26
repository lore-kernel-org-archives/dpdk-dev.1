Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBD7CA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 12:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBFB3402A3;
	Tue, 26 Aug 2025 14:38:56 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 1E0224021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 14:38:55 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-70dbcf43dbfso28111306d6.3
 for <dev@dpdk.org>; Tue, 26 Aug 2025 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1756211934;
 x=1756816734; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LMggkssp1BbX8gF1vJd/h74/tpyJzP3sWGlHJZIckAM=;
 b=EKT6bPZ5fJu3AXUmTFJ2adSvBgZm/ylpZ2ljie+BzXUc8N+3jz3CkXeWOJsSwKcdE/
 tYnuYKvRaRLgbnLG40IxJzxJrb8C5I6G8o6WVxBMpYPDVefZKpnELGgOehVvn4H8QOLi
 GVoYSv2IWAVzC6htVifg7HB7fyqUPeBz8uAru/zO3Zm9cj5btQnyIbMp2x0RYUhWC3O/
 pwewm3GmrgapgOCBIpBp5yUnfyK2CEUngGhJa54kRdRt2/3gicQcH1LC/tnCJnBoROh5
 i1EZCxPUygjD4PPBWfU6Gj7lFXHkFzBX7NaGJPwsvPgOBDu9sPUaCItNDt4eKnR0jyOm
 qpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756211934; x=1756816734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMggkssp1BbX8gF1vJd/h74/tpyJzP3sWGlHJZIckAM=;
 b=uqr8CF2GvSZrSGbqvPP3YUMAyzy267ZH1kAYn0UuHqJgTAnADP3eZYFn0aQtY3D051
 8aPS+GVcybYcbKcistJZgBhyOKqsclm1Jgr3c4m+VslaScs2qcW5Xyb8Lpy1hbsaK5oa
 Ae4gUj1IwmagvrIGjMNkSe7IFPJhNfcgTuzlnGnJbZacUTVEjw8rM1fNGx5ogOgcTL0n
 38rnvigcn3/CDQ0x0we93WJOvQ3JVb4/gw306t82yOSEIiEKMif8xziINB6aKUH1b+TC
 ZUIBbg8k8XzO1QbyjP1OcVYv3a+UAUPW1Z44V0wDdHYQHPtwMJHV6iPlhdhqHPWGQvHQ
 BCYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDKt82G7FKXCnex3TodVhCJDZIH/EIOUEj8kNYKV/c/GVlkA02wBsy5bJSBnxgA9pB9wQ=@dpdk.org
X-Gm-Message-State: AOJu0YwOozH4jA8i1JERj4fi7lSl2V2w+zRocT/Wq9tIDYjyt4RLUWhj
 tbWPvWuUxLlQSWHuAIEcHCPDsQcSmvs+YWsDymvyZOtgHjSeHAEHO+rH+JoWUC4SFX4OoM08rWj
 Jq/JyOh4sCLj5azec1guEGc74fnKLk5kgNWwpb5HPmne8RQaULEDy
X-Gm-Gg: ASbGncu/cSCcVmKvQXPR59nYZZYDy/VCB5Itvrzr2wYJHUm4jbNwHahTkfuRzw0xW5+
 +tVf4FChTBOMA0wW/YusCPNG6maRnEFCSf+HoVpCdlXv/S7UO+zhOq6rNbuhUpmVCnQi7OQCGyS
 tIXi1E/1WU2DOkunhHXyO7DCUTPbftYnI6A6IZS5rsxwN65wwbZFTBVPe6ApbHBbFncmiA6KPhc
 S/UAGxVP2U6xbBDk75QKhvza1wbq6aJ5Sr9dqzgdwunumXDijGSQZZOxR9udiwdpWgkICIwDUvy
 wNrMnpFk/g==
X-Google-Smtp-Source: AGHT+IHpbbM95Re2B4FeQHrCAR/ETkEbXo4zXSL0rQXO4dJEV7i/KgNjfUh3gkdI7IB7JSUmy3Zon0SVR4p7ZmaaSAA=
X-Received: by 2002:a05:6214:21ee:b0:70d:a712:617e with SMTP id
 6a1803df08f44-70da7126252mr134388826d6.66.1756211934198; Tue, 26 Aug 2025
 05:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-4-ciara.loftus@intel.com>
 <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
 <aK1oNgPbHGeJdgUp@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x5j0hH3XweLL+=O7-GJOnGSuN8zoFURs13mgFiVh1MD3Q@mail.gmail.com>
 <aK2Rajd8rypPr7lT@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x4kcTQwBRKKvhqwjqMBQ2OAmiGtuagqSQ+6Tw74PRGRbg@mail.gmail.com>
 <aK2jBtI5qY4tnKEO@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aK2jBtI5qY4tnKEO@bricha3-mobl1.ger.corp.intel.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 26 Aug 2025 17:38:43 +0500
X-Gm-Features: Ac12FXweuypXimUWPUeJYVNxsPP-rPt5c_ZBVFsg_700xH0fYupaKpgVfltvhOA
Message-ID: <CA++2-x66ttTz6ZMSkPRgdfSo1dzzWR__T3Z1ETDGEiRZNusRQg@mail.gmail.com>
Subject: Re: [PATCH 3/4] net/ice: remove SSE vector path
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Ciara Loftus <ciara.loftus@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007d15fe063d43f4eb"
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

--0000000000007d15fe063d43f4eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:05=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

>
> Yes, AXV2 and AVX-512 code paths have far higher performance than the
> scalar paths. However, that performance comes at the cost of not supporti=
ng
> all features. What the drivers then do at initialization time, is they
> check the offloads requested by the app, and then select the highest
> performance code path that can support those requested offloads.
> The whole process should be transparent to the user - they just get the
> best performance possible for their running conditions...
>
> /Bruce
>


Got it!
Thanks for the help.

Regards,
Khadem

--0000000000007d15fe063d43f4eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div dir=3D"ltr"><br></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Aug 26, 2025 at 5:05=E2=80=AFPM Bruce Richardson &lt;<a href=
=3D"mailto:bruce.richardson@intel.com">bruce.richardson@intel.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Yes, AXV2 and AVX-512 code paths have far higher performance than the<br>
scalar paths. However, that performance comes at the cost of not supporting=
<br>
all features. What the drivers then do at initialization time, is they<br>
check the offloads requested by the app, and then select the highest<br>
performance code path that can support those requested offloads.<br>
The whole process should be transparent to the user - they just get the<br>
best performance possible for their running conditions...<br>
<br>
/Bruce<br>
</blockquote></div><div><br clear=3D"all"></div><br></div>Got it!=C2=A0<br>=
</div>Thanks for the help.=C2=A0<br><br></div>Regards,=C2=A0<br></div>Khade=
m</div>

--0000000000007d15fe063d43f4eb--
