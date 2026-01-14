Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E686D3CC87
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:41:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E91740E42;
	Wed, 14 Jan 2026 23:41:12 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 8F9124003C
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:41:10 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-11f3a10dcbbso288169c88.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768430469; x=1769035269; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7HTKz/oXGaUJQW8KgPTsVsPtA879eQwTNmyg7nLxgik=;
 b=Bbe4c0XPwALRYNhBTgnXx8rEpjijbL40gTp80BrSkHTodQZMoqywz9KWSxLx06KIHX
 Odq1hE90Sr4IPcTlD3WLHZZhxPha7d/wNRzsyJJjbBdvDVlBSp7P9kuH4BKjGoXhYjrw
 2xLTPL7ig4vbfjt0DIL31tmjWUx/RiCtNs7UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768430469; x=1769035269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HTKz/oXGaUJQW8KgPTsVsPtA879eQwTNmyg7nLxgik=;
 b=LQlkSNfUvbieABjJAapTh27ICu0IrMKaSzWLeabWq6oz3hFxO5SHZpL0rLv8bYiAp6
 BLm9luBGu46U4Y+HincOn6ASOXMYTrKj8ffPFDD7c3B1pY1VRmOzZxok5RcAG5Vp3eHw
 bcmUggzbJFb3Fcf02BalEk2FSnvlvkQjTxA81ikYhL/JnT4lh7rztvYADL95OID/6w7u
 HFjw1oVuUWCUSIgPfyw4vZ3bTTDqwKgEk+bUYW0xXZi3xa/7dFOd8cct/++ju3UySTI4
 +9Ovuz2T8SMiKqZamZz67Gwbba9dLgGhABqy/1j7zJ+KBcWPu1BC5hBQAo9ihu3zH8Ng
 VHPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXIGnA1JrgyhtOzfJkDNVOixj2nf1axYQdxu3YqeBzE/FAWRCgIxjfBzyMsjuyyUUkAIM=@dpdk.org
X-Gm-Message-State: AOJu0YwurAr8UXXdx8v8/cKpdN+bOpwnHWP4rxzpTBIPlR7ZjDU6ID3t
 zmzMzPw6RQOXzk0u6WgmmpggUy/RJQLWMSp1vnSHeVj44KZqkuASOm00Rx++hJrKCdGbHYAd4YQ
 xunNuHkCKbeUUhNRknSjk9l9T0RwFNBYaYNHMixckrA==
X-Gm-Gg: AY/fxX7Vu+MmrVzuj40tdXBDxhxjy+IYRNJFSux227c5LeAzsnf03026R5eiFN+pR91
 FCjQawgtK7gbCICWaF5j76LYB84Uf6lykTyMK97yyPCnF2fW2i407cs/V155KxZl8K8luggYH8b
 u6u9SvAJr7p2g9mEggvQTA1eoYpVX8dihaSgVsOqmwuopyiKOE8VNMQA4XxWEHoGxGhrPoVHV8R
 Tn74xmptHcM9By/EIKJQrtAOTFYOQEh/sWJWG1etItEj3V57odlVX6I01p/bvsEjSbARsEHOPmx
 wxNTTNy0TZt2E9mA15V0P0Iyu6Y6xrTLLDr97COLyK6kdZIGovc7bGcoR9o3
X-Received: by 2002:a05:7022:1a84:b0:11c:b3ae:c9f1 with SMTP id
 a92af1059eb24-12336a2312dmr4990042c88.1.1768430469531; Wed, 14 Jan 2026
 14:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20251212210142.669766-1-abailey@iol.unh.edu>
 <20251215214049.694604-1-abailey@iol.unh.edu>
In-Reply-To: <20251215214049.694604-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 14 Jan 2026 17:38:57 -0500
X-Gm-Features: AZwV_Qj_-9IlKuo1S0MCJUksAoZkVqGvll9toBy2tfy6qvcvuMDpczncI59AY9M
Message-ID: <CAJvnSUBjbRZeS-Vy4uuboK_XkGFpuNb_QdsUmBCnSqeBj8vDUg@mail.gmail.com>
Subject: Re: [PATCH v3] dts: show missing NIC capabilities in DTS logs
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, paul.szczepanek@arm.com, dmarx@iol.unh.edu, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f2594c064860cdc0"
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

--000000000000f2594c064860cdc0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

On Mon, Dec 15, 2025 at 4:40=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> When a test was skipped due to a missing NIC capability, the logs should
> print the name of the missing capability. This has since changed to show
> only the integer representation of the missing capability. This patch
> restores the previous behavior of printing the name of the missing
> capability to the user.
>
> Bugzilla ID: 1803
> Fixes: eba657ae3c3c ("dts: move testpmd module from framework to API
> directory")
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/api/capabilities.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
> index 243759668f..2d0cd65854 100644
> --- a/dts/api/capabilities.py
> +++ b/dts/api/capabilities.py
> @@ -219,6 +219,10 @@ class NicCapability(IntEnum):
>      PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()
>      QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()
>
> +    def __str__(self):
> +        """Override the default string representation to return the name
> of the capability."""
> +        return self.name
> +
>
>  def requires_link_topology(
>      link_topology: LinkTopology,
> --
> 2.50.1
>
>

--000000000000f2594c064860cdc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.=
unh.edu">probb@iol.unh.edu</a>&gt;</div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 15, 202=
5 at 4:40=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.ed=
u">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">When a test was skipped due to a missing NIC capabili=
ty, the logs should<br>
print the name of the missing capability. This has since changed to show<br=
>
only the integer representation of the missing capability. This patch<br>
restores the previous behavior of printing the name of the missing<br>
capability to the user.<br>
<br>
Bugzilla ID: 1803<br>
Fixes: eba657ae3c3c (&quot;dts: move testpmd module from framework to API<b=
r>
directory&quot;)<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/capabilities.py | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py<br>
index 243759668f..2d0cd65854 100644<br>
--- a/dts/api/capabilities.py<br>
+++ b/dts/api/capabilities.py<br>
@@ -219,6 +219,10 @@ class NicCapability(IntEnum):<br>
=C2=A0 =C2=A0 =C2=A0PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()<br>
<br>
+=C2=A0 =C2=A0 def __str__(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Override the default string =
representation to return the name of the capability.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return <a href=3D"http://self.name" rel=3D"nor=
eferrer" target=3D"_blank">self.name</a><br>
+<br>
<br>
=C2=A0def requires_link_topology(<br>
=C2=A0 =C2=A0 =C2=A0link_topology: LinkTopology,<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--000000000000f2594c064860cdc0--
