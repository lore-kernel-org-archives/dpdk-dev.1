Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2127CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 18:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F39142DE9;
	Fri, 17 Oct 2025 20:15:54 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3FB1942DD5
 for <dev@dpdk.org>; Fri, 17 Oct 2025 20:15:53 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so16679245ad.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760724952;
 x=1761329752; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1iWHlKMNRCY6z8yv4J7Kf83aWNE6Nzp7kIu60B4ZEI=;
 b=SoObPV2Qsa7OLv9T6WrG0skA4eX/0y05LFMLOjzpxprh0qnFeSKzPvw6Uu44ePNLw/
 h8WoeYRsZFbsAtAcdNftEUl6+1UCQKwik+mnrfB9VW5NmI3F6e2J8PjdGWYtZ7oP9NLV
 5svYkq57VqTshZ7r5kFMPe7ruC+7w9849PRonKbotPM0i4kGKSGpoQRJCDffWl8OteKK
 4PrUAG5AtOCKtcN4ntQOfAs/m8q615z598Nf+7gtclrSksCBKotQTn2nPTzgaJzdazAQ
 X07ZoVHXcNKAG43+7dKdIZKOctnUFGlOEsIgqKgGGg4RqyVM5Cmu1gK0b6K7mn2bCUKy
 +GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760724952; x=1761329752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1iWHlKMNRCY6z8yv4J7Kf83aWNE6Nzp7kIu60B4ZEI=;
 b=lo4SEFcCsqA7lIZQ2pNppEcZGSdEHv5r+fNvyCO0xmEHA0P4dgghEncxYm4I/jqXc8
 RWyG64DmBr0qmb1S0MDnjQPhU5WW3iCU2Fo5nUM8zfXw3oYS6n0FGVS3HWAdvkj6jOE7
 h+E/xUTeyXbEJ/BO3jtzN4a+rT2aUp7T4R8V+NLnsRIs3Gkiw961tf8jKd/1oI12u7FS
 VE1St5YvFxTgf6uWaYrMBIrOCMy363H8+sGrBH/bFhdm7+auDV+1D3acr5/Yhlg7le18
 IHlVlQYqAlVqFGz2BPSfgmeYc9HdXUQyxY0xyF4O/h015G8avMF4Y6u+FimrfR+Zd288
 iywA==
X-Gm-Message-State: AOJu0YyngmbtnSgtNybVfHbQaaVoTc3sKSlqSUqECMuqlTv768dKM3Il
 o9QpeOYhyFn1gHGWG1I1XtR0L3UTv1BCmhUH0L0o7pfrv1sy3cboSdjIKVMGmjJfISs=
X-Gm-Gg: ASbGncuv67CZ4btCOWpwy/Z1DSLZVv+/J6MP4S9KOmNjjLE5ik5MuzHRoxc4DMpDTLl
 ODRPWzab5pwK3qC3clPdBrZ+Eg+CABNeAE5F2JWxxX3UwnhfFRDN1wJ1yMFXzEKT+QU4pB0hdqS
 WfmRVlRBbCGXbueA8SS2mYy/QeOkyqR8PdQ13nGtbguFiD3LFdydKFHTfoyV49ti0wMXrFkS3Ct
 zxsmGjmC0VzK37ROfOK6yeY7y+tNPiWP2HeMWmizun3fDHUMq1EoOMo0XhrTfRX8t0CG9PIOyzY
 AM2mdnsb8vepCfngPXOjox37pT9vaOP8UlcMLq6b1G6T/r7QWfkZEQTE+GRO1+17GR3JPAyB0w2
 Bpo+mUf0KZzFN0PgkkHtORVdvsere0G1E9V6mwVumAp4QsqY7yfyrSBSke9LnedRb8FhTlZ6aNw
 zd8n8V9HMIn8kWLwQxFFJ4Xt8ySaOEtQBWwMJ1Jn0=
X-Google-Smtp-Source: AGHT+IFPCxu3rwcdaHzus7xTV9uGzgmpnHuuS39RnZcfSqhtu8lgOp9XHGYI0bnh+5UiNrcyUmGyOA==
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id
 d9443c01a7336-290c99a8ed3mr59448955ad.0.1760724952237; 
 Fri, 17 Oct 2025 11:15:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebcdefsm1825405ad.16.2025.10.17.11.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 11:15:52 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:53:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Vanshika Shukla <vanshika.shukla@nxp.com>,
 stable@dpdk.org
Subject: Re: [PATCH v5 6/6] net/dpaa: fix resource leak coverity issue
Message-ID: <20251017185338.4e1e6d51@phoenix.lan>
In-Reply-To: <20251017044848.3269627-7-g.singh@nxp.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
 <20251017044848.3269627-7-g.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 17 Oct 2025 10:18:48 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> From: Vanshika Shukla <vanshika.shukla@nxp.com>
> 
> Fix CID:362787 issue. This patch correct the cleanup
> order of PCD and FMan handles to prevent resource leaks.
> 
> Fixes: 4defbc8cbb6d ("net/dpaa: support FMCless mode")
> Cc: sachin.saxena@nxp.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>

Patches that fix Coverity issues should use standard tag.

Coverity ID: 362787
