Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D16C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 21:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78E6A410FD;
	Thu, 15 May 2025 23:04:05 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id BF574410D0
 for <dev@dpdk.org>; Thu, 15 May 2025 23:04:04 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so1289620b3a.0
 for <dev@dpdk.org>; Thu, 15 May 2025 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747343043; x=1747947843; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9YosoUVA3AMXGmfrrIKB8zMOcWHxBkDHNoH7P64TDPI=;
 b=d7jWiAUEmXty4NgqeQ4vzucsowiNuIxUsjL8KPiB3ShciF6rJtTpunnHQwSWhZUqkh
 /xCcT6kvYN3ArjR3/6XyO218FloDRZDpq+WXX2zpdfk970GUCC5Zfex1j9kwB8PqiWAQ
 u0rdd/XA3rsmXChU+p1KDj+LfEmeXJlroLkxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747343043; x=1747947843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9YosoUVA3AMXGmfrrIKB8zMOcWHxBkDHNoH7P64TDPI=;
 b=sy/okFwUWqSVk9vjnphbOhMIsss2/jPXOnsEcBK/uzDzBHvQb0FYgdV5AX6tyS9eNo
 RhpmaBG4pVJTSzIHjV0I0ZPXoQwO7gbEirUn7RyNVPceSAUlNZ18RLqSjvX6ntSDBni2
 IcbGQgtnmmFWJsIhpg8IHZsTPNsxqPn2dELPJDewTxGGiearY/B6/BrRawtIewoXLP+Z
 GWfnZLbetgfgg552lJLvjvqbN5kvVyHJWm+BwcLBZlL/4avMp1DJWEMVIeKNnu9pmmQc
 E6JfP8rOmmTIMGXM5XxeFmprqIMTwkTR5jcHHgqP25NONxjYERPYIinLtfjuogGe9mQP
 Uz9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMudsdg0JBsI38KOEri78A6veA2Yr46vnPRyo9Q0KgoK/vQRL8pPTzw6h0gu4enycAsh8=@dpdk.org
X-Gm-Message-State: AOJu0Yw/dxpSv6+pbY5wG1kLsTtI6TtWFx+wHC9/4dLyRnPK681nYg4Y
 9W3y4XhKaAsL4LBFXv2M5yED9/D7KI7LxG20Cwc7nJVTjHSLfzIiciTxq8barLG4qLh3CI0tgPJ
 5yJbCrampIz9USl1lXk8C5apIkd5mjqTs2nGi8qVi2w==
X-Gm-Gg: ASbGnculsk7ihudVfPG5S36VDKVQNZF+IbR0Yp97snX/KX7fPHJl8vF6BUiacjvw0pg
 TvF8inwttYMiyf8f4d0Q7o+D/fjTs7uxWUQzt48+KH0f6kQ67sasnq3qQSsmgierBK6ylhORUlK
 5AsRd3Qd5gtZjnOF64nNw7NMn0BVFJC/GwGJzJ649Gqr4Pb87m6Y14Tz9fgPRvQzGkdw==
X-Google-Smtp-Source: AGHT+IGjzTf/UygCl9zynUrjTrQgoX5OpdQCx8tKKDK+yJg8LOmcXcsyWA5hWk9trmM03yXoN0rJReJx/gOg3JjEST0=
X-Received: by 2002:a17:903:1988:b0:22e:6cc6:cf77 with SMTP id
 d9443c01a7336-231d45d938cmr10233375ad.53.1747343043491; Thu, 15 May 2025
 14:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
 <PAWPR08MB89094F996EAC0988995DE9899F802@PAWPR08MB8909.eurprd08.prod.outlook.com>
In-Reply-To: <PAWPR08MB89094F996EAC0988995DE9899F802@PAWPR08MB8909.eurprd08.prod.outlook.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 15 May 2025 16:59:20 -0400
X-Gm-Features: AX0GCFufa7of8YsQyJeVT5xDFSPe3psdqfHxz-uIHzzIUdy05gzbQ7VFaTISA7A
Message-ID: <CAJvnSUD6tKB8xjiSMD7Ompy4TMGL__X682z_pNDbKAK54Vv+Lw@mail.gmail.com>
Subject: Re: meson error on ARM Grace server 23.11/22.11
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
Cc: "ci@dpdk.org" <ci@dpdk.org>, dev <dev@dpdk.org>, 
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
 "stable@dpdk.org" <stable@dpdk.org>, 
 Doug Foster <Doug.Foster@arm.com>, nd <nd@arm.com>
Content-Type: multipart/alternative; boundary="000000000000688c6806353301df"
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

--000000000000688c6806353301df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Wathsala,

How can we help on the UNH side? Do you want us to produce the 22.11 and
23.11 diffs/patches, which would be based on d007038, with some
modifications based on what you had said to Doug?

I'm not sure what the process looks like exactly for providing backports to
LTS maintainers.

On Tue, Apr 29, 2025 at 12:00=E2=80=AFPM Wathsala Wathawana Vithanage <
wathsala.vithanage@arm.com> wrote:

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
>
>
>

--000000000000688c6806353301df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Wathsala, <br></div><div><br></div><div>How ca=
n we help on the UNH side? Do you want us to produce the 22.11 and 23.11 di=
ffs/patches, which would be based on d007038, with some modifications based=
 on what you had said to Doug?</div><div><br></div><div>I&#39;m not sure wh=
at the process looks like exactly for providing backports to LTS maintainer=
s.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Apr 29, 2025 at 12:00=E2=80=AFPM Wath=
sala Wathawana Vithanage &lt;<a href=3D"mailto:wathsala.vithanage@arm.com">=
wathsala.vithanage@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">&gt; Hi,<br>
&gt; <br>
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
&gt; <br>
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
on par with latest. <br>
<br>
<br>
</blockquote></div>

--000000000000688c6806353301df--
