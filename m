Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D545C3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 08:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBCE140156;
	Mon, 31 Mar 2025 10:42:45 +0200 (CEST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
 [209.85.166.53]) by mails.dpdk.org (Postfix) with ESMTP id B9A00402C1
 for <dev@dpdk.org>; Fri, 28 Mar 2025 14:48:30 +0100 (CET)
Received: by mail-io1-f53.google.com with SMTP id
 ca18e2360f4ac-85e73f7ba09so188493239f.3
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743169710; x=1743774510; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kbhuN4KJx1BXPZsqZaHZN5801Y9zdY26dTF2NTfGX7k=;
 b=ZKREk7U1RgYIJqr/PyMAk03fJwNsTilerewyiEzbxEd/efZyO4qYJr7FcXqdfxlcdZ
 FVLM/QS5VNJ9glA+FOFbDLzgLaI5FG9MwMpgoJ1mBPQ4MS1JzSFZsVihFS3+N58zgGFt
 zuQ+25hNecKrIXLcLL2prpPaeNWbpCxvMQkp3wgBJD5r8G2QSqmlH4YN6dsvw6N/CBTw
 4e+sW0ngCeE7CglJn4suTbyyDHPZOcNN3FLJXlMIsR0pNgBh2jAIvATjULX2onVaYm1U
 c1G7hJKXto8yCHxrQY/hduZbmlHvkx396fDBuwDwo9RUHvzvZmmitnAnjEsLUlOqiOed
 +NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743169710; x=1743774510;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kbhuN4KJx1BXPZsqZaHZN5801Y9zdY26dTF2NTfGX7k=;
 b=dE4Z83AtoohnWfRqVQnQXgdxf2QeV25QubzQog8SXs8bISiGfrcalwyd/c3RQKZoHJ
 fx6/LHWx+b41mfyQ9F6BxhwAIRej/k59Lq4aDxkr8E0V2k1EG6a6j8UPsR2t0sOXtLe8
 Doy0I2Nw5AbZb6HeVOOp9mkNGRBbW9Jy+61it4a6kzls41RvJc1p8CghQ0K6qU3LCyBn
 9Rs/a4VkcM3K+IFHEYCixo+aym6cWcA9VTlgxY177e5dgfHdy/QFzKQJsdNJR8nJY/m5
 pQ22l0czSWd0vDALq2PnpwjxUwQnR7VW2heqPI8hDAKSrOTJBGd8ANLUdkIaFYmqDbrg
 3CyQ==
X-Gm-Message-State: AOJu0YwxkbaZWKTf8GsqOJ7ztYZIcj1QgoDPJv9FuixTdqzZGzsauAAy
 fITdnh5WFDZvIggbN9nygB7pCsBDgewBM8LMrEhoFuPPWRNBN+5Qcz8ymjysbkLFunojd4hxDjp
 7f4RHdXeKjueKPGzPHY2WnCtoN6yGWPeO
X-Gm-Gg: ASbGncvS4SPoL4o9R9KwAZl9SRfhSHQtn4t3OIEXL18wCAHsRGupSqrRT/Gy9Nc0ImO
 +qkAFVl5caDiQgaROLps+Qn8Jxl+/h2BnCSgjkLf92+FSRnELwKNhiMffT5t7tJSdqdp03GY/Gz
 6KctVfZJUW+k6ufxBHQRm+8vAxFg==
X-Google-Smtp-Source: AGHT+IEtcYYLRneGvdotI++1xcLsquXA8jO6yTiQQWFbmSxWtidxR4buE/Jo1amAc4qAfx5LzpwzyclWNLWiIXtCln4=
X-Received: by 2002:a05:6602:3a03:b0:85e:17c5:bb94 with SMTP id
 ca18e2360f4ac-85e820552b3mr881772939f.1.1743169709599; Fri, 28 Mar 2025
 06:48:29 -0700 (PDT)
MIME-Version: 1.0
From: Eldho Paul Mathew <eldho789@gmail.com>
Date: Fri, 28 Mar 2025 19:18:18 +0530
X-Gm-Features: AQ5f1JpuSy3mQi_qsCJKd8zqYXMAZJKp_aULOMrCGQwNhgjYiPEECgVmUVFWKDc
Message-ID: <CAOFFPTpNTn7=y91beCJ+hvf+q-sR5xr3OUhkEa7wgcYNT7zyXQ@mail.gmail.com>
Subject: Migrate DPDK 18.05.1 -> DPDK 24.11.1 LTS
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005306a40631675336"
X-Mailman-Approved-At: Mon, 31 Mar 2025 10:42:44 +0200
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

--0000000000005306a40631675336
Content-Type: text/plain; charset="UTF-8"

Hi,

In the 24.11.1 build, I have specific questions

1) I need the DPDK output in static lib format. How can I switch off the
shared lib build?

2) I need to build librte_kni. a - Is this module deprecated in DPDK 24.11.1

3) How can I enable librte_pmd_* modules? In the driver/net folder, many
pmd are available, but none of them are built in the default ninja build.?
How to enable this?

I used the build steps listed below

cd dpdk
 meson build
 ninja -C build

Will you please help?

--0000000000005306a40631675336
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Hi,</div><div class=3D"gmail_default" style=3D"font-family:verd=
ana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family=
:verdana,sans-serif">In the 24.11.1 build, I have specific questions=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</div><div class=3D"gmail_default" style=3D"f=
ont-family:verdana,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif">1) I need the DPDK output in static lib=
 format. How can I switch off the shared lib build?</div><div class=3D"gmai=
l_default" style=3D"font-family:verdana,sans-serif"><br></div><div class=3D=
"gmail_default" style=3D"font-family:verdana,sans-serif">2) I need to build=
 librte_kni. a - Is this module deprecated in DPDK 24.11.1</div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><br></div><div =
class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">3) How can=
 I enable librte_pmd_* modules? In the driver/net folder, many pmd are avai=
lable, but none of them are built in the default ninja build.?=C2=A0=C2=A0<=
/div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">=
How to enable this?</div><div class=3D"gmail_default" style=3D"font-family:=
verdana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:verdana,sans-serif">I used the build steps listed below=C2=A0=C2=A0</d=
iv><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><b=
r></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-seri=
f">cd dpdk</div><div class=3D"gmail_default" style=3D"font-family:verdana,s=
ans-serif">=C2=A0meson build<br>=C2=A0ninja -C build</div><div class=3D"gma=
il_default" style=3D"font-family:verdana,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif">Will you please=
 help?</div></div>

--0000000000005306a40631675336--
