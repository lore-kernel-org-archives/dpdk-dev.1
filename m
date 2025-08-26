Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F0C8303F
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 02:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F1FE4021E;
	Tue, 26 Aug 2025 04:31:51 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id A4BB840156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 04:31:50 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-24626e06f04so31413295ad.2
 for <dev@dpdk.org>; Mon, 25 Aug 2025 19:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756175510; x=1756780310; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gxv92ipBMn416KzfceRs+hp6lBIK1lCAmlipWIIyp2c=;
 b=S4etJqMlJu+eb+R7jfLJ+wRCS0DEdoIYg27TS5fm9ckijXVZ2YnfnL2bSJ4B0BeN+0
 qc91YMgljAvlfH6dH1X/gJTySf/btVj2HMSBscJOxRSdwMFPDwtliSX1K+UtqsqtwFlO
 4agX+zm0Rxfl+VndMsDNfgEJnJcaw4DJc9/S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756175510; x=1756780310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxv92ipBMn416KzfceRs+hp6lBIK1lCAmlipWIIyp2c=;
 b=EBkQ8PB2P7GvpEKZrQilHUZ78JOMvsXzOooNGVHnkycn210A7rLOw3N7dTtKUZipho
 3HNLRwqRpvIB+KbvPfuLG1KugHvpW3LjFSie6IfDTspGFq0FAJ+01M2wpz/IJ1MCHS2/
 SWaAIiKqveEx2jziKgJNuiqsa47CZdhaGCZV9xuJ76THsjUmtTYY2194hG8/mJP0dxvG
 /+NqgD0L/GhnQSJdP/PLmDquZyCI7R2sXeHvGT+BQO2c3vmbQlhXYt7RM0DfQXHk1n79
 b5zyKvLoZN0iOwWW8j/0s+fvh1lsH3TUmXgPDTcvdVngA32JhDggNrckrDldEIRNBS85
 D0sg==
X-Gm-Message-State: AOJu0Yz2FpcLsnWz6npK9Ji29yn+wPEqWmbU1O3DIyAe/SDlCIitgRxn
 PZrWMzbAPaRzkr4OkEFRWsgP79gD1ZSagclt3XeOVjOMaQ+GuZMs7KL84lWWGsJM0dhy3ApZIpP
 505rz0BJdG1fgpQcfKqaTbCrnqHs/ryFDmO5JDljweQ==
X-Gm-Gg: ASbGncvOfPoe/6f3Sljcx4WSaAoASzY2dOGkUc+GA8Zlo7TOhfU+LyKUl1fmUUjlg8e
 +IWSiScP2uPZ0+glg73b2bBJzM8pag14nFj58Ibj/rd4afoYV7Y2Q8NK36jYwfpJGNC5O0F1p9Y
 gxA3R4HZ+vOjZPigiT89ZbEYYD4DMklD+8JDQeHXGUyo73f9j7gXiedTDKV9b/cvDon9C+rsMOo
 qIoLEFOqCzN55zmhzVM94C5bOtIBzX/0K+lTz8=
X-Google-Smtp-Source: AGHT+IGiW4nDxT/BXefCzmD0UX+ytxP0TiXF4C6X+LIA4kG/GMCWI6o4RN8rEw81oWdsLdXX4l1Qkb9PB0OPcV0y4bs=
X-Received: by 2002:a17:903:234e:b0:248:6d1a:42e0 with SMTP id
 d9443c01a7336-2486d1a4610mr2373985ad.14.1756175509775; Mon, 25 Aug 2025
 19:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250718150404.200096-1-thomas.wilks@arm.com>
 <20250730125859.159185-1-thomas.wilks@arm.com>
 <20250730125859.159185-3-thomas.wilks@arm.com>
 <CAJvnSUDKEV26wS=xOE2oVMfwOS3xqnTV-OP70PGfBNRcBCeGkQ@mail.gmail.com>
In-Reply-To: <CAJvnSUDKEV26wS=xOE2oVMfwOS3xqnTV-OP70PGfBNRcBCeGkQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 25 Aug 2025 22:25:13 -0400
X-Gm-Features: Ac12FXwIymHfpUD7ktr_38DFSrkrz95MZXqdJkMM4VQL16Fhz06rBRI5bBggQQw
Message-ID: <CAJvnSUCDsxDg3M99NMF1JJyjfTR-5HqA+05-TJrsgkvvD77PaQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dts: add PMD RSS testsuite
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Ivan Malov <ivan.malov@arknetworks.am>, 
 Dean Marx <dmarx@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000006c7df3063d3b7985"
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

--0000000000006c7df3063d3b7985
Content-Type: text/plain; charset="UTF-8"

I forgot to add my tag to the previous email.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000006c7df3063d3b7985
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div>I forgot to add my tag to the previous email.</div><div><br></div>Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div>

--0000000000006c7df3063d3b7985--
