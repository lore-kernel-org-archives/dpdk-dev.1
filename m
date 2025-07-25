Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91809C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 16:51:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 386EA40144;
	Fri, 25 Jul 2025 18:51:22 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id D04C9400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 18:51:20 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-311e46d38ddso2101129a91.0
 for <dev@dpdk.org>; Fri, 25 Jul 2025 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753462280; x=1754067080; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xmFSS7UOWMYbyauv6ozkhXf7F6eVs5uRpWozTn4hoeg=;
 b=RsD8vdK01K6O/PVtrf1UcUcZDw/esJvCbcvhoYAehgfizKuB+OeZz+0kxK/YY3VS8g
 3AUxCof0bbw+FCOTo+iIM3fUW1mG4oTYxeswXCTKDfPotc/RUYnbGi7dmHXM6bfoQiAC
 tdLMZDBpaA6HJdhAA3qh90+1/uZR2LaCNxoXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753462280; x=1754067080;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xmFSS7UOWMYbyauv6ozkhXf7F6eVs5uRpWozTn4hoeg=;
 b=AABQx9j4y1OWUE0rBHOdsjhO8TYWMDvx/evCgueASJoTlfPxH4NrNLsyFWW7b0JXR9
 TU5FSqGRAkhW9FNNZQrVCnMgRHF8u0PAMdahV8iJJlMqJz+wVP9nt2dymbkBV35oIl9m
 G3qOrJ2/4i4BW/OmhpHdB7ebXLMZtaNnVZmZs82IBSvHNXiFGKhljhS6TcHOHONW8JZ0
 T9xCC8E3p5YuPvjSdc6EeI7/UBc9NCQiQbV/gFCc24Nx/LjMvoo0OXg7SpYre03mpRkD
 gMYRn0rsq8PHtTUPkV2WBKZPwtpgRS2VZ7FVPqyyan2UoB8p+WAamomGDj+2GPpCyqHu
 044Q==
X-Gm-Message-State: AOJu0YydvRw+e4ieYwSr8ghwByc9sc2JjegXCRJIzBdzUWXfZxkfV7fC
 E3e6JYgh5U/uQnOAhUvsVz2DWiFfvPomeT0PKyidbWCsEsoaeUk8tSbFrdDC1L4LF9kCFpxEPNY
 i68sncUK8409B74Fc8kRhsNthsawdcIF633ECPeuncA==
X-Gm-Gg: ASbGnctgK0+oHiXWdw9sjdR+oCF75Ge6vHll+K1fiavQ9OvckSypf2DeQZgWfh21gOl
 dakexQ64pm7+HHZmF+GvLVXhZCr3BT7rPBwMFWrx3s0eW1fzOCVy2w047yWysV9/H+wfBLM5QEH
 aRdSbqz2ue64i9xK/A6aJYItYxhJ9+GEjlPn81kBRldrGo6aYRYvF30FlH+nXQlJ86IOxakCTU+
 9s0s+cMOWnupbW9Y1ciTg==
X-Google-Smtp-Source: AGHT+IGOT8Clo421vmyGRSWNnhUREDYpmfoZh45Q87lGalyH11WQX59+LxBUiwU0J6GVrcesNOrsJrDpn/8huqihro0=
X-Received: by 2002:a17:90b:5252:b0:311:c93b:3ca2 with SMTP id
 98e67ed59e1d1-31e77a18d76mr3791755a91.6.1753462279782; Fri, 25 Jul 2025
 09:51:19 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 25 Jul 2025 12:45:17 -0400
X-Gm-Features: Ac12FXzDz5rDg1yNw7Aae8nGdLdA5JNlbllvMSzOmzKjMA152zufkxRD-l6IG8U
Message-ID: <CAJvnSUC4+CO1M6MEnQyY264nvBPobG6pc_FG0rhmEFJWs1QZ-A@mail.gmail.com>
Subject: Scheduled DPDK Community Lab downtime this weekend
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000505ba3063ac3c0b2"
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

--000000000000505ba3063ac3c0b2
Content-Type: text/plain; charset="UTF-8"

Hello,

I will be taking the DPDK Community Lab offline at 5pm EST today for system
updates and backups on the Community Lab's Jenkins server. I expect to be
able to bring the Community Lab back online at midday Saturday. If that
schedule changes, I will provide updates on the Slack infra-issues channel.
Thanks.

-Community Lab Team

--000000000000505ba3063ac3c0b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I will be taking the =
DPDK Community Lab offline at 5pm EST today for system updates and backups =
on the Community Lab&#39;s Jenkins server. I expect to be able to bring the=
 Community Lab back online at midday Saturday. If that schedule changes, I =
will provide updates on the Slack infra-issues channel. Thanks.</div><div><=
br></div><div>-Community Lab Team</div></div>

--000000000000505ba3063ac3c0b2--
