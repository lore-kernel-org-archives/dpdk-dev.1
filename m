Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086EBC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 21:30:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00069402DD;
	Wed,  5 Mar 2025 22:30:58 +0100 (CET)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by mails.dpdk.org (Postfix) with ESMTP id CE97840279
 for <dev@dpdk.org>; Wed,  5 Mar 2025 22:30:57 +0100 (CET)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-6fd4dcf2df7so47437497b3.0
 for <dev@dpdk.org>; Wed, 05 Mar 2025 13:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741210257; x=1741815057; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=YjVeh0mQtc4zF6JB1BZadnbIdgAOV0tSGXACXy8iWkXOdBbviHO37NGOdh/A/b3/IZ
 0jUcuWF8rRQ5ujE0+DiEBcQXab0E4S9BBnUxtC+FeVh4AAKEdpwp92o+6Wj4wrpzMxb0
 68jThBc3V3JKOCQ4fVRkmwb9UcWTixVGTjFaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741210257; x=1741815057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=wL7FTsrFqDh85hYul75vJB9a1V/Iy1cmP5vYCtvIVpTCl2in+ui49dK8YUK0KVYWHg
 HOszlDW85/QTGtYvWlrPLFg2rei+xGQnBwAiwB96Av+1hf1omjs9nEWNu208XtpeHHPY
 750KrPet3l8wPCc6yp1IatQ2lsSTCreHufqYukrsQr6paKs5mq09VlqNM53HB/BncnLR
 uebSKViX8BMjysS0zlwUlL50EalSSKk0iJqv1kjSkk7fUORW0ht5GVJqTECcu9UQ23GH
 FeU4CxXY6wyG/VshJtF6hbRkgWxa2BzhQmaHP3TN49O646f2KDTCOTiJMGzyFBQtoiMr
 Io3w==
X-Gm-Message-State: AOJu0YwE3SO39X0sVgjK7njhALlkvIXR24j9eJzWMq009mnkhDPQJU9z
 DRsHDNEeXLtGy/58wY18iPh5gyT3m2yV5KMIy+sds414TILus4I3rXWPjXEviteG8qw0LPLdUIj
 jGU5o02RdkVzTUA7iw1E3Be6ABnuZy1IgNB1ymA==
X-Gm-Gg: ASbGncuiwn8PtpVnVVPy3LVW1Vywy91fR0+6YMkOIqFtWmYUr2gh76PaI3ljnNZftpg
 sYPRDY+dYtOEK61jWdvSk/X6gdCcHS3PVkCSe5PE+YrpF+FJ3JEEJxZOrRFml08hf0UR7/6yCOT
 hvMCOg/ZRnc08op+8fagWwgcHMUXfQkYd2TyRzdn1UQOlIYlyFzvIJEr8gZieE
X-Google-Smtp-Source: AGHT+IE7ksK7r3KKFTMirN+39LiWAgSRROoHX9OoEN/2kQqJGyFQoySbC1QdjTPhFV8nEIqZAf99RF8LowradlMSwrQ=
X-Received: by 2002:a05:690c:d87:b0:6fe:ad42:19be with SMTP id
 00721157ae682-6fead421b2amr24470647b3.12.1741210257249; Wed, 05 Mar 2025
 13:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-5-luca.vizzarro@arm.com>
In-Reply-To: <20250224132823.196509-5-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 5 Mar 2025 16:30:46 -0500
X-Gm-Features: AQ5f1Jpuh9X5ZNfNvtRqA1rTSmRdDUJ2RbskNoYdjzGuofocJCOPoIp0374SJMM
Message-ID: <CABD7UXO5N+4qUtrnW2vZgxThQd026x=5_TXJ6j7+yHuLjEjRtw@mail.gmail.com>
Subject: Re: [PATCH 4/6] dts: decouple DPDK runtime from build
To: Luca Vizzarro <luca.vizzarro@arm.com>
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
