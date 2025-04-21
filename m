Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C6EC369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 18:28:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BBF840658;
	Mon, 21 Apr 2025 20:28:36 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8CA9040299
 for <dev@dpdk.org>; Mon, 21 Apr 2025 20:28:34 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b0b2ce7cc81so3667832a12.3
 for <dev@dpdk.org>; Mon, 21 Apr 2025 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745260113; x=1745864913; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ego4Fo1LhdMDq+b15xNSxdsWneAPOcVQaG6cuScHALQ=;
 b=HioSQ5tZK7BUd2uNfzQS5mUs0eBBvJ+euwc2SGqxC2TyoP2yYlmFcBQcDfHgcntAHb
 4G6DAlu/c/Ss+gOQa1lqEqXhmJjxJFvO9v3Kx5oYSi2EJ54ZKcoEMcvXRRVzIKEiZufj
 GL9j/XVmAmHJW6anIXbCqma6FtQlTqlRKjpV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745260113; x=1745864913;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ego4Fo1LhdMDq+b15xNSxdsWneAPOcVQaG6cuScHALQ=;
 b=nImQV1EtR0KdWI/KOgtpIkG8aTLTd4OhFYj/w4oKq1rl1IIMzdxarGHWNo8yrngcVG
 DgAb/ynofZBDTUbPW9WKx+wuS7wpdgjNbOhZMMSKDLSw79lyPFYAgcSPAYV2tVxv4oO2
 D/KR7ENjb/YqyvzOSPpnqpp+Bf/utOrhr+Z73dOVBMzyNFnEJ8MngHb5f7JYXVDBuoQk
 hkAQ+/en8KaZOSWgAvPpvgGpgvAM4zt5bUpoDFkZjMq0bzlFGk9udpk8UPGtMlEePmqR
 eKZ9MrtWO8LtIUDY7FwnpFvdnD+EJAZltgTfyaUqdc96l11KVtclamADZ3tustWkfWKs
 +O5A==
X-Gm-Message-State: AOJu0Ywi6/q/ySCZ00s6lrXvNtJdS2zkfhhhMjFM33JXC5MvKZrtENyn
 epOIGFgf4ivi572v1O5e7B0TbJQ9l0Amy7yjJ50vNjhnO0IznmXlLLrjvhD5IIuVd4xjSfRuuPf
 xygibg/dIo0wkUDcsNzWDaNqYA94oD+/3JKQKXZDDBv11gUBx
X-Gm-Gg: ASbGncuqDT+BPx6yJksmbwfO25/+0FSpSaH9Gu0ORj0u9IWxSy/7jcv4LOpwgh1f5LH
 XDI1NGAXB3LzLIuNAa1SHnBA1YpdbuZ06wGrWXgN+xeRM+4Xff1J9vF96S6XbNWCfEVMt8+FTzv
 Fh10Attivz3diCK9j9Zq0J6mGij45U83aFNnupmZ+KgSC0QTu59/+vYkA=
X-Google-Smtp-Source: AGHT+IEdqeB6o8vkkdlDqNGJ5mZrS7MjHOuUp48Uhmm16CpYLM8YmnIAfqiHc98eBO/idCVG3+xf6zAWFZrsd8P+RqI=
X-Received: by 2002:a17:90b:1f90:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-3087bb3c7eemr15053473a91.6.1745260113269; Mon, 21 Apr 2025
 11:28:33 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 21 Apr 2025 14:24:13 -0400
X-Gm-Features: ATxdqUFCNyAJdsy5y8z7KSe1SrowZjVFFZ0S5XnI1lf8VuLw2AH6zw1ElhoogbA
Message-ID: <CAJvnSUDOJLGbjncEdSi_9k1+cP9N56Pp6VOkFktt3-V07d_R7Q@mail.gmail.com>
Subject: Reschedule 4/24 DTS meeting
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, Paul Szczepanek <Paul.Szczepanek@arm.com>, 
 Luca Vizzarro <Luca.Vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="00000000000017b15606334e09e2"
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

--00000000000017b15606334e09e2
Content-Type: text/plain; charset="UTF-8"

Hello,

There is a conflict between this Thursday's DPDK governing board meeting
and the DTS meeting. So, I think we will have to push the DTS meeting back
to 14:00 UTC.

Apologies for the late notice on this.

-Patrick

--00000000000017b15606334e09e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>There is a conflict b=
etween this Thursday&#39;s DPDK governing board meeting and the DTS meeting=
. So, I think we will have to push the DTS meeting back to 14:00 UTC.</div>=
<div><br></div><div>Apologies for the late notice on this.</div><div><br></=
div><div>-Patrick</div></div>

--00000000000017b15606334e09e2--
