Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EDECCFA02
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 19:19:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3349402E4;
	Fri, 31 Oct 2025 20:19:08 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 96CD240150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 20:19:07 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-294fac2d438so21433935ad.1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761938346; x=1762543146; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RHpTGTyBKBiKprnnDl+5MySS33YsNoKOyoDvaMJmmvM=;
 b=Xl4ZJb0Vb/nsShl/9oJBbnhsfq9WGw9mzfUeXeedaP5uToUMS0wDWZ0BnhVQJn0tbV
 RSG5bDHyh1Gh1uQ1szejBgNKzc4SkRnCD2Edqdcoj8EDqWqwzz6HGZxSq2yt7/DXj+re
 LApXN/SeLXy8QBcWjIosUlqU32kiQ31MfLCvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761938346; x=1762543146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHpTGTyBKBiKprnnDl+5MySS33YsNoKOyoDvaMJmmvM=;
 b=koJgdIf8Aqidpp9ZQ84t97rzhqaM1qf4LVhmxZ675rafnJbPnm+5x0tYaHLg+wkC5a
 dlvTQtTMYEldRIeBGEJ0PVLpreb7K2uUUNE/rYX79i9FHv6CKMD1G/dOs602B6s6xKqg
 by606jO6Hh+w8KPOTjl1tMqiXbrWYLaDTuAQ0vBjSAV748P8Uh6umMXV0m5njfNmtA0P
 Oru1amKYqkLEmkM4t/Zf9SY5TzYfu/Am+hp1F+8RwJUkBrqgqG/F48qQ0NaxgYVLtjPp
 8BF4pe6yNIIUSLWeQtSsgN3y6xEWdsgUAF1lu3YQ1mvlS10FcoUKjZcql9PJFb4AsGkz
 xRFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9+NiX4qFp+E0adKRVlbCz7p1/Jy0bfz0QEOyg8yInREXQCHp1wC+MObH9F7NFnO+rWR0=@dpdk.org
X-Gm-Message-State: AOJu0YxonCA62d6ZeQMzZUb4Hx2IrfcxkLGXD/+uT1uAIrTx7gLl3olT
 2Uh4h+DmfKiduP1PUpND63sCL+KYMKbRcN/tfnKdcxMRWkwbDbqAwYiThSFbAyuBoCMDFNed8Mm
 mdlUdZOgsXyE6HV5/xzLay3gxt4MOSXBqxKSwU1Qoyg==
X-Gm-Gg: ASbGnctgkGLAM2X4/CCv5k0ERzkqNYye+f97AEQimE/KmaIVRTN5zJA3r2s7j0sgfyk
 cjYXlaFqIpDF/h3mXi+HWYj2esyNC+CEo4NDJHT4sTOUA42kYjxzoVhSNM35ldD8tCE41wyaGwN
 IkA744cswbEl607EZAauTjEf+hd8giQqIzm/eio036Gu5s4JiWj6pM0uQJPhsOe6AUD9IYbFW7F
 EtvXGJXtaaCEsUq4lZ4uC6BhXMe1320r3yys/qIXrUSz18wN8HUcpIedvjtr6IU4sdd+lafmRfK
 9SeP+NzBdw==
X-Google-Smtp-Source: AGHT+IE2SLfM62jIwR44UAMQpdVWSgG2PzryJQI8VHDT8qLiKYwlmfaDCpd9pPqt0vR0gWyt80BupnWXW2DVmpYcb8s=
X-Received: by 2002:a17:902:b48e:b0:27e:ef27:1e52 with SMTP id
 d9443c01a7336-2951a45459emr43557955ad.35.1761938346527; Fri, 31 Oct 2025
 12:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251024184724.1698235-1-svaze@qti.qualcomm.com>
 <SJ2PR02MB97955A036156C166302AC92489FDA@SJ2PR02MB9795.namprd02.prod.outlook.com>
 <SJ2PR02MB97950C22EE0516E4903D5CF389F8A@SJ2PR02MB9795.namprd02.prod.outlook.com>
In-Reply-To: <SJ2PR02MB97950C22EE0516E4903D5CF389F8A@SJ2PR02MB9795.namprd02.prod.outlook.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 31 Oct 2025 15:18:04 -0400
X-Gm-Features: AWmQ_bnogKF6nUOXIqB9I6cJ1TNHh_dCq0_38Gd4o9A-CHNzwi7ZuN-cPa7mHzc
Message-ID: <CAJvnSUCRqwCG=DyOXYeibHk=Yt4BRmqtfFaJkWbcD7=jOq3XLw@mail.gmail.com>
Subject: Re: [PATCH] compressdev: fix coverity issue
To: Sameer Vaze <svaze@qti.qualcomm.com>
Cc: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashishg@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000042dfd30642793d9a"
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

--00000000000042dfd30642793d9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sameer,

Thanks for the heads up. It looks like the Github Robot has a failure but I
think it is a spurious false fail, so I just sent a recheck request for
that. I expect that failure will be overwritten with a PASS soon.

There are also 2 warnings on your patch, which I can address, but they will
not preclude your patch from being merged (as they are only a WARN, not a
FAIL).

Thanks.

On Fri, Oct 31, 2025 at 1:10=E2=80=AFPM Sameer Vaze <svaze@qti.qualcomm.com=
> wrote:

>
> Hey Patrick
>
> I followed https://core.dpdk.org/testing/#requesting-a-patch-retest to
> request a rebase and recheck since the failures don't seem related to my
> changes. It doesn't look like the retests were picked up. Did I miss
> something?
>
> Thanks
> Sameer Vaze
> ------------------------------
> *From:* Sameer Vaze <svaze@qti.qualcomm.com>
> *Sent:* Tuesday, October 28, 2025 11:19 AM
> *To:* Sunila Sahu <ssahu@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>=
;
> Ashish Gupta <ashishg@marvell.com>
> *Cc:* dev@dpdk.org <dev@dpdk.org>
> *Subject:* Re: [PATCH] compressdev: fix coverity issue
>
>
> *WARNING:* This email originated from outside of Qualcomm. Please be wary
> of any links or attachments, and do not enable macros.
> Recheck-request: rebase=3Dmain, iol-sample-apps-testing,
> iol-compile-amd64-testing
> ------------------------------
> *From:* Sameer Vaze <svaze@qti.qualcomm.com>
> *Sent:* Friday, October 24, 2025 12:47 PM
> *To:* Sunila Sahu <ssahu@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>=
;
> Ashish Gupta <ashishg@marvell.com>
> *Cc:* dev@dpdk.org <dev@dpdk.org>; Sameer Vaze <svaze@qti.qualcomm.com>
> *Subject:* [PATCH] compressdev: fix coverity issue
>
> Adds missing free before end of function
>
> Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
> ---
>  drivers/compress/zlib/zlib_pmd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/compress/zlib/zlib_pmd.c
> b/drivers/compress/zlib/zlib_pmd.c
> index 3a2485b54e..1d7651dd7d 100644
> --- a/drivers/compress/zlib/zlib_pmd.c
> +++ b/drivers/compress/zlib/zlib_pmd.c
> @@ -126,6 +126,7 @@ process_zlib_inflate_chksum(struct rte_comp_op *op,
>                  free(dictionary);
>                  return;
>          }
> +       free(dictionary);
>  }
>
>  static void
> --
> 2.31.1
>
>

--00000000000042dfd30642793d9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sameer,<div><br></div><div>Thanks for the heads up. It =
looks like the Github Robot has a failure but I think it is a spurious fals=
e fail, so I just sent a recheck request for that. I expect that failure wi=
ll be overwritten with a PASS soon.</div><div><br></div><div>There are also=
 2 warnings on your patch, which I can address, but they will not preclude =
your patch from being merged (as they are only a WARN, not a FAIL).</div><d=
iv><br></div><div>Thanks.</div></div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 31, 2025 a=
t 1:10=E2=80=AFPM Sameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcomm.com"=
>svaze@qti.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div class=3D"msg528728163559859775">




<div dir=3D"ltr">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div id=3D"m_528728163559859775Signature">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Hey Patrick</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
I followed <a id=3D"m_528728163559859775OWA1ca9f512-d97b-9bdf-6aac-161c55ee=
1852" href=3D"https://core.dpdk.org/testing/#requesting-a-patch-retest" tar=
get=3D"_blank">
https://core.dpdk.org/testing/#requesting-a-patch-retest</a>=C2=A0to reques=
t a rebase and recheck since the failures don&#39;t seem related to my chan=
ges. It doesn&#39;t look like the retests were picked up. Did I miss someth=
ing?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:11pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:11pt=
;color:rgb(0,0,0)">
Thanks<br>
Sameer Vaze</div>
</div>
<div id=3D"m_528728163559859775appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_528728163559859775divRplyFwdMsg" dir=3D"ltr"><font face=3D"Cal=
ibri, sans-serif" style=3D"font-size:11pt" color=3D"#000000"><b>From:</b> S=
ameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcomm.com" target=3D"_blank">=
svaze@qti.qualcomm.com</a>&gt;<br>
<b>Sent:</b> Tuesday, October 28, 2025 11:19 AM<br>
<b>To:</b> Sunila Sahu &lt;<a href=3D"mailto:ssahu@marvell.com" target=3D"_=
blank">ssahu@marvell.com</a>&gt;; Fan Zhang &lt;<a href=3D"mailto:fanzhang.=
oss@gmail.com" target=3D"_blank">fanzhang.oss@gmail.com</a>&gt;; Ashish Gup=
ta &lt;<a href=3D"mailto:ashishg@marvell.com" target=3D"_blank">ashishg@mar=
vell.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</=
a> &lt;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a>&g=
t;<br>
<b>Subject:</b> Re: [PATCH] compressdev: fix coverity issue</font>
<div>=C2=A0</div>
</div>

<div dir=3D"ltr">
<p style=3D"text-align:center"><span style=3D"background-color:rgb(255,255,=
0);font-size:14px;font-family:sans-serif;color:rgb(0,0,0)"><strong>WARNING:=
</strong> This email originated from outside of Qualcomm. Please be wary of=
 any links or attachments, and do not enable
 macros.</span></p>
<div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Recheck-request: rebase=3Dmain, iol-sample-apps-testing, iol-compile-amd64-=
testing</div>
<div id=3D"m_528728163559859775x_appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_528728163559859775x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"C=
alibri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b>=
 Sameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcomm.com" target=3D"_blank=
">svaze@qti.qualcomm.com</a>&gt;<br>
<b>Sent:</b> Friday, October 24, 2025 12:47 PM<br>
<b>To:</b> Sunila Sahu &lt;<a href=3D"mailto:ssahu@marvell.com" target=3D"_=
blank">ssahu@marvell.com</a>&gt;; Fan Zhang &lt;<a href=3D"mailto:fanzhang.=
oss@gmail.com" target=3D"_blank">fanzhang.oss@gmail.com</a>&gt;; Ashish Gup=
ta &lt;<a href=3D"mailto:ashishg@marvell.com" target=3D"_blank">ashishg@mar=
vell.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</=
a> &lt;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a>&g=
t;; Sameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcomm.com" target=3D"_bl=
ank">svaze@qti.qualcomm.com</a>&gt;<br>
<b>Subject:</b> [PATCH] compressdev: fix coverity issue</font>
<div>=C2=A0</div>
</div>
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>Adds missing free before end of function<br>
<br>
Signed-off-by: Sameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcomm.com" ta=
rget=3D"_blank">svaze@qti.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0drivers/compress/zlib/zlib_pmd.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_=
pmd.c<br>
index 3a2485b54e..1d7651dd7d 100644<br>
--- a/drivers/compress/zlib/zlib_pmd.c<br>
+++ b/drivers/compress/zlib/zlib_pmd.c<br>
@@ -126,6 +126,7 @@ process_zlib_inflate_chksum(struct rte_comp_op *op,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 free(dictionary);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(dictionary);<br>
=C2=A0}<br>
=C2=A0<br>
=C2=A0static void<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>

</div></blockquote></div>

--00000000000042dfd30642793d9a--
