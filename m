Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E78C3ABA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 21:33:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0845402A3;
	Tue, 29 Apr 2025 23:33:23 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id DFBA940277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 23:33:21 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so8123907a91.0
 for <dev@dpdk.org>; Tue, 29 Apr 2025 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745962401; x=1746567201; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jgh0NhtVxHPrYmLOsMYSHgJnkdsbunTEwPVV+ovswNw=;
 b=OYwOacB9kb3AIdv5Mu0e+/z+/dyZ6pUD01omjKljkC6AN1khEplETQPim3EkvKzyFE
 xJJuYqmIvJDRqWEIMfh5aD8vThUUWkNRu5H9gIMduOYzy6QvAgtioFSb8ELfms3YeKlV
 oYehYq7s4UHA3oK5XwEUJE+56WsSAFnYDPo5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745962401; x=1746567201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jgh0NhtVxHPrYmLOsMYSHgJnkdsbunTEwPVV+ovswNw=;
 b=tCtW99A1TixanXyta5DFGBi3eXZRqvxDBwKxzP+Ya5kHdcfzu2JEaz1tDiMlntmL0p
 PE5ghK3OpygJkPhXtPhtnmoi3adIwS67YFWNx2YdFmgt7OZvr1ujooXtPJrQUNTqD+Ip
 bO1Akl8P3FHoWWFMLk76NHyduMpH44TJUdus7GAOpnh2n1eCPpXQS4ng05ieC/gmicKt
 Y5DBpHR/zzwCzNnsaUJdDa5rSBHt9S+YH97V/0zwPZCPMLH+ICOLsb4zRh6v+sb3Urd0
 40WCv+AWS9+0F3blgKPGU7CRFtjKTISGw+hg9qVv0Rj94rxSrOO4sqZr+b/cHR01HBb/
 2/fQ==
X-Gm-Message-State: AOJu0Yz5sjggzkyKVahOnQPcoKIQ/dv0929Pf2Us8GJh8wQzOs4GDygd
 WjAooOiWXCLQZCMvSJsh6gyB0Eo0h/1NLpe7B3k84KKjVO55X/rBhR+Rmd7f0K16umxyR5yudy/
 kn1/Q8ZGH5IjAyhG9DQWut3p2N3MF9U5gtFmhVA==
X-Gm-Gg: ASbGncujSMXEnzlRjzpOboLpK9AVHgD2kmVZIYiMOOhkcavPsIJZM8AIearImFF3xfk
 r7OnBILDJLKkV3f8FZDyOQXM6RfQwtp29kFfWci3KuKsXbR03+6kfyh5KZav2AfF9/m+FXBybST
 kg/aCjEf0rrmjr5yDinbMSWkqna6CGwQU5sdwJ
X-Google-Smtp-Source: AGHT+IEBLVadZGmo/HK27xlgm3sLBQStiRXiec4NXtWxJd+lubB1fp2UzyXa7jYJERWUZroB+wqZ3xcPKzGlDgSSfdo=
X-Received: by 2002:a17:90b:2644:b0:2ff:52b8:2767 with SMTP id
 98e67ed59e1d1-30a33300e3bmr807897a91.19.1745962400770; Tue, 29 Apr 2025
 14:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250427112537.108725-1-mkashani@nvidia.com>
In-Reply-To: <20250427112537.108725-1-mkashani@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 29 Apr 2025 17:28:52 -0400
X-Gm-Features: ATxdqUGT3TG9AanHR7xfrEgOD2XMB_Zf8hTBmdiMzY5n-b85_kXoDvVaOQz58tg
Message-ID: <CAJvnSUDo=SrtpmmCV=O03Fmdep5hOVKm0YwL88cAgiLso=Uv5Q@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: add match on IPv6 fragment extension header
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b08b790633f18c23"
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

--000000000000b08b790633f18c23
Content-Type: text/plain; charset="UTF-8"

Hi, it looks like your patch was affected by an infrastructure issue at the
DPDK Community Lab and has a false failure test result on DPDK patchwork.
Issuing a retest to correct this:

Recheck-request: iol-intel-Functional

--000000000000b08b790633f18c23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, it looks=C2=A0like your patch was affected by an infra=
structure issue=C2=A0at the DPDK Community Lab and has a false failure test=
 result on DPDK patchwork. Issuing a retest to correct this:=C2=A0<br><br><=
div>Recheck-request:=C2=A0iol-intel-Functional</div></div>

--000000000000b08b790633f18c23--
