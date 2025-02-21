Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A22C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 23:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B2F402A9;
	Sat, 22 Feb 2025 00:05:52 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 956A140267
 for <dev@dpdk.org>; Sat, 22 Feb 2025 00:05:51 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-220f4dd756eso54730795ad.3
 for <dev@dpdk.org>; Fri, 21 Feb 2025 15:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740179150;
 x=1740783950; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/yGb90w9v4/0xiN50Xtk8o+p76HIoPYmQaRsREAlClI=;
 b=y5eXEp4d9ZtTNX2anAHMuc/bxiknvK770/XrrT2+KTT3Sk6qgXnzz1+20vnV/eAHWj
 ujDKlcCixlsrm1W6llJ/3+2DQh0D793079dAxzg/9Zj15bZCZIGlbuB0n5FSqTJII/qK
 kQkWMJiTXoM+diPDcCaZBVdbzkj5qBHpjxVelFFGGVjNkv1a3c8AEsW9UzQ3X2g8n86A
 yb1ctSyIDa1SUBk+F+REAAeWDZ/YuCKloC5pjrARx9g/wOdbnXXW515Fa40sB/b9mqo7
 uywmIPkB16VQmlfw88Cukyh+FznlJUNC59/MrXi5HCXqnJM60XUiX4a5WonNO/yrNsi1
 LY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740179150; x=1740783950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yGb90w9v4/0xiN50Xtk8o+p76HIoPYmQaRsREAlClI=;
 b=D1VXeLjLegWcwy4zvGlnIr3RSwWjZ0/dqd213Z9zxJsoe8mzJGujiWzG9WBiIfL1tj
 QNq/8cjfj93SQAG/DOzK02sz4Zfm4GH2qu3Oi0vJDMl608HXHAh+XaTUVda3wUUCnh0M
 YLnvmENB03aovhvFHRvJNks2ZCTSOW6wzASOhV9WOMo8FVYQSREWJnVqRnvDtsPJLuT0
 GwaIKmSGLxgi+1+5JTgwfeTCAodIih7mXcFHU0rvs81/38SG/551MKrh8d1GL4DB5l4C
 ITiF+8tPDpp5xB9AaoL/xuf0mOENd5O8KCBF1t2512w3ps3CX+jGaTdjSchxMg0V6AnF
 Lr+w==
X-Gm-Message-State: AOJu0Yyo/sVKEU465cFK8U9t4MONQ2wedhDx46fM1OUyLg8kw8rjg13V
 jer8kUfUIp1Lco/gVlzt75wmWgHGAUWhmA+WkpTZVyncqotIFssv1my9Xdt7Pwo=
X-Gm-Gg: ASbGncueigatOT9EhdXgMH58IDinjfzQXwVsS3hsob/NoJLlttTiPMJeXixZhYTw3Cb
 qawxu2VIAx4R9pU8L02SEKKJX15sQRFryoL7HU30tBPcgwPxHt/N+SDW7JEC2ZraBu7uMYvlL9i
 4oGGUn0/iWnuaS4ZSF4yX/gEOLAfVFbUIJ9YNl/l//9+riPiJj9uP5Is3M+cv8nwbNfS/cl/TZG
 pa0XnPDRXP2LbCOD6OBZVJVG6CBRJz8Yb9Bmp7stFClL/Isc+kxyTWoEqa47EVqzODwoG93fS0Y
 6SWfNEswXS/xDJsME0A1vPOWN9+zCsal+bEKQrZjZcoPUyjIUTUmJswYCeM/pV0lJ+58rNrCmGf
 eNb0=
X-Google-Smtp-Source: AGHT+IFuu/tYelWWafUY0wete/HeHfROms+sAP2WFx8yZzIE4KaDJo80YX4RPdNm6IlalG3mtAzkBw==
X-Received: by 2002:a05:6a20:72a3:b0:1ee:d6a7:e341 with SMTP id
 adf61e73a8af0-1eef3d6cdc7mr10288396637.30.1740179149311; 
 Fri, 21 Feb 2025 15:05:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ae5eddbcbe1sm5057242a12.50.2025.02.21.15.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 15:05:49 -0800 (PST)
Date: Fri, 21 Feb 2025 15:05:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Message-ID: <20250221150545.2ae330ba@hermes.local>
In-Reply-To: <12279496.nUPlyArG6x@thomas>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
 <20250214172134.73908-2-stephen@networkplumber.org>
 <12279496.nUPlyArG6x@thomas>
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

On Wed, 19 Feb 2025 15:55:17 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 14/02/2025 18:20, Stephen Hemminger:
> > The Linux version of sys/queue.h is frozen at an older version
> > and is missing the _SAFE macro variants. Several drivers started
> > introducing the own workarounds for this. Should be handled in EAL.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> We may want to unify with lib/eal/windows/include/sys/queue.h

Do we want to just not use the local Linux version of queue.h entirely?
Maybe just put in current FreeBSD one? It has lots more useful variations.

The point is to avoid broken versions (like one Intel driver) or
having same macro in multiple places.
