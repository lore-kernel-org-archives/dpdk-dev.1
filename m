Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE10EC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 20:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CF5C402B6;
	Wed, 28 May 2025 22:25:01 +0200 (CEST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTP id E875040156
 for <dev@dpdk.org>; Wed, 28 May 2025 22:24:59 +0200 (CEST)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-70e102eada9so2954677b3.2
 for <dev@dpdk.org>; Wed, 28 May 2025 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748463899; x=1749068699; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7yyeJLZ2FpxSZbVwtIRLjVtZlYAUD4jyA+O+WUhHkQg=;
 b=E55aVZc/Uvl1MBpL5STqFcqDeTSn3mX1XUlKTgvOOTNB3HuEb45zdSYzGAnRUETrj/
 Gs4vmYA5mFlFflQV9wmI9Vc3EhscoKtNLXHj1O6BXCL9UJbgAlPHtVm2z9jObWgCo6Hn
 jNOxjtX8TsUQk8lW+suDISDWlRvG+LKY8aqr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748463899; x=1749068699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yyeJLZ2FpxSZbVwtIRLjVtZlYAUD4jyA+O+WUhHkQg=;
 b=XIRGATOG4+/der5j+ocRoXBIn8KXkq6gzhbDpO2s3iqdDh8bhzDo0vfZPR8hof30pD
 oqkVeIfZRWqwC2Kh/v4Ij0PjM3B5t4dUk3PwtTp2tO05DAZq3/3EbwLwOMX8MuJvCHev
 F46TgsIIIxovhU/QMOJwr2yM/9x8UkI1sFU4Oko3sXvxKhEO+6BdgTJ6jyveMHROphVd
 wtXmwckgyyx0eu4BT/oq+x9olReHDD/O51v3U4GkWlmIV8PnKb43n3PS2C4caNIOc/KS
 rI8sIedVWyWf4wZfWA+c8MJlYXg0glkewr5AeZn45VA1c74u9XK3Lpgtf9peM0Amcxs1
 jDrA==
X-Gm-Message-State: AOJu0YzFv/y2qtT54u4trt4f3d2+AniMohauhyPaePUZgN3Oo02PEFXI
 tLPG5OL1A8snXDQyjQSPt6NF+hPkwSq6TBJ0NzwxF+SSkd+a8Wy60SWNxgDrlTNZ9dAmFjb0gvd
 ZQ6Vc25B+cKv2SCVpkPwl/9eTJ0Jyq5bSVn268/IOKA==
X-Gm-Gg: ASbGncur2SjML04vN74LXzDH0OpCYk24DDSVCYHZCY3McqoeUz9bWddO+D845+mqH8Y
 fJor3dkqL9tJWgt9GNOGmQayfadx2oritfyry6gEdRAVigliyNRraUqZFZbXYbXO2NKxhTHFafY
 vhGzKIPDZ8ch2H3x0lmQbzHDAb2DAz4mcEF6KDi4hWX2+SC3FpVXv6t5KdK1yAmeBsFnc=
X-Google-Smtp-Source: AGHT+IGQyt/00fj4wBmkfzSJa3RB4g1+ZuO1xFKtk4vetfegI++H4hnDd2HShb4krICHYv2wjEC6v1OZ+VMlO9zDqu4=
X-Received: by 2002:a05:690c:6710:b0:70e:143:b822 with SMTP id
 00721157ae682-70e2d954fc5mr217165267b3.7.1748463899192; Wed, 28 May 2025
 13:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250415130903.224858-1-thomas.wilks@arm.com>
 <20250415130903.224858-2-thomas.wilks@arm.com>
In-Reply-To: <20250415130903.224858-2-thomas.wilks@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 28 May 2025 16:24:48 -0400
X-Gm-Features: AX0GCFsImQDfVjWXbVvAw67peQ3QCIPfjHWE_eEzSDkB-bveLzK8bE0Cfm_IhLk
Message-ID: <CABD7UXMO-f3sixGWEGfcsknzf65=KphMqoqgR323qDVgGrur-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: add remote create dir function
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
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

Tested-by: Dean Marx <dmarx@iol.unh.edu>
