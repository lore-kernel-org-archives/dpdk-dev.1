Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D9C369D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 03:45:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5426F400D7;
	Fri, 25 Apr 2025 05:45:28 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 13AC0400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 05:45:27 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3014678689aso1559323a91.0
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745552726; x=1746157526; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=72Ja/iGOAmffzt6QNhL9Aj479lzmVBW/OOGjj1KzBYA=;
 b=AzH5e7P8Ru4loXnxXJTC646nyVcGXcwGeDXOdnHjtFHqsvJy1aawZwwFmqdMlGoMi5
 OvVw7F4M+xQVK+wTqQS1+lgayh6PtCO+utXRIX4LiNURlFe5MJRBqvGcIgA/Icsk8h+Q
 Z2DZA0V9lejVTfZCZYxuN/APa6J18da9CY4Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745552726; x=1746157526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=72Ja/iGOAmffzt6QNhL9Aj479lzmVBW/OOGjj1KzBYA=;
 b=XPimeHTthd3yWVYbyIIFRvR2T5QPlw2bIuxWu3EktQC1Z3J7jKqzEZkbmFQKk11PG/
 osG/Xp7fqpT8VWmLPEn6JwhtY1LHp0mpsfgbVEiiLCQvW78W2DRI+k3INM5FF1AcNMqu
 stCjmcQeVpqm2IavnfaJbJG8b9SgAbrOTflui50LL8K0D+ZhFh29HBtxLkXuiAijWb2t
 +57liN8aIhH3rro2L45D91I7kI+pn8nGBs1oi1+hxSfktVQmeKbtecvE018q/x/E8783
 3oU7T1GzBhDvyTZ52ngnCrRnTl/JN1sYm7OISbY7MDTUjZDAer5daI6PhL8ECgyFCGTQ
 7fiQ==
X-Gm-Message-State: AOJu0YxU63FE76L3Kqw+jrYLiqHXmoAZYiTvRRegSF/D6euY0IBX+dSs
 dZYBem2LfvO+vTzUB6nmEk3siFZG/srjWrgECfeYlf/9v/REAmDmGBK/HqkPqAy5V7z/l8kRyQ1
 Z61N2e3mWca+4lVC8/PsifgJ2AcaBUE+hdJDSyw==
X-Gm-Gg: ASbGncv0CFwuJ5KbEcqZNVlsNX/TISP0wkcMZLMMM5dBBvRvs9dy5m4PT1jNF5Ykb3H
 0oJejBigfWlej5tDB6TxV+bwcJ8VoXTlg96mjjnVFaf//EEmEN/uXwDkJlrTQm4BE0u/gkHJdSO
 FqhdTDX4oviTmTJcULWaHhgmQnSnOa8zSbsaNk7w==
X-Google-Smtp-Source: AGHT+IEIcysf93WJuf1KZPipcoxMhZ8+4vy+Hr6jqf6+cyf43KVKjdpYOBGqRqyuBp3uHPck6gpp6edsBlyfB2BTHT0=
X-Received: by 2002:a17:90b:54d0:b0:2ff:58a4:9db3 with SMTP id
 98e67ed59e1d1-309f7eb67famr1393367a91.35.1745552725837; Thu, 24 Apr 2025
 20:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-8-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-8-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 23:41:02 -0400
X-Gm-Features: ATxdqUG3yM6sQVNRV-FTSketC5JNOzXTwFFcEdxbbL3L8atH5KXt9sv14xIx-sg
Message-ID: <CAJvnSUBUm8P8O8tMQA5B2G6++Q2tAA4GB6VeCPqy5znkh2TzRQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] dts: enable shell pooling
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000291e7c0633922a47"
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

--000000000000291e7c0633922a47
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000291e7c0633922a47
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000291e7c0633922a47--
