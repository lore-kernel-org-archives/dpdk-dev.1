Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE7CAC587
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 19:23:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D1040652;
	Thu, 11 Sep 2025 21:23:32 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id ED44D40285
 for <dev@dpdk.org>; Thu, 11 Sep 2025 21:23:30 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8173e8effa1so72018385a.0
 for <dev@dpdk.org>; Thu, 11 Sep 2025 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757618610;
 x=1758223410; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HGAcZlhx9htcu80hqpKyRInabfNWddwbv5uh5jSFzck=;
 b=JIsVPmUqQLmXceXgoJH3tPQVeQLgir9IJxGWapKjuwNRRQ/98wmxF2mJv2UkNQgxzd
 TmdesLiQaE/3/ZwGY5oEcIhRMosE4dXzoYJlNly10tgFJRWdrpbeKpqPtEnS1OAxKLRX
 Z/oDlTpH7mTo1pcvsg3cLq0SgD/cBdXDN3UwA1Yg083MuX9UtsS6uqA7FIasumJeP8Db
 9LPiHacdy/RdKG/U3soGyANnZRiy13mUCV6yl+9QaO7bhiHSn7XxnKXY8GqwDujzKdaq
 8pw8v0oPbM2WiyiEMeNUcRX0kkhRjn0gvva1Ox095ZBLO4KFSSXD01EqmZ61ebNt+yoS
 bhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757618610; x=1758223410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HGAcZlhx9htcu80hqpKyRInabfNWddwbv5uh5jSFzck=;
 b=V3XRS3IrgrbrlLcPUdgrTjZPblOm18AD8V3cdKyS+1frtMI6DAwL0YzkaVWAfcwdxO
 TWPTrXP/hxQsk8dj4lbgHCrRNzsLNZFtqiwpul681uw5v4pDLXaer8gqpxGtgwUgxLLn
 5KHCmsN2Epnpev7oZ+2yrteP9Uk09q8fBi+bt52ke08/JPbBHnr5/+gvOQ3/mYXuPMWT
 HGKBnA/uO6VcF5MVDWa6AQungEbguiwxdAVIbvnbBQyP/Hxc+7Wlhu+dO0XFpQ6xShHC
 fTOTt1TIe9n2ypRm3uUx9gSKdcSNZxePjVbUX/bYbLVUcYrj5U7ErrD6dvPzJagJvXtL
 DIuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnLVlS15JVAGOo/NJIK7V+ckpcNnHz02eqd6HxNN5icbQ51wdUzCp+hyo9YpjQ1aG1LzM=@dpdk.org
X-Gm-Message-State: AOJu0YzYk6FOs9wBC6TiJ0m0w9RxGxv8fX2OP82bgs65eZUdFnQVg8AQ
 F8lhksPhDYj4V9uiixoguDSdQa+JhAdPutb+wLffxAp9jsk5rZAB3btLOOCHUK7BY3G7NP2kyEr
 ocy3v2V71dGO/IFcaW2hHVQ3IseIRZrDVVkTANA1Pwg==
X-Gm-Gg: ASbGncsD4iOLPJ6zdMJv7XLUd7HdT4TlfEUL5fWennqoDgYNnuavdKFQRzEga4SxHrh
 2vz4n7pDIuBFNJCb/Cu4iDNn3/D6F1RvIyhlo9SRmvwr97Ddm1qSPwFcreEHI3Z9TpMFWcz+8MM
 LKzekqP+taQPbY51fvdJl3i+lZoZUpklkKmzozcYC0T1ltBEZ0uIILacnssU6aFQaRL+cqANmlf
 mVpc6IAS6U3+Mgb4NaN4GVHqCZ6SqJr8ODC3AnGK17tlqHQuFmqvf84FJdEh0QpOc/MvcG1XHuL
 mzfaIDBOpJopQlHXrk4fWJxePrMR/lZ6474bDguiu4P0fA==
X-Google-Smtp-Source: AGHT+IE5QyqW5iVo3Hm7k8uGzxDD88Vp7oov+6hLi3Z1oaorXjyxGqxIasGMh7e6yUyOMDqUGPIzkXEOFoTVFVx4ujE=
X-Received: by 2002:a05:620a:4587:b0:803:7023:36b0 with SMTP id
 af79cd13be357-82402350914mr49486785a.74.1757618610034; Thu, 11 Sep 2025
 12:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911105305.5eb9c67a@hermes.local>
In-Reply-To: <20250911105305.5eb9c67a@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Fri, 12 Sep 2025 00:23:17 +0500
X-Gm-Features: AS18NWB0iYfRO9nN4nKvL3540LmA7cTbL_71w3FSbOYx1uIrjZKiH5xqknSDCTw
Message-ID: <CA++2-x6C74B2qiONU76RqFZ-mV=gKc0aX7hTf45L6B+Uy0BB_Q@mail.gmail.com>
Subject: Re: [PATCH v2] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Lijun Ou <oulijun@huawei.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>
Content-Type: multipart/alternative; boundary="000000000000e6ea87063e8b784b"
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

--000000000000e6ea87063e8b784b
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Thu, Sep 11, 2025, 22:53 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Thu, 11 Sep 2025 03:25:01 -0700
> Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>
> > When the secondary process testpmd application running any fwd_engine
> > and after that primary has exited will cause a crash.
> >
> > This patch forces secondary process forwarding lcores
> > in fwd_engine to stop before the primary process exits.
> >
> > Fixes: a550baf24af90f ("app/testpmd: support multi-process")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
>
> NAK
> As you said, you did not test it on Windows, yet you added #ifdef
> for Windows support. Since Windows doesn't support secondary
> processes (yet) how could you.
>
> Adding Windows here has to wait until it can be tested.
>
Can you please check if my understanding is correct that #ifndef
RTE_EXEC_ENV_WINDOWS means only Linux based systems ?
I have added all the codes under this macro :)


Best regards,
Khadem

>

--000000000000e6ea87063e8b784b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Thomas,=C2=A0<br><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 11, =
2025, 22:53 Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.=
org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Thu, 11 Sep 2025 03:25:01 -0700<br>
Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk" target=
=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote=
:<br>
<br>
&gt; When the secondary process testpmd application running any fwd_engine<=
br>
&gt; and after that primary has exited will cause a crash.<br>
&gt; <br>
&gt; This patch forces secondary process forwarding lcores<br>
&gt; in fwd_engine to stop before the primary process exits.<br>
&gt; <br>
&gt; Fixes: a550baf24af90f (&quot;app/testpmd: support multi-process&quot;)=
<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"norefe=
rrer">stable@dpdk.org</a><br>
&gt; <br>
&gt; Signed-off-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpesha=
war.edu.pk" target=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.ed=
u.pk</a>&gt;<br>
<br>
NAK<br>
As you said, you did not test it on Windows, yet you added #ifdef<br>
for Windows support. Since Windows doesn&#39;t support secondary<br>
processes (yet) how could you.<br>
<br>
Adding Windows here has to wait until it can be tested.<br></blockquote></d=
iv></div><div dir=3D"auto">Can you please check if my understanding is corr=
ect that #ifndef RTE_EXEC_ENV_WINDOWS means only Linux based systems ?=C2=
=A0</div><div dir=3D"auto">I have added all the codes under this macro :)=
=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Best regards,</div><div dir=3D"auto">Khadem</div><div dir=3D"aut=
o"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
</blockquote></div></div></div>

--000000000000e6ea87063e8b784b--
