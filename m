Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D18C28B2E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68796402E1;
	Mon, 10 Mar 2025 16:31:28 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 3CE9C400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:31:26 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso7341231a91.1
 for <dev@dpdk.org>; Mon, 10 Mar 2025 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741620685;
 x=1742225485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUoBOD5MJM8G4SoKD+LhEyzOFi597PbPDx+XSuzELg0=;
 b=NQXWqJ/DoOhGKaUoLj4OhZe1mUs9YzHX1yayBmrkbrpi9NAe2fk56VnjKS+gBFDFd1
 iwg47lxTGRhi2MgVZnjBezpSfZNfMae5dn/h4QW56gfZitRKBUbKXxLXlefd//QqX2F9
 KLBVKtcwkefymY6AUFbPLuxb7CNRjhGfnBVDSvtR/VtOXQ5sG/7wXdUzXfvWWDdIFekm
 gErYt8bKOoYF1ukFDH+ZH5s3DWV3NN0KaiM2kbpNya52xeoNsqzhxkY5cqzkhHL9Sbm9
 HBfzR5g0BbllagMV79b7vaflHHe3WOFiUvr8amO/mh8dXhGlv1rneshiPTc3v81yFqGd
 Kpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741620685; x=1742225485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUoBOD5MJM8G4SoKD+LhEyzOFi597PbPDx+XSuzELg0=;
 b=tJhveQkhCd4yT42lawj/ND59lDXHbBPJI69EahkRI7hwaYwM2XmXTw0PHVVBPTQAPk
 0GzDCg1R1Y2UEA5hZTkECWnbeWEC6Y1mWCB/xPZLsYjd2EaCP0CfHeNogOqkc5ywTLfy
 uWPuR5Lg74KP2svuAXoQeWpuK/pGlz1ne4YWjlMpEoSKCKRnhnD9GgZx2r13qWv6efTN
 d2d+JU0leNvjoNuMhZ/AbcetCHnlZvevFZGMspN0dyGEdYmbpDxzY4Ow2SrsSec2msvr
 ZGFhEyra5wNi0kYXoSnClykxlqVgYGJX03s88vvjR5vSsr94zSTxMyIo4P7PkZvQUobv
 fYTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIZn02stXZbmG79MevXC8ibCmIsO4SNlfBB+CAUQ0HOzyS3sIQWMdSP/ZVGAV/bBUvqs8=@dpdk.org
X-Gm-Message-State: AOJu0Ywwan7w+ufPupKOhsh1PuYQgs7H5GozUdypRi87mDswxA0vpVD5
 Aj6aQ5PF0o2U91UTcNyerwpv+Ey17ChYGcJ4AjCaGtEsWjvmOHRgbTW0mKdqWYE=
X-Gm-Gg: ASbGncuVNAZlJkLvrxKbVlQq/uLz3MQmO65osqRgMano7ENCfCzrpBaZAE7mwTrhLPg
 irmZqIQFzrWfw6E7unt29q5WWXOaW4mWajlvNCmY0FMmkvKL7eO2/c01rwKuVz23sk+EbqmilsT
 tRT/en7aBCm0NwyBlPwJmnHhIz+7cYmPyz8dBqFavKuFkeO69ZVRdZPdqPFOZFiiPpLokpwqzuy
 ux7x1YJs38zKrF3ykzC/zDB+ZAJg85p/ybBGZ0A053kEoD1LTiS2aY6ocok+bOX0sBHV0VBnO5x
 lh67MJO3XJc9DNRlX8JcZE76LrXdrz/YWGE3C2Rnj07y57tw/5dU9KjBWcxoCqZX4XuX0r4MDBG
 KWq0fqg2xUrAd56BceHEY7g==
X-Google-Smtp-Source: AGHT+IHJVB+hV5dOb6AVjycUj36cR86vYKa/MokwRL61yrkyCdHiLFu1Rlq27KTpWpLiuAYa0cUdoA==
X-Received: by 2002:a17:90b:4cc5:b0:2ff:71d2:ee8f with SMTP id
 98e67ed59e1d1-2ffbc1c8aa0mr16595421a91.13.1741620685022; 
 Mon, 10 Mar 2025 08:31:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff6933997csm8149632a91.9.2025.03.10.08.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:31:24 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:31:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Etelson, Gregory" <getelson@nvidia.com>
Cc: Igor Gutorov <igootorov@gmail.com>, dev@dpdk.org, thomas@monjalon.net,
 mkashani@nvidia.com, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
Message-ID: <20250310083122.7088ec4f@hermes.local>
In-Reply-To: <a850dee4-a7c6-8173-2285-22c36292e182@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <CAL7bPf2ddD=Hnw19uO-EzBBYYZz2vYUKxWapYoYK9Qqt7wdbfA@mail.gmail.com>
 <a850dee4-a7c6-8173-2285-22c36292e182@nvidia.com>
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

On Sat, 8 Mar 2025 21:14:15 +0200 (IST)
"Etelson, Gregory" <getelson@nvidia.com> wrote:

> Hello Igor,
> 
> > Hi Gregory!
> >
> > As a DPDK as well as a Rust user, I'm quite excited about this patch.
> > I'm wondering though, is DPDK getting an official Rust API? I'm
> > subscribed to dev and user mailing lists, and haven't seen any
> > announcements - did I miss something?
> >
> > Bellow are some stylistic suggestions
> >  
> 
> There is no DPDK API for RUST yet.
> My patch  allows RUST application to use native DPDK API.
> I'll adopt you coding style suggestions in the next patch release.
> 
> Regards,
> Gregory


I have same concerns about rust in DPDK as the Linux kernel.
What API's are we going to be covered?
Will new API's have to have rust support?
What about API stability?

Good to see this mainstreamed, baby steps first.
The build system issues seem like a lot of heavy lifting.
