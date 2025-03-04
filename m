Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB5C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 20:01:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21766402EB;
	Tue,  4 Mar 2025 21:01:01 +0100 (CET)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id DDE65402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 21:00:59 +0100 (CET)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-6f6ca9a3425so54953397b3.2
 for <dev@dpdk.org>; Tue, 04 Mar 2025 12:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741118459; x=1741723259; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=J8gpyleVMh/GwkMc8BFP0NzQ0HcuawyKP+YULkw2Ib/Kxx2sRIVik7RN+gWjGt1fJJ
 MgX4plKg1s7rA/6pob12oOLkdWVPsJJAeDDWkoYd+kqdzkrEZgx7iFiy18SWtGy5jrgc
 xSv2prhma23pfAedamgRF6ZVS5kW6oukbvgvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741118459; x=1741723259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=JEPXeG870dmEzsD9YYHHnyJoGOzWCqpJW1MH62JeaCMSpBCWLO+qfx4DZUXCxbr8xv
 hNmTQMkj4N5IS4q24B1nZnVu17c5a8XMrx1F37boKKDHaR0MLZFTyyBpdtDemzjuZ1bt
 nusdis0J59A/1RnkJDHKoXbgTmPzz4d936XNomF79hTovQOYvLL1elxWVSnGjTcMSLCm
 +2hqCgbBOUxuUjJDO+l3wBfFu3Lem0AOzJ3+QPP3FbLquh3/a8FZc8aMpLsWqyafMaKv
 fG6jPS4+p8ntei7cQRwM7Y+Cq70pUsUbNqtyruErArTDleBVvMd5DaHwq9l6LGrZuc38
 KEfQ==
X-Gm-Message-State: AOJu0Yy3NNwgicwaHoH45ONrjqTRQtg1eSGGaLvpHimkhag+FAP1YLMF
 kOzj66flXVg8uwfBD7GJSbYsCJ0izsdmStNmDe60Mpfh8kvs4Ru7hoHAqzpwYdZfemjlaKPgyZY
 Pi7jtxFFTKQGsc0ajeH+AZ4pYuGo4K+rIrLDt5Q==
X-Gm-Gg: ASbGnct1lsIempeerMOQVrzsr+0V5GOHTyt+g2q3/FMrHrzM9xBih9kCKqtyccCO6NL
 Yq1AFzuIR0dKsl5cAeXlYpyPDlremxh4bOmlmc7RpnWZEZoCZyisYXTPaSoOAMefgUKdHcxDJPm
 enB5QZqXjWC6ipzv7XmVu/h5Vxruisb8e3mg4rQwLTwlYhB8EFJFWH90y0WK0v
X-Google-Smtp-Source: AGHT+IFfjjkDIN/TRmSStb3B/s2VCZ0oNEfH1wqH4SVV1GJ4KcwkbwoFob/o6mEeYNi+HQ21gr0OToJN1gBznm9QEFU=
X-Received: by 2002:a05:690c:4b09:b0:6fb:8461:e828 with SMTP id
 00721157ae682-6fda3027b0bmr8434157b3.30.1741118459206; Tue, 04 Mar 2025
 12:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
 <20250303145709.126126-3-Luca.Vizzarro@arm.com>
In-Reply-To: <20250303145709.126126-3-Luca.Vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Mar 2025 15:00:48 -0500
X-Gm-Features: AQ5f1Jocn63q9l-XoLrzUXJMY4qguHNlb9o9iKV77MFNUgpl1KFV2-sMMaEBs4o
Message-ID: <CABD7UXNP_2+_oKtxt7vgOBKykBHFhY+i0nnCu4O6yvwNiczTLg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dts: amend test suites docstring
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
