Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD86C369D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 03:53:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAE4D400D7;
	Fri, 25 Apr 2025 05:53:30 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 299F6400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 05:53:30 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so1423858a91.2
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745553209; x=1746158009; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/pEhgiw0kR6h9a2izDNFzNb+QV5osw2qyGN1GIur7rI=;
 b=ZhgH8hJcTl+MASwS3y5QolKql7DfTHSojL1uwf6+YXwHoQuhNWnTY7Y6jgw80PKe1J
 y/9eSJoj4db6Xz/dXIGWSkJJaXY8QxOJLQ2rEt1aaI4y+pweFW2Q9xKQPdcqQLib1RK/
 Z2+iT2HM7W7RHeHBQYZOXtUPWxKsVFI3kNHjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745553209; x=1746158009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/pEhgiw0kR6h9a2izDNFzNb+QV5osw2qyGN1GIur7rI=;
 b=QH8UK3TLpWUPhybxHFxElIiNIoxNSEeNY0Jwg3stO+BUwzeLXT9o1+oYeGXqED4otd
 hBhwmSscmJlazPcifgNZCxIO31GK4Am+Yl2Wno695UIhXTu4n/gQhGqWcymz+cTVN2qn
 7N0NSi6OcM4IdlSMoUJGIx94sriHJ0+FNIz0PRgbyU3sX8K3xtGClULoMlJCy/WVPwN4
 FJOh92FkAVIyTlbOVe4bQsPuL+tsQylBepRIde39Dtdy6up+L8EVCZ6CVSn+wZaY1g3r
 fM2JppNq9hFtQpU0zgK3ezCMpk7CxmFUwKTaDOfxg/oO9/buKkaOHM9mF4Kaq7uVYB6z
 Fb/w==
X-Gm-Message-State: AOJu0YwehMOqVGG0oQgps5agYm4maEcYMfeGyFy32Ztc/UbtjFEurkxK
 KbJQc/w8n0tvEf7tQCu8Xqr68LulFxMAosrRE2YX7jKM4l4QGO6YYCSaics4cqDR36XNvd4P6Pb
 ELlo+nS2+CfoyYejWhsINI9UKMjONZsaNkEENtw==
X-Gm-Gg: ASbGnctaabolZpIybAn24397kTOEfnfqOVGcivvtjGi1VvqA5UlhvskPNMarX36QI52
 nlqxX74Mxt0CqvFOYonJYrzW7/KQ+U4ycrltPptaCPqpEd/txI+9oewQFNAWP/lRIIt+3LwZgtt
 BdAwrc2BDC+2yGHc+UrYcuAnfvj4B+Za01Y/l5lw==
X-Google-Smtp-Source: AGHT+IHjQyvBuaF/sS068wD+yhDssdxCXWwkKgPS1vJKqI2onT8lEO+UZNm8cVvQ/ZrfYjXGKWK9Z7p2m+pF8N3JnnA=
X-Received: by 2002:a17:90b:1b48:b0:308:539d:7577 with SMTP id
 98e67ed59e1d1-309f7c70113mr2072194a91.0.1745553208813; Thu, 24 Apr 2025
 20:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-1-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 23:49:06 -0400
X-Gm-Features: ATxdqUHVxezheRUCo8W-MC1bFliW32XeiugFoC0ILe5sco3rroa35yq10xhHUgM
Message-ID: <CAJvnSUBH_LQD6hoaMLXoY3=51gK4cCiEAbZLEH=41a1zSKzaKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] dts: shell improvements
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000f2c20d06339246f3"
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

--000000000000f2c20d06339246f3
Content-Type: text/plain; charset="UTF-8"

Thanks for this series Luca. Dean did a review earlier and I have just done
one so we're almost good to proceed. I should probably apply it and do a
testrun before merging, which should be possible tomorrow (Friday).

I will flag that when I tried to apply the series, git complained of a sha1
issue:

Applying: dts: escape single quotes
Applying: dts: add blocking dpdk app class
Applying: dts: add shells pool
Applying: dts: revert back to a single InteractiveShell
error: sha1 information is lacking or useless
(dts/framework/remote_session/testpmd_shell.py).
error: could not build fake ancestor
Patch failed at 0004 dts: revert back to a single InteractiveShell

From a quick google, it sounds like this can happen when sharing
commits/patches across related repos, when one of the repos has rewritten
history. Maybe this is because sometimes dpdk mainline rewords commits and
then we hard reset off of that... or some other reason - not sure right
now. But in any case it sounds like it's benign and there are some
tricks/workarounds to apply it so it probably won't be an issue. If it is
I'll let you know. :)

Thanks.

--000000000000f2c20d06339246f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for this series Luca. Dean did a review earlier and=
 I have just done one so we&#39;re almost good to proceed. I should probabl=
y apply it and do a testrun before merging, which should be possible tomorr=
ow (Friday).<div><br></div><div>I will flag that when I tried to apply the =
series, git complained of a sha1 issue:=C2=A0</div><div><br></div><div>Appl=
ying: dts: escape single quotes<br>Applying: dts: add blocking dpdk app cla=
ss<br>Applying: dts: add shells pool<br>Applying: dts: revert back to a sin=
gle InteractiveShell<br>error: sha1 information is lacking or useless (dts/=
framework/remote_session/testpmd_shell.py).<br>error: could not build fake =
ancestor<br>Patch failed at 0004 dts: revert back to a single InteractiveSh=
ell<br><br></div><div>From a quick google, it sounds like this can happen w=
hen sharing commits/patches across related repos, when one of the repos has=
 rewritten history. Maybe this is because sometimes dpdk mainline rewords=
=C2=A0commits and then we hard reset off of that... or some other reason - =
not sure right now. But in any case it sounds like it&#39;s benign and ther=
e are some tricks/workarounds to apply it so it probably won&#39;t be an is=
sue. If it is I&#39;ll let you know. :)</div><div><br></div><div>Thanks.</d=
iv><div><br></div></div>

--000000000000f2c20d06339246f3--
