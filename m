Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F804CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 15:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50119402CB;
	Mon, 22 Sep 2025 17:46:50 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3437A402A9
 for <dev@dpdk.org>; Mon, 22 Sep 2025 17:46:49 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b5241e51764so3575199a12.1
 for <dev@dpdk.org>; Mon, 22 Sep 2025 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758556008; x=1759160808; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UTpuRbL3Z3N1xOfoEB0DGfuvu5hIzDuKDOu8Us2DiCE=;
 b=AfsbGnFmcd36FDwL3TM90P36j6rZUH+x0/dl8sraueWtxVuvfOdS/8zCrB2jv707me
 SzfpxHZqGtIRrHsv388W7ROe8pdvUnmfFTajuK+LEFW60SoxSXEVMZ33/NLGoI3nXloT
 8ATW7SdQ3WVjpBXOrDdB6hbb5fZ6hmWJquJbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556008; x=1759160808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTpuRbL3Z3N1xOfoEB0DGfuvu5hIzDuKDOu8Us2DiCE=;
 b=C/ZRZezxwqVlyWKxD3ejeY02sq4X89Rp05EIUMMJHurszUn5XP1ztI0VK1uezOG5lg
 K5VvRxm/bO4KMFqcwHtRrEFI3VzpjkDNGHECTVJlkZp5P4QUvoci3yO8eKLIVjx61A2L
 XcTKMAvLYUDlcwdnK+bbyI0TCuwtuyPdS5QuDz9AM9Xy3saDjmmUUY8kQ9C1xkfqwJpX
 BBpzbNgzUA+x8qqH9beMQLDs9JUtxpLu0xYi+DBkwGjnMzciCGc3xwYry/eKEoxuxxU/
 RsI+get+i8Hrhl7PiCSBHfaiGsm9/6pU418wT82XCeMR5Bzf5vYSHTAlhBRQ9wNVLnVP
 WIfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZQ+7X014o0bqx6YGSV0/I9UzBfP3AlauIkgVw0gmxnkyyQLNsbCDSyRSQgdtBE6II0/4=@dpdk.org
X-Gm-Message-State: AOJu0YxBwPpwKt0zisSL09kn73xk1B6zSAnkHwi4/7iYW7pbMzUe8dgu
 BQb4D7uc4oS+mFbkxObQ2rWbnF7SGw+anc+Tri3349a32Z9YZlf4NTgcOc98I0fE3G+AciFFfTK
 qejkdOp9MpVcnMBUFzw8QMVCyG6zeun2uyv7+A0pQjw==
X-Gm-Gg: ASbGncv2F9kmfZmvpZzeex5epVySAa55yAE3NAYBVLsePqCYwCoGC+h+9VhioYIok8Z
 CFYaH9hN++4AK6U9ZUHCrBZnNe+wCMbPC5tx+Gpr8FuF4aX8POLVGg4CXURQuljVD7ZEAVnOXkg
 nDO/7QDfLZOWSzWaZlDmb76Vp9hZlOT+WkQxZeqcxvgb8hZbMT+c61Vpw9X5YE4DyLy3tnhVtZv
 MMMnd8OO6estJeORIq4RA==
X-Google-Smtp-Source: AGHT+IHFo9CQRwkiGYnwwCGDVzFRjIDCyALR4zA5roxMeXvnXc0xBXvTRFQ3U6cIBpKspJDvzJtU1f/BX4QJXEwjazY=
X-Received: by 2002:a17:90b:1e12:b0:32e:ca03:3d6 with SMTP id
 98e67ed59e1d1-3309838d3bcmr13965673a91.36.1758556008151; Mon, 22 Sep 2025
 08:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250808182152.356879-2-abailey@iol.unh.edu>
 <20250910122749.8277-1-abailey@iol.unh.edu>
In-Reply-To: <20250910122749.8277-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 22 Sep 2025 11:46:27 -0400
X-Gm-Features: AS18NWAYg_xGi2GJ9GYAqtZKc5IwimycZXk40r4tSso0D41CqHUfKdbizgOAV6I
Message-ID: <CAJvnSUD5raC7qtXzD7v11wHR0r2XG4+5hm+UcCPo7H+Oa=QuFA@mail.gmail.com>
Subject: Re: [PATCH v5] dts: enable port binding on the TG
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000002f0ef6063f65ba2d"
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

--0000000000002f0ef6063f65ba2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:30=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Currently, ports on the TG are not bound to the correct drivers prior to
> running DTS. This causes DTS to crash if they are not initially bound to
> the intended drivers. Binding the TG ports to the proper driver caused
> DTS to fail when the OS and DPDK drivers were the same, due to the port
> link not being up.


This probably does not read very clearly to people not working on DTS. I
would be more "to the point" by saying something like "Currently, DTS will
not attempt to bind the TG interfaces to the kernel driver automatically,
meaning the user must manually verify the TG binding before running DTS.
Also, when the TG and DPDK drivers are the same, DTS will not automatically
attempt to bring up the link on the TG port. So, this change adds both of
these automatic steps for the TG."


> Changing the bound_for_dpdk method for a port to
> return false when the OS driver and DPDK driver were shared on a TG
> node allowed the TG ports to enter the logic to be brought up in the
> configure_ports method within the topology class.
>

I believe this is a carry over from your V3. The V4 and V5 patches do not
include this change to the bound_for_dpdk property.

Otherwise, the commit looks good, thank you! I will tweak the commit
message itself per my preferences above when I merge to next-dts.

--0000000000002f0ef6063f65ba2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 10,=
 2025 at 8:30=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.un=
h.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Currently, ports on the TG are not bound to the c=
orrect drivers prior to<br>
running DTS. This causes DTS to crash if they are not initially bound to<br=
>
the intended drivers. Binding the TG ports to the proper driver caused<br>
DTS to fail when the OS and DPDK drivers were the same, due to the port<br>
link not being up. </blockquote><div><br></div><div>This probably does not =
read very clearly to people not working on DTS. I would be more &quot;to th=
e point&quot; by saying something like &quot;Currently, DTS will not attemp=
t to bind the TG interfaces to the kernel driver automatically, meaning the=
 user must manually verify the TG binding before running DTS. Also, when th=
e TG and DPDK drivers are the same, DTS will not automatically attempt to b=
ring up the link on the TG port. So, this change adds both of these automat=
ic steps for the TG.&quot;=C2=A0</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Changing the bound_for_dpdk method for a port=
 to<br>
return false when the OS driver and DPDK driver were shared on a TG<br>
node allowed the TG ports to enter the logic to be brought up in the<br>
configure_ports method within the topology class.<br></blockquote><div><br>=
</div><div>I believe this is a carry over from your V3. The V4 and V5 patch=
es do not include this change to the bound_for_dpdk property.</div><div><br=
></div><div>Otherwise, the commit looks good, thank you! I will tweak the c=
ommit message itself per my preferences above when I merge to next-dts.</di=
v><div>=C2=A0</div></div></div>

--0000000000002f0ef6063f65ba2d--
