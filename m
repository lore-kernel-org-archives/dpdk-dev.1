Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E8FCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 20:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F10E4026C;
	Tue, 19 Aug 2025 22:46:48 +0200 (CEST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com
 [209.85.219.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7873940151
 for <dev@dpdk.org>; Tue, 19 Aug 2025 22:46:46 +0200 (CEST)
Received: by mail-yb1-f176.google.com with SMTP id
 3f1490d57ef6-e933af9f8b5so3331304276.0
 for <dev@dpdk.org>; Tue, 19 Aug 2025 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755636406; x=1756241206; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=BPR11/NytzZJwBuFmWW4vGAH3Ppbx7TvWU1QjqEHd9pv2rGdWcnbOm8bsQLby6F/mP
 kOzqDeQdfwAo+j5n+zLc0XR/feU0V945wOU7CTp6wzI4IpQx9cmxMqpxqqwIoNGuxsIM
 /5tG/loB5mQ2ivmtEKLpEAsgk5LKoeP5UfnRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755636406; x=1756241206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=goitZZEpO6m4lqhaoqUgGys97ahNppGjDBrV84MbxZRiEd/AGLnPB2JoWSFYtZXNp7
 0gSJbAjFnr9eo32W+lzrsanaIiO6OmZpjf62V6Y977qdndkvGy4o3cQiWLMaebexne1/
 GVTVhcsH/U0x/s6OmPAZhvSRGJKV9HB0Nsl3Gn4G4BLC6BxECjYWXCi6nK6nKi5K8dBT
 6ElITNgajm72YGbwednh2w2Ou0BiDOnzt0A6GbPapoD1h5AW0DeO4XNWMnJdfPZIJc23
 syEoCGgjemJqXeDqTvoxOGBlQf+EKny7ThWnc/lvtQEnGsc170vDr7qGGrw/zT0AYXCk
 9MhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlfz0BAbKhBTxTsTKr5Eca7FmQg7RjJzgg5oii21OIxfsvLIbQfiEB7OS0512ATA2UviE=@dpdk.org
X-Gm-Message-State: AOJu0YwEeVbg+cw6B596ixznmuHF6EGmQHoU8jVcA7jUZDy581latH35
 vGiqaOMSgvZAeEH3+dbUyMeCa78cOZB3uEOMdCS7+LnnHdP5k9OuR5wjnaTxhRlAKn5hBsUlFKm
 gk8FRoyt58kORxsV8aySFkVSW0SLR9dvUBCJJJItNgw==
X-Gm-Gg: ASbGnct+Yxe1Uzle5bVJgBGgipeRUlSr+3RmKfQPQPpfnBMokBI4XAta5apx/zCmLY7
 YjlgRkFX78TajFCgbm3EabVoGDWBNqdId/HJclB6b5u6yCgiozV0cZBSgM1dEqRz/0tF7BEegfR
 dH3qmWoR6Lj0ZueCDvpMD6KempNl2pgYnNJ4y8YYSCI2+nxdo1NKkTdEoE6izuXaHR6F4q6/8UW
 an3skS7bAGgCIWzcmknH6GM8IZrWkGkR9SiGoPK3g==
X-Google-Smtp-Source: AGHT+IEQR8P8qiNLupqAahFHhIhf5sy7ZFVTcgGLNPhXGk9RzgTEk77x3peCuxAZeol4wIQ8D6ZPlTeJdpFSJs3Ehjk=
X-Received: by 2002:a05:6902:1502:b0:e94:f716:140a with SMTP id
 3f1490d57ef6-e94f716192cmr421217276.19.1755636405763; Tue, 19 Aug 2025
 13:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250806162900.273571-1-abailey@iol.unh.edu>
 <20250818165054.447127-1-abailey@iol.unh.edu>
In-Reply-To: <20250818165054.447127-1-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 19 Aug 2025 16:46:34 -0400
X-Gm-Features: Ac12FXwGxdtQBsgfrWefZN9aoNa7wtWkzG8D4ecSmCDI7KF_9rb7NFCl1kCiAi8
Message-ID: <CABD7UXM88bGiGjbkVnAgmgeajzgAuojW+dnTRELenVP0f8j0eg@mail.gmail.com>
Subject: Re: [PATCH v3] dts: add missing type hints to method signatures
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, probb@iol.unh.edu
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
