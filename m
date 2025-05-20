Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1F0C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 17:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA1E640DD5;
	Tue, 20 May 2025 19:20:16 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 91F3E40DD5
 for <dev@dpdk.org>; Tue, 20 May 2025 19:20:15 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-af59c920d32so3794277a12.0
 for <dev@dpdk.org>; Tue, 20 May 2025 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747761614; x=1748366414; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TPdTVn2OvQhd/R2haD/e5W2a66WJHaNJ5qnizNUMJ4g=;
 b=FzFjcwN+opQylmKB0DXYUnGWWLim1ZLMtRPGSjBg5D96RIjvjSBpklRJWUg8+9fNfd
 P+laWhym62ceuuLhvV+g1PZU3KmlILuv5zwTkO5phUkug+rEzJzLZHXQLc8YnoUJUxiN
 6axnMYtFs5+r7+bBSAgbMigpGurBUw6PpMMgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747761614; x=1748366414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPdTVn2OvQhd/R2haD/e5W2a66WJHaNJ5qnizNUMJ4g=;
 b=RZg+0IYCDMljY828SGR2kE6nJbFkJZEUsyP1D5MOlizIteNN3Q67abjdrqrpphDKLu
 fqaoSM2Ngun09jYQOfD/hvufgIu7j9WtZz4KWzluWpA72HQjd2n9YwrYdekIVOrVOVnJ
 cJSRGQaCOd0TK5FHugMdZQALi1dY/bNBoWA++TU6zT9P78+S2LSlMxWEmUEfdGQeefMM
 rXve0bg+PnD7sVy8kCDeHF1Go55fEtPJRjTOiqOUZcWECbLPsWM5tPOJcKPWN/8cf0co
 EJY3zQvcKK+2hAzjDp1x7sWc/kwkLFDfe+u6wkdIb+R/sjHCWM9pk0Zw2reiXnIqGMbl
 IZOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvTHL1gt8uDusYynvB1BB9LIT1ICiRGqn8qHgqTFO1G4j6aSnabi+uo7vFHGZUP8SbJHE=@dpdk.org
X-Gm-Message-State: AOJu0YylAF20NCwsBkqRImt/6f/QLExc+9VP+qg23zwOHnk5p4StfcjI
 k+98ziAvGNdsXvaUptx0QwZxkq75oe/OWlnoVyi1sl69sj3BWQ6U/1wZ3lkMklNGG8m0Hsm+gFC
 r/x0wY/isgKGCNL6w31zTb7pcUFxDCe5MCQP0PERgPA==
X-Gm-Gg: ASbGncukz5PSaFlYGSECyZwmJXE2EI7r+f2BRaTopTlpkfMv5g5b5RQ6JO2NEyTCA+S
 q6l1oUahYxxKmll1EXFwUV1R/56lIasZGGBsr97Mtz/irzhcsrsEtz7vR+ylp70J982CKYo23WB
 yWhPiO/0nlknsikPwbZdtT7UqX1wiuf1fLegOxfcavyh4FBwy+zF5illSN0dJaZSuRMA==
X-Google-Smtp-Source: AGHT+IG5WMrMHXrckWVeS5rC2jfs4FduFIHSsziGVvSBeTYPkhKZDMhz0yVrB/qoXPzSwG22BeTbqFU+lXBor5Jgl3w=
X-Received: by 2002:a17:903:41cc:b0:223:325c:89de with SMTP id
 d9443c01a7336-231d43d9c96mr244563675ad.1.1747761614504; Tue, 20 May 2025
 10:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
 <PAWPR08MB89094F996EAC0988995DE9899F802@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <CAJvnSUD6tKB8xjiSMD7Ompy4TMGL__X682z_pNDbKAK54Vv+Lw@mail.gmail.com>
 <AS8PR08MB73396AB179C12ACDCBA214B5E593A@AS8PR08MB7339.eurprd08.prod.outlook.com>
 <AS8PR08MB733911AE8B83C45AFF3632BFE59FA@AS8PR08MB7339.eurprd08.prod.outlook.com>
In-Reply-To: <AS8PR08MB733911AE8B83C45AFF3632BFE59FA@AS8PR08MB7339.eurprd08.prod.outlook.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 20 May 2025 13:15:27 -0400
X-Gm-Features: AX0GCFuPuqUnkBAjWXhXZOtPzf-ck_fwqFc0ekoabksQDXuoog2MT5eplK4bMXQ
Message-ID: <CAJvnSUA9YPmxv_7RF6=zoM-LKPGTRy1Eppswf9qds1BcojpZ9Q@mail.gmail.com>
Subject: Re: meson error on ARM Grace server 23.11/22.11
To: Doug Foster <Doug.Foster@arm.com>
Cc: "ci@dpdk.org" <ci@dpdk.org>, dev <dev@dpdk.org>, 
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
 "stable@dpdk.org" <stable@dpdk.org>, nd <nd@arm.com>, 
 Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
Content-Type: multipart/alternative; boundary="0000000000002f65590635947668"
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

--0000000000002f65590635947668
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

Without overburdening you with details, at the CI lab we have some tests
which run with werror=3Dtrue (treat warnings as errors) and some which run
without it. The tests which I'm currently trying to extend to LTS for Grace
do not have this flag included, i.e. they are tolerant to warnings. So, we
should be good to proceed with your patch.

Although no warnings on 22.11 and 23.11 would open us up to adding
werror=3Dtrue build tests directly on Grace in the future, there isn't an a=
sk
for this right now and I don't think we will need to support it. So, again
I think we can proceed with your patch as is.

Thanks for handling this.

On Tue, May 20, 2025 at 1:00=E2=80=AFPM Doug Foster <Doug.Foster@arm.com> w=
rote:

> Hi Patrick,
>
> While building 22.11 and 23.11 with GCC 13.3, I noticed compiler warnings
> related to memcpy usage, specifically involving __builtin___memcpy_chk
> failures.
> Would these warnings be a concern for CI test runs, or are they generally
> tolerated?
>
> From: Doug Foster
> Sent: Friday, May 16, 2025 12:16 AM
> To: Patrick Robb <probb@iol.unh.edu>; Wathsala Wathawana Vithanage <
> wathsala.vithanage@arm.com>
> Cc: ci@dpdk.org; dev <dev@dpdk.org>; Honnappa Nagarahalli <
> Honnappa.Nagarahalli@arm.com>; stable@dpdk.org; nd <nd@arm.com>
> Subject: RE: meson error on ARM Grace server 23.11/22.11
>
> Hi Patrick,
>
> I will produce the patches with necessary changes to build on Grace for
> 22.11 and 23.11.
>
> From: Patrick Robb <mailto:probb@iol.unh.edu>
> Sent: Thursday, May 15, 2025 3:59 PM
> To: Wathsala Wathawana Vithanage <mailto:wathsala.vithanage@arm.com>
> Cc: mailto:ci@dpdk.org; dev <mailto:dev@dpdk.org>; Honnappa Nagarahalli
> <mailto:Honnappa.Nagarahalli@arm.com>; mailto:stable@dpdk.org; Doug
> Foster <mailto:Doug.Foster@arm.com>; nd <mailto:nd@arm.com>
> Subject: Re: meson error on ARM Grace server 23.11/22.11
>
> Thanks Wathsala,
>
> How can we help on the UNH side? Do you want us to produce the 22.11 and
> 23.11 diffs/patches, which would be based on d007038, with some
> modifications based on what you had said to Doug?
>
> I'm not sure what the process looks like exactly for providing backports
> to LTS maintainers.
>
> On Tue, Apr 29, 2025 at 12:00=E2=80=AFPM Wathsala Wathawana Vithanage <ma=
ilto:
> wathsala.vithanage@arm.com> wrote:
> > Hi,
> >
> > At the DPDK Community Lab we have been running CI tests with a new ARM
> > Grace server for the past couple of months on main and next-* branches.
> I am
> > trying to add LTS runs now, and ran into a snag with 23.11 and 22.11 fo=
r
> this
> > system. Stable maintainers I'm not sure whether this should be addresse=
d
> or not
> > for hardware which is new and didn't exist when 22.11 and 23.11 were
> > released... but I figured I'd make the tickets and find out. I attached
> the meson
> > logs to the tickets and if for whatever reason you guys want to remote
> into this
> > machine, I'm happy to setup the VPN and SSH access.
> >
> > 22.11: https://bugs.dpdk.org/show_bug.cgi?id=3D1703
> > 23.11: https://bugs.dpdk.org/show_bug.cgi?id=3D1702
>
> +doug
>
> neoverse-v2 is supported in the GCC 13.3 used for this build although
> -mtune/-mcpu
> for grace is not available in that version.
> Adding neoverse-v2 and soc_grace with crypto extension should bring these
> releases
> on par with latest.
> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose the
> contents to any other person, use it for any purpose, or store or copy th=
e
> information in any medium. Thank you.
>

--0000000000002f65590635947668
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Doug,=C2=A0<div><br></div><div>Without overburdening yo=
u with details, at the CI lab we have some tests which run with werror=3Dtr=
ue (treat warnings as errors) and some which run without it. The tests whic=
h I&#39;m currently trying to extend to LTS for Grace do not have this flag=
 included, i.e. they are tolerant to warnings. So, we should be good to pro=
ceed with your patch.</div><div><br></div><div>Although no warnings on 22.1=
1 and 23.11 would open us up to adding werror=3Dtrue build tests directly o=
n Grace in the future, there isn&#39;t an=C2=A0ask for this right now and I=
 don&#39;t think we will need to support it. So, again I think we can proce=
ed with your patch as is.</div><div><br></div><div>Thanks for handling this=
.=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, May 20, 2025 at 1:00=E2=80=AFPM Doug Foster &lt;<a hre=
f=3D"mailto:Doug.Foster@arm.com" target=3D"_blank">Doug.Foster@arm.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Pa=
trick,<br>
<br>
While building 22.11 and 23.11 with GCC 13.3, I noticed compiler warnings r=
elated to memcpy usage, specifically involving __builtin___memcpy_chk failu=
res.<br>
Would these warnings be a concern for CI test runs, or are they generally t=
olerated?<br>
<br>
From: Doug Foster<br>
Sent: Friday, May 16, 2025 12:16 AM<br>
To: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank"=
>probb@iol.unh.edu</a>&gt;; Wathsala Wathawana Vithanage &lt;<a href=3D"mai=
lto:wathsala.vithanage@arm.com" target=3D"_blank">wathsala.vithanage@arm.co=
m</a>&gt;<br>
Cc: <a href=3D"mailto:ci@dpdk.org" target=3D"_blank">ci@dpdk.org</a>; dev &=
lt;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a>&gt;; =
Honnappa Nagarahalli &lt;<a href=3D"mailto:Honnappa.Nagarahalli@arm.com" ta=
rget=3D"_blank">Honnappa.Nagarahalli@arm.com</a>&gt;; <a href=3D"mailto:sta=
ble@dpdk.org" target=3D"_blank">stable@dpdk.org</a>; nd &lt;<a href=3D"mail=
to:nd@arm.com" target=3D"_blank">nd@arm.com</a>&gt;<br>
Subject: RE: meson error on ARM Grace server 23.11/22.11<br>
<br>
Hi Patrick,<br>
<br>
I will produce the patches with necessary changes to build on Grace for 22.=
11 and 23.11.<br>
<br>
From: Patrick Robb &lt;mailto:<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
Sent: Thursday, May 15, 2025 3:59 PM<br>
To: Wathsala Wathawana Vithanage &lt;mailto:<a href=3D"mailto:wathsala.vith=
anage@arm.com" target=3D"_blank">wathsala.vithanage@arm.com</a>&gt;<br>
Cc: mailto:<a href=3D"mailto:ci@dpdk.org" target=3D"_blank">ci@dpdk.org</a>=
; dev &lt;mailto:<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk=
.org</a>&gt;; Honnappa Nagarahalli &lt;mailto:<a href=3D"mailto:Honnappa.Na=
garahalli@arm.com" target=3D"_blank">Honnappa.Nagarahalli@arm.com</a>&gt;; =
mailto:<a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org=
</a>; Doug Foster &lt;mailto:<a href=3D"mailto:Doug.Foster@arm.com" target=
=3D"_blank">Doug.Foster@arm.com</a>&gt;; nd &lt;mailto:<a href=3D"mailto:nd=
@arm.com" target=3D"_blank">nd@arm.com</a>&gt;<br>
Subject: Re: meson error on ARM Grace server 23.11/22.11<br>
<br>
Thanks Wathsala,<br>
<br>
How can we help on the UNH side? Do you want us to produce the 22.11 and 23=
.11 diffs/patches, which would be based on d007038, with some modifications=
 based on what you had said to Doug?<br>
<br>
I&#39;m not sure what the process looks like exactly for providing backport=
s to LTS maintainers.<br>
<br>
On Tue, Apr 29, 2025 at 12:00=E2=80=AFPM Wathsala Wathawana Vithanage &lt;m=
ailto:<a href=3D"mailto:wathsala.vithanage@arm.com" target=3D"_blank">waths=
ala.vithanage@arm.com</a>&gt; wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; At the DPDK Community Lab we have been running CI tests with a new ARM=
<br>
&gt; Grace server for the past couple of months on main and next-* branches=
. I am<br>
&gt; trying to add LTS runs now, and ran into a snag with 23.11 and 22.11 f=
or this<br>
&gt; system. Stable maintainers I&#39;m not sure whether this should be add=
ressed or not<br>
&gt; for hardware which is new and didn&#39;t exist when 22.11 and 23.11 we=
re<br>
&gt; released... but I figured I&#39;d make the tickets and find out. I att=
ached the meson<br>
&gt; logs to the tickets and if for whatever reason you guys want to remote=
 into this<br>
&gt; machine, I&#39;m happy to setup the VPN and SSH access.<br>
&gt;<br>
&gt; 22.11: <a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1703" rel=3D=
"noreferrer" target=3D"_blank">https://bugs.dpdk.org/show_bug.cgi?id=3D1703=
</a><br>
&gt; 23.11: <a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1702" rel=3D=
"noreferrer" target=3D"_blank">https://bugs.dpdk.org/show_bug.cgi?id=3D1702=
</a><br>
<br>
+doug<br>
<br>
neoverse-v2 is supported in the GCC 13.3 used for this build although -mtun=
e/-mcpu<br>
for grace is not available in that version.<br>
Adding neoverse-v2 and soc_grace with crypto extension should bring these r=
eleases<br>
on par with latest.<br>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.<br>
</blockquote></div>

--0000000000002f65590635947668--
