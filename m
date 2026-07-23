Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDA8C531D1
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 15:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F3440663;
	Thu, 23 Jul 2026 17:26:43 +0200 (CEST)
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com
 [209.85.217.97]) by mails.dpdk.org (Postfix) with ESMTP id B85A740280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 17:26:41 +0200 (CEST)
Received: by mail-vs1-f97.google.com with SMTP id
 ada2fe7eead31-7473e927969so252136137.3
 for <dev@dpdk.org>; Thu, 23 Jul 2026 08:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784820401; x=1785425201;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:in-reply-to:references:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EtpfFLUe7wm+KLWUoniHM8L1JwnOxkG8uNPi9W2/mzY=;
 b=KbYKI3XuflI16kGP4oJw9u9Bl+ww+q9Bqs46XJ8lRq34uZB9UNRZoPKuIX0+JYcNJw
 CYXF98aa15OdkvjcorHQPps87ayepPNFROziZc91I5GhEZvY0D7/yIyXc1VIjixmyhVd
 ndWHhy1jMX5Ert7/8tetWf7QsAoRjmy7NvnDq+u/PqEVWRqsToTppOg3YI5TapH8sd5v
 n2TwDZgbfswhf9XqxTRa+RdBikBfWddS55rTu3LdMwlNkJohaVesGZIPlpgwhCHUozni
 sOuYyCPxYrrg223P4dEdMwu0oupeAkR0InNPsePYrC6uC1sK3R5pRQs3CGtqYzd5mI6x
 jxYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBju6a1Q9emOfFDVK+VVNOs6iz6cMF2k7Ze0n+g3AK5w/nOY34CxwS5s497+Qi8lu5mlI=@dpdk.org
X-Gm-Message-State: AOJu0YzbPB+stc8+TnjFMCjILEfF+cIbBpl5YxrqWm7dSyQfUlBWEcQa
 TAWUCjlwo9MCxP24rlxJyC+Yu+7gmXD6I3OiGnXJdn3Wdfc7JnCAmWSAGQGA26Cw+lQBEKvhfMl
 jHiB1NOSEZORJIKUS1GC9Y1wPJmxPDpZKXXdFIevbERexkAEERLdWdHKdLqPSizKrbmokbM0uJn
 81/tHR63Zt/p3ztR4pHnAN2RHvpgEXpdbgPAMSg17vq83MbE7FKo6sYwpqjauhwR/gngYBce3TD
 t4UqQ==
X-Gm-Gg: AR+sD1181Nz1f2j9fN0tRe/pqyg4riE7oLDE/UTXWI4qxPe2Oj6ThGtnvHFHMx0DvOb
 vsCDqx+SuITl8ygcHtmqMtiAw6WN8T1MSkra1Su0IVHq9WMHBg3mRbkTxhGXC8ort8RZ7x6w4Ai
 l0xcU9HeE1M7J0IEd8BxTBNPLbzHosHQdPQt1k3m7I4ZE0g1JSQiMxmAIWiG6+SCM+lthILe8yg
 EKVNGUdY+EnErh1QPAHrz7SLH4N2XLXJxlxcX1xWYMK4ouuVzpgEPGmI40D6IdicH5Pgw4KjOPr
 5j5HQh9IL1YRtyyMjumMTq0PqCPOf2/RyonsC1t4+EgoQXsjMPcBB37XzoEdZFDz9p6b2929gsU
 BldCt045mTEfh8vcInFnVPV8fJeKM9+oj3AscWrJt0pLtrJh3j+zoTNzzg+9iL7HEuGdSURiHco
 V/sLWXXwSPBz6mNT/bH4GmhPWIlTB5WelBsHjKfEra71Q=
X-Received: by 2002:a05:6102:441d:b0:74a:b5e3:e96f with SMTP id
 ada2fe7eead31-74d5e0c8eeemr1487886137.7.1784820400537; 
 Thu, 23 Jul 2026 08:26:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-977441b3582sm400010241.7.2026.07.23.08.26.40
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jul 2026 08:26:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so1097811a91.1
 for <dev@dpdk.org>; Thu, 23 Jul 2026 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784820399; x=1785425199; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:in-reply-to:references:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EtpfFLUe7wm+KLWUoniHM8L1JwnOxkG8uNPi9W2/mzY=;
 b=e+Ow9qDHbPHz43vM7fAzlkAhkhQs4L4IyK0Xq7d+Yx0FLxsGv7FzE1Ja7eBbW0Rr2f
 WQe+rddD1YaXjxxhIOgxpO5C3JV7EQhGiasuL4hJo+Rk2xYlkvEL9CvuZV4L2xAbIbR1
 j1tGiCTSOAxt+zD+7TRyZvfnlkRnHlqhVtZ+0=
X-Forwarded-Encrypted: i=1;
 AHgh+RqaunvSJVa8dce8qagNXiBW04Cmp01c+dkWpPRyxYi/U7WvFdND86qP3Bp5tVICBaLsO94=@dpdk.org
X-Received: by 2002:a17:90a:dfcc:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-38ec63e1ee3mr3689308a91.9.1784820399006; 
 Thu, 23 Jul 2026 08:26:39 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcc:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-38ec63e1ee3mr3689263a91.9.1784820398347; Thu, 23 Jul 2026
 08:26:38 -0700 (PDT)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: <20260416090252.2211405-1-lyulin.2003@mail.ru>
 <CA+BST0m7zXt0YD2kgg5nXzHsAk_3n8aYsgncifRxm5dvJt1SyQ@mail.gmail.com>
 <1784799305.659637239@f128.i.mail.ru>
In-Reply-To: <1784799305.659637239@f128.i.mail.ru>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL152tkVfP347mb8ZBG9BnkoMVIygM+8d3iAr6f/Q+0GbOqIA==
Date: Thu, 23 Jul 2026 11:26:34 -0400
X-Gm-Features: AUfX_myl_WQpyhSyht5nv0PJEC6WQJOWGC0pwxi_vTs1Tn6GvkQUxzWgFeScUPA
Message-ID: <7287e3b8f5c4dd323a3207186c458a86@mail.gmail.com>
Subject: RE: [PATCH] net/bnxt: fix memset size mismatch in Tx queue start
To: =?UTF-8?B?0JTQtdC90LjRgSDQm9GO0LvQuNC9?= <lyulin.2003@mail.ru>
Cc: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>,
 Manish Kurup <manish.kurup@broadcom.com>, 
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Randy Schacher <stuart.schacher@broadcom.com>, dev@dpdk.org, 
 stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000e70f23065748e170"
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

--000000000000e70f23065748e170
Content-Type: multipart/alternative; boundary="000000000000d4f81e065748e162"

--000000000000d4f81e065748e162
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Denis,



I have accepted the change and post it for merging the change.



Thanks,

Kishore





*From:* =D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=9B=D1=8E=D0=BB=D0=B8=D0=BD <lyul=
in.2003@mail.ru>
*Sent:* Thursday, July 23, 2026 5:35 AM
*To:* Kishore Padmanabha <kishore.padmanabha@broadcom.com>
*Cc:* Ajit Khaparde <ajit.khaparde@broadcom.com>; Manish Kurup <
manish.kurup@broadcom.com>; Shuanglin Wang <shuanglin.wang@broadcom.com>;
Randy Schacher <stuart.schacher@broadcom.com>; dev@dpdk.org; stable@dpdk.or=
g
*Subject:* Re: [PATCH] net/bnxt: fix memset size mismatch in Tx queue start



Kindly reminder
Sorry, But nobody has reviewed my patch on Patchwork
https://patches.dpdk.org/project/dpdk/patch/20260416090252.2211405-1-lyulin=
.2003@mail.ru/
Could you please review this?



On Thu, Apr 16, 2026 at 5:03=E2=80=AFAM Denis Lyulin <lyulin.2003@mail.ru> =
wrote:

When the tx_queue is started, previous stats are reset.
For tpa_v2 and P7, extended stats structure is used:
`struct bnxt_ring_stats_ext`, so passing wrong size to memset
makes not all stats to be reset. This commit sets correct size of
the structure passed to memset when zeroing-out previous stats.

Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: shuanglin.wang@broadcom.com
Cc: stable@dpdk.org

Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>

Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

---
 drivers/net/bnxt/bnxt_txr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 27758898b0..b6ad37f872 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -729,7 +729,7 @@ int bnxt_tx_queue_start(struct rte_eth_dev *dev,
uint16_t tx_queue_id)
         */
        if (BNXT_TPA_V2_P7(bp))
                memset(&bp->prev_tx_ring_stats_ext[tx_queue_id], 0,
-                      sizeof(struct bnxt_ring_stats));
+                      sizeof(struct bnxt_ring_stats_ext));
        else
                memset(&bp->prev_tx_ring_stats[tx_queue_id], 0,
                       sizeof(struct bnxt_ring_stats));
--
2.34.1

--000000000000d4f81e065748e162
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"><meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered m=
edium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=
=3D"word-wrap:break-word"><div class=3D"WordSection1"><p class=3D"MsoNormal=
"><span style=3D"font-size:11.0pt">Hi Denis,</span></p><p class=3D"MsoNorma=
l"><span style=3D"font-size:11.0pt">=C2=A0</span></p><p class=3D"MsoNormal"=
><span style=3D"font-size:11.0pt">I have accepted the change and post it fo=
r merging the change.</span></p><p class=3D"MsoNormal"><span style=3D"font-=
size:11.0pt">=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-si=
ze:11.0pt">Thanks,</span></p><p class=3D"MsoNormal"><span style=3D"font-siz=
e:11.0pt">Kishore</span></p><p class=3D"MsoNormal"><span style=3D"font-size=
:11.0pt">=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:1=
1.0pt">=C2=A0</span></p><div><div style=3D"border:none;border-top:solid #e1=
e1e1 1.0pt;padding:3.0pt 0in 0in 0in"><p class=3D"MsoNormal"><b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</spa=
n></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-=
serif"> =D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=9B=D1=8E=D0=BB=D0=B8=D0=BD &lt;<=
a href=3D"mailto:lyulin.2003@mail.ru">lyulin.2003@mail.ru</a>&gt; <br><b>Se=
nt:</b> Thursday, July 23, 2026 5:35 AM<br><b>To:</b> Kishore Padmanabha &l=
t;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.padmanabha@bro=
adcom.com</a>&gt;<br><b>Cc:</b> Ajit Khaparde &lt;<a href=3D"mailto:ajit.kh=
aparde@broadcom.com">ajit.khaparde@broadcom.com</a>&gt;; Manish Kurup &lt;<=
a href=3D"mailto:manish.kurup@broadcom.com">manish.kurup@broadcom.com</a>&g=
t;; Shuanglin Wang &lt;<a href=3D"mailto:shuanglin.wang@broadcom.com">shuan=
glin.wang@broadcom.com</a>&gt;; Randy Schacher &lt;<a href=3D"mailto:stuart=
.schacher@broadcom.com">stuart.schacher@broadcom.com</a>&gt;; <a href=3D"ma=
ilto:dev@dpdk.org">dev@dpdk.org</a>; <a href=3D"mailto:stable@dpdk.org">sta=
ble@dpdk.org</a><br><b>Subject:</b> Re: [PATCH] net/bnxt: fix memset size m=
ismatch in Tx queue start</span></p></div></div><p class=3D"MsoNormal">=C2=
=A0</p><p class=3D"MsoNormal">Kindly reminder<br>Sorry, But nobody has revi=
ewed my patch on Patchwork=C2=A0<a href=3D"https://patches.dpdk.org/project=
/dpdk/patch/20260416090252.2211405-1-lyulin.2003@mail.ru/">https://patches.=
dpdk.org/project/dpdk/patch/20260416090252.2211405-1-lyulin.2003@mail.ru/</=
a><br>Could you please review this?<br><br>=C2=A0</p><blockquote style=3D"b=
order:none;border-left:solid #0857a6 1.0pt;padding:0in 0in 0in 8.0pt;margin=
-left:7.5pt;margin-top:7.5pt;margin-right:7.5pt;margin-bottom:7.5pt"><div i=
d=3D""><div id=3D"style_17764436580970480114_mr_css_attr"><div id=3D"style_=
17764436580970480114_BODY_mr_css_attr"><p class=3D"MsoNormal">On Thu, Apr 1=
6, 2026 at 5:03<span style=3D"font-family:&quot;Arial&quot;,sans-serif">=E2=
=80=AF</span>AM Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@mail.ru">lyu=
lin.2003@mail.ru</a>&gt; wrote:</p><blockquote style=3D"border:none;border-=
left:solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin=
-right:0in"><p class=3D"MsoNormal">When the tx_queue is started, previous s=
tats are reset.<br>For tpa_v2 and P7, extended stats structure is used:<br>=
`struct bnxt_ring_stats_ext`, so passing wrong size to memset<br>makes not =
all stats to be reset. This commit sets correct size of<br>the structure pa=
ssed to memset when zeroing-out previous stats.<br><br>Fixes: dd0191d5e70d =
(&quot;net/bnxt/tf_ulp: support Thor2 ULP layer&quot;)<br>Cc: <a href=3D"ma=
ilto:shuanglin.wang@broadcom.com">shuanglin.wang@broadcom.com</a><br>Cc: <a=
 href=3D"mailto:stable@dpdk.org">stable@dpdk.org</a><br><br>Signed-off-by: =
Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@mail.ru">lyulin.2003@mail.ru=
</a>&gt;</p></blockquote><p class=3D"MsoNormal"><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">Acked-by:=C2=
=A0 Kishore Padmanabha &lt;</span><a href=3D"mailto:kishore.padmanabha@broa=
dcom.com"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#0563c1">kishore.padmanabha@broadcom.com</span></a><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:bl=
ack">&gt;</span>=C2=A0</p><blockquote style=3D"border:none;border-left:soli=
d #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0i=
n"><p class=3D"MsoNormal">---<br>=C2=A0drivers/net/bnxt/bnxt_txr.c | 2 +-<b=
r>=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br><br>diff --git a/d=
rivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c<br>index 27758898b=
0..b6ad37f872 100644<br>--- a/drivers/net/bnxt/bnxt_txr.c<br>+++ b/drivers/=
net/bnxt/bnxt_txr.c<br>@@ -729,7 +729,7 @@ int bnxt_tx_queue_start(struct r=
te_eth_dev *dev, uint16_t tx_queue_id)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (BNXT_TPA_V2_P7(bp))<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;bp-&gt;prev_tx_ri=
ng_stats_ext[tx_queue_id], 0,<br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct bnxt_ring_stats));<br>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(struct bnxt_ring_stats_ext));<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 els=
e<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;bp=
-&gt;prev_tx_ring_stats[tx_queue_id], 0,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct bnxt_ring=
_stats));<br>--<br>2.34.1<br>=C2=A0</p></blockquote></div></div></div></blo=
ckquote></div></body></html>

--000000000000d4f81e065748e162--

--000000000000e70f23065748e170
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCDDQaK8f0uEK+QySovpe6xXXeW+3XJmTKZYvMC6GW7F7jAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA3MjMxNTI2MzlaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCeQT+JALrr
hdESxJ/6YPZEghSIrezGf/w7s2lyaJGVdsHy93O7unhkmDbOxaIhnhbHKn5+SCzc6xFuwAuOIACB
vKlJumUxPY2Jwehre5isLNlGvTYj2KDNrd0+GfdR3NuGmPVdtyafLCUZpRBmZgPD8hW2AP8mKJys
U0kNxadCWGW+mEEbSS/eNAayrZZ+G0GY3PJAmdq+1k0t61P3hvnmGZUTiTUsfCe6fvPS+EKTi5jN
Kb1AciI96PWtEwGW5FuvLiov7uUCjdv9+AOVScos7k40PuCLp8hkSbTidpLPtwuSj+ydGRtTRGG3
K5lgRqLJnBKYRQ+8TwPAb1W8IyXn
--000000000000e70f23065748e170--
