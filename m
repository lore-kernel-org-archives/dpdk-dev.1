Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5233EC369D3
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 15:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EB3240608;
	Fri, 25 Apr 2025 17:06:23 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 21A7240279
 for <dev@dpdk.org>; Fri, 25 Apr 2025 17:06:22 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b074d908e56so1729695a12.2
 for <dev@dpdk.org>; Fri, 25 Apr 2025 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745593581; x=1746198381; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HwnzxSA245S1a80aHDOevVrHAhiHxniDwQ4k2JE2LjE=;
 b=Drq8JOd+bv94iuwVSOB8M2wPwpBKW1Bhd5jgGXJTegwOVCZsWOpmi6CquyKI/pgfK8
 fgmog7DD3nvIm82HDRPoRajs0fAS6s7/2LHjR0RATlrRjeoIV224fbS1thnHu+HpbU88
 sFFRiagZdDdEOWGHePbWY85wEbUauJeyhSqXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745593581; x=1746198381;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HwnzxSA245S1a80aHDOevVrHAhiHxniDwQ4k2JE2LjE=;
 b=ZvztyU6DSmy4k0pwyaCvrOFrmbBUgOYEWOfVWSfgE0+D2Tyyo1MGEL8T4HKZEoAA6S
 t1sUpEydluxwjDvJp+Y8TI6k5X5hk42ilgDN8LoVaGGXKbOJ4s+mLTmp4rolopdSsMsX
 Dj8E4SIMkNs98CPI7RYXsPzgza6e/sextEyz4JpJppM4HDypJawMVQV7MKsTxIVn1CCE
 z8KcpnzYFodLE3qLGDIMfBlBcnbpw8OaT4VaKo3jT+Lpeck3rAaD+OUDBOGJyKVC5Bv1
 SPWeQI31aMy8H6KlJ64j2bYf50TJAiEuA0xPClbzCQ9B5v3AZsA9IYG6jpySyu/bbsZq
 Wspg==
X-Gm-Message-State: AOJu0YzSbx1I7JdoQ5QHXlrc+LRiBif1JSavM58VQX2bzTsyDZNstRSu
 YDLYhgb6sCEzGcFkSyE4X7epLlTVMCcd4IDnc6Brwvw2lWVybvAXlpuRAMLvyCofnMv2eI3egpB
 KVm4LcxMxV/LgeHEAh/gAYZxb7ld77HMGG0jX0Q==
X-Gm-Gg: ASbGncs9BQiaDZBFbRJOf8RK4Iwxg8CVJKo/TwEKLM1y4quO6huz58bLFj8DyltjYwB
 3tGcXYrmHjU1mspfh//MrrPMK2n67qsFm0Bh6QAxIiRJde4aM9UeJLOY8fnRYFVZb5MuF75XihV
 8/dp8asX2XkVJk+GmP/ZVEMyuLqrtG2GHNocUqX/EZcBhgEeDNbAqbqpA=
X-Google-Smtp-Source: AGHT+IEtBgR09JBo6ra7F3PN4thHonXURhOZGLDb2lrunm6WWgMtLt/rjvqSV2sg8r0Tz93oY7UYFy+IZg+JDFT85dQ=
X-Received: by 2002:a17:90b:3ccf:b0:301:c5cb:7b13 with SMTP id
 98e67ed59e1d1-309f7d9db26mr4098488a91.3.1745593580706; Fri, 25 Apr 2025
 08:06:20 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 25 Apr 2025 11:01:57 -0400
X-Gm-Features: ATxdqUHryvm6luIHVxnUAIXxGWgQFPJyTIWZZMj_GmQeQq7_0C-xhqGRLs4d7r4
Message-ID: <CAJvnSUBEBMaFiaAp8a8M4CLCKLV8JEgZnu7O5hkQ=LjN5znVpg@mail.gmail.com>
Subject: New AWS DPDK CI Testing "Lab" and Patchwork Test Label
To: "ci@dpdk.org" <ci@dpdk.org>
Cc: dev <dev@dpdk.org>, "Brandes, Shai" <shaibran@amazon.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, 
 Aaron Conole <aconole@redhat.com>, Lincoln Lavoie <lylavoie@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000004cef3906339bad94"
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

--0000000000004cef3906339bad94
Content-Type: text/plain; charset="UTF-8"

Hello all,

As has been discussed at the DPDK CI Meetings, Shai Brandes of AWS has been
working to set up the infrastructure to do per-patch testing for DPDK on
some AWS x86 and ARM environments. Currently they are doing a DPDK build +
dpdk-test fast tests on those environments, and reporting those results to
Patchwork under the label aws-unit-testing.

You can see an example report here:
http://mails.dpdk.org/archives/test-report/2025-April/872683.html

And an example of it appearing in a Patchwork checks table:
https://patchwork.dpdk.org/project/dpdk/patch/20250424133128.133900-1-viacheslavo@nvidia.com/

Shai will also be at DPDK Prague where we can chat with him about any next
steps for test coverage on these AWS environments (like running DTS or any
other testing options).

Thank you Shai for working to get this online!

--0000000000004cef3906339bad94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello all,</div><div><br></div><div>As has been discu=
ssed at the DPDK CI Meetings, Shai Brandes of AWS has been working to set u=
p the infrastructure to do per-patch testing for DPDK on some AWS x86 and A=
RM environments. Currently they are doing a DPDK build=C2=A0+ dpdk-test fas=
t tests on those environments, and reporting those results to Patchwork und=
er the label=C2=A0aws-unit-testing.=C2=A0</div><div><br></div><div>You can =
see an example report here:=C2=A0<a href=3D"http://mails.dpdk.org/archives/=
test-report/2025-April/872683.html">http://mails.dpdk.org/archives/test-rep=
ort/2025-April/872683.html</a></div><div><br></div><div>And an example of i=
t appearing=C2=A0in a Patchwork checks table:=C2=A0<a href=3D"https://patch=
work.dpdk.org/project/dpdk/patch/20250424133128.133900-1-viacheslavo@nvidia=
.com/">https://patchwork.dpdk.org/project/dpdk/patch/20250424133128.133900-=
1-viacheslavo@nvidia.com/</a></div><div><br></div><div>Shai will also be at=
 DPDK Prague where we can chat with him about any next steps for test cover=
age on these AWS environments (like running DTS or any other testing option=
s).=C2=A0</div><div><br></div><div>Thank you Shai for working to get this o=
nline!</div><div><br></div></div>

--0000000000004cef3906339bad94--
