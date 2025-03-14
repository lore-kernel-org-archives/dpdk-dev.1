Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140D3C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 15:21:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A8384029E;
	Fri, 14 Mar 2025 16:21:49 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 561A540289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 16:21:47 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2fec3176ef3so3689361a91.1
 for <dev@dpdk.org>; Fri, 14 Mar 2025 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741965706; x=1742570506; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=73WRh9g0L+gz4mhjPYNDSPnjlDU9xyv1S5UsqJJkvnE=;
 b=JhJfocepVMpbU6mbDGYKRfOb8sFJ38mrrGvOKpQF8hbWLgRZc2p+PLgKKQEaCfXsmQ
 R7/+SLREw//NJdIb8DfpAAL3kmqDgCN4abeb3yJpVrt6NtpZH6LQQxH3C1yALzznEghN
 3GqvSYaRWsxJqjIzaTcb1s2gWwlHlMhLJiWQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741965706; x=1742570506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73WRh9g0L+gz4mhjPYNDSPnjlDU9xyv1S5UsqJJkvnE=;
 b=CXUNpBWUeN74zdAAzN0o3u4p8tIWslR/ncgKeCGyQg5tGM224RDuGJYrvxQRqOoE2t
 4+TE6zhVKziPuXn0tvqrHbbjh3pU0D73izezUJofiFHaws6fyPYbQqC6qmrykqmSaLT7
 HAqm3zzvRWTwk/LRfQy6/fL/RhgtGDRfCbG7+JQoH4DZdvm+We6m0ggPsVV71sz8MgIu
 lBArKjbI7QsZ9PXi/JqUzzsM7riEGLFnwMi/ZOe+ltPY1wEE5OWKm/hIzD7Lmt7CZN28
 4kZyIcNRhc96nxRC6vWyZJFSiBjW0viMdiQvXpulBm6Ihis1KzeERXGoxh+MRYlbP0Rl
 BMLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPNWw/F2an2QEzgQ2fSqd90fnRqVjdFDTNxCCPVS6kREoSH0xytxj272dAPbhhroKT8aM=@dpdk.org
X-Gm-Message-State: AOJu0YwbdZ2bhELQl+ju9cdRppH6kxyqfwayPVynNL7dt25IN1Jqce2p
 hMdaXf9jD8NJt+gqEYxmmco69zps8DIQSrqOOY1S+dgo/xLSuInt5F7WGlzsF0oF4EB8KO7nRse
 2riqJIlE2gaz6/W9EKq++cntc/Li/q56EZ7JoKg==
X-Gm-Gg: ASbGncs1N6uDqHNrBZZuBk+zWLjNa/9UpMPr3TbMvVxQN2UqA1TSsG4Y4YDUFuPv88H
 ux+Rs+xDXftZBI7SY1JMAGmbwRPCH3mAorF9naUBQMxWUVz7ShyGzRpTYoDQdzU8IZOeOQoMfhh
 1ko9jWQTRNEEeQPMeoSvZhyVr+Duu1+J82iBfvvnQYKIXUZl6xDse6p6flDUYEY4DJm1WN5w==
X-Google-Smtp-Source: AGHT+IHvkDJjPNaG2+QVNVpXAkDAuCHiGVzF0Zy1UlmeW+jXuFD8lbzGim80FBlbT2Ojvf9GbSp8i3W7dqyikrU0+2U=
X-Received: by 2002:a17:90b:5144:b0:2ff:5c4e:5ac2 with SMTP id
 98e67ed59e1d1-30151c75f2cmr3360840a91.6.1741965706026; Fri, 14 Mar 2025
 08:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250207182634.168820-1-stephen@networkplumber.org>
 <20250210172050.8884-1-stephen@networkplumber.org> <3828431.VsPgYW4pTa@thomas>
In-Reply-To: <3828431.VsPgYW4pTa@thomas>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 14 Mar 2025 11:18:03 -0400
X-Gm-Features: AQ5f1Jpz8Bl_FbvkrkiSZingUptsBpjlUO0bN47SKnf-kmFA8PSJaLsG7ikq0K8
Message-ID: <CAJvnSUC+=QcAMwuxgiZpTG=LTyo7nv30QYSUbZOxBL+BwtfdSw@mail.gmail.com>
Subject: Re: [RFC] git: consolidate .gitignore files
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org, 
 Paul Szczepanek <paul.szczepanek@arm.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001e781806304effb5"
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

--0000000000001e781806304effb5
Content-Type: text/plain; charset="UTF-8"

https://git.dpdk.org/next/dpdk-next-dts/commit/?id=564f4abb42df0cdf7da8c53933705bc205642005

This commit on next-dts changes the name of this default config file from
test_runs.yaml to test_run.yaml. However, it is not pulled to main yet.

I can send a patch equivalent to Stephen's which changes test_rund.yml to
test_run.yaml. But, should it be applied to next-dts instead of main, so
that it is "on top of" commit 564f4abb42df0cdf7da8c53933705bc205642005
which necessitates it?

--0000000000001e781806304effb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><a href=3D"https://git.dpdk.org/next/dpdk=
-next-dts/commit/?id=3D564f4abb42df0cdf7da8c53933705bc205642005">https://gi=
t.dpdk.org/next/dpdk-next-dts/commit/?id=3D564f4abb42df0cdf7da8c53933705bc2=
05642005</a><div><br></div><div>This commit on next-dts changes the name of=
 this default config file from test_runs.yaml to test_run.yaml. However, it=
 is not pulled to main yet.</div><div><br></div><div>I can send a patch equ=
ivalent=C2=A0to Stephen&#39;s which changes test_rund.yml to test_run.yaml.=
 But, should it be applied to next-dts instead of main, so that it is &quot=
;on top of&quot; commit=C2=A0564f4abb42df0cdf7da8c53933705bc205642005 which=
 necessitates it?=C2=A0</div></div></div>

--0000000000001e781806304effb5--
