Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F7C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 16:08:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28CD740297;
	Fri,  4 Sep 2026 18:08:27 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 701FE4021F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 18:08:26 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3990fe066ebso886523a91.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788538105;
 x=1789142905; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v0hyW0dYqLqU6ioPmc+Krezbvs867KIMJoKU7jZHNFI=;
 b=XRbYSi1MQEEpaGmFokq2/hCq/vlekzeEzt+kYDgNF5ELuhshuO6qi51OJs3hXTzQrF
 PqTRdpqX2UGBpNnlsEizIX8OEeKn67bGPDbDY58WG/NVeF0ieq3HRm9hcVwYJ7RIX+8r
 RDu3QLJL/L+xmrF27FvylHb+ImAxAuWrMB3xNte01zCkU5oTvDY64t3rHvhLc0Bco7uL
 FlfukoX0ZQ9vooDMdc8E3Y7rplahu7doH1/CGuoeIxJeVDeEqLu7zv1ev7xlEnEyY21m
 PWq7KvPclc525LgAeTLT6PTASPzb4KfNl+D07ZEpQbaOklVWpzDLMcB1H5kJi8oqsudQ
 pRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788538105; x=1789142905;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v0hyW0dYqLqU6ioPmc+Krezbvs867KIMJoKU7jZHNFI=;
 b=rhastClTsq5ncYbyBK5UKHRRjzRgodVkjH1LNk4/P1JlmoiHfOtKtmNYO/f4xnpiMe
 gsBaVcI9aAJlYVWl67+FqlKiJL7w467MebEWjyZlu3tepkCDrHEdIUMek6YYiROrmZl2
 2dpC7HYy8ApnX77NfT/zOSexGNXDdpSoUR3P/fVStYsrnA4P6wteymlmUR0KSedZ9jry
 n5wqLTQ0C3VMKBuxWXjd3ZNDdnYyLRfWlV+9yxaoMOEHRc0wKvt6fNjynAVKWPLKQuED
 t4ImRvFQLqtLngzSHhYOf1QDx7z0JJ2LJkFdjNgnXm2RER//im9NhqJgbSKODlBBU+FW
 9Oqw==
X-Gm-Message-State: AFuF++lOFdqemjHfb8i8HMaRUhOk1gCm/5bRmYrsA+LyPRgIydk+51Ep
 AY4WyTpkiecAFAOLqGJRpz/ltIVyCnjHMmbtI0NCdmiixogZe4/QGqhpgXXmXT11J/8=
X-Gm-Gg: AYBFou2dzGMo/L+VCl+1rhq6hDqB9Jc2+fR9jbKVLA6tJvEBoH6uVt22Yv3OAF7Ud/q
 smkF5XPFfz6gZDHsohZ2v5WxOoVuuyOHx7ibdtIr0VK0jtsjqFQTi4q94rAwvH+3kMyLyaxEXSL
 1r6PT/sT849mnfkJi82jcXtvRSQ06qQseg9KQdxIUzgouXwMwPXO/7oVHTTqYt+qALMYRxy5/Ok
 QJugmUjr2ulJsmWN1tz0VWSX6l6r/DM0NB9IYno0J3b+dP3mk5f0Ydd3DgOh305iGRP5VG+Tm9S
 YhedEj+YsHruJh6ZKql5QfpVeMW1a6q0RtcxAnwFVnltI63VQIRHjfJVznj1YDsdc7rbgghQIsU
 lErhE/HcHP9xxPiNlXqZ/waxRsXmc7ljh6BvlVCvDRr4i76G4wWheq4wMPninQlPTGJwGlUPaRU
 DmTjawe6Qf70KlNSubWlIa7yxVbJwp6QQ1Nkj32ctmfNOfHYpwcm1kCPf/OtQZaTDk3v7epGbKF
 X0fJPx8W/PFq6lS96uSZOxwzPS0Qg==
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id
 98e67ed59e1d1-39b260dda6emr9480627a91.4.1788538105137; 
 Fri, 04 Sep 2026 09:08:25 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db149cc85dsm11745825ad.74.2026.09.04.09.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:08:24 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:08:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v6 0/6] remove deprecated packet framework
Message-ID: <20260904090816.7ff9f759@phoenix.local>
In-Reply-To: <CAJFAV8wEJAcFKH3svazPaGCnW3HX7T1Bd9OYKQPou0RS9j0cKg@mail.gmail.com>
References: <20260724164520.192203-1-stephen@networkplumber.org>
 <20260730162311.313350-1-stephen@networkplumber.org>
 <CAJFAV8wEJAcFKH3svazPaGCnW3HX7T1Bd9OYKQPou0RS9j0cKg@mail.gmail.com>
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

On Fri, 4 Sep 2026 14:13:02 +0200
David Marchand <david.marchand@redhat.com> wrote:

> I did not see much activity on this series on the ml, but I see it is
> applied to next-net already.
> I see some images were left behind.
> Worth fixing before this gets pulled in main.

Thanks will cleanup. Put it in next-net as way to get full CI and
avoid any later merge issues
