Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B75C71159
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 00:57:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4176E40653;
	Tue, 17 Jun 2025 02:57:01 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 5AF8A402CC
 for <dev@dpdk.org>; Tue, 17 Jun 2025 02:57:00 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3122368d7c4so4542456a91.1
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750121819; x=1750726619; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IFloO9asdPwidEybD4UOt5EkH2knDr53wCONV1FrNzQ=;
 b=OT5mSzZY6t42W3kg+bMDDN00U+DH79d9iExIgOLyVJTmbo4ByB9j/VFJM8cJiWH9op
 iBxMhDQc3mwE5SIzULxyoj8UTaIkD6cNznojupiCw5ljPtmSfqUZXmmj7ojcyAnUkjQO
 vSmtqLJ6FJXsntuj6CpXuErsNiymSPcdo7OT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750121819; x=1750726619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFloO9asdPwidEybD4UOt5EkH2knDr53wCONV1FrNzQ=;
 b=VDcDIXEc2iFbGijlLVxLI/V0PU2bcP3Nk2uYpHs6+PqCTIw7CGjlNac/L4q85WcYwP
 KVNGL+m5C06IFB7EscN5fPCyDJ+gkDhAfq/BR+SC5HDfE4Cf92YxpRYtXIUSmsH31pA0
 rE1ONiplscCG5X/HPruqOVKqEkOX/T3M4+mE/5n+5TYkuT93lOxTrfRZZf7PYqzU9+pi
 ZfqJmSdw7cmNnbAeWPyxQAzouorbGeIvBUxMngUJAg0300JTGeChhZ+gDgpY8OxI97po
 GmMoq+tKneu8d090+1KgV0opvC7s2uFbwuzbttdLoy6yW3ytDRKoqQcSPrn4yZBKMqWD
 tdaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6wTXy8JjZQOAvnrUIEdTgZZuE8LJcT4AS8+lQMTA0U68seeK49iyKvUtD0Ux5qRs6d7g=@dpdk.org
X-Gm-Message-State: AOJu0Yw3rSU8kMpi85PnPRzB/+d0NqUUcuzbyUCxVFTYiAYLnxngvibO
 rZQgcLh9W1hViY7of/GVP+erzAzQ2Z6nwYZWZh5S5mL1IFeNgWtubaSqEjh6365gOrrCJDi2bzH
 gCL9WQ/N3L/LwL9+3/l40um0aqP/PEpdrHh5FffWa7Q==
X-Gm-Gg: ASbGnctpCscxS6tEGuPit5hJcycOkbwNtI3tq8ohE4+C5wpARkbXjadPM4/Xg6NAyJd
 VoyRKz5CgbhIJKg5CsB3MfTm4PpNncglw7ubt5PqzJ9IphrRDsoKyhfrw7At7j8uXFIxHWIrUEy
 QOmbIsm7sllm/ul21li7amvHF9IU79l5GC3LoU1HcVNHdlN6pLW53yLaZ+wes=
X-Google-Smtp-Source: AGHT+IHIK0us2V6aYMlQlsuPHiPikyhizGEgRmCr6XU1LJi6PLTELmd/kRh041RVJ8b5qxuo2emWUpck5L20i8gP4pQ=
X-Received: by 2002:a17:90b:2dd2:b0:312:f88d:25f9 with SMTP id
 98e67ed59e1d1-313f1c7dacfmr19047607a91.7.1750121819413; Mon, 16 Jun 2025
 17:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250612201220.614724-1-dmarx@iol.unh.edu>
 <20250616183859.646384-1-dmarx@iol.unh.edu>
 <CAJvnSUC_=euqk5aYGgLTu=CsDgmT2Bgrd=vcX4XG4oLmvG_YZQ@mail.gmail.com>
In-Reply-To: <CAJvnSUC_=euqk5aYGgLTu=CsDgmT2Bgrd=vcX4XG4oLmvG_YZQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 16 Jun 2025 20:51:43 -0400
X-Gm-Features: AX0GCFvLyAExJszgnfzSuD3cTx96zENI4ypuks397QYLjUCAKjsVso456Uj8JEc
Message-ID: <CAJvnSUDbyN8ng820X=TXAXusWwewZXr_j4p==vPxp1Fj3ZHi8g@mail.gmail.com>
Subject: Re: [PATCH v2] dts: fix devbind initialization bug
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005c344f0637b9fd8f"
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

--0000000000005c344f0637b9fd8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, looks good and I gave it a testrun on some XL710.

I'm going to include the Slack summary of the bugs for clarity on the v2:

Bugs:
1. topology setup is called before DPDKRuntimeEnvironment setup, but
DPDKRuntimeEnvironment setup is required for topology setup, so the
ordering needs to be reversed, which is done in Dean's V1 patch.

2. The capability check in TestRunSetup requires that the SUT be bound to
the DPDK driver, but this cannot work (except on mellanox NICs) because the
SUT NIC is bound to the kernel driver just before, for the topology setup,
and not touched again before the capability check.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

On Mon, Jun 16, 2025 at 8:17=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Recheck-request: iol-intel-Functional
>

--0000000000005c344f0637b9fd8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, looks good and I gave it a testrun on some XL710.<=
div><br></div><div>I&#39;m going to include the Slack summary of the bugs f=
or clarity on the v2:</div><div><br></div><div><div>Bugs:<br>1. topology se=
tup is called before DPDKRuntimeEnvironment setup, but DPDKRuntimeEnvironme=
nt setup is required for topology setup, so the ordering needs to be revers=
ed, which is done in Dean&#39;s V1 patch.<br><br></div><div>2. The capabili=
ty check in TestRunSetup requires that the SUT be bound to the DPDK driver,=
 but this cannot work (except on mellanox NICs) because the SUT NIC is boun=
d to the kernel driver just before, for the topology setup, and not touched=
 again before the capability check.</div><div><br></div><div>Reviewed-by: P=
atrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&=
gt;</div></div></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 16, 2025 at 8:17=E2=80=AFP=
M Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr">Recheck-request: iol-intel-Functional</div>
</blockquote></div>

--0000000000005c344f0637b9fd8f--
