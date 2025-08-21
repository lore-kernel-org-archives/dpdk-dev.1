Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84161CA0EF8
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 15:20:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2B08402BD;
	Thu, 21 Aug 2025 17:20:20 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id CD280402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 17:20:18 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso5658405e9.3
 for <dev@dpdk.org>; Thu, 21 Aug 2025 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755789618;
 x=1756394418; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BjSKINq7/CnOwXfW6315VatX2bSuo8j808kyNRHR1c=;
 b=bBHmP8JeXCZ3jrACEAfDUk+9FCCn/Hsg1EBIgF+EjcXcjqmqdjiUhEUwyMXD3Xra0K
 NzLSDAHZ0USdsfQyKLB7MAFKU9GydclaFHgjMIj37FyMZDZY18sSQAI51yJTTRR//O2x
 PpfkvCGuIuvt12l+apR2kp1/TPzw6+GsSTzY+3aaJplEPDZPAIUgK5TPMSfDO8q3vAV1
 5Nn4Qo2xtmIVBkFHRt+gi6A35P1xNLzoX26znhgrC2Kr9bkrDaZXeGiS3DXWYk6DAL6F
 VCunafpxDrTV/thovKuNgQGACvna5fKa6nkSoYWOmy7gL/zBU1KZmYSUOatFqbr5p5+m
 OKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755789618; x=1756394418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BjSKINq7/CnOwXfW6315VatX2bSuo8j808kyNRHR1c=;
 b=CngDGuKT7sPQsqhT7JHJkDCNSqEMA1et8SNuMPeqVm1jt1HOYRJTulO1KvUCQ2TjRF
 BP6ScAfEzsapIfCkkJPrhVPS4OVp57aGV6oQJ17WGStdot16xJ5yjYHMpBu28RVXb6o9
 jWjdsR3/MJ/dfALHzGaLs/ucY+RC6NNRyf7uIPRBcIQM5qagBUn/35t/FOvo0paNfYhm
 c6pkgbh+r54gTDd0FENjo7/LU0hRVqjEBjCO3krV7Z6NSVffA9Nej7OIYenzCafzDSoI
 x1ffTlJbKMVfdA8TlvutUOEZSxdMvbiQl/mUHO8bL19sO3QXJvln1LX/QDSPFzBxPZYg
 iKmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFSSHCxTe+6EHQjxxJR/HaPwc+sICDRA//jPkyiwDGvupJjv0U7Mft8mxz0cUjC+xXbAg=@dpdk.org
X-Gm-Message-State: AOJu0YzqWoklCuaTRkxqQvqCaonG/6mAWDN6M1GOpegq2kVAApLNTlsk
 KWUsp2C4+95+JyLSrGd/lY7U5fhlOwC7Lt4EORGw3m7bm05BBhUZ7cpmbkpLB+PQnys=
X-Gm-Gg: ASbGncvCQGZCJicSkws+n07bWbwID/GgvpvkdaJgxAWpPSJO+BKweiAGa4g83skl2jv
 3KpV/JIYCYuQ3/fV/o7nCXlLFTKlU+Arc2i1IGOVkTe/StoP7VhV2O/kMMiIe1G4qD1zKSsBXIq
 0d2s+fGWI3oABexfLEtEC6Z1NZkWuIvhdJPnIy2p5/a5ICgFnNZHTP+ei7jy7qn1yU453eSthdg
 Qj5VJlUv8rNlwB/ufKU0tIusWHdUJYUUL9ipZ2Yr+bltrsuOuZghusMOy+ZQ6ZiVUOezdh63epI
 ZqgrYmTB+XK+3KSTOCF7WDkDAnJEu2otwYMiz0WiWC3oX1/bQEXPNEoJxbEx2zfiPTSYN7EgEUO
 1X5HCWzwSCggGGaJ2Dl4SOVP/yGLLANbgxPstYszKCQwkeSGVcWNU0QQYsVBHfoSf67LIEXjiRq
 8=
X-Google-Smtp-Source: AGHT+IH8tb0h+2TgAYCnVyyodLv+1gHlIbaVEwgAJd9k4LUu1XDRCt7CgRWoZC+Q0p50KroemY5ULA==
X-Received: by 2002:a05:600c:19cb:b0:456:db0:4f3d with SMTP id
 5b1f17b1804b1-45b4d8281bdmr25972755e9.24.1755789618157; 
 Thu, 21 Aug 2025 08:20:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e1d77e0sm17256915e9.0.2025.08.21.08.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:20:17 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:20:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sunil Kumar Kori <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v7 1/1] ethdev: add support to provide
 link type
Message-ID: <20250821082012.1264dbc1@hermes.local>
In-Reply-To: <SN7PR18MB386917862951DD1A6ABE715FB432A@SN7PR18MB3869.namprd18.prod.outlook.com>
References: <20250820111350.2992591-1-skori@marvell.com>
 <20250820175317.3063659-1-skori@marvell.com>
 <20250820115818.0a3628ee@hermes.local>
 <SN7PR18MB386917862951DD1A6ABE715FB432A@SN7PR18MB3869.namprd18.prod.outlook.com>
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

On Thu, 21 Aug 2025 04:51:47 +0000
Sunil Kumar Kori <skori@marvell.com> wrote:

> > 
> > IMHO adding a trace point to a helper function like this is just extra clutter,
> > remove it.
> >   
> Ack, I will share a separate patch to add trace in this API.

No, please no tracepoint. Tracing is meant for datapath and control path operations
not every helper library. For example, the string functions should not have tracing.
