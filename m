Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B4C87FCA
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 15:34:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84C7C40659;
	Tue, 29 Jul 2025 17:34:33 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 7CDA340658
 for <dev@dpdk.org>; Tue, 29 Jul 2025 17:34:32 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3137c2021a0so4885200a91.3
 for <dev@dpdk.org>; Tue, 29 Jul 2025 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753803271; x=1754408071; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GaegzWxWQq0pdyatFqBUOKqDY7bnvvNY0iDltw3FYUI=;
 b=LmYg7evjYmyC6qicI4BJRW4AxafH7JXmN32Ino2ysKjnhDWp+EkzIokW12rTxPyaz9
 cdFmlDNrqpfFDkqDZ2qyIVJInTOWgJpkE9mz/AJjeS/7Uhsexg0/vIAbqzagBLQYUisr
 tTcGMnaziLYi3RG82D0UNS6ey4Jg2LEsvwVQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753803271; x=1754408071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GaegzWxWQq0pdyatFqBUOKqDY7bnvvNY0iDltw3FYUI=;
 b=Cb62r3KzunzqttYiBaFKTSoTTmU5/jRjQQDhjBf9XIPu2m1Aka3C2Cx9Vaqqi3lDK3
 vHCgXD2W9LW4+mfaaMW25cAXxl10Tt6NXZ3GLFugUvMjZ+FGRbhSkwnSuCHrrAXLLuDq
 umOWjc1sToXAvgqHkGBPj6CvYxx4+GSfPE8w2oZKats/esiCQqmANGcZ1biag3BPssh7
 gxRNDW7sd/oPU29j/GJXEEazwgvu2jtVDf/HmvBSRa08LQlfwbH3nDb0rgnw3aMPrGpG
 m9ypQ7f4jMdz35GN0vAHkMUOsh26i+GnXQXZOObgcK/XXIeJBg+zX7lNLeH8AMg5WXWa
 K9gA==
X-Gm-Message-State: AOJu0YwMHZS+4IShf318NurEypLF6Jt97qn6LFuf7ofAoIEOkhfOCtB2
 b4ptpg3WTodNCqIi1WngXt/XN/knEcSn2HeDrjpmQPscZHiP+cyHuaCubQmtcrDMwRCaElmdMxp
 HpSFtHsL4vtJPxBFq1bX6HplgbaOHwUbTQgZtcAs8jFAuK/L1kLBB
X-Gm-Gg: ASbGncuOryw8B5NDd35vgTqymgnlzTzSnv0Ou5b40eslGInnVggowwzH+ffJiJ4cM5b
 p2lGD9x9iwNSi3W0IwhcMOh4Z25PQ85uWRR4FFLMKBJGuTWK5RHBvybDGfuSejreV5B1iqeG6EA
 X8DVuz9iSOpIA8o6SCjOGYhZWWW3IsUWgA6Un3a28kQt77oC2akGG2JB+4eTFjUzUb/RKUPBX4y
 m2CtUujeQ==
X-Google-Smtp-Source: AGHT+IFbSe6NoLs57zn93tOoWhR+KbqwtR14aiUC6kL4xKSPSVJyYBqNPzPhImRs+N32Jy1dA9pXnLUmWhucs3W7N1E=
X-Received: by 2002:a17:90b:3c85:b0:31e:ff97:75a1 with SMTP id
 98e67ed59e1d1-31eff97767cmr9051377a91.3.1753803270446; Tue, 29 Jul 2025
 08:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250725200553.1262542-1-probb@iol.unh.edu>
 <20250728213209.1834486-1-probb@iol.unh.edu>
 <f80063c1-a5a9-43c5-8284-4e1b2dfc8fef@arm.com>
 <CAJvnSUAmXTUH4qxHarwThXKFRE9PvbP5voXR_N1EpvfUHRpxdg@mail.gmail.com>
In-Reply-To: <CAJvnSUAmXTUH4qxHarwThXKFRE9PvbP5voXR_N1EpvfUHRpxdg@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 29 Jul 2025 11:28:24 -0400
X-Gm-Features: Ac12FXzPwWsErKXBySdVxM1lyfLgGmgFoMt0tA1TTN3OVMLqX-6aaLxE8AxQtDs
Message-ID: <CAJvnSUCRYux06-7bTF0TJsJ+4pzrnW=yHP7cWJV9Cgo4C+1BSA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: call hugepages configure at node setup
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f0f476063b1324ad"
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

--000000000000f0f476063b1324ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Actually, Luca is going to fixup this commit, pulling the function down to
the node setup method, and push to next-dts.

On Tue, Jul 29, 2025 at 9:20=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> ... Woops.
>
> Will send the correction later today.
>
> On Tue, Jul 29, 2025 at 5:50=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.=
com>
> wrote:
>
>> Hi Patrick,
>>
>> thank you for the quick v2! I am afraid you may have placed the call in
>> the class constructor instead of the setup method :')
>>
>> Luca
>>
>

--000000000000f0f476063b1324ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Actually, Luca is going to fixup this commit, pulling the =
function down to the node setup method, and push to next-dts.</div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, Jul 29, 2025 at 9:20=E2=80=AFAM Patrick Robb &lt;<a href=3D=
"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">... Woops.<div=
><br></div><div>Will send the correction later today.</div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 29, =
2025 at 5:50=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@a=
rm.com" target=3D"_blank">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi Patrick,<br>
<br>
thank you for the quick v2! I am afraid you may have placed the call in <br=
>
the class constructor instead of the setup method :&#39;)<br>
<br>
Luca<br>
</blockquote></div>
</blockquote></div>

--000000000000f0f476063b1324ad--
