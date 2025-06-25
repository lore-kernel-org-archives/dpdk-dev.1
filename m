Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F49C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 549474068E;
	Wed, 25 Jun 2025 06:12:28 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 1F6AF40697
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:12:27 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b31d489a76dso5586922a12.1
 for <dev@dpdk.org>; Tue, 24 Jun 2025 21:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750824746; x=1751429546; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ttvi7S4a/XTQjic+/uY0QX/tBRsuWuaHlK/R6qJAmw=;
 b=GVa51lkH2pKUd/agfKWK7zz4d30I8wXLCN/om8gO3gpZWIdn7BRDkdHyqNVuicjSM5
 hPeVt6Mq8XYj58J9nX/hmDbqh+TjqEPi1CSBo5lY5jpM8o1/69kNG54IqHDyUU71Olub
 bbW9DOzTgnZqqufax9vaL8MYqYFX3sdA18sXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750824746; x=1751429546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Ttvi7S4a/XTQjic+/uY0QX/tBRsuWuaHlK/R6qJAmw=;
 b=ntyJle5bjvc4HUj0AfW2Li8NFCq2MkOgP8q00a6LgWX1CrTDbHjscxFcX6f9yx2uih
 /IEZc8kxGKDZqqqhVLQm+v2v27UhKA6BJ2GRNEtehTypyKOTL7UrPhf4oBojgR/IWN0t
 JwAezwa29eFIHxjXLtuh3OBXxvaWmOG+60/+7VMaiNm14KCmEkN9iRWPjenVvI6gI6Kw
 4zcxCD79EN/4KBrWcbDBwGAsOfvup6SsKRBSi5w7/hdqdns08P0ch99Mca9dRXonnHjk
 uE54paWr9sdnk7d2kVpTsFNABZzY5ydMIn12X4NkgHklKws683fVfhLDbQhWJ+VMYIak
 pSGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLFW3ox9jiKHD4D6E11zO23I2s09uE0YXjkOo/4sOPmI9Z8Fjv7DvtCiTFcVz8iBL0vAQ=@dpdk.org
X-Gm-Message-State: AOJu0Yy7kUqZ7EEqV9GgSyI/bxmBA0G2Byg4alSNgVGnxyzYvZVK4wD+
 4sc0XuIAtROaPpbMyOkmLedo8EEkcIYMd/yWLaAX5jj6v0t/TfzJJZJlRK9L7qgyghZKbOXifgd
 0elI5IqI0jT/J5aNm6Ih1S9UkOgNcXuv81wLBT5az6w==
X-Gm-Gg: ASbGnculmtTWM1Xm5Rztho0vsTMVoGLsTXBhjPByY73MPp21V4ASvelcnCPpfNjPbo5
 zfed69Vyx33kII1bc27jnaZuECLnjW9oYGkVmUk+CBYLLy+GL8Lsyt2BQvXldfpiFqcd0zou61S
 4u0gQmWj0yYAygXA7uYvL+GIbQem2fH8nUwAgFLlOuws3auJ1pv2NSlteH/fQ=
X-Google-Smtp-Source: AGHT+IFVZyw6Hd4vy+bYcQln1ropw2ssP5/ZPKpA6S9i/AMscTgZldPYwwZ6wC3VH9Nf/sIiSnf0BSiyt6IzXne/Veo=
X-Received: by 2002:a17:90b:574d:b0:312:f0d0:bc4 with SMTP id
 98e67ed59e1d1-315f25e3026mr2146191a91.5.1750824746286; Tue, 24 Jun 2025
 21:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250527153734.368235-2-dmarx@iol.unh.edu>
 <20250603172827.458725-1-dmarx@iol.unh.edu>
 <20250603172827.458725-2-dmarx@iol.unh.edu>
In-Reply-To: <20250603172827.458725-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 25 Jun 2025 00:07:00 -0400
X-Gm-Features: AX0GCFvs42nggjVT7Ekxlc90xF1oSnl6RWkKdQ2rJZZ3pkvgudpamgP6SCB6BVs
Message-ID: <CAJvnSUAGND5nTFHp71_d4ELqY20bcLC8Oc-OAhWz0V1jcpvOhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: rewrite dts rst
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000001118f206385da73b"
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

--0000000000001118f206385da73b
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thanks Dean.

--0000000000001118f206385da73b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thanks Dean.</div>

--0000000000001118f206385da73b--
