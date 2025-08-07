Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAD2C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 15:41:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BF944042C;
	Thu,  7 Aug 2025 17:41:37 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4946940270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 17:41:35 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b34a8f69862so885032a12.2
 for <dev@dpdk.org>; Thu, 07 Aug 2025 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754581294; x=1755186094; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OvfX5WM1mCy58vU4VcJt0OyeXncLVUNG5nZLQITUczQ=;
 b=glky+44ozG4mOHdkTfx6+PfipjRnkMNEM2kt4fQ66Bh2xR9VoQU3HBqWdzgyoVZsSf
 32NtWNnhDK4qga0Tu+t9t/1oLUz4Xnc8YOPdUeJ/8+Nwkx+D5aEKO2GrxuVOMRfRoy+C
 VwENid5ALxdj0V6/GTCfc94t4XDj243r8G6+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754581294; x=1755186094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvfX5WM1mCy58vU4VcJt0OyeXncLVUNG5nZLQITUczQ=;
 b=ECBdBZbAxg9GZCqP5AdPiewMlGubaXHOq2LLnsAc7UXLiobBg+eZB5I4pxcpo83zjy
 TvcVkLxSireh7wFCUGGzT4Fs5wqiN8AyOE740ovxX02WTXeckzF0biI7WLwSiQ403sba
 UWfG9w371+MwwNz0BvBW3LV2eFlKSZoLJpPCofE+EWY62J5zg8Ifpl5y1TCg9miuE4Bi
 lI+rgNqvnlVE80FWr9KdAiE9UeZL1ZqK4Ruokpg4vQYKST1FVDaWFfMnk/Vi2UA03okn
 3xEuwyrWq8rS9denpeSo5iwlzbymdyK/sYq1az6fXoq/NXvIMuAFpjH8s+X6ktI6FVOj
 UDAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzyzlJYNT1cVAp5mqhdNJjz3upa9lBHvnBoaALwQCXTcodShga/o/p1SfGtpQicyzCQZU=@dpdk.org
X-Gm-Message-State: AOJu0YzqwdeoRkIB4CAicpbiwEe1vJw7C2nr11r4DQaKHA5z7F5vo8w2
 z3pPR1uCuipeQIEbMx4pqAvXNC8ZwqsdSEAh/6lRyW66TxSIXvaaFtqcMrBMPDV6TWixw49yJtY
 NBbrf1Xq0EduYFLx/PL546X7PIiL9OxH3UANbqsmFBg==
X-Gm-Gg: ASbGncvNOK3lMtSmXK9FQq1SEX26W//ymzX9nKYs/SNWAzyz+29+GKpWbkdFNz3BFgi
 9oSXJ+qK5bzVW7Ts7QMY7WudcKUEBu0d2lh+5J2S6vyuHmxWeDQduO3v1ASV/ikJE/aWErplPwE
 t+lAeIPiAgBl70eV+CjB42H9kpj99+y1Q0o0tyW8nwRKvR3M5xcrdTSYo8RMFPdj2hA46xoINUV
 uVXOsG9nvF1djV3PQPQw+FeSMON2iX/yoXlzHBC
X-Google-Smtp-Source: AGHT+IEpEScSkvOgnmtvuXskWgXCGiajndzQVrPgZJlygqSoRlavIS3eWE+FcRPmbUbeRF5pUxRSNNYgd6c/Yw6Zmow=
X-Received: by 2002:a17:903:11c6:b0:23f:d903:d867 with SMTP id
 d9443c01a7336-242a0b874aamr99717435ad.35.1754581294451; Thu, 07 Aug 2025
 08:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250722172214.202308-1-dmarx@iol.unh.edu>
 <20250807153358.304262-1-dmarx@iol.unh.edu>
 <20250807153358.304262-2-dmarx@iol.unh.edu>
In-Reply-To: <20250807153358.304262-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 7 Aug 2025 11:35:19 -0400
X-Gm-Features: Ac12FXwg2F7CpP0LOVxbjxDxqqfbra10sHgCNwygphB83byltEpCNx1xmGN6F58
Message-ID: <CAJvnSUAOeqJRJBpJ=xMCYB3Q4YX7cnrfOGMV38NaGMGT9tEytA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add reception check to checksum offload suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c92c5a063bc84a7b"
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

--000000000000c92c5a063bc84a7b
Content-Type: text/plain; charset="UTF-8"

Looks good to me.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000c92c5a063bc84a7b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Looks good to me.</div><div><br></div>Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000c92c5a063bc84a7b--
