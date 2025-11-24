Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB29CFD313
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 15:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13C7440673;
	Mon, 24 Nov 2025 16:46:56 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 452B0402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 16:46:54 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso6989211b3a.2
 for <dev@dpdk.org>; Mon, 24 Nov 2025 07:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763999213; x=1764604013; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RJoMkmY6ZFO4JV54yFd4aoPtVmc7+kHd2JSXEIQir2g=;
 b=HByYOoVcZNEr+Zg5vXcVWGP+CGWsAi8z9O7IlDrGRMWbz/TriC6MOdJ+FmGxG4wS3V
 oj1o87/O28T6t550MUrnyiWOBPbpmAF4mXg9t5VyfldqiHvp8vNG0nCe77vXkXKXehBa
 S6/8We7KOV2cXpMDFheXUahqGkaQlvZ7NCctc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999213; x=1764604013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJoMkmY6ZFO4JV54yFd4aoPtVmc7+kHd2JSXEIQir2g=;
 b=J3p2BHXLOi/WSWsmFBaoayXolmPt6Ik3QKF2TQJLEI8dEEuR+OmkWqGunRUPxuuaEd
 KgctlBQRMPT4QKb+UO+V+MFAjLWCt0sTm7wz7lKJ8rT+BNZLkAEHKF64gjwZ8nL2rDRE
 RardsHfh/wjAcfJusJggxt8Oeihpo7BoIjw4sXeXyVgj1zHgTJxK670hhGAstASPdrYT
 F3xYr97RkTH1h0dYhzK9VXKJsb9VCrM0b+9CHsz+7qILwNIkEQvOY25wnQ+ux2hbq/zf
 QTEv0zNYszSnF3mNo0c94dGhABe4tRofdIY1/mvS/il/r6W1978KWE0SQwqCft118RPK
 ApeQ==
X-Gm-Message-State: AOJu0Yyt4j9ZxdtORNCvWdApZ/W4EXH9A0cIL4VftU16x7uq71kVaTO5
 UrZST+v+AjlQYzFFROfAaQkelBNYQLsnMx6Soxg7BEo7B7ZEitaglfhfP80PztPM8pYk48t5oVk
 qCiEW8IZzMeWUBu459yzCB1ICrnmmOZJ5Edd9XG+yUmtw0zUcvZJsrvFAiQ==
X-Gm-Gg: ASbGncu4tkfzRxwk7/+Xi5Xi8s+W79myrX4vL4le1De2cEovEjCD7ZDcorNuDp7CObZ
 7TfdAU6QNcr+UKPjr4mwrenfQTSTaLQjOJSm8m38RHP5E9UhhvJE6WXqoRzvmAox4kQFSC4ZSC0
 O8zIeAgmjwX5SJHEV6XeCjHwDkInMFvTTs8UAMGoB0Ah6JWj3aogbT+vhFWMmRRMHuynB+QSjlB
 lDssdClzdLZOKaPWFAgGK2R5zU+0YCxK4o+J9QbAGCGIzP0kKX95Yl+IaOBHWsbU3hgSQiB+tCe
 sqFUq0aKlcGpuHJdPan6Hb/gyv7LQ1O8eWpm/Lc=
X-Google-Smtp-Source: AGHT+IFu9Dg6VKHWnfOl/iS42dpAM5U5a0P/0hr2y0FJ841iEp3Sq44l7gIioR3JgqQXMMUproB4z+hYe4EMwuBypFU=
X-Received: by 2002:a05:7022:3c84:b0:11b:b61a:a497 with SMTP id
 a92af1059eb24-11c9d8635c7mr5643724c88.37.1763999213281; Mon, 24 Nov 2025
 07:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 24 Nov 2025 10:45:27 -0500
X-Gm-Features: AWmQ_bnj3QHBl33As87BehcBIxbOdV8wfNLj1IO4MFUL0-FCBOKUjSSsnteFE-E
Message-ID: <CAJvnSUDjD31LH-vLZWw-OC7B8uE2Kuw6NESwFpvkBDF+AaR=VA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] tests: fix format truncation warnings
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007df3d6064459126e"
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

--0000000000007df3d6064459126e
Content-Type: text/plain; charset="UTF-8"

Hi. There are some DTS failures on this testbed due to misconfiguration
applied by us at UNH last week. I'm fixing it and rerunning testing which
will update the CI checks for your patchseries.

--0000000000007df3d6064459126e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi. There are some DTS failures on this testbed due t=
o misconfiguration applied by us at UNH last week. I&#39;m fixing it and re=
running testing=C2=A0which will update the=C2=A0CI checks for your patchser=
ies.</div></div>

--0000000000007df3d6064459126e--
