Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420BBC79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 11:39:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92E8340ED2;
	Wed,  9 Sep 2026 13:39:53 +0200 (CEST)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41]) by mails.dpdk.org (Postfix) with ESMTP id 6CC0140A76
 for <dev@dpdk.org>; Wed,  9 Sep 2026 13:39:51 +0200 (CEST)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-66f78cba2e1so5788765d50.3
 for <dev@dpdk.org>; Wed, 09 Sep 2026 04:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788953990; cv=none;
 d=google.com; s=arc-20260327;
 b=d9ZiYLUcfEYreEuSAnCQDkR2EmqflG2qeMoBs54vF2fOf5qvU7F52fybRTGRiRk18g
 mY2Mfjks69wGZESTx+8ztXXqdF2zSWGaThSMqPQzFqaCLdTxUjL0040d8SF5omhJzUTX
 L3TWd24QnrL8B9yOvp6WVPdpOOuWtqajTqY03bGDbYyqFLrzPeD1sa2xON7CiPvcTbzG
 vs0FXggH501ovJswhnX8pp3XEnppt0fG+IxWv9/2bYzTWOjbQU921MWB/2aYmnOF2EQw
 DDCQXuCfiN27GzNIyVFPLuipVGObnaFTzzG/4yzGbOn9qWG22YFeZtFhTL80wHmKGhgA
 0uFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+uX3lvPlUBVfD+J0LKgEG4zwfaZoLmnLAm2l+qBj10k=;
 fh=zNphAuCom6MxCckqDX4te/Ve18PlZzkCipEnMIbKzh4=;
 b=ERK/r7Lygqa6u3t6EHu0ehUI/56omOTBO3M1XRKlHTsttJ0OwG8Xf/3hQTmmLcNVEl
 BOQRr16zAqtRSPkhKR2VDqg/rlpEPUZ4290lYGpcBZOcl+qs68WiYpJZt+ByTZAVJaiZ
 EpHKwS0O6FaPvgXHa/6tWZkiSpaGvvh2/LeoRmOwUAi7olH8j7OmBf+dBJaQBSCmFOpl
 nqTyqvYROod6d/OtVb1q23FqbrGi7gXwFbGL+JCOrxytokAzamd0QEcTC2hP4XVUaKKM
 K7jp7Brx1ku1Q1xh5L97uAqqDtEXMiZ1QMKM3GT4UKBG40ntXHdiX0haJ4TbKCwj+n6B
 oZiA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788953990; x=1789558790; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+uX3lvPlUBVfD+J0LKgEG4zwfaZoLmnLAm2l+qBj10k=;
 b=LJxFVadsm3GWJbYI0qL4pUv/bvlHGZ1/erOGMtmCVTmEbGpeox230kZOaCB39sUJll
 32/6q6pjIzMTjENcjsCqgEdRfcWexs/c/u3PIuYX5y51/rGLtpZKEjVyKkenSD/vPXfz
 5E8QyF7fPE8TU7jN0mYsa5dN8rHCqIPtZUZlstmw3ug0m/DEdil+irvZhnwNwVLN/I8o
 +n7Ij/LXdcyRRjlI5/qBzb8hl27XHvpNM/clxcnAx1mEFb2qZE8wbM7WBHaIRL+KXGj+
 rpljiS5OPM9CzLPgbB5JW71OlqjBwrn/DSdtlek5jpf9VxC/OinVY0jaxz+MYHG07PNn
 UQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788953990; x=1789558790;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+uX3lvPlUBVfD+J0LKgEG4zwfaZoLmnLAm2l+qBj10k=;
 b=l10gus6+ZzKBMiqKX22orv9jDMOqeFzz9s5AlndpwMVZ7xXKeTQitnrk3SkSqsnm73
 ReBTR7BNLn2sNVOtE7bRoWFToz8nMUvCR5m4HrLwmcjSLPA2P3WvjUM27FdGi1Y6z/5L
 ip368fFRnpEN6ZS0+NI/2kvWeUAB9T6Ci4nNb1T3hlbZk4nXA6zY2vzzQulL93AEYc0X
 pwXHYyg+7JZAK6gBWn0fXOfnrAKzHs+c9trCSRERa4o2EaMm2HL32pJGas4R5sE1EaWw
 CVzVy7M1ZQW3vgQz7mdBSGz9S4W82cfwYpFT7SZwIVi/vBcboE8utdCyOgP7ybX4BYWL
 Nj6A==
X-Gm-Message-State: AFuF++mGU6G9t3jTKbFf6Wau7RdXEDkppLijyGR3iMhrBbEkWQwGLNfC
 wLDvTMPa+O82H0kwYhU70oAfnIfFaLA77u640I5RzwFY88syhSswxhYF+vi5kzIxLd2EVTTqCyr
 a2/D0bD7L77ccL3U8r1LWgWYD+T5ubFfbIWlR
X-Gm-Gg: AYBFou3qi/9PKhKz9C1aFz6DFwSQjoxO1QNj2kc5SaXi8LpM9k4mkFzKowYtTU6fNs4
 yNTUXpnWQBI4hAqfrK2DulgHo9YcIvfbJMd1dHQA+N9tuTpEbiZxHFuDAW2TMM8WgE3oHdT4ZOF
 f0Cmow+WkmSlfWjTOX31thcfqsWKzBgeG+jxosWjk6pOLWlUa6imdbnStaOvHVBDIXBKw6rXLhJ
 r0Eu5wf8b9ILuZb095EMBnBu6qsOSuW9yu7kBky8xUGmqAY98ei0gA2AcWtj/xgRPZvZsaCPdz1
 SvfVXg6SMTD3EIYeu7WCSnsTY/uJujCg9t+tV+VEgO4XbRC/xEryFUZS
X-Received: by 2002:a05:690e:1c1c:b0:669:586a:8673 with SMTP id
 956f58d0204a3-66fb59c3a99mr9750476d50.21.1788953990538; Wed, 09 Sep 2026
 04:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260904092157.51040-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpNCdJDJN77BFwFP4bK887xsRDtid7HxSZ=3yapW5mvNsQ@mail.gmail.com>
In-Reply-To: <CAL+mCpNCdJDJN77BFwFP4bK887xsRDtid7HxSZ=3yapW5mvNsQ@mail.gmail.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Wed, 9 Sep 2026 17:09:39 +0530
X-Gm-Features: AcwNN1WWE395zWPZrDiMdbel847NxyPv9YGM4qe98_gl-NHM_qx43SafcavsefA
Message-ID: <CAL+mCpOxM+AeN6ehfr5vVwQQ=1KSv8uivEC-Ng7j3tQ58cjbLg@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: fix duplicate mbox alloc in NPA aura pool
 init
To: dev@dpdk.org
Cc: asekhar@marvell.com, stable@dpdk.org, hkalra@marvell.com, 
 skoteshwar@marvell.com, skori@marvell.com, ndabilpuram@marvell.com, 
 kirankumark@marvell.com
Content-Type: multipart/alternative; boundary="0000000000002029af065b0b4f4f"
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

--0000000000002029af065b0b4f4f
Content-Type: text/plain; charset="UTF-8"

Hi Team

The change-set has no relation to the intel performance test which is
failing. Could someone pls guide on how to get rid of this, get it reviewed
and merged?

Thanks
Amiya


On Wed, 9 Sept 2026 at 16:26, Amiya Ranjan Mohakud <
amiyaranjan.mohakud@gmail.com> wrote:

> Recheck-request: iol-intel-Performance
>
> Thanks
> Amiya
>
>
> On Fri, 4 Sept 2026 at 14:52, Amiya Ranjan Mohakud <
> amiyaranjan.mohakud@gmail.com> wrote:
>
>> npa_aura_pool_init() allocates the pool init mbox message twice on
>> non-CN20K platforms. The if/else block at line 106-111 allocates via
>> the model-specific branch, but the original unconditional allocation
>> at line 112 was not removed when the CN20K branch was added. This
>> overwrites pool_init_req, and the orphaned first message is sent to
>> the AF with uninitialized aura_id, ctype, and op fields, which can
>> trigger any undesired behavior on CN10K.
>>
>> Remove the duplicate allocation.
>>
>> Fixes: 143a419edf35 ("common/cnxk: use new NPA aq enq mbox for CN20K")
>> Cc: asekhar@marvell.com
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
>> ---
>>  drivers/common/cnxk/roc_npa.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
>> index 4a3e96a97a..87f7637e9f 100644
>> --- a/drivers/common/cnxk/roc_npa.c
>> +++ b/drivers/common/cnxk/roc_npa.c
>> @@ -110,7 +110,6 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t
>> aura_id, struct npa_aura_s *aura
>>         } else {
>>                 pool_init_req = mbox_alloc_msg_npa_aq_enq(mbox);
>>         }
>> -       pool_init_req = mbox_alloc_msg_npa_aq_enq(mbox);
>>         if (pool_init_req == NULL)
>>                 goto exit;
>>         pool_init_req->aura_id = aura_id;
>> --
>> 2.39.5 (Apple Git-154)
>>
>>

--0000000000002029af065b0b4f4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:trebuchet ms,sans-serif;col=
or:rgb(103,78,167)" class=3D"gmail_default">Hi Team</div><div style=3D"font=
-family:trebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_defau=
lt"><br></div><div style=3D"font-family:trebuchet ms,sans-serif;color:rgb(1=
03,78,167)" class=3D"gmail_default">The change-set has no relation to the i=
ntel performance test which is failing. Could someone pls guide on how to g=
et rid of this, get it reviewed and merged?</div><br clear=3D"all"></div><d=
iv><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signa=
ture"><div dir=3D"ltr"><div><span style=3D"font-family:verdana,sans-serif">=
Thanks</span></div><div><span style=3D"font-family:verdana,sans-serif">Amiy=
a</span><br></div></div></div></div><br></div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 9 Sep=
t 2026 at 16:26, Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.moh=
akud@gmail.com">amiyaranjan.mohakud@gmail.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Recheck-=
request: iol-intel-Performance</div><div><br></div><div><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div><span style=3D"font-family:ve=
rdana,sans-serif">Thanks</span></div><div><span style=3D"font-family:verdan=
a,sans-serif">Amiya</span><br></div></div></div></div><br></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 4 Sept 20=
26 at 14:52, Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.mohakud=
@gmail.com" target=3D"_blank">amiyaranjan.mohakud@gmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">npa_aura_pool_in=
it() allocates the pool init mbox message twice on<br>
non-CN20K platforms. The if/else block at line 106-111 allocates via<br>
the model-specific branch, but the original unconditional allocation<br>
at line 112 was not removed when the CN20K branch was added. This<br>
overwrites pool_init_req, and the orphaned first message is sent to<br>
the AF with uninitialized aura_id, ctype, and op fields, which can<br>
trigger any undesired behavior on CN10K.<br>
<br>
Remove the duplicate allocation.<br>
<br>
Fixes: 143a419edf35 (&quot;common/cnxk: use new NPA aq enq mbox for CN20K&q=
uot;)<br>
Cc: <a href=3D"mailto:asekhar@marvell.com" target=3D"_blank">asekhar@marvel=
l.com</a><br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.mohak=
ud@gmail.com" target=3D"_blank">amiyaranjan.mohakud@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/common/cnxk/roc_npa.c | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c<=
br>
index 4a3e96a97a..87f7637e9f 100644<br>
--- a/drivers/common/cnxk/roc_npa.c<br>
+++ b/drivers/common/cnxk/roc_npa.c<br>
@@ -110,7 +110,6 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id=
, struct npa_aura_s *aura<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pool_init_req =3D m=
box_alloc_msg_npa_aq_enq(mbox);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pool_init_req =3D mbox_alloc_msg_npa_aq_enq(mbo=
x);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pool_init_req =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pool_init_req-&gt;aura_id =3D aura_id;<br>
-- <br>
2.39.5 (Apple Git-154)<br>
<br>
</blockquote></div>
</blockquote></div>

--0000000000002029af065b0b4f4f--
