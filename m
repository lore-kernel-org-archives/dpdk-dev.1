Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD88FC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 14:18:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22BD9402BC;
	Tue,  1 Jul 2025 16:18:36 +0200 (CEST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by mails.dpdk.org (Postfix) with ESMTP id 2E90E402A5
 for <dev@dpdk.org>; Tue,  1 Jul 2025 16:18:35 +0200 (CEST)
Received: by mail-yb1-f169.google.com with SMTP id
 3f1490d57ef6-e7dc89108bfso4866493276.3
 for <dev@dpdk.org>; Tue, 01 Jul 2025 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751379514; x=1751984314; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=Je7fQnodCYdlXA7ick+NLlfKD5JtsRIqCkBOvxjhrEkaQ/+lnH91hw038y61nvUPPV
 Phnw/BZLtjAsGskE5a+dt+Qw3brWUephAKKaDolttUet5Gbpsx77kFl8ww1qXMKWymyo
 AgJH16WIHfmuplVXjFYs6AjN5cumpFka0PzB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751379514; x=1751984314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=nIteR/eBcnp2uUabsHbhXGLIRJ+SStBQuxWefCynKm9T/GGxahzntcgJu5mFeGKumM
 aOxlGlQk/k9n6m8Bxab95F9tOB4ofkkDzYY6r1bgG+cW8XCw4Fn/e/Vj4a1/B0oAxg0h
 ExGhZDc4k1KGKnnSV9ijk997ikqxflEiD5e8SxYL65BKrRPUKbnNhHWD55aVpLND6Tt2
 YvPhC1WKLFE5DLAldC8PVfM8mDY1LX8rVpNMVJhJT+KwalplrbHxxqdu3e+QIihE8SQ5
 ZNhQr5RMWZR10tOGuIGW7TVQQNNIvrpZ0mAgi6KXq7Ut1TeC9AFl0pbbLdCijrBo2s14
 JRiA==
X-Gm-Message-State: AOJu0YyYTrPTXr7xMKRpcOsBslp6bM1nJGIEfFxRApf9fVvZrrabHlfX
 RHIgoOvAfQ2NI5E7NYCO99rjL2nAKeyOtuvF+lOA+7E4J6W4ZoU6TJyTudclgHJRq05GbDLK3SO
 Ez1nv3yDLgisYTGSi8XL1a1zq9Fo9pibpGFKKFz2EHw==
X-Gm-Gg: ASbGncs2ppQ8rJWCMnfsdiSsbr0MBkKM2a9soJN8rsamrPIu1+TCPhcR5br/MgJmENK
 x0QSbkIQonQwTRs26rz5XPJc6qVqW44O2eCCnGUV9hzaMqYSXakHW4bl8wsfz7mBFYAMyhGaWD8
 P0kFlBGznP/YUGpXgUYPCdZpc3rwux5SLSaaekhseGctmhYh7llQ9dEBO+5CnyZAjbuD7duw4mF
 c8e9w==
X-Google-Smtp-Source: AGHT+IEHzk1/awf8YuVoJ0pQzmZP7Ee89wig43TyYJPN6FW42cUwoarmyk0CVv33zhNoFM5H1yFsnoHv5UsumlhH/2Y=
X-Received: by 2002:a05:690c:45ca:b0:6fe:d759:b187 with SMTP id
 00721157ae682-7151719258fmr258589627b3.24.1751379514451; Tue, 01 Jul 2025
 07:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250627151241.335114-1-thomas.wilks@arm.com>
 <20250627151241.335114-3-thomas.wilks@arm.com>
In-Reply-To: <20250627151241.335114-3-thomas.wilks@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 1 Jul 2025 10:18:22 -0400
X-Gm-Features: Ac12FXzWfi91t8LozaiekORKVHD2F_0inkInzX8WKd9ptST5xFobvCduymo0U-A
Message-ID: <CABD7UXNk2bVYpEjUOxLy2BfyB+Kc6+tuJVUy423GiB6=0k0PgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: rework test results
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, Luca Vizzarro <luca.vizzarro@arm.com>
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
