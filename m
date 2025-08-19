Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60224CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 18:57:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80D9040662;
	Tue, 19 Aug 2025 20:57:20 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 57EF7402EB
 for <dev@dpdk.org>; Tue, 19 Aug 2025 20:57:18 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2445806d44fso47125915ad.1
 for <dev@dpdk.org>; Tue, 19 Aug 2025 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755629837; x=1756234637; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6RDj09zT3oih/LTW5kV2JV0gkbSIvvKorrLkkkzRG0Y=;
 b=g5nIsqZ63FBrCgeabUcvTgxSDTPLcYr6OFFOXW2mntoCIbD6Ldut23SRDE9pZqWs7a
 vYGM/mEzorLOTl0MGObfq2Et4ITyzMzQiTxKQ4fBv0G6gIkjg6ZP2nSvXPBTuB6LOaJJ
 SIQ6WtYP2WRwxCbUEaf2Kuf9aQVDR5XoxdAto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755629837; x=1756234637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6RDj09zT3oih/LTW5kV2JV0gkbSIvvKorrLkkkzRG0Y=;
 b=RIFzXPsfF32B03ZrAiW/dP5h0cb5H3avEVdSJECCj/diJUCxzK5aKjNIaDqk2zFL+Q
 FMXVqWVXqG1GQ148mTTA1v5AAG+uBX6tDa2R9c3VpEmH9JxTQN9wV5DRpV2cVWcj5blX
 AK7Oo0EOTgMhMBj+2GniQ1j8xM0BzPHI/ddodLLA0B3EGoWEqtSCLeBRDy2vfwH4XgRP
 KU1BXoNIVTtlauXG8Cy7vRASucZfl4cX7oA2gZnHiM4tP2lGcorvYuRPIg5Z5nyfvJue
 RobDBza2peGpbt+1XRz+cT0ja5tEhlXaqWD/2HtGPP+k9+Q0d/oTgUIGGsv27uv6kEHk
 Eybw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLQz6wAuEpFWv+ufjAbASnsOux8UzQ+jP30yGpUD1z5v7f3rWWnaQrsvs9Bw7KFQoSy9I=@dpdk.org
X-Gm-Message-State: AOJu0YyaLi67nEb68qv+In9EoGDftICnRCURCsuBW217ZZmjq6kRwys2
 zKLUPFPTfi2YC8PiIOxXFdUGAfqiBpJK1aT1X482D4Xd1fd2kZ23OrFHPTHNxDWSl0yKUQO0rdy
 ertiDcfrdYETxRvDeieZKt02/YVaTopij2llJiyZTlQ==
X-Gm-Gg: ASbGncvZaJAa3inIdlOa6s+5/VIhfz39807GzcCy3H9Dgn7PBZgIzliwcBztIpSVKVw
 PFW4Oqql3m/Q8qf0LDiuJKNdrpBBZ8RQ8TwrO0Rs7wNCo3yYdGLZ8aOF6Ok0H1ZMGiZjJ/Kl00j
 EVS6Zw567Vm9zFx9ju9BkCZ6fafSODqN0rtQcmLH4sR4KmsryzyFnUuEMsWY0RNbUwriITvB8Sw
 90A0N53deGkuP6UxY6L/uT0Wmw+6EN2EaSlaeinEGM5RgRXSIw=
X-Google-Smtp-Source: AGHT+IFkXir3uUk56QKNI3Ho2qCoxSaihfePZ/rSrAiD2kyxUymAX0WXM7XRV13M5I99G4lpmOAcaLY+THI0dwuZMgA=
X-Received: by 2002:a17:902:ecce:b0:243:47:f61b with SMTP id
 d9443c01a7336-245ef239393mr594525ad.45.1755629837323; Tue, 19 Aug 2025
 11:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
 <PAWPR08MB89094F996EAC0988995DE9899F802@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <CAJvnSUD6tKB8xjiSMD7Ompy4TMGL__X682z_pNDbKAK54Vv+Lw@mail.gmail.com>
 <AS8PR08MB73396AB179C12ACDCBA214B5E593A@AS8PR08MB7339.eurprd08.prod.outlook.com>
 <AS8PR08MB733911AE8B83C45AFF3632BFE59FA@AS8PR08MB7339.eurprd08.prod.outlook.com>
 <CAJvnSUA9YPmxv_7RF6=zoM-LKPGTRy1Eppswf9qds1BcojpZ9Q@mail.gmail.com>
In-Reply-To: <CAJvnSUA9YPmxv_7RF6=zoM-LKPGTRy1Eppswf9qds1BcojpZ9Q@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 19 Aug 2025 14:50:47 -0400
X-Gm-Features: Ac12FXwKRWGGwOPtRWcd5PSYFbfOU0IGRlrDY27-BuB4-H_hftIcd3YdDFUfUDw
Message-ID: <CAJvnSUDT=yq4jQ03_XTEicsbh28WGvtTd5HUaTY7W6Si_5vSqQ@mail.gmail.com>
Subject: Re: meson error on ARM Grace server 23.11/22.11
To: Doug Foster <Doug.Foster@arm.com>
Cc: "ci@dpdk.org" <ci@dpdk.org>, dev <dev@dpdk.org>, 
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
 "stable@dpdk.org" <stable@dpdk.org>, nd <nd@arm.com>, 
 Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>,
 Luca Boccassi <bluca@debian.org>
Content-Type: multipart/alternative; boundary="000000000000cfa87b063cbc6cb8"
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

--000000000000cfa87b063cbc6cb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see Luca just sent a new version of 22.11 which includes the Grace build
patch, so this build "issue" should now be resolved for his tree. I hope we
will see the same patch reach 23.11 soon. :)

Thanks for doing this Doug and Luca.

On Tue, May 20, 2025 at 1:15=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Hi Doug,
>
> Without overburdening you with details, at the CI lab we have some tests
> which run with werror=3Dtrue (treat warnings as errors) and some which ru=
n
> without it. The tests which I'm currently trying to extend to LTS for Gra=
ce
> do not have this flag included, i.e. they are tolerant to warnings. So, w=
e
> should be good to proceed with your patch.
>
> Although no warnings on 22.11 and 23.11 would open us up to adding
> werror=3Dtrue build tests directly on Grace in the future, there isn't an=
 ask
> for this right now and I don't think we will need to support it. So, agai=
n
> I think we can proceed with your patch as is.
>
> Thanks for handling this.
>
> On Tue, May 20, 2025 at 1:00=E2=80=AFPM Doug Foster <Doug.Foster@arm.com>=
 wrote:
>
>> Hi Patrick,
>>
>> While building 22.11 and 23.11 with GCC 13.3, I noticed compiler warning=
s
>> related to memcpy usage, specifically involving __builtin___memcpy_chk
>> failures.
>> Would these warnings be a concern for CI test runs, or are they generall=
y
>> tolerated?
>>
>> From: Doug Foster
>> Sent: Friday, May 16, 2025 12:16 AM
>> To: Patrick Robb <probb@iol.unh.edu>; Wathsala Wathawana Vithanage <
>> wathsala.vithanage@arm.com>
>> Cc: ci@dpdk.org; dev <dev@dpdk.org>; Honnappa Nagarahalli <
>> Honnappa.Nagarahalli@arm.com>; stable@dpdk.org; nd <nd@arm.com>
>> Subject: RE: meson error on ARM Grace server 23.11/22.11
>>
>> Hi Patrick,
>>
>> I will produce the patches with necessary changes to build on Grace for
>> 22.11 and 23.11.
>>
>> From: Patrick Robb <mailto:probb@iol.unh.edu>
>> Sent: Thursday, May 15, 2025 3:59 PM
>> To: Wathsala Wathawana Vithanage <mailto:wathsala.vithanage@arm.com>
>> Cc: mailto:ci@dpdk.org; dev <mailto:dev@dpdk.org>; Honnappa Nagarahalli
>> <mailto:Honnappa.Nagarahalli@arm.com>; mailto:stable@dpdk.org; Doug
>> Foster <mailto:Doug.Foster@arm.com>; nd <mailto:nd@arm.com>
>> Subject: Re: meson error on ARM Grace server 23.11/22.11
>>
>> Thanks Wathsala,
>>
>> How can we help on the UNH side? Do you want us to produce the 22.11 and
>> 23.11 diffs/patches, which would be based on d007038, with some
>> modifications based on what you had said to Doug?
>>
>> I'm not sure what the process looks like exactly for providing backports
>> to LTS maintainers.
>>
>> On Tue, Apr 29, 2025 at 12:00=E2=80=AFPM Wathsala Wathawana Vithanage <m=
ailto:
>> wathsala.vithanage@arm.com> wrote:
>> > Hi,
>> >
>> > At the DPDK Community Lab we have been running CI tests with a new ARM
>> > Grace server for the past couple of months on main and next-* branches=
.
>> I am
>> > trying to add LTS runs now, and ran into a snag with 23.11 and 22.11
>> for this
>> > system. Stable maintainers I'm not sure whether this should be
>> addressed or not
>> > for hardware which is new and didn't exist when 22.11 and 23.11 were
>> > released... but I figured I'd make the tickets and find out. I attache=
d
>> the meson
>> > logs to the tickets and if for whatever reason you guys want to remote
>> into this
>> > machine, I'm happy to setup the VPN and SSH access.
>> >
>> > 22.11: https://bugs.dpdk.org/show_bug.cgi?id=3D1703
>> > 23.11: https://bugs.dpdk.org/show_bug.cgi?id=3D1702
>>
>> +doug
>>
>> neoverse-v2 is supported in the GCC 13.3 used for this build although
>> -mtune/-mcpu
>> for grace is not available in that version.
>> Adding neoverse-v2 and soc_grace with crypto extension should bring thes=
e
>> releases
>> on par with latest.
>> IMPORTANT NOTICE: The contents of this email and any attachments are
>> confidential and may also be privileged. If you are not the intended
>> recipient, please notify the sender immediately and do not disclose the
>> contents to any other person, use it for any purpose, or store or copy t=
he
>> information in any medium. Thank you.
>>
>

--000000000000cfa87b063cbc6cb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I see Luca just sent a new version of 22.11 which includes=
 the Grace build patch, so this build &quot;issue&quot; should=C2=A0now be =
resolved for his tree. I hope we will see the same patch reach 23.11 soon. =
:)<div></div><div><br></div><div>Thanks for doing this Doug and Luca.</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, May 20, 2025 at 1:15=E2=80=AFPM Patrick Robb =
&lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=
Hi Doug,=C2=A0<div><br></div><div>Without overburdening you with details, a=
t the CI lab we have some tests which run with werror=3Dtrue (treat warning=
s as errors) and some which run without it. The tests which I&#39;m current=
ly trying to extend to LTS for Grace do not have this flag included, i.e. t=
hey are tolerant to warnings. So, we should be good to proceed with your pa=
tch.</div><div><br></div><div>Although no warnings on 22.11 and 23.11 would=
 open us up to adding werror=3Dtrue build tests directly on Grace in the fu=
ture, there isn&#39;t an=C2=A0ask for this right now and I don&#39;t think =
we will need to support it. So, again I think we can proceed with your patc=
h as is.</div><div><br></div><div>Thanks for handling this.=C2=A0</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, May 20, 2025 at 1:00=E2=80=AFPM Doug Foster &lt;<a href=3D"mailto:Doug.=
Foster@arm.com" target=3D"_blank">Doug.Foster@arm.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Patrick,<br>
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
</blockquote></div>

--000000000000cfa87b063cbc6cb8--
