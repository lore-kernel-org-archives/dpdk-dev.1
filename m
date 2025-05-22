Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8B2C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 15:05:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F46C4060F;
	Thu, 22 May 2025 17:05:11 +0200 (CEST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com
 [209.85.219.178])
 by mails.dpdk.org (Postfix) with ESMTP id A94CA402E5
 for <dev@dpdk.org>; Thu, 22 May 2025 17:05:10 +0200 (CEST)
Received: by mail-yb1-f178.google.com with SMTP id
 3f1490d57ef6-e7ba37b2b5bso4771354276.0
 for <dev@dpdk.org>; Thu, 22 May 2025 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747926310; x=1748531110; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=f9OOPr0yH6RtFeuuyejbIGw2klJpIOd1TEXj5uQ3HnmPbs4Etgf7rAG+ugrdxjds9H
 rNP8UR7YJVI3QuhpF4PSiY7rlggwNOQhDZcAytj3NXX4ZAK4PS3p4Qo00Dd3I5vV5luz
 /QuUeDoDFHOcWsCM+4EmbrWwYyA0ebM8KMylk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747926310; x=1748531110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=QEhY7v/59pK4WGzR7YSTEECTvrCL08KLxj6mLcF3tsa0b+XFRN7cmatIMrcp/R07F0
 83hf/luOYLbA5nX9mNmH+70AL8IzVnYzfw21j5/oPsBwZrmHsousFAISd3o/dCv21Vob
 Esb25lXx7MXV9mEIhMyoXaCJwdDynJRQn3cS+jf30AHhIFI8NL7X2IjInPleGDCTj6ho
 MqI0vKhjDJKRLsZoVDVzpW/uM5SvSiNdDf43PwKZihDlMVkpiMmZQpK0r2tpWJ2YRfdL
 JAsZhxin6OieFH3FoA++MzWYl2TIaZxw2c5mDRxXRkTf/z18rrcIeYfqaFfZagtU1ogz
 r+iA==
X-Gm-Message-State: AOJu0YwiHBmvLf7c88hxapfrgofChsoTNHPtBJpiuGMyDrWgKom8vjZK
 Sc5Va3O4MQn57l8DX5KrB73mPjmtMtE/ZhgleVGzfUzW8FsektNOtjfXyvScm5zisN7riq3sDHG
 UOOol4bUFQWkUlB5/Iv7LIRbWZQO0AdFaixz6Sl3TiV6R8lVXzAr0
X-Gm-Gg: ASbGncvc8G0NoXi4zSz5bej4fzrHZCRu48jCeXzw8tJmHYF4ezmFAynIoFNpqQcPfVJ
 xCvm3VWsk/lt4PQKT5WpGW7LOWh1wItXFp5pJRRVXZM5xMX5jtmUJmLrNALQ6QsBIvDtcEkE9f5
 K1iJe/nG6jU+I2I7QBj3UdpmEfXRI3MgNjAYJaDSRNkFw2jjtnGgCmuV3hGpazTGaoiM0=
X-Google-Smtp-Source: AGHT+IEoqTPrDe6mQgIuE26KIyu+iOYGfXDT9ecWC6v/Wy6sZ6fTA8KD/2psF3r2wNJjqnpo/JxjzBX8ulJuXTcf/vs=
X-Received: by 2002:a05:6902:6005:b0:e7d:73ff:10eb with SMTP id
 3f1490d57ef6-e7d73ff1211mr2136906276.18.1747926309768; Thu, 22 May 2025
 08:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
 <20250516201834.626206-4-npratte@iol.unh.edu>
In-Reply-To: <20250516201834.626206-4-npratte@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 22 May 2025 11:04:58 -0400
X-Gm-Features: AX0GCFsuGt0vGtYVmsObmRXjEsBn544ApJ1WDfNpW5LaUFKLZ8qLPaaJ_4wr3DU
Message-ID: <CABD7UXOs7rUgxdVS=jhzZpNiaCT_D89MepxgaNnveDUzrtrWJQ@mail.gmail.com>
Subject: Re: [RFC v2 3/6] dts: add asynchronous support to ssh sessions.
To: dev@dpdk.org
Cc: stephen@networkplumber.org, luca.vizzarro@arm.com, paul.szczepanek@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, 
 thomas.wilks@arm.com, probb@iol.unh.edu
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
