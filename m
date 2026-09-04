Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B7CC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 16:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6E6042D92;
	Fri,  4 Sep 2026 18:25:41 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 35BCD42D9F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 18:25:40 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbee846deecso1509053a12.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788539139;
 x=1789143939; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IfCt6uCHFCl5dG6OHwi0CpIEG7P/fsE7Cv+EKcuvzkQ=;
 b=z6e6w2tTWLULd5csKEvk2hHJjHhbczOw37RcqY7vBe6PQUP1F1jVz9W0dpwgND3Dwt
 6fJbtdRcPff5oxhPJh2mzRUkzZ8B8IZ+ERjLio7MFpzccDJtl4rn1g4/cczOc/sUvEO+
 aCUTNBS/3EkXgmCIZUqAIwdtdKXQ7UzGFQcH/jqB+shyRP9nG3ZcKq2QULczEIIvi6w0
 Ber9qzXDZihkzu+yb9tnWaX4pRoDirUen3Kgf3Gs2PyRFCjwNRbNQu35/jr0b0mXdWC5
 Iw1jBVkYxf0GTljApMSwPcm/4VRXH0PDjpftWf+1YunkGEeR6Q57/Gs7WHsaNppXQCmW
 fwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788539139; x=1789143939;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IfCt6uCHFCl5dG6OHwi0CpIEG7P/fsE7Cv+EKcuvzkQ=;
 b=bxlMP9HaEowm6y9qo0Rcb6ryyFIUanX4RcJwsygtLl19D9sTuZ/1vB5CWAVtQf9c0r
 rT8dyZIAsvSkpK4khFBUEqQ9c3y7VVHiY+0IlcWgnWMNDojxnQTeghUJnppxK/dHSuAz
 FcbdANbHWOplbMBR6fr0yBrObhG1yPmRzptShzOBJhR8+beDT0+q7xp6ey/SYPJuXuR+
 0NRmCzi//LSnyuiie2gVhIgqIlleALbEKMDiItLm7VXCM8oA/KikcHd3craxuPVgMmCT
 2DezoTxM3YT0m1hLAZZA2QLORX4CQJbmzoW1H0Ge8dZBUwmKaK2zVCeOP65sNBDg1hK4
 BNVw==
X-Gm-Message-State: AFuF++nXcfM2mBmMJPlRNTr3fqQ5vt/6G/C1JZxebMU0A/OeEg53G8mr
 1tLyldLuacmRw4gIVTui5LcVAstn70p1N23bKerN+knVFkGtyDOvdq9hfnNlaN3bA1w=
X-Gm-Gg: AYBFou3cX6TsNX47BCyOjg7cuk4nHcAeFiWSIOZsrQjGjDq0oM2cqpsn32/PKhjW3xq
 4bJ5KzHsqsHQoSvicODY7x+BAiFntMm13tvBpMjVu5WU45Kk/77V6C7qH8yEJVsLTwDtpyiqfsa
 nmab02exHMAgr75YGAnTqEx+fzCi3icis1C4b9I0RmKQYfIBZANsncOi8X7Wotxw9fYcNstrev3
 P1cYd/4YKhE/pV0JItxTbgCMHZ9LGz3agIauxVM6/Uoz+Zvr/lKYQmhz2r6SCqXO0ZysbkdT/pQ
 OLUKOypzolsgqvLY7wKUiHIyKiKdYgIC3A9obYAsYdEyHkKx84Oo1UnfCThiwuOf4hIwk+sC2bP
 cr+w8CJvbQXjwySScLKxq4WBaQVo2EOPJXLE0dswtDRsFzFgCEg9Bqj3AbS2RYeY4rfDi+SmXkt
 L1HsF6W4H+2wExeThKH7NBDTM9a8fTZAUg9qsbbENYEmGf9ezyOdQMaLF/RUw81tKhSvh0u5mVD
 27Yl8yNoykGluKnefShk8e2RIpCn8tcpFGymD2R
X-Received: by 2002:a17:90a:da8f:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-39b26299957mr10548709a91.25.1788539139008; 
 Fri, 04 Sep 2026 09:25:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae8ccdecdsm4902421a91.2.2026.09.04.09.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:25:38 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:25:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: |SUCCESS| [v4] eal/x86: fix memcpy alignment mask definition
Message-ID: <20260904092530.04422afa@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A33@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F65A33@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 4 Sep 2026 17:02:24 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> The simple AI in our CI managed - for the first time ever - to not emit a=
ny garbage at all, when reviewing one of my patches!
>=20
> Maybe I should stick to simple patches that don't really change anything;=
 then it doesn't get confused. ;-)


I have a patch to make AGENTS and review patch smarter, but it still is wor=
se than local runs.
Just sent the latest update. Still needs to be able to look at existing sou=
rce
when making reviews.
