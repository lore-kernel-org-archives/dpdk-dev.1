Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA20AC54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 17:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B73F640612;
	Thu, 22 May 2025 19:54:56 +0200 (CEST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id CA67C4025E
 for <dev@dpdk.org>; Thu, 22 May 2025 19:54:55 +0200 (CEST)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-708d90aa8f9so79766817b3.3
 for <dev@dpdk.org>; Thu, 22 May 2025 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747936495; x=1748541295; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=KVcB79nq2s89duB/QoP0MdhTownqHdqz27X3ERfhtfXBcVxgM68l888wGknPwZ5wgS
 l8d3BEX4C3slgV1dmqxKXUCoBLscreBLAAUCVtTQYOY9H8IlizMxFfGQcCzbRKFzd0Ix
 Pzd0PTtVuCuxjAaa7tvz2C/l2WiRv1mP5PQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747936495; x=1748541295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=P+J3MWX8hrhLhkY1VzlLtPt3lOd0VARLmDiT0IKGn/xsnFy37no2+NwOxWkfPYbuek
 qG6GkZohqy9RVCbZHu18fuwk762KB6X+pOi6QSWwhoy1UrtzMFBbamwj2ck6kIOB9jEG
 bEStMA9EY5K/Lb9ZmRkDIptCFpu+AJOdCZU1zC1hbDfxsfI1rlEtvhMuaxPBsc7PapPR
 QadKeQ/ZYuAayy8J287w7OMeq5r/qDYE4eRqVk0ywoQmiNeg0EJGLf38eIoRQWT8w1PG
 Ky0vW+u/2GA2KOZ8b7QA3j9m1ww39P0qSWNgeWf5gVI89fUM9l9X+iliVbubpWc/dlmj
 Ph8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDKn0FXB9LyGcI7SLpdL66g0qcdBxx/1Ql5vzejYHL4t7t7OtDs8yJ3VQoavI5gDPRUGw=@dpdk.org
X-Gm-Message-State: AOJu0YxnE7JIGcFFu+sSQuNcNqVWbheEYI2/fxd1OaBW4lVzqcX+iHBM
 jW3bmS09BqqOC3+DUeicQ7NYXMXDBzdKk/cMJPnAnjlfVyi7pQgVozvqOLXeiWypez9Z5/lJj1W
 qcA8HNXt59NCJO1tKv6m2K7ASMhfyT4SZdSgU2pDU2Q==
X-Gm-Gg: ASbGncvB/W9uYV8W++oggdGoKZ2WQcRqNJ8i+cokGvOaPP4VGEGMhE/8fs+aeLnXNdR
 Q1h+l0+L4xo1eT/bEEYiHAKyQCT1+wugwlkYh5tAu63sETDVgppEgP+Zl8QY3XAHWhGJiX0PzSv
 bGL20GFqgP14iFglBfDRc2CmTUG/RH+8GpLkvm7jQHH9fxttQVzy3+JlGBx358xVOD5hA=
X-Google-Smtp-Source: AGHT+IEHoT1wh5KEjwevFKQiPkCAMoJ32bWy44MUWQ1wWSjXGZ1nqxjo6/yJVTRkHa30Rm92IXUBtvnmINl+WalTjmQ=
X-Received: by 2002:a05:690c:dc9:b0:70c:9364:2c62 with SMTP id
 00721157ae682-70ca7c124b1mr356069347b3.25.1747936494990; Thu, 22 May 2025
 10:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
 <20250516201834.626206-7-npratte@iol.unh.edu>
In-Reply-To: <20250516201834.626206-7-npratte@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 22 May 2025 13:54:43 -0400
X-Gm-Features: AX0GCFsKEWB13b3ybRk3yZ69l7RCKOYlZOI2wf7xc_FEiAmLs75ID4QqjGdlz0g
Message-ID: <CABD7UXMv94hHk9nuHdciR30oQKKF0uqTRot2BMKi_AJdS7To=Q@mail.gmail.com>
Subject: Re: [RFC v2 6/6] dts: add performance test functions to test suite api
To: Nicholas Pratte <npratte@iol.unh.edu>
Cc: stephen@networkplumber.org, luca.vizzarro@arm.com, paul.szczepanek@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, 
 thomas.wilks@arm.com, probb@iol.unh.edu, dev@dpdk.org
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
