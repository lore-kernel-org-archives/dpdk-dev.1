Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB11BCDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 22:35:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98796402EE;
	Wed, 24 Jun 2026 00:35:05 +0200 (CEST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by mails.dpdk.org (Postfix) with ESMTP id 0448B40299
 for <dev@dpdk.org>; Wed, 24 Jun 2026 00:35:04 +0200 (CEST)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-39657d28132so2847541fa.3
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782254103; cv=none;
 d=google.com; s=arc-20240605;
 b=Rde5oMka5DBPIM153YE+4ffGQRliGcyx83F6dv7WN7OElT+UTKeSZwdNtNR/Tu76J0
 DcAjEzbnkWaRkiL/50efacIhjo2yIoydZpohF2EdRXQ/UtYJQs31XNqcaYhPSnyIEUIJ
 MZiiFRNfLFYNPBcBWVjYf5rPrXvYYLfzDiu47N6yfhQwItV4jnqW5Gno+XF4TNJy6ibU
 W86wsPBr/Z+xeLYH0FJzePDDHhgiERzpN5CWe6PPXyYH7nGmnf6UjKfBbxNDlmP8hPyN
 PAOHHwmhvhqEAIZDqkCeyQbEOH0np8ThmwD480F24BZUmT0bIiQll7YW6pfByANVqk74
 hBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Er0C6/PEeeI1PRFEU5ubw1Ipgqc7uFMzIS0Wi21Uu34=;
 fh=RloalQ24cM4nIOD0e9Pbj/lgWMY/LLP51wfmqJiIYlU=;
 b=aM1/VMDVrRGVn0qM1J9ltQUspdQ+6iRRcsi3zi4DehitZ41VF99ohjZhqCO+a6CRkx
 rbtfrXRHJhs22vTAbdCgTMIWjzBRCsgLzOyM9M7FuZr4aC04SMKi76UIykRGPBDlGpbW
 z4T7ycE+99utBbRysxrut3LXYBZLd19uihjOE5WXLVRqkmEI32SYgY7EHnV0dsO3EAI4
 dF63ibDprIPq4KZ2bNj9JZv5GnzzEIVBh3lpfkgTACcBvc6GRj3vJ3htwOkQzzeFgX+x
 k5IZfU2W+5UdsYMs94gSdHaZI9rVZx4Eteox7NTJDcVZ/mkxOUTN2lVbVH26rWb7yIsw
 paxw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782254103; x=1782858903; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Er0C6/PEeeI1PRFEU5ubw1Ipgqc7uFMzIS0Wi21Uu34=;
 b=N/v2oNoLfl1UQzfUZXDjM/fmBBbRmfe7UcTukLvsmu/7l+QVy8rDttrjdecSP4qF+k
 0+8/pul4ait5owfY+Y2t7Oc2Lt4dVv8XGBCkxuDOMGwSDam/tYNLZugQCkYyj8WHlkx6
 /lYisAo6VkqOvN6Zj4NiGlNCFcCl7LqWcJOGlwjQxtJBY6FR2wf2khGs+vmMdyt3e1K9
 knBrIDf9+15zBDB89b7WoydzsdgUF/JTbjTRm5UZ4QxsAYjFIvTxmQ+D89cUz7YXgsg1
 QrneYK6dBN/NSUBbZTTPTf5hdsvjUKXhS0hPSgAkywPceCF0Q3fusWDBz1lReEyTSldU
 F2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782254103; x=1782858903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Er0C6/PEeeI1PRFEU5ubw1Ipgqc7uFMzIS0Wi21Uu34=;
 b=IHYneTcRMcxlZslBkTnkc6XyoME0W2GOMHOiPSjFYbBSzttwmJ8NxOrAtsYqCoUcIG
 g1gsIcXaEZqLB8UqnEVqpYFddCY84XGIqqP59q8yQuy0OcOLOUBiljG37aCKpFFg7QGe
 ZGMU/HDvQl/unUhgQREnuoHyN4jdIqeI9bqCRbhgU9M/hlmTdQ1WzqPeXDeyiMx/sy5W
 2VgG7NI8YubLBXlxLeF4AtT8pWNisWkE8Z+RNKtoMpBcCytCLaQ5bD0vVH33y3LPzXhH
 cjn2ITSPw2C31lgI14zr+YbfJLAIRsbJ7nmCgNh0XbDT76q5VK3Ds+GkDdJ3JAxuluZT
 ewew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dy3p4SxF2J5hEZfBz9dkaTZ3svLKx4uyx54DFv0Gb3dquz7NpDereaX6ekUg8CpUWpgQ=@dpdk.org
X-Gm-Message-State: AOJu0Yw7KvY30FWXu5E6pTH35GfdEk+u22qrMEIZQnPgf1hvhkgG0gnP
 0vg/sdiTgRZ9Cbne7bCN3nZAJ9Aqc7feKJ+WAenT6qlmP60fP+SW5c7d1BtcADWE1K8RudL6cGf
 AKFz/hmMW+b8m56QzPzz1WtTfNGgYvLg=
X-Gm-Gg: AfdE7ck1DaWM/3VuQlJeKovKzRMkgC73HvxSRhA/91Cfep4Q93/c1G3z19VrIZFDQ8w
 wV8bsOmfjtsQGa5h5XLznxANbaxspprStquZjfgVnXWj4R9P8v4T3w8yyPZXNUQe4+nMXXO4xlX
 W7kGKX2B8e/yiFs7zzAGc84hfZ/39uTy6uQm2PZcSHdZvygjiQfDQ6dnv9Qu3uzT/5oS06Qj95e
 I/cjEoApGQLo5s0cuuackV92EBT9i190GpyyokmVo9X1GqyO7j7h5auoJjbmqZ+74aNzCbSMxg2
 MOb/LZNUm7LRd8X6Q8oa0nQwvcAwQA==
X-Received: by 2002:a2e:bc0b:0:b0:38e:36c2:9bd1 with SMTP id
 38308e7fff4ca-39aba16c376mr1259851fa.11.1782254102983; Tue, 23 Jun 2026
 15:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260609144501.1441468-1-knimoji@iol.unh.edu>
 <20260618204525.1010218-1-knimoji@iol.unh.edu>
In-Reply-To: <20260618204525.1010218-1-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 23 Jun 2026 18:34:51 -0400
X-Gm-Features: AVVi8CcEpGMbZXvqQGLd9JtU0jn-96rOiVzAyTiQtdhEyWDj9_McMAg147UkAh8
Message-ID: <CAK6Duxs-o_OcgjM9_dm-oBFTU7zKjk1g1X0bvbS=gtgwFSd0=Q@mail.gmail.com>
Subject: Re: [PATCH v2] dts: update dts check format script and resolve errors
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu, 
 NBU-Contact-Thomas Monjalon <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="000000000000b538720654f35e7b"
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

--000000000000b538720654f35e7b
Content-Type: text/plain; charset="UTF-8"

Looks like your patch is failing some of the checks on patchwork, including
doc build: https://github.com/ovsrobot/dpdk/actions/runs/27789008643

Remember to run a doc build locally before sending any patches:

meson setup build
ninja -C build doc

Otherwise, please provide a little more info regarding your info. So, you
have updated some of the dependencies used in the dts check format script.
I think what I see from a quick look that is relevant is:

-mypy = "^1.13.0"
+mypy = "^2.1.0"
 toml = "^0.10.2"
-ruff = "^0.8.1"
-types-paramiko = "^3.5.0.20240928"
+ruff = "^0.15.16"
+types-paramiko = "^4.0.0.20260518"
 types-invoke = "^2.0.0.10"
-types-pyyaml = "^6.0.12.20240917"
+types-pyyaml = "^6.0.12.20260518"

What is being done broadly? All dependencies covered by poetry are being
updated? or just the subset included in format checks? Are dependencies
being brought to current latest or something different?

I remember Thomas mentioning that DTS was not checking the
dts-check-format.sh at DPDK Summit and that confused me. Perhaps he is
running DTS and dts-check-format.sh outside of poetry (which we have said
is okay to do) and he is on newer versions of the formatting dependencies
than what we currently have committed to the poetry.lock.

--000000000000b538720654f35e7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks like your patch is failing some of the checks on pat=
chwork, including doc build:=C2=A0<a href=3D"https://github.com/ovsrobot/dp=
dk/actions/runs/27789008643">https://github.com/ovsrobot/dpdk/actions/runs/=
27789008643</a><div><br></div><div>Remember to run a doc build locally befo=
re sending any patches:</div><div><br></div><div>meson setup build</div><di=
v>ninja -C build doc</div><div><br></div><div>Otherwise, please provide a l=
ittle more info regarding your info. So, you have updated some of the depen=
dencies used in the dts check format script. I think what I see from a quic=
k look that is relevant is:</div><div><br></div><div>-mypy =3D &quot;^1.13.=
0&quot;<br>+mypy =3D &quot;^2.1.0&quot;<br>=C2=A0toml =3D &quot;^0.10.2&quo=
t;<br>-ruff =3D &quot;^0.8.1&quot;<br>-types-paramiko =3D &quot;^3.5.0.2024=
0928&quot;<br>+ruff =3D &quot;^0.15.16&quot;<br>+types-paramiko =3D &quot;^=
4.0.0.20260518&quot;<br>=C2=A0types-invoke =3D &quot;^2.0.0.10&quot;<br>-ty=
pes-pyyaml =3D &quot;^6.0.12.20240917&quot;<br>+types-pyyaml =3D &quot;^6.0=
.12.20260518&quot;</div><div><br></div><div>What is being done broadly? All=
 dependencies covered by poetry are being updated? or just the subset inclu=
ded in format checks? Are dependencies being brought to current latest or s=
omething different?</div><div><br></div><div>I remember Thomas mentioning t=
hat DTS was not checking the dts-check-format.sh at DPDK Summit and that co=
nfused me. Perhaps he is running DTS and dts-check-format.sh outside of poe=
try (which we have said is okay to do) and he is on newer versions of the f=
ormatting dependencies than what we currently have committed to the poetry.=
lock.</div></div>

--000000000000b538720654f35e7b--
