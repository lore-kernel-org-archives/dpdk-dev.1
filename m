Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A804C9EC98
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 15:57:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AC8340156;
	Mon, 12 Jan 2026 16:57:12 +0100 (CET)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54]) by mails.dpdk.org (Postfix) with ESMTP id 97A5D40041
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:57:10 +0100 (CET)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-59b77f2e43aso4059502e87.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 07:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768233429; x=1768838229; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kPEMLLDcvPNhk0SUtlwh2rkc5BtepANhaFW0DWsAVrg=;
 b=GmN4fMdHvyII7fNPqsoR3eTVHsVKYsKzWpCSNNvnZSLaaMQkKNrhLLbrtc8+PxGGX/
 H2G/J1GUhfJFT7fu2F1KUpyUxnkwL2Xr4d1z8o5NObqHxMU9qOq5f/ItCJ+3ipqtIChQ
 NkGDu9QtrXx3ZwDUPnMZvr9iyBgXyvJOBpfl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768233429; x=1768838229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPEMLLDcvPNhk0SUtlwh2rkc5BtepANhaFW0DWsAVrg=;
 b=Ji30FZwpTlx/dGeJfjq0rkXEW/nBcdsTB/9pt/144wyTrAG5+H/mHhdXxu7FaXIjjf
 1uFaiMU7hJUD8q6Gxrhvx9JSmw0BMIKpcWgiLTIv76ro0XRnXtZ0ak/lE/j/A9Oeflq9
 Jjg4vbiRmR5yYuOtubJSghDg4ivLJsnjq8UcW++lPrjMI6cr2Y8N3X4VqS2qjHsaP3YQ
 I5f2tYnjjk+MpABoG8vcsT3aZS0ih6XBYRLFXlJcYt6a4zANspW24oFEdAIWQKqUxrZt
 ml+5UNdiHcdH9R+LKQP8ApOAF5OYrmxHgFgjtRg+K2a9/hw8gnjqbYAbtryAf3TBwyQh
 TanQ==
X-Gm-Message-State: AOJu0YzrTTGyygyptxWa+SVuAUwqLxEUGXXa60bS3z8CGmLGIFv4n2fq
 SFy2R7mluRcZoms8EIF7mxSswqy6z+GPXEnxe+lEq1t6EzG0CLFG0ZeFEvbpOOlGh0+NSk4/N6c
 g8Ut2GavOEAXGXbCjmHb5A1SXtYvNV4ltSItk82pb6g==
X-Gm-Gg: AY/fxX6+8AF1MVnc261rJU3MBETZ3B56S9eYoloF6QY8OHNhfIZC3aQqcDtOnwWvLn2
 qhtGmUXUpQrjpK4Be+qqqzuBrFGkBR+5KawABA6hXOW3vMWoUP8rcCU2l0Y+WBeBPME0vg8QFqc
 TDbFroQT5o5yqn67qG0wEryGungR72PoHW1QXAn8m2ijTB7G0atp39nC3C5+XlU3h3HBLkNdmWp
 zisR2qTN5SbzAF9UcNCtnigrJTe/WnSEqsKkx+QA8jjTsCHmelc/WAxFpYCFVnm9aMFl6WUftJi
 mMUpsmecGxtwg5CtBrZ2H+BcdkfnmeMUtS84INU=
X-Google-Smtp-Source: AGHT+IGPRY2Bbl6jdDL1BCgp/4dQeqDhZozqEI7w5wcGk8iHS4i32cxQ5OJXuDHiYrRTTrKYpes0o42Uo6hdzLwG1B4=
X-Received: by 2002:a05:6512:33cb:b0:59b:73b9:1f49 with SMTP id
 2adb3069b0e04-59b73b921e7mr5640832e87.26.1768233429253; Mon, 12 Jan 2026
 07:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20260107215129.1329960-2-rjarry@redhat.com>
 <20260108105036.1341037-2-rjarry@redhat.com>
In-Reply-To: <20260108105036.1341037-2-rjarry@redhat.com>
From: Matthew Labrecque <mlabrecque@iol.unh.edu>
Date: Mon, 12 Jan 2026 10:56:58 -0500
X-Gm-Features: AZwV_Qh8Req83rIcbvIvKwetdrXA5j9WUNC9SH_QX2B-FhEwvW-m5Fb1CY2M13w
Message-ID: <CANGnzyBfmEy3Vccqywvzota=R2CNv1h+cgvfiawq5+qJqA4Rsg@mail.gmail.com>
Subject: Re: [PATCH dpdk v2] telemetry: fix adding dicts in container arrays
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Ciara Power <ciara.power@intel.com>, stable@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006e4f32064832ed11"
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

--0000000000006e4f32064832ed11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Robin, my name is Mathew Labrecque and I work over at the UNH
InterOperability Laboratory on the Open-Source Team.

I wanted to email you regarding the ARM cross-compile tests that failed on
the patch. While it says the tests were run on Ubuntu 20.04, these tests
were actually performed on Ubuntu 24.04. This was due to an internal error
where we hadn't properly updated the labels for the tests.

Cheers,
Matthew

On Thu, Jan 8, 2026 at 5:50=E2=80=AFAM Robin Jarry <rjarry@redhat.com> wrot=
e:

> Currently, adding TEL_DICT containers in TEL_ARRAY_CONTAINER containers
> is not supported by rte_tel_data_add_array_container. It wrongfully
> returns -EINVAL where it should allow it.
>
> This is supported by the JSON formatter.
>
> Allow the same value types than rte_tel_data_add_dict_container().
>
> Add test case to verify it works as expected.
>
> Fixes: c933bb5177ca ("telemetry: support array values in data object")
> Cc: stable@dpdk.org
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>
> Notes:
>     v2: added test case
>
>  app/test/test_telemetry_data.c | 21 +++++++++++++++++++++
>  lib/telemetry/telemetry_data.c |  6 +++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/app/test/test_telemetry_data.c
> b/app/test/test_telemetry_data.c
> index 59898ff5e983..e904b5a7f210 100644
> --- a/app/test/test_telemetry_data.c
> +++ b/app/test/test_telemetry_data.c
> @@ -405,6 +405,26 @@ test_array_with_array_uint_hex_values_nopadding(void=
)
>         return CHECK_OUTPUT("[[\"0x888\"],[\"0x8888\"]]");
>  }
>
> +static int
> +test_array_with_dict_values(void)
> +{
> +       rte_tel_data_start_array(&response_data, RTE_TEL_CONTAINER);
> +
> +       struct rte_tel_data *d1 =3D rte_tel_data_alloc();
> +       rte_tel_data_start_dict(d1);
> +       rte_tel_data_add_dict_string(d1, "name", "foo");
> +       rte_tel_data_add_dict_uint(d1, "size", 42);
> +       rte_tel_data_add_array_container(&response_data, d1, 0);
> +
> +       struct rte_tel_data *d2 =3D rte_tel_data_alloc();
> +       rte_tel_data_start_dict(d2);
> +       rte_tel_data_add_dict_string(d2, "name", "bar");
> +       rte_tel_data_add_dict_uint(d2, "size", 666);
> +       rte_tel_data_add_array_container(&response_data, d2, 0);
> +
> +       return
> CHECK_OUTPUT("[{\"name\":\"foo\",\"size\":42},{\"name\":\"bar\",\"size\":=
666}]");
> +}
> +
>  static int
>  test_case_array_u64(void)
>  {
> @@ -597,6 +617,7 @@ telemetry_data_autotest(void)
>                         test_array_with_array_string_values,
>                         test_array_with_array_uint_hex_values_padding,
>                         test_array_with_array_uint_hex_values_nopadding,
> +                       test_array_with_dict_values,
>                         test_string_char_escaping,
>                         test_array_char_escaping,
>                         test_dict_char_escaping,
> diff --git a/lib/telemetry/telemetry_data.c
> b/lib/telemetry/telemetry_data.c
> index 0354a0654804..0a006559ab42 100644
> --- a/lib/telemetry/telemetry_data.c
> +++ b/lib/telemetry/telemetry_data.c
> @@ -96,10 +96,10 @@ int
>  rte_tel_data_add_array_container(struct rte_tel_data *d,
>                 struct rte_tel_data *val, int keep)
>  {
> -       if (d->type !=3D TEL_ARRAY_CONTAINER ||
> -                       (val->type !=3D TEL_ARRAY_UINT
> +       if (d->type !=3D TEL_ARRAY_CONTAINER || (val->type !=3D TEL_ARRAY=
_UINT
>                         && val->type !=3D TEL_ARRAY_INT
> -                       && val->type !=3D TEL_ARRAY_STRING))
> +                       && val->type !=3D TEL_ARRAY_STRING
> +                       && val->type !=3D TEL_DICT))
>                 return -EINVAL;
>         if (d->data_len >=3D RTE_TEL_MAX_ARRAY_ENTRIES)
>                 return -ENOSPC;
> --
> 2.52.0
>
>

--=20
Matthew Labrecque
Technical Intern, Open Source Team

UNH Interoperability Labs

21 Madbury Rd, Suite 100, Durham, NH 03824

www.iol.unh.edu

--0000000000006e4f32064832ed11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hey Robin, my name is Mathew Labrecque an=
d I work over at the UNH InterOperability Laboratory on the Open-Source Tea=
m.<div><br></div><div>I wanted to email you regarding the ARM cross-compile=
 tests=C2=A0that failed on the patch. While it says the=C2=A0tests were run=
 on Ubuntu 20.04, these tests were actually performed on Ubuntu 24.04. This=
 was due to an internal error where we hadn&#39;t properly updated the labe=
ls for the tests.</div><div><br></div><div>Cheers,</div><div>Matthew</div><=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jan 8, 2026 at 5:50=E2=80=AFAM Robin Jarry &lt=
;<a href=3D"mailto:rjarry@redhat.com">rjarry@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Currently, adding TE=
L_DICT containers in TEL_ARRAY_CONTAINER containers<br>
is not supported by rte_tel_data_add_array_container. It wrongfully<br>
returns -EINVAL where it should allow it.<br>
<br>
This is supported by the JSON formatter.<br>
<br>
Allow the same value types than rte_tel_data_add_dict_container().<br>
<br>
Add test case to verify it works as expected.<br>
<br>
Fixes: c933bb5177ca (&quot;telemetry: support array values in data object&q=
uot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Robin Jarry &lt;<a href=3D"mailto:rjarry@redhat.com" target=
=3D"_blank">rjarry@redhat.com</a>&gt;<br>
---<br>
<br>
Notes:<br>
=C2=A0 =C2=A0 v2: added test case<br>
<br>
=C2=A0app/test/test_telemetry_data.c | 21 +++++++++++++++++++++<br>
=C2=A0lib/telemetry/telemetry_data.c |=C2=A0 6 +++---<br>
=C2=A02 files changed, 24 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/app/test/test_telemetry_data.c b/app/test/test_telemetry_data.=
c<br>
index 59898ff5e983..e904b5a7f210 100644<br>
--- a/app/test/test_telemetry_data.c<br>
+++ b/app/test/test_telemetry_data.c<br>
@@ -405,6 +405,26 @@ test_array_with_array_uint_hex_values_nopadding(void)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return CHECK_OUTPUT(&quot;[[\&quot;0x888\&quot;=
],[\&quot;0x8888\&quot;]]&quot;);<br>
=C2=A0}<br>
<br>
+static int<br>
+test_array_with_dict_values(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_start_array(&amp;response_data, RT=
E_TEL_CONTAINER);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_tel_data *d1 =3D rte_tel_data_alloc(=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_start_dict(d1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_add_dict_string(d1, &quot;name&quo=
t;, &quot;foo&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_add_dict_uint(d1, &quot;size&quot;=
, 42);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_add_array_container(&amp;response_=
data, d1, 0);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_tel_data *d2 =3D rte_tel_data_alloc(=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_start_dict(d2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_add_dict_string(d2, &quot;name&quo=
t;, &quot;bar&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_add_dict_uint(d2, &quot;size&quot;=
, 666);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_tel_data_add_array_container(&amp;response_=
data, d2, 0);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return CHECK_OUTPUT(&quot;[{\&quot;name\&quot;:=
\&quot;foo\&quot;,\&quot;size\&quot;:42},{\&quot;name\&quot;:\&quot;bar\&qu=
ot;,\&quot;size\&quot;:666}]&quot;);<br>
+}<br>
+<br>
=C2=A0static int<br>
=C2=A0test_case_array_u64(void)<br>
=C2=A0{<br>
@@ -597,6 +617,7 @@ telemetry_data_autotest(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 test_array_with_array_string_values,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 test_array_with_array_uint_hex_values_padding,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 test_array_with_array_uint_hex_values_nopadding,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0test_array_with_dict_values,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 test_string_char_escaping,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 test_array_char_escaping,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 test_dict_char_escaping,<br>
diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.=
c<br>
index 0354a0654804..0a006559ab42 100644<br>
--- a/lib/telemetry/telemetry_data.c<br>
+++ b/lib/telemetry/telemetry_data.c<br>
@@ -96,10 +96,10 @@ int<br>
=C2=A0rte_tel_data_add_array_container(struct rte_tel_data *d,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_tel_data=
 *val, int keep)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (d-&gt;type !=3D TEL_ARRAY_CONTAINER ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(val-&gt;type !=3D TEL_ARRAY_UINT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (d-&gt;type !=3D TEL_ARRAY_CONTAINER || (val=
-&gt;type !=3D TEL_ARRAY_UINT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;&amp; val-&gt;type !=3D TEL_ARRAY_INT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;&amp; val-&gt;type !=3D TEL_ARRAY_STRING))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;&amp; val-&gt;type !=3D TEL_ARRAY_STRING<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;&amp; val-&gt;type !=3D TEL_DICT))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (d-&gt;data_len &gt;=3D RTE_TEL_MAX_ARRAY_EN=
TRIES)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOSPC;<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div><span style=3D"background-color:transparent=
;color:rgb(0,0,0);font-family:Arial;font-size:13.3333px">Matthew Labrecque<=
/span></div><div><div>Technical Intern, Open Source Team</div><p style=3D"c=
olor:rgb(34,34,34);line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"background-color:transparent;color:rgb(0,0,0);font-family:Arial;fo=
nt-size:10pt">UNH Interoperability Labs</span></p><p dir=3D"ltr" style=3D"c=
olor:rgb(34,34,34);line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:10pt;font-family:Arial;color:rgb(0,0,0);background-color=
:transparent;vertical-align:baseline">21 Madbury Rd, Suite 100, Durham, NH =
03824</span></p><p dir=3D"ltr" style=3D"color:rgb(34,34,34);line-height:1.2=
;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:10pt;font-famil=
y:Arial;color:rgb(17,85,204);background-color:transparent;vertical-align:ba=
seline"><a href=3D"http://www.iol.unh.edu/" style=3D"color:rgb(17,85,204)" =
target=3D"_blank">www.iol.unh.edu</a></span></p></div></div></div></div>

--0000000000006e4f32064832ed11--
