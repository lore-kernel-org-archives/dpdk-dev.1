Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E13CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 15:54:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 804E6402A0;
	Thu,  9 Oct 2025 17:54:10 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7516040267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 17:54:09 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-72e565bf2feso11985017b3.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760025249; x=1760630049; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=jW3ZN7naDo9Fa0BCXZ8zZXKLc/Hjw42zCpvihtKWzHGtQOZ21OstsSxPQ8ZWb/+I1n
 wJToss5f/QLD5Tj4aa2Pmjbx7dN2v5+auUlSAtGt5XRI4d+JgY2p29ittILRrtrB0JpN
 0Tsfuray/9GClfBO4EvA/mjGHWm3arh6C7GWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760025249; x=1760630049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=be/in14yvPg2/+R7vX9qOtvTU6er3UDPci8LMSfmOiOJOTMsm/Jazo2w21gt6Gisix
 oB10u39ldRmWTD9jSpgtNptCGd97wqrnUFCuQO4qXGo391oZgaKx1qkvXcogDk4LRlYM
 tuQOUPrX7dtoPBODilcvTlbcXJQeIBTY1MJcIyLiHLb/PRqQSjkGz0/EGa39BWkhRfU2
 GVNODE/tvBvWiT2UIKZopFqir2MkJ8msZKTFe5lWE2ZL5YH+UYTyXKrBPsIxaDdHfrsn
 gHoo4W7MW5N9t7R4ZnX77QGog/lWTkpe2xEApmmO1FmLKQ1jtLAsUNRQVVUyHUdMZbRG
 I4qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXXAXOSBUhGwc1iXj6iQdjDb1VP1mgOX/ztQWtlAr7ZohLB70OWymFRbwSoKlBXLhUB2E=@dpdk.org
X-Gm-Message-State: AOJu0YyOGFhtvUh4MybW0Z1pqYKDdLmOnkBth4mrCAWbaqsb7tOVbv5l
 B6JRm8Rz3sei+asNdOyQ2pQORrs5C2B0NxPJYczveXiobrZbhc9Pjx2Q7C8jogHheoWJdeGiO3h
 fZKgIsoog0zjVQkFN18DU/RhGZ4WtBqCq9AcPMW/jpw==
X-Gm-Gg: ASbGncvmJbEu68C3VcWdrOrP1/jbCFo2WfAlx8WDYujX9imkTPmCZhYq9DclmpVDDcg
 lYPnYWWiw9WA90/0CA1LKp/IYGt3PJL3kC85YW3y4HaESmkuzpGH0U9qfwGvfA+N8W1dDJfs827
 YZAe1ckDqhfKj4T6MUQb2ZB9Wural+a/tLcAIgryPuC9rB0QbyH1mZVq+Jfh8r3NNAgF+jrB6mB
 YCBw0hIzfJ5Hsynajiyxb0QaTnvR1EMFKnuPTqfsMy+jTJ2s9IySFYT
X-Google-Smtp-Source: AGHT+IGkgWzKJ+pXXE6XPYMDIk2jjALDYY0/8s3/4FP41gqfMMOGyk4mNEWADW3LD5z08L3AD2ZBTLZPJsGV2biZPTU=
X-Received: by 2002:a05:690e:c8:b0:622:7517:af78 with SMTP id
 956f58d0204a3-63ccb85338fmr6006683d50.13.1760025248572; Thu, 09 Oct 2025
 08:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929172734.218467-1-abailey@iol.unh.edu>
 <20250929172734.218467-2-abailey@iol.unh.edu>
In-Reply-To: <20250929172734.218467-2-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 9 Oct 2025 11:53:57 -0400
X-Gm-Features: AS18NWChz82bpbwvmphJ8zmwmHyFaJ5HwNAPwaT_rcYTzJ6pT5JhTsXGD_WVt3M
Message-ID: <CABD7UXN048_rw1uTcPru6-7GgPuRGac66+KtUor+PJYmjMOEOA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dts: allow mbuf_fast_free to be set with testpmd
 shell
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, ivan.malov@arknetworks.am, 
 probb@iol.unh.edu
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
