Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA61CAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 05:30:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41282402B7;
	Thu, 18 Sep 2025 07:30:37 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 55AB94027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 07:30:36 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b49b56a3f27so302471a12.1
 for <dev@dpdk.org>; Wed, 17 Sep 2025 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758173435; x=1758778235; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IvPX2ekaEvXVDVf5gVEG4jdbi0jX/xhXwH4hnJ+1Flw=;
 b=HYe+SfOUvccrSAaLbGsginCH/xxXN16W7AQLr6gsx68LdnxKvaEEej1jdhCFsrV3nX
 2MjuzlrceBHSAfaV5uGmUq6GvtwQH1xVdv7OfVVcARbW0rAdtVgdxwHlje0EwLl0mxeo
 T02PxHBXnW4TCSHkpUcArxCrEuPyEbwZZnm/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758173435; x=1758778235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IvPX2ekaEvXVDVf5gVEG4jdbi0jX/xhXwH4hnJ+1Flw=;
 b=N+/VLqIrnkZ1Y7E61fjEREd4vVA6NXqtNipe5C/Tkbz9ejyjwC3bTkHeyBygydbcAR
 xH7Z8AQfbS9TIvDjXgaIEZuRCTbIbxSB31pnx1fks037qnzE/fCDdQkG7KEiVv3r005H
 X66ZgnGOmhxEeCLDTS1saCh8xQPzKu4ZioToGQ7Cpw+rOpC5TPl4hbV5EYZCEUOkgb1i
 ftrtL2nZbeRmHMPHXa/YCo651RSVNgM8kbfy+GaBs1qY5jLYRJ7vma4lV9Z95rugcDLu
 g3HHaQ/OHTaB4O/n/rC+xI8MiU5LxI7NhaJwJSg1ig3QE2/ZjqYWmTd5++n20gcathWx
 FiWg==
X-Gm-Message-State: AOJu0YwHcFilQ4zSMUgsS8Fel++F2K5/qETzzs9IiOviH3OYqXdauSF5
 723SqVAeKhQ0qrdo1tv+r9Dlaes8VqAOP+QcLvyCoH9NUHrgmkmav4OpHLprKEsrVxHT+XC7DWo
 mZugb9W4SPfEi/Sl+hTeU7EKYR3q3tckMmNJDBfeghPSsuqy0TLDacCM=
X-Gm-Gg: ASbGncvqvZuuN321kSBVTWseRVteSB5hJ4JaWwT7RHGWjFzU4rCBxnRx9wxzhAcBbgK
 AgyFGFwABLpizEJzrat7ha/fxCr2Fs8q8a517F36PDw8j6yjHife+DTGOA+WD3uabdDTuWiEFrr
 a1zhWZtWzzQvJf4zTFjU6MPotAtO2UPUIOFq51SHrpQ0g+BUSr9QcAQDlifbO164lolmlF0LTmK
 3TfTINklLBGqv8dajfGkc9phy74wyNG4jj475XMDw==
X-Google-Smtp-Source: AGHT+IHueODrzyCdr5yS5DmpwxUOw2SZPvoVlvPStAzyF3KQ/Z+r+WumQOl2JzdPfAd/9TAlYLfkJkg4NtYtFCa4NX8=
X-Received: by 2002:a17:902:d2ca:b0:25c:bd0b:d048 with SMTP id
 d9443c01a7336-26813903e80mr63285435ad.40.1758173435522; Wed, 17 Sep 2025
 22:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250910152103.976383-1-paul.szczepanek@arm.com>
 <20250910152103.976383-2-paul.szczepanek@arm.com>
In-Reply-To: <20250910152103.976383-2-paul.szczepanek@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 18 Sep 2025 01:30:19 -0400
X-Gm-Features: AS18NWALjmibJ45P0uZo4mFlreNU76VScvGjdM4GqdhfgEl9Qd8pZpVP6QtROMQ
Message-ID: <CAJvnSUD+qtkT88C_7q6BS8migv7r3cmdRtCMSq7KOk-ms1D1mw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dts: move testpmd into API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="0000000000001413c5063f0ca7fc"
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

--0000000000001413c5063f0ca7fc
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000001413c5063f0ca7fc
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--0000000000001413c5063f0ca7fc--
