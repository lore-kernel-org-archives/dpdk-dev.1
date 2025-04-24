Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CE7C369C2
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 16:22:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BE07400D7;
	Thu, 24 Apr 2025 18:22:01 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 14B6C400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 18:22:00 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-70811611315so12373257b3.1
 for <dev@dpdk.org>; Thu, 24 Apr 2025 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745511719; x=1746116519; darn=dpdk.org;
 h=mime-version:content-language:accept-language:in-reply-to
 :references:message-id:date:thread-index:thread-topic:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kM4G8DFR43ioId2zdQ5Nbie+R0cJbsTl/eV4WFo3Zos=;
 b=c8wi8IhTNW3dkmcI1hNGk0ZqCETiTL/q/FNpN2ILCiDSWNgY3RQHP5hOlbAZ39mv+D
 MUt4HMVhuV5kspROUPiqLXSgF8yzIV0PUTpqIvzPTbwE1R2vRoD/mgPhx8h/hpFnGT3J
 iojuBo9HudpucZNqxvCSyqKiEOKpXpkwms29Ll6XLuR89yZ3GZD7N+YrsfiflgTIoU5O
 r7RfleZNe1JSvKmGkD/vs4RmqztF9jlw6oPS5OmuZkLM04ifwZzj26mRFf6V2zuF+d7i
 9A+gTDc2ctiqZMOeDYVyzYGmxx9vTQ5zKG2Iimasi1WvQRH2FCNpYZgxoI2kG45iV0wb
 N91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745511719; x=1746116519;
 h=mime-version:content-language:accept-language:in-reply-to
 :references:message-id:date:thread-index:thread-topic:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kM4G8DFR43ioId2zdQ5Nbie+R0cJbsTl/eV4WFo3Zos=;
 b=eUZXgzi66hqkUTH3j1KDVXksF6gm0EED5QwM2JgM2aqjNllSSc7gipaxAhezZk6yE4
 h4GHnof2IA1BTRbbhxtd87w7w8UUj/SrmpE+QkZ3PehwIZqBmPtNEw6QAZwG1mWsm8fP
 DeznmJ+1SYj406ukB4u+Ax/frvuiFW14Eb+C14i5obO+55FP+nK/XunBSKhHJKSpf3B0
 8EI9LNNBq/O8b5rpy5XvNv+3Ezc6gnWvmMqw0BTIoOn7PcIquvsbKrY4Pc4TL9zqOPYF
 Yx+wtOVYaCHwuy1jwq4AKWtXS2wYJhJwmN/ZUg+Ea59TFUoJVdnrhn2f8yNH8BSPE8C2
 I4GQ==
X-Gm-Message-State: AOJu0Ywso0qdsaCERw7y4yPLijEsk1jBR58x2+QZt+kLDmVpPgcjv69P
 jVSyHknCj+lUCk+DngK2IrjeyzvZZcXhDc3eVtaUjE4Ml5gl+bMtznzcRQ==
X-Gm-Gg: ASbGncuPEHiAq1p1rNCoTkc2ofgGPuxkByHqc22ig3RgcKlt2ZIUGlzhFdKp2W4JCOf
 RJU6DzbRWanOrqKjsXiOrrz6Q5MWv01jyGGkgrv0CgWWmT5XFS5GDGBZ1MxLiE9LS6sCpkkRlEN
 8wko/yZ/v9CKf5j9fPPQchRsxS1cCFMrO4YpWwCqSq2qTqfw2JzCi9iR2K4MiRgTDttoXyStGpA
 iIlxiH6Vt1che1OEUIP8wBcSiSsLeNATCnRyUuSIaL2MCIIGWq0evZgpBVNEaHJ4ITk/gXcaz/h
 1XrTwzeTxOK3d4topo4ppkerf3NwvkNiWgHNBsfbn/vjsqIzsu2H3XOeOUsBGHGGZWEH+z5YjVe
 dGyKh2p51JVDLY1wGwKQgbuJpCem0iSmX5A==
X-Google-Smtp-Source: AGHT+IFz844cRVH/gU95DNqr33eGgC0l+jk7pzPbsKq0orFi8t7EGcUrj0aAiZwdY+a4krqoxm6rMQ==
X-Received: by 2002:a05:690c:886:b0:6f9:871e:6903 with SMTP id
 00721157ae682-7084f1850damr5125767b3.37.1745511719222; 
 Thu, 24 Apr 2025 09:21:59 -0700 (PDT)
Received: from DS7P223MB0525.NAMP223.PROD.OUTLOOK.COM ([2603:1036:301:306b::5])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70841acdfd0sm4029897b3.86.2025.04.24.09.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:21:58 -0700 (PDT)
From: Nandini Persad <nandinipersad361@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2] doc: reword flow offload and api docs
Thread-Topic: [PATCH v2] doc: reword flow offload and api docs
Thread-Index: AQHbqkj3qENUarj7kkyLoFkqDQ+2KrOzEcwAgAADUSA=
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 24 Apr 2025 16:21:58 +0000
Message-ID: <DS7P223MB05259706BBBD7AAF31621176AD852@DS7P223MB0525.NAMP223.PROD.OUTLOOK.COM>
References: <20250331214036.17295-1-nandinipersad361@gmail.com>
 <20250410183931.40881-1-nandinipersad361@gmail.com>
 <20250424090858.7ef78315@hermes.local>
In-Reply-To: <20250424090858.7ef78315@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-reactions: allow
Content-Type: multipart/alternative;
 boundary="_000_DS7P223MB05259706BBBD7AAF31621176AD852DS7P223MB0525NAMP_"
MIME-Version: 1.0
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

--_000_DS7P223MB05259706BBBD7AAF31621176AD852DS7P223MB0525NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Stephen. I think I know how to fix it. Might have to submit a new pa=
tch
________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Thursday, April 24, 2025 9:08:58 AM
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: Re: [PATCH v2] doc: reword flow offload and api docs

On Thu, 10 Apr 2025 11:39:31 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> I removed low level details of the code from the Flow Offload
> section of the Programmer's Guide so that it is more about
> the general usage of the APIs. I moved the specific details
> and definitions of the constants/function to the API docs
> if the details were not already there.
>
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---
>  doc/guides/prog_guide/ethdev/flow_offload.rst | 3584 +----------------

Looks good but does not apply cleanly to current main branch.
Tried manually fixing it but it was too hard and gave up.

--_000_DS7P223MB05259706BBBD7AAF31621176AD852DS7P223MB0525NAMP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr">Thanks Stephen. I think I know how to fix it. Might have t=
o submit a new patch&nbsp;</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"ltr"></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Stephen Hemminger &lt=
;stephen@networkplumber.org&gt;<br>
<b>Sent:</b> Thursday, April 24, 2025 9:08:58 AM<br>
<b>To:</b> Nandini Persad &lt;nandinipersad361@gmail.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> Re: [PATCH v2] doc: reword flow offload and api docs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, 10 Apr 2025 11:39:31 -0700<br>
Nandini Persad &lt;nandinipersad361@gmail.com&gt; wrote:<br>
<br>
&gt; I removed low level details of the code from the Flow Offload<br>
&gt; section of the Programmer's Guide so that it is more about<br>
&gt; the general usage of the APIs. I moved the specific details<br>
&gt; and definitions of the constants/function to the API docs<br>
&gt; if the details were not already there.<br>
&gt; <br>
&gt; Signed-off-by: Nandini Persad &lt;nandinipersad361@gmail.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; doc/guides/prog_guide/ethdev/flow_offload.rst | 3584 +----------=
------<br>
<br>
Looks good but does not apply cleanly to current main branch.<br>
Tried manually fixing it but it was too hard and gave up.<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS7P223MB05259706BBBD7AAF31621176AD852DS7P223MB0525NAMP_--
