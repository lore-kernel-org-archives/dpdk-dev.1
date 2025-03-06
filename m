Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B1C19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 03:03:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14B7C40612;
	Thu,  6 Mar 2025 04:03:05 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 81B1840612
 for <dev@dpdk.org>; Thu,  6 Mar 2025 04:03:04 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso454721a91.3
 for <dev@dpdk.org>; Wed, 05 Mar 2025 19:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741230183; x=1741834983; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eN3eO3c5e2fe2hgSurJTJuEM2Jb7WBO3qN2L/3aVUsk=;
 b=NTofMSRUTiHFjkWsDat3hCFh9KKkOjmjrYQ66yErWQui+V+yrbvHWH0Hltimq7ncgn
 pvI0m2lFBWrIDxDYo+v3O0Q2fHsKzH9+MDMIkc11IGqIGOtjLvzU8wzzRHfYutW72JB4
 2i5GTHwQEiloCU7Q3sc0zot0nPAX9kc+4BoI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230183; x=1741834983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eN3eO3c5e2fe2hgSurJTJuEM2Jb7WBO3qN2L/3aVUsk=;
 b=ikP3bag03iUG6G0vtjeWRwcB3QLYaoyCUbxEC6LBqMeOeE/xUyMKgGDkppfMWJldGF
 vqJkll5p7rsLYFe+O1bgH/q36pUKO33ya2THdke2aslBAvI1u3aq/cM2MQPoThJHAm4a
 RDMK781LATgRpO3aRxAKMhl/t85dd2UrWXYSpFKeMEXExUmfLpk6sDHXawADTXFgNOMl
 ngK9M8YjDVq+XO0EIL92mBTm2NiLyCNRc2V2BN3VxVo0VTfc5LWQ2y2+AJcZmcHftCLB
 0NEuHPpH8WP/Y4WzPw9oe1NP4sFEMArIbdORLjuUdUYDkz+ZeSd3utB7EvwpyC2n+qWo
 1AYA==
X-Gm-Message-State: AOJu0YyHfR6YyUOcAdmlSRQkfiP5bvfpNqfZ7AWbPWNQjXgebHZvwrd2
 skZF6KvHqABtg4IwpXj2zmeqDSHSX2LAtK7Y0ryyhjWa/MwpTLtkS/0PCKM7jJ72LGQcAHfG3dP
 ILFjFw+5oe4+RBCvNmkasPuOtOEA3vCmZ9DqrVPgYSTfx7omWMDRD1w==
X-Gm-Gg: ASbGnctxYqKetfGd570kFkeQSNELs2WU5zg75q6ntFPe8kGGlYKfd4laIPmr6ZzMESV
 ElAtsC5F1BsLq9avlEONNeDr9Tdzx71Am1VqqUPapTzKLkISv0/XOEAduZhjM+415Uc274JacnF
 oWHERaOpGSG7xIWZcIDU3BQQDeZlinvy1RcbrcPIxfpw==
X-Google-Smtp-Source: AGHT+IFaHQyg5647bOcpc3CXZQ+3cvlF68mfELldG6DB8DQGQEDkBjM/U8zwwQY517lGk+15A8RanKoxhgKwuP9jbUM=
X-Received: by 2002:a17:90b:43:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-2ff64c33df2mr1545767a91.31.1741230183673; Wed, 05 Mar 2025
 19:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20250305182716.773937-1-nicolas.chautru@intel.com>
 <20250305182716.773937-2-nicolas.chautru@intel.com>
In-Reply-To: <20250305182716.773937-2-nicolas.chautru@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 5 Mar 2025 21:59:29 -0500
X-Gm-Features: AQ5f1JrgZ92WaZmZR_oF4dpebp9n2KwPYY2B_d73Kp3EmzeeLqdnQ3_ZdVrH8MM
Message-ID: <CAJvnSUCm5wj3ZRfCGGNqqaVYctXT3SdeKWrJ3ePJi3H=dNTK2g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] baseband/acc: fix queue setup failure clean up
To: Nicolas Chautru <nicolas.chautru@intel.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, hernan.vargas@intel.com, 
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000920ce5062fa3be0a"
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

--000000000000920ce5062fa3be0a
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

There was an infra failure with the Arm Grace server about 12 hours ago
which caused this failure - sending a retest request.

--000000000000920ce5062fa3be0a
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Recheck-request: iol-intel-Performance<br><br></div>There was an infra failure with the Arm Grace server about 12 hours ago which caused this failure - sending a retest request.</div>

--000000000000920ce5062fa3be0a--
