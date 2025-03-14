Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FD8C35FF1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 18:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A608C4028A;
	Fri, 14 Mar 2025 19:29:59 +0100 (CET)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com
 [209.85.166.175])
 by mails.dpdk.org (Postfix) with ESMTP id 81268400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 19:29:58 +0100 (CET)
Received: by mail-il1-f175.google.com with SMTP id
 e9e14a558f8ab-3cfc8772469so9835025ab.3
 for <dev@dpdk.org>; Fri, 14 Mar 2025 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741976996; x=1742581796; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7DUIIEFFPhL0HSdgNsYrLZ2pMg2UHdaa/LLjNZTFDU8=;
 b=ljMbM2Lry5b4e1V1LMl12eUXie151g6B8ceSfQesKPj3U57rKr6oeZb3qem1QyrrTk
 6xcxzoZnOLGs4pvagj51cIzVp09DEuhA/Pkx+5jD9lmgFV+Sm2nxfccKCW7Nju17ogCT
 tbjjbcRD3Oal7zyU2t0QO0NoFTMuOSTVycGgnMFsNzWXLTdv/s+awW4zAvoHfRbSIAau
 CCrPH1N81dJKdJhKkOazzhuIeibTvaQdEbSbC/AUEjKuJXU/YhcpRThYYwVsbz6MlzIw
 RYXDE+AgTK0PV8E0kmZCQm3MzHFPdtRBc4xIJoHcpxj/litCzztekQNfGZ0TrAxYsZmP
 /hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741976996; x=1742581796;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7DUIIEFFPhL0HSdgNsYrLZ2pMg2UHdaa/LLjNZTFDU8=;
 b=n+GI9qcPKtm6GXQ6Lyl2NTlo1ZzVJ74MBlndCGJjpXyjy7fvCh/8wBkM34PNs4qjNm
 EH2cFdN2YsXyg97p1915wn6E/8s4Pc3/2BtG2vio+kcmfUMj0dLLIj7JeKMfywWowBX+
 lV5ECS7EOkqCXDpb0y4KuL/vC6ZiQ7cuEj3M7j+z/u/6QoF/hV0Enwqc7i2rKxAsBA5n
 Zk6bDMuHiWKFx7DHuFyda0rE9z1KBg3AkMjpWjqCawFJX+RJYVsrs8gggbv3V7IZo0Ec
 /n5BAsTtt6ivl1d+J6bh6ACh2rL8rJ0vfedbbkLdr4pm1KFuamEahy5G1sgPTUPU3Hqo
 o0Vg==
X-Gm-Message-State: AOJu0Yz3mailyJ71o709w0o2lu9mX6ht5oJyj2Xjcdfh5fPCNmUBjhjp
 /e18lbdIzehblvatWaoqdzCyyAlfNxNfBZjf8k7qp+SgXdNbP8cXWjQlvC1BhlQsk4NHiMyRG44
 OTgh9m3MUujJ2+1Yhh/805Oump8xe6wnM
X-Gm-Gg: ASbGnctRttLv1DPgl3eFCI0VB4tgonKzbSdBPTk43HRhmMTFz6UWkoekOtLsS3XHbQD
 JJ1NfoDjmT0WPl1v9dZWybrkllNg5XVJzsUy9E+oqWN0KnnbKkGbrtnRjCXnc3BrS4h4yh8zhH3
 ZQ8wrTBR+P+7+5QWZPc9yXAz2C
X-Google-Smtp-Source: AGHT+IECL9XSar82EgeVkmffKssx5mXslXlBu4LVWxHVseKwdyZ/0Ci0RoedQEzIwTrQRb0bBM/C1duv45F+AeDOZKw=
X-Received: by 2002:a05:6e02:3182:b0:3d2:b154:49dc with SMTP id
 e9e14a558f8ab-3d4839fea50mr36274815ab.5.1741976996443; Fri, 14 Mar 2025
 11:29:56 -0700 (PDT)
MIME-Version: 1.0
From: Adel Belkhiri <adel.belkhiri@gmail.com>
Date: Fri, 14 Mar 2025 14:29:43 -0400
X-Gm-Features: AQ5f1Jp-DeWf-DAl0TiU3ABPs8kbob4J2KgaFuR65rcRw56ZwkQkr-WtLnlIbyo
Message-ID: <CAMxxxdMyxGM8wCCCM=wd+Stg1Ptxk8Tn1k3fATU+AKmY698Thw@mail.gmail.com>
Subject: Feedback Requested on DPDK Performance Analysis Video
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000001482cb063051a0fb"
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

--0000000000001482cb063051a0fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I hope you=E2=80=99re doing well! I wanted to share a YouTube video I recen=
tly
created, showcasing the performance analyses I developed for DPDK in Trace
Compass incubator. In this video, I show how tracing can help reveal some
performance aspects of DPDK applications, with the goal of sparking
discussion within the community.

Here=E2=80=99s the link:
https://www.youtube.com/watch?v=3Dafgma-J12tE&ab_channel=3DEclipseTraceComp=
ass

If you can spare about 8 minutes to watch, I=E2=80=99d be grateful for any =
feedback
or suggestions, including new analysis ideas.

Thank you and I look forward to hearing your thoughts!

Best,
Adel

--0000000000001482cb063051a0fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I hope you=E2=80=99re doing well! I wanted =
to share a YouTube video I recently created, showcasing the performance ana=
lyses I developed for DPDK in Trace Compass incubator. In this video, I sho=
w how tracing can help reveal some performance aspects of DPDK applications=
, with the goal of sparking discussion within the community.<br><br>Here=E2=
=80=99s the link:=C2=A0<a href=3D"https://www.youtube.com/watch?v=3Dafgma-J=
12tE&amp;ab_channel=3DEclipseTraceCompass" target=3D"_blank">https://www.yo=
utube.com/watch?v=3Dafgma-J12tE&amp;ab_channel=3DEclipseTraceCompass</a><br=
><br>If you can spare about 8 minutes to watch, I=E2=80=99d be grateful for=
 any feedback or suggestions, including new analysis ideas.=C2=A0<br><br>Th=
ank you and I look forward to hearing your thoughts!<br><br>Best,<br>Adel</=
div>

--0000000000001482cb063051a0fb--
