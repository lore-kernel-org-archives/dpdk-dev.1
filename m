Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FECCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 18:15:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D59442D78;
	Fri, 17 Oct 2025 20:15:51 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 5C7B5400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 20:15:50 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b57bf560703so1566879a12.2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760724949;
 x=1761329749; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAGe4ZMuohzlG9F3gOuI3HvGcdctSOOlaFFqERCnp0k=;
 b=DwFqNo/Ztnh2VlgRoPCIQfBqtJABHZpikCWJ1ArgJnus83evbMj/zKVRq7/VaIGISs
 puLS03W1mKtTfvjLIAONM+Y/6vURbxicXxCnJoz7RKCBMd+2syjb+xholiDncqoluS7G
 97AztNo548KUJ5kQly1SLE/svX8g7AnzcimhB1HfQBh+0sL1ZFEYsQQOV689WUVYPP/F
 U69JFaPq3+cS2netHcZK/bKJmgRThoz/nMKv6HiOvU63IHHfExldDG3mOC0lje3YGyZ5
 xRPfOIGW0WyUXFoKWyxWc2S/RyWS1hIFf0LA2fB4QB0LA0Vq5UL9oE5OwEYKnhPpjnPQ
 iEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760724949; x=1761329749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAGe4ZMuohzlG9F3gOuI3HvGcdctSOOlaFFqERCnp0k=;
 b=PmUMHuyC9tRYz5oRbLvt1r7LHtkpQliNvNOz60Ya/2rxcdnB9S/fcrKevcnn9VoFLT
 krurPI1GRgU6bgXMiJ+ActRnMX9esOqRls9A3EDB2T17owLA9lvVZQnqmnWwTVpVdIup
 JyCO+ZGojnhJBKpH0DC86x/Ryb0iuqpCnV23mX4Ftsm1lgILOBMkBBuhj4+/N7fWH++t
 I3h3ucN3ZrJWkQ+ep/kn+puU0896E3HIo/Nl+HsmSoisPZ/mOY/KP9sWKW/ClgbtHHAq
 HJAMJAXt/V9J+K5rYK0bNiZJ6NfERjPegNQmAoUh4qSxBqZGh2DIG+5R3XgeotBr5Tv3
 FIUg==
X-Gm-Message-State: AOJu0YxYdRqjenrcKmkyeFQjqoRhZNR3mMiaCsouqc/JyLwqEslV0UlL
 k/h7wZwtDBHrukdBTF2uxrnvJi1kHNrqgN2mxffYlYryJK7aBv4cz1BcWZql6XvaBB0=
X-Gm-Gg: ASbGncuCoTzAfo3fy58yT91+th9LEsd6o6GY8GcyXDWwFY9+Oz6PzTb0NBattmS2dlK
 Dt35w4TrNQk3YqoZy6jEXDyGzCEqxfWRUFNRoXfeaRNIsipNNlSlYz/LD0+OMtFAGAJK5U5yhJV
 5KMj18+YapjFRv1+HAc5W5z99rSXZfv7Rb0yKfkzlEo9CIoUVUgDEOv+J2zvl0Nqdr/Xyj7a3s3
 jYqQ9de2UwgQAM/q7H16s41YcafepD+UFpioWguILWFelYI+S9whnuLQB6lq8mNChIhqu0ndtug
 OSiEPzX/hOYq7SzsA3j1XeurjKVi1AhyqczBUYTBZopSrCDl9Jbd4dHhU65IJPR6EFF/4bVZ3RJ
 83XDwBVgYZCl3t/ccL2vTbdMoeEKimWDE0bfkqRkl0MzdhKzqI+Dr7JVdygYuJsv6P0Y7E9z0er
 kaHsdOcG55BNInSLss/dBZNExUA7sBWA1aWlK/8loFV2vKBZUE1sWA3apsiGMf
X-Google-Smtp-Source: AGHT+IFA26tqim7ldCI89l2QmSZyAc/FrqK72a2A/EGt258PrAevFZn9f+b07zaS5qdBfqWNDwr91A==
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id
 d9443c01a7336-290cba4edaemr51095325ad.31.1760724949309; 
 Fri, 17 Oct 2025 11:15:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebcdefsm1825405ad.16.2025.10.17.11.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 11:15:49 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:51:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Geoff Thorpe <geoff.thorpe@nxp.com>, Shreyansh
 Jain <shreyansh.jain@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: Re: [PATCH v5 1/6] bus/dpaa: fix and add FQ shutdown
Message-ID: <20251017185113.1ea5fca2@phoenix.lan>
In-Reply-To: <20251017044848.3269627-2-g.singh@nxp.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
 <20251017044848.3269627-2-g.singh@nxp.com>
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

On Fri, 17 Oct 2025 10:18:43 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> fixing and adding a FQ shutdown functionality to ensure
> proper cleanup of frame queues during queue setup. This helps
> reset the queues reliably and prevents potential resource leaks or
> stale state issues.
> 
> Fixes: c47ff048b99a ("bus/dpaa: add QMAN driver core routines")

Commit message should be full sentence in imperative voice.
Like:

Fix FQ shutdown to do proper cleanup of frame queues.
This helps reset the queues and prevents potential resoure leaks
or stale state issues.

