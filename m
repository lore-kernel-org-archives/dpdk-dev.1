Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29B8CAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 05:31:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FD30402D0;
	Thu, 18 Sep 2025 07:31:01 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3EA19402B7
 for <dev@dpdk.org>; Thu, 18 Sep 2025 07:31:00 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b4c1fc383eeso386350a12.1
 for <dev@dpdk.org>; Wed, 17 Sep 2025 22:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758173459; x=1758778259; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ib1cdU/NaCEKIE00OZKzU+muraD05bBUTX8xtO1eo8=;
 b=eEVl6Oa50RlxmWAbqMnhoV0utcTTF7TEu6BYI2Q9m+H/ux4H+TqZZC3rxutjf99c2v
 aQmbFFoWKv6xG3zSrWZXB019n/zVeRWnFkRC3EtE9A3zcK9lPVT2a5s8rN7KA9wLnuYr
 ehzxP2Z/rf5mYAwjZAHHBEZVpIjHW5lexUY/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758173459; x=1758778259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Ib1cdU/NaCEKIE00OZKzU+muraD05bBUTX8xtO1eo8=;
 b=anaWFIbU1jKilDik48cINiYwRgpYQWH82zOEMpK7t4jY1VsxIaoX6cB4P0VzThxdYI
 28sWyRoJfAjQQ+nXmayt0Cgv5e4KEvwxCASmO9bvPN9S2WVIj4deKwR/3zZl073kmgE1
 0XuVfrfMavwGruyII+y9Uq2RRDDhe4xQoXeway9LrOOQMAQmhucVu8aB3JhLKMoYsDr2
 Dbwnf4izEw/Y0Lf++mw8jz4i4fgGHoC0/dawmy6SQ0z4fckvfIrJ3qm8dO1e8L8pqRW7
 pHOtTRbUUOE2zghy924wGQv+Kg9aP/fvSMbQo9IjwM09JmScjUVBBT43ITknXSI/7/1e
 1QFQ==
X-Gm-Message-State: AOJu0YyJInjaTrkJRfR0kwL5G3gDAHreQoEQfr7KeMnshxNTiSiQQqH7
 QkLhw/vBmfzAX00Vj9oqedvMgHMRKapMUe/mAxcwoZDS8Ay7AZ1hGGWAECdQSU2zQ246DxTp7rv
 hXOxDtdNIJDy2nAACSMLKlxaCytFUr5Dl95rV87PVmQ==
X-Gm-Gg: ASbGncsLyWn9E00Jc9wlgEtrnb1Aa8JB3EZt5OGZr0YFklTpds7i+qNUt5vzOBDzUj3
 ANuB9Dht3m8G1SdqQNVJlJdrAmDL2aW8Z6Cv70bNwhDMz6Bbfn9ZZZ9wzsAqCMO11W5eksWfnWZ
 kriEqm0AP1fSwuFb+GQDR2XOXrmLF//1QQs2XhRC1hYougnxNLc1ToGoah4xKWr+tEuEYL8UB7C
 H/RDC7BljjMvVrCdzj5hMR88At3rBSfgU0v1fJx8Q==
X-Google-Smtp-Source: AGHT+IFQ16B7jCCrnrfwSjV7jv62ODjbisjBjbPl8wv9SBjzsvAK1mHHcSqdKRNClj1lk0Wp/KoEK+Ov9aT76Ya+iEo=
X-Received: by 2002:a17:902:f706:b0:267:ba53:8bd3 with SMTP id
 d9443c01a7336-268137fdf51mr59201075ad.28.1758173459413; Wed, 17 Sep 2025
 22:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250910152103.976383-1-paul.szczepanek@arm.com>
 <20250910152103.976383-3-paul.szczepanek@arm.com>
In-Reply-To: <20250910152103.976383-3-paul.szczepanek@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 18 Sep 2025 01:30:43 -0400
X-Gm-Features: AS18NWCMV2UcsfmiuAfHyEMYEfZRnI0vGwopVAw6ECnaeFD5qNLnu5wi5yH801I
Message-ID: <CAJvnSUDzxjmbO8oMCo3X-cBGEnW76zOJnumnHHxE89HQ=tb-3Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: update tests to use new API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="0000000000008098f5063f0ca8f9"
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

--0000000000008098f5063f0ca8f9
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000008098f5063f0ca8f9
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--0000000000008098f5063f0ca8f9--
