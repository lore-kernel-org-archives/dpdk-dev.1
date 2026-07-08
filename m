Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0806EC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:12:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5C3D40268;
	Wed,  8 Jul 2026 16:12:03 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id BAB6D40265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 16:12:01 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-51c04bf4711so5575451cf.2
 for <dev@dpdk.org>; Wed, 08 Jul 2026 07:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783519921; cv=none;
 d=google.com; s=arc-20260327;
 b=GltVkArXz5TE+TbZyffiWOL5mc+XILTF7WdWZJSy8+CpMrvo4yAdzoVZ2qI4Ywii4E
 QKF7bb/CS9nL/IwMF/s9MC3hm934EPRhmdXVc/Twt8pyBlykbiw1Gzl232A1peRmQBqe
 03vB6p+P+qW+Kw9leeW4x/Ibo+58LgoibTqQnFkr3QNqVUa/g5uBu8dh+7ZVGMlgoBLm
 T4LP4L/JQSPv3s4nzn3F/5sVZXJpFtCszXVKFOE1sYzH2uYUmepsOa6wa9UH7BzmPoo0
 YQ3ejw/8bw0ZBUqRalWd9Szhrh1cSUUcazBuHTNfhQJ7+pTEmsR/l+CQn8qlngYOovN2
 qyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WRWeTp/54ls1BGHSO9/P57wnjgt4F1ENWvDfotmKK1c=;
 fh=i2pe1Twnff/preDX0e6UrnODCfGT3BW4o2pNTRqYpnA=;
 b=rDZ7CY9DaHIz47P88/aKLWR628CqjtXKhWM4y3XcW7Dsz4zya2EA5rO+k7cDztyzGc
 2qdG3aZLp1tgPL8t6sXY0qJnXsa3xZCBQKOEiGaqsZHK36MmyCFnZf1Jjw4QAUwwxTUU
 3rjw5OYrtN7A0Ig+WKOzZjXaPCihZxEM5RQo3fL7bWwaxKcjYenbSBrjXsOctscsDq5/
 0dF3FybcUhYY5AIQuwKW9ZBfduSOdeBFtihEg+o2CZfgJ7/TEVX6cw50VPUWtysVq9z+
 lCPZiktj8xiyfTuTzCbamIdGnsNyY+fCLfMo2j7YgpVNwH+DSxTQ0FWysh39Om9L0LrC
 Fp/Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783519921; x=1784124721; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WRWeTp/54ls1BGHSO9/P57wnjgt4F1ENWvDfotmKK1c=;
 b=e7W96RezOgIiAGikUJWd2y9fxgUDXUWKjh3cR+wBWPEq7pzE3jbLoD43lWxjPIbrrD
 LXqZgonZrJHOLTiYRLi5ixxvMkzVIO0tWnrJNsyM01ae5R8qgsFcQJZPZYGcKOCD2Tuo
 PuKniL9ljjlpee35iXDN+DpQKLriHQQyVbUAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783519921; x=1784124721;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WRWeTp/54ls1BGHSO9/P57wnjgt4F1ENWvDfotmKK1c=;
 b=MosOElJMLNWrtO6Xtr/fyhSYwE0MuYNwCengxmXHdM/6cORxE+c8LTPDjp4N5g6fIn
 RvkettNPGdTT1UmBSFsw8S4VPSYN3lojYDwMuV8iJhHzkT5eykVA9OAtBbtxOD8Y7WlX
 Y0yKrPnjfhV9LMNUzDkcUmm3SB0wWW1VMpdFNS8PlnisdrJedN8ronCMyJC8ILc0uG6Z
 b9aOuurd6qW1XUUvC945l9gXQFg0WH8jM+AT/ElT+lbpn1ngc4fEbQSCKEMnLHCh1Yne
 ZJ6nze7lcayxIF/KA+FfYSqw1QSY7lT/MHM7jwsEXrjzGYbaSAGSUHYqUK9zKBcB6RMg
 Edrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqeYRE2tvUz8nVxJCV9iZtYaU2V59ixH3RVvqrVDntL/R8rMIHCvDN16i4HeqFAnGwlDgY=@dpdk.org
X-Gm-Message-State: AOJu0Yy05LAILRoEhDOuI/tJ88Z6dyFkkgBX/Q0RtzIvwBxHbzBb98ob
 vnLrHYwX0R5k4r3Uaf8ZsTCFCEm6IJHjwhzh41rbUv0InVGwFCrRYB44zMzdzgvMLOxYG5ELRx9
 s9ntn3zHIpp83n8IkNnfrOj0TzROvolClq/s3z+h0bw==
X-Gm-Gg: AfdE7ck5+giqtkp55CJykdfAHygYN4yIU6cAN1nBB/MXUKgt3Jt3ssQNOtEWDXB3E5L
 +pF9Y9/F3q4Txvdf0BiekUjZuuHOk6/1iNelOBeG16iSAAcCTgH8FqAKNvCc36iMLS/+wWoiUDg
 xGOAIQIUPR3TlIjAIOpWUUlOos8n+DCgDF4EXjNr9oaFDLLYko41h25t2YwDFUyWEzm8Rfdpy/k
 /gbq960jGSv91hC02W/kjSDHAr9mIfCnZbpkwTl+l2NUqX3fPayP/XVwa79Id5mpRilEqUuvP/S
 mkVrWtCBoXkLYoExaJ2KGq3BVC+fblN/SIXd/R2Sh6CxrxVQiIZ4DKfjbogWeWYZyNqu2Y3N2Nj
 VtCB2z9bkcqU0wWK9VMntCo6jemHsaZ3f5On3zEtkx77kYLUPptC8yyQUCczJVg==
X-Received: by 2002:a05:622a:201:b0:51a:8c86:bd41 with SMTP id
 d75a77b69052e-51c8b409ab1mr28902841cf.62.1783519920980; Wed, 08 Jul 2026
 07:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260609142330.1423729-1-knimoji@iol.unh.edu>
 <20260625172233.2288663-1-knimoji@iol.unh.edu>
 <CAK6Duxvkpxh8XzwvmMaX2y=Am2ePXD092JwX61H5EizDv5f2Gg@mail.gmail.com>
 <CAKYPG+yPEA2pH4hv3PHDGkVoc=NggT4+GWrvLg0E3V4JvRLBVA@mail.gmail.com>
 <CAK6DuxvoaE=SBv8SParRR0CmFdGHgJNFq0ydKxJ6nO7ft+xOjw@mail.gmail.com>
In-Reply-To: <CAK6DuxvoaE=SBv8SParRR0CmFdGHgJNFq0ydKxJ6nO7ft+xOjw@mail.gmail.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Wed, 8 Jul 2026 10:11:24 -0400
X-Gm-Features: AVVi8Ce1fwZiCYAOqimE8VAfIZE6XxtF9OFd7cG08OaR7nIosVuwEBnFIaoygT4
Message-ID: <CAKYPG+y2HCuMh_sTqmcyBecF-oeSC3R2U6u=FR-4MdfgRuu5iw@mail.gmail.com>
Subject: Re: [PATCH v3] dts: update dts check format script and resolve errors
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000057166306561a17c7"
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

--00000000000057166306561a17c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Patrick. After this patch got applied I reran the
dts-check-format.sh script to test the other patches that were applied, to
which a file has been reformatted. Nothing big, just a few whitespace
insertions. I will be sending a patch out shortly that includes those
whitespace formatting fixes.

Thanks,
Koushik

On Tue, Jul 7, 2026 at 9:16=E2=80=AFPM Patrick Robb <patrickrobb1997@gmail.=
com>
wrote:

> Applied to next-dts, thank you Koushik.
>

--00000000000057166306561a17c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Patrick. After this patch got applied I reran=C2=A0=
the dts-check-format.sh script to test the=C2=A0other patches that were app=
lied, to which=C2=A0a file has been reformatted. Nothing big, just a few wh=
itespace insertions. I will be sending a patch out shortly that includes th=
ose whitespace=C2=A0formatting fixes.<div><br></div><div>Thanks,</div><div>=
Koushik</div></div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2026 at 9:16=E2=80=AFPM P=
atrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com">patrickrobb199=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr">Applied to next-dts, thank you Koushik.</div>
</blockquote></div>

--00000000000057166306561a17c7--
