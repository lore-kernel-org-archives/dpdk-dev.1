Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD03AC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 19:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 426F6410F1;
	Thu, 15 May 2025 21:30:22 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9FFCD41060
 for <dev@dpdk.org>; Thu, 15 May 2025 21:30:21 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22e661313a3so15838685ad.3
 for <dev@dpdk.org>; Thu, 15 May 2025 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747337421; x=1747942221; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E4V1pbL7dT4Ax0ev1wZHgMFN1O2cVm86DcqVbC912Ic=;
 b=YcCR5L3qni+HWaPw4FFFQ4Wwl/gW3mnM92Z4w81foihdZNwsmLHyQb+XbehNBUPfA0
 0i4JiDekMkzdCBtlSY/aOGWAd35BD5wVOmpCIEHS2ZJPgdKrUREkZ/buxyr02MmdmbXB
 QLXF8lu8mJ6aSKhzbeTljsHXPKUYwYwGaWwxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337421; x=1747942221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E4V1pbL7dT4Ax0ev1wZHgMFN1O2cVm86DcqVbC912Ic=;
 b=jWWFuTrcPr61d97Oo5YjYSFpMXzdvkIrOAJ5qPkd3JwLCviKIlwrcJPLsFmVFzNLjD
 MIwOphpK5piPil2BFhd7CN5W1mlYfkBRj0Q5wa10oyN10XefQVTQ1w1x8qJ1VJHA6eOZ
 wS3zijV+HoNCsW0SIF7OJYGuI9m2Nfco3Zak3M4EkrAfvsP53FqzuVqBkxbAQy1BwxAZ
 TKqONRZtR18eDfUg7ClzoZnW2Z72f1VZj9WncDTYoMcfFV+ZOe+qSDXO0a5hHhY1SbOH
 m23Dt8IIg9Nbn7Dyxao6j6aJk80sSCt+BS6FjreuMV7acODSAqI+RCOOTl06NAYlNHYd
 WZzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCZsSQvYLxMZpkJxRNewdn50C5VwHbkTvcbyvBVibaAmcXjsgKthYPqTK06W9SD4I9sD8=@dpdk.org
X-Gm-Message-State: AOJu0YwwEiW4t2zBoITgHYxq8pWsHQa89L9bWsJtUkbcNMSpu5/ZFBlb
 raBkb8L/HymnwTxVRm5OxvO/HVVjcUmPRmYwal8umV+7QWcXwT6m1jY7mDMb5cVGM9tNj+6gWu9
 QgkoF2sJO0LEIg6ejn61aXTR2/PDBSbNUOMNGUBDcvg==
X-Gm-Gg: ASbGnctpWp7IPBqn8EAqGirpxX3s5E493bpOrMEDm1IP6pkEY6z38tLWLod1hneWuq3
 elSGBtnHWVZGTevkJSEk2sFJG4czHhyYQlZNdCJ3LDafy9be9us4rrOcm6ZuaJloTEUdF3a/LgS
 w16HdkfXSjQjmqfDzsPGMjFAZDlWNIzo9UuyJ3P1I40FGbRYofwuJ2S2VxwQNxMudqFg==
X-Google-Smtp-Source: AGHT+IGXOsVFxL7GsD0f4DpX3SR+ZmndIb1GqZiP73/jW4VCGVgyEjGiCAleNAAqnP8M3QpHYEMQNhDnI7fyagpwSaM=
X-Received: by 2002:a17:903:2f0b:b0:22d:e57a:27a2 with SMTP id
 d9443c01a7336-231d43bdb93mr8360555ad.23.1747337420774; Thu, 15 May 2025
 12:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250423194011.1447679-6-npratte@iol.unh.edu>
In-Reply-To: <20250423194011.1447679-6-npratte@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 15 May 2025 15:25:37 -0400
X-Gm-Features: AX0GCFua_bzh2KUe2jFeGrO51XxuVVQGUbjwpJm71TB3bgb3aboi0Faya6BtwLg
Message-ID: <CAJvnSUBk=GoB+sqnyrGT3XdSGmv7qG3RscZ=YckgC8ih+C4vDQ@mail.gmail.com>
Subject: Re: [RFC Patch v1 5/5] dts: add performance test functions to test
 suite api
To: Nicholas Pratte <npratte@iol.unh.edu>
Cc: ian.stokes@intel.com, yoan.picchi@foss.arm.com, paul.szczepanek@arm.com, 
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, luca.vizzarro@arm.com, 
 thomas.wilks@arm.com, dmarx@iol.unh.edu, stephen@networkplumber.org, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000044b7f3063531b295"
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

--00000000000044b7f3063531b295
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 3:40=E2=80=AFPM Nicholas Pratte <npratte@iol.unh.ed=
u> wrote:

> Provide functional performance method to run performance tests using a
> user-supplied performance traffic generator. The single core performance
> test is included, with some basic statistics checks verifying TG packet
> transmission rates.
>
>
>
Obviously the testsuite is a placeholder to demonstrate the TG usage, as
you say, which is all good.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000044b7f3063531b295
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 23,=
 2025 at 3:40=E2=80=AFPM Nicholas Pratte &lt;<a href=3D"mailto:npratte@iol.=
unh.edu">npratte@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Provide functional performance method to run pe=
rformance tests using a<br>
user-supplied performance traffic generator. The single core performance<br=
>
test is included, with some basic statistics checks verifying TG packet<br>
transmission rates.<br>
<br><br></blockquote><div><br></div><div>Obviously the testsuite is a place=
holder to demonstrate the TG usage, as you say, which is all good.=C2=A0</d=
iv><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:prob=
b@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></div>

--00000000000044b7f3063531b295--
