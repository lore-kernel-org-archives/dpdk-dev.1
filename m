Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC99C61CE8
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 09:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F6BA402BB;
	Sun,  8 Jun 2025 11:21:53 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id F17834026C
 for <dev@dpdk.org>; Fri,  6 Jun 2025 13:16:09 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so1570111f8f.2
 for <dev@dpdk.org>; Fri, 06 Jun 2025 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749208569; x=1749813369; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=olCAj6JPifMPH6du6Mgv1C3GxJ+QAH8TEeeQFRreBGk=;
 b=D47OxDbYfW+CjGK/8K2nl2XRdPWmXDNWKloTz8rxm2Xaa2H1j8wqhe0FRQtWicHiXt
 Yk4/Y2f5eChVvueXnwVfipuC3O3fwjFmH1GGttryG6emDGqiJPLd5vwRHf5ZYutFlu6B
 rHF1xmf+aUmWfx0M+qfVKfNprn0FY+V9+b5iDcoKV6ulzPulxZC1nQIWJNRtUEKVmtE+
 8d89tIh/CptbRD23YrxYD04UZ4BeOpoGWRyc48fd+LHkDnASCE8/cn6vveyC37q5cncq
 fQKGsMZcuJ1zVwa+FexdKs0oRUVam5z7Gq4gD3WA7sG3JKuT3tcmC/ngOPQrPsbX4Eo6
 CpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749208569; x=1749813369;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=olCAj6JPifMPH6du6Mgv1C3GxJ+QAH8TEeeQFRreBGk=;
 b=dFuMp+a1Dgi8vvsZkkeiGdW0NB0KyQsP1xB5oL1sof70mZ+54B3OUUCZnmy9lvm/mX
 CSlWkUoa+HZEG7Sq1Goz7rOYZnL5EV2p0J2n3JKZO+MPI4K0LLoNjRZPdgjQ7TwCTX9H
 TZkNRFKnmmkh6Du02dmF7mbdcoaJ7uHKLtgktmBXje6GvwKSOuEgv8jrKtH/Vn8T4eVi
 tOM2XUqR1mTB8Md1mqC373RyglsqlpVNT1xR8mNx+0mKIzscjDfLRLLMNgOBHWViDupL
 Q2chWgzVxb+ZfVAgNJka2vDvQZgzJ55PlY2MFOrczcrxxl4yc7eZxJzf78RrsHeJ34aT
 s1JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWj4uNb4rzs2o4FH8QQgNZ9vA+8r4P5df1rW/5NIHsT8DadF0KTuNBKryAvF1OKRTg5Bw=@dpdk.org
X-Gm-Message-State: AOJu0Yx65/r4jhV5Lda3Q+YUdUWXjOCsx3+RDyQusXSFPX2/bVRdjjtl
 fZGoznL8GCTfI4aR7d65nu2Cp41HtDNBJf/Fk04aH2IYgeC5KVToI8QmdMlZSpSJ20r54lQmdJ2
 oEgUd3mVk05h7Tnkkz9mknJ8X2J33jmY7GA==
X-Gm-Gg: ASbGncvYSHxcjTJRdnhC2VA7xicJHl7+eR397eTJRWZfgp4u30vOG/W72fNyPzMrSO/
 lsx2YkjUNGapaIbtg+DXwYOEzo516ycwqtpb8hXmRm8IraTwTRXaDqYsPkKFQxHsoVxJHnMq6gR
 4TXsge36I/tRW6jFacP5eGJ8xV2m1whMl21aBoMNxmmwgA
X-Google-Smtp-Source: AGHT+IFsk5yiewaq14yEMeZBRRwxd3YYOk4DtPTPI58CKr3xc6Y6aG6XKBPW2MFc0keIGor2x6ytoDroGca4M97WvJQ=
X-Received: by 2002:a05:6000:188f:b0:3a4:fe9d:1b10 with SMTP id
 ffacd0b85a97d-3a531caff2dmr2324035f8f.45.1749208569206; Fri, 06 Jun 2025
 04:16:09 -0700 (PDT)
MIME-Version: 1.0
From: Zhen Yit Chong <czy331@gmail.com>
Date: Fri, 6 Jun 2025 19:15:56 +0800
X-Gm-Features: AX0GCFu5TnF3MxMf0nV72AJ3u1HX0nEx38tSEd19GQDiAYkP_g-WXmAG85xdmgo
Message-ID: <CAFYAXgbM74G5Q0vgeZuUuTo3t5Sz=-9cz3hhRJbySpoOr0UpOg@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH v3 4/8] crypto/cnxk: add security capabilities
To: anoobj@marvell.com
Cc: adwivedi@marvell.com, dev@dpdk.org, gakhil@marvell.com, jerinj@marvell.com,
 ktejasree@marvell.com, schalla@marvell.com, thomas@monjalon.net
Content-Type: multipart/alternative; boundary="00000000000067ddda0636e55bdd"
X-Mailman-Approved-At: Sun, 08 Jun 2025 11:21:49 +0200
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

--00000000000067ddda0636e55bdd
Content-Type: text/plain; charset="UTF-8"



--00000000000067ddda0636e55bdd
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--00000000000067ddda0636e55bdd--
