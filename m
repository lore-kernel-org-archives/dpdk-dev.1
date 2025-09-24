Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E5CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 20:52:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05BA5409FA;
	Wed, 24 Sep 2025 22:52:04 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1E0CD4064A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:52:02 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-271067d66fbso2605525ad.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758747121; x=1759351921; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nShOuG+1MXhi214+HW8hyUGRPnpnblRTvWGOnoqPnlc=;
 b=LUllkAkO6S6d97bgrU+4byLLYZLgnTX8bMb6i9KfOFxVqyly39hESDmg384gnFpP9l
 jtVGgZYNU4gYlgJgcn+pR8DbIzdUiCfsUKyuIsvcPpoTZe6EAZyUpT872psUX79zIzEY
 mu5cS4IyV+mAkt3S9dfzNSgNJ58SOsA/D0GqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758747121; x=1759351921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nShOuG+1MXhi214+HW8hyUGRPnpnblRTvWGOnoqPnlc=;
 b=spTE1SdHRNMXsQ4qh4WX7icUUWJLp9eugylUt2dBbCMhjtqS5Ba+ZzGr5/piH6382d
 lAtAFl3Cy3MNYFHo82fGgqn7S5YkQI8HZeTRQ+3Aeshm2gVNIlpl5vrDdnACVSDHut7v
 7RtFwt59G2Qend30U+HnvuaHJL/Jajh9tkngaP918JiAMY0JAEmrTUG3DrUUtROLzHIp
 xnhfVeScuAXEhNb6Xq8CoXWveQVFDvQOrmaRYBbs320WdnNRkbH1e2VZKl7ilBQDzhx0
 YMTcx5jxELgTKyQKgIr2BOdoYcuJR3MSU0Jv+cw31hD1dIHCq/Vmsq2YBjiVi2rRUj8A
 GjVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcmijg5yTbv0IN8oVnm0sdygRpJl8ss+iG5CFpkxC++Ea/ZkuBpglr2ZpGoN+Ndxxrx3g=@dpdk.org
X-Gm-Message-State: AOJu0Yxq+BX3HgaKbZcBlIqrauahbA5heT9jNAXn+kNdJu4AFnTAYAse
 TZWdaGxb9A9vVhvYmHEtHtDK4cqG7S61mkH0e/EfLtsCUWtvlhLALr5Apn6Vr1PIOj0KC+PEd1W
 ZlJ0WdnFb02vONTjlB/XWlB1lZrSjyueS7qjGLw993M+s4A9HAeq2
X-Gm-Gg: ASbGncsOSNxFS5mIbpbS/kidjClH2mkgt6SwC9XAUdIIAWUEj2K3qGbd4nWH1QREqqP
 jD6O83Pe9rLMqwEPqpyTvnIKs91c2q4uhUDtZh4X5vYwk3wtczRBTcdlK/OfGoFFAiXZ1vXS3Dd
 H4Csgd1ISgd55o1H9FncN1GY8k1nTyIbolHEsR0rmdnhmc+Of5OBx5WtJiD64FGGxTukOT7OQJf
 RzO3WL+uwGAJNWZXvuJkMSXk1eekTkP9wnd9C9Na+1zOGfaqSc=
X-Google-Smtp-Source: AGHT+IH3g91AcUqaA5wP+/gEdJWw9+LmHDk2YTecL43CQw8aXFFe4L70tDmWCeau95ugIq58r5LKHsNGdz0Xuv4Tu+E=
X-Received: by 2002:a17:903:298f:b0:269:91b2:e9d6 with SMTP id
 d9443c01a7336-27ed4a6f290mr10320765ad.46.1758747121303; Wed, 24 Sep 2025
 13:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250924164725.168773-1-abailey@iol.unh.edu>
 <20250924164725.168773-3-abailey@iol.unh.edu>
In-Reply-To: <20250924164725.168773-3-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 24 Sep 2025 16:51:39 -0400
X-Gm-Features: AS18NWC-3iDnqvDTkT388_NZIM_byOHVmcFVHWFrTVKuODzT1Jy08wupMtboR1Y
Message-ID: <CAJvnSUC51q2nZnZp+SZwoD=e-7qyGPMwvF6OWgXg2mMudLtkxw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dts: add TX offload capabilities to NIC
 capabilities
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 ivan.malov@arknetworks.am, Jeremy Spewock <jspewock@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000006a549c063f9239ee"
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

--0000000000006a549c063f9239ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 12:47=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu=
> wrote:

> Currently, there is no support for tracking tx_offload capabilities and
> there is no separation between port capabilities and queue
> capabilities. This is an issue if a test case requires a tx_offload
> capability or if a test case requires that a card supports a capability
> on a queue. This causes test cases with said requirements to not be
> skipped when appropriate. Add tx_offload capabilities and distinguish
> capabilities between ports and queues.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
>
> -        Args:
> -            line: The line to parse.
> +@dataclass
> +class OffloadCapabilities(TextParser):
> +    """The result of testpmd's ``show port <port_id> tx_offload
> capabilities`` command.
>

tx_offload or rx_offload, right?

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000006a549c063f9239ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 24,=
 2025 at 12:47=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.u=
nh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Currently, there is no support for tracking tx_o=
ffload capabilities and<br>
there is no separation between port capabilities and queue<br>
capabilities. This is an issue if a test case requires a tx_offload<br>
capability or if a test case requires that a card supports a capability<br>
on a queue. This causes test cases with said requirements to not be<br>
skipped when appropriate. Add tx_offload capabilities and distinguish<br>
capabilities between ports and queues.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
Signed-off-by: Jeremy Spewock &lt;<a href=3D"mailto:jspewock@iol.unh.edu" t=
arget=3D"_blank">jspewock@iol.unh.edu</a>&gt;<br><br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line: The line to parse.<br>
+@dataclass<br>
+class OffloadCapabilities(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;The result of testpmd&#39;s ``show port &l=
t;port_id&gt; tx_offload capabilities`` command.<br></blockquote><div><br><=
/div><div>tx_offload or rx_offload, right?</div><div>=C2=A0</div><div>Revie=
wed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh=
.edu</a>&gt;=C2=A0</div></div></div>

--0000000000006a549c063f9239ee--
