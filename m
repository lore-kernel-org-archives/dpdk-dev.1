Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B750C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 07:56:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D63B34014F;
	Fri,  6 Jun 2025 09:56:15 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id C9899400EF
 for <dev@dpdk.org>; Fri,  6 Jun 2025 09:56:13 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4a4312b4849so22696641cf.1
 for <dev@dpdk.org>; Fri, 06 Jun 2025 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749196573; x=1749801373; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ho8H0oT36ZfTEn1ORiipa+ui8k4sbWqVcrKxLuwBwU=;
 b=AfJ7LRfucsaVd5u4p23c9nS1TarlVumq0uU6Z0oeTUCbYxeZhOr92fdrSPbFZMtbbm
 iwQEwLqSeUN6j/5BPj6YORXURLXTGQWKi1PpMBYTuc1N7Y4SN3K1peq7hFG4R7nVOWsN
 teephwmAxctftm1w7a1/4+kSP5+z2H+Z+fZGaYPiQmZBDH5luK67y3HcCgkV99kYtrPk
 x/K7B0fSU47giNwuNAU/lHI0iCcr+LCKX9ECdlR/d8kfcKry3UaMy8LsUOUrN8QDMyY0
 o967IOJiCKKrwaKvpIIHD34NyZTniE12BcmsZRlvqS/hOOXmQ1LAqb8DykRcJ6rmcW6q
 0JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749196573; x=1749801373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Ho8H0oT36ZfTEn1ORiipa+ui8k4sbWqVcrKxLuwBwU=;
 b=Qfu9s21YG0NybR1Qqb+bJvd+Yemz7TrdXPirpc7rR0A4c6wubVgYomgBsIxQCTqrVM
 ATCdgC/9KLnyFaYIO0OU+rAYAeRz8fi+Fn6IKmSnsQ1wx+CV7Lay3s5jc8pT78tZrFev
 opmNcfCLD1wFiQaj8EVT9XtkDqcDEIqaA235xKk/SxYPpRv+s0ACXa7qzJ7qsZRMaY99
 nih55eSE0vbVVMdkGkxThzV4NiOLgLznvtTJ66YwaVkPXNowG1P54MrH8s30XlO9tUlp
 AypMuzo8Yyzvwas83sUQvfgGAXu4Fs/ojEvFa3K7toaO6eJ5RkfApwSU4uB6cVNSH3x9
 XnhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlfPRvibl/+JL7+Rm+DxOv2g1+9dzvkhVbwYZ6Y6br6Rvr/NKIrr2nWc+e/R4RrDmqE+Y=@dpdk.org
X-Gm-Message-State: AOJu0YzBJiDcbBchPexW4wD/HIBlL+hSHuHQQh+tVZRRwP4Df7lIaNZP
 QnuvZfXczZX8iGUQlj1AXLTtp7okw8WtiU7rIbLQYztTn+JEQEswpDtc02QhQwG49uo9YUVy5p7
 uufK69Ghz8sMshJXRoB8ED7ZFMdRkt7g=
X-Gm-Gg: ASbGncvrQCQj/H69W6D6Gjj/DQr6HkFQCkaZPOz7DZvl1DAmjDs5ClKUBXtRdbvO9yz
 wqgkRt/q7kutOz/ZjIY0p1ZndNzEiL5BI5SWFiH9BRAGR76e3X6H2dIBNL2O/nRRMjnNJG5ujgt
 vVdeOvEOHIJKyLZFcAfvs4SguieZ9llp8=
X-Google-Smtp-Source: AGHT+IEPRNJv0zqtMk8JRKl7Mz4BGknPSBDU4X7AojPdf+vqbUxMJ9fZUIV3gsRcsSI0nLu0TBx/m4/p3dKMyZoj5nU=
X-Received: by 2002:a05:622a:4892:b0:494:a283:1c4a with SMTP id
 d75a77b69052e-4a5b9d7da40mr50751761cf.32.1749196572962; Fri, 06 Jun 2025
 00:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250605173315.1447003-1-nsaxena@marvell.com>
 <20250605173315.1447003-2-nsaxena@marvell.com>
In-Reply-To: <20250605173315.1447003-2-nsaxena@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 6 Jun 2025 13:25:45 +0530
X-Gm-Features: AX0GCFswH-VYrICtmn6NKbDzx2PIqAAwcUZ5w1r4CE5KqcndmHmMlxRkx0hTU7w
Message-ID: <CALBAE1OmW+Oh=nAXNW5YCJys08GSgRwU8J8W4-VSwozk0AuR1Q@mail.gmail.com>
Subject: Re: [PATCH v12 1/7] graph: add API to override node process function
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
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

On Thu, Jun 5, 2025 at 11:12=E2=80=AFPM Nitin Saxena <nsaxena@marvell.com> =
wrote:
>
> New internal API used by feature arc library to override node's original
> process() func.
>
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>

@Thomas Monjalon While merging, please add <nsaxena@marvell.com> in
.mailmap for  Nitin Saxena  in addition to current emails
