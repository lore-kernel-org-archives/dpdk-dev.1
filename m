Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE43CEDD93
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 14:34:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C193940265;
	Tue, 18 Nov 2025 15:34:24 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 731A440150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 15:34:23 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b472842981fso696401666b.1
 for <dev@dpdk.org>; Tue, 18 Nov 2025 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763476463; x=1764081263; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IUHvLn+aiHhV+n7+grygFShpjxIUjPhOSlwSiRMeH+k=;
 b=gTH0e6HXTESZi6TtmqAM12KRUXSFaiYNoPYpxPkpAI8abfjiuJEiD+aZ6iGWKRM4na
 vaOSm+1TCG2dcUcPTNO+L2cv/DuwrKRoGKsfxIqcGL1Xnuw0lS3g93fFXTxswKm9JRCL
 CCm+81o9rakZM0bmvxD7uMto0zHPz/trHhCRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763476463; x=1764081263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUHvLn+aiHhV+n7+grygFShpjxIUjPhOSlwSiRMeH+k=;
 b=KF9Zn1cgzKepuJhQULvXnzaeO1QnmLmeBQWho5PshAInOnX/eS5PElt4Wo5OtzD2nt
 SIHtV8zsnusy/WBD4HGyjs1RywCHkeLXD22yIwLjOFhukBhAMv7bQDk1aKG1PJOGekWZ
 rZd9w7bMWNllHRxqF2vrWRvFCbioLrNfZpPHbjE+8MrtNlNnVXkTozrP4L8H9Wfq5TWm
 vDirYJsmhKjk7J96uacSALMTtbyOiDqXGJrE8BBI7LYqBPhcNce2pWaze+np/DFVWIW+
 6px7ZPzc8ij0VNd9T6dKtLsk6K3unmmA9B/lJt5K2KVr1p+zhV1Ejcwg4Yn6rtS2anph
 0FoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk4yxEUsWDnhSzrAbb6pLkQXz/Gw3zTmS2w4E833VV/o0c0xSF9AdomVlkXEQfM5jsoeY=@dpdk.org
X-Gm-Message-State: AOJu0Yyn3XvRFT1XLGYGRx3/6/yd3qtBJL/ng6Mxq/Ro1tcPMpsJw0Sz
 Be5s8KC5996MfiZYVs+97i+aFjslh0176s1BU+ffJ9WJUKhY3aZAdOUFCNJCHhhGWHtRPrlAbq2
 tikjInOj2YD/Z5crZVoAEmqT7UXn0NEChBRkfSLkFag==
X-Gm-Gg: ASbGncs44HCGKnuCWSmtiXQdN1/cayuaM5Z2JIMjDvn1tkTi3DllapfFjIeK61/oMuF
 XcifbNW/MyrN10yfe/6Wy6rZwIMuOXPJEKboczIIOtbteSAhHC1ea1/Q3uEnY1GTp2brLtmUS/h
 I2Io+KtbrTz6u752Em6U0gSvyldOo0TR7M9xmiZlvv8NwMcFQyhrzy6KT2FYluMJuAF2zcA6Aw1
 Uu83njedd2YOLuwTyzXRvoHxnR/JML6PrAahnKhRJpzk+g8Ae2U0ltroNOisKeoSgHix4TpyaKU
 nID7O8Y5LFs=
X-Google-Smtp-Source: AGHT+IFdK6zFl8OCtsPIBaUjmCnuvfi7mc8Md2GT/VlQKSgbkmKVyxmzQYii6UrmVN854bouqNqZCZvpOrE6DYWBxqs=
X-Received: by 2002:a17:907:1b0a:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b7367829bc2mr1910343666b.26.1763476463008; Tue, 18 Nov 2025
 06:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20251113232954.273454-1-probb@iol.unh.edu>
 <20251113232954.273454-2-probb@iol.unh.edu>
In-Reply-To: <20251113232954.273454-2-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 18 Nov 2025 09:34:11 -0500
X-Gm-Features: AWmQ_blpqd3XTC56a8sYR_PTjVTzv2vt4veuwII51pucQKyDgMFhTzXZxoKY2MU
Message-ID: <CABJ3N2XkRQF5sN0DRwMh5ZqCwu4rKgzt-4Hi+vZOStSn2-cd9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: fix incorrect import order for RSS testsuite
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, thomas@monjalon.net, 
 david.marchand@redhat.com
Content-Type: multipart/alternative; boundary="00000000000025d13a0643df5c2f"
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

--00000000000025d13a0643df5c2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

On Thu, Nov 13, 2025 at 6:31=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Fix the order of the imports on the RSS testsuite such that
> the dts check format script is no longer reporting issues.
>
> Fixes: 367e950f6d24 ("dts: add RSS test suite")
>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  dts/tests/TestSuite_pmd_rss.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dts/tests/TestSuite_pmd_rss.py
> b/dts/tests/TestSuite_pmd_rss.py
> index 80f6e310ae..f6adf262c3 100644
> --- a/dts/tests/TestSuite_pmd_rss.py
> +++ b/dts/tests/TestSuite_pmd_rss.py
> @@ -20,8 +20,8 @@
>      requires_link_topology,
>      requires_nic_capability,
>  )
> -from api.test import verify
>  from api.packet import send_packets_and_capture
> +from api.test import verify
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import (
> --
> 2.49.0
>
>

--00000000000025d13a0643df5c2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@i=
ol.unh.edu">abailey@iol.unh.edu</a>&gt;</div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 13=
, 2025 at 6:31=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.=
edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Fix the order of the imports on the RSS testsuite suc=
h that<br>
the dts check format script is no longer reporting issues.<br>
<br>
Fixes: 367e950f6d24 (&quot;dts: add RSS test suite&quot;)<br>
<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/tests/TestSuite_pmd_rss.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_pmd_rss.p=
y<br>
index 80f6e310ae..f6adf262c3 100644<br>
--- a/dts/tests/TestSuite_pmd_rss.py<br>
+++ b/dts/tests/TestSuite_pmd_rss.py<br>
@@ -20,8 +20,8 @@<br>
=C2=A0 =C2=A0 =C2=A0requires_link_topology,<br>
=C2=A0 =C2=A0 =C2=A0requires_nic_capability,<br>
=C2=A0)<br>
-from api.test import verify<br>
=C2=A0from api.packet import send_packets_and_capture<br>
+from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import (<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--00000000000025d13a0643df5c2f--
