Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F33C531F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 16:36:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEEF040687;
	Thu, 23 Jul 2026 18:36:22 +0200 (CEST)
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com
 [209.85.128.228])
 by mails.dpdk.org (Postfix) with ESMTP id 0DE2240663
 for <dev@dpdk.org>; Thu, 23 Jul 2026 18:36:22 +0200 (CEST)
Received: by mail-yw1-f228.google.com with SMTP id
 00721157ae682-81eaf3709b4so8045287b3.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 09:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784824581; x=1785429381;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:in-reply-to:references:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vk13hRWUbu42IdTqc8OP8qMwJ0Of4dh9zzJw+7eoZ2k=;
 b=D/VY7S2bPcONvswjIowSNxs7N9NulHMHkFCwsdvTbYFabXx9IqmvziM0CG1usQH+f3
 Klkgtpxc1m5rBTus5dbRAn7mR/wslNwM+nFWg0FgXHn187ffikxNc6WC5aFgz+S8f0KF
 BScI22ibSiTTJ0AW3oLBZO415IOXcjyArq2OkNK6NcVfYYOCZK3B9yYCtVn+YTndSjK+
 RX7dWXpKUnr5zHK/cpyGDGlpbaySHIvB4IqiK8AhkWQrGvHo08CdvOmHhODg1JbXM1yU
 D8mAg8iqnAQV7gy5o1WLbfR7oBaNWTjBc5VGR/qf6U6JhfKkzw3CnjrF47iSrCIiq9m8
 DGSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbapBCQuBHFXkPO/7+TEo5pX75d2a8wfI9bJUi03zbpWmaf/3n8gwQ/dNuF6RMGOZRNCE=@dpdk.org
X-Gm-Message-State: AOJu0Yz1mFD4LsbbQnJr4acJ2K5ANcxm50m5rgHmqpBxS10eWLOBcRu3
 5Zm76sP+mqHRzWuhf3fhjVtrVRlvbDDO0rFKZwdbTuCf+SDInss8WD+UHWgdB9Tks4thX5MLpUj
 sYGYRIwmCDmzmgtYe/sy8ygKATrHr+IFio3EXYgNJtMSSRzQ20fUN5ZVr0+tuW8ZmwG0Jmbyy7d
 kTwiVjor5oQCv28oh+Zuqfsz2LZ/lA84nayszgwRd6fziVXbNzngm6BlccbiS8JEkksadEa1oVC
 0OyBg==
X-Gm-Gg: AR+sD13qVVWr85MYvglGTQ3QcHPsoS7R7ByHNxC8U1xYxiYqq+53jkw6s2rYTeS0MOK
 qPBN2SJJ3wDvoyHfnl1egtF41HvptwKX08tdfkr5kJxvZpGKuEKzkldLTtECKA/62TlyunxQ8lj
 ynjm14kwsV3i2vlFY9zsR0nH57s0AfeSQjV2vP6STz/7YkCkgoOX3nimjp/HEsZ5mrrCcN4q+Mg
 dK76MgC7idwPLSev665MNwa4Lyreyzn7ht23YFfQMcjd44q5x6Wm5/E/TvXLA99QZJa2EwYuHRX
 qbcGTHWFwkqgLqax0I6yrmYgQON/YyIFDeoA9usE5vt588oXBidWx4UMtCbRmtY9KqLJZCMuVdI
 EVMvvo5PkIoigv2fiK7Q14DVAYb1mOIAZWuIfvDya3IpNQGh9M6ioEkUd8BQvhBtLG6lgaT44y6
 TJV5LN/wLTd3/NbnSg6BYmozW6wQYl6spmv0szMnreU3E=
X-Received: by 2002:a05:690c:6383:b0:814:7a54:3a93 with SMTP id
 00721157ae682-81f4c1ac8e5mr13578547b3.23.1784824580802; 
 Thu, 23 Jul 2026 09:36:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-81f403a1fd5sm2419727b3.25.2026.07.23.09.36.20
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:36:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cca3673560so16252925ad.1
 for <dev@dpdk.org>; Thu, 23 Jul 2026 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784824579; x=1785429379; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:in-reply-to:references:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vk13hRWUbu42IdTqc8OP8qMwJ0Of4dh9zzJw+7eoZ2k=;
 b=aH0hbyTuwwQ+4r8KAafTmOZJPTSrETX8S3p2x7mH4hJKW8iNrsd9GCE/nP5TQi8JRX
 LDbQYWoFEsagrYBh6a5xpLCcdPoeFNo1LMzAAoEY0y43nD54VdYhx5Abmr9WlyWnBPak
 MSK+CNK/RKxdbCegXzfdSvRt7+uAy7U/xowpU=
X-Forwarded-Encrypted: i=1;
 AHgh+RqeJl/KnWBk5GAgIspVyfMYqOSLbumlZ0kboSPBYesTO796Atdxp9VDkySdKp8ukED/0+Q=@dpdk.org
X-Received: by 2002:a17:902:ecc2:b0:2ca:bb7e:29a7 with SMTP id
 d9443c01a7336-2cfa71af010mr44647585ad.41.1784824579353; 
 Thu, 23 Jul 2026 09:36:19 -0700 (PDT)
X-Received: by 2002:a17:902:ecc2:b0:2ca:bb7e:29a7 with SMTP id
 d9443c01a7336-2cfa71af010mr44647145ad.41.1784824578776; Thu, 23 Jul 2026
 09:36:18 -0700 (PDT)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: <20260417052334.2217652-1-lyulin.2003@mail.ru>
 <CA+BST0=McqcXBkCKaibAG=d8u=EsM2XTRxbqA5azE-yd2jcY8g@mail.gmail.com>
 <1784799383.856929464@f128.i.mail.ru>
In-Reply-To: <1784799383.856929464@f128.i.mail.ru>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGqo18RfHe5H4d8amILbn1ta7BLVgJCjEStAi6LV962vLMe8A==
Date: Thu, 23 Jul 2026 12:36:16 -0400
X-Gm-Features: AUfX_mxtmiwK_chYPbc9QONB6L7gwv-JKDXAuROkIKHCLWJQye-aUdsx3sLDVFI
Message-ID: <7a88723163b592558cc7de1ac04f5579@mail.gmail.com>
Subject: RE: [PATCH] net/bnxt: add cast to wider type before multiplication
To: =?UTF-8?B?0JTQtdC90LjRgSDQm9GO0LvQuNC9?= <lyulin.2003@mail.ru>
Cc: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org,
 stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000010bed2065749db77"
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

--00000000000010bed2065749db77
Content-Type: multipart/alternative; boundary="00000000000001463d065749db56"

--00000000000001463d065749db56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Denis,



Accepted the change, should be merged in next cycle.



Thanks,

Kishore





*From:* =D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=9B=D1=8E=D0=BB=D0=B8=D0=BD <lyul=
in.2003@mail.ru>
*Sent:* Thursday, July 23, 2026 5:36 AM
*To:* Kishore Padmanabha <kishore.padmanabha@broadcom.com>
*Cc:* Ajit Khaparde <ajit.khaparde@broadcom.com>; Kalesh AP <
kalesh-anakkur.purayil@broadcom.com>; dev@dpdk.org; stable@dpdk.org
*Subject:* Re: [PATCH] net/bnxt: add cast to wider type before
multiplication



Kindly reminder
Sorry, But nobody has reviewed my small cosmetic patch on Patchwork
https://patches.dpdk.org/project/dpdk/patch/20260417052334.2217652-1-lyulin=
.2003@mail.ru/
Could you please review this?





On Fri, Apr 17, 2026 at 1:23=E2=80=AFAM Denis Lyulin <lyulin.2003@mail.ru> =
wrote:

Some static analyzers generate warnings about possible integer
overflow on multiplication. The first parameter of
`rte_eal_alarm_set()` is `uint64_t`, so this commit adds cast
of `uint32_t` values before the multiplication to prevent overflow.
The fix is cosmetic.

Fixes: 9d0cbaecc91a ("net/bnxt: support periodic FW health monitoring")
Cc: kalesh-anakkur.purayil@broadcom.com
Cc: stable@dpdk.org

Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>

Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

---
 drivers/net/bnxt/bnxt_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.=
c
index b677f9491d..bdfab3eef2 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -4861,7 +4861,7 @@ static void bnxt_dev_recover(void *arg)
 void bnxt_dev_reset_and_resume(void *arg)
 {
        struct bnxt *bp =3D arg;
-       uint32_t us =3D US_PER_MS * bp->fw_reset_min_msecs;
+       uint64_t us =3D US_PER_MS * (uint64_t)bp->fw_reset_min_msecs;
        uint16_t val =3D 0;
        int rc;

@@ -5008,7 +5008,7 @@ static void bnxt_check_fw_health(void *arg)

        info->last_reset_counter =3D val;

-       rte_eal_alarm_set(US_PER_MS * info->driver_polling_freq,
+       rte_eal_alarm_set(US_PER_MS * (uint64_t)info->driver_polling_freq,
                          bnxt_check_fw_health, (void *)bp);

        return;
@@ -5030,7 +5030,7 @@ static void bnxt_check_fw_health(void *arg)
        else
                wait_msec =3D info->normal_func_wait_period;

-       rte_eal_alarm_set(US_PER_MS * wait_msec,
+       rte_eal_alarm_set(US_PER_MS * (uint64_t)wait_msec,
                          bnxt_fw_reset_cb, (void *)bp);
 }

@@ -5048,7 +5048,7 @@ void bnxt_schedule_fw_health_check(struct bnxt *bp)

        polling_freq =3D bp->recovery_info->driver_polling_freq;

-       rte_eal_alarm_set(US_PER_MS * polling_freq,
+       rte_eal_alarm_set(US_PER_MS * (uint64_t)polling_freq,
                          bnxt_check_fw_health, (void *)bp);
        bp->flags |=3D BNXT_FLAG_FW_HEALTH_CHECK_SCHEDULED;

--
2.34.1

--00000000000001463d065749db56
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
><span style=3D"font-size:11.0pt">Accepted the change, should be merged in =
next cycle.</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0p=
t">=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"=
>Thanks,</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">=
Kishore</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">=
=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">=
=C2=A0</span></p><div><div style=3D"border:none;border-top:solid #e1e1e1 1.=
0pt;padding:3.0pt 0in 0in 0in"><p class=3D"MsoNormal"><b><span style=3D"fon=
t-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
 =D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=9B=D1=8E=D0=BB=D0=B8=D0=BD &lt;<a href=
=3D"mailto:lyulin.2003@mail.ru">lyulin.2003@mail.ru</a>&gt; <br><b>Sent:</b=
> Thursday, July 23, 2026 5:36 AM<br><b>To:</b> Kishore Padmanabha &lt;<a h=
ref=3D"mailto:kishore.padmanabha@broadcom.com">kishore.padmanabha@broadcom.=
com</a>&gt;<br><b>Cc:</b> Ajit Khaparde &lt;<a href=3D"mailto:ajit.khaparde=
@broadcom.com">ajit.khaparde@broadcom.com</a>&gt;; Kalesh AP &lt;<a href=3D=
"mailto:kalesh-anakkur.purayil@broadcom.com">kalesh-anakkur.purayil@broadco=
m.com</a>&gt;; <a href=3D"mailto:dev@dpdk.org">dev@dpdk.org</a>; <a href=3D=
"mailto:stable@dpdk.org">stable@dpdk.org</a><br><b>Subject:</b> Re: [PATCH]=
 net/bnxt: add cast to wider type before multiplication</span></p></div></d=
iv><p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal">Kindly reminder<=
br>Sorry, But nobody has reviewed my small cosmetic=C2=A0patch on Patchwork=
=C2=A0<a href=3D"https://patches.dpdk.org/project/dpdk/patch/20260417052334=
.2217652-1-lyulin.2003@mail.ru/">https://patches.dpdk.org/project/dpdk/patc=
h/20260417052334.2217652-1-lyulin.2003@mail.ru/</a><br>Could you please rev=
iew this?<br><br>=C2=A0</p><blockquote style=3D"border:none;border-left:sol=
id #0857a6 1.0pt;padding:0in 0in 0in 8.0pt;margin-left:7.5pt;margin-top:7.5=
pt;margin-right:7.5pt;margin-bottom:7.5pt"><div id=3D""><div id=3D"style_17=
764444091671824853_mr_css_attr"><div id=3D"style_17764444091671824853_BODY_=
mr_css_attr"><p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal">On Fri=
, Apr 17, 2026 at 1:23<span style=3D"font-family:&quot;Arial&quot;,sans-ser=
if">=E2=80=AF</span>AM Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@mail.=
ru">lyulin.2003@mail.ru</a>&gt; wrote:</p><blockquote style=3D"border:none;=
border-left:solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt=
;margin-right:0in"><p class=3D"MsoNormal">Some static analyzers generate wa=
rnings about possible integer<br>overflow on multiplication. The first para=
meter of<br>`rte_eal_alarm_set()` is `uint64_t`, so this commit adds cast<b=
r>of `uint32_t` values before the multiplication to prevent overflow.<br>Th=
e fix is cosmetic.<br><br>Fixes: 9d0cbaecc91a (&quot;net/bnxt: support peri=
odic FW health monitoring&quot;)<br>Cc: <a href=3D"mailto:kalesh-anakkur.pu=
rayil@broadcom.com">kalesh-anakkur.purayil@broadcom.com</a><br>Cc: <a href=
=3D"mailto:stable@dpdk.org">stable@dpdk.org</a><br><br>Signed-off-by: Denis=
 Lyulin &lt;<a href=3D"mailto:lyulin.2003@mail.ru">lyulin.2003@mail.ru</a>&=
gt;</p></blockquote><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif">Acked-by:=C2=A0=C2=A0Kishore Pa=
dmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.pad=
manabha@broadcom.com</a>&gt;</span>=C2=A0</p><blockquote style=3D"border:no=
ne;border-left:solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.=
8pt;margin-right:0in"><p class=3D"MsoNormal">---<br>=C2=A0drivers/net/bnxt/=
bnxt_ethdev.c | 8 ++++----<br>=C2=A01 file changed, 4 insertions(+), 4 dele=
tions(-)<br><br>diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/b=
nxt/bnxt_ethdev.c<br>index b677f9491d..bdfab3eef2 100644<br>--- a/drivers/n=
et/bnxt/bnxt_ethdev.c<br>+++ b/drivers/net/bnxt/bnxt_ethdev.c<br>@@ -4861,7=
 +4861,7 @@ static void bnxt_dev_recover(void *arg)<br>=C2=A0void bnxt_dev_=
reset_and_resume(void *arg)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struc=
t bnxt *bp =3D arg;<br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t us =3D US_PER_M=
S * bp-&gt;fw_reset_min_msecs;<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t us =
=3D US_PER_MS * (uint64_t)bp-&gt;fw_reset_min_msecs;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint16_t val =3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br><b=
r>@@ -5008,7 +5008,7 @@ static void bnxt_check_fw_health(void *arg)<br><br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;last_reset_counter =3D val;<br><br>-=
=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * info-&gt;driver_po=
lling_freq,<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * (u=
int64_t)info-&gt;driver_polling_freq,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bnxt_check_fw_heal=
th, (void *)bp);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>@@ -5030,7 +=
5030,7 @@ static void bnxt_check_fw_health(void *arg)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
wait_msec =3D info-&gt;normal_func_wait_period;<br><br>-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * wait_msec,<br>+=C2=A0 =C2=A0 =C2=A0=
 =C2=A0rte_eal_alarm_set(US_PER_MS * (uint64_t)wait_msec,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 bnxt_fw_reset_cb, (void *)bp);<br>=C2=A0}<br><br>@@ -5048,7 +5048,7 @@ =
void bnxt_schedule_fw_health_check(struct bnxt *bp)<br><br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 polling_freq =3D bp-&gt;recovery_info-&gt;driver_polling_freq=
;<br><br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * polling_=
freq,<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * (uint64_=
t)polling_freq,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bnxt_check_fw_health, (void *)bp);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp-&gt;flags |=3D BNXT_FLAG_FW_HEALTH_CHECK_SCH=
EDULED;<br><br>--<br>2.34.1<br>=C2=A0</p></blockquote></div></div></div></b=
lockquote></div></body></html>

--00000000000001463d065749db56--

--00000000000010bed2065749db77
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
oIHHMC8GCSqGSIb3DQEJBDEiBCAARx+pIoWhb7R3qr0F1JtyOkJH1i8+/+Fu7Q5ewKL10jAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA3MjMxNjM2MTlaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCg784EDmrI
h4XbjWBayiilHX3qfHyU8delr2f6dSXKZ9kVnVs8WbKHMwX2/0Sm7W89Ux+QWss+VWHsIJSljEOq
Ao6FNPrQI7LrdEGGvieMG4G27CA5ZF2kgugWv9bN4Sz7j4VZaSQ00B68qkHfsE+pV6CcaENzHbSL
+lDsHacTK1YDLWYt0Zhuw674fR6rJGOCxsXEEa9d9ZxYPyLAwdcX3kkO+bGFgD5MDAfJgS/OV4K9
Am8qUcfe2PsSBBhkGmEflSlPGqqzZi+A2w3k0j04cZGA8Vd22LQvWsNz0MV2huxX5/aVwUN05Pva
PuEnmU7k5fJger/O7vRvTgyuWKGz
--00000000000010bed2065749db77--
