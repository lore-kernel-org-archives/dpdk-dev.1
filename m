Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D5CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E470640E0C;
	Tue, 20 Jan 2026 17:26:56 +0100 (CET)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 14C8D4026F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 17:26:56 +0100 (CET)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124566b6693so7809007c88.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 08:26:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768926415; cv=none;
 d=google.com; s=arc-20240605;
 b=jqzlmmwMd0+NLvoNCK7lKOwdXroI1LaG7UJjrliqEKpCqcOiLedPt1el97xtg0ZyL4
 PX2fZZQEruaRGUHdJim/+pVHBDKrfetsz/VFKa//aoLFHbDUiWvSiQxUOrIDUvoY0Mdn
 dLgkg8lXAU4dMPXVVyt+If9D6iYiVy8iRcbeI86+YpJYfA+vz7kuA0srzQd2MvnEsnC/
 RCpFfJTYSOR8iX/yBw9mMJT34Di3kEALkW+WbheZvwnNAQlf0AePMZnI7htSNANwsz22
 NIwX5Ab+X/dICqgC7EpkCsqcxD4yhjwdV1EdjZ6Z9YsCanYtjVKaiWLfNpWOFf41C0Sy
 MM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bVb0v2tYJraTH8Vj//2sKzXqx167EHtJID3bTGxG06E=;
 fh=i3/DvSCn0z+PdnmPUleGuFt/9DHlL8B0vL1zy1wKVfs=;
 b=e+0OcoG5bSjn7DpUVln2B+xjnYOrl0gWvGwkr9XxMNs3xeQoh1rqhlaxj/My3AyqZv
 ro0smYVFRwjbdt7PpUA4PuJQ45tNrAST0cPeLpyyA4zvxzNnOAFGt4nR6XbVmSx5UrkC
 hlc0DcCEhaYD35xS1DKIc4K2w3Xfk/RmZpVZ6xwumxbhXbSuxEX+uesjQFM70NFyRG6D
 OT+q4+1Dt/9EXKK7/h4jaTzjGkQOM4a7X6q9vbXVtKyHocYbc9MhRQ2hvm3gQvNWEuFm
 a7ofyvq+5e8K3tgS9em5s7HlBx4DA7tscpqHpPoE+VWcp/MCzl5Zozr4avHWpUCxp+Pg
 MnCA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768926415; x=1769531215; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bVb0v2tYJraTH8Vj//2sKzXqx167EHtJID3bTGxG06E=;
 b=GE+MqnaqDsni3vn+T6/y3tJaJ8kycuL8W+Nq+zO3ssqgnTcvm9fjT76idCdwd5l/XK
 MZ/Cx8/sjcnxuJoAtzyl54+g3WWjKz+2uWz4Qd9rNt0MI3vUzHO7JhgrCZ1ORu9NzNqK
 oBZeW8JEIZ4Q6HDO7GAuJxSDuu3d32ik5nhWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768926415; x=1769531215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVb0v2tYJraTH8Vj//2sKzXqx167EHtJID3bTGxG06E=;
 b=eM3DGLxH36n+TsByqnlM168nYSL1X/6I69Maj7sR96XLVRbFfDorWGcinNyq6ss0FG
 rKDYhVUP9wwILKln21ToJFkyY4ie137aW8RDEgXpMw+h2BicnvFno996+rA8PcFUaawg
 DVz2p662TNWHV1G5Atv0Jo2A1+/NagSP/4wIWHuEVmw65AFEpPl6PWRiHpJphBFncGAQ
 5YmzqnW5f6kTDLtzGd13FNqj3Kk/ANevG5iqE5hNYAihbQLm+kfsmE2zNyOJQEPk0vo5
 t6wVdm4xGYutCzwQSRCh877kjNLCFzR+H+Iphyzx2hM3W61FDfxbMSWawLloWjEXynZc
 b86w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBgoL7T8ZcXGDpTAedglOvKIBeCsz3aBZ+w0Zt3xiO5aKnjTLCYs20L6N27zVP3L7q09o=@dpdk.org
X-Gm-Message-State: AOJu0YxBuDqgmrO6T6Uh2AtbywOsMrf+YDjVgn5m03bKazNc8lfw05FQ
 Ye819ckvPb3Qp8eN5AU6pDOO4omXT0dCRc+B2M6DHlyDjxitya6ul+qYfvuknrXKiqyj/Q9Si+a
 5vUTMqMEU36WEwlGe0nJRJq1OvHniv8Dc4z1wkJPEwQ==
X-Gm-Gg: AY/fxX4mE5nPHI/HSvTolJJEzJJEI/6oyxHA1nrSMxDdru5qhsh6PJ+uUQTeChrUlvu
 IK/Ot8TgbnC4BObpra/+fF3XdelZqToKGwaUa5QXZ8K/s3jVbez3jr2sqKMbmr9bjSbHhupMwh/
 0ZAYwcGS5Wt4ktt0Nx8lYYoIg6lyR5y+RLAFUHyGhYF2aWdmsQqU4ZppFbb9dbr8grYDMJ27bCB
 J3zytQNZvtY6jX2K+NYCuHRpZ3bD0cC5Kw5qW+g/WwIzkQJI3+Ba+qj5VD2/sNCIfVRj90jg0po
 IezfmSdP/CpeMr8w2q23TGvfw3gWGJ0yXDIw38dzTDSgmG1aVonO
X-Received: by 2002:a05:7022:b8f:b0:11a:4016:44a5 with SMTP id
 a92af1059eb24-1244b3706e1mr10157297c88.24.1768926414951; Tue, 20 Jan 2026
 08:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20260119104147.219027-1-bruce.richardson@intel.com>
 <20260119115607.225929-1-bruce.richardson@intel.com>
 <f7ttswgxvzi.fsf@redhat.com>
In-Reply-To: <f7ttswgxvzi.fsf@redhat.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 20 Jan 2026 11:24:38 -0500
X-Gm-Features: AZwV_Qj68_7DT0Kgs-f2mBQvfeSfDBVvEkPt3kF0tVZxyAJIHLBu7-ToTZXZF8A
Message-ID: <CAJvnSUCyNA2UmS_tYzC=Y6+w107e0V=cbsvzzyb+gPyAZ1Cqog@mail.gmail.com>
Subject: Re: [PATCH v2] ci: improve logging of unit tests runs
To: Aaron Conole <aconole@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, ci@dpdk.org, 
 Matthew Labrecque <mlabrecque@iol.unh.edu>
Content-Type: multipart/alternative; boundary="00000000000098e55b0648d446d3"
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

--00000000000098e55b0648d446d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Aaron, Bruce,

Yes, we have our own build and unit test scripts in Jenkins that we should
update to align with the above.

Matt, please go ahead and add these flags and send a jenkins PR. The one
exception to this will be the special pipeline for running unit tests on
aarch32, since that needs to be run from dpdk-test directly, instead of
using meson test. So, you don't need to modify that aarch32 pipeline.

On Tue, Jan 20, 2026 at 8:19=E2=80=AFAM Aaron Conole <aconole@redhat.com> w=
rote:

> Bruce Richardson <bruce.richardson@intel.com> writes:
>
> > To help track down issues reported by CI test runs, add some additional
> > meson flags to the run of the fast-tests:
> >
> > --no-stdsplit:
> >   keep the stdout and stderr output interleaved, rather
> >   than separated in the logs, to make following what is happening durin=
g
> >   a test run easier.
> > --print-errorlogs:
> >   when an error with a unit test does occur, output to the terminal the
> >   last N lines of output. This allows us to see inline what may have
> >   failed without always needing to check log files.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> > V2: Drop max-lines flag, since it's only introduced in very recent meso=
n
> >     versions.
> > ---
>
> Thanks for working on this.  I guess when we bump our meson support
> version we could re-introduce the max-lines flag (looks like it was
> added in 1.5.0 based on reading the notes).
>
> Acked-by: Aaron Conole <aconole@redhat.com>
>
> CC'ing Patrick and the CI list - just in case any of the labs have any
> special processing when they pull error logs.
>
>

--00000000000098e55b0648d446d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Aaron, Bruce,=C2=A0<div><br></div><div>Yes, we have=
 our own build and unit test scripts=C2=A0in Jenkins that we should update =
to align with the above.</div><div><br></div><div>Matt, please go ahead and=
 add these flags and send a jenkins PR. The one exception to this will be t=
he special pipeline for running unit tests on aarch32, since that needs to =
be run from dpdk-test directly, instead of using meson test. So, you don&#3=
9;t need to modify that aarch32 pipeline.</div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Jan 20, 2026 at 8:19=E2=80=AFAM Aaron Conole &lt;<a href=3D"mailto:aconol=
e@redhat.com">aconole@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Bruce Richardson &lt;<a href=3D"mailto:bru=
ce.richardson@intel.com" target=3D"_blank">bruce.richardson@intel.com</a>&g=
t; writes:<br>
<br>
&gt; To help track down issues reported by CI test runs, add some additiona=
l<br>
&gt; meson flags to the run of the fast-tests:<br>
&gt;<br>
&gt; --no-stdsplit:<br>
&gt;=C2=A0 =C2=A0keep the stdout and stderr output interleaved, rather<br>
&gt;=C2=A0 =C2=A0than separated in the logs, to make following what is happ=
ening during<br>
&gt;=C2=A0 =C2=A0a test run easier.<br>
&gt; --print-errorlogs:<br>
&gt;=C2=A0 =C2=A0when an error with a unit test does occur, output to the t=
erminal the<br>
&gt;=C2=A0 =C2=A0last N lines of output. This allows us to see inline what =
may have<br>
&gt;=C2=A0 =C2=A0failed without always needing to check log files.<br>
&gt;<br>
&gt; Signed-off-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson=
@intel.com" target=3D"_blank">bruce.richardson@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; V2: Drop max-lines flag, since it&#39;s only introduced in very recent=
 meson<br>
&gt;=C2=A0 =C2=A0 =C2=A0versions.<br>
&gt; ---<br>
<br>
Thanks for working on this.=C2=A0 I guess when we bump our meson support<br=
>
version we could re-introduce the max-lines flag (looks like it was<br>
added in 1.5.0 based on reading the notes).<br>
<br>
Acked-by: Aaron Conole &lt;<a href=3D"mailto:aconole@redhat.com" target=3D"=
_blank">aconole@redhat.com</a>&gt;<br>
<br>
CC&#39;ing Patrick and the CI list - just in case any of the labs have any<=
br>
special processing when they pull error logs.<br>
<br>
</blockquote></div>

--00000000000098e55b0648d446d3--
