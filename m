Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC1EC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 16:00:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE0DD42E68;
	Wed,  4 Jun 2025 18:00:16 +0200 (CEST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49]) by mails.dpdk.org (Postfix) with ESMTP id 4723742DF1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 18:00:16 +0200 (CEST)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-4e5a0ec639dso4556335137.3
 for <dev@dpdk.org>; Wed, 04 Jun 2025 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749052815; x=1749657615; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOh/CzyjzceH9F2U3ViGeu8z4OoqtGcu7fay7yyIRhg=;
 b=nNxeZiUkNSyPpkeEv4bNeAJLgB24TJJfDB+nDVdiaTod44WICeg3bdXtb4pJH7i8Mr
 QEqDUifLtR/hxzPYWiPCf+M7pkrAlhdw2dSHnWACjG4NMD0XBsL57mwNQa5OcsxGwDge
 mD61z4YAnOI3pqh1uLm35RrTAkPxC/l69VNYer4llDjd0RLdKUFLIpIsJ98J274wat2r
 Pkjs1uyWe/zqd+qdvArQNUPrVQVAjKtop3oZT8xwhKexahGBFZWFdwmNdJr0CX2N52w6
 KFqpwX3PbrRuQ2lQ3FQ8XGS8CJYp0VeNk1/p9U5SCUuEI3GIfwHKMl9JJ1bP+xKUGi7s
 ZkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749052815; x=1749657615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOh/CzyjzceH9F2U3ViGeu8z4OoqtGcu7fay7yyIRhg=;
 b=QcRnUtizjt8I+qyHxjVvXfxAgpYKfuxCioUtbhxLs5VgXWZPQx4kzo6rIVDf2zFFJK
 rSfV+IivqQ7oy97hOmSz9SE6I50/OhPSsDspJs7NUXJsGVMc3ch2XZJFciav9Oau0OsE
 AogbysXoMsTUzUBZBDaZJNGvMZd/BDFzfa+nvwj/EnFAsMExEkZLU2sbDKN+BcdLddQJ
 Skl91kuWWt+ptWK8VOk3GdFmUSr+6++rqehIXgH/YPWrI76zM6wGnIN7Jbzx2BIxNQ/r
 fq2xKWP3VPCYAR9vgXuFbayk14JWyRz4cvIXuIacc+KrbEbLLhnZa81SOW3guRCB/n+M
 qbnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8XRtv9lGGcBxiM+U4A0lrSExChcwQkZ6HV7g+PVx+PbpaMyiTPmb0rbURcU+C2gcqhoA=@dpdk.org
X-Gm-Message-State: AOJu0YzbNf/NM5nh64fBSfLs7XRfEHcWy9D9GWrH9Cc0+WhbjhOsnBZA
 jGQvuyu+y8I+h0K33y3Hi5p05gy5dVvryJxBsqNBDil2WvSoRReFh0HovSBQ/jeFsIruCqet9zg
 TQwZrggo0fGdZwGkUkD47cxfklz1QxUB7kATG
X-Gm-Gg: ASbGncvPbVvmKiRnWidMhCPRl7cwp5wltvPHpFVIYCn4lrOfpZgjk3cs8jHbyMXxYN1
 otRXDppMdu5hYx9YBRdZX90T4BsoemsZUrDdaSg/v8yRmL8UopFSH9GGweH9JH7+5l24rVTbgOq
 s7xJrm0a++yxoHrgL4L9mNsVeNalqaglwRSPT/yT2YBw==
X-Google-Smtp-Source: AGHT+IEUOkqTcdDDl1Tk1AN4C8/iddjo2RCtaTcykcWgrHyBaaJU4Gc+XgOiAEp1cYExPb8XCt3Ye7tqTdIDvupE7gA=
X-Received: by 2002:a05:6102:1481:b0:4e2:91ce:8cad with SMTP id
 ada2fe7eead31-4e746f83a08mr2980801137.24.1749052815408; Wed, 04 Jun 2025
 09:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
 <20250421151718.2172470-3-nsaxena@marvell.com>
 <BY3PR18MB4785E9B4003F2CA386071F16C861A@BY3PR18MB4785.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4785E9B4003F2CA386071F16C861A@BY3PR18MB4785.namprd18.prod.outlook.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Wed, 4 Jun 2025 21:30:04 +0530
X-Gm-Features: AX0GCFtX0pwFnmndOx-_Ap3FV0ftPJMaZU7_sg4NL6k_Mb93NFi404jpQ5lLXCg
Message-ID: <CAG6-93zpGfkoHo1Jwnrq30iffzb4O_R4KXqj8wXBCaLOH8mPYA@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] graph: add feature arc abstraction
To: Jerin Jacob <jerinj@marvell.com>
Cc: Nitin Saxena <nsaxena@marvell.com>,
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>, 
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jerin,


On Fri, May 30, 2025 at 6:43=E2=80=AFPM Jerin Jacob <jerinj@marvell.com> wr=
ote:
>
>
>
> > -----Original Message-----
> > From: Nitin Saxena <nsaxena@marvell.com>
> > Sent: Monday, April 21, 2025 8:47 PM
> > To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> > <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> > <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>; Robin
> > Jarry <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> > Cc: dev@dpdk.org; Nitin Saxena <nsaxena16@gmail.com>
> > Subject: [PATCH v9 2/5] graph: add feature arc abstraction
> >
> > Feature arc abstraction allows rte_graph based applications to
> > - Allow control plane to runtime enable/disable feature nodes.
> >   Fast path APIs helps to steer packets across enabled feature nodes
> > - Feature enable/disable based on indexes. Index can be interface index=
,
> >   route index, etc
> > - More than one feature nodes can be added to an arc and also provide
> >   mechanism to control features sequencing order in fast path.
> > - Does not require stopping of workers for control plane updates. RCU
> >   mechanism also provided
> > - Once DPDK inbuilt nodes adopts feature arc abstraction, out-of-tree
> >   nodes can also be hooked (with no custom changes in DPDK in-built
> >   nodes)
> >
> > Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
>
> Also split this patch as N patches. Update programming guide in  each pat=
ches.
> i.e No separate patch for programing guide.
>
>
Have splitted "feature arc" patch into 3 patches in v10
