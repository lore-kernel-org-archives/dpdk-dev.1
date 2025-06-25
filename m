Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6927CC7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52B674026C;
	Wed, 25 Jun 2025 06:12:16 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id E9C884013F
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:12:14 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so7432752a12.2
 for <dev@dpdk.org>; Tue, 24 Jun 2025 21:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750824734; x=1751429534; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TIsSHcC8Weu7A3o5Uu/dTwWQ16jIbkwj8+NtKAHMuzE=;
 b=eNLnfOW1Bx44yDMIBGU4W5OsvTSFRshgrV+AV+vh4pbYsaMLI2VZcQIl7E1U5RA3zG
 jPjOhhzoNixT0sNoJrYlTRcCsl/yWaj46JX2YXtb4yClOsdkwKvOqYJIoS4M9dj8XdrS
 NxYngV6kJCu6FNYFO+hnPcQuHJLgETLlQ92pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750824734; x=1751429534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TIsSHcC8Weu7A3o5Uu/dTwWQ16jIbkwj8+NtKAHMuzE=;
 b=Xdp8RpPcVUKSifDF/SDer8j9rggZNiqBmHL6nXaESs5Q9na+baaA/g6KBRPgq32zkE
 E0GNHe/vaQ/w5ASWKhdMUIBrRMNw1sC5it8sg8pXNfc583dOOT0qOMzp4UoDQf+Fg6BF
 uSX7yBXiJpzLW1dih3P3dd0xtZY5bzF2dd3uAXvp6xFSqf7xjW0eT1eFqImDzuapH0Kf
 JYXOTtEND0scHwT1uyiiRFtHQkkzbuNwMXZcVDOJS9E9btQ1bij6IzjDIKwo6TwIacM1
 RUNBE7f+RFGpb7EQBH5qBMZZua/2YxoHNgbjx9AJLB1Ezh/24q5B1MssCVAdi2AkQzbk
 d9vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKb6zhHqvRiE2ssq2Fe4Cd/Lyo+sW2ZlgQl7WtP9ra00/DEsP3tIXPktM0VecSFd04QZc=@dpdk.org
X-Gm-Message-State: AOJu0YxZIbRBDL6YGTIbimTc7rPQrcBs3KacrbZEoCnOoRB/ZuvZBgjv
 RJMJdxOD08dTwpmE9HiAmEf++rBUTp5SGZt2ngKat3WwFm2HmrPRg5gCqXkUgeIQhd/AIS19YFN
 942DRVO3IzUqpiki+QpOs62B5lwLXgDUTwkGutKB3PA==
X-Gm-Gg: ASbGncummtI8YQx5c/UJzOG7XBTk9khV8X7KM91X9U+QYbeqhFS4O65F2/XfFkcI6AN
 aiESbvuQZTyuRwFIbvpfMp4Yg8L7y+X1X8rdsvj2qDseMrJVfHqarTq5+xqLTSKRMP1pJGBosWQ
 UYD1RIQ4yfT7FSkSvst/GquwnuwmSXUWQJeC52qOMPL2PlkSrdfXW2BX+TSYw=
X-Google-Smtp-Source: AGHT+IG6vcQgmDByOPXtH5HBa7FR7+SVAqe4xwfLcrJvF8ilylqS6LPWheSDiKwKS+bed/AIJ3eseQZu0mtjn7ai9sg=
X-Received: by 2002:a17:90a:da8d:b0:313:bf67:b354 with SMTP id
 98e67ed59e1d1-315f2553204mr2461322a91.0.1750824733971; Tue, 24 Jun 2025
 21:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250527153734.368235-2-dmarx@iol.unh.edu>
 <20250603172827.458725-1-dmarx@iol.unh.edu>
In-Reply-To: <20250603172827.458725-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 25 Jun 2025 00:06:49 -0400
X-Gm-Features: AX0GCFtQzkjRBGRtCzZ3bTejGVeAgDjluUtiEQx1ovq8Wxxj8u4l2UF_qdFq7YY
Message-ID: <CAJvnSUCzB3f=wSnCP223zePyAZ1iwxLYuN-4iXoNPiA+pGA7RA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: rewrite README
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000055324b06385da68c"
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

--00000000000055324b06385da68c
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thanks Dean.

--00000000000055324b06385da68c
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thanks Dean.</div>

--00000000000055324b06385da68c--
